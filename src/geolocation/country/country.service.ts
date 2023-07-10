import { Injectable } from '@nestjs/common';

import { decodeId, encodeId } from 'src/common/hashids.helper';
import { PrismaService } from 'src/prisma.service';
import { Country, PaginatedCountry } from './entities/country.entity';
import { CountryQueryArgs } from './dto/query-location.args';

@Injectable()
export class CountryService {

  constructor(private prisma: PrismaService) {}

  async findAllCountry(args: CountryQueryArgs): Promise<PaginatedCountry> {
    const totalItemCount = await this.prisma.country.count();
    const totalPageCount = Math.ceil(totalItemCount / (args.take > 0 ? args.take : 1)) 
    const currentPage = Math.floor(args.skip / (args.take > 0 ? args.take : 1)) + 1
    return {
      nodes: await Promise.all(
        (await this.prisma.country.findMany({ skip: args.skip, take: args.take })).map((item) => ({
          ...item,
          id: encodeId(item.id)
        })),
      ),
      pageSize: args.take,
      totalPageCount,
      totalItemCount,
      currentPage
    }
  }

  async findOneCountry(id: string): Promise<Country> {
    const country = await this.prisma.country.findUnique({
      where: { id: decodeId(id) },
    });
    return {
      ...country,
      id: encodeId(country.id),
    };
  }
}




