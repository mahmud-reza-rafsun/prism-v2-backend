export interface IRegionData {
    name: string;
    code?: string;
}

export interface ICreateRegionPayload {
    regions: IRegionData[];
}