/*
  Warnings:

  - Added the required column `parkingId` to the `accesses` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "accesses" ADD COLUMN     "parkingId" TEXT NOT NULL;

-- AddForeignKey
ALTER TABLE "accesses" ADD CONSTRAINT "accesses_parkingId_fkey" FOREIGN KEY ("parkingId") REFERENCES "parking"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
