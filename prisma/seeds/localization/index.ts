import { PrismaClient } from '@prisma/client';
import { readFile } from 'fs/promises';
import { join } from 'path'

 
export async function localizationSeed(prisma: PrismaClient) {

  // Seed Country
  const rawCountryData = await readFile(join(__dirname, 'country-data.json')  , { encoding: 'utf8' })

  const countries = JSON.parse(rawCountryData);

  for (const country of countries) {
    await prisma.country.upsert({
      where: { id: country["id"] },
      update: {},
      create: {
        id: country["id"],
        alpha2Code: country["alpha_2_code"],
        alpha3Code: country["alpha_3_code"],
        name: country["name_native"],
        name_en: country["name_en"],
        name_fr: country["name_fr"],
        nationality: country["nationality_fr"],
        nationality_en: country["nationality_en"],
      },
    });
  }

  // Seed Location
  const rawLocationData = await readFile(join(__dirname, 'localization-data.json')  , { encoding: 'utf8' })

  const locations = JSON.parse(rawLocationData);

  for (const location of locations) {
    await prisma.location.upsert({
      where: { id: location["id"] },
      update: {},
      create: {
        id: location["id"],
        name: location["name"],
        level: location["level"],
        code: location["code"],
        countryId: location["country_id"],
        parentId: location["parent_id"],
      },
    });
  }
}