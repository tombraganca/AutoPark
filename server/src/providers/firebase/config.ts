
import admin from 'firebase-admin';
import serviceAccount from './serviceAccountKey.json';
import credentials from './credentials.json'
import { initializeApp } from 'firebase/app'
import { getFirestore } from 'firebase/firestore';

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount as admin.ServiceAccount),
});

const app = initializeApp(credentials);
const dataBase = getFirestore(app);


export { app, dataBase, admin }