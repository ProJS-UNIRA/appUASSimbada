import express from 'express';
import { generatePool, generateConfig } from './db.js';
import cors from 'cors';
import fs from 'fs';

const app = express();
app.use(cors());
app.use(express.json());

app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.get('/soal', async (req, res) => {
  // check if database exists from variable nim
  // if not, create database
  const mainPool = await generatePool(generateConfig({}, false));
  try {
    const nim = `db_${req.query.nim}`;
    const result = await mainPool.query(`SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '${nim}'`);
    if (result.length === 0) {
      await mainPool.query(`CREATE DATABASE ${nim}`);
      await mainPool.query(`USE ${nim}`);
      // import sql file
      const file = fs.readFileSync('./movie.sql', 'utf8').toString();
      await mainPool.query(file);
    }
    mainPool.end();
  } catch(err) {
    console.log(err);
    mainPool.end();
    return res.json(err);
  } finally {
    mainPool.end();
  }

  const pool = await generatePool(generateConfig({
    database: 'uas'
  }));
  try {
    const result = await pool.query('SELECT id, soal FROM soal');
    pool.end();
    return res.json(result);
  } catch(err) {
    console.log(err);
    pool.end();
    return res.json(err);
  } finally {
    pool.end();
  }
});

app.post('/jawab', async (req, res) => {
  const { nim, soal, sql } = req.body;

  // get expected output from database
  let expectedOutput = '';
  const mainPool = await generatePool(generateConfig({
    database: 'uas'
  }));
  try {
    const result = await mainPool.query(`SELECT output FROM soal WHERE id = ${soal}`);
    expectedOutput = result[0].output;
  } catch(err) {
    console.log(err);
    mainPool.end();
    return res.json(err);
  } finally {
    mainPool.end();
  }
  
  const pool = await generatePool(generateConfig({
    database: `db_${nim}`
  }));
  try {
    // sql must be not contain drop, alter, truncate, rename, insert, update, delete
    const sqlLowered = sql.toLowerCase();
    if (sqlLowered.includes('drop') || sqlLowered.includes('alter') || sqlLowered.includes('truncate') || sqlLowered.includes('rename') || sqlLowered.includes('insert') || sqlLowered.includes('update') || sqlLowered.includes('delete')) {
      pool.end();
      return res.json({
        output: 'SQL not allowed', status: false
      });
    }

    const result = await pool.query(sql);
    const output = JSON.stringify(result);
    // compare output with expected output
    if (expectedOutput.localeCompare(output) === 0) {
      // insert only if not exists
      const result = await mainPool.query(`SELECT COUNT(id) AS TOTAL FROM jawaban WHERE soal = ? AND nim = ?`, [soal, nim]);
      if (result[0].TOTAL === 0) {
        await mainPool.query(`INSERT INTO jawaban (soal, nim) VALUES (?, ?)`, [soal, nim]);
      }
      
      mainPool.end();
      pool.end();
      return res.json({
        output, status: true
      });
    }

    mainPool.end();
    pool.end();
    return res.json({
      output, status: false
    });
  } catch(err) {
    console.log(err);
    pool.end();
    return res.json({
      output: err.text, status: false
    });
  } finally {
    pool.end();
  }
});

app.get('/output/:id', async (req, res) => {
  const id = req.params.id;
  const pool = await generatePool(generateConfig({
    database: 'uas'
  }));

  try {
    const result = await pool.query(`SELECT output FROM soal WHERE id = ${id}`);
    pool.end();
    return res.json(result[0]);
  } catch(err) {
    console.log(err);
    pool.end();
    return res.json(err);
  } finally {
    pool.end();
  }
});

app.get('/nilai', async (req, res) => {

});

app.post('/test', async (req, res) => {
  const sql = req.body.sql;
  const pool = await generatePool(generateConfig({
    database: 'movie'
  }));
  try {
    const result = await pool.query(sql);
    pool.end();
    return res.json(result);
  } catch(err) {
    console.log(err);
    pool.end();
    return res.json(err);
  } finally {
    pool.end();
  }
});

app.listen(3000, () => {
  console.log('Server started on port 3000');
});