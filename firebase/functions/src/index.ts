import * as functions from "firebase-functions";
import createApp from "./https";
import express from "express";

export const app = functions.https.onRequest(createApp(express()));
