import { https } from "firebase-functions";
import createApp from "./https";
import express from "express";
import * as firestoreTriggers from "./triggers/firestore";
// import * as authTriggers from "./triggers/auth";

export const app = https.onRequest(createApp(express()));
export default { ...firestoreTriggers /* ...authTriggers */ };
