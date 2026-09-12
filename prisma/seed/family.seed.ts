import { prisma } from '../../src/database/prisma';
import fs from 'fs';
import path from 'path';
import { FamilyData } from '../../src/interface/sku.interface';

async function main() {
    const filePath = path.join(process.cwd(), 'raw_data', 'family.json');
    const rawData = fs.readFileSync(filePath, 'utf-8');
    const families: FamilyData[] = JSON.parse(rawData);

    console.log('Seeding families...');

    for (const family of families) {
        await prisma.family.upsert({
            where: { name: family.name },
            update: {
                id: family.id,
                segmentId: family.segmentId,
            },
            create: {
                id: family.id,
                name: family.name,
                segmentId: family.segmentId,
            },
        });
    }

    console.log('Family Seeding completed successfully!');
}

main()
    .catch((e) => {
        console.error(e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
