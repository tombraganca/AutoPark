/*
  Warnings:

  - You are about to drop the column `plateCar` on the `vacancies` table. All the data in the column will be lost.
  - Added the required column `center` to the `vacancies` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "vacancies" DROP COLUMN "plateCar",
ADD COLUMN     "center" JSONB NOT NULL;
