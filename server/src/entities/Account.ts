import { v4 as uuidV4 } from "uuid";

interface ICars {
  plate: string;
  model: {
    manufacturer: string;
    name: string;
    year: number;
  };
}

export class Account {
  id!: string;
  name!: string;
  email!: string;
  password!: string;
  cars: Array<ICars> = [];
  created_at!: Date;
  updated_at!: Date;
  deleted_at!: Date;

  constructor(
    props: Omit<Account, "id" | "created_at" | "updated_at" | "deleted_at">,
    id?: string
  ) {
    Object.assign(this, props);

    if (!id) {
      this.id = uuidV4();
    }

    if (!this.created_at) {
      this.created_at = new Date();
    }
  }
}
