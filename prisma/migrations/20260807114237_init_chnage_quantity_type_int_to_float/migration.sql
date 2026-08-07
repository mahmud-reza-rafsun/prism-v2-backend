/*
  Warnings:

  - The `unlockRequested` column on the `shipment_orders` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "shipment_orders" ALTER COLUMN "quantity" SET DEFAULT 0.00,
ALTER COLUMN "quantity" SET DATA TYPE DOUBLE PRECISION,
DROP COLUMN "unlockRequested",
ADD COLUMN     "unlockRequested" "ShipmentOrderStatus" NOT NULL DEFAULT 'FALSE';
