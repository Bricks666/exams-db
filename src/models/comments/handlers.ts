import { faker } from "@faker-js/faker";
import { __dirname } from "@/consts";
import { readSQLFile } from "@/helpers";
import { query, splitAndExecuteQuery } from "@/db";
import { UserRoom } from "../userRoom";
import { Task } from "../tasks";
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
  taskRoomIds: Array<Task>,
  userRoomPairs: Array<UserRoom>
): Promise<Array<Comment>> => {
  const requests: Array<Promise<unknown>> = [];
  for (let i = 0; i < count; i++) {
    const { ROOM_ID: roomId, USER_ID: userId } =
      faker.helpers.arrayElement(userRoomPairs);
    const task = faker.helpers.arrayElement(
      taskRoomIds.filter(({ ROOM_ID }) => ROOM_ID === roomId)
    );
    if (!task) {
      i--;
      continue;
    }
    const { ID: taskId } = task;
    const params = {
      taskId,
      userId,
      content: JSON.stringify(faker.lorem.text().slice(0, 128)),
    };
    const request = query(
      `CALL INSERT_COMMENT(${params.taskId},  ${params.userId}, ${params.content});`
    );

    requests.push(request);
  }
  await Promise.all(requests);
  return query("SELECT * from `COMMENTS`;");
};
