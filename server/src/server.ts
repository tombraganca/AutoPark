import { env } from 'process';
import express from 'express';
import cors from 'cors';

import router from './router';

const PORT = Number(env.PORT) || 3000;

const app = express();
app.use(express.json());
app.use(cors());

app.get('/', (request, response) => {
    response.json({ message: 'Hello World!' });
});

app.use(router);

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});

