import { splitAndExecuteQuery } from "@/db";
import { __dirname } from "@/consts";
import { readSQLFile } from "@/helpers";
import table from "./table.sql";
import procedures from "./procedures.sql";
import triggers from "./triggers.sql";
import api from "./api.sql";

export const createTable = async () => {
  const tableSQL = await readSQLFile(table);
  await splitAndExecuteQuery(tableSQL);
};

export const createProcedures = async () => {
  const proceduresSQL = await readSQLFile(procedures);
  await splitAndExecuteQuery(proceduresSQL, "END; ");
};

export const createTriggers = async () => {
  const triggersSQL = await readSQLFile(triggers);
  await splitAndExecuteQuery(triggersSQL, "END; ");
};


export const createApi = async () => {
  const apiSQL = await readSQLFile(api);
  await splitAndExecuteQuery(apiSQL, "END; ");
};
