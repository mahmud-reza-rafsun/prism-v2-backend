/*
  Warnings:

  - You are about to drop the `stt_records` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE "stt_records";

-- CreateTable
CREATE TABLE "final_submits" (
    "id" TEXT NOT NULL,
    "date" DATE NOT NULL,
    "point" TEXT NOT NULL,
    "sttNumber" TEXT NOT NULL,
    "value" DECIMAL(15,2) NOT NULL DEFAULT 0.0,
    "status" "FinalSubmitStatus" NOT NULL DEFAULT 'PENDING',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "final_submits_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "final_submits_sttNumber_key" ON "final_submits"("sttNumber");
