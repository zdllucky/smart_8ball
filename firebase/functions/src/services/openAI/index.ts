import { createHttpError } from "express-zod-api";
import { Configuration, OpenAIApi } from "openai";
import { openAIAPIKey, systemInstructionText } from "./env/secrets.prod.json";
import { Logger } from "winston";

const openAIService = ({ logger }: { logger: Logger }) => {
  const configuration = new Configuration({
    apiKey: openAIAPIKey,
  });
  const openai = new OpenAIApi(configuration);

  const getAnonymousModel3Dot5TurboAnswer = async (
    question: string
  ): Promise<string> => {
    try {
      const chat = await openai.createChatCompletion({
        model: "gpt-3.5-turbo",
        messages: [
          {
            role: "system",
            content: systemInstructionText,
          },
          {
            role: "user",
            content: question,
          },
        ],
      });

      const answer = chat.data.choices[0].message?.content;

      if (answer === undefined || answer === null || answer === "") {
        logger.error("OpenAI API response empty or undefined", {
          res: chat.data.choices,
        });
        throw createHttpError(400, "No words, sorry...");
      }

      return chat.data.choices[0].message?.content ?? "";
    } catch (e) {
      logger.error("OpenAI API error", { e });
      if (e instanceof createHttpError.HttpError) throw e;
      else
        throw createHttpError(400, "Couldn't answer your question, sorry...");
    }
  };

  return { getAnonymousModel3Dot5TurboAnswer };
};

export default openAIService;
