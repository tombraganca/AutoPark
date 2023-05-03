import express, { request } from "express";
import { createAccount, getToken, loginAccount } from "./Account";

const router = express();

router.post("/signup", (request, response) => {
    const data: { email: string, password: string } = request.body;

    if (!data.email || !data.password) {
        response.status(400).json({ message: "Missing email or password" });
        return;
    }

    createAccount(data).then((result) => {
        response.status(200).json(result);
    }).catch((error) => {
        response.status(500).json(error);
    });
});

router.post("/login", (request, response) => {
    const data: { email: string, password: string } = request.body;

    if (!data.email || !data.password) {
        response.status(400).json({ message: "Missing email or password" });
        return;
    }

    loginAccount(data).then((result) => {
        response.status(200).json(result);
    }).catch((error) => {
        response.status(500).json(error);
    });
});

router.get("/token", (request, response) => {
    getToken().then((result) => {
        response.status(200).json(result);
    }).catch((error) => {
        response.status(500).json(error);
    });
});

export default router;


