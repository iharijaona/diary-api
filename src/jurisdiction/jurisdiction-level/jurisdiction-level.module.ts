import { Module } from '@nestjs/common';
import { PrismaService } from 'src/prisma.service';
import { JurisdictionLevelService } from './jurisdiction-level.service';
import { JurisdictionLevelResolver } from './jurisdiction-level.resolver';

@Module({
  providers: [PrismaService, JurisdictionLevelResolver, JurisdictionLevelService]
})
export class JurisdictionLevelModule {}
