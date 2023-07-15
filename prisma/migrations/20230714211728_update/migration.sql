/*
  Warnings:

  - Added the required column `name_feminine` to the `job` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "job" ADD COLUMN     "name_feminine" VARCHAR(128) NOT NULL;
