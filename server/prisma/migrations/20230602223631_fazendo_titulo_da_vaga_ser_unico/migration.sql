/*
  Warnings:

  - A unique constraint covering the columns `[title]` on the table `vacancies` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "vacancies_title_key" ON "vacancies"("title");
