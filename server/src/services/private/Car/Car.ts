import { collection, query, updateDoc, doc, setDoc, getDocs } from "firebase/firestore";
import { dataBase } from "../../../providers/firebase/config";


interface ICar {
    car: {
        plate: string;
        model: string;
        manufacturer: string;
    };
    uid: string;
}


export async function createCar(props: ICar) {
    try {
        const AccountReference = doc(collection(dataBase, "Accounts", props.uid, "Cars"), props.car.plate);
        const docRef = setDoc(AccountReference, {
            plate: props.car.plate,
            model: props.car.model,
            manufacturer: props.car.manufacturer,
        });
        return docRef;
    } catch (error: any) {
        return error
    }
}

export async function updateCar(props: ICar) {
    try {
        const AccountReference = doc(collection(dataBase, "Accounts", props.uid, "Cars"), props.car.plate);
        const docRef = updateDoc(AccountReference, {
            plate: props.car.plate,
            model: props.car.model,
            manufacturer: props.car.manufacturer,
        });
        return docRef;
    } catch (error: any) {
        return error
    }
}

export async function listCars(uid: string) {
    const AccountReference = collection(dataBase, "Accounts", uid, "Cars");
    const docRef = query(AccountReference);
    const result: any = [];
    const querySnapshot = await getDocs(docRef);
    querySnapshot.forEach((doc) => {
        result.push(doc.data());
    }
    );
    return result;
}


