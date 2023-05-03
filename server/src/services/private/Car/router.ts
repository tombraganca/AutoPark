import express from "express";
import { createCar, listCars, updateCar } from "./Car";


const router = express();

//create car
router.post("/car", (request, response) => {
    const data: { model: string, manufacturer: string, plate: string } = request.body;
    const uid = request.body.uid;
    if (!data?.model || !data?.manufacturer) {
        return response.status(400).json({ message: "Missing required data" });
    }

    createCar({ car: data, uid: uid }).then((result) => {
        if (result instanceof Error) {
            response.status(500).json({ message: result.message });
            return;
        }
        response.status(201).json({ message: "Car created successfully" });
    }
    ).catch((error) => {
        response.status(500).json({ message: error.message });
    });
});

//update car
router.put("/car", (request, response) => {
    const data: { model: string, manufacturer: string, plate: string } = request.body;
    const uid = request.body.uid;
    if (!data?.model || !data?.manufacturer) {
        return response.status(400).json({ message: "Missing required data" });
    }

    updateCar({ car: data, uid: uid }).then((result) => {
        if (result instanceof Error) {
            response.status(500).json({ message: result.message });
            return;
        }
        response.status(201).json({ message: "Car updated successfully" });
    }
    ).catch((error) => {
        response.status(500).json({ message: error.message });
    });
});

router.get("/car", (request, response) => {
    const uid = request.body.uid;

    listCars(uid).then((result) => {
        if (result instanceof Error) {
            response.status(500).json({ message: result.message });
            return;
        }
        response.status(201).json(result);
    }
    ).catch((error) => {
        response.status(500).json({ message: error.message });
    });
});


export default router;