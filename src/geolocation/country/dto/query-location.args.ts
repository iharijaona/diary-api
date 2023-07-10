import { ArgsType, Field, Int, InputType } from '@nestjs/graphql';
import { Max, Min } from 'class-validator';
import { PageArgs, EnumSortOrder } from 'src/common/query.metadata';

@InputType()
export class CountryOrderByInput {
  @Field((type) => EnumSortOrder, { nullable: true })
  name?: EnumSortOrder

  @Field((type) => EnumSortOrder, { nullable: true })
  nationality?: EnumSortOrder

  @Field((type) => EnumSortOrder, { nullable: true })
  alpha2Code?: EnumSortOrder

  @Field((type) => EnumSortOrder, { nullable: true })
  alpha3Code?: EnumSortOrder
}

@ArgsType()
export class CountryQueryArgs extends PageArgs {
  @Field((type) => Int)
  @Min(1)
  @Max(2000)
  take = 100;

  @Field({ nullable: true })
  filter?: string;

  @Field({ nullable: true })
  orderBy?: CountryOrderByInput
}

