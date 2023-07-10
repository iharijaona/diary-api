import { ArgsType, Field, Int, ObjectType, registerEnumType } from '@nestjs/graphql';
import { Type } from '@nestjs/common';
import { Min } from 'class-validator';

export enum EnumSortOrder {
  asc,
  desc
}

registerEnumType(EnumSortOrder, {
  name: 'EnumSortOrder',
  description: 'The sort order.',
});

@ArgsType()
export class PageArgs {
  @Field((type) => Int)
  @Min(0)
  skip = 0;

  @Field((type) => Int)
  take: number;
}

export interface IPaginatedType<T> {
  nodes: T[];

  currentPage: number;

  pageSize: number;
  
  totalItemCount: number;

  totalPageCount: number;
}


export function Paginated<T>(classRef: Type<T>, defaultPageSize = 100): Type<IPaginatedType<T>> {
  // @ObjectType(`${classRef.name}Edge`)
  @ObjectType({ isAbstract: true })
  abstract class PaginatedType implements IPaginatedType<T> {

    @Field((type) => [classRef], { nullable: true })
    nodes: T[];

    @Field((type) => Int)
    currentPage: number;

    @Field((type) => Int)
    pageSize: number = defaultPageSize;
    
    @Field((type) => Int)
    totalItemCount = 0;

    @Field((type) => Int)
    totalPageCount = 0;
  }
  return PaginatedType as Type<IPaginatedType<T>>;
}
