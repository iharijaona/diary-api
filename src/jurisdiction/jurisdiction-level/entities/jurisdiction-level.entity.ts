import { ObjectType, Field, registerEnumType } from '@nestjs/graphql';
import { IsEnum, IsString } from 'class-validator';
import { JurisdictionLevel as JurisdictionLevelModel } from '@prisma/client';

export enum EnumJurisdictionLevel {
  SUPREME_COURT = 'SUPREME_COURT', 
  CASSATION_COURT = 'CASSATION_COURT',
  AUDIT_COURT = 'AUDIT_COURT',
  ADMINISTRATIVE_LAW_COURT = 'ADMINISTRATIVE_LAW_COURT',
  APPELLATE_COURT = 'APPELLATE_COURT',
  ADMINISTRATIVE_COURT = 'ADMINISTRATIVE_COURT',
  FISCAL_COURT = 'FISCAL_COURT',
  TRIAL_COURT = 'TRIAL_COURT'
}


registerEnumType(EnumJurisdictionLevel, {
  name: 'EnumJurisdictionLevel',
  description: 'Level of jurisdiction.',
});


@ObjectType()
export class JurisdictionLevel {
  @Field(() => EnumJurisdictionLevel, { description: 'Unique identifier of the jurisdiction level' })
  @IsEnum(EnumJurisdictionLevel)
  code: EnumJurisdictionLevel;

  @Field(() => String, { description: 'Name of the jurisdiction level' })
  @IsString()
  name: string;

  @Field(() => String, { description: 'Short name of the jurisdiction level: TPI, CC...' })
  @IsString()
  shortName: string;

  // @Field(() => ID, { description: 'Unique identifier of the jurisdiction level' })
  // instances: string;

  constructor(payload: JurisdictionLevelModel) {
    Object.assign(this, {
      ...payload,
    });
  }
}
