import { prisma } from '../../src/database/prisma';
import fs from 'fs';
import path from 'path';

async function main() {
    const filePath = path.join(process.cwd(), 'raw_data', 'brand.json');
    const rawData = fs.readFileSync(filePath, 'utf-8');
    const brands: { name: string; familyId: string }[] = JSON.parse(rawData);

    console.log('Seeding brands...');

    for (const brand of brands) {
        await prisma.brand.upsert({
            where: { name: brand.name },
            update: {
                familyId: brand.familyId,
            },
            create: {
                name: brand.name,
                familyId: brand.familyId,
            },
        });
    }

    console.log('Seeding completed successfully!');
}

main()
    .catch((e) => {
        console.error(e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
