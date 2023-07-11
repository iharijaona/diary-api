import { ArgsType, Field, Int, InputType } from '@nestjs/graphql';
import { Max, Min, IsString, IsOptional, IsObject } from 'class-validator';
import { PageArgs, EnumSortOrder } from 'src/common/query.metadata';

@InputType()
export class CountryOrderByInput {
  @Field((type) => EnumSortOrder, { nullable: true })
  @IsOptional()
  name?: EnumSortOrder

  @Field((type) => EnumSortOrder, { nullable: true })
  @IsOptional()
  nationality?: EnumSortOrder

  @Field((type) => EnumSortOrder, { nullable: true })
  @IsOptional()
  alpha2Code?: EnumSortOrder

  @Field((type) => EnumSortOrder, { nullable: true })
  @IsOptional()
  alpha3Code?: EnumSortOrder
}

@ArgsType()
export class CountryQueryArgs extends PageArgs {
  @Field((type) => Int)
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
  orderBy?: CountryOrderByInput
}

