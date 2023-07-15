import { PrismaClient } from '@prisma/client';
import { readFile } from 'fs/promises';
import { join } from 'path';

export async function jurisdictionSeed(prisma: PrismaClient) {
  // Seed Jurisdiction Level
  const rawJurisdictionCourts = await readFile(
    join(__dirname, 'jurisdiction-court.json'),
    { encoding: 'utf8' },
  );

  const jurisdictionCourts = JSON.parse(rawJurisdictionCourts);

  for (const court of jurisdictionCourts) {
    await prisma.jurisdictionLevel.upsert({
      where: { code: court['code'] },
      update: {},
      create: {
        code: court['code'],
        name: court['name'],
        shortName: court['short_name'],
      },
    });
  }

  // Seed Jurisdiction Level
  const rawJurisdictionData = await readFile(
    join(__dirname, 'jurisdiction-data.json'),
    { encoding: 'utf8' },
  );

  const jurisdictions = JSON.parse(rawJurisdictionData);

  for (const jurisdiction of jurisdictions) {
    const jurisdictionPayload = {
      levelCode: jurisdiction['level_code'],
      name: jurisdiction['name'],
      locationId: jurisdiction['location_id'],
    };

    await prisma.jurisdiction.upsert({
      where: {
        name_levelCode_locationId: jurisdictionPayload,
      },
      update: {},
      create: jurisdictionPayload,
    });
  }
}
