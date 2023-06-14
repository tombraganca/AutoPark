/*
  Warnings:

  - Added the required column `ownerId` to the `accesses` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "accesses" ADD COLUMN     "ownerId" TEXT NOT NULL;

-- AddForeignKey
ALTER TABLE "accesses" ADD CONSTRAINT "accesses_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "accounts"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
