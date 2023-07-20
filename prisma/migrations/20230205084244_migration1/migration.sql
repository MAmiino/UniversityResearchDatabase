/*
  Warnings:

  - The primary key for the `Journal` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `reseachPaperId` on the `Journal` table. All the data in the column will be lost.
  - The primary key for the `ReseachPaper` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the `users` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `cAuthorId` to the `ReseachPaper` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Journal" DROP CONSTRAINT "Journal_editor1Id_fkey";

-- DropForeignKey
ALTER TABLE "Journal" DROP CONSTRAINT "Journal_reseachPaperId_fkey";

-- DropForeignKey
ALTER TABLE "ReseachPaper" DROP CONSTRAINT "ReseachPaper_author1Id_fkey";

-- AlterTable
ALTER TABLE "Journal" DROP CONSTRAINT "Journal_pkey",
DROP COLUMN "reseachPaperId",
ADD COLUMN     "editor2Id" TEXT,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "editor1Id" SET DATA TYPE TEXT,
ADD CONSTRAINT "Journal_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "Journal_id_seq";

-- AlterTable
ALTER TABLE "ReseachPaper" DROP CONSTRAINT "ReseachPaper_pkey",
ADD COLUMN     "authoer3Id" TEXT,
ADD COLUMN     "author2Id" TEXT,
ADD COLUMN     "cAuthorId" TEXT NOT NULL,
ALTER COLUMN "Id" DROP DEFAULT,
ALTER COLUMN "Id" SET DATA TYPE TEXT,
ALTER COLUMN "author1Id" SET DATA TYPE TEXT,
ADD CONSTRAINT "ReseachPaper_pkey" PRIMARY KEY ("Id");
DROP SEQUENCE "ReseachPaper_Id_seq";

-- DropTable
DROP TABLE "users";

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "email" TEXT NOT NULL,
    "hash" TEXT NOT NULL,
    "surName" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "middleName" TEXT NOT NULL,
    "countryCode" TEXT NOT NULL,
    "phoneNumber" INTEGER NOT NULL,
    "address" TEXT,
    "role" "Role" NOT NULL DEFAULT 'USER',
    "institutionName" TEXT NOT NULL,
    "positionTitle" TEXT,
    "staffNumber" INTEGER,
    "nameOfFaculty" TEXT,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_JournalToReseachPaper" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_phoneNumber_key" ON "User"("phoneNumber");

-- CreateIndex
CREATE UNIQUE INDEX "User_institutionName_staffNumber_key" ON "User"("institutionName", "staffNumber");

-- CreateIndex
CREATE UNIQUE INDEX "_JournalToReseachPaper_AB_unique" ON "_JournalToReseachPaper"("A", "B");

-- CreateIndex
CREATE INDEX "_JournalToReseachPaper_B_index" ON "_JournalToReseachPaper"("B");

-- AddForeignKey
ALTER TABLE "ReseachPaper" ADD CONSTRAINT "ReseachPaper_author1Id_fkey" FOREIGN KEY ("author1Id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReseachPaper" ADD CONSTRAINT "ReseachPaper_cAuthorId_fkey" FOREIGN KEY ("cAuthorId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReseachPaper" ADD CONSTRAINT "ReseachPaper_author2Id_fkey" FOREIGN KEY ("author2Id") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReseachPaper" ADD CONSTRAINT "ReseachPaper_authoer3Id_fkey" FOREIGN KEY ("authoer3Id") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Journal" ADD CONSTRAINT "Journal_editor1Id_fkey" FOREIGN KEY ("editor1Id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Journal" ADD CONSTRAINT "Journal_editor2Id_fkey" FOREIGN KEY ("editor2Id") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_JournalToReseachPaper" ADD CONSTRAINT "_JournalToReseachPaper_A_fkey" FOREIGN KEY ("A") REFERENCES "Journal"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_JournalToReseachPaper" ADD CONSTRAINT "_JournalToReseachPaper_B_fkey" FOREIGN KEY ("B") REFERENCES "ReseachPaper"("Id") ON DELETE CASCADE ON UPDATE CASCADE;
