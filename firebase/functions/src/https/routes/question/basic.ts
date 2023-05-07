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
      service: { openAI, resources },
    },
  }) => {
    const { userIrDeviceId } = await getUserOrDeviceId(user);

    await resources.addBasicTriesAmount(userIrDeviceId, -1);

    try {
      const answer = await openAI.getAnonymousModel3Dot5TurboAnswer(question);

      return { answer };
    } catch (e) {
      await resources.addBasicTriesAmount(userIrDeviceId, 1, {
        allowNegative: true,
      });
      throw e;
    }
  },
});

const getUserOrDeviceId = async (user: DecodedIdToken) => {
  let userIrDeviceId: string;
  let isDeviceId: boolean;

  // Check if the user is anonymous
  if (user.provider_id === "anonymous") {
    userIrDeviceId = user.deviceId;
    isDeviceId = true;
  } else {
    throw createHttpError(400, "Unimplemented");
  }

  return { userIrDeviceId, isDeviceId };
};
