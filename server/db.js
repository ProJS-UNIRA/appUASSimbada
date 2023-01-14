import mariadb from 'mariadb';

let mainPool;
let uasPool;
let mhsPool;
let moviePool;

async function generatePool(config, type) {
  let conn;
  switch (type) {
    case 'main':
      if (! mainPool) {
        mainPool = mariadb.createPool(config);
        conn = await mainPool.getConnection();
      }
      break;
    case 'uas':
      if (! uasPool) {
        uasPool = mariadb.createPool(config);
        conn = await uasPool.getConnection();
      }
      break;
    case 'mhs':
      if (! mhsPool) {
        mhsPool = mariadb.createPool(config);
        conn = await mhsPool.getConnection();
      }
      break;
    default:
      if (! moviePool) {
        moviePool = mariadb.createPool(config);
        conn = await moviePool.getConnection();
      }
      break;
  }
  return conn;
}

function generateConfig(config, withDatabase = true) {
  const result = {};
  result.host = config.host || '127.0.0.1';
  result.user = config.user || 'root';
  result.password = config.password || 'root';
  if (withDatabase) {
    result.database = config.database || 'uas';
  }
  result.connectionLimit = config.connectionLimit || 10;
  result.port = config.port || 3306;
  result.multipleStatements = true;
  result.supportBigNumbers = true;
  return result;
}

export { generatePool, generateConfig };