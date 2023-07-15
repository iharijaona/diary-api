import { ObjectType, Field, ID, } from '@nestjs/graphql';
import { IsEnum, IsString, IsObject } from 'class-validator';
import { encodeId } from 'src/common/hashids.helper';
import { JurisdictionInstance as JurisdictionInstanceModel } from '@prisma/client';
import { Paginated } from 'src/common/query.metadata';
import { EnumJurisdictionLevel, JurisdictionLevel } from 'src/jurisdiction/jurisdiction-level/entities/jurisdiction-level.entity';
import { Location } from 'src/geolocation/location/entities/location.entity';

@ObjectType()
export class JurisdictionInstance {
  @Field(() => ID, { description: 'Hashed unique ID of the jurisdiction instance' })
  id: string;

  @Field(() => String, { description: 'Name of the jurisdiction instance' })
  @IsString()
  name: string;

  @Field(() => EnumJurisdictionLevel, { description: 'Code of the jurisdiction level' })
  @IsEnum(EnumJurisdictionLevel)
  levelCode: EnumJurisdictionLevel;

  @Field(() => ID, { description: 'Hashed unique ID of the location' })
  @IsString()
  locationId: string;

  @Field(() => Location, { nullable: true, description: 'Location object' })
  @IsObject()
  location?: Location

  @Field(() => JurisdictionLevel, { nullable: true, description: 'Jurisdiction level object' })
  @IsObject()
  level?: JurisdictionLevel

  constructor(payload: JurisdictionInstanceModel) {
    Object.assign(this, {
      ...payload,
      id: encodeId(payload.id),
      locationId: payload.locationId && encodeId(payload.locationId),
    });
  }
}

@ObjectType({ description: 'Paginated jurisdiction instance list' })
export class PaginatedJurisdictionInstance extends Paginated(JurisdictionInstance) {}