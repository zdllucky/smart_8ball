import { createHttpError } from "express-zod-api";
import { basicFactory } from "../../helpers/factories";
import { z } from "zod";
import headersProviderMiddleware from "../../middlewares/zod/headers";

export const get = basicFactory
  .addMiddleware(headersProviderMiddleware)
  // TODO: Provide proper middleware to verify the signature
  .build({
    input: z.object({
      ad_network: z.string(),
      ad_unit: z.string(),
      custom_data: z.string(),
      reward_amount: z.coerce.number(),
      reward_item: z.string(),
      timestamp: z.coerce.number(),
      transaction_id: z.string(),
      user_id: z.string(),
      signature: z.string(),
      key_id: z.string(),
    }),
    output: z.object({}),
    method: "get",
    async handler({
      input: { user_id, custom_data },
      logger,
      options: {
        service: { user, resources },
        headers,
      },
    }) {
      try {
        validateHeaders(
          headers,
          new Map([["user-agent", "google-admob-reward-verification"]])
        );
      } catch (e) {
        throw createHttpError(400, `Error validating origin. ${e.message}`);
      }

      // Check if the request is a test request
      if (user_id === "test123" && custom_data === '{"test": 123}') {
        logger.debug("Test request received");
        return {};
      }

      const { userOrDeviceId } = await user.getUserOrDeviceId(user_id);

      await resources.addBasicTriesAmount(userOrDeviceId, 1);

      return {};
    },
  });

const validateHeaders = (headers, map: Map<string, string>) => {
  for (const [key, value] of map) {
    if (
      typeof headers[key] !== "string" ||
      headers[key].toLowerCase() !== value
    )
      throw Error(`Invalid header ${key}`);
  }
};
