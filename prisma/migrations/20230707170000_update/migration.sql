/*
  Warnings:

  - Changed the type of `name` on the `role` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "RoleName" AS ENUM ('SUPERUSER', 'ADMINISTRATOR', 'SYSTEM_MANAGER', 'AGENCY_MANAGER', 'AGENCY_SECRETARY', 'LAWYER', 'USER');

-- AlterTable
ALTER TABLE "role" DROP COLUMN "name",
ADD COLUMN     "name" "RoleName" NOT NULL;
