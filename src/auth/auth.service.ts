import { ForbiddenException, Injectable } from "@nestjs/common";
import { PrismaService } from "src/prisma/prisma.service";
import { AuthDto } from "./dto";
import * as argon from 'argon2'
import { JwtService } from "@nestjs/jwt";
import { ConfigService } from "@nestjs/config";
import { PrismaClientKnownRequestError } from "@prisma/client/runtime";

@Injectable({})
export class AuthService {
    constructor(private prisma: PrismaService, private jwt: JwtService, private congfig: ConfigService,) { }

    async singup(dto: AuthDto) {
        const hash = await argon.hash(dto.password);
        try {
            const user = await this.prisma.user.create({
                data: {
                    email: dto.email,
                    hash,
                    surName: dto.surName,
                    firstName: dto.firstName,
                    middleName: dto.middleName,
                    countryCode: dto.countryCode,
                    phoneNumber: dto.phoneNumber,
                    institutionName: dto.institutionName,
                }
            })
            return this.signToken(user.id, user.email);
        } catch (error) {
            if (error instanceof PrismaClientKnownRequestError) {
                if (error.code == 'P2002') {
                    throw new ForbiddenException('Credential Taken',)
                }
            }
            throw error;
        }
    }

    async signin(dto: AuthDto) {
        const user = await this.prisma.user.findUnique({
            where: {
                email: dto.email,
            }
        })
        if (!user) throw new ForbiddenException('Credentials Incorrect,');

        const pwMatches = await argon.verify(user.hash, dto.password);

        if (!pwMatches) throw new ForbiddenException('Credentials Incorrect',);

        return this.signToken(user.id, user.email);
    }
    async signToken(userId: string, emailL: string): Promise<{ acess_token: string }> {
        const payload = {
            sub: userId,
            emailL
        };
        const secret = this.congfig.get('JWT_SECRET');

        const token = await this.jwt.signAsync(payload, {
            expiresIn: '60m',
            secret: secret,
        },
        );
        return {
            acess_token: token,
        };
    }

}