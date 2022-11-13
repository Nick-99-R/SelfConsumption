
// const getUserModel = (sequelize, { DataTypes }) => {
//   const User = sequelize.define('user', {
//     email: {
//       required: true,
//       type: DataTypes.STRING,
//       unique: true,
//       allowNull: false,
//       validate: {
//         validator: (value) => {
//           const re =
//             /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
//           return value.match(re);
//         },
//         message: "Invalides Email Format",}      },
//     password: {
//       required: true,
//       type: String,
//       validate: {
//         validator: (value) => {
//           return value.length > 6;
//         },
//         message: "Zu kurzes Passwort"
//       }
//     },
    
//   },
//   );
  
 
  
//   return User;};
  


// //export default User;
// module.exports = getUserModel;
