# RESTful JSON API WITH RUBY ON RAILS

**RESTful API Todo App** menggunakan **Ruby on Rails**, meliputi otentikasi JWT, CRUD Todos, CRUD Items (nested), pagination, dan versioning API.

---

## 1. Authentication Flow

### 1.1 User Registration — `POST /signup`
Membuat akun pengguna baru.

**Endpoint:** `/signup`  
**Method:** `POST`  
**Status:** `201 Created`
 
![Sign up](https://s3.ezgif.com/tmp/ezgif-34edd14638df31.gif)

---

### 1.2 User Login — `POST /auth/login`
Menggunakan kredensial untuk mendapatkan token autentikasi (JWT).

**Endpoint:** `/auth/login`  
**Method:** `POST`  
**Response:** Mengembalikan `auth_token`  
Token ini digunakan di **semua request berikutnya** sebagai:

![Login](https://s2.ezgif.com/tmp/ezgif-239d666f1cfb25.gif)

---

## 2. Todos API (CRUD Level 1)

> Semua endpoint di bawah ini memerlukan header:


### 2.1 Create Todo — `POST /todos`
Membuat sumber daya Todo baru.

**Status:** `201 Created`

![Sign up](https://s3.ezgif.com/tmp/ezgif-3d72e3cf3632e4.gif)

---

### 2.2 Get All Todos — `GET /todos`
Mengambil seluruh Todo milik user yang sedang login.

**Status:** `200 OK`

![Sign up](https://s3.ezgif.com/tmp/ezgif-331474056648b7.gif)

---

### 2.3 Get Single Todo — `GET /todos/:id`
Mengambil detail Todo tertentu.

**Contoh:** `/todos/1`  
**Status:** `200 OK`

![Sign up](https://s3.ezgif.com/tmp/ezgif-338f87245e9a31.gif)

---

### 2.4 Update Todo — `PUT /todos/:id`
Memperbarui judul Todo.

**Status:** `204 No Content`

![Sign up](https://s3.ezgif.com/tmp/ezgif-3486af23dee593.gif)

---

### 2.5 Delete Todo — `DELETE /todos/:id`
Menghapus Todo dari database.

**Status:** `204 No Content`

![Sign up](https://s3.ezgif.com/tmp/ezgif-38711290987834.gif)

---

## 3. Items API (CRUD Nested)

Item adalah sumber daya yang **berada di dalam** Todo (nested resources).

### 3.1 Create Item — `POST /todos/:todo_id/items`
Menambahkan item baru ke Todo tertentu.

**Status:** `201 Created`  
**Contoh:** `/todos/2/items`

![Sign up](https://s3.ezgif.com/tmp/ezgif-34e618a8f732b7.gif)

---

### 3.2 Update Item — `PUT /todos/:todo_id/items/:id`
Mengubah atribut item (mis. `done: true`).

**Status:** `204 No Content`

![Sign up](https://s3.ezgif.com/tmp/ezgif-368b1b485b676a.gif)

---

### 3.3 Delete Item — `DELETE /todos/:todo_id/items/:id`
Menghapus item tertentu.

**Status:** `204 No Content`

![Sign up](https://s3.ezgif.com/tmp/ezgif-3e77b4516c3749.gif)

---

## 4. Advanced Features

### 4.1 Pagination — `GET /todos?page=&per_page=`
Menampilkan hasil secara bertahap untuk data yang banyak.

**Contoh:**  
`/todos?page=1` → Mengambil semua data pada halaman ke-1.

`/todos?page=3` → Mengambil semua data pada halaman ke-3.

`/todos?page=2&per_page=15` → Mengambil 15 data pada halaman ke-2.

`/todos?page=3&per_page=20` → Mengambil 20 data pada halaman ke-3.

![Sign up](https://s2.ezgif.com/tmp/ezgif-25340e5fdc599e.gif)

---

## Tech
Created With 

![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)
![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)

Credit

https://www.digitalocean.com/community/tutorials/build-a-restful-json-api-with-rails-5-part-one

---

