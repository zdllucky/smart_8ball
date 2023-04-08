import { textTypeFactory } from "../helpers/factories";
import { OpenAPI } from "express-zod-api";
import { z } from "zod";
import routing from "./index";
import { config } from "../index";
import { version } from "../../../package.json";
import { getFullUrlFromReq } from "../helpers/misc";
import requestProviderMiddleware from "../middlewares/zod/request";

export const get = textTypeFactory
  .addMiddleware(requestProviderMiddleware)
  .build({
    input: z.object({}),
    output: z.object({
      data: z.string(),
      mimeType: z.string(),
    }),
    method: "get",
    handler: async ({ options: { request } }) => ({
      data: JSON.stringify(
        new OpenAPI({
          routing,
          config,
          title: "Ponder8 API",
          version: version,
          serverUrl: getFullUrlFromReq(request),
        }).getSpec()
      ),
      mimeType: "application/vnd.oai.openapi+json;version=3.0",
    }),
  });
