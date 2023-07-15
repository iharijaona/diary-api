/*
  Warnings:

  - A unique constraint covering the columns `[name,level_code,location_id]` on the table `jurisdiction` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "jurisdiction_name_level_code_location_id_key" ON "jurisdiction"("name", "level_code", "location_id");
