import { GraphQLError } from 'graphql';

export class LocationNotFoundError extends GraphQLError {
  constructor(id: string, error?: any) {
    super(`Location '${id}' not found`, {
      originalError: error,
      extensions: {
        code: 'LOCATION_NOT_FOUND',
      },
    });
  }
}
