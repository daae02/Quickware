const express = require("express");
const app = express();
app.use(express.urlencoded({extended: false}))
app.use(express.json());
require("./app/routes/client.routes.js")(app);
require("./app/routes/dealers.routes.js")(app);
// simple route
app.get("/", (req, res) => {
    res.json({ message: "Welcome to Quickwares's api." });
  });
// set port, listen for requests
app.listen(3000, () => {
  console.log("Server is running on port 3000.");
});