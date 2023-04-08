import { firestore } from "firebase-functions";
import admin from "../https/helpers/admin";
import { Collections } from "../models/firestore";
import { z } from "zod";
import logger from "../https/helpers/logger";

export const onCreateUserLinkDocument = firestore
  .document(`${Collections.anonymousUserLinks.name}/{deviceId}`)
  .onCreate(async (snap, context) => {
    logger.info("createRealtimeRecord", { deviceId: context.params.deviceId });
    const deviceId = context.params.deviceId;
    const resource = admin
      .firestore()
      .collection(Collections.resourcesAvailable.name)
      .doc(deviceId);

    resource.set({
      subjectType: "deviceId",
      resources: { basicTries: 0 },
    } as z.infer<typeof Collections.resourcesAvailable.documentModel>);
  });
