const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
const authRouter = require('./src/controllers/auth_controller')
const consumptionRouter = require('./src/controllers/self_consumption_controller')

app.use(express.json())

app.use(authRouter)
app.use(consumptionRouter)

app.listen(port, () => console.log(`app listening on port ${port}`));