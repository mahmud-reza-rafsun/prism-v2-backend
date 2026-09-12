import { prisma } from '../../src/database/prisma';
import fs from 'fs';
import path from 'path';

interface ShipmentSkuData {
    name: string;
    code?: string;
    packSize?: string;
}

async function main() {
    const filePath = path.join(process.cwd(), 'raw_data', 'shipment-sku.json');
    const rawData = fs.readFileSync(filePath, 'utf-8');
    const items: ShipmentSkuData[] = JSON.parse(rawData);

    console.log('Seeding Shipment SKUs...');

    for (const item of items) {
        await prisma.shipmentSku.upsert({
            where: { name: item.name },
            update: {
                code: item.code,
                packSize: item.packSize,
            },
            create: {
                name: item.name,
                code: item.code,
                packSize: item.packSize,
            },
        });
    }

    console.log('Shipment SKU seeding completed successfully!');
}

main()
    .catch((e) => {
        console.error('Error seeding Shipment SKUs:', e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
