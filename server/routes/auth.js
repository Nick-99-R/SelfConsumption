// const express = require('express');
// const authRouter = express.Router();
// const User = require ('../models/users')
// const bcryptjs = require("bcrypt");
// const controller = require('../controller');

// authRouter.get("/",  controller.getUsers());

// // SIGN UP
// authRouter.post("/api/signup", async (req, res) => {
//     try {
//       const {  email, password } = req.body;
  
//       const existingUser = await User.findOne({ email });
//       if (existingUser) {
//         return res
//           .status(400)
//           .json({ msg: "User with same email already exists!" });
//       }
  
//       const hashedPassword = await bcryptjs.hash(password, 8);
  
//       let user = new User({
//         email,
//         password: hashedPassword,
        
//       });
//       user = await user.save();
//       res.json(user);
//     } catch (e) {
//       res.status(500).json({ error: e.message });
//     }
//   });

// module.exports = authRouter;