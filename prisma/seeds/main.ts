import { PrismaClient } from '@prisma/client';
import { locationSeed } from './location';

const prisma = new PrismaClient();

async function main() {
  locationSeed(prisma)
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
