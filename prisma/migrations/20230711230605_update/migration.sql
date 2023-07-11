/*
  Warnings:

  - You are about to drop the column `tribunal_id` on the `deal_event` table. All the data in the column will be lost.
  - You are about to drop the column `tribunal_id` on the `deal_jurisdiction` table. All the data in the column will be lost.
  - You are about to drop the `person_contact` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `tribunal` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `tribunal_categ` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `jurisdiction_id` to the `deal_jurisdiction` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "deal_event" DROP CONSTRAINT "deal_event_tribunal_id_fkey";

-- DropForeignKey
ALTER TABLE "deal_jurisdiction" DROP CONSTRAINT "deal_jurisdiction_tribunal_id_fkey";

-- DropForeignKey
ALTER TABLE "person_contact" DROP CONSTRAINT "person_contact_person_id_fkey";

-- DropForeignKey
ALTER TABLE "tribunal" DROP CONSTRAINT "tribunal_location_id_fkey";

-- DropForeignKey
ALTER TABLE "tribunal" DROP CONSTRAINT "tribunal_tribunal_categ_id_fkey";

-- AlterTable
ALTER TABLE "deal_event" DROP COLUMN "tribunal_id",
ADD COLUMN     "jurisdiction_id" INTEGER;

-- AlterTable
ALTER TABLE "deal_jurisdiction" DROP COLUMN "tribunal_id",
ADD COLUMN     "jurisdiction_id" INTEGER NOT NULL;

-- DropTable
DROP TABLE "person_contact";

-- DropTable
DROP TABLE "tribunal";

-- DropTable
DROP TABLE "tribunal_categ";

-- CreateTable
CREATE TABLE "contact" (
    "id" BIGSERIAL NOT NULL,
    "person_id" BIGINT NOT NULL,
    "contact" VARCHAR(128) NOT NULL,
    "type" SMALLINT NOT NULL,
    "is_primary" BOOLEAN DEFAULT false,
    "is_verified" BOOLEAN DEFAULT false,
    "created_by" BIGINT,
    "created_on" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "contact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "jurisdiction_level" (
    "id" SMALLSERIAL NOT NULL,
    "name" VARCHAR(128) NOT NULL,
    "code" VARCHAR(8) NOT NULL,
    "description" VARCHAR(256),

    CONSTRAINT "jurisdiction_level_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "jurisdiction" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(128) NOT NULL,
    "jurisdiction_level_id" SMALLINT NOT NULL,
    "location_id" BIGINT NOT NULL,

    CONSTRAINT "jurisdiction_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "jurisdiction_level_name_idx" ON "jurisdiction_level" USING SPGIST ("name");

-- CreateIndex
CREATE INDEX "jurisdiction_name_idx" ON "jurisdiction" USING SPGIST ("name");

-- AddForeignKey
ALTER TABLE "contact" ADD CONSTRAINT "contact_person_id_fkey" FOREIGN KEY ("person_id") REFERENCES "person"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "jurisdiction" ADD CONSTRAINT "jurisdiction_location_id_fkey" FOREIGN KEY ("location_id") REFERENCES "location"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "jurisdiction" ADD CONSTRAINT "jurisdiction_jurisdiction_level_id_fkey" FOREIGN KEY ("jurisdiction_level_id") REFERENCES "jurisdiction_level"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "deal_jurisdiction" ADD CONSTRAINT "deal_jurisdiction_jurisdiction_id_fkey" FOREIGN KEY ("jurisdiction_id") REFERENCES "jurisdiction"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "deal_event" ADD CONSTRAINT "deal_event_jurisdiction_id_fkey" FOREIGN KEY ("jurisdiction_id") REFERENCES "jurisdiction"("id") ON DELETE SET NULL ON UPDATE CASCADE;
