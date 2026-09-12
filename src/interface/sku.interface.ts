export interface SegmentData {
    id: string;
    name: string;
}

export interface FamilyData {
    id: string;
    name: string;
    segmentId: string;
}

export interface BrandData {
    id: string;
    name: string;
    familyId: string;
}

export interface SttSkuData {
    name: string;
    brandId: string;
    familyId: string;
    segmentId: string;
    code: string;
    packSize: string;
}
