import { collection, addDoc } from "firebase/firestore";
import { db } from "../../../providers/firebase/config";

export async function createCar(props: { model: string, manufacturer: string }) {
    try {
        console.log('entrei!')
        const docRef = await addDoc(collection(db, "cars"), {
            model: props.model,
            manufacturer: props.manufacturer
        });
        return docRef;
    } catch (error: any) {
        return {
            errorCode: error.code,
            errorMessage: error.message,
        };
    }
}


