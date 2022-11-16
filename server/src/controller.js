const pool = require('../db');
const queries = require('./queries');
const bcryptjs = require("bcrypt");
const jwt = require("jsonwebtoken");
const auth = require("./middlewares/auth");
const express = require("express");
const authRouter = express.Router();
const e = require('express');


// authRouter.get("/", async (req, res) => {
//     pool.query(queries.getUsers, (error, results) => {
//         if (error) throw error;
//         res.status(200).json(results.rows);
//     })
// });

authRouter.get("/:id", async (req, res) => {
    const id = parseInt(req.params.id);
    pool.query(queries.getUsersByID, [id], (error, results) => {
        if (error) throw error;
        res.status(200).json(results.rows);
    })
});


// const removeUser = (req, res) => {
//     const id = parseInt(req.params.id);

//     pool.query(queries.getUsersByID, [id], (error, results) => {
//         const noUserFound = !results.rows.length;
//         if(noUserFound){
//             res.send("Student does not exist in the database")
//         }

//         pool.query(queries.removeUser, [id], (error, results) => {
//             if (error) throw error;
//             res.status(200).send("User deleted");
//         })
//     })
// }

// const updateUser = (req, res) => {
//     const id = parseInt(req.params.id);
//     const {password} = req.body;

//     pool.query(queries.getUsersByID, [id], (error, results) => {
//         const noUserFound = !results.rows.length;
//         if(noUserFound){
//             res.send("User does not exist in the database");
//         }
//         pool.query(queries.updateUser, [password, id], (error, results) => {
//             if (error) throw error;
//             res.status(200).send("Password updated successfully");
//         });
//     });
// }

authRouter.post("/api/signup", async (req, res) => {
    try {
        const {password, email} = req.body;

    pool.query(queries.checkEmailExists, [email], async (error, results) => {
        if(results.rows.length){
            return res
            .status(400)
            .json({ msg: "User with same email already exists!" });        }

        const hashedPassword = await bcryptjs.hash(password, 8);

        pool.query(queries.addUser, [hashedPassword, email], async (error, results) => {
            if (error) throw error;
            res.status(201).send("Account erfolgreich erstellt");
            
        })
       
    })
    } catch (error) {
        res.status(500).json({ error: e.message });
    }
})

authRouter.post("/api/signin", async (req, res) => {
    try{
        const {email, password} = req.body;

        pool.query(queries.checkEmailExists, [email], async (error, results) => {
            if(!results.rows.length){
                return res
                .status(400)
                .json({ msg: "Benutzer mit dieser Email existiert nicht" });
            }
        
         else {
                var string = results.rows[0].s;
                var splitedString = string.split(","); 
                var hashedPassword = splitedString[1];
                const isMatch = await bcryptjs.compare(password, hashedPassword);
                if(!isMatch){
                    return res.status(400).json({msg:"Falsche E-mail - Passwort Kombination"});
                } 
                var id = splitedString[0];
                while(id.charAt(0) ==='('){
                    id = id.substring(1);
                }
                const token = jwt.sign({id: id}, "passwordKey");
                res.json({token, ...results.rows._doc});
                }

            })
        }
     catch (e){
        res.status(500).json({ error: e.message });
    }
});
    
authRouter.post("/tokenIsValid", async(req, res) => {
    try {
        const id = parseInt(req.params.id);

        const token = req.header("x-auth-token");
        if (!token) return res.json(false);
        const verified = jwt.verify(token, "passwordKey");
        if (!verified) return res.json(false);


        pool.query(queries.getUsersByID, [verified.id], async (error, results) => {
            console.log(results)
            if(!results.rows.length){
                return res
                .json(false)
            }
         else {
                res.json(true);
                }

            })

      } catch (e) {
        res.status(500).json({ error: e.message });
      }
})

  authRouter.get("/", auth, async (req, res) => {
    const user = pool.query(queries.getUsersByID, [req.user]);

   res.json({ ...user._doc, token: req.token });
  });

module.exports = authRouter;