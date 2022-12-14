import { faker } from "@faker-js/faker";
import { __dirname } from "@/consts";
import { readSQLFile } from "@/helpers";
import { query, splitAndExecuteQuery } from "@/db";
import { UserRoom } from "../userRoom";
import { Group } from "./types";
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
  userRoomPairs: Array<UserRoom>
): Promise<Array<Group>> => {
  const requests: Array<Promise<unknown>> = [];
  for (let i = 0; i < count; i++) {
    const { ROOM_ID: roomId, USER_ID: userId } =
      faker.helpers.arrayElement(userRoomPairs);
    const params = {
      roomId,
      userId,
      name: JSON.stringify(faker.lorem.text().slice(0, 32)),
      mainColor: JSON.stringify(
        faker.color.rgb({ format: "hex", prefix: "#" })
      ),
      secondaryColor: JSON.stringify(
        faker.color.rgb({ format: "hex", prefix: "#" })
      ),
    };
    const request = query(
      `CALL ADD_GROUP(${params.roomId}, ${params.userId}, ${params.name}, ${params.mainColor}, ${params.secondaryColor});`
    );

    requests.push(request);
  }
  await Promise.all(requests);
  return query("SELECT * from `GROUPS`;");
};
