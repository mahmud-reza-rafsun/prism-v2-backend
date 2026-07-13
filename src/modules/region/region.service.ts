/* eslint-disable @typescript-eslint/no-explicit-any */
import { status } from "http-status";
import { ICreateRegionPayload } from "../../interface/region.interface";
import { prisma } from "../../database/prisma";
import { AppError } from "../../shared/errors/app-error";
import { IRequestUser } from "../../interface/auth.type";

const createRegions = async (payload: ICreateRegionPayload, userId: string) => {
    // Verify user existence
    const user = await prisma.user.findUnique({
        where: { id: userId },
    });

    if (!user) {
        throw new AppError(status.UNAUTHORIZED, "User not found");
    }

    if (!payload || !payload.regions || !Array.isArray(payload.regions) || payload.regions.length === 0) {
        throw new AppError(status.BAD_REQUEST, "Invalid or empty region data provided");
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

const getMyRegionData = async (user: IRequestUser) => {
    const { role, regionId } = user; // টোকেন থেকে পেলেন

    // ডিফল্ট ফিল্টার (সুপার এডমিন হলে সব পাবে)
    let queryFilter: any = {};

    // যদি ইউজার রিজিওনাল ম্যানেজার হয়
    if (role === 'REGIONAL_MANAGER') {
        queryFilter = {
            id: regionId // সে শুধু তার নিজের রিজিয়ন ডাটা দেখবে
        };
    }

    // ডাটাবেস কোয়েরি
    return await prisma.region.findMany({
        where: queryFilter,
        include: {
            areas: true, // রাজশাহীর আন্ডারের সব এরিয়া চলে আসবে
            distributionHouses: true // রাজশাহীর আন্ডারের সব হাউস চলে আসবে
        }
    });
};

export const regionService = {
    createRegions,
    getMyRegionData
};