export interface ICreateTerritoryItem {
    name: string;
    code?: string;
    distributionHouseId: string;
}

export interface ICreateTerritoryPayload {
    territories: ICreateTerritoryItem[];
}