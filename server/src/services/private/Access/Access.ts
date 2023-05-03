import { collection, addDoc, query, getDocs, Timestamp } from "firebase/firestore";
import { dataBase } from "../../../providers/firebase/config";

interface IAccessCar {
    plate: string,
    uid: string,
}

export async function newAccessCar(props: IAccessCar) {

    const isValid = await accessValidator(props.plate, props.uid, 'in');
    if (isValid.message !== 'Access granted') {
        return new Error(isValid.message);
    }

    const accessRefence = collection(dataBase, "Accounts", props.uid, "Access");
    const docRef = await addDoc(accessRefence, {
        arrival_date: Timestamp.fromDate(new Date()),
        plate: props.plate,
    });
    return docRef;

}

export async function listAccess(uid: string) {
    const AccountReference = collection(dataBase, "Accounts", uid, "Access");
    const docRef = query(AccountReference);
    const result: any = [];
    const querySnapshot = await getDocs(docRef);
    querySnapshot.forEach((doc) => {
        result.push(doc.data());
    }
    );
    return result;
}

export async function exitAccess(props: IAccessCar) {

    const isValid = await accessValidator(props.plate, props.uid, 'out');
    if (isValid.message !== 'Access granted') {
        return new Error(isValid.message);
    }

    const AccountReference = collection(dataBase, "Accounts", props.uid, "Access");
    const docRef = await addDoc(AccountReference, {
        departure_date: Timestamp.fromDate(new Date()),
        plate: props.plate,
    });
    return docRef;
}

async function accessValidator(plate: string, uid: string, accessType: 'in' | 'out'): Promise<{ message: string }> {
    //list acess of user
    const access: Array<any> = await listAccess(uid);

    //se o carro estiver entrando e não tiver saido
    const accessOfCar = access.filter((a) => a.plate === plate);
    if (!accessOfCar[accessOfCar.length - 1].departure_date && accessType === 'in') {
        return { message: "Car already entered" };
    }

    //se o carro estiver saindo e não tiver entrado
    if (!accessOfCar[accessOfCar.length - 1].arrival_date && accessType === 'out') {
        return { message: "Car already left" };
    }

    return { message: "Access granted" };
}