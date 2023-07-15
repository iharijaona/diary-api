import { Test, TestingModule } from '@nestjs/testing';
import { JurisdictionLevelResolver } from './jurisdiction-level.resolver';
import { JurisdictionLevelService } from './jurisdiction-level.service';

describe('JurisdictionLevelResolver', () => {
  let resolver: JurisdictionLevelResolver;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [JurisdictionLevelResolver, JurisdictionLevelService],
    }).compile();

    resolver = module.get<JurisdictionLevelResolver>(JurisdictionLevelResolver);
  });

  it('should be defined', () => {
    expect(resolver).toBeDefined();
  });
});
