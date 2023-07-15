import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma.service';
import {
  JurisdictionLevel,
  EnumJurisdictionLevel,
} from './entities/jurisdiction-level.entity';

@Injectable()
export class JurisdictionLevelService {
  constructor(private prisma: PrismaService) {}

  async findAllJurisdictionLevel(): Promise<JurisdictionLevel[]> {
    const jurisdictionLevels = await this.prisma.jurisdictionLevel.findMany();
    // Return the results
    return await jurisdictionLevels.map((item) => new JurisdictionLevel(item));
  }

  async findOneJurisdictionLevel(code: string): Promise<JurisdictionLevel> {
    const jurisdictionLevel = await this.prisma.jurisdictionLevel.findUnique({
      where: { code: EnumJurisdictionLevel[code] },
    });
    return new JurisdictionLevel(jurisdictionLevel);
  }
}
