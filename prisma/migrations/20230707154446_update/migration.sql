/*
  Warnings:

  - You are about to drop the column `level` on the `location` table. All the data in the column will be lost.
  - Added the required column `type` to the `location` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "LocationType" AS ENUM ('PROVINCE', 'REGION', 'DISTRICT', 'MUNICIPALITY', 'NEIGHBORHOOD');

-- AlterTable
ALTER TABLE "location" DROP COLUMN "level",
ADD COLUMN     "type" "LocationType" NOT NULL;
