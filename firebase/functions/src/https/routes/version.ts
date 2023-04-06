import { z } from "zod";
import { basicFactory } from "../helpers/factories";

const Type = {
  getInput: z.object({}),
  getOutput: z.object({ stub: z.string() }),
};

export const get = basicFactory.build({
  input: Type.getInput,
  output: Type.getOutput,
  method: "get",
  handler: async () => ({ stub: "1.0.1" }),
});
