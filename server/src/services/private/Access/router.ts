import express from "express";
import { exitAccess, listAccess, newAccessCar } from "./Access";

const router = express();


router.get("/access", (request, response) => {
    const uid = request.body.uid;

    listAccess(uid).then((result) => {
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

router.post('/access', (request, response) => {
    const uid = request.body.uid;
    const plate = request.body.plate;

    newAccessCar({ uid: uid, plate: plate }).then((result) => {
        if (result instanceof Error) {
            response.status(500).json({ message: result.message });
            return;
        }
        response.status(201).json({ message: "Access granted" });
    }).catch((error) => {
        response.status(500).json({ message: error.message });
    }
    );
});

router.post('/exit', (request, response) => {
    const uid = request.body.uid;
    const plate = request.body.plate;

    exitAccess({ uid: uid, plate: plate }).then((result) => {
        if (result instanceof Error) {
            response.status(500).json({ message: result.message });
            return;
        }
        response.status(201).json({ message: "Access granted" });
    }).catch((error) => {
        response.status(500).json({ message: error.message });
    }
    );
});

export default router;