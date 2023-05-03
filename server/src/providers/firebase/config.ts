// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";
import admin from 'firebase-admin'
import credentials from "./credentials.json"

const app = initializeApp(credentials);
const db = getFirestore(app);

export { app, db, admin };
