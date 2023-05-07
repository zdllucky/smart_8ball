import { Request } from "express";

export const getFullUrlFromReq = (req: Request) => {
  const protocol = req.headers["x-forwarded-proto"] || req.protocol;
  const host = req.headers["x-forwarded-host"] || req.headers["host"];
  let originalUrl = req.originalUrl || req.url;

  // Trim the right part of the originalUrl after the "app" string
  const indexOfApp = originalUrl.indexOf("app");
  if (indexOfApp >= 0) {
    originalUrl = originalUrl.substring(0, indexOfApp + "app".length);
  }

  return `${protocol}://${host}${originalUrl}`;
};

export const isEmulator =
  !!JSON.parse(process.env.FIREBASE_CONFIG || "{}").emulators ||
  process.env.FIREBASE_ENV === "emulator";
