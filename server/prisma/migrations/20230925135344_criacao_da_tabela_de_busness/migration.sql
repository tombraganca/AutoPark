/*
  Warnings:

  - Added the required column `busnessId` to the `vacancies` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "vacancies" ADD COLUMN     "busnessId" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "busness" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "location" TEXT NOT NULL,

    CONSTRAINT "busness_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "busness_name_key" ON "busness"("name");

-- AddForeignKey
ALTER TABLE "vacancies" ADD CONSTRAINT "vacancies_busnessId_fkey" FOREIGN KEY ("busnessId") REFERENCES "busness"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
