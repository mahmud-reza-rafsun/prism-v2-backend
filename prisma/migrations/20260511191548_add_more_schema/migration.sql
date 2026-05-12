/*
  Warnings:

  - Added the required column `skuNameId` to the `retailers` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "FinalSubmitStatus" AS ENUM ('PENDING', 'COMPLETED');

-- AlterTable
ALTER TABLE "retailers" ADD COLUMN     "skuNameId" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "by-outlet-stt" (
    "id" TEXT NOT NULL,
    "region" TEXT NOT NULL,
    "area" TEXT NOT NULL,
    "house" TEXT NOT NULL,
    "territory" TEXT NOT NULL,
    "point" TEXT NOT NULL,
    "route" TEXT NOT NULL,
    "retailerCode" TEXT NOT NULL,
    "retailerName" TEXT NOT NULL,
    "channel" TEXT NOT NULL,
    "subChannel" TEXT NOT NULL,
    "cluster" TEXT NOT NULL,
    "clusterType" TEXT NOT NULL,
    "tpg" TEXT NOT NULL,
    "skuNameId" TEXT NOT NULL,
    "stt" INTEGER NOT NULL DEFAULT 0,
    "memo" INTEGER NOT NULL DEFAULT 0,
    "total" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "by-outlet-stt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ds_rrs_report" (
    "id" TEXT NOT NULL,
    "skuNameId" TEXT NOT NULL,
    "issue" INTEGER NOT NULL DEFAULT 0,
    "return" INTEGER NOT NULL DEFAULT 0,
    "totalStt" INTEGER NOT NULL DEFAULT 0,
    "memo" INTEGER NOT NULL DEFAULT 0,
    "platinum" INTEGER NOT NULL DEFAULT 0,
    "gold" INTEGER NOT NULL DEFAULT 0,
    "silver" INTEGER NOT NULL DEFAULT 0,
    "rcc" INTEGER NOT NULL DEFAULT 0,
    "trc" INTEGER NOT NULL DEFAULT 0,
    "bcc" INTEGER NOT NULL DEFAULT 0,
    "gt" INTEGER NOT NULL DEFAULT 0,
    "manufacturingFault" INTEGER NOT NULL DEFAULT 0,
    "marketingFault" INTEGER NOT NULL DEFAULT 0,
    "amountTaka" DECIMAL(10,2) NOT NULL DEFAULT 0.0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ds_rrs_report_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stt_records" (
    "id" TEXT NOT NULL,
    "date" DATE NOT NULL,
    "point" TEXT NOT NULL,
    "sttNumber" TEXT NOT NULL,
    "value" DECIMAL(15,2) NOT NULL DEFAULT 0.0,
    "status" "FinalSubmitStatus" NOT NULL DEFAULT 'PENDING',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "stt_records_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "own_point_distribution" (
    "own_point_dist_id" TEXT NOT NULL,
    "pointOnHandStock" INTEGER NOT NULL DEFAULT 0,
    "transferableAmount" INTEGER NOT NULL DEFAULT 0,
    "skuNameId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "own_point_distribution_pkey" PRIMARY KEY ("own_point_dist_id")
);

-- CreateTable
CREATE TABLE "route_wise_stt" (
    "id" TEXT NOT NULL,
    "region" TEXT NOT NULL,
    "area" TEXT NOT NULL,
    "territory" TEXT NOT NULL,
    "house" TEXT NOT NULL,
    "point" TEXT NOT NULL,
    "route" INTEGER NOT NULL DEFAULT 0,
    "skuNameId" TEXT NOT NULL,
    "totalStt" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "route_wise_stt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "route_wise_memo" (
    "id" TEXT NOT NULL,
    "region" TEXT NOT NULL,
    "area" TEXT NOT NULL,
    "territory" TEXT NOT NULL,
    "house" TEXT NOT NULL,
    "point" TEXT NOT NULL,
    "route" INTEGER NOT NULL DEFAULT 0,
    "target" INTEGER NOT NULL DEFAULT 0,
    "successfulCall" INTEGER NOT NULL DEFAULT 0,
    "skuNameId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "route_wise_memo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sales_summary_statement" (
    "id" TEXT NOT NULL,
    "route" INTEGER NOT NULL DEFAULT 0,
    "rRName" TEXT NOT NULL,
    "noOfOutlets" INTEGER NOT NULL DEFAULT 0,
    "noOfMemos" INTEGER NOT NULL DEFAULT 0,
    "skuNameId" TEXT NOT NULL,
    "totalVolume" INTEGER NOT NULL DEFAULT 0,
    "totalValue" DECIMAL(10,2) NOT NULL DEFAULT 0.0,
    "percentOfVolume" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "percentOfValue" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "discountAmount" DECIMAL(10,2) NOT NULL DEFAULT 0.0,
    "unnotiReimbursement" DECIMAL(10,2) NOT NULL DEFAULT 0.0,
    "netValue" DECIMAL(10,2) NOT NULL DEFAULT 0.0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "sales_summary_statement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "shipment_orders" (
    "id" TEXT NOT NULL,
    "skuNameId" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 0,
    "targetDate" DATE NOT NULL,
    "isFinalized" BOOLEAN NOT NULL DEFAULT false,
    "finalizedAt" TIMESTAMP(3),
    "unlockRequested" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "shipment_orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "shipment" (
    "id" TEXT NOT NULL,
    "onHandStock" INTEGER NOT NULL DEFAULT 0,
    "skuNameId" TEXT NOT NULL,

    CONSTRAINT "shipment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stock_management" (
    "id" TEXT NOT NULL,
    "skuNameId" TEXT NOT NULL,
    "region" TEXT,
    "area" TEXT,
    "distributionHouse" TEXT,
    "skuOpening" INTEGER NOT NULL DEFAULT 0,
    "shipment" INTEGER NOT NULL DEFAULT 0,
    "igt" INTEGER NOT NULL DEFAULT 0,
    "stt" INTEGER NOT NULL DEFAULT 0,
    "stolen" INTEGER NOT NULL DEFAULT 0,
    "warehouseQc" INTEGER NOT NULL DEFAULT 0,
    "closing" INTEGER NOT NULL DEFAULT 0,
    "scr" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "stock_management_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "by-outlet-stt_retailerCode_key" ON "by-outlet-stt"("retailerCode");

-- CreateIndex
CREATE UNIQUE INDEX "stt_records_sttNumber_key" ON "stt_records"("sttNumber");

-- CreateIndex
CREATE UNIQUE INDEX "shipment_orders_skuNameId_targetDate_key" ON "shipment_orders"("skuNameId", "targetDate");

-- AddForeignKey
ALTER TABLE "by-outlet-stt" ADD CONSTRAINT "by-outlet-stt_skuNameId_fkey" FOREIGN KEY ("skuNameId") REFERENCES "sku_name"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ds_rrs_report" ADD CONSTRAINT "ds_rrs_report_skuNameId_fkey" FOREIGN KEY ("skuNameId") REFERENCES "sku_name"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "own_point_distribution" ADD CONSTRAINT "own_point_distribution_skuNameId_fkey" FOREIGN KEY ("skuNameId") REFERENCES "sku_name"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "retailers" ADD CONSTRAINT "retailers_skuNameId_fkey" FOREIGN KEY ("skuNameId") REFERENCES "sku_name"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "route_wise_stt" ADD CONSTRAINT "route_wise_stt_skuNameId_fkey" FOREIGN KEY ("skuNameId") REFERENCES "sku_name"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "route_wise_memo" ADD CONSTRAINT "route_wise_memo_skuNameId_fkey" FOREIGN KEY ("skuNameId") REFERENCES "sku_name"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sales_summary_statement" ADD CONSTRAINT "sales_summary_statement_skuNameId_fkey" FOREIGN KEY ("skuNameId") REFERENCES "sku_name"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "shipment_orders" ADD CONSTRAINT "shipment_orders_skuNameId_fkey" FOREIGN KEY ("skuNameId") REFERENCES "sku_name"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "shipment" ADD CONSTRAINT "shipment_skuNameId_fkey" FOREIGN KEY ("skuNameId") REFERENCES "sku_name"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stock_management" ADD CONSTRAINT "stock_management_skuNameId_fkey" FOREIGN KEY ("skuNameId") REFERENCES "sku_name"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
