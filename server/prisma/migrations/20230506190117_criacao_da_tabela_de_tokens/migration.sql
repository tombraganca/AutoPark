-- CreateTable
CREATE TABLE "account_tokens" (
    "id" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "expiresIn" INTEGER NOT NULL,
    "accountId" TEXT NOT NULL,

    CONSTRAINT "account_tokens_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "account_tokens" ADD CONSTRAINT "account_tokens_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "accounts"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
