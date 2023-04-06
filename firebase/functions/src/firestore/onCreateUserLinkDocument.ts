import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

admin.initializeApp();

export const createRealtimeRecord = functions.firestore
    .document("user-links/{deviceId}")
    .onCreate(async (snap, context) => {
      const documentId = context.params.deviceId;

      console.log(`Realtime record created for document ID: ${documentId}`);
    });
