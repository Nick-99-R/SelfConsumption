const getUsers = "SELECT * FROM users";
const getUsersByID = "SELECT * FROM users WHERE id = $1";
const checkEmailExists = "SELECT s FROM users s WHERE s.email = $1";
const addUser = "INSERT INTO users (password, email) VALUES ($1, $2)";
const removeUser = "DELETE FROM users WHERE id = $1";
const updateUser = "UPDATE users SET password = $1 WHERE id = $2";
const getConsumptionData = "SELECT * FROM verbrauchsdaten WHERE id = $1";
const getPlantOutput = "SELECT * from erzeugungsdaten WHERE id = $1";

module.exports = {
    getUsers,
    getUsersByID,
    checkEmailExists,
    addUser,
    removeUser,
    updateUser,
    getConsumptionData,
    getPlantOutput
};