import mariadb from 'mariadb';

async function generatePool(config) {
  const pool = mariadb.createPool(config);
  const conn = await pool.getConnection();
  return conn;
}

function generateConfig(config, withDatabase = true) {
  const result = {};
  result.host = config.host || '127.0.0.1';
  result.user = config.user || 'root';
  result.password = config.password || 'secret';
  if (withDatabase) {
    result.database = config.database || 'uas';
  }
  result.connectionLimit = config.connectionLimit || 5;
  result.port = config.port || 3333;
  result.multipleStatements = true;
  result.supportBigNumbers = true;
  return result;
}

export { generatePool, generateConfig };