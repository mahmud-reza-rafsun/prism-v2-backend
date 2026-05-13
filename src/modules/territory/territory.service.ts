import { status } from "http-status";
import { ICreateRegionPayload } from "../../interface/region.interface";
import { prisma } from "../../database/prisma";
import { AppError } from "../../shared/errors/app-error";

const createTerritory = async (payload: ICreateRegionPayload, userId: string) => {
    // Verify user existence
    const user = await prisma.user.findUnique({
        where: { id: userId },
    });

    if (!user) {
        throw new AppError(status.UNAUTHORIZED, "Admin not found");
    }

    // Robust validation to catch the "Invalid or empty" error
    if (!payload || !payload.regions || !Array.isArray(payload.regions) || payload.regions.length === 0) {
        throw new AppError(status.BAD_REQUEST, "Invalid or empty territory data provided");
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

export const territoryService = {
    createTerritory
};