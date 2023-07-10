import { Resolver, Query, Args, ID } from '@nestjs/graphql';
import { NotFoundException } from '@nestjs/common';
import { CountryService } from './country.service';
import { Country, PaginatedCountry } from './entities/country.entity';
import { CountryQueryArgs } from './dto/query-location.args';


@Resolver(() => Country)
export class CountryResolver {
  constructor(private readonly countryService: CountryService) {}

  @Query(() => Country)
  async country(
    @Args('id', { type: () => ID }) id: string,
  ): Promise<Country> {
    const country = await this.countryService.findOneCountry(id);
    if (!country) {
      throw new NotFoundException(id);
    }
    return country;
  }

  @Query(() => PaginatedCountry)
  countries(@Args() args: CountryQueryArgs): Promise<PaginatedCountry> {
    return this.countryService.findAllCountry(args);
  }
}
