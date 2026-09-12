export interface ICreateDistributionItem {
    name: string;
    code?: string;
    areaId: string;
    address?: string;
    contact?: string;
}

export interface ICreateDistributionPayload {
    distributions: ICreateDistributionItem[];
}