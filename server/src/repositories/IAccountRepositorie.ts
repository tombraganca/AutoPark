import { Account } from "../entities/Account";

export interface IAccountRepository {
  save(account: Account): Promise<void>;
}
