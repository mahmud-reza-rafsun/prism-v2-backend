import { Role } from "@prisma/client";

export interface UserData {
    name: string;
    email: string;
    image?: string;
    password: string;
    role: Role;
    distributionHouseId: string;
    regionId: string;
    areaId: string;
    distributionPointId: string;
};
