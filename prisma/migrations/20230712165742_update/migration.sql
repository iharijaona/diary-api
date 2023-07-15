/*
  Warnings:

  - You are about to drop the column `jurisdiction_level_id` on the `jurisdiction` table. All the data in the column will be lost.
  - The primary key for the `jurisdiction_level` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `description` on the `jurisdiction_level` table. All the data in the column will be lost.
  - You are about to drop the column `id` on the `jurisdiction_level` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[short_name]` on the table `jurisdiction_level` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `level_code` to the `jurisdiction` table without a default value. This is not possible if the table is not empty.
  - Added the required column `short_name` to the `jurisdiction_level` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `code` on the `jurisdiction_level` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "JurisdictionLevelCode" AS ENUM ('SUPREME_COURT', 'CASSATION_COURT', 'AUDIT_COURT', 'ADMINISTRATIVE_LAW_COURT', 'APPELLATE_COURT', 'ADMINISTRATIVE_COURT', 'FISCAL_COURT', 'TRIAL_COURT');

-- DropForeignKey
ALTER TABLE "jurisdiction" DROP CONSTRAINT "jurisdiction_jurisdiction_level_id_fkey";

-- DropIndex
DROP INDEX "jurisdiction_level_name_idx";

-- AlterTable
ALTER TABLE "jurisdiction" DROP COLUMN "jurisdiction_level_id",
ADD COLUMN     "level_code" "JurisdictionLevelCode" NOT NULL;

-- AlterTable
ALTER TABLE "jurisdiction_level" DROP CONSTRAINT "jurisdiction_level_pkey",
DROP COLUMN "description",
DROP COLUMN "id",
ADD COLUMN     "short_name" VARCHAR(8) NOT NULL,
DROP COLUMN "code",
ADD COLUMN     "code" "JurisdictionLevelCode" NOT NULL,
ADD CONSTRAINT "jurisdiction_level_pkey" PRIMARY KEY ("code");

-- CreateIndex
CREATE UNIQUE INDEX "jurisdiction_level_short_name_key" ON "jurisdiction_level"("short_name");

-- AddForeignKey
ALTER TABLE "jurisdiction" ADD CONSTRAINT "jurisdiction_level_code_fkey" FOREIGN KEY ("level_code") REFERENCES "jurisdiction_level"("code") ON DELETE RESTRICT ON UPDATE CASCADE;
