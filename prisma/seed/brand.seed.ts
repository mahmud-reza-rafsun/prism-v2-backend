import { prisma } from '../../src/database/prisma';
import fs from 'fs';
import path from 'path';
import { BrandData } from '../../src/interface/sku.interface';

async function main() {
    const filePath = path.join(process.cwd(), 'raw_data', 'brand.json');
    const rawData = fs.readFileSync(filePath, 'utf-8');
    const brands: BrandData[] = JSON.parse(rawData);

    console.log('Seeding brands...');

    for (const brand of brands) {
        await prisma.brand.upsert({
            where: { name: brand.name },
            update: {
                id: brand.id,
                familyId: brand.familyId,
            },
            create: {
                id: brand.id,
                name: brand.name,
                familyId: brand.familyId,
            },
        });
    }

    console.log('Brand Seeding completed successfully!');
}

main()
    .catch((e) => {
        console.error(e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
