/*
  Warnings:

  - Added the required column `device` to the `account_tokens` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "account_tokens" ADD COLUMN     "device" TEXT NOT NULL;
