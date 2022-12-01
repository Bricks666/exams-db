import { join } from "node:path";
import { readFile } from "node:fs/promises";
import { __dirname } from "@/consts";

export const readSQLFile = async (path: string): Promise<string> => {
  const res = await readFile(join(__dirname, path));
  const sql = res.toString();
  return sql.replace(/[\s]{1,}/g, " ").replaceAll('""', "''");
};
