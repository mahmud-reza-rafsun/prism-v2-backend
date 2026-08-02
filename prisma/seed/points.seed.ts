import fs from "fs";
import path from "path";
import { prisma } from "../../src/database/prisma";
import { Role } from "@prisma/client";
import { auth } from "../../src/lib/auth";


type PointData = {
    distributionHouseId: string;
    points: {
        name: string;
        code: string;
        address: string;
        contact: string;
        territoryId?: string;
        user: {
            name: string;
            email: string;
            password: string;
            role: Role;
        };
    }[];
};

async function seedPoints() {
    const filePath = path.join(process.cwd(), "raw_data", "points2.json");

    const data: PointData[] = JSON.parse(
        fs.readFileSync(filePath, "utf-8")
    );

    for (const dh of data) {
        const distributionHouse = await prisma.distributionHouse.findUnique({
            where: {
                id: dh.distributionHouseId,
            },
        });

        if (!distributionHouse) {
            console.log(
                `❌ Distribution House not found: ${dh.distributionHouseId}`
            );
            continue;
        }

        for (const point of dh.points) {
            try {
                // Check duplicate point
                const existingPoint =
                    await prisma.distributionPoints.findUnique({
                        where: {
                            code: point.code,
                        },
                    });

                if (existingPoint) {
                    console.log(`⚠️ Point already exists: ${point.code}`);
                    continue;
                }

                // Check duplicate user
                const existingUser = await prisma.user.findUnique({
                    where: {
                        email: point.user.email,
                    },
                });

                let userId: string;

                if (existingUser) {
                    userId = existingUser.id;
                } else {
                    // Better Auth Registration
                    const result = await auth.api.signUpEmail({
                        body: {
                            name: point.user.name,
                            email: point.user.email,
                            password: point.user.password,
                            role: point.user.role,
                            distributionHouseId: dh.distributionHouseId,
                            territoryId: point.territoryId,
                            image: "",
                        },
                    });

                    userId = result.user.id;

                    // Update Role
                    await prisma.user.update({
                        where: {
                            id: userId,
                        },
                        data: {
                            role: point.user.role,
                        },
                    });
                }

                // Create Distribution Point
                const createdPoint = await prisma.distributionPoints.create({
                    data: {
                        name: point.name,
                        code: point.code,
                        address: point.address,
                        distributionHouseId: dh.distributionHouseId,
                        contact: point.contact,
                        territoryId: point.territoryId,
                    },
                });

                // Assign User to Point
                await prisma.user.update({
                    where: {
                        id: userId,
                    },
                    data: {
                        role: point.user.role,
                        emailVerified: true,
                        distributionPointId: createdPoint.id,
                        distributionHouseId: dh.distributionHouseId,
                        territoryId: point.territoryId,
                    },
                });

                console.log(
                    `✅ ${point.name} created | ${point.user.email}`
                );
            } catch (error) {
                console.error(
                    `❌ Failed to create ${point.name}`,
                    error
                );
            }
        }
    }

    console.log("🎉 Point seeding completed");
}

seedPoints()
    .catch((err) => {
        console.error(err);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
