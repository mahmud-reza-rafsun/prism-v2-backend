export interface ICreateTerritoryItem {
    name: string;
    code?: string;
    distributionHouseId: string;
    areaId: string;
}

export interface ICreateTerritoryPayload {
    territories: ICreateTerritoryItem[];
}
