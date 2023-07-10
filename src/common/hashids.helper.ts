import Hashids from 'hashids';
import { HASHIDS_SECRET } from 'src/app.config';

const hashids = new Hashids(process.env.HASHIDS_SECRET ?? HASHIDS_SECRET);

export const encodeId = (id: number | bigint): string => {
  return hashids.encode(id);
};

export const decodeId = (id: string): number => {
  return Number(hashids.decode(id)[0]);
};
