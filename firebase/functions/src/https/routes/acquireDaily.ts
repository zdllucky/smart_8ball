import { basicFactory } from "../helpers/factories";
import authMiddleware from "../middlewares/zod/auth";
import { z } from "zod";

export const post = basicFactory.addMiddleware(authMiddleware).build({
  input: z.object({}),
  output: z.object({}),
  method: "post",
  handler: async ({ input, logger }) => {
    logger.info("acquireDaily", { input });
    return {};
  },
});
