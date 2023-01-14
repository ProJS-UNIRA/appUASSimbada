import mariadb from 'mariadb';

let mainPool;
let uasPool;
let mhsPool;
let moviePool;

async function generatePool(config, type) {
  switch (type) {
    case 'main':
      if (! mainPool) {
        mainPool = mariadb.createPool(config);
      }
      return mainPool;
    case 'uas':
      if (! uasPool) {
        uasPool = mariadb.createPool(config);
      }
      return uasPool;
    case 'mhs':
      if (! mhsPool) {
        mhsPool = mariadb.createPool(config);
      }
      return mhsPool;
    default:
      if (! moviePool) {
        moviePool = mariadb.createPool(config);
      }
      return moviePool;
  }
}

function generateConfig(config, withDatabase = true) {
  const result = {};
  result.host = config.host || '127.0.0.1';
  result.user = config.user || 'root';
  result.password = config.password || 'root';
  // result.password = config.password || 'secret';
  if (withDatabase) {
    result.database = config.database || 'uas';
  }
  result.connectionLimit = config.connectionLimit || 10;
  result.port = config.port || 3306;
  // result.port = config.port || 3333;
  result.multipleStatements = true;
  result.supportBigNumbers = true;
  return result;
}

export { generatePool, generateConfig };