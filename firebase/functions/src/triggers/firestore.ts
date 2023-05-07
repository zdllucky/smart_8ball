import { runWith } from "firebase-functions";
import repositories from "../repositories";
import admin from "../services/admin";
import { Collections } from "../models/firestore";

export const onCreateUserLinkDocument = runWith({ failurePolicy: true })
  .firestore.document(`${Collections.anonymousUserLinks.name}/{deviceId}`)
  .onCreate((snap, context) => {
    const { deviceId } = context.params;
    const { triesAvailable } = repositories;
    const doc = triesAvailable.reference.doc(deviceId);

    return doc.set({
      subjectType: "deviceId",
      resources: { basicTries: 0 },
    });
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
