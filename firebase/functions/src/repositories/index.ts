import { createHttpError } from "express-zod-api";
import _admin from "../services/admin";
import { Collections } from "../models/firestore";

const anonymousUserLinks = ({ admin }: { admin: typeof _admin }) => {
  const aULMeta = Collections.anonymousUserLinks;
  const uLMeta = Collections.userLink;

  const reference = admin
    .firestore()
    .collection(aULMeta.name)
    .withConverter({
      toFirestore: (data) => aULMeta.documentModel.parse(data),
      fromFirestore: (snap) => aULMeta.documentModel.parse(snap.data()),
    });

  const linksToReference = (deviceId: string) =>
    reference
      .doc(deviceId)
      .collection(uLMeta.name)
      .withConverter({
        toFirestore: (data) => uLMeta.documentModel.parse(data),
        fromFirestore: (snap) => uLMeta.documentModel.parse(snap.data()),
      });

  return { reference, linksToReference };
};

const triesAvailable = ({ admin }: { admin: typeof _admin }) => {
  const meta = Collections.triesAvailable;
  const reference = admin
    .firestore()
    .collection(meta.name)
    .withConverter({
      toFirestore: (data) => meta.documentModel.parse(data),
      fromFirestore: (snap) => meta.documentModel.parse(snap.data()),
    });

  const getResources = async (deviceId: string) => {
    const tADSnapshot = await reference.doc(deviceId).get();

    if (!tADSnapshot.exists)
      throw createHttpError(500, "Document doesn't exist");

    return tADSnapshot.data()!.resources;
  };

  return { reference, getResources };
};

export default {
  anonymousUserLinks: anonymousUserLinks({ admin: _admin }),
  triesAvailable: triesAvailable({ admin: _admin }),
};
