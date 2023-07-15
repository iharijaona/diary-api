import { Test, TestingModule } from '@nestjs/testing';
import { JurisdictionInstanceService } from './jurisdiction-instance.service';

describe('JurisdictionInstanceService', () => {
  let service: JurisdictionInstanceService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [JurisdictionInstanceService],
    }).compile();

    service = module.get<JurisdictionInstanceService>(JurisdictionInstanceService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
