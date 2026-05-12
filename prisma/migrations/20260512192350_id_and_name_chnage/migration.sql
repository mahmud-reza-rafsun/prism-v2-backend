/*
  Warnings:

  - You are about to drop the column `retailerId` on the `sku_name` table. All the data in the column will be lost.
  - You are about to drop the `retailers` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[outletNameId]` on the table `sku_name` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `outletNameId` to the `sku_name` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "retailers" DROP CONSTRAINT "retailers_distributionPointsId_fkey";

-- DropForeignKey
ALTER TABLE "retailers" DROP CONSTRAINT "retailers_skuNameId_fkey";

-- DropIndex
DROP INDEX "sku_name_retailerId_key";

-- AlterTable
ALTER TABLE "sku_name" DROP COLUMN "retailerId",
ADD COLUMN     "outletNameId" TEXT NOT NULL;

-- DropTable
DROP TABLE "retailers";

-- CreateTable
CREATE TABLE "outlet_name" (
    "id" TEXT NOT NULL,
    "prismID" TEXT NOT NULL,
    "partnerCode" TEXT,
    "region" TEXT NOT NULL,
    "area" TEXT NOT NULL,
    "territory" TEXT NOT NULL,
    "house" TEXT NOT NULL,
    "point" TEXT NOT NULL,
    "clusterName" TEXT NOT NULL,
    "clusterType" TEXT NOT NULL,
    "geoClass" TEXT NOT NULL,
    "routeNumber" TEXT NOT NULL,
    "section" TEXT NOT NULL,
    "retailerName" TEXT NOT NULL,
    "ownerName" TEXT NOT NULL,
    "contactNumber" TEXT NOT NULL,
    "channel" TEXT NOT NULL,
    "subChannel" TEXT NOT NULL,
    "superTPG" TEXT NOT NULL,
    "tpg" TEXT NOT NULL,
    "pmmInformation" TEXT,
    "dccScope" TEXT,
    "skuNameId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "distributionPointsId" TEXT,

    CONSTRAINT "outlet_name_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "outlet_name_prismID_key" ON "outlet_name"("prismID");

-- CreateIndex
CREATE UNIQUE INDEX "sku_name_outletNameId_key" ON "sku_name"("outletNameId");

-- AddForeignKey
ALTER TABLE "outlet_name" ADD CONSTRAINT "outlet_name_skuNameId_fkey" FOREIGN KEY ("skuNameId") REFERENCES "sku_name"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "outlet_name" ADD CONSTRAINT "outlet_name_distributionPointsId_fkey" FOREIGN KEY ("distributionPointsId") REFERENCES "distribution_points"("id") ON DELETE SET NULL ON UPDATE CASCADE;
