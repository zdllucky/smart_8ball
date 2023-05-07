import { attachRouting } from "express-zod-api";
import { Express } from "express";
import routing from "./routes";
import * as process from "process";
import logger from "../services/logger";

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

  app.use("/rest", notFoundHandler);

  return app;
};

export default createApp;
