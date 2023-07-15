import { ObjectType, Field, ID, registerEnumType } from '@nestjs/graphql';
import { IsOptional, IsEnum, IsArray } from 'class-validator';
import { encodeId } from 'src/common/hashids.helper';
import { Location as LocationModel } from '@prisma/client';
import { Paginated } from 'src/common/query.metadata';

export enum EnumLocationType {
  PROVINCE = 'PROVINCE',
  REGION = 'REGION',
  DISTRICT = 'DISTRICT',
  MUNICIPALITY = 'MUNICIPALITY',
  NEIGHBORHOOD = 'NEIGHBORHOOD',
}

registerEnumType(EnumLocationType, {
  name: 'EnumLocationType',
  description: 'Type of location.',
});

@ObjectType()
export class Location {
  @Field(() => ID, { description: 'Hashed unique ID of the location' })
  id: string;

  @Field((type) => String, { description: 'Name of the location' })
  name: string;

  @Field(() => String, {
    nullable: true,
    description: 'Code of the location',
  })
  @IsOptional()
  code?: string;

  @Field(() => EnumLocationType, { description: 'Type of the location' })
  @IsEnum(EnumLocationType)
  type: EnumLocationType;

  @Field((type) => ID, { nullable: true, description: 'Parent location ID' })
  @IsOptional()
  parentId: string;

  @Field(() => ID, {
    nullable: true,
    description: 'ID of the country (for STATE/PROVINCE)',
  })
  @IsOptional()
  countryCode: string;

  @Field(() => [Location], { nullable: false })
  @IsArray()
  @IsOptional()
  subdivisions?: Location[];

  constructor(payload: LocationModel) {
    Object.assign(this, {
      ...payload,
      id: encodeId(payload.id),
      countryCode: payload.countryCode,
      parentId: payload.parentId && encodeId(payload.parentId),
      type: EnumLocationType[payload.type],
    });
  }
}

@ObjectType({ description: 'Paginated location list' })
export class PaginatedLocation extends Paginated(Location) {}
