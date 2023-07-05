-- CreateTable
CREATE TABLE "province" (
    "id" SMALLSERIAL NOT NULL,
    "name" VARCHAR(64) NOT NULL,

    CONSTRAINT "province_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "region" (
    "id" SMALLSERIAL NOT NULL,
    "name" VARCHAR(64) NOT NULL,
    "province_id" SMALLINT NOT NULL,

    CONSTRAINT "region_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "district" (
    "id" SMALLSERIAL NOT NULL,
    "name" VARCHAR(128) NOT NULL,
    "region_id" SMALLINT NOT NULL,

    CONSTRAINT "district_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "municipality" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(128) NOT NULL,
    "district_id" SMALLINT NOT NULL,

    CONSTRAINT "municipality_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "fokontany" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(256) NOT NULL,
    "municipality_id" INTEGER NOT NULL,

    CONSTRAINT "fokontany_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "address" (
    "id" BIGSERIAL NOT NULL,
    "name" VARCHAR(128) NOT NULL,
    "fokontany_id" INTEGER NOT NULL,

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
    "name" VARCHAR(32) NOT NULL,
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
CREATE TABLE "nationality" (
    "id" SMALLSERIAL NOT NULL,
    "name" VARCHAR(64) NOT NULL,

    CONSTRAINT "nationality_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "country" (
    "id" SMALLSERIAL NOT NULL,
    "name" VARCHAR(128) NOT NULL,
    "nationality" VARCHAR(128) NOT NULL,

    CONSTRAINT "country_pkey" PRIMARY KEY ("id")
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
    "nationality_id" SMALLINT,

    CONSTRAINT "person_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "identity_proof" (
    "id" BIGSERIAL NOT NULL,
    "person_id" BIGINT NOT NULL,
    "type" SMALLINT NOT NULL,
    "number" VARCHAR(16) NOT NULL,
    "delivery_place" VARCHAR(128),
    "delivery_date" DATE NOT NULL,
    "expiry_date" DATE,
    "issuer_country_id" SMALLINT NOT NULL,
    "is_verified" BOOLEAN DEFAULT false,
    "created_by" BIGINT,
    "created_on" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "verified_by" BIGINT,
    "verified_on" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "identity_proof_pkey" PRIMARY KEY ("id")
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
CREATE TABLE "person_contact" (
    "id" BIGSERIAL NOT NULL,
    "person_id" BIGINT NOT NULL,
    "contact" VARCHAR(128) NOT NULL,
    "type" SMALLINT NOT NULL,
    "is_primary" BOOLEAN DEFAULT false,
    "is_verified" BOOLEAN DEFAULT false,
    "created_by" BIGINT,
    "created_on" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "person_contact_pkey" PRIMARY KEY ("id")
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
CREATE TABLE "tribunal_categ" (
    "id" SMALLSERIAL NOT NULL,
    "name" VARCHAR(128) NOT NULL,
    "description" VARCHAR(256),

    CONSTRAINT "tribunal_categ_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tribunal" (
    "id" SERIAL NOT NULL,
    "tribunal_categ_id" SMALLINT NOT NULL,
    "district_id" SMALLINT NOT NULL,
    "name" VARCHAR(128) NOT NULL,

    CONSTRAINT "tribunal_pkey" PRIMARY KEY ("id")
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
    "tribunal_id" INTEGER NOT NULL,
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
    "tribunal_id" INTEGER,
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
CREATE UNIQUE INDEX "user_person_id_key" ON "user"("person_id");

-- CreateIndex
CREATE UNIQUE INDEX "user_username_key" ON "user"("username");

-- CreateIndex
CREATE UNIQUE INDEX "lawyer_person_id_key" ON "lawyer"("person_id");

-- AddForeignKey
ALTER TABLE "region" ADD CONSTRAINT "region_province_id_fkey" FOREIGN KEY ("province_id") REFERENCES "province"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "district" ADD CONSTRAINT "district_region_id_fkey" FOREIGN KEY ("region_id") REFERENCES "region"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "municipality" ADD CONSTRAINT "municipality_district_id_fkey" FOREIGN KEY ("district_id") REFERENCES "district"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fokontany" ADD CONSTRAINT "fokontany_municipality_id_fkey" FOREIGN KEY ("municipality_id") REFERENCES "municipality"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "address" ADD CONSTRAINT "address_fokontany_id_fkey" FOREIGN KEY ("fokontany_id") REFERENCES "fokontany"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

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
ALTER TABLE "person" ADD CONSTRAINT "person_nationality_id_fkey" FOREIGN KEY ("nationality_id") REFERENCES "nationality"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "identity_proof" ADD CONSTRAINT "identity_proof_issuer_country_id_fkey" FOREIGN KEY ("issuer_country_id") REFERENCES "country"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "person_job" ADD CONSTRAINT "person_job_person_id_fkey" FOREIGN KEY ("person_id") REFERENCES "person"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "person_job" ADD CONSTRAINT "person_job_job_id_fkey" FOREIGN KEY ("job_id") REFERENCES "job"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "person_address" ADD CONSTRAINT "person_address_person_id_fkey" FOREIGN KEY ("person_id") REFERENCES "person"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "person_address" ADD CONSTRAINT "person_address_address_id_fkey" FOREIGN KEY ("address_id") REFERENCES "address"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "person_contact" ADD CONSTRAINT "person_contact_person_id_fkey" FOREIGN KEY ("person_id") REFERENCES "person"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

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
ALTER TABLE "tribunal" ADD CONSTRAINT "tribunal_district_id_fkey" FOREIGN KEY ("district_id") REFERENCES "district"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tribunal" ADD CONSTRAINT "tribunal_tribunal_categ_id_fkey" FOREIGN KEY ("tribunal_categ_id") REFERENCES "tribunal_categ"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

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
ALTER TABLE "deal_jurisdiction" ADD CONSTRAINT "deal_jurisdiction_tribunal_id_fkey" FOREIGN KEY ("tribunal_id") REFERENCES "tribunal"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "deal_event" ADD CONSTRAINT "deal_event_deal_id_fkey" FOREIGN KEY ("deal_id") REFERENCES "deal"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "deal_event" ADD CONSTRAINT "deal_event_event_type_id_fkey" FOREIGN KEY ("event_type_id") REFERENCES "event_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "deal_event" ADD CONSTRAINT "deal_event_tribunal_id_fkey" FOREIGN KEY ("tribunal_id") REFERENCES "tribunal"("id") ON DELETE SET NULL ON UPDATE CASCADE;
