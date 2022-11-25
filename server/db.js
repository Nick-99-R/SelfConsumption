const Pool = require('pg').Pool;

const pool = new Pool({
    user: "flutterdb_admin",
    host: "178.254.20.45",
    database: "postgres",
    password: "Acr6HHjx!85$",
    port: 5432
});

module.exports = pool;