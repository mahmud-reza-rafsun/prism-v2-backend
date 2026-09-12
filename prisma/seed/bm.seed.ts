import fs from "fs";
import path from "path";
import { prisma } from "../../src/database/prisma";
import { auth } from "../../src/lib/auth";
import { UserData } from "../../src/interface/user.interface";



async function seedUsers() {
    const filePath = path.join(process.cwd(), "raw_data", "bm.json");

    const users: UserData[] = JSON.parse(
        fs.readFileSync(filePath, "utf-8")
    );

    for (const user of users) {
        try {
            // Check if distribution house exists
            const distributionHouse = await prisma.distributionHouse.findUnique({
                where: {
                    id: user.distributionHouseId,
                },
            });

            if (!distributionHouse) {
                console.log(
                    `❌ Distribution House not found: ${user.distributionHouseId}`
                );
                continue;
            }

            // Check duplicate user
            const existingUser = await prisma.user.findUnique({
                where: {
                    email: user.email,
                },
            });

            if (existingUser) {
                console.log(`⚠️ User already exists: ${user.email} | Skipping creation.`);
                continue;
            }

            // Better Auth Registration
            const result = await auth.api.signUpEmail({
                body: {
                    name: user.name,
                    email: user.email,
                    password: user.password,
                    role: user.role,
                    distributionHouseId: user.distributionHouseId,
                    image: user.image || "",
                },
            });

            const userId = result.user.id;

            // Update user with additional DB fields
            await prisma.user.update({
                where: {
                    id: userId,
                },
                data: {
                    role: user.role,
                    emailVerified: true,
                    distributionHouseId: user.distributionHouseId,
                    image: user.image || null,
                },
            });

            console.log(`✅ User created: ${user.name} | ${user.email}`);
        } catch (error) {
            console.error(`❌ Failed to create user: ${user.email}`, error);
        }
    }

    console.log("🎉 User seeding completed");
}

seedUsers()
    .catch((err) => {
        console.error(err);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
