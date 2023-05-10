-- CreateTable
CREATE TABLE "vacancies" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "situation" TEXT NOT NULL,

    CONSTRAINT "vacancies_pkey" PRIMARY KEY ("id")
);
