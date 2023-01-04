<script lang="ts">
declare const alertify: any;
declare const bootstrap: any;
</script>

<script setup lang="ts">
import { computed, onMounted, onUnmounted, ref, shallowRef, watch } from 'vue';
import { Codemirror } from 'vue-codemirror';
import { sql, MariaSQL } from '@codemirror/lang-sql';
import { server } from './variables';

const schema = ref<any>({
  "movie.film": [
    { label: 'film_id', type: 'keyword', info: 'INT' },
    { label: 'film_judul', type: 'variable', info: 'VARCHAR(50)' },
    { label: 'film_tahun', type: 'variable', info: 'YEAR(4)' },
    { label: 'film_durasi', type: 'variable', info: 'INT' },
    { label: 'film_bahasa', type: 'variable', info: 'VARCHAR(50)' },
    { label: 'film_tanggal_rilis', type: 'variable', info: 'DATE' },
    { label: 'film_negara_rilis', type: 'variable', info: 'VARCHAR(5)' }
  ],
  "movie.aktor": [
    { label: 'aktor_id', type: 'keyword', info: 'INT' },
    { label: 'aktor_nama_depan', type: 'variable', info: 'VARCHAR(20)' },
    { label: 'aktor_nama_belakang', type: 'variable', info: 'VARCHAR(20)' },
    { label: 'aktor_jenis_kelamin', type: 'variable', info: 'ENUM(...)' },
  ],
  "movie.pemeran_film": [
    { label: 'film_id', type: 'keyword', info: 'INT' },
    { label: 'aktor_id', type: 'keyword', info: 'INT' },
    { label: 'pemeran_film_peran', type: 'variable', info: 'VARCHAR(30)' }
  ],
  "movie.sutradara": [
    { label: 'sutradara_id', type: 'keyword', info: 'INT' },
    { label: 'sutradara_nama_depan', type: 'variable', info: 'VARCHAR(20)' },
    { label: 'sutradara_nama_belakang', type: 'variable', info: 'VARCHAR(20)' }
  ],
  "movie.sutradara_film": [
    { label: 'sutradara_id', type: 'keyword', info: 'INT' },
    { label: 'film_id', type: 'keyword', info: 'INT' }
  ],
  "movie.genre": [
    { label: 'genre_id', type: 'keyword', info: 'INT' },
    { label: 'genre_judul', type: 'variable', info: 'VARCHAR(20)' }
  ],
  "movie.genre_film": [
    { label: 'genre_id', type: 'keyword', info: 'INT' },
    { label: 'film_id', type: 'keyword', info: 'INT' }
  ],
  "movie.reviewer": [
    { label: 'reviewer_id', type: 'keyword', info: 'INT' },
    { label: 'reviewer_nama', type: 'variable', info: 'VARCHAR(30)' }
  ],
  "movie.rating": [
    { label: 'film_id', type: 'keyword', info: 'INT' },
    { label: 'reviewer_id', type: 'keyword', info: 'INT' },
    { label: 'rating_nilai', type: 'variable', info: 'INT(1)' },
    { label: 'rating_total', type: 'variable', info: 'INT' }
  ],
  "movie.aktor_id": [""],
  "movie.aktor_jenis_kelamin": [""],
  "movie.aktor_nama_belakang": [""],
  "movie.aktor_nama_depan": [""],
  "movie.film_bahasa": [""],
  "movie.film_durasi": [""],
  "movie.film_id": [""],
  "movie.film_judul": [""],
  "movie.film_negara_rilis": [""],
  "movie.film_tahun": [""],
  "movie.film_tanggal_rilis": [""],
  "movie.genre_id": [""],
  "movie.genre_judul": [""],
  "movie.pemeran_film_peran": [""],
  "movie.rating_nilai": [""],
  "movie.rating_total": [""],
  "movie.reviewer_id": [""],
  "movie.reviewer_nama": [""],
  "movie.sutradara_id": [""],
  "movie.sutradara_nama_belakang": [""],
  "movie.sutradara_nama_depan": [""],
});

function removeSchemaString(label: any) {
  const arr = label.split('.');
  return arr[arr.length - 1];
}

const extensions = [
  sql({
    upperCaseKeywords: true,
    dialect: MariaSQL,
    schema: schema.value,
    defaultSchema: 'movie'
  })
];

const started = ref(false);
const loggedIn = ref(false);

