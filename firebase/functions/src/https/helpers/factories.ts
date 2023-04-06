import { json, urlencoded } from "express";
import { defaultResultHandler, EndpointsFactory } from "express-zod-api";
import { config } from "../index";

export const basicFactory = new EndpointsFactory({
  resultHandler: defaultResultHandler,
  config,
})
  .addExpressMiddleware(json())
  .addExpressMiddleware(urlencoded({ extended: true }));
