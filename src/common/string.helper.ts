export const toProperCase = (charSequance: string, split = ' '): string => {
  return charSequance
    .split(split)
    .map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase())
    .join(' ');
};
