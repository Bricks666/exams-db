import { faker } from "@faker-js/faker";
import { __dirname } from "@/consts";
import { readSQLFile } from "@/helpers";
import { query, splitAndExecuteQuery } from "@/db";
import { Room } from "./types";
import procedures from "./procedures.sql";
import table from "./table.sql";
import api from "./api.sql";

export const createTable = async () => {
  const tableSQL = await readSQLFile(table);
  await splitAndExecuteQuery(tableSQL);
};

export const createProcedures = async () => {
  const proceduresSQL = await readSQLFile(procedures);
  await splitAndExecuteQuery(proceduresSQL, "END; ");
};

export const createApi = async () => {
  const apiSQL = await readSQLFile(api);
  await splitAndExecuteQuery(apiSQL, "END; ");
};

export const generate = async (count: number): Promise<Array<number>> => {
  const requests: Array<Promise<unknown>> = [];
  for (let i = 0; i < count; i++) {
    const params = {
      name: JSON.stringify(faker.lorem.lines().slice(0, 32)),
      description: JSON.stringify(faker.lorem.paragraph(1).slice(0, 255)),
    };
    const request = query(
      `CALL INSERT_ROOM(${params.name}, ${params.description});`
    );

    requests.push(request);
  }
  await Promise.all(requests);
  return query<Room>("SELECT * from `ROOMS`;").then((res) =>
    res.map(({ ID }) => ID)
  );
};
