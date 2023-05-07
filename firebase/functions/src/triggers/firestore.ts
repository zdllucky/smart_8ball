import { runWith } from "firebase-functions";
import admin from "../services/admin";
import { Collections } from "../models/firestore";

export const onCreateUserLinkDocument = runWith({ failurePolicy: true })
  .firestore.document(`${Collections.anonymousUserLinks.name}/{deviceId}`)
  .onCreate((snap, context) => {
    const { deviceId } = context.params;
    const { name, documentModel } = Collections.triesAvailable;
    const doc = admin.firestore().collection(name).doc(deviceId);

    return doc.set(
      documentModel.parse({
        subjectType: "deviceId",
        resources: { basicTries: 0 },
      })
    );
  });

export const onLinkUserToDevice = runWith({
  failurePolicy: true,
})
  .firestore.document(
    `${Collections.anonymousUserLinks.name}/{deviceId}/${Collections.userLink.name}/{userId}`
  )
  .onCreate(async (change, context) => {
    const { deviceId, userId } = context.params;

    return admin.auth().setCustomUserClaims(userId, { deviceId });
  });
