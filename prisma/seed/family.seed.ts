import { prisma } from '../../src/database/prisma';
import fs from 'fs';
import path from 'path';


async function main() {
    const filePath = path.join(process.cwd(), 'raw_data', 'family.json');
    const rawData = fs.readFileSync(filePath, 'utf-8');
    const families: { name: string; segmentId: string }[] = JSON.parse(rawData);

    console.log('Seeding families...');

    for (const family of families) {
        await prisma.family.upsert({
            where: { name: family.name },
            update: {
                segmentId: family.segmentId,
            },
            create: {
                name: family.name,
                segmentId: family.segmentId,
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
