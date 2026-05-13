/*
  Warnings:

  - You are about to drop the column `areaId` on the `territory` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[name,distributionHouseId]` on the table `territory` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `distributionHouseId` to the `territory` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "territory" DROP CONSTRAINT "territory_areaId_fkey";

-- DropIndex
DROP INDEX "territory_name_areaId_key";

-- AlterTable
ALTER TABLE "territory" DROP COLUMN "areaId",
ADD COLUMN     "distributionHouseId" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "distribution_houses" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT,
    "areaId" TEXT NOT NULL,
    "address" TEXT,
    "contact" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "distribution_houses_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "distribution_houses_code_key" ON "distribution_houses"("code");

-- CreateIndex
CREATE UNIQUE INDEX "distribution_houses_name_areaId_key" ON "distribution_houses"("name", "areaId");

-- CreateIndex
CREATE UNIQUE INDEX "territory_name_distributionHouseId_key" ON "territory"("name", "distributionHouseId");

-- AddForeignKey
ALTER TABLE "distribution_houses" ADD CONSTRAINT "distribution_houses_areaId_fkey" FOREIGN KEY ("areaId") REFERENCES "area"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "territory" ADD CONSTRAINT "territory_distributionHouseId_fkey" FOREIGN KEY ("distributionHouseId") REFERENCES "distribution_houses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
