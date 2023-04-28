// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";

// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyC8J4_Lopm91DJrbLnwi__TDpOGUlqJ_nc",
  authDomain: "autopark-5b7ba.firebaseapp.com",
  projectId: "autopark-5b7ba",
  storageBucket: "autopark-5b7ba.appspot.com",
  messagingSenderId: "615797933896",
  appId: "1:615797933896:web:2c9203a2a6ca93acc6557d",
  measurementId: "G-SELTL9RH1K",
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

export { app, db };
