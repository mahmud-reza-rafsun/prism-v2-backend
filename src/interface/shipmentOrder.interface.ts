export interface TSkuOrderItem {
    shipmentSkuId: string;
    quantity: number | string;
    isFinalized: boolean;
    unlockRequested: boolean;
}

export interface TDateOrderGroup {
    targetDate: string | Date;
    items: TSkuOrderItem[];
}

export interface DhCreateShipmentOrder {
    orders: TDateOrderGroup[];
}
