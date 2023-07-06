import { PrismaClient } from '@prisma/client';
import { localizationSeed } from './localization';

const prisma = new PrismaClient();

async function main() {
  localizationSeed(prisma)
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });
