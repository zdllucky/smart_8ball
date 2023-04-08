import fs from "fs";
import { exec } from "child_process";

// Read the configuration from the JSON file
const configFilePath = "config.json";
const configData = JSON.parse(fs.readFileSync(configFilePath, "utf8"));

// Set environment variables for each configuration key
const setEnvironmentVariable = (
  namespace: string,
  key: string,
  value: string
): Promise<void> => {
  return new Promise((resolve, reject) => {
    const fullKey = `${namespace}.${key}`;
    console.log(`Setting ${fullKey}...`);

    exec(
      `firebase functions:config:set ${fullKey}="${value}"`,
      (error, stdout, stderr) => {
        if (error) {
          console.error(`Error setting ${fullKey}:`, error);
          reject(error);
        } else {
          console.log(`Set ${fullKey} successfully`);
          resolve();
        }
      }
    );
  });
};

(async () => {
  try {
    for (const namespace in configData) {
      const namespaceConfig = configData[namespace];

      for (const key in namespaceConfig) {
        await setEnvironmentVariable(namespace, key, namespaceConfig[key]);
      }
    }

    console.log("All environment variables set successfully");
  } catch (error) {
    console.error("Error setting environment variables:", error);
  }
})();
