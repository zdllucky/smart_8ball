import { createHttpError } from "express-zod-api";
import repositories from "../repositories";
import { FirebaseAdmin } from "./admin";

const resourcesService = ({
  triesRepo,
  admin,
}: {
  triesRepo: typeof repositories.triesAvailable;
  admin: FirebaseAdmin;
}) => {
  const addBasicTriesAmount = async (
    userOrDeviceId: string,
    amount: number,
    { allowNegative = false }: { allowNegative?: boolean } = {}
  ) => {
    await admin.firestore().runTransaction(async (transaction) => {
      const doc = triesRepo.reference.doc(userOrDeviceId);
      const { basicTries } = await triesRepo.getResources(userOrDeviceId);

      if (basicTries + amount < 0 && !allowNegative)
        throw createHttpError(400, "No tries available");

      transaction.update(doc, {
        "resources.basicTries": basicTries + amount,
      });
    });
  };

  return { addBasicTriesAmount };
};

export default resourcesService;
