import { PrismaClient } from '@prisma/client';
import { readFile } from 'fs/promises';
import { join } from 'path';

export async function jobSeed(prisma: PrismaClient) {
  // Seed Job
  const rawJobs = await readFile(
    join(__dirname, 'job-list.json'),
    { encoding: 'utf8' },
  );

  const jobList = JSON.parse(rawJobs);

  for (const job of jobList) {
    await prisma.job.upsert({
      where: { id:  job["id"]},
      update: {},
      create: {
        id:  job["id"],
        name: job['name_male'],
        feminineName: job['name_female'],
        isOther: job["id"] === 99999
      },
    });
  }
}
