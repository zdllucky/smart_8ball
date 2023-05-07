import winston, { format } from "winston";
import { LoggingWinston } from "@google-cloud/logging-winston";
import { isEmulator } from "../https/helpers/misc";

const loggingWinston = new LoggingWinston();

const logger = winston.createLogger({
  level: isEmulator ? "debug" : "info",
  format: winston.format.combine(
    format.timestamp(),
    format.uncolorize(),
    format.json()
  ),
  transports: [new winston.transports.Console(), loggingWinston],
});

export default logger;
