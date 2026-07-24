import * as fs from 'fs';
import * as path from 'path';
import { prisma } from '../../src/database/prisma';

async function main() {
    const filePath = path.join(process.cwd(), 'raw_data', 'segment.json');
    const rawData = fs.readFileSync(filePath, 'utf-8');
    const segments: { name: string }[] = JSON.parse(rawData);

    console.log('Seeding segments...');

    for (const segment of segments) {
        await prisma.segment.upsert({
            where: { name: segment.name },
            update: {},
            create: {
                name: segment.name,
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
