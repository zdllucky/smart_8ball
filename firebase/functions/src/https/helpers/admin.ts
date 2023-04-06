import admin from "firebase-admin";

import serviceAccount from "../../../06.04.23.sa.json";

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount as admin.ServiceAccount),
  databaseURL: "https://smart-8ball-default-rtdb.firebaseio.com",
});

export default admin;
