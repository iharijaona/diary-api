/*
  Warnings:

  - You are about to drop the `identity_proof` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `nationality` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "identity_proof" DROP CONSTRAINT "identity_proof_country_id_fkey";

-- DropForeignKey
ALTER TABLE "person" DROP CONSTRAINT "person_nationality_id_fkey";

-- DropTable
DROP TABLE "identity_proof";

-- DropTable
DROP TABLE "nationality";

-- CreateTable
CREATE TABLE "identity" (
    "id" BIGSERIAL NOT NULL,
    "person_id" BIGINT NOT NULL,
    "type" SMALLINT NOT NULL,
    "number" VARCHAR(16) NOT NULL,
    "delivery_place" VARCHAR(128),
    "delivery_date" DATE NOT NULL,
    "expiry_date" DATE,
    "country_id" SMALLINT NOT NULL,
    "is_verified" BOOLEAN DEFAULT false,
    "created_by" BIGINT,
    "created_on" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "verified_by" BIGINT,
    "verified_on" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "identity_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "person" ADD CONSTRAINT "person_nationality_id_fkey" FOREIGN KEY ("nationality_id") REFERENCES "country"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "identity" ADD CONSTRAINT "identity_country_id_fkey" FOREIGN KEY ("country_id") REFERENCES "country"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
