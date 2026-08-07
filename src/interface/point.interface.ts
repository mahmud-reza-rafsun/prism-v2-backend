import { Role } from "@prisma/client";

export interface PointData {
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
