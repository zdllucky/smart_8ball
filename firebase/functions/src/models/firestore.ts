import { z } from "zod";

const SubjectTypeModel = z.enum(["deviceId", "userId"]);
export const Collections = {
  anonymousUserLinks: {
    name: "anonymousUserLinks",
    documentModel: z.object({ linksTo: z.any() }),
  },
  userLink: {
    name: "linksTo",
    documentModel: z.object({ linkedAt: z.string().datetime() }),
  },
  triesAvailable: {
    name: "triesAvailable",
    documentModel: z.object({
      subjectType: SubjectTypeModel,
      resources: z.object({
        basicTries: z.number().int().nonnegative().safe().multipleOf(1),
      }),
    }),
  },
};
