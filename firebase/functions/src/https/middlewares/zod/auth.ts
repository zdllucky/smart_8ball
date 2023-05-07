import { z } from "zod";
import { createHttpError, createMiddleware } from "express-zod-api";
import { getAuth } from "firebase-admin/auth";

const authMiddleware = createMiddleware({
  security: { type: "bearer" },
  input: z.object({}),
  middleware: async ({ request }) => {
    const token = request.headers.authorization?.split("Bearer ")[1];

    if (!token) throw createHttpError(401, "auth/no-token-provided");

    try {
      return { user: await getAuth().verifyIdToken(token, true) };
    } catch (e) {
      throw createHttpError(401, e.code);
    }
  },
});

export default authMiddleware;
