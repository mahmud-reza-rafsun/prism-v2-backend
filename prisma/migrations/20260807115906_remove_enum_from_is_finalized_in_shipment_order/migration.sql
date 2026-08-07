/*
  Warnings:

  - The `isFinalized` column on the `shipment_orders` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `unlockRequested` column on the `shipment_orders` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "shipment_orders" DROP COLUMN "isFinalized",
ADD COLUMN     "isFinalized" BOOLEAN NOT NULL DEFAULT true,
DROP COLUMN "unlockRequested",
ADD COLUMN     "unlockRequested" BOOLEAN NOT NULL DEFAULT false;

-- DropEnum
DROP TYPE "ShipmentOrderStatus";
