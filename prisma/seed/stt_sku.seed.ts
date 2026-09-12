import { prisma } from '../../src/database/prisma';
import fs from 'fs';
import path from 'path';
import { SttSkuData } from '../../src/interface/sku.interface';

async function main() {
    const filePath = path.join(process.cwd(), 'raw_data', 'stt-sku.json');
    const rawData = fs.readFileSync(filePath, 'utf-8');
    const skus: SttSkuData[] = JSON.parse(rawData);

    console.log('Seeding STT SKUs...');

    for (const sku of skus) {
        await prisma.sttSku.upsert({
            where: { name: sku.name },
            update: {
                brandId: sku.brandId,
            },
            create: {
                name: sku.name,
                code: sku.code,
                packSize: sku.packSize,
                brandId: sku.brandId,
                familyId: sku.familyId,
                segmentId: sku.segmentId
            },
        });
    }

    console.log('STT SKU seeding completed successfully!');
}

main()
    .catch((e) => {
        console.error('Error seeding STT SKUs:', e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
