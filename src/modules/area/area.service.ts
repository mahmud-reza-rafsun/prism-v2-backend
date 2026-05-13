// modules/area/area.service.ts
import { status } from "http-status";
import { ICreateAreaPayload } from "../../interface/area.interface";
import { prisma } from "../../database/prisma";
import { AppError } from "../../shared/errors/app-error";

const createArea = async (
    payload: ICreateAreaPayload,
    userId: string,
    regionId: string
) => {
    // Verify user existence
    const user = await prisma.user.findUnique({
        where: { id: userId },
    });

    if (!user) {
        throw new AppError(status.UNAUTHORIZED, "User not found");
    }

    // Verify region existence
    const region = await prisma.region.findUnique({
        where: { id: regionId },
    });

    if (!region) {
        throw new AppError(status.NOT_FOUND, "Region not found");
    }

    // Validate payload
    if (
        !payload ||
        !payload.areas ||
        !Array.isArray(payload.areas) ||
        payload.areas.length === 0
    ) {
        throw new AppError(status.BAD_REQUEST, "Invalid or empty area data provided");
    }

    const result = await prisma.area.createMany({
        data: payload.areas.map((area) => ({
            name: area.name,
            code: area.code,
            regionId: region.id,
        })),
        skipDuplicates: true,
    });

    return result;
};

export const areaService = {
    createArea,
};