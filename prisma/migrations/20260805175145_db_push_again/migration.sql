/*
  Warnings:

  - You are about to drop the `Family` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Family" DROP CONSTRAINT "Family_segmentId_fkey";

-- DropForeignKey
ALTER TABLE "brand" DROP CONSTRAINT "brand_familyId_fkey";

-- DropForeignKey
ALTER TABLE "stt_sku" DROP CONSTRAINT "stt_sku_familyId_fkey";

-- DropTable
DROP TABLE "Family";

-- CreateTable
CREATE TABLE "family" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "segmentId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "family_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "family_name_key" ON "family"("name");

-- CreateIndex
CREATE INDEX "family_segmentId_idx" ON "family"("segmentId");

-- AddForeignKey
ALTER TABLE "brand" ADD CONSTRAINT "brand_familyId_fkey" FOREIGN KEY ("familyId") REFERENCES "family"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "family" ADD CONSTRAINT "family_segmentId_fkey" FOREIGN KEY ("segmentId") REFERENCES "segment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stt_sku" ADD CONSTRAINT "stt_sku_familyId_fkey" FOREIGN KEY ("familyId") REFERENCES "family"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
