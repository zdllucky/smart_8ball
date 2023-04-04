const admin = require("firebase-admin");

// Use the application default credentials for authentication
const app = admin.initializeApp({
  projectId: "your-project-id", // Replace with your project ID
});

const firestore = app.firestore();
const emulatorSettings = {
  host: "localhost",
  port: 8080, // Make sure this matches the port in your firebase.json
};
firestore.useEmulator(emulatorSettings.host, emulatorSettings.port);

// eslint-disable-next-line require-jsdoc
async function populateFirestoreEmulator() {
  // Add your sample data as a JavaScript object
  firestore.addCollection()

  // Terminate the Firebase app after populating the emulator
  app.delete();
}

await populateFirestoreEmulator();
