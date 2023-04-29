// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";

import credentials from "./credentials.json"

const firebaseConfig = {
  apiKey: credentials.apiKey,
  authDomain: credentials.authDomain,
  projectId: credentials.projectId,
  storageBucket: credentials.storageBucket,
  messagingSenderId: credentials.messagingSenderId,
  appId: credentials.appId,
  measurementId: credentials.measurementId
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

export { app, db };
