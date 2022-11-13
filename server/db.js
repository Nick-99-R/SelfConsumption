const Pool = require('pg').Pool;

const pool = new Pool({
    user: "postgres",
    host: "178.254.20.45",
    database: "postgres",
    password: "asasBT31LKOD.",
    port: 5432
});

module.exports = pool;