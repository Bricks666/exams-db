import { connect } from "@/db";
import {
  usersHandlers,
  roomsHandlers,
  userRoomHandlers,
  groupsHandlers,
  tasksHandlers,
  commentsHandlers,
  activitiesHandlers,
} from "@/models";

const start = async () => {
  await connect({
    user: "root",
    password: "1234",
    initSql: [
      "DROP DATABASE IF EXISTS `TASKS_MANAGER`;",
      "CREATE DATABASE `TASKS_MANAGER`;",
      "USE `TASKS_MANAGER`;",
    ],
    insertIdAsNumber: true,
    bigIntAsNumber: true,
    allowPublicKeyRetrieval: true,
  });

  await usersHandlers.createTable();
  await usersHandlers.createApi();
  await roomsHandlers.createTable();
  await roomsHandlers.createProcedures();
  await roomsHandlers.createApi();
  await userRoomHandlers.createTable();
  await userRoomHandlers.createApi();
  await groupsHandlers.createTable();
  await groupsHandlers.createApi();
  await tasksHandlers.createTable();
  await tasksHandlers.createApi();
  await commentsHandlers.createTable();
  await commentsHandlers.createApi();
  await activitiesHandlers.createTable();
  await activitiesHandlers.createProcedures();
  await activitiesHandlers.createTriggers();
  const userIds = await usersHandlers.generate(15);
  const roomIds = await roomsHandlers.generate(3);
  const userRoomPairs = await userRoomHandlers.generate(6, userIds, roomIds);
  const groupRoomIds = await groupsHandlers.generate(15, userRoomPairs);
  const taskRoomIds = await tasksHandlers.generate(
    50,
    groupRoomIds,
    userRoomPairs
  );
  await commentsHandlers.generate(99, taskRoomIds, userRoomPairs);
};
start();
