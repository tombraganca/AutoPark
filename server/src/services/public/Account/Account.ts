import { getAuth, createUserWithEmailAndPassword, signInWithEmailAndPassword } from "firebase/auth";
import { app } from "../../../providers/firebase/config";

export async function createAccount(props: {
    email: string;
    password: string;
}) {
    const auth = getAuth(app);
    try {
        const userCredential = await createUserWithEmailAndPassword(
            auth,
            props.email,
            props.password
        );

        return userCredential;
    } catch (error: any) {
        return {
            errorCode: error.code,
            errorMessage: error.message,
        };
    }
}

export async function loginAccount(props: { email: string, password: string }) {
    const auth = getAuth(app);
    try {
        const userCredential = await signInWithEmailAndPassword(
            auth,
            props.email,
            props.password
        );

        return userCredential;
    } catch (error: any) {
        return {
            errorCode: error.code,
            errorMessage: error.message,
        };
    }
}

export async function getToken() {
    const auth = getAuth(app);
    const user = auth.currentUser;
    if (user) {
        const token = await user.getIdToken();
        return token;
    } else {
        return null;
    }
}
