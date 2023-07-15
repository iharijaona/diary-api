import { NotFoundException } from '@nestjs/common';
import { Resolver, Query, Args } from '@nestjs/graphql';
import { JurisdictionLevelService } from './jurisdiction-level.service';
import {
  JurisdictionLevel,
  EnumJurisdictionLevel,
} from './entities/jurisdiction-level.entity';

@Resolver(() => JurisdictionLevel)
export class JurisdictionLevelResolver {
  constructor(
    private readonly jurisdictionLevelService: JurisdictionLevelService,
  ) {}

  @Query(() => JurisdictionLevel)
  async jurisdictionLevel(
    @Args('code', { type: () => EnumJurisdictionLevel }) code: string,
  ): Promise<JurisdictionLevel> {
    const jurisdictionLevel =
      await this.jurisdictionLevelService.findOneJurisdictionLevel(code);
    if (!jurisdictionLevel) {
      throw new NotFoundException(code);
    }
    return jurisdictionLevel;
  }

  @Query(() => [JurisdictionLevel])
  async jurisdictionLevels(): Promise<JurisdictionLevel[]> {
    return this.jurisdictionLevelService.findAllJurisdictionLevel();
  }
}
