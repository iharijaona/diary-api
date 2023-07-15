import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { decodeId } from 'src/common/hashids.helper';
import { PrismaService } from 'src/prisma.service';
import { PaginatedJurisdictionInstance, JurisdictionInstance } from './entities/jurisdiction-instance.entity';
import { JurisdictionInstanceQueryArgs } from './dto/jurisdiction-instance.args';
import { JurisdictionInstanceNotFoundError } from './jurisdiction-instance.error';
import { EnumJurisdictionLevel } from '../jurisdiction-level/entities/jurisdiction-level.entity';

@Injectable()
export class JurisdictionInstanceService {

  constructor(private prisma: PrismaService) {}

  
  async findAllJurisdictionInstances(args: JurisdictionInstanceQueryArgs): Promise<PaginatedJurisdictionInstance> {

    // Filter by name and code
    let whereFilter: Prisma.JurisdictionInstanceWhereInput = args.filter
      ? {
          OR: [
            { name: { contains: args.filter, mode: 'insensitive' } },
          ],
        }
      : {};

    // Filter by level code
    whereFilter = args.levelCode ? { ...whereFilter, levelCode: EnumJurisdictionLevel[args.levelCode] } : whereFilter;

    // Filter by location id
    whereFilter = args.locationId
      ? { ...whereFilter, locationId: decodeId(args.locationId) }
      : whereFilter;


    // Compute pagination metadata
    const totalItemCount = await this.prisma.jurisdictionInstance.count({
      where: whereFilter,
    });
    const totalPageCount = Math.ceil(
      totalItemCount / (args.take > 0 ? args.take : 1),
    );
    const currentPage =
      Math.floor(args.skip / (args.take > 0 ? args.take : 1)) + 1;

    const jurisdictionInstances = await Promise.all(
      (
        await this.prisma.jurisdictionInstance.findMany({
          skip: args.skip,
          take: args.take,
          where: whereFilter,
          orderBy:
            args.orderBy as Prisma.Enumerable<Prisma.LocationOrderByWithRelationInput>,
        })
      ).map((item) => new JurisdictionInstance(item)),
    );

    // Return the results
    return {
      nodes: jurisdictionInstances,
      pageSize: args.take,
      totalPageCount,
      totalItemCount,
      currentPage,
    };

  }

  async findOneJurisdictionInstance(id: string): Promise<JurisdictionInstance> {
    try {
      const jurisdictionInstance = await this.prisma.jurisdictionInstance.findUnique({
        where: { id: decodeId(id) },
      });
      // Throw error if not exists
      if (!jurisdictionInstance) throw new JurisdictionInstanceNotFoundError(id);
      return new JurisdictionInstance(jurisdictionInstance);
    } catch (error) {
      throw new JurisdictionInstanceNotFoundError(id, error);
    }
  }
}
