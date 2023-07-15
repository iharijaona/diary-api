import { GraphQLError } from 'graphql';

export class JurisdictionInstanceNotFoundError extends GraphQLError {
    constructor(id: string, error?: any) {
        super(`Jurisdiction instance '${id}' not found`, {
            originalError: error,
            extensions: {
                code: 'JURISDICTIONINSTANCE_NOT_FOUND',
            },
        });
    }
}
  