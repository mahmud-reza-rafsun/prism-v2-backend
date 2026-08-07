import { status } from "http-status";
import { prisma } from "../../database/prisma";
import { AppError } from "../../shared/errors/app-error";
import { ICreateTerritoryPayload } from "../../interface/territory.interface";

const createTerritory = async (
    payload: ICreateTerritoryPayload,
    userId: string,
    distributionId: string // Received from params
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

    if (!payload?.territories?.length) {
        throw new AppError(status.BAD_REQUEST, "No Territory data provided");
    }

    const result = await prisma.territory.createMany({
        data: payload.territories.map((territory) => ({
            name: territory.name,
            code: territory.code,
            distributionHouseId: distributionId,
            areaId: territory.areaId,
        })),
        skipDuplicates: true,
    });

    return result;
};

const getAllTerritory = async () => {
    const [totalCount, territories] = await prisma.$transaction([
        prisma.territory.count(),
        prisma.territory.findMany()
    ]);

    return {
        territories,
        totalCount
    };
};

export const territoryService = {
    createTerritory,
    getAllTerritory
};
