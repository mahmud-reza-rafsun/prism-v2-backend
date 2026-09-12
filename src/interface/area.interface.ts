export interface ICreateAreaItem {
    name: string;
    code?: string;
}

export interface ICreateAreaPayload {
    areas: ICreateAreaItem[];
}