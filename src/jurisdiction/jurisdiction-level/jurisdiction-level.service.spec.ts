import { Test, TestingModule } from '@nestjs/testing';
import { JurisdictionLevelService } from './jurisdiction-level.service';

describe('JurisdictionLevelService', () => {
  let service: JurisdictionLevelService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [JurisdictionLevelService],
    }).compile();

    service = module.get<JurisdictionLevelService>(JurisdictionLevelService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