const nim = ref('');
const pin = ref('');
const sending = ref(false);
const user = ref<{
  nim: string; nama: string; thumbnail: string; token: string,
  jawaban: {
    nomor: number; jawaban: string; benar: boolean;
  }[]
}>({ nim: '', nama: '', thumbnail: '', token: '', jawaban: [] });

/**
 * Login
 */
async function tryLogin() {
  if (nim.value.length < 8 || pin.value.length < 4) {
    return;
  }
  sending.value = true;
  const respon = await fetch('https://api.unira.ac.id/v1/token', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: `username=${nim.value}&password=${pin.value}&client=external`,
  });
  // jika respon header 422, berarti login gagal
  if (respon.status === 422) {
    alertify.alert('Gagal', 'Gagal Masuk Aplikasi');
    sending.value = false; return;
  }
  const data = await respon.json();
  const token = data.data.attributes.access;
  // jika respon header 200, berarti login berhasil
  // ambil data saya
  const respon2 = await fetch('https://api.unira.ac.id/v1/saya', {
    headers: {
      Authorization: `Bearer ${token}`,
    },
  });
  const mhs = await respon2.json();
  // set ke data user
  user.value = {
    nim: mhs.data.id, nama: mhs.data.attributes.nama, thumbnail: mhs.data.attributes.thumbnail, token: token, jawaban: [],
  };
  // set ke localstorage
  // apakah sudah ada jawaban sebelumnya?
  const jawaban = localStorage.getItem(mhs.data.id);
  if (jawaban) {
    const jawabanObj = JSON.parse(jawaban);
    user.value.jawaban = jawabanObj.jawaban;
  }
  localStorage.setItem(mhs.data.id, JSON.stringify(user.value));
  localStorage.setItem('lastLogin', mhs.data.id);
  
  loggedIn.value = true;
  const modal = bootstrap.Modal.getOrCreateInstance(document.querySelector('#loginModal'));
  modal.hide();
}

const query = ref('');
const view = shallowRef();
const handleReady = (editor: any) => {
  view.value = editor.view;
};
function log(event: any, ...args: any[]) {
  // console.log(event, ...args);
}

async function start() {
  started.value = true;
  await loadPertanyaan();
  document.addEventListener('keydown', keypress);
  // const textarea = document.querySelector('textarea')!;
  // textarea.addEventListener('keydown', event => {
  //   if (event.key === 'Tab') {
  //     const start = textarea.selectionStart;
  //     const end = textarea.selectionEnd;
  //     textarea.value = textarea.value.substring(0, start) + '  ' + textarea.value.substring(end);
  //     textarea.selectionStart = textarea.selectionEnd = start + 2;
  //     event.preventDefault()
  //   }
  // });
}

const currentSoal = ref(-1);
const soalList = ref<any[]>([]);
async function loadPertanyaan() {
  if (soalList.value.length === 0) {
    const response = await fetch(`${server}/soal?nim=${user.value.nim}`);
    const data = await response.json();
    soalList.value = data;
    currentSoal.value = 0;
  }
}
const soal = computed(() => {
  if (soalList.value.length === 0) {
    return { soal: '::' };
  }
  return soalList.value[currentSoal.value];
});
function checkJawaban(i: number) {
  if (user.value.jawaban.length === 0) {
    return false;
  }
  const jawaban = user.value.jawaban[i];
  if (!jawaban) {
    return false;
  }
  return jawaban.benar;
}
function setFieldJawaban() {
  // apakah ada jawaaban sebelumnya?
  const jawaban = user.value.jawaban[currentSoal.value];
  query.value = jawaban ? jawaban.jawaban : '';
}
function changeSoal(i: number) {
  currentSoal.value = i;
  const offCanvas = bootstrap.Offcanvas.getOrCreateInstance(document.querySelector('#offcanvasExample'));
  offCanvas.hide();
}
function skipSoal() {
  if (currentSoal.value < soalList.value.length - 1) {
    currentSoal.value++;
  }
}

