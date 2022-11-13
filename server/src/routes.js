const {Router} = require("express");
const controller = require("./controller");

const router = Router();

router.get("/", controller.getUsers);
router.post("/register", controller.addUser);
router.post("/login", controller.loginUser);
router.get("/:id", controller.getUsersByID);
router.put("/:id", controller.updateUser);
router.delete("/:id", controller.removeUser);

module.exports = router;