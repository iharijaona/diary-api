import {
  Resolver,
  Query,
  Args,
  ID,
  ResolveField,
  Parent,
} from '@nestjs/graphql';
import { NotFoundException } from '@nestjs/common';
import { LocationService } from './location.service';
import { Location, PaginatedLocation } from './entities/location.entity';
import { LocationQueryArgs } from './dto/query-location.args';

@Resolver(() => Location)
export class LocationResolver {
  constructor(private readonly locationService: LocationService) {}

  @Query(() => Location)
  async location(
    @Args('id', { type: () => ID }) id: string,
  ): Promise<Location> {
    const country = await this.locationService.findOneLocation(id);
    if (!country) {
      throw new NotFoundException(id);
    }
    return country;
  }

  @Query(() => PaginatedLocation)
  async locations(@Args() args: LocationQueryArgs): Promise<PaginatedLocation> {
    return this.locationService.findAllLocation(args);
  }

  @ResolveField(() => [Location])
  async subdivisions(@Parent() parentLocation: Location) {
    return this.locationService.findLocationSubdivisions(parentLocation.id);
  }
}
