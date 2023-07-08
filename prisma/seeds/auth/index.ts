import { PrismaClient, RoleName } from '@prisma/client';

 
export const toProperCase = (charSequance: string, split=' '): string => {
  return  charSequance.split(split)
   .map(w => w[0].toUpperCase() + w.substring(1).toLowerCase())
  .join(' ');
}

async function roleSeed(prisma: PrismaClient) {

  for (const roleName of Object.keys(RoleName)) {
    await prisma.role.upsert({
      where: { name:  roleName as RoleName},
      update: {},
      create: {
        name: roleName as RoleName,
        label: toProperCase(roleName)
      },
    });
  }
}

export async function authSeed(prisma: PrismaClient) {
  await roleSeed(prisma)
}