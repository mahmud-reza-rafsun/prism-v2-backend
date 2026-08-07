import status from "http-status";
import { prisma } from "../../database/prisma";
import { ICreateDistributionPointPayload } from "../../interface/distributionPoint.interface";
import { AppError } from "../../shared/errors/app-error";

const createDistributionPoint = async (
    payload: ICreateDistributionPointPayload,
    userId: string
) => {
    // Check logged-in user
    const user = await prisma.user.findUnique({
        where: {
            id: userId,
        },
    });

    if (!user) {
        throw new AppError(status.UNAUTHORIZED, "User not found");
    }

    // Check Distribution House
    const distributionHouse = await prisma.distributionHouse.findUnique({
        where: {
            id: payload.distributionHouseId,
        },
    });

    if (!distributionHouse) {
        throw new AppError(
            status.NOT_FOUND,
            "Distribution House not found"
        );
    }

    // Create Distribution Points
    await prisma.distributionPoints.createMany({
        data: payload.points.map((point) => ({
            name: point.name,
            code: point.code,
            address: point.address,
            contact: point.contact,
            distributionHouseId: payload.distributionHouseId,
            territoryId: point.territoryId,
        })),
        skipDuplicates: true,
    });

    // Return created points
    const distributionPoints = await prisma.distributionPoints.findMany({
        where: {
            distributionHouseId: payload.distributionHouseId,
        },
        orderBy: {
            createdAt: "asc",
        },
    });

    return distributionPoints;
};

const getAllDistributionPoint = async () => {
    const [totalCount, distributionPoints] = await prisma.$transaction([
        prisma.distributionPoints.count(),
        prisma.distributionPoints.findMany(),
    ]);

    return {
        distributionPoints,
        totalCount,
    };
};

export const distributionPointService = {
    createDistributionPoint,
    getAllDistributionPoint,
};
