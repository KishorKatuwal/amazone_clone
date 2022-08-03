//contains imports from packages
const express = require('express');
const mongoose = require('mongoose');
const adminRouter = require('./routes/admin');

//contains imports from other files
const authRouter = require("./routes/auth");
const productRouter = require('./routes/product');
const userRouter = require('./routes/user');

//all the initilization
const PORT = 3000;
const app = express();
const DB = "mongodb+srv://kishor:laptop@cluster0.lp56wr2.mongodb.net/?retryWrites=true&w=majority";

//middleware
//CLIENT => SERVE -> CLIENT
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

//connections
mongoose.connect(DB).then(() => {
    console.log('Connection Successful');
}).catch((e) => {
    console.log(e);
});
app.listen(PORT, "0.0.0.0", () => {
    console.log(`connected at port at ${PORT} `);
})

