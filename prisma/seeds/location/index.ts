import { PrismaClient } from '@prisma/client';
import { readFile } from 'fs/promises';
import { join } from 'path'

 
export async function locationSeed(prisma: PrismaClient) {

  // Seed Country
  const rawCountryData = await readFile(join(__dirname, 'country-data.json')  , { encoding: 'utf8' })

  const countries = JSON.parse(rawCountryData);

  for (const country of countries) {
    try{
      await prisma.country.upsert({
        where: { code: country["code"] },
        update: {},
        create: {
          code: country["code"],
          alpha3Code: country["alpha_3_code"],
          name: country["name_native"],
          name_en: country["name_en"],
          name_fr: country["name_fr"],
          nationality: country["nationality_fr"],
          nationality_en: country["nationality_en"],
          currencyCode: country["currency_code"],
          phonePrefix: country["phone_prefix"],
        },
      });
    }
    catch(error){
      console.error(country)
      console.error(error)
    }
  }

  // Seed Location
  const rawLocationData = await readFile(join(__dirname, 'location-data.json')  , { encoding: 'utf8' })

  const locations = JSON.parse(rawLocationData);

  for (const location of locations) {
    await prisma.location.upsert({
      where: { id: location["id"] },
      update: {},
      create: {
        id: location["id"],
        name: location["name"],
        type: location["type"],
        code: location["code"],
        countryCode: location["country_code"],
        parentId: location["parent_id"],
      },
    });
  }
}