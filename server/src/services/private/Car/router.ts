import express from "express";
import { createCar } from "./Car";


const router = express();

//create car
router.post("/car" ,(request, response) => {
    const data: { model: string, manufacturer: string } = request.body;
    if (!data?.model || !data?.manufacturer) {
        return response.status(400).json({ message: "Missing required data" });
    }

    createCar(data).then((result) => {
        response.status(201).json({ message: "Car created successfully" });
    }
    ).catch((error) => {
        response.status(500).json({ message: error.message });
    });
});

export default router;