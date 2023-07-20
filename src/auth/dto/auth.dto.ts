import { IsEmail, IsNotEmpty, IsNumber, IsOptional, IsString, } from 'class-validator'

export class AuthDto {
    @IsEmail()
    @IsNotEmpty()
    email: string;

    @IsString()
    @IsNotEmpty()
    password: string;

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