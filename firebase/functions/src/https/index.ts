import { attachRouting, OpenAPI } from "express-zod-api";
import { Express } from "express";
import routing from "./routes";
import swaggerUi from "swagger-ui-express";
import * as process from "process";
import logger from "./helpers/logger";

export let config: any;

const createApp = (app: Express) => {
  const { notFoundHandler } = attachRouting(
    (config = {
      app,
      cors: process.env.NODE_ENV !== "development",
      logger,
      startupLogo: false,
    }),
    routing
  );

  app.use(
    "/rest/docs",
    swaggerUi.serve,
    swaggerUi.setup(
      new OpenAPI({
        routing, // the same routing and config that you use to start the server
        config,
        title: "asd",
        version: "1.0.0",
        serverUrl: "http://localhost:3000/",
      }).getSpec(),
      {
        explorer: true,
      }
    )
  );

  app.use("/rest", notFoundHandler);

  return app;
};

export default createApp;
