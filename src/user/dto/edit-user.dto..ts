import { IsEmail, IsInt, IsNumber, IsOptional, IsString } from 'class-validator';

export class EditUserDto {
    @IsEmail()
    @IsOptional()
    email?: string;

    @IsString()
    @IsOptional()
    surName?: string;

    @IsString()
    @IsOptional()
    firstName?: string;

    @IsString()
    @IsOptional()
    middleName?: string;

    @IsString()
    @IsOptional()
    countryCode?: string;

    @IsNumber()
    @IsOptional()
    phoneNumber?: number;

    @IsString()
    @IsOptional()
    address?: string;

    @IsString()
    @IsOptional()
    institutionName?: string;

    @IsString()
    @IsOptional()
    positionTItle?: string;

    @IsNumber()
    @IsOptional()
    StaffNumber?: number;

    @IsString()
    @IsOptional()
    nameOfFaculty?: string;
}