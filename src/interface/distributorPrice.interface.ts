// ১. সিঙ্গেল আইটেমের জন্য টাইপ definition
export type TDistributorPriceItem = {
    code: string;
    price: number;
};

// ২. রিকোয়েস্ট পে-লোডের (Request Body) জন্য টাইপ definition
export type TDistributorPricePayload = {
    items: TDistributorPriceItem[];
};

// ৩. সার্ভিস রেসপন্সের জন্য টাইপ definition
export type TDistributorPriceResponse = {
    code: string;
    price: number;
};
