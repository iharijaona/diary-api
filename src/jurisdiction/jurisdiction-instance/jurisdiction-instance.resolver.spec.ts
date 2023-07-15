import { Test, TestingModule } from '@nestjs/testing';
import { JurisdictionInstanceResolver } from './jurisdiction-instance.resolver';
import { JurisdictionInstanceService } from './jurisdiction-instance.service';

describe('JurisdictionInstanceResolver', () => {
  let resolver: JurisdictionInstanceResolver;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [JurisdictionInstanceResolver, JurisdictionInstanceService],
    }).compile();

    resolver = module.get<JurisdictionInstanceResolver>(JurisdictionInstanceResolver);
  });

  it('should be defined', () => {
    expect(resolver).toBeDefined();
  });
});
