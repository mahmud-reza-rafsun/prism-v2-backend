/*
  Warnings:

  - You are about to drop the column `distributionHouseId` on the `distributor_price` table. All the data in the column will be lost.

*/
-- AlterEnum
ALTER TYPE "Role" ADD VALUE 'FG_SUPERVISOR';

-- DropForeignKey
ALTER TABLE "distributor_price" DROP CONSTRAINT "distributor_price_distributionHouseId_fkey";

-- DropIndex
DROP INDEX "distributor_price_distributionHouseId_shipmentOrderId_idx";

-- AlterTable
ALTER TABLE "distributor_price" DROP COLUMN "distributionHouseId";

-- CreateIndex
CREATE INDEX "distributor_price_shipmentOrderId_idx" ON "distributor_price"("shipmentOrderId");
