import { Resolver, Query, Args, ID } from '@nestjs/graphql';
import { NotFoundException } from '@nestjs/common';
import { CountryService } from './country.service';
import { Country, PaginatedCountry } from './entities/country.entity';
import { CountryQueryArgs } from './dto/query-country.args';

@Resolver(() => Country)
export class CountryResolver {
  constructor(private readonly countryService: CountryService) {}

  @Query(() => Country)
  async country(
    @Args('code', { type: () => ID }) code: string,
  ): Promise<Country> {
    const country = await this.countryService.findOneCountry(code);
    if (!country) {
      throw new NotFoundException(code);
    }
    return country;
  }

  @Query(() => PaginatedCountry)
  async countries(@Args() args: CountryQueryArgs): Promise<PaginatedCountry> {
    return this.countryService.findAllCountry(args);
  }
}
