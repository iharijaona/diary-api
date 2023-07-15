import { PrismaClient } from '@prisma/client';
import { locationSeed } from './location';
import { authSeed } from './auth';
import { jurisdictionSeed } from './jurisdiction'
import { jobSeed } from './job'

const prisma = new PrismaClient();

async function main() {
  // await locationSeed(prisma)
  // await authSeed(prisma)
  // await jurisdictionSeed(prisma)
  await jobSeed(prisma)
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
