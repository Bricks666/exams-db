import * as url from "node:url";
import { join } from "node:path";
import { readFile } from "node:fs/promises";
import { createConnection, Connection } from "mariadb";
import { faker } from "@faker-js/faker";
let connection: Connection;
const __dirname = url.fileURLToPath(new URL(".", import.meta.url));

const start = async () => {
  connection = await createConnection({
    user: "root",
    password: "1234",
    initSql: [
      "CREATE DATABASE IF NOT EXISTS `TASKS_MANAGER`;",
      "USE `TASKS_MANAGER`;",
    ],
  });
  // prettier-ignore
  const databaseSQL = (
    await readSQLFile(join(__dirname, "..", "sql", "create.sql"))
  )
  const proceduresSQL = await readSQLFile(
    join(__dirname, "..", "sql", "procedures.sql")
  );
  const triggersSQL = await readSQLFile(
    join(__dirname, "..", "sql", "triggers.sql")
  );
  const apiSQL = await readSQLFile(join(__dirname, "..", "sql", "api.sql"));

  await connection.query(databaseSQL);
  await connection.query(proceduresSQL);
  await connection.query(triggersSQL);
  await connection.query(apiSQL);
  await generateUsers(5);
};
const readSQLFile = (path: string): Promise<string> => {
  return readFile(path, { encoding: "utf8" }).then((sql) =>
    sql.replace(/[\s]{1,}/g, " ").replaceAll('""', "''")
  );
};

const generateUsers = async (count: number): Promise<Array<number>> => {
  const requests: Array<Promise<unknown>> = [];
  for (let i = 0; i < count; i++) {
    const request = connection.query(
      "CALL `INSERT_USER(:login, :password, :photo);`",
      {
        login: faker.internet.userName(),
        password: faker.internet.password(),
        photo: faker.helpers.arrayElement([faker.internet.avatar(), null]),
      }
    );

    requests.push(request);
  }

  await Promise.all(requests);
  console.log(await connection.query("SELECT `ID` from `USERS`;"));
  return connection.query("SELECT `ID` from `USERS`;");
};

start();
