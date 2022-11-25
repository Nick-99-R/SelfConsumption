const pool = require('../../db');
const queries = require('../queries');
const express = require("express");
const consumptionRouter = express.Router();

// authRouter.get("/", async (req, res) => {
//     pool.query(queries.getUsers, (error, results) => {
//         if (error) throw error;
//         res.status(200).json(results.rows);
//     })
// });

consumptionRouter.get("/consumption/:id", async (req, res) => {
    const id = parseInt(req.params.id);
    pool.query(queries.getConsumptionData, [id], (error, results) => {
        if (error) throw error;
        res.status(200).json(results.rows);
    })
});

consumptionRouter.get("/output/:id", async (req, res) => {
    const id = parseInt(req.params.id);
    pool.query(queries.getPlantOutput, [id], (error, results) => {
        if (error) throw error;
        res.status(200).json(results.rows);
    })
});

module.exports = consumptionRouter;
