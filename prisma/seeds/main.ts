import { PrismaClient } from '@prisma/client';
import { locationSeed } from './location';
import { authSeed } from './auth';

const prisma = new PrismaClient();

async function main() {
  locationSeed(prisma)
  authSeed(prisma)
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
