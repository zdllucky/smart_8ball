import repositories from "../repositories";
import admin from "./admin";
import openAIService from "./openAI";
import logger from "./logger";
import resourcesService from "./resources";
import userService from "./user";

export default {
  resources: resourcesService({
    triesRepo: repositories.triesAvailable,
    admin,
  }),
  openAI: openAIService({ logger }),
  admin,
  logger,
  user: userService({ admin }),
};
