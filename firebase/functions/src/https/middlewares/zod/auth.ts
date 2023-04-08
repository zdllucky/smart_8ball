import { z } from "zod";
import { createMiddleware } from "express-zod-api";
// import admin from "../../helpers/admin";

const authMiddleware = createMiddleware({
  security: { or: [{ type: "cookie", name: "__session" }, { type: "bearer" }] },
  input: z.object({}),
  middleware: async ({ request: req, logger, response: res }) => {
    logger.info("authMiddleware", {
      headers: req.headers,
      cookies: req.cookies,
    });
    if (
      (!req.headers.authorization ||
        !req.headers.authorization.startsWith("Bearer ")) &&
      !(req.cookies && req.cookies.__session)
    ) {
      logger.error(
        "No Firebase ID token was passed as a Bearer token in the Authorization header.",
        "Make sure you authorize your request by providing the following HTTP header:",
        "Authorization: Bearer <Firebase ID Token>",
        'or by passing a "__session" cookie.'
      );
      res.status(403).send("Unauthorized");
    }
    return {};

    // let idToken;
    // if (
    //   req.headers.authorization &&
    //   req.headers.authorization.startsWith("Bearer ")
    // ) {
    //   logger.info('Found "Authorization" header');
    //   // Read the ID Token from the Authorization header.
    //   idToken = req.headers.authorization.split("Bearer ")[1];
    // } else if (req.cookies) {
    //   logger.info('Found "__session" cookie');
    //   // Read the ID Token from cookie.
    //   idToken = req.cookies.__session;
    // } else {
    //   // No cookie
    //   res.status(403).send("Unauthorized");
    //   return;
    // }
    //
    // try {
    //   const decodedIdToken = await admin.auth().verifyIdToken(idToken);
    //   logger.log("ID Token correctly decoded", decodedIdToken);
    //   req.user = decodedIdToken;
    //   next();
    //   return;
    // } catch (error) {
    //   logger.error("Error while verifying Firebase ID token:", error);
    //   res.status(403).send("Unauthorized");
    //   return;
    // }
  },
});

export default authMiddleware;
//
// // async function _authMiddleware(req, res, next) {
// //   if (
// //     !req.headers.authorization ||
// //     !req.headers.authorization.startsWith("Bearer ")
// //   ) {
// //     res.status(403).send("Unauthorized");
// //     return;
// //   }
// //
// //   const idToken = req.headers.authorization.split("Bearer ")[1];
// //
// //   try {
// //     const decodedIdToken = await admin.auth().verifyIdToken(idToken);
// //     req.context = {
// //       auth: {
// //         uid: decodedIdToken.uid,
// //         token: decodedIdToken,
// //       },
// //       rawRequest: req,
// //       timestamp: Date.now(),
// //     };
// //     next();
// //   } catch (error) {
// //     res.status(403).send("Unauthorized");
// //   }
// // }