const output = ref<{ keys: any[], values: any[] }>({ keys: [], values: [] });
async function executeSQL() {
  const respon = await fetch(`${server}/jawab`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      nim: user.value.nim,
      soal: currentSoal.value + 1,
      sql: query.value,
    }),
  });
  const data = await respon.json();
  
  // update jawaban
  user.value.jawaban[currentSoal.value] = {
    nomor: currentSoal.value + 1,
    jawaban: query.value,
    benar: data.status,
  };
  // simpan ke localstorage
  localStorage.setItem(user.value.nim, JSON.stringify(user.value));

  if (data.status) {
    alertify.alert('Benar', 'Jawaban Anda Benar');
    // next soal
    skipSoal();
  } else {
    alertify.notify('Jawaban Anda Salah!', 'error', 5);
  }

  // show output
  // sometimes output is string error from query error
  try {
    const o = JSON.parse(data.output);
    output.value = {
      keys: Object.keys(o[0]),
      values: o.map((o: any) => {
        return Object.values(o);
      }),
    };
  } catch (e) {
    output.value = {
      keys: ['Error Message'],
      values: [[data.output]],
    };
  }
}

function keypress(e: KeyboardEvent) {
  // if Ctrl + R pressed
  if (e.ctrlKey && e.key === 'r') {
    executeSQL();
    e.preventDefault();
    e.stopPropagation();
  }
}

async function logout() {
  localStorage.removeItem('lastLogin');
  const token = user.value.token;
  loggedIn.value = false;
  started.value = false;
  query.value = '';
  output.value = { keys: [], values: [] };
  targetOutput.value = { keys: [], values: [] };
  user.value = { nim: '', nama: '', thumbnail: '', token: '', jawaban: [] };
  // send delete request
  await fetch('https://api.unira.ac.id/v1/token', {
    method: 'DELETE',
    headers: { Authorization: `Bearer ${token}` },
  });
}

const targetOutput = ref<{ keys: any[], values: any[] }>();
watch(currentSoal, async () => {
  setFieldJawaban();
  // load output
  if (started.value) {
    const respon = await fetch(`${server}/output/${currentSoal.value + 1}`);
    const data = await respon.json();
    const output = JSON.parse(data.output);
    // output is array with object { key: value }
    // we need to capture key and then flatten value
    const keys = Object.keys(output[0]);
    const values = output.map((o: any) => {
      return keys.map((k: string) => o[k]);
    });
    targetOutput.value = {
      keys,
      values,
    };
  }
}, { immediate: true });

onMounted(() => {
  // cek apakah ada data user di localstorage
  const d = localStorage.getItem('lastLogin');
  if (d && d.length > 0) {
    loggedIn.value = true;
    user.value = JSON.parse(localStorage.getItem(d)!);
  }
});

onUnmounted(() => {
  document.removeEventListener('keydown', keypress);
});
</script>

