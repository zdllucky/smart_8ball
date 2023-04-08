import { https } from "firebase-functions";
import createApp from "./https";
import express from "express";
import { onCreateUserLinkDocument } from "./firestore/onCreateUserLinkDocument";

export const app = https.onRequest(createApp(express()));
export default { onCreateUserLinkDocument };
