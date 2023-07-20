-- CreateEnum
CREATE TYPE "Role" AS ENUM ('USER', 'ADMIN');

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "email" TEXT NOT NULL,
    "hash" TEXT NOT NULL,
    "surName" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "middleName" TEXT NOT NULL,
    "phoneNumber" INTEGER NOT NULL,
    "address" TEXT,
    "role" "Role" NOT NULL DEFAULT 'USER',
    "institutionName" TEXT NOT NULL,
    "positionTitle" TEXT,
    "staffNumber" INTEGER,
    "nameOfFaculty" TEXT,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReseachPaper" (
    "Id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "title" TEXT NOT NULL,
    "areaOfReasearch" TEXT NOT NULL,
    "author1Id" INTEGER NOT NULL,
    "abstract" TEXT NOT NULL,

    CONSTRAINT "ReseachPaper_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "Journal" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "title" TEXT,
    "field" TEXT,
    "editor1Id" INTEGER NOT NULL,
    "reseachPaperId" INTEGER,

    CONSTRAINT "Journal_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- AddForeignKey
ALTER TABLE "ReseachPaper" ADD CONSTRAINT "ReseachPaper_author1Id_fkey" FOREIGN KEY ("author1Id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Journal" ADD CONSTRAINT "Journal_editor1Id_fkey" FOREIGN KEY ("editor1Id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Journal" ADD CONSTRAINT "Journal_reseachPaperId_fkey" FOREIGN KEY ("reseachPaperId") REFERENCES "ReseachPaper"("Id") ON DELETE SET NULL ON UPDATE CASCADE;
