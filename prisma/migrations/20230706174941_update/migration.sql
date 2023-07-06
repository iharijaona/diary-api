/*
  Warnings:

  - You are about to drop the column `name` on the `country` table. All the data in the column will be lost.
  - You are about to drop the column `nationality` on the `country` table. All the data in the column will be lost.
  - Added the required column `alpha_2_code` to the `country` table without a default value. This is not possible if the table is not empty.
  - Added the required column `alpha_3_code` to the `country` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name_en` to the `country` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name_fr` to the `country` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name_native` to the `country` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nationality_en` to the `country` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nationality_fr` to the `country` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "country" DROP COLUMN "name",
DROP COLUMN "nationality",
ADD COLUMN     "alpha_2_code" VARCHAR(8) NOT NULL,
ADD COLUMN     "alpha_3_code" VARCHAR(8) NOT NULL,
ADD COLUMN     "name_en" VARCHAR(128) NOT NULL,
ADD COLUMN     "name_fr" VARCHAR(128) NOT NULL,
ADD COLUMN     "name_native" VARCHAR(128) NOT NULL,
ADD COLUMN     "nationality_en" VARCHAR(128) NOT NULL,
ADD COLUMN     "nationality_fr" VARCHAR(128) NOT NULL;
