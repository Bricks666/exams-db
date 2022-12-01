import { Connection, ConnectionConfig, createConnection } from "mariadb";

let connection: Connection;

export const connect = async (options: ConnectionConfig) => {
  connection = await createConnection(options);
};

export const query = <T>(sql: string): Promise<Array<T>> => {
  return connection.query(sql);
};

export const splitAndExecuteQuery = async (sql: string, separator = ";") => {
  const queries =
    separator !== "" ? sql.split(separator).filter(Boolean) : [sql];

  for (const q of queries) {
    if (!q) {
      return;
    }
    const result = await query(`${q}${separator}`);
    console.debug(result);
  }
};
