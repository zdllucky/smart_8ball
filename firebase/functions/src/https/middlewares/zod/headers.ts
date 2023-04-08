import { createMiddleware } from "express-zod-api";
import { z } from "zod";

const headersProviderMiddleware = createMiddleware({
  input: z.object({}), // means no inputs
  middleware: async ({ request }) => ({
    headers: request.headers,
  }),
});

export default headersProviderMiddleware;
