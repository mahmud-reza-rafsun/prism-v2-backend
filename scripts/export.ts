import fs from "node:fs";
import { prisma } from "../src/database/prisma";

async function main() {
    const [regions, areas, distributionHouses, territories] = await Promise.all([
        prisma.region.findMany(),
        prisma.area.findMany(),
        prisma.distributionHouse.findMany(),
        prisma.territory.findMany(),
    ]);

    const data = {
        regions,
        areas,
        distributionHouses,
        territories,
    };

    fs.writeFileSync("backup.json", JSON.stringify(data, null, 2), "utf8");

    console.log("✅ Export completed!");
}

main()
    .catch((error) => {
        console.error(error);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
