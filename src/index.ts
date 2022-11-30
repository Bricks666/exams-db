// import * as url from "node:url";
// import { join } from "node:path";
// import { readFile } from "node:fs/promises";
import { createConnection, Connection } from 'mariadb';
import { faker } from '@faker-js/faker';
let connection: Connection;
// const __dirname = url.fileURLToPath(new URL(".", import.meta.url));

const start = async () => {
	connection = await createConnection({
		user: 'root',
		password: 'Root123',
		initSql: [
			'CREATE DATABASE IF NOT EXISTS `TASKS_MANAGER`;',
			'USE `TASKS_MANAGER`;',
		],
	});
	// prettier-ignore
	// const databaseSQL = (
	//   await readSQLFile(join(__dirname, "..", "sql", "create.sql"))
	// )
	// const proceduresSQL = await readSQLFile(
	//   join(__dirname, "..", "sql", "procedures.sql")
	// );
	// const triggersSQL = await readSQLFile(
	//   join(__dirname, "..", "sql", "triggers.sql")
	// );
	// const apiSQL = await readSQLFile(join(__dirname, "..", "sql", "api.sql"));

	// await connection.query(databaseSQL);
	// await connection.query(proceduresSQL);
	// await connection.query(triggersSQL);
	// await connection.query(apiSQL);
	const userIds = await generateUsers(15);
	const roomIds = await generateRooms(3);
	const userRoomPairs = await generateUserRoom(6, userIds, roomIds);
	const groupRoomIds = await generateGroups(15, userRoomPairs);
	const taskRoomIds = await generateTasks(50, groupRoomIds, userRoomPairs);
	await generateComments(99, taskRoomIds, userRoomPairs);
};
// const readSQLFile = (path: string): Promise<string> => {
//   return readFile(path, { encoding: "utf8" }).then((sql) =>
//     sql.replace(/[\s]{1,}/g, " ").replaceAll('""', "''")
//   );
// };

const generateUsers = async (count: number): Promise<Array<number>> => {
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
		const request = connection.query(
			`CALL INSERT_USER(${params.login}, ${params.password}, ${params.photo});`
		);

		requests.push(request);
	}
	await Promise.all(requests);
	return connection
		.query('SELECT `ID` from `USERS`;')
		.then((res) => res.map(({ ID }: { ID: number }) => ID));
};

const generateRooms = async (count: number): Promise<Array<number>> => {
	const requests: Array<Promise<unknown>> = [];
	for (let i = 0; i < count; i++) {
		const params = {
			name: JSON.stringify(faker.lorem.lines().slice(0, 32)),
			description: JSON.stringify(faker.lorem.paragraph(1).slice(0, 255)),
		};
		const request = connection.query(
			`CALL INSERT_ROOM(${params.name}, ${params.description});`
		);

		requests.push(request);
	}
	await Promise.all(requests);
	return connection
		.query('SELECT `ID` from `ROOMS`;')
		.then((res) => res.map(({ ID }: { ID: number }) => ID));
};

const generateUserRoom = async (
	count: number,
	userIds: Array<number>,
	roomIds: Array<number>
): Promise<Array<{ USER_ID: number; ROOM_ID: number }>> => {
	const requests: Array<Promise<unknown>> = [];
	for (let i = 0; i < count; i++) {
		const params = {
			userId: faker.helpers.arrayElement(userIds),
			roomId: faker.helpers.arrayElement(roomIds),
		};
		const request = connection.query(
			`CALL INSERT_USER_ROOM(${params.userId}, ${params.roomId});`
		);

		requests.push(request);
	}
	await Promise.all(requests);
	return connection.query('SELECT `USER_ID`, `ROOM_ID` from `USER_ROOM`;');
};

const generateGroups = async (
	count: number,
	userRoomPairs: Array<{ USER_ID: number; ROOM_ID: number }>
): Promise<Array<{ ID: number; ROOM_ID: number }>> => {
	const requests: Array<Promise<unknown>> = [];
	for (let i = 0; i < count; i++) {
		const { ROOM_ID: roomId, USER_ID: userId } =
			faker.helpers.arrayElement(userRoomPairs);
		const params = {
			roomId,
			userId,
			name: JSON.stringify(faker.lorem.text().slice(0, 32)),
			mainColor: JSON.stringify(
				faker.color.rgb({ format: 'hex', prefix: '#' })
			),
			secondaryColor: JSON.stringify(
				faker.color.rgb({ format: 'hex', prefix: '#' })
			),
		};
		const request = connection.query(
			`CALL INSERT_GROUP(${params.roomId}, ${params.userId}, ${params.name}, ${params.mainColor}, ${params.secondaryColor});`
		);

		requests.push(request);
	}
	await Promise.all(requests);
	return connection.query('SELECT `ID`, `ROOM_ID` from `GROUPS`;');
};
const generateTasks = async (
	count: number,
	groupRoomIds: Array<{ ID: number; ROOM_ID: number }>,
	userRoomPairs: Array<{ USER_ID: number; ROOM_ID: number }>
): Promise<Array<{ ID: number; ROOM_ID: number }>> => {
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
					'DONE',
					'IN PROGRESS',
					'NEED REVIEW',
					'READY',
				])
			),
		};
		const request = connection.query(
			`CALL INSERT_TASK(${params.roomId}, ${params.groupId}, ${params.userId}, ${params.content}, ${params.status});`
		);

		requests.push(request);
	}
	await Promise.all(requests);
	return connection.query('SELECT `ID`, `ROOM_ID` from `TASKS`;');
};

const generateComments = async (
	count: number,
	taskRoomIds: Array<{ ID: number; ROOM_ID: number }>,
	userRoomPairs: Array<{ USER_ID: number; ROOM_ID: number }>
): Promise<Array<number>> => {
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
		const request = connection.query(
			`CALL INSERT_COMMENT(${params.taskId},  ${params.userId}, ${params.content});`
		);

		requests.push(request);
	}
	await Promise.all(requests);
	return connection.query('SELECT `ID`, `AUTHOR_ID` from `COMMENTS`;');
};

start();
