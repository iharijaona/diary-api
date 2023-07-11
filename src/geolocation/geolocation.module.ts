import { Module } from '@nestjs/common';
import { CountryModule } from './country/country.module';
import { LocationModule } from './location/location.module';

@Module({
  imports: [CountryModule, LocationModule],
})
export class GeoLocationModule {}
