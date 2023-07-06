/*
  Warnings:

  - You are about to drop the column `fokontany_id` on the `address` table. All the data in the column will be lost.
  - You are about to drop the column `issuer_country_id` on the `identity_proof` table. All the data in the column will be lost.
  - You are about to drop the column `district_id` on the `tribunal` table. All the data in the column will be lost.
  - You are about to drop the `district` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `fokontany` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `municipality` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `province` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `region` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `location_id` to the `address` table without a default value. This is not possible if the table is not empty.
  - Added the required column `country_id` to the `identity_proof` table without a default value. This is not possible if the table is not empty.
  - Added the required column `location_id` to the `tribunal` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "address" DROP CONSTRAINT "address_fokontany_id_fkey";

-- DropForeignKey
ALTER TABLE "district" DROP CONSTRAINT "district_region_id_fkey";

-- DropForeignKey
ALTER TABLE "fokontany" DROP CONSTRAINT "fokontany_municipality_id_fkey";

-- DropForeignKey
ALTER TABLE "identity_proof" DROP CONSTRAINT "identity_proof_issuer_country_id_fkey";

-- DropForeignKey
ALTER TABLE "municipality" DROP CONSTRAINT "municipality_district_id_fkey";

-- DropForeignKey
ALTER TABLE "region" DROP CONSTRAINT "region_province_id_fkey";

-- DropForeignKey
ALTER TABLE "tribunal" DROP CONSTRAINT "tribunal_district_id_fkey";

-- AlterTable
ALTER TABLE "address" DROP COLUMN "fokontany_id",
ADD COLUMN     "location_id" BIGINT NOT NULL;

-- AlterTable
ALTER TABLE "identity_proof" DROP COLUMN "issuer_country_id",
ADD COLUMN     "country_id" SMALLINT NOT NULL;

-- AlterTable
ALTER TABLE "tribunal" DROP COLUMN "district_id",
ADD COLUMN     "location_id" BIGINT NOT NULL;

-- DropTable
DROP TABLE "district";

-- DropTable
DROP TABLE "fokontany";

-- DropTable
DROP TABLE "municipality";

-- DropTable
DROP TABLE "province";

-- DropTable
DROP TABLE "region";

-- CreateTable
CREATE TABLE "location" (
    "id" BIGSERIAL NOT NULL,
    "name" VARCHAR(128) NOT NULL,
    "code" VARCHAR(8),
    "level" SMALLINT NOT NULL,
    "parent_id" BIGINT,
    "country_id" SMALLINT,

    CONSTRAINT "location_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "location" ADD CONSTRAINT "location_country_id_fkey" FOREIGN KEY ("country_id") REFERENCES "country"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "location" ADD CONSTRAINT "location_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "location"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "address" ADD CONSTRAINT "address_location_id_fkey" FOREIGN KEY ("location_id") REFERENCES "location"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "identity_proof" ADD CONSTRAINT "identity_proof_country_id_fkey" FOREIGN KEY ("country_id") REFERENCES "country"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tribunal" ADD CONSTRAINT "tribunal_location_id_fkey" FOREIGN KEY ("location_id") REFERENCES "location"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
