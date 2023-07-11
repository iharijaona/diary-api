import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { decodeId, encodeId } from 'src/common/hashids.helper';
import { PrismaService } from 'src/prisma.service';
import { Country, PaginatedCountry } from './entities/country.entity';
import { CountryQueryArgs } from './dto/query-country.args';

@Injectable()
export class CountryService {
  constructor(private prisma: PrismaService) {}

  async findAllCountry(args: CountryQueryArgs): Promise<PaginatedCountry> {
    // Filter
    const whereFilter: Prisma.CountryWhereInput = args.filter
      ? {
          OR: [
            { name: { contains: args.filter, mode: 'insensitive' } },
            { name_fr: { contains: args.filter, mode: 'insensitive' } },
            { name_en: { contains: args.filter, mode: 'insensitive' } },
            { nationality: { contains: args.filter, mode: 'insensitive' } },
            { nationality_en: { contains: args.filter, mode: 'insensitive' } },
          ],
        }
      : {};

    // Compute pagination metadata
    const totalItemCount = await this.prisma.country.count({
      where: whereFilter,
    });
    const totalPageCount = Math.ceil(
      totalItemCount / (args.take > 0 ? args.take : 1),
    );
    const currentPage =
      Math.floor(args.skip / (args.take > 0 ? args.take : 1)) + 1;
    const filteredCountries = await Promise.all(
      (
        await this.prisma.country.findMany({
          skip: args.skip,
          take: args.take,
          where: whereFilter,
          orderBy:
            args.orderBy as Prisma.Enumerable<Prisma.CountryOrderByWithRelationInput>,
        })
      ).map((item) => ({
        ...item,
        id: encodeId(item.id),
      })),
    );

    // Return the results
    return {
      nodes: filteredCountries,
      pageSize: args.take,
      totalPageCount,
      totalItemCount,
      currentPage,
    };
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
