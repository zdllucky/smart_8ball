import { DependsOnMethod } from "express-zod-api";
import * as versionRoute from "./version";
import * as openApiRoute from "./openapi";
import * as admobAddTryAdCallbackRoute from "./admob/addTryAdCallback";
import * as basicRoute from "./question/basic";

const d = (r: typeof DependsOnMethod.constructor.arguments) =>
  new DependsOnMethod(r);

export default {
  v1: {
    version: d(versionRoute),
    api: d(openApiRoute),
    // ball: {
    //   acquireDaily: d(acquireDailyRoute),
    // },
    question: {
      basic: d(basicRoute),
    },
    admob: {
      adTryAdCallback: d(admobAddTryAdCallbackRoute),
    },
  },
};
