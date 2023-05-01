import { Collections } from "../../../models/firestore";
import { basicFactory } from "../../helpers/factories";
import { z } from "zod";
import { isEmulator } from "../../helpers/misc";
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
      options: { admin, headers },
    }) {
      // Check header.user-agent to be 'Google-AdMob-Reward-Verification'
      if (
        typeof headers["user-agent"] === "string" &&
        headers["user-agent"].toLowerCase() !==
          "google-admob-reward-verification"
      ) {
        throw Error("Error validating origin");
      }

      // Check if the request is a test request
      if (user_id === "test123" && custom_data === '{"test": 123}') {
        logger.debug("Test request received");
        return {};
      }
      // Check whether user is anonymous or not
      const user = await admin.auth().getUser(user_id);
      if (user.providerData.length === 0) {
        // Get the doc id from the custom_data
        const { deviceId } = JSON.parse(custom_data);

        isEmulator() &&
          logger.debug(`deviceId: ${deviceId}, user_id: ${user_id}`);

        // Check if the doc with id = device_id exists in the 'anonymousUserLinks' collection and doc with id = user_id is in the linksTo collection
        const userLink = await admin
          .firestore()
          .collection(Collections.anonymousUserLinks.name)
          .doc(deviceId)
          .collection("linksTo")
          .doc(user_id)
          .get();

        isEmulator() && logger.debug(`userLink: ${userLink}`);

        // If the user is anonymous, then the 'anonymousUserLinks' collection should contain a document with the user_id
        if (!userLink.exists) throw new Error("Anonymous user not found");

        // Add +1 to triesAvailable.basicTries for doc with id = device_id
        await admin.firestore().runTransaction(async (transaction) => {
          const doc = admin
            .firestore()
            .collection(Collections.triesAvailable.name)
            .doc(deviceId);

          const triesAvailable =
            (await doc.get()).data()?.resources.basicTries ?? 0;

          transaction.update(doc, {
            resources: {
              basicTries: triesAvailable + 1,
            },
          });
        });
      }
      // TODO: If the user is not anonymous, then add +1 to triesAvailable.basicTries for doc with id = user_id

      return {};
    },
  });
