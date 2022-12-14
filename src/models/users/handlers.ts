import { faker } from "@faker-js/faker";
import { __dirname } from "@/consts";
import { readSQLFile } from "@/helpers";
import { query, splitAndExecuteQuery } from "@/db";
import table from "./table.sql";
import api from "./api.sql";
import { User } from "./types";

export const createTable = async () => {
  const tableSQL = await readSQLFile(table);
  await splitAndExecuteQuery(tableSQL);
};

export const createApi = async () => {
  const apiSQL = await readSQLFile(api);
  await splitAndExecuteQuery(apiSQL, "END; ");
};

export const generate = async (count: number): Promise<Array<number>> => {
  const requests: Array<Promise<unknown>> = [];
  for (let i = 0; i < count; i++) {
    const params = {
      login: JSON.stringify(faker.internet.userName().slice(0, 32)),
      password: JSON.stringify(faker.internet.password().slice(0, 255)),
      photo: JSON.stringify(
        faker.helpers.arrayElement([
          faker.internet.avatar().slice(0, 255),
          null,
        ])
      ),
    };
    const request = query(
      `CALL ADD_USER(${params.login}, ${params.password}, ${params.photo});`
    );

    requests.push(request);
  }
  await Promise.all(requests);
  return query<User>("SELECT * from `USERS`;").then((res) =>
    res.map(({ ID }) => ID)
  );
};
