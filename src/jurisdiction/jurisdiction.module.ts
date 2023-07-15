import { Module } from '@nestjs/common';
import { JurisdictionLevelModule } from './jurisdiction-level/jurisdiction-level.module';
import { JurisdictionInstanceModule } from './jurisdiction-instance/jurisdiction-instance.module';

@Module({
  imports: [JurisdictionLevelModule, JurisdictionInstanceModule]
})
export class JurisdictionModule {}
