/*
  Warnings:

  - You are about to drop the column `finalizedAt` on the `shipment_orders` table. All the data in the column will be lost.
  - The `isFinalized` column on the `shipment_orders` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- CreateEnum
CREATE TYPE "ShipmentOrderStatus" AS ENUM ('TRUE', 'FALSE');

-- AlterTable
ALTER TABLE "shipment_orders" DROP COLUMN "finalizedAt",
DROP COLUMN "isFinalized",
ADD COLUMN     "isFinalized" "ShipmentOrderStatus" NOT NULL DEFAULT 'TRUE';
