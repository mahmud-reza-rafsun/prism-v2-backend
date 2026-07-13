import status from "http-status";
import { prisma } from "../../database/prisma";
import { ICreateDistributionPointPayload } from "../../interface/distributionPoint.interface";
import { AppError } from "../../shared/errors/app-error";

const createDistributionPoint = async (
    payload: ICreateDistributionPointPayload,
    userId: string,
    distributionId: string
) => {
    const user = await prisma.user.findUnique({
        where: { id: userId },
    });

    if (!user) {
        throw new AppError(status.UNAUTHORIZED, "User not found");
    }

    const distribution = await prisma.distributionHouse.findUnique({
        where: { id: distributionId },
    });

    if (!distribution) {
        throw new AppError(status.NOT_FOUND, "Target Distribution not found");
    }

    // Step 1: create
    await prisma.distributionPoints.createMany({
        data: payload.points.map((point) => ({
            name: point.name,
            code: point.code,
            address: point.address,
            contact: point.contact,
            distributionId: distributionId,
            territoryId: point.territoryId
        })),
        skipDuplicates: true,
    });

    // Step 2: fetch created points
    const distributionPoints = await prisma.distributionHouse.findMany({
        where: { id: distributionId },
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