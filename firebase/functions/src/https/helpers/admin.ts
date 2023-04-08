import admin from "firebase-admin";

import serviceAccount from "../../../06.04.23.sa.json";

process.env.FIRESTORE_EMULATOR_HOST = "localhost:8080";

admin.initializeApp({
  projectId: serviceAccount.project_id,
  credential: admin.credential.cert(serviceAccount as admin.ServiceAccount),
});

export default admin;
