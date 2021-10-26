module.exports = app => {
    const Cliente = require('../models/client.model');
    const client = require("../controllers/clients.controller.js");
    

    app.use(function(req, res, next) {
        var allowedOrigins = ['http://localhost:3000/productos','*'];
        var Origin = req.headers.Origin;
        if(allowedOrigins.indexOf(Origin) > -1){
             res.setHeader('Access-Control-Allow-Origin', Origin);
        }
        //res.header('Access-Control-Allow-Origin', 'http://127.0.0.1:8020');
        res.header('Access-Control-Allow-Methods', 'GET, OPTIONS');
        res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization');
        res.header('Access-Control-Allow-Credentials', true);
        return next();
      });

    // Create a new Customer
    app.post("/createClient", client.create);

    app.get('/productos',client.find);
    
    
};