import winston from "winston";
import { LoggingWinston } from "@google-cloud/logging-winston";

const loggingWinston = new LoggingWinston();

const logger = winston.createLogger({
  level: "debug",
  transports: [
    new winston.transports.Console({
      format: winston.format.combine(
        winston.format.timestamp(),
        winston.format.uncolorize(),
        winston.format.json()
        // winston.format.printf(
        //   ({ timestamp, level, message }) => {
        //     return `${timestamp} [${level}]: ${message}`;
        //   }
        // )
      ),
    }),
    loggingWinston,
  ],
});

export default logger;
