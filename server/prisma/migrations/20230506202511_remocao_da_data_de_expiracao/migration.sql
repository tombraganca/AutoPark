/*
  Warnings:

  - You are about to drop the column `expiresIn` on the `account_tokens` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "account_tokens" DROP COLUMN "expiresIn";
