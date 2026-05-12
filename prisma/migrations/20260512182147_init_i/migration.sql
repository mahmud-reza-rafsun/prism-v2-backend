-- CreateEnum
CREATE TYPE "SalesPlanStatus" AS ENUM ('ACTIVE', 'INACTIVE');

-- AlterTable
ALTER TABLE "retailers" ADD COLUMN     "distributionPointsId" TEXT;

-- CreateTable
CREATE TABLE "area" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT,
    "regionId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "area_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "distribution_points" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT,
    "territoryId" TEXT NOT NULL,
    "address" TEXT,
    "contact" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "distribution_points_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "region" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "region_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "routes" (
    "id" TEXT NOT NULL,
    "routeNumber" INTEGER NOT NULL DEFAULT 0,
    "distributionPointsId" TEXT NOT NULL,

    CONSTRAINT "routes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sales_plan" (
    "id" TEXT NOT NULL,
    "pointId" TEXT NOT NULL,
    "skuNameId" TEXT NOT NULL,
    "status" "SalesPlanStatus" NOT NULL DEFAULT 'ACTIVE',
    "effectiveFrom" TIMESTAMP(3),
    "effectiveTo" TIMESTAMP(3),
    "createdById" TEXT,
    "updatedById" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "sales_plan_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "territory" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT,
    "areaId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "territory_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "area_code_key" ON "area"("code");

-- CreateIndex
CREATE UNIQUE INDEX "area_name_regionId_key" ON "area"("name", "regionId");

-- CreateIndex
CREATE UNIQUE INDEX "distribution_points_code_key" ON "distribution_points"("code");

-- CreateIndex
CREATE UNIQUE INDEX "region_name_key" ON "region"("name");

-- CreateIndex
CREATE UNIQUE INDEX "region_code_key" ON "region"("code");

-- CreateIndex
CREATE UNIQUE INDEX "sales_plan_pointId_skuNameId_key" ON "sales_plan"("pointId", "skuNameId");

-- CreateIndex
CREATE UNIQUE INDEX "territory_code_key" ON "territory"("code");

-- CreateIndex
CREATE UNIQUE INDEX "territory_name_areaId_key" ON "territory"("name", "areaId");

-- AddForeignKey
ALTER TABLE "area" ADD CONSTRAINT "area_regionId_fkey" FOREIGN KEY ("regionId") REFERENCES "region"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "distribution_points" ADD CONSTRAINT "distribution_points_territoryId_fkey" FOREIGN KEY ("territoryId") REFERENCES "territory"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "retailers" ADD CONSTRAINT "retailers_distributionPointsId_fkey" FOREIGN KEY ("distributionPointsId") REFERENCES "distribution_points"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "routes" ADD CONSTRAINT "routes_distributionPointsId_fkey" FOREIGN KEY ("distributionPointsId") REFERENCES "distribution_points"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sales_plan" ADD CONSTRAINT "sales_plan_pointId_fkey" FOREIGN KEY ("pointId") REFERENCES "distribution_points"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sales_plan" ADD CONSTRAINT "sales_plan_skuNameId_fkey" FOREIGN KEY ("skuNameId") REFERENCES "sku_name"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "territory" ADD CONSTRAINT "territory_areaId_fkey" FOREIGN KEY ("areaId") REFERENCES "area"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
