export type TDistributorPriceItem = {
    code: string;
    price: number;
};

export type TDistributorPricePayload = {
    items: TDistributorPriceItem[];
};

export type TDistributorPriceResponse = {
    code: string;
    price: number;
};
