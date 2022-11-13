const pool = require('../db');
const queries = require('./queries');
const bcryptjs = require("bcrypt");
const jwt = require("jsonwebtoken");


const getUsers = (req, res) => {
    pool.query(queries.getUsers, (error, results) => {
        if (error) throw error;
        res.status(200).json(results.rows);
    })
};

const getUsersByID = (req, res) => {
    const id = parseInt(req.params.id);
    pool.query(queries.getUsersByID, [id], (error, results) => {
        if(error) throw error;
        res.status(200).json(results.rows);
    })
}

const addUser = (req, res)  => {

    try {
        const {password, email} = req.body;

    pool.query(queries.checkEmailExists, [email], async (error, results) => {
        if(results.rows.length){
            res.send("Email already exists.");
        }

        const hashedPassword = await bcryptjs.hash(password, 8);

        pool.query(queries.addUser, [hashedPassword, email], (error, results) => {
            if (error) throw error;
            res.status(201).send("User Created Successfully");
        })
    })
    } catch (error) {
        res.status(500).json({ "somethin went wrong": "wrongi" });
    }
    
};

const loginUser = async (req, res) => {
    const id = parseInt(req.params.id);

        const {password, email} = req.body;

    const user = pool.query(queries.checkEmailExists, [email]);
    if(!user){
        return res.status.send("User with this email does not exist!")
    }

    const token = jwt.sign({id: id}, "passwordKey");
    res.json({token, ...user._doc})
    const isMatch = bcryptjs.compare(password, user.password, function (err, result) {
    });
    if(!isMatch){
        return res.status(400).send("Incorrect password");
    }
     
}

const removeUser = (req, res) => {
    const id = parseInt(req.params.id);

    pool.query(queries.getUsersByID, [id], (error, results) => {
        const noUserFound = !results.rows.length;
        if(noUserFound){
            res.send("Student does not exist in the database")
        }

        pool.query(queries.removeUser, [id], (error, results) => {
            if (error) throw error;
            res.status(200).send("User deleted");
        })
    })
}

const updateUser = (req, res) => {
    const id = parseInt(req.params.id);
    const {password} = req.body;

    pool.query(queries.getUsersByID, [id], (error, results) => {
        const noUserFound = !results.rows.length;
        if(noUserFound){
            res.send("User does not exist in the database");
        }
        pool.query(queries.updateUser, [password, id], (error, results) => {
            if (error) throw error;
            res.status(200).send("Password updated successfully");
        });
    });
}

module.exports = {
    getUsers,
    getUsersByID,
    addUser,
    removeUser,
    updateUser,
    loginUser
};