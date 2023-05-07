import { createHttpError } from "express-zod-api";
import { DecodedIdToken } from "firebase-admin/lib/auth/token-verifier";
import { z } from "zod";
import { authFactory } from "../../helpers/factories";

export const post = authFactory.build({
  input: z.object({ question: z.string().nonempty() }),
  output: z.object({ answer: z.string() }),
  method: "post",
  handler: async ({
    input: { question },
    options: {
      user,
      service: { openAI, resources, user: userService },
    },
  }) => {
    const { userOrDeviceId } = await userService.getUserOrDeviceId(user.uid);

    await resources.addBasicTriesAmount(userOrDeviceId, -1);

    try {
      const answer = await openAI.getAnonymousModel3Dot5TurboAnswer(question);

      return { answer };
    } catch (e) {
      await resources.addBasicTriesAmount(userOrDeviceId, 1, {
        allowNegative: true,
      });
      throw e;
    }
  },
});
