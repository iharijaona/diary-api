import { Module } from '@nestjs/common';
import { PrismaService } from 'src/prisma.service';
import { JurisdictionInstanceService } from './jurisdiction-instance.service';
import { JurisdictionInstanceResolver } from './jurisdiction-instance.resolver';

@Module({
  providers: [
    PrismaService,
    JurisdictionInstanceResolver,
    JurisdictionInstanceService,
  ],
})
export class JurisdictionInstanceModule {}
