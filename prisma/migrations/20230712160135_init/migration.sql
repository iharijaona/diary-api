-- CreateEnum
CREATE TYPE "LocationType" AS ENUM ('PROVINCE', 'REGION', 'DISTRICT', 'MUNICIPALITY', 'NEIGHBORHOOD');

-- CreateEnum
CREATE TYPE "RoleName" AS ENUM ('SUPERUSER', 'ADMINISTRATOR', 'SYSTEM_MANAGER', 'AGENCY_MANAGER', 'AGENCY_SECRETARY', 'LAWYER', 'USER');

-- CreateTable
CREATE TABLE "country" (
    "code" VARCHAR(8) NOT NULL,
    "alpha_3_code" VARCHAR(8) NOT NULL,
    "name_native" VARCHAR(128) NOT NULL,
    "name_en" VARCHAR(128) NOT NULL,
    "name_fr" VARCHAR(128) NOT NULL,
    "nationality_fr" VARCHAR(128) NOT NULL,
    "nationality_en" VARCHAR(128) NOT NULL,
    "currency_code" VARCHAR(8),
    "phone_prefix" VARCHAR(8),

    CONSTRAINT "country_pkey" PRIMARY KEY ("code")
);

-- CreateTable
CREATE TABLE "location" (
    "id" BIGSERIAL NOT NULL,
    "name" VARCHAR(256) NOT NULL,
    "code" VARCHAR(8),
    "type" "LocationType" NOT NULL,
    "parent_id" BIGINT,
    "country_code" VARCHAR(8),

    CONSTRAINT "location_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "address" (
    "id" BIGSERIAL NOT NULL,
    "name" VARCHAR(128) NOT NULL,
    "location_id" BIGINT NOT NULL,

    CONSTRAINT "address_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "permission" (
    "id" SMALLSERIAL NOT NULL,
    "name" VARCHAR(32) NOT NULL,
    "label" VARCHAR(128) NOT NULL,

    CONSTRAINT "permission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "role" (
    "id" SMALLSERIAL NOT NULL,
    "name" "RoleName" NOT NULL,
    "label" VARCHAR(128) NOT NULL,

    CONSTRAINT "role_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "role_permission" (
    "role_id" SMALLINT NOT NULL,
    "permission_id" SMALLINT NOT NULL,

    CONSTRAINT "role_permission_pkey" PRIMARY KEY ("role_id","permission_id")
);

-- CreateTable
CREATE TABLE "user" (
    "id" BIGSERIAL NOT NULL,
    "person_id" BIGINT NOT NULL,
    "username" VARCHAR(64),
    "password" VARCHAR(128),
    "is_active" BOOLEAN DEFAULT false,
    "is_confirmed" BOOLEAN DEFAULT false,
    "password_reset_token" VARCHAR(256),
    "registration_token" VARCHAR(256),
    "confirm_token" VARCHAR(256),
    "created_by" BIGINT,
    "updated_by" BIGINT,
    "deleted_by" BIGINT,
    "created_on" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_on" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "deleted_on" TIMESTAMP(3),

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_role" (
    "user_id" BIGINT NOT NULL,
    "role_id" SMALLINT NOT NULL,

    CONSTRAINT "user_role_pkey" PRIMARY KEY ("user_id","role_id")
);

