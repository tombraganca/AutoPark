import express, { request } from "express";
import { createAccount, getToken, loginAccount, validateToken } from "./Account";
import { admin } from "../../../providers/firebase/config";

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
    console.log(request.body);
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

router.post("/refreshToken", (request, response) => {

    const refreshToken = request.body.refreshToken;
    if (!refreshToken) {
        response.status(400).json({ message: "Missing refresh token" });
        return;
    }
});

router.get('/validate', async (request, response) => {
    const token = request.headers.authorization?.split(" ")[1];
    if (!token) {
        return response.status(401).json({
            message: "Token not found"
        });
    }

    const isValid = await validateToken(token)

    response.status(200).json(isValid);

});

export default router;


