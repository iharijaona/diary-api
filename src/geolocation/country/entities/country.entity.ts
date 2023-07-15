import { Field, ID, ObjectType } from '@nestjs/graphql';
import { Paginated } from 'src/common/query.metadata';

@ObjectType({ description: 'A country of the world' })
export class Country {
  @Field((type) => ID, { description: 'Two-letter codes (ISO alpha-2)' })
  code: string;

  @Field((type) => String, { description: 'Three-letter codes (ISO alpha-3) ' })
  alpha3Code: string;

  @Field((type) => String, { description: 'The original country name' })
  name: string;

  @Field((type) => String, { description: 'Country name in english' })
  name_en: string;

  @Field((type) => String, { description: 'Nom du pay en français' })
  name_fr: string;

  @Field((type) => String, { description: 'Nationalité en français' })
  nationality: string;

  @Field((type) => String, { description: 'Nationality in english' })
  nationality_en: string;

  @Field((type) => String, {
    nullable: true,
    description: 'Currency code of the country',
  })
  currencyCode?: string;

  @Field((type) => String, {
    nullable: true,
    description: 'Phone prefix of the country',
  })
  phonePrefix?: string;
}

@ObjectType({ description: 'Paginated country list' })
export class PaginatedCountry extends Paginated(Country) {}
