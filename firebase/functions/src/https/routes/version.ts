import { z } from "zod";
import { basicFactory } from "../helpers/factories";
import { version } from "../../../package.json";

const Type = {
  getInput: z.object({}),
  getOutput: z.object({ version: z.string() }),
};

export const get = basicFactory.build({
  input: Type.getInput,
  output: Type.getOutput,
  method: "get",
  handler: async () => ({ version }),
});
