export interface TSkuOrderItem {
    shipmentSkuId: string;
    quantity: number;
}

export interface TDateOrderGroup {
    targetDate: string | Date;
    items: TSkuOrderItem[];
}

export interface DhCreateShipmentOrder {
    orders: TDateOrderGroup[];
}