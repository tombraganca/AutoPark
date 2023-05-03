import { getAuth, createUserWithEmailAndPassword, signInWithEmailAndPassword } from "firebase/auth";
import { app, admin, dataBase } from "../../../providers/firebase/config";
import { DecodedIdToken } from "firebase-admin/lib/auth/token-verifier";
import { setDoc, doc } from 'firebase/firestore'

export async function createAccount(props: {
    email: string;
    password: string;
    name: string;
}) {
    const auth = getAuth(app);
    try {
        const userCredential = await createUserWithEmailAndPassword(
            auth,
            props.email,
            props.password
        );

        const accountDoc = doc(dataBase, "Accounts", userCredential.user.uid)
        await setDoc(accountDoc, {
            email: props.email,
            name: props.name,
        })

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

export async function validateToken(token: string): Promise<DecodedIdToken | { message: string }> {
    try {
        const decodedToken = await admin.auth().verifyIdToken(token)
        return decodedToken
    } catch (error) {
        return { message: "Invalid token" };
    }
}

export async function refreshToken(token: string) {
    const auth = getAuth(app);
    try {
        const userCredential = await admin.auth().verifyIdToken(token, true);
        return userCredential;
    } catch (error: any) {
        return {
            errorCode: error.code,
            errorMessage: error.message,
        };
    }
}

export async function signout(user: { uid: string }) {
    admin.auth().revokeRefreshTokens(user.uid)
}
