import { faker } from "@faker-js/faker";
import { __dirname } from "@/consts";
import { readSQLFile } from "@/helpers";
import { query, splitAndExecuteQuery } from "@/db";
import { UserRoom } from "./types";
import table from "./table.sql";
import api from "./api.sql";

export const createTable = async () => {
  const tableSQL = await readSQLFile(table);
  await splitAndExecuteQuery(tableSQL);
};

export const createApi = async () => {
  const apiSQL = await readSQLFile(api);
  await splitAndExecuteQuery(apiSQL, "END; ");
};

export const generate = async (
  count: number,
  userIds: Array<number>,
  roomIds: Array<number>
): Promise<Array<UserRoom>> => {
  const requests: Array<Promise<unknown>> = [];
  for (let i = 0; i < count; i++) {
    const params = {
      userId: faker.helpers.arrayElement(userIds),
      roomId: faker.helpers.arrayElement(roomIds),
    };
    const request = query(
      `CALL INSERT_USER_ROOM(${params.userId}, ${params.roomId});`
    );

    requests.push(request);
  }
  await Promise.all(requests);
  return query("SELECT * from `USER_ROOM`;");
};
