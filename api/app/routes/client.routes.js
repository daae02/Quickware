module.exports = app => {
    const client = require("../controllers/clients.controller.js");
    
    // Create a new Customer
    app.post("/createClient", client.create);
};