export interface TSkuPriceItem {
    skuCode: string;
    price: number;
}

export interface TCreateDistributorPricePayload {
    effectiveDate?: string | Date;
    items: TSkuPriceItem[];
}
