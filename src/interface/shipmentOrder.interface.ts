export interface TSkuOrderItem {
    shipmentSkuId: string; // Payload অনুযায়ী code/skuId আসছে
    quantity: number;
}

export interface TDateOrderGroup {
    targetDate: string | Date;
    items: TSkuOrderItem[];
}

export interface DhCreateShipmentOrder {
    orders: TDateOrderGroup[];
}
