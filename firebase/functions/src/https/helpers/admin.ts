import admin from "firebase-admin";

import serviceAccount from "./envs/sa.prod.json";
import { isEmulator } from "./misc";
isEmulator && (process.env.FIRESTORE_EMULATOR_HOST = "localhost:8080");

admin.initializeApp(
  isEmulator
    ? undefined
    : {
        projectId: serviceAccount.project_id,
        credential: admin.credential.cert(
          serviceAccount as admin.ServiceAccount
        ),
      }
);

export default admin;
