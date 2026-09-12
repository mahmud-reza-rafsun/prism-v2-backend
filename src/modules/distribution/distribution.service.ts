import { status } from "http-status";
import { prisma } from "../../database/prisma";
import { AppError } from "../../shared/errors/app-error";
import { ICreateDistributionPayload } from "../../interface/distribution.interface";

const createDistribution = async (
    payload: ICreateDistributionPayload,
    userId: string,
    areaId: string // Received from params
) => {
    const user = await prisma.user.findUnique({
        where: { id: userId },
    });

    if (!user) {
        throw new AppError(status.UNAUTHORIZED, "User not found");
    }

    const area = await prisma.area.findUnique({
        where: { id: areaId },
    });

    if (!area) {
        throw new AppError(status.NOT_FOUND, "Target area not found");
    }

    if (!payload?.distributions?.length) {
        throw new AppError(status.BAD_REQUEST, "No distribution data provided");
    }

    const result = await prisma.distributionHouse.createMany({
        data: payload.distributions.map((item) => ({
            name: item.name,
            code: item.code,
            areaId: areaId, // Applied to all items
            address: item.address,
            contact: item.contact,
        })),
        skipDuplicates: true,
    });

    return result;
};

const getAllDistribution = async () => {
    const [distributions, totalCount] = await prisma.$transaction([
        prisma.distributionHouse.count(),
        prisma.distributionHouse.findMany()
    ]);

    return {
        distributions,
        totalCount
    }
}

export const distributionService = {
    createDistribution,
    getAllDistribution
};