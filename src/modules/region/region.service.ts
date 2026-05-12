import status from "http-status";
import { prisma } from "../../database/prisma";
import { AppError } from "../../shared/errors/app-error";
import { ICreateRegionPayload } from "../../interface/region.interface";

const createRegions = async (payload: ICreateRegionPayload, userId: string) => {
    const user = await prisma.user.findUnique({
        where: { id: userId },
    });

    if (!user) {
        throw new AppError(status.UNAUTHORIZED, "User not found");
    }

    if (!payload.regions || payload.regions.length === 0) {
        throw new AppError(status.BAD_REQUEST, "No region data provided");
    }

    const result = await prisma.region.createMany({
        data: payload.regions.map((region) => ({
            name: region.name,
            code: region.code,
        })),
        skipDuplicates: true,
    });

    return result;
};

export const regionService = {
    createRegions
}