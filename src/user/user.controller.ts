import { Body, Controller, Get, Patch, UseGuards } from "@nestjs/common";
import { JwtGuard } from "src/auth/guard";
import { UserService } from "./user.service";
import { AuthGuard } from '@nestjs/passport';
import { EditUserDto } from "./dto";
import { GetUser } from "src/auth/decorator";
import { User } from "@prisma/client";


@UseGuards(JwtGuard)
@Controller('users')
export class UserController {
    constructor(private userService: UserService) { }
    @Get('me')
    getMe(@GetUser() user: User) {
        return user;
    }
    @Patch()
    editUser(@GetUser('id') userId: string, @Body() dto: EditUserDto) {
        return this.userService.editUser(userId, dto);
    }
}