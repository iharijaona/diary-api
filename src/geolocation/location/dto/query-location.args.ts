import { ArgsType, Field, Int, ID, InputType } from '@nestjs/graphql';
import { Max, Min, IsString, IsOptional, IsObject } from 'class-validator';
import { PageArgs, EnumSortOrder } from 'src/common/query.metadata';
import { EnumLocationType } from '../entities/location.entity';

@InputType()
export class LocationOrderByInput {
  @Field(() => EnumSortOrder, { nullable: true })
  @IsOptional()
  id?: EnumSortOrder;

  @Field(() => EnumSortOrder, { nullable: true })
  @IsOptional()
  name?: EnumSortOrder;

  @Field(() => EnumSortOrder, { nullable: true })
  @IsOptional()
  code?: EnumSortOrder;
}

@ArgsType()
export class LocationQueryArgs extends PageArgs {
  @Field(() => Int)
  @Min(1)
  @Max(2000)
  take = 100;

  @Field({ nullable: true })
  @IsString()
  @IsOptional()
  filter?: string;

  @Field({ nullable: true })
  @IsObject()
  @IsOptional()
  orderBy?: LocationOrderByInput;

  @Field(() => EnumLocationType, { nullable: true })
  @IsOptional()
  type?: EnumLocationType;

  @Field(() => ID, { nullable: true })
  @IsOptional()
  parentId?: string;

  @Field(() => ID, { nullable: true })
  @IsOptional()
  countryCode?: string;
}
