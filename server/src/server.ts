import fastify from "fastify";
import cors from '@fastify/cors'
import formbody from '@fastify/formbody'
import setUserRoutes from "./auth/router";


const server = fastify({ logger: true });

server.register(cors, {
  origin: true,
  methods: ["GET", "POST", "PUT", "DELETE"],
  allowedHeaders: ["Content-Type", "Authorization"],
  credentials: true,
});

server.register(formbody);

server.register(setUserRoutes, { prefix: "/api" });

server.get("/", async (request, reply) => {
  return { hello: "world" };
});

server.listen({ port: 3000 }, (err, address) => {
  if (err) {
    server.log.error(err);
    process.exit(1);
  }
  server.log.info(`server listening on ${address}`);
});
