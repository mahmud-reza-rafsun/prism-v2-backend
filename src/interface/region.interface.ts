export interface ICreateRegionPayload {
    regions: {
        name: string;
        code: string;
    }[];
}