import { ArgsType, Field, Int, ID, InputType } from '@nestjs/graphql';
import {
  Max,
  Min,
  IsString,
  IsOptional,
  IsObject,
  IsEnum,
} from 'class-validator';
import { PageArgs, EnumSortOrder } from 'src/common/query.metadata';
import { EnumJurisdictionLevel } from 'src/jurisdiction/jurisdiction-level/entities/jurisdiction-level.entity';

@InputType()
export class JurisdictionInstanceOrderByInput {
  @Field(() => EnumSortOrder, { nullable: true })
  @IsOptional()
  name?: EnumSortOrder;

  @Field(() => EnumSortOrder, { nullable: true })
  @IsOptional()
  levelCode?: EnumSortOrder;
}

@ArgsType()
export class JurisdictionInstanceQueryArgs extends PageArgs {
  @Field(() => Int)
  @Min(1)
  @Max(2000)
  take = 100;

  @Field(() => String, { nullable: true })
  @IsString()
  @IsOptional()
  filter?: string;

  @Field(() => JurisdictionInstanceOrderByInput, { nullable: true })
  @IsObject()
  @IsOptional()
  orderBy?: JurisdictionInstanceOrderByInput;

  @Field(() => EnumJurisdictionLevel, {
    nullable: true,
    description: 'Code of the jurisdiction level',
  })
  @IsEnum(EnumJurisdictionLevel)
  @IsOptional()
  levelCode?: EnumJurisdictionLevel;

  @Field(() => ID, {
    nullable: true,
    description: 'Hashed unique ID of the location',
  })
  @IsString()
  @IsOptional()
  locationId?: string;
}
