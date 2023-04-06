import { DependsOnMethod } from "express-zod-api";
import { get } from "./version";

// @ts-ignore
const d = (r: typeof DependsOnMethod.constructor.arguments) =>
  new DependsOnMethod(r);

export default {
  rest: {
    v1: {
      version: get,
      // product: {
      // 	"": d(productsRoute),
      // 	":id": {
      // 		"": d(productRoute),
      // 		relation: d(relationRoute),
      // 	},
      // },
      // category: d(categoriesRoute),
      // data: {
      // 	":id": d(dataRoute),
      // },
    },
  },
};