<template>
  <nav class="navbar bg-light shadow-sm">
    <div class="container-fluid">
      <button class="navbar-brand d-flex align-items-center btn shadow-sm" type="button" @click="executeSQL()" :disabled="! loggedIn" :class="! loggedIn ? 'btn-outline-warning' : 'btn-warning fw-bold'">
        <i class="bx bx-play-circle text-success" style="font-size: 30px;"></i>
        <span class="ms-2 fs-6">Eksekusi SQL</span>
      </button>
      <form>
        <button class="btn btn-primary py-2 shadow-sm" data-bs-toggle="modal" data-bs-target="#loginModal" type="button" v-if="! loggedIn"><i class="bx bx-log-in-circle"></i> Masuk Aplikasi</button>
        <button class="btn btn-dark py-2 shadow-sm" type="button" @click="logout()" v-else><i class="bx bx-log-out-circle"></i> Keluar Aplikasi</button>
      </form>
    </div>
  </nav>
  <div class="main-content">
    <aside class="my-2 mx-2">
      <div class="d-grid gap-2">
        <button class="btn btn-lg btn-outline-info fs-6 fw-bold" :disabled="! loggedIn || ! started" data-bs-toggle="offcanvas" href="#offcanvasExample" @click="loadPertanyaan()">Lihat Pertanyaan</button>
        <button class="btn btn-lg btn-outline-info fs-6 fw-bold" data-bs-toggle="modal" data-bs-target="#tableModal">Struktur Tabel</button>

        <div class="card text-bg-light" v-if="loggedIn">
          <div class="card-body text-center">
            <img :src="`https://api.unira.ac.id/${user.thumbnail}`" class="rounded mx-auto d-block shadow-sm" alt="" style="max-width: 110px">
            <h4 class="mb-0 mt-2 fs-5">{{ user.nim }}</h4>
            <h5 class="mb-0 fs-6 text-muted">{{ user.nama }}</h5>
          </div>
        </div>
      </div>
    </aside>
    <main class="mt-1">
      
      <codemirror
        v-model="query"
        :extensions="extensions"
        placeholder="Tulis perintah SQL disini..."
        :tab-size="2"
        @ready="handleReady"
        @change="log('change', $event)"
        @blur="log('blur', $event)"
        @focus="log('focus', $event)"
        :style="{ height: '190px' }"
        :disabled="! loggedIn || ! started"
      ></codemirror> 
      
      <div class="result">
        <div class="card shadow-sm">
          <div class="card-body">
            <h5 class="card-title text-center">Hasil Eksekusi</h5>
            <hr>
            <div id="result-box" style="overflow: auto; max-height: 200px;">
              <p class="mb-0 text-center" v-if="output.keys.length === 0">Hasil query akan muncul disini. Klik <strong>Eksekusi SQL</strong> atau tekan <strong>Ctrl + R</strong> untuk mengeksekusi query</p>
              <div class="table-responsive" v-else>
                <table class="table mb-0 table-bordered table-sm table-striped table-hover" style="font-size: 13px">
                  <thead>
                    <tr>
                      <th scope="col" v-for="key in output?.keys">{{ key }}</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="row in output?.values">
                      <td v-for="key in row">{{ key }}</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
    <aside class="my-2 mx-2">
      <div class="d-grid gap-2">
        <!-- tombol mulai mengerjakan  -->
        <button class="btn btn-lg py-2 shadow-sm btn-danger fs-5 fw-light" v-if="! started" :disabled="! loggedIn" @click="start"><i class="bx bx-play"></i> Mulai Mengerjakan</button>
        
        <section>
          <div class="card text-bg-light shadow-sm">
            <div class="card-body">
              <div class="alert alert-info mb-0 lh-1 fs-6 text-center" v-if="! loggedIn">
                <i class="bx bx-info-circle"></i> <span class="fw-bold">Petunjuk:</span> Silahkan klik tombol <strong>MASUK APLIKASI</strong> dan kemudian tekan tombol <span class="fw-bold">Mulai Mengerjakan</span> untuk memulai mengerjakan soal.
              </div>
              <div class="alert alert-info mb-0 lh-1 fs-6 text-center" v-if="loggedIn && ! started">
                <i class="bx bx-info-circle"></i> <span class="fw-bold">Petunjuk:</span> Silahkan klik tombol <span class="fw-bold">Mulai Mengerjakan</span> untuk memulai mengerjakan soal.
              </div>

              <div v-if="loggedIn && started">
                <h5 class="card-title"># {{ currentSoal + 1 }}</h5>
                <hr>
                <p class="mb-4 question fst-italic">{{ soal.soal.split('::')[1] }}</p>
                <!-- large skip button -->
                <div class="d-grid gap mt-3">
                  <button class="btn btn-lg btn-outline-danger fs-6 fw-bold" :disabled="currentSoal == soalList.length - 1" @click="skipSoal()"><i class="bx bx-redo"></i> Lewati Soal</button>
                </div>
              </div>
            </div>
          </div>

          <!-- Expected Output  -->
          <div class="card text-bg-light shadow-sm mt-3" style="max-height: 250px; overflow: auto" v-if="started">
            <div class="card-body">
              <h5 class="card-title">Target Output</h5>
              <div class="table-responsive">
                <table class="table mb-0 table-bordered table-sm table-striped table-hover" style="font-size: 13px">
                  <thead>
                    <tr>
                      <th scope="col" v-for="key in targetOutput?.keys">{{ key }}</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="row in targetOutput?.values">
                      <td v-for="key in row">{{ key }}</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </section>
      </div>
    </aside>
    <footer>
      <div class="container pt-3 text-muted">
        &copy; 2022 - <a href="https://monazdev.com" target="_blank" class="text-info">Nazir Arifin</a> - Eksekusi SQL Online Untuk Ujian Sistem Basis Data
      </div>
    </footer>
  </div>

  <!-- modal -->
  <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="loginModalLabel">Masuk Aplikasi</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <form>
            <div class="mb-3">
              <label for="npm" class="form-label">NPM</label>
              <input type="text" class="form-control" v-model="nim" required minlength="8" maxlength="10" id="npm" placeholder="Nomor Pokok Mahasiswa">
            </div>
            <div class="mb-3">
              <label for="password" class="form-label">PIN</label>
              <input type="password" v-model="pin" required minlength="4" maxlength="6" class="form-control" id="password" placeholder="Personal Identification Number">
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-primary" :disabled="(nim.length < 8 || pin.length < 4) || sending" @click="tryLogin()">Masuk Aplikasi</button>
        </div>
      </div>
    </div>
  </div>

  <!-- modal untuk struktur table -->
  <div class="modal fade" id="tableModal" tabindex="-1" aria-labelledby="tableModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
      <div class="modal-content">
        <div class="modal-body">
          <div class="row">
            <div class="col-sm-4">
              <!-- <h4 class="text-center fw-light mb-4">&nbsp;</h4> -->
              <div class="accordion" id="accordionFlushExample">
                <template v-for="(t, i) in schema" :key="i">
                  <div class="accordion-item" v-if="typeof t[0] != 'string'">
                    <h2 class="accordion-header" :id="`acc-${removeSchemaString(i)}`">
                      <button class="accordion-button collapsed fw-bold py-2" type="button" data-bs-toggle="collapse" :data-bs-target="`#accolp-${removeSchemaString(i)}`" aria-expanded="false" :aria-controls="`accolp-${removeSchemaString(i)}`">{{ removeSchemaString(i) }}
                      </button>
                    </h2>
                    <div :id="`accolp-${removeSchemaString(i)}`" class="accordion-collapse collapse" :aria-labelledby="`acc-${removeSchemaString(i)}`" data-bs-parent="#accordionFlushExample">
                      <div class="accordion-body py-2">
                        <div class="row" v-for="(item, k) in t" :key="k">
                          <div class="col-sm-1"><i class="bx" :class="item.type == 'keyword' ? 'bx-key' : 'bx-radio-circle'"></i></div>
                          <div class="col-sm-7">{{ item.label }}</div>
                          <div class="col-sm-4 text-end">{{ item.info }}</div>
                        </div>
                      </div>
                    </div>
                  </div>
                </template>
              </div>
            </div>
            <div class="col-sm-6 offset-sm-2">
              <img src="/uas.png" class="img-fluid" alt="diagram">
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasExample" aria-labelledby="offcanvasExampleLabel">
    <div class="offcanvas-header">
      <h5 class="offcanvas-title" id="offcanvasExampleLabel">Daftar Pertanyaan</h5>
      <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body">
      <ol class="list-group list-group-numbered">
        <template v-for="(s, i) in soalList" :key="i">
          <a href="" @click.prevent="changeSoal(i)" class="text-decoration-none text-muted">
            <li class="list-group-item d-flex justify-content-between align-items-start" :class="{ 'bg-light': i == currentSoal }">
              <div class="ms-2 me-auto">
                <div class="mb-2 badge bg-info">{{ s.soal.split('::')[0] }}</div>
                <span class="question d-block">{{ s.soal.split('::')[1] }}</span>
              </div>
              <span class="badge rounded-pill" :class="checkJawaban(i) ? 'bg-success' : 'bg-danger'"><i class="bx" :class="checkJawaban(i) ? 'bx-check' : 'bx-x'"></i></span>
            </li>
          </a>
        </template>
      </ol>
    </div>
  </div>
</template>

<style scoped>
.editor {
  display: flex;
  font-family: 'Fira Code', Consolas, monospace;
  line-height: 21px;
  border-radius: 2px;
  padding: 5px 0px;
  background-color: #f5f5f5;
  border: 1px solid #e5e5e5;
}

.line-numbers {
  width: 30px;
  padding-right: 15px;
  padding-left: 5px;
  text-align: right;
  background-color: #f5f5f5;
  border-right: 1px solid #e5e5e5;
}

.line-numbers span {
  counter-increment:  linenumber;
}

.line-numbers span::before {
  content: counter(linenumber);
  display: block;
  /* color is the same as the border color of the textarea but darken 30% */
  color: #e5e5e5;
}

textarea {
  line-height: 21px;
  overflow-y: hidden;
  padding: 0;
  border: 0;
  min-width: 500px;
  outline: none;
  resize: none;
  flex-grow: 1;
}

.accordion-body {
  font-size: 12px;
}

.list-group-item {
  line-height: .8rem;
}
.list-group-item span.question {
  font-size: 14px;
}
.list-group-numbered>.list-group-item::before {
  line-height: 1.1rem;
}
</style>