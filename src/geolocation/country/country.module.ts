import { Module } from '@nestjs/common';
import { PrismaService } from 'src/prisma.service';
import { CountryService } from './country.service';
import { CountryResolver } from './country.resolver';

@Module({
  providers: [PrismaService, CountryResolver, CountryService],
})
export class CountryModule {}
