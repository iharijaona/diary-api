import { Resolver, Query, Args, ID } from '@nestjs/graphql';
import { JurisdictionInstanceService } from './jurisdiction-instance.service';
import { JurisdictionInstanceQueryArgs } from './dto/jurisdiction-instance.args';
import { JurisdictionInstance, PaginatedJurisdictionInstance } from './entities/jurisdiction-instance.entity';

@Resolver(() => JurisdictionInstance)
export class JurisdictionInstanceResolver {
  constructor(private readonly jurisdictionInstanceService: JurisdictionInstanceService) {}

  @Query(() => JurisdictionInstance)
  async jurisdictionInstance(@Args('id', { type: () => ID }) id: string): Promise<JurisdictionInstance> {
    const jurisdictionLevel = await this.jurisdictionInstanceService.findOneJurisdictionInstance(id);
    return jurisdictionLevel;
  }

  @Query(() => PaginatedJurisdictionInstance)
  async jurisdictionInstances(@Args() args: JurisdictionInstanceQueryArgs): Promise<PaginatedJurisdictionInstance> {
    return this.jurisdictionInstanceService.findAllJurisdictionInstances(args);
  }
  
}
