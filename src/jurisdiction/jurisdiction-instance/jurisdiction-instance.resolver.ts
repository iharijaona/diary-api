import { Resolver, Query, Args, ID, ResolveField, Parent } from '@nestjs/graphql';
import { JurisdictionInstanceService } from './jurisdiction-instance.service';
import { JurisdictionInstanceQueryArgs } from './dto/jurisdiction-instance.args';
import {
  JurisdictionInstance,
  PaginatedJurisdictionInstance,
} from './entities/jurisdiction-instance.entity';
import { LocationService } from 'src/geolocation/location/location.service';
import { JurisdictionLevelService } from '../jurisdiction-level/jurisdiction-level.service';
import { Location } from 'src/geolocation/location/entities/location.entity';
import { JurisdictionLevel } from '../jurisdiction-level/entities/jurisdiction-level.entity';

@Resolver(() => JurisdictionInstance)
export class JurisdictionInstanceResolver {
  constructor(
    private readonly jurisdictionInstanceService: JurisdictionInstanceService,
    private readonly locationService: LocationService,
    private readonly jurisdictionLevelService: JurisdictionLevelService
  ) {}

  @Query(() => JurisdictionInstance)
  async jurisdictionInstance(
    @Args('id', { type: () => ID }) id: string,
  ): Promise<JurisdictionInstance> {
    const jurisdictionLevel =
      await this.jurisdictionInstanceService.findOneJurisdictionInstance(id);
    return jurisdictionLevel;
  }

  @Query(() => PaginatedJurisdictionInstance)
  async jurisdictionInstances(
    @Args() args: JurisdictionInstanceQueryArgs,
  ): Promise<PaginatedJurisdictionInstance> {
    return this.jurisdictionInstanceService.findAllJurisdictionInstances(args);
  }

  @ResolveField(() => Location)
  async location(@Parent() jurisdictionInstance: JurisdictionInstance) {
    return this.locationService.findOneLocation(jurisdictionInstance.locationId);
  }

  @ResolveField(() => JurisdictionLevel)
  async level(@Parent() jurisdictionInstance: JurisdictionInstance) {
    return this.jurisdictionLevelService.findOneJurisdictionLevel(jurisdictionInstance.levelCode);
  }
}
