-- CreateEnum
CREATE TYPE "Role" AS ENUM ('SUPER_ADMIN', 'ADMIN', 'HEAD_OF_TRADE', 'FINANCE_CONTROLLER', 'ACCOUNTS_OFFICER', 'REGIONAL_MANAGER', 'REGIONAL_REPORTING_OFFICER', 'AREA_MANAGER', 'TERRITORY_OFFICER', 'BUSINESS_MANAGER', 'COMPUTER_OPERATOR');

-- CreateEnum
CREATE TYPE "UserStatus" AS ENUM ('ACTIVE', 'BLOCKED', 'DELETED');

-- CreateEnum
CREATE TYPE "FinalSubmitStatus" AS ENUM ('PENDING', 'COMPLETED');

-- CreateEnum
CREATE TYPE "SalesPlanStatus" AS ENUM ('ACTIVE', 'INACTIVE');

-- CreateEnum
CREATE TYPE "SttSkuStatus" AS ENUM ('ACTIVE', 'INACTIVE');

-- CreateEnum
CREATE TYPE "OutletStatus" AS ENUM ('ACTIVE', 'INACTIVE');

-- CreateEnum
CREATE TYPE "SectionType" AS ENUM ('A', 'B', 'D');

-- CreateEnum
CREATE TYPE "BusinessDateStatus" AS ENUM ('TRUE', 'FALSE');

-- CreateEnum
CREATE TYPE "IGTStatus" AS ENUM ('PENDING', 'NO_PENDING');

