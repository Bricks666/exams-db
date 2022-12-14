import { faker } from "@faker-js/faker";
import { __dirname } from "@/consts";
import { readSQLFile } from "@/helpers";
import { query, splitAndExecuteQuery } from "@/db";
import { Group } from "../groups";
import { UserRoom } from "../userRoom";
import { Task } from "./types";
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
  groupRoomIds: Array<Group>,
  userRoomPairs: Array<UserRoom>
): Promise<Array<Task>> => {
  const requests: Array<Promise<unknown>> = [];
  for (let i = 0; i < count; i++) {
    const { ROOM_ID: roomId, USER_ID: userId } =
      faker.helpers.arrayElement(userRoomPairs);
    const group = faker.helpers.arrayElement(
      groupRoomIds.filter(({ ROOM_ID }) => ROOM_ID === roomId)
    );
    if (!group) {
      i--;
      continue;
    }
    const { ID: groupId } = group;
    const params = {
      roomId,
      userId,
      groupId,
      content: JSON.stringify(faker.lorem.text().slice(0, 128)),
      status: JSON.stringify(
        faker.helpers.arrayElement([
          "DONE",
          "IN PROGRESS",
          "NEED REVIEW",
          "READY",
        ])
      ),
    };
    const request = query(
      `CALL ADD_TASK(${params.roomId}, ${params.groupId}, ${params.userId}, ${params.content}, ${params.status});`
    );

    requests.push(request);
  }
  await Promise.all(requests);
  return query("SELECT * from `TASKS`;");
};
