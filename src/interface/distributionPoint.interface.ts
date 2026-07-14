export interface IDistributionPointItem {
    name: string;
    code?: string;
    address?: string;
    contact?: string;
    territoryId?: string;
}

export interface ICreateDistributionPointPayload {
    distributionHouseId: string;
    points: IDistributionPointItem[];
}
