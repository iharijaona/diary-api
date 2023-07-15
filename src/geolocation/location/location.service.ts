import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { decodeId } from 'src/common/hashids.helper';
import { PrismaService } from 'src/prisma.service';
import { Location, PaginatedLocation } from './entities/location.entity';
import { LocationQueryArgs } from './dto/query-location.args';

@Injectable()
export class LocationService {
  constructor(private prisma: PrismaService) {}

  async findAllLocation(args: LocationQueryArgs): Promise<PaginatedLocation> {
    // Filter by name and code
    let whereFilter: Prisma.LocationWhereInput = args.filter
      ? {
          OR: [
            { name: { contains: args.filter, mode: 'insensitive' } },
            { code: { contains: args.filter, mode: 'insensitive' } },
          ],
        }
      : {};

    // Filter by type
    whereFilter = args.type ? { ...whereFilter, type: args.type } : whereFilter;

    // Filter by country id
    whereFilter = args.countryCode
      ? { ...whereFilter, countryCode: args.countryCode }
      : whereFilter;

    // Filter by parent id
    whereFilter = args.parentId
      ? { ...whereFilter, parentId: decodeId(args.parentId) }
      : whereFilter;

    // Compute pagination metadata
    const totalItemCount = await this.prisma.location.count({
      where: whereFilter,
    });
    const totalPageCount = Math.ceil(
      totalItemCount / (args.take > 0 ? args.take : 1),
    );
    const currentPage =
      Math.floor(args.skip / (args.take > 0 ? args.take : 1)) + 1;
    const filteredLocations = await Promise.all(
      (
        await this.prisma.location.findMany({
          skip: args.skip,
          take: args.take,
          where: whereFilter,
          orderBy:
            args.orderBy as Prisma.Enumerable<Prisma.LocationOrderByWithRelationInput>,
        })
      ).map((item) => new Location(item)),
    );

    // Return the results
    return {
      nodes: filteredLocations,
      pageSize: args.take,
      totalPageCount,
      totalItemCount,
      currentPage,
    };
  }

  async findOneLocation(id: string): Promise<Location> {
    const locationRaw = await this.prisma.location.findUnique({
      where: { id: decodeId(id) },
    });
    return new Location(locationRaw);
  }

  async findLocationSubdivisions(parentId: string): Promise<Location[]> {
    return await Promise.all(
      (
        await this.prisma.location.findMany({
          where: { parentId: decodeId(parentId) },
        })
      ).map((item) => new Location(item)),
    );
  }
}
