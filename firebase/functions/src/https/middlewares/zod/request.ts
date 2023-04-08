import { createMiddleware } from "express-zod-api";
import { z } from "zod";

const requestProviderMiddleware = createMiddleware({
  input: z.object({}),
  middleware: async ({ request }) => ({ request }),
});

export default requestProviderMiddleware;
