import { PrismaClient, EnumRoleName } from '@prisma/client';

 
export const toProperCase = (charSequance: string, split=' '): string => {
  return  charSequance.split(split)
   .map(w => w[0].toUpperCase() + w.substring(1).toLowerCase())
  .join(' ');
}

async function roleSeed(prisma: PrismaClient) {

  for (const roleName of Object.keys(EnumRoleName)) {
    await prisma.role.upsert({
      where: { name:  EnumRoleName[roleName]},
      update: {},
      create: {
        name: EnumRoleName[roleName],
        label: toProperCase(roleName)
      },
    });
  }
}

export async function authSeed(prisma: PrismaClient) {
  await roleSeed(prisma)
}