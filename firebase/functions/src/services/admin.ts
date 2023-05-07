import admin from "firebase-admin";

import serviceAccount from "../https/helpers/envs/sa.prod.json";
import { isEmulator } from "../https/helpers/misc";
if (isEmulator) {
  process.env.FIRESTORE_EMULATOR_HOST = "localhost:8080";
  process.env.FIREBASE_AUTH_EMULATOR_HOST = "localhost:9099";
}

admin.initializeApp({
  projectId: serviceAccount.project_id,
  credential: admin.credential.cert(serviceAccount as admin.ServiceAccount),
});

export type FirebaseAdmin = typeof admin;

export default admin;
