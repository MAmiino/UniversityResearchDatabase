import { Module } from '@nestjs/common';
import { AuthModule } from './auth/auth.module';
import { UserModule } from './user/user.module';
import { ResearchPaperModule } from './research-paper/research-paper.module';
import { JournalModule } from './journal/journal.module';
import { PrismaModule } from './prisma/prisma.module';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [ConfigModule.forRoot({ isGlobal: true, }), AuthModule, UserModule, ResearchPaperModule, JournalModule, PrismaModule],
})
export class AppModule { }
