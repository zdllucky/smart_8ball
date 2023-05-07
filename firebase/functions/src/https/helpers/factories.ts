import { json, urlencoded } from "express";
import { z } from "zod";
import {
  EndpointsFactory,
  createResultHandler,
  defaultResultHandler,
} from "express-zod-api";
import { config } from "..";
import authMiddleware from "../middlewares/zod/auth";
import { isEmulator } from "./misc";
import service from "./../../services";
import repository from "./../../repositories";

export const basicFactory = new EndpointsFactory({
  resultHandler: defaultResultHandler,
  config,
})
  .addExpressMiddleware(json())
  .addExpressMiddleware(urlencoded({ extended: true }))
  .addOptions({ isEmulator, service, repository });

export const authFactory = new EndpointsFactory({
  resultHandler: defaultResultHandler,
  config,
})
  .addExpressMiddleware(json())
  .addExpressMiddleware(urlencoded({ extended: true }))
  .addOptions({ isEmulator, service, repository })
  .addMiddleware(authMiddleware);

export const textTypeFactory = new EndpointsFactory({
  config,
  resultHandler: createResultHandler({
    getPositiveResponse: () => ({
      schema: z.string(),
    }),
    getNegativeResponse: defaultResultHandler.getNegativeResponse,
    handler: ({ response, error, output }) => {
      if (error) {
        response.status(400).send(error.message);
        return;
      }
      if ("data" in output) {
        response.type(output.mimeType ?? "text/plain").send(output.data);
      } else {
        response.status(400).send("Data is missing");
      }
    },
  }),
})
  .addExpressMiddleware(json())
  .addExpressMiddleware(urlencoded({ extended: true }));
