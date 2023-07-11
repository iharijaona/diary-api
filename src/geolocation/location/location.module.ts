import { Module } from '@nestjs/common';
import { PrismaService } from 'src/prisma.service';
import { LocationService } from './location.service';
import { LocationResolver } from './location.resolver';

@Module({
  providers: [PrismaService, LocationResolver, LocationService],
})
export class LocationModule {}
