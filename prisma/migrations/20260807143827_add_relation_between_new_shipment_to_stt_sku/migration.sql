/*
  Warnings:

  - You are about to drop the column `skuNameId` on the `new_shipment` table. All the data in the column will be lost.
  - Added the required column `sttSkuId` to the `new_shipment` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "new_shipment" DROP COLUMN "skuNameId",
ADD COLUMN     "sttSkuId" TEXT NOT NULL,
ALTER COLUMN "onHandStock" SET DEFAULT 0.00,
ALTER COLUMN "onHandStock" SET DATA TYPE DOUBLE PRECISION,
ALTER COLUMN "ShipmentQuantity" SET DEFAULT 0.00,
ALTER COLUMN "ShipmentQuantity" SET DATA TYPE DOUBLE PRECISION;

-- CreateIndex
CREATE INDEX "new_shipment_sttSkuId_idx" ON "new_shipment"("sttSkuId");

-- AddForeignKey
ALTER TABLE "new_shipment" ADD CONSTRAINT "new_shipment_sttSkuId_fkey" FOREIGN KEY ("sttSkuId") REFERENCES "stt_sku"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
