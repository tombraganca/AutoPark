import { FastifyReply, FastifyRequest } from "fastify";
import { db } from "../integrations/firebase/config";
import { collection, addDoc } from "firebase/firestore";

export const createUser = async (req: FastifyRequest, res: FastifyReply ) => {
  try {
    const docRef = await addDoc(collection(db, "users"), {
      first: "Ada",
      last: "Lovelace",
      born: 1815,
    });
    console.log("Document written with ID: ", docRef.id);
  } catch (e) {
    console.error("Error adding document: ", e);
  }
};
