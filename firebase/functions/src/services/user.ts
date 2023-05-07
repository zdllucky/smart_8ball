import { createHttpError } from "express-zod-api";
import { FirebaseAdmin } from "./admin";

const userService = ({ admin }: { admin: FirebaseAdmin }) => {
  const getUserOrDeviceId = async (
    uid: string,
    { deviceId }: { deviceId?: string }
  ) => {
    let userOrDeviceId: string;
    let isDeviceId: boolean;

    const user = await admin.auth().getUser(uid);

    if (user.providerData.length === 0) {
      userOrDeviceId = deviceId ?? user.customClaims?.deviceId;

      if (!userOrDeviceId)
        throw createHttpError(
          400,
          "No device is associated with this anonymous user"
        );
      isDeviceId = true;
    } else {
      userOrDeviceId = uid;
      isDeviceId = false;
    }

    return { userOrDeviceId, isDeviceId };
  };

  return { getUserOrDeviceId };
};

export default userService;
