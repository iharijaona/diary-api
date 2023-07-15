import { Module } from '@nestjs/common';
import { PrismaService } from 'src/prisma.service';
import { JurisdictionInstanceService } from './jurisdiction-instance.service';
import { JurisdictionInstanceResolver } from './jurisdiction-instance.resolver';
import { LocationModule } from 'src/geolocation/location/location.module';
import { JurisdictionLevelModule } from '../jurisdiction-level/jurisdiction-level.module';

@Module({
  providers: [
    PrismaService,
    JurisdictionInstanceResolver,
    JurisdictionInstanceService,
  ],
  imports: [LocationModule, JurisdictionLevelModule]
})
export class JurisdictionInstanceModule {}
