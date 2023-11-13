/*
  Warnings:

  - Added the required column `section` to the `vacancies` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "vacancies" ADD COLUMN     "section" INTEGER NOT NULL;
