import { config } from './config/config';
import "express-async-errors";
import express, { Request, Response, NextFunction } from 'express';
import cors from 'cors';
import router from './router';
import swaggerUi from 'swagger-ui-express';
import swaggerFile from './swagger.json';

const PORT = config.port;
const app = express();

app.use(express.json());
app.use(cors());
router.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerFile));
app.use(router);

app.use((error: Error, request: Request, response: Response, next: NextFunction) => {
    return response.json({
        status: "Error",
        message: error.message
    })
});

app.get('/', (request, response) => {
    response.json({ message: 'Hello World!' });
});


app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});

