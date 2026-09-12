import fs from "node:fs";
import path from "node:path";
import { prisma } from "../../src/database/prisma";

const backupFilePath = path.join(process.cwd(), "raw_data", "backup2.json");

const backup = JSON.parse(fs.readFileSync(backupFilePath, "utf8"));

async function main() {
    console.log("Seeding Master Data...");

    await prisma.region.createMany({
        data: backup.regions,
        skipDuplicates: true,
    });
    console.log(`✅ Region: ${backup.regions.length}`);

    await prisma.area.createMany({
        data: backup.areas,
        skipDuplicates: true,
    });
    console.log(`✅ Area: ${backup.areas.length}`);

    await prisma.distributionHouse.createMany({
        data: backup.distributionHouses,
        skipDuplicates: true,
    });
    console.log(`✅ Distribution House: ${backup.distributionHouses.length}`);

    await prisma.territory.createMany({
        data: backup.territories,
        skipDuplicates: true,
    });
    console.log(`✅ Territory: ${backup.territories.length}`);

    console.log("Seed Completed Successfully!");
}

main()
    .catch((err) => {
        console.error("Seeding Error:", err);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