-- CreateTable
CREATE TABLE "add_new_igt" (
    "id" TEXT NOT NULL,
    "distributionHouseId" TEXT NOT NULL,
    "AvailableAmount" DOUBLE PRECISION NOT NULL,
    "PendingTransfer" "IGTStatus" NOT NULL DEFAULT 'NO_PENDING',

    CONSTRAINT "add_new_igt_pkey" PRIMARY KEY ("id")
);

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
CREATE TABLE "user" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "emailVerified" BOOLEAN NOT NULL DEFAULT false,
    "role" "Role" NOT NULL,
    "status" "UserStatus" NOT NULL DEFAULT 'ACTIVE',
    "needPasswordChange" BOOLEAN NOT NULL DEFAULT false,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,
    "deletedAt" TIMESTAMP(3),
    "image" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "areaId" TEXT,
    "regionId" TEXT,
    "distributionHouseId" TEXT,
    "territoryId" TEXT,
    "distributionPointId" TEXT,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "session" (
    "id" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "token" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "ipAddress" TEXT,
    "userAgent" TEXT,
    "userId" TEXT NOT NULL,

    CONSTRAINT "session_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "account" (
    "id" TEXT NOT NULL,
    "accountId" TEXT NOT NULL,
    "providerId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "accessToken" TEXT,
    "refreshToken" TEXT,
    "idToken" TEXT,
    "accessTokenExpiresAt" TIMESTAMP(3),
    "refreshTokenExpiresAt" TIMESTAMP(3),
    "scope" TEXT,
    "password" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "account_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "verification" (
    "id" TEXT NOT NULL,
    "identifier" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "verification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Brand" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "familyId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Brand_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "business_date" (
    "id" TEXT NOT NULL,
    "businessDate" TIMESTAMP(3) NOT NULL,
    "isClosed" "BusinessDateStatus" NOT NULL DEFAULT 'FALSE',
    "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "business_date_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "by_outlet_stt" (
    "id" TEXT NOT NULL,
    "region" TEXT NOT NULL,
    "area" TEXT NOT NULL,
    "distributionHouseId" TEXT NOT NULL,
    "territoryId" TEXT NOT NULL,
    "point" TEXT NOT NULL,
    "route" TEXT NOT NULL,
    "retailerCode" TEXT NOT NULL,
    "retailerName" TEXT NOT NULL,
    "channel" TEXT NOT NULL,
    "subChannel" TEXT NOT NULL,
    "cluster" TEXT NOT NULL,
    "clusterType" TEXT NOT NULL,
    "tpg" TEXT NOT NULL,
    "stt" INTEGER NOT NULL DEFAULT 0,
    "memo" INTEGER NOT NULL DEFAULT 0,
    "total" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "businessDateId" TEXT NOT NULL,
    "sttSkuId" TEXT NOT NULL,

    CONSTRAINT "by_outlet_stt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "distribution_points" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT,
    "territoryId" TEXT,
    "address" TEXT,
    "contact" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "distributionHouseId" TEXT NOT NULL,

    CONSTRAINT "distribution_points_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "distribution_house" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT,
    "areaId" TEXT NOT NULL,
    "address" TEXT,
    "contact" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "distribution_house_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ds_rrs_report" (
    "id" TEXT NOT NULL,
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
    "sttSkuId" TEXT NOT NULL,

    CONSTRAINT "ds_rrs_report_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Family" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "segmentId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Family_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "final_submit" (
    "id" TEXT NOT NULL,
    "date" DATE NOT NULL,
    "point" TEXT NOT NULL,
    "sttNumber" TEXT NOT NULL,
    "value" DECIMAL(15,2) NOT NULL DEFAULT 0.0,
    "status" "FinalSubmitStatus" NOT NULL DEFAULT 'PENDING',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "businessDateId" TEXT NOT NULL,
    "sectionId" TEXT NOT NULL,
    "roueteId" TEXT NOT NULL,
    "distributionPointId" TEXT NOT NULL,

    CONSTRAINT "final_submit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "new_shipment" (
    "id" TEXT NOT NULL,
    "onHandStock" INTEGER NOT NULL DEFAULT 0,
    "skuNameId" TEXT NOT NULL,
    "ShipmentQuantity" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "new_shipment_pkey" PRIMARY KEY ("id")
);

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
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "distributionPointsId" TEXT,
    "sttSkuId" TEXT NOT NULL,

    CONSTRAINT "outlet_name_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "own_point_distribution" (
    "own_point_dist_id" TEXT NOT NULL,
    "pointOnHandStock" INTEGER NOT NULL DEFAULT 0,
    "transferableAmount" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "sttSkuId" TEXT NOT NULL,
    "distributionPointId" TEXT NOT NULL,

    CONSTRAINT "own_point_distribution_pkey" PRIMARY KEY ("own_point_dist_id")
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
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "businessDateId" TEXT NOT NULL,
    "sttSkuId" TEXT NOT NULL,
    "distributionPointId" TEXT NOT NULL,

    CONSTRAINT "route_wise_memo_pkey" PRIMARY KEY ("id")
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
    "totalStt" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "businessDateId" TEXT NOT NULL,
    "sttSkuId" TEXT NOT NULL,

    CONSTRAINT "route_wise_stt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "routes" (
    "id" TEXT NOT NULL,
    "routeNumber" INTEGER NOT NULL DEFAULT 0,
    "distributionPointsId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "routes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sales_plan" (
    "id" TEXT NOT NULL,
    "pointId" TEXT NOT NULL,
    "status" "SalesPlanStatus" NOT NULL DEFAULT 'ACTIVE',
    "effectiveFrom" TIMESTAMP(3),
    "effectiveTo" TIMESTAMP(3),
    "createdById" TEXT,
    "updatedById" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "sttSkuId" TEXT NOT NULL,

    CONSTRAINT "sales_plan_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sales_summary_statement" (
    "id" TEXT NOT NULL,
    "noOfOutlets" INTEGER NOT NULL DEFAULT 0,
    "noOfMemos" INTEGER NOT NULL DEFAULT 0,
    "totalVolume" INTEGER NOT NULL DEFAULT 0,
    "totalValue" DECIMAL(10,2) NOT NULL DEFAULT 0.0,
    "percentOfVolume" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "percentOfValue" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "discountAmount" DECIMAL(10,2) NOT NULL DEFAULT 0.0,
    "unnotiReimbursement" DECIMAL(10,2) NOT NULL DEFAULT 0.0,
    "netValue" DECIMAL(10,2) NOT NULL DEFAULT 0.0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "businessDateId" TEXT NOT NULL,
    "sectionId" TEXT NOT NULL,
    "sttSkuId" TEXT NOT NULL,

    CONSTRAINT "sales_summary_statement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "section" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "type" "SectionType" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "section_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Segment" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Segment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "shipment_orders" (
    "id" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 0,
    "targetDate" DATE NOT NULL,
    "isFinalized" BOOLEAN NOT NULL DEFAULT false,
    "finalizedAt" TIMESTAMP(3),
    "unlockRequested" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "distributionHouseId" TEXT NOT NULL,
    "shipmentSkuId" TEXT NOT NULL,

    CONSTRAINT "shipment_orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ShipmentSku" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT,
    "packSize" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ShipmentSku_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stock_management" (
    "id" TEXT NOT NULL,
    "skuOpening" INTEGER NOT NULL DEFAULT 0,
    "shipment" INTEGER NOT NULL DEFAULT 0,
    "igt" INTEGER NOT NULL DEFAULT 0,
    "stt" INTEGER NOT NULL DEFAULT 0,
    "closing" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "stockManagementSkuId" TEXT NOT NULL,
    "businessDateId" TEXT NOT NULL,

    CONSTRAINT "stock_management_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stock_management_sku" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT,
    "packSize" TEXT,
    "brandId" TEXT NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "stock_management_sku_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stt_sku" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT,
    "packSize" TEXT,
    "brandId" TEXT NOT NULL,
    "familyId" TEXT NOT NULL,
    "segmentId" TEXT NOT NULL,
    "isActive" "SttSkuStatus" NOT NULL DEFAULT 'ACTIVE',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "stt_sku_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "territory" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "distributionHouseId" TEXT NOT NULL,
    "areaId" TEXT NOT NULL,

    CONSTRAINT "territory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_OutletNameToRoutes" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,

    CONSTRAINT "_OutletNameToRoutes_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE INDEX "add_new_igt_distributionHouseId_idx" ON "add_new_igt"("distributionHouseId");

-- CreateIndex
CREATE UNIQUE INDEX "area_code_key" ON "area"("code");

-- CreateIndex
CREATE INDEX "area_regionId_idx" ON "area"("regionId");

-- CreateIndex
CREATE UNIQUE INDEX "area_name_regionId_key" ON "area"("name", "regionId");

-- CreateIndex
CREATE UNIQUE INDEX "user_email_key" ON "user"("email");

-- CreateIndex
CREATE INDEX "user_regionId_idx" ON "user"("regionId");

-- CreateIndex
CREATE INDEX "user_areaId_idx" ON "user"("areaId");

-- CreateIndex
CREATE INDEX "user_distributionHouseId_idx" ON "user"("distributionHouseId");

-- CreateIndex
CREATE INDEX "user_territoryId_idx" ON "user"("territoryId");

-- CreateIndex
CREATE INDEX "user_distributionPointId_idx" ON "user"("distributionPointId");

-- CreateIndex
CREATE UNIQUE INDEX "session_token_key" ON "session"("token");

-- CreateIndex
CREATE INDEX "session_userId_idx" ON "session"("userId");

-- CreateIndex
CREATE INDEX "account_userId_idx" ON "account"("userId");

-- CreateIndex
CREATE INDEX "verification_identifier_idx" ON "verification"("identifier");

-- CreateIndex
CREATE UNIQUE INDEX "Brand_name_key" ON "Brand"("name");

-- CreateIndex
CREATE INDEX "Brand_familyId_idx" ON "Brand"("familyId");

-- CreateIndex
CREATE UNIQUE INDEX "business_date_businessDate_key" ON "business_date"("businessDate");

-- CreateIndex
CREATE UNIQUE INDEX "by_outlet_stt_retailerCode_key" ON "by_outlet_stt"("retailerCode");

-- CreateIndex
CREATE UNIQUE INDEX "distribution_points_code_key" ON "distribution_points"("code");

-- CreateIndex
CREATE UNIQUE INDEX "distribution_house_code_key" ON "distribution_house"("code");

-- CreateIndex
CREATE INDEX "distribution_house_areaId_idx" ON "distribution_house"("areaId");

-- CreateIndex
CREATE UNIQUE INDEX "distribution_house_name_areaId_key" ON "distribution_house"("name", "areaId");

-- CreateIndex
CREATE UNIQUE INDEX "Family_name_key" ON "Family"("name");

-- CreateIndex
CREATE INDEX "Family_segmentId_idx" ON "Family"("segmentId");

-- CreateIndex
CREATE UNIQUE INDEX "final_submit_sttNumber_key" ON "final_submit"("sttNumber");

-- CreateIndex
CREATE INDEX "idx_final_submit_business_date_id" ON "final_submit"("businessDateId");

-- CreateIndex
CREATE INDEX "idx_final_submit_section_id" ON "final_submit"("sectionId");

-- CreateIndex
CREATE INDEX "idx_final_submit_route_id" ON "final_submit"("roueteId");

-- CreateIndex
CREATE INDEX "idx_final_submit_distribution_point_id" ON "final_submit"("distributionPointId");

-- CreateIndex
CREATE UNIQUE INDEX "outlet_name_prismID_key" ON "outlet_name"("prismID");

-- CreateIndex
CREATE UNIQUE INDEX "region_name_key" ON "region"("name");

-- CreateIndex
CREATE UNIQUE INDEX "region_code_key" ON "region"("code");

-- CreateIndex
CREATE INDEX "route_wise_memo_distributionPointId_idx" ON "route_wise_memo"("distributionPointId");

-- CreateIndex
CREATE INDEX "route_wise_memo_businessDateId_idx" ON "route_wise_memo"("businessDateId");

-- CreateIndex
CREATE INDEX "route_wise_memo_sttSkuId_idx" ON "route_wise_memo"("sttSkuId");

-- CreateIndex
CREATE UNIQUE INDEX "sales_plan_pointId_sttSkuId_key" ON "sales_plan"("pointId", "sttSkuId");

-- CreateIndex
CREATE UNIQUE INDEX "section_name_key" ON "section"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Segment_name_key" ON "Segment"("name");

-- CreateIndex
CREATE INDEX "shipment_orders_shipmentSkuId_idx" ON "shipment_orders"("shipmentSkuId");

-- CreateIndex
CREATE INDEX "shipment_orders_distributionHouseId_idx" ON "shipment_orders"("distributionHouseId");

-- CreateIndex
CREATE UNIQUE INDEX "shipment_orders_shipmentSkuId_targetDate_distributionHouseI_key" ON "shipment_orders"("shipmentSkuId", "targetDate", "distributionHouseId");

-- CreateIndex
CREATE UNIQUE INDEX "ShipmentSku_name_key" ON "ShipmentSku"("name");

-- CreateIndex
CREATE UNIQUE INDEX "ShipmentSku_code_key" ON "ShipmentSku"("code");

-- CreateIndex
CREATE INDEX "stock_management_stockManagementSkuId_idx" ON "stock_management"("stockManagementSkuId");

-- CreateIndex
CREATE INDEX "stock_management_businessDateId_idx" ON "stock_management"("businessDateId");

-- CreateIndex
CREATE UNIQUE INDEX "stock_management_sku_name_key" ON "stock_management_sku"("name");

-- CreateIndex
CREATE UNIQUE INDEX "stock_management_sku_code_key" ON "stock_management_sku"("code");

-- CreateIndex
CREATE INDEX "stock_management_sku_brandId_idx" ON "stock_management_sku"("brandId");

-- CreateIndex
CREATE UNIQUE INDEX "stt_sku_name_key" ON "stt_sku"("name");

-- CreateIndex
CREATE UNIQUE INDEX "stt_sku_code_key" ON "stt_sku"("code");

-- CreateIndex
CREATE INDEX "stt_sku_segmentId_idx" ON "stt_sku"("segmentId");

-- CreateIndex
CREATE INDEX "stt_sku_familyId_idx" ON "stt_sku"("familyId");

-- CreateIndex
CREATE INDEX "stt_sku_brandId_idx" ON "stt_sku"("brandId");

-- CreateIndex
CREATE UNIQUE INDEX "territory_code_key" ON "territory"("code");

-- CreateIndex
CREATE INDEX "territory_distributionHouseId_areaId_idx" ON "territory"("distributionHouseId", "areaId");

-- CreateIndex
CREATE UNIQUE INDEX "territory_name_distributionHouseId_key" ON "territory"("name", "distributionHouseId");

-- CreateIndex
CREATE INDEX "_OutletNameToRoutes_B_index" ON "_OutletNameToRoutes"("B");

-- AddForeignKey
ALTER TABLE "add_new_igt" ADD CONSTRAINT "add_new_igt_distributionHouseId_fkey" FOREIGN KEY ("distributionHouseId") REFERENCES "distribution_house"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "area" ADD CONSTRAINT "area_regionId_fkey" FOREIGN KEY ("regionId") REFERENCES "region"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user" ADD CONSTRAINT "user_regionId_fkey" FOREIGN KEY ("regionId") REFERENCES "region"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user" ADD CONSTRAINT "user_areaId_fkey" FOREIGN KEY ("areaId") REFERENCES "area"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user" ADD CONSTRAINT "user_distributionHouseId_fkey" FOREIGN KEY ("distributionHouseId") REFERENCES "distribution_house"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user" ADD CONSTRAINT "user_territoryId_fkey" FOREIGN KEY ("territoryId") REFERENCES "territory"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user" ADD CONSTRAINT "user_distributionPointId_fkey" FOREIGN KEY ("distributionPointId") REFERENCES "distribution_points"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "session" ADD CONSTRAINT "session_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "account" ADD CONSTRAINT "account_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Brand" ADD CONSTRAINT "Brand_familyId_fkey" FOREIGN KEY ("familyId") REFERENCES "Family"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "by_outlet_stt" ADD CONSTRAINT "by_outlet_stt_distributionHouseId_fkey" FOREIGN KEY ("distributionHouseId") REFERENCES "distribution_house"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "by_outlet_stt" ADD CONSTRAINT "by_outlet_stt_territoryId_fkey" FOREIGN KEY ("territoryId") REFERENCES "territory"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "by_outlet_stt" ADD CONSTRAINT "by_outlet_stt_businessDateId_fkey" FOREIGN KEY ("businessDateId") REFERENCES "business_date"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "distribution_points" ADD CONSTRAINT "distribution_points_distributionHouseId_fkey" FOREIGN KEY ("distributionHouseId") REFERENCES "distribution_house"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "distribution_points" ADD CONSTRAINT "distribution_points_territoryId_fkey" FOREIGN KEY ("territoryId") REFERENCES "territory"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "distribution_house" ADD CONSTRAINT "distribution_house_areaId_fkey" FOREIGN KEY ("areaId") REFERENCES "area"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Family" ADD CONSTRAINT "Family_segmentId_fkey" FOREIGN KEY ("segmentId") REFERENCES "Segment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "final_submit" ADD CONSTRAINT "final_submit_businessDateId_fkey" FOREIGN KEY ("businessDateId") REFERENCES "business_date"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "final_submit" ADD CONSTRAINT "final_submit_sectionId_fkey" FOREIGN KEY ("sectionId") REFERENCES "section"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "final_submit" ADD CONSTRAINT "final_submit_roueteId_fkey" FOREIGN KEY ("roueteId") REFERENCES "routes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "final_submit" ADD CONSTRAINT "final_submit_distributionPointId_fkey" FOREIGN KEY ("distributionPointId") REFERENCES "distribution_points"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "outlet_name" ADD CONSTRAINT "outlet_name_distributionPointsId_fkey" FOREIGN KEY ("distributionPointsId") REFERENCES "distribution_points"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "own_point_distribution" ADD CONSTRAINT "own_point_distribution_distributionPointId_fkey" FOREIGN KEY ("distributionPointId") REFERENCES "distribution_points"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "own_point_distribution" ADD CONSTRAINT "own_point_distribution_sttSkuId_fkey" FOREIGN KEY ("sttSkuId") REFERENCES "stt_sku"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "route_wise_memo" ADD CONSTRAINT "route_wise_memo_distributionPointId_fkey" FOREIGN KEY ("distributionPointId") REFERENCES "distribution_points"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "route_wise_memo" ADD CONSTRAINT "route_wise_memo_businessDateId_fkey" FOREIGN KEY ("businessDateId") REFERENCES "business_date"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "route_wise_memo" ADD CONSTRAINT "route_wise_memo_sttSkuId_fkey" FOREIGN KEY ("sttSkuId") REFERENCES "stt_sku"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "route_wise_stt" ADD CONSTRAINT "route_wise_stt_businessDateId_fkey" FOREIGN KEY ("businessDateId") REFERENCES "business_date"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "routes" ADD CONSTRAINT "routes_distributionPointsId_fkey" FOREIGN KEY ("distributionPointsId") REFERENCES "distribution_points"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sales_plan" ADD CONSTRAINT "sales_plan_pointId_fkey" FOREIGN KEY ("pointId") REFERENCES "distribution_points"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sales_summary_statement" ADD CONSTRAINT "sales_summary_statement_businessDateId_fkey" FOREIGN KEY ("businessDateId") REFERENCES "business_date"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sales_summary_statement" ADD CONSTRAINT "sales_summary_statement_sectionId_fkey" FOREIGN KEY ("sectionId") REFERENCES "section"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "shipment_orders" ADD CONSTRAINT "shipment_orders_distributionHouseId_fkey" FOREIGN KEY ("distributionHouseId") REFERENCES "distribution_house"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "shipment_orders" ADD CONSTRAINT "shipment_orders_shipmentSkuId_fkey" FOREIGN KEY ("shipmentSkuId") REFERENCES "ShipmentSku"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stock_management" ADD CONSTRAINT "stock_management_stockManagementSkuId_fkey" FOREIGN KEY ("stockManagementSkuId") REFERENCES "stock_management_sku"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stock_management" ADD CONSTRAINT "stock_management_businessDateId_fkey" FOREIGN KEY ("businessDateId") REFERENCES "business_date"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stt_sku" ADD CONSTRAINT "stt_sku_brandId_fkey" FOREIGN KEY ("brandId") REFERENCES "Brand"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stt_sku" ADD CONSTRAINT "stt_sku_familyId_fkey" FOREIGN KEY ("familyId") REFERENCES "Family"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stt_sku" ADD CONSTRAINT "stt_sku_segmentId_fkey" FOREIGN KEY ("segmentId") REFERENCES "Segment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "territory" ADD CONSTRAINT "territory_areaId_fkey" FOREIGN KEY ("areaId") REFERENCES "area"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_OutletNameToRoutes" ADD CONSTRAINT "_OutletNameToRoutes_A_fkey" FOREIGN KEY ("A") REFERENCES "outlet_name"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_OutletNameToRoutes" ADD CONSTRAINT "_OutletNameToRoutes_B_fkey" FOREIGN KEY ("B") REFERENCES "routes"("id") ON DELETE CASCADE ON UPDATE CASCADE;