-- CreateTable
CREATE TABLE "job" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(128) NOT NULL,
    "is_other" BOOLEAN DEFAULT false,

    CONSTRAINT "job_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "person" (
    "id" BIGSERIAL NOT NULL,
    "name" VARCHAR(128),
    "first_name" VARCHAR(128),
    "last_name" VARCHAR(128),
    "birth_date" DATE,
    "birth_place" VARCHAR(128),
    "gender" SMALLINT,
    "is_human" BOOLEAN DEFAULT true,
    "created_by" BIGINT,
    "updated_by" BIGINT,
    "deleted_by" BIGINT,
    "created_on" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_on" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "deleted_on" TIMESTAMP(3),
    "nationality_code" VARCHAR(8),

    CONSTRAINT "person_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "identity" (
    "id" BIGSERIAL NOT NULL,
    "person_id" BIGINT NOT NULL,
    "type" SMALLINT NOT NULL,
    "number" VARCHAR(16) NOT NULL,
    "delivery_place" VARCHAR(128),
    "delivery_date" DATE NOT NULL,
    "expiry_date" DATE,
    "country_code" VARCHAR(8) NOT NULL,
    "is_verified" BOOLEAN DEFAULT false,
    "created_by" BIGINT,
    "created_on" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "verified_by" BIGINT,
    "verified_on" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "identity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "person_job" (
    "id" SERIAL NOT NULL,
    "person_id" BIGINT NOT NULL,
    "job_id" INTEGER NOT NULL,
    "other_job" VARCHAR(128),
    "work_place" VARCHAR(128),
    "is_current" BOOLEAN DEFAULT false,
    "created_by" BIGINT,
    "created_on" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "person_job_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "person_address" (
    "id" BIGSERIAL NOT NULL,
    "person_id" BIGINT NOT NULL,
    "address_id" BIGINT NOT NULL,
    "is_current" BOOLEAN DEFAULT false,
    "created_by" BIGINT,
    "created_on" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "person_address_pkey" PRIMARY KEY ("id")
);

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
CREATE TABLE "agency" (
    "id" SMALLSERIAL NOT NULL,
    "name" VARCHAR(128) NOT NULL,
    "created_by" BIGINT,
    "updated_by" BIGINT,
    "deleted_by" BIGINT,
    "created_on" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_on" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "deleted_on" TIMESTAMP(3),

    CONSTRAINT "agency_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "agency_address" (
    "id" BIGSERIAL NOT NULL,
    "agency_id" SMALLINT NOT NULL,
    "address_id" BIGINT NOT NULL,
    "is_current" BOOLEAN DEFAULT false,
    "created_by" BIGINT,
    "created_on" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "agency_address_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "lawyer" (
    "id" BIGSERIAL NOT NULL,
    "person_id" BIGINT NOT NULL,
    "bio" VARCHAR(256),
    "created_by" BIGINT,
    "updated_by" BIGINT,
    "deleted_by" BIGINT,
    "created_on" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_on" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "deleted_on" TIMESTAMP(3),

    CONSTRAINT "lawyer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "agency_lawyer" (
    "id" BIGSERIAL NOT NULL,
    "agency_id" SMALLINT NOT NULL,
    "lawyer_id" BIGINT NOT NULL,
    "created_by" BIGINT,
    "deleted_by" BIGINT,
    "created_on" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deleted_on" TIMESTAMP(3),

    CONSTRAINT "agency_lawyer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "media_type" (
    "id" SMALLSERIAL NOT NULL,
    "name" VARCHAR(128) NOT NULL,
    "is_other" BOOLEAN DEFAULT false,

    CONSTRAINT "media_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "media" (
    "id" BIGSERIAL NOT NULL,
    "media_type_id" SMALLINT NOT NULL,
    "name" VARCHAR(256) NOT NULL,
    "hash" VARCHAR(256) NOT NULL,
    "ext" VARCHAR(16) NOT NULL,
    "mime" VARCHAR(16) NOT NULL,
    "url" VARCHAR(256) NOT NULL,
    "description" VARCHAR(256),
    "tag" VARCHAR(16),
    "created_by" BIGINT,
    "updated_by" BIGINT,
    "deleted_by" BIGINT,
    "created_on" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_on" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "deleted_on" TIMESTAMP(3),

    CONSTRAINT "media_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "person_picture" (
    "id" BIGSERIAL NOT NULL,
    "person_id" BIGINT NOT NULL,
    "media_id" BIGINT NOT NULL,
    "is_current" BOOLEAN DEFAULT false,
    "created_by" BIGINT,
    "created_on" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "person_picture_pkey" PRIMARY KEY ("id")
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

-- CreateTable
CREATE TABLE "deal" (
    "id" BIGSERIAL NOT NULL,
    "agency_id" SMALLINT NOT NULL,
    "num" VARCHAR(32) NOT NULL,
    "name" VARCHAR(128) NOT NULL,
    "subject" TEXT NOT NULL,
    "created_by" BIGINT,
    "updated_by" BIGINT,
    "deleted_by" BIGINT,
    "created_on" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_on" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "deleted_on" TIMESTAMP(3),

    CONSTRAINT "deal_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "deal_part" (
    "deal_id" BIGINT NOT NULL,
    "person_id" BIGINT NOT NULL,
    "is_offender" BOOLEAN DEFAULT false,
    "as_lawyer" BOOLEAN DEFAULT false,
    "created_by" BIGINT,
    "deleted_by" BIGINT,
    "created_on" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deleted_on" TIMESTAMP(3),

    CONSTRAINT "deal_part_pkey" PRIMARY KEY ("deal_id","person_id")
);

-- CreateTable
CREATE TABLE "deal_comment" (
    "id" BIGSERIAL NOT NULL,
    "deal_id" BIGINT NOT NULL,
    "comment" TEXT NOT NULL,
    "created_by" BIGINT,
    "updated_by" BIGINT,
    "deleted_by" BIGINT,
    "created_on" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_on" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "deleted_on" TIMESTAMP(3),

    CONSTRAINT "deal_comment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "deal_attachment" (
    "deal_id" BIGINT NOT NULL,
    "media_id" BIGINT NOT NULL,

    CONSTRAINT "deal_attachment_pkey" PRIMARY KEY ("deal_id","media_id")
);

-- CreateTable
CREATE TABLE "deal_jurisdiction" (
    "id" BIGSERIAL NOT NULL,
    "deal_id" BIGINT NOT NULL,
    "jurisdiction_id" INTEGER NOT NULL,
    "is_current" BOOLEAN DEFAULT false,
    "created_by" BIGINT,
    "created_on" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "deal_jurisdiction_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "event_type" (
    "id" SMALLSERIAL NOT NULL,
    "name" VARCHAR(128) NOT NULL,
    "description" VARCHAR(256),
    "is_other" BOOLEAN DEFAULT false,

    CONSTRAINT "event_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "deal_event" (
    "id" BIGSERIAL NOT NULL,
    "name" VARCHAR(128) NOT NULL,
    "description" VARCHAR(256),
    "event_type_id" SMALLINT NOT NULL,
    "deal_id" BIGINT NOT NULL,
    "jurisdiction_id" INTEGER,
    "start_date" TIMESTAMP(3),
    "end_date" TIMESTAMP(3),
    "created_by" BIGINT,
    "updated_by" BIGINT,
    "deleted_by" BIGINT,
    "created_on" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_on" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "deleted_on" TIMESTAMP(3),

    CONSTRAINT "deal_event_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "role_name_key" ON "role"("name");

-- CreateIndex
CREATE UNIQUE INDEX "user_person_id_key" ON "user"("person_id");

-- CreateIndex
CREATE UNIQUE INDEX "user_username_key" ON "user"("username");

-- CreateIndex
CREATE UNIQUE INDEX "lawyer_person_id_key" ON "lawyer"("person_id");

-- CreateIndex
CREATE INDEX "jurisdiction_level_name_idx" ON "jurisdiction_level" USING SPGIST ("name");

-- CreateIndex
CREATE INDEX "jurisdiction_name_idx" ON "jurisdiction" USING SPGIST ("name");

-- AddForeignKey
ALTER TABLE "location" ADD CONSTRAINT "location_country_code_fkey" FOREIGN KEY ("country_code") REFERENCES "country"("code") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "location" ADD CONSTRAINT "location_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "location"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "address" ADD CONSTRAINT "address_location_id_fkey" FOREIGN KEY ("location_id") REFERENCES "location"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "role_permission" ADD CONSTRAINT "role_permission_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "role"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "role_permission" ADD CONSTRAINT "role_permission_permission_id_fkey" FOREIGN KEY ("permission_id") REFERENCES "permission"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user" ADD CONSTRAINT "user_person_id_fkey" FOREIGN KEY ("person_id") REFERENCES "person"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_role" ADD CONSTRAINT "user_role_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_role" ADD CONSTRAINT "user_role_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "role"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "person" ADD CONSTRAINT "person_nationality_code_fkey" FOREIGN KEY ("nationality_code") REFERENCES "country"("code") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "identity" ADD CONSTRAINT "identity_country_code_fkey" FOREIGN KEY ("country_code") REFERENCES "country"("code") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "person_job" ADD CONSTRAINT "person_job_person_id_fkey" FOREIGN KEY ("person_id") REFERENCES "person"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "person_job" ADD CONSTRAINT "person_job_job_id_fkey" FOREIGN KEY ("job_id") REFERENCES "job"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "person_address" ADD CONSTRAINT "person_address_person_id_fkey" FOREIGN KEY ("person_id") REFERENCES "person"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "person_address" ADD CONSTRAINT "person_address_address_id_fkey" FOREIGN KEY ("address_id") REFERENCES "address"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contact" ADD CONSTRAINT "contact_person_id_fkey" FOREIGN KEY ("person_id") REFERENCES "person"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "agency_address" ADD CONSTRAINT "agency_address_agency_id_fkey" FOREIGN KEY ("agency_id") REFERENCES "agency"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "agency_address" ADD CONSTRAINT "agency_address_address_id_fkey" FOREIGN KEY ("address_id") REFERENCES "address"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lawyer" ADD CONSTRAINT "lawyer_person_id_fkey" FOREIGN KEY ("person_id") REFERENCES "person"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "agency_lawyer" ADD CONSTRAINT "agency_lawyer_agency_id_fkey" FOREIGN KEY ("agency_id") REFERENCES "agency"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "agency_lawyer" ADD CONSTRAINT "agency_lawyer_lawyer_id_fkey" FOREIGN KEY ("lawyer_id") REFERENCES "lawyer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "media" ADD CONSTRAINT "media_media_type_id_fkey" FOREIGN KEY ("media_type_id") REFERENCES "media_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "person_picture" ADD CONSTRAINT "person_picture_person_id_fkey" FOREIGN KEY ("person_id") REFERENCES "person"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "person_picture" ADD CONSTRAINT "person_picture_media_id_fkey" FOREIGN KEY ("media_id") REFERENCES "media"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "jurisdiction" ADD CONSTRAINT "jurisdiction_location_id_fkey" FOREIGN KEY ("location_id") REFERENCES "location"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "jurisdiction" ADD CONSTRAINT "jurisdiction_jurisdiction_level_id_fkey" FOREIGN KEY ("jurisdiction_level_id") REFERENCES "jurisdiction_level"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "deal" ADD CONSTRAINT "deal_agency_id_fkey" FOREIGN KEY ("agency_id") REFERENCES "agency"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "deal_part" ADD CONSTRAINT "deal_part_deal_id_fkey" FOREIGN KEY ("deal_id") REFERENCES "deal"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "deal_part" ADD CONSTRAINT "deal_part_person_id_fkey" FOREIGN KEY ("person_id") REFERENCES "person"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "deal_comment" ADD CONSTRAINT "deal_comment_deal_id_fkey" FOREIGN KEY ("deal_id") REFERENCES "deal"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "deal_attachment" ADD CONSTRAINT "deal_attachment_deal_id_fkey" FOREIGN KEY ("deal_id") REFERENCES "deal"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "deal_attachment" ADD CONSTRAINT "deal_attachment_media_id_fkey" FOREIGN KEY ("media_id") REFERENCES "media"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "deal_jurisdiction" ADD CONSTRAINT "deal_jurisdiction_deal_id_fkey" FOREIGN KEY ("deal_id") REFERENCES "deal"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "deal_jurisdiction" ADD CONSTRAINT "deal_jurisdiction_jurisdiction_id_fkey" FOREIGN KEY ("jurisdiction_id") REFERENCES "jurisdiction"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "deal_event" ADD CONSTRAINT "deal_event_deal_id_fkey" FOREIGN KEY ("deal_id") REFERENCES "deal"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "deal_event" ADD CONSTRAINT "deal_event_event_type_id_fkey" FOREIGN KEY ("event_type_id") REFERENCES "event_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "deal_event" ADD CONSTRAINT "deal_event_jurisdiction_id_fkey" FOREIGN KEY ("jurisdiction_id") REFERENCES "jurisdiction"("id") ON DELETE SET NULL ON UPDATE CASCADE;
