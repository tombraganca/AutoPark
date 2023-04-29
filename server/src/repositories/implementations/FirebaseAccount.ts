import { Account } from "../../entities/Account";
import { IAccountRepository } from "../IAccountRepositorie";

export class FireBaseAccountRepository implements IAccountRepository {
    constructor () {}
  async save(account: Account) {
    console.log("Saving account to Firebase");
  }

}