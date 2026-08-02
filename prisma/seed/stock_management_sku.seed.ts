import { prisma } from '../../src/database/prisma';
import fs from 'fs';
import path from 'path';
import { StockManagementSkuData } from '../../src/interface/stock.management.sku.interface';

async function main() {
    const filePath = path.join(process.cwd(), 'raw_data', 'stock-management-sku.json');
    const rawData = fs.readFileSync(filePath, 'utf-8');
    const skus: StockManagementSkuData[] = JSON.parse(rawData);

    console.log('Seeding Stock Management SKUs...');

    for (const sku of skus) {
        await prisma.stockManagementSku.upsert({
            where: { name: sku.name },
            update: {
                code: sku.code,
                packSize: sku.packSize,
                brandId: sku.brandId,
            },
            create: {
                name: sku.name,
                code: sku.code,
                packSize: sku.packSize,
                brandId: sku.brandId,
            },
        });
    }

    console.log('Stock Management SKU seeding completed successfully!');
}

main()
    .catch((e) => {
        console.error('Error seeding Stock Management SKUs:', e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
