const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
const userRoutes = require('./src/routes')

app.use(express.json()),
app.get("/", (req, res) => {
    res.send("Hello World!")
})

app.use('/api/v1/users', userRoutes)

app.listen(port, () => console.log(`app listening on port ${port}`));