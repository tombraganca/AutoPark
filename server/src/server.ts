import { env } from 'process';
import fastify from "fastify";
import cors from '@fastify/cors'

const PORT = Number(env.PORT) || 3000;
const server = fastify();

server.register(cors);

server.get("/", async (request, reply) => {
  return { hello: "world" };
});


server.listen({ port: PORT }, (err, address) => {
  if (err) {
    server.log.error(err);
    process.exit(1);
  }
  server.log.info(`server listening on ${address}`);
  console.log(`server listening on ${address}`);
});
