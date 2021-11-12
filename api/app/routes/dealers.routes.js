module.exports = app => {
    const Dealer = require('../models/dealer.model');
    const dealer = require("../controllers/dealers.controller");
    app.get('/repartidores',dealer.find);
    app.post('/addRepartidor',dealer.create);
    app.get('/randomDealer',dealer.random);
    app.post('/orders',dealer.orders);
    app.post('/updateOrder',dealer.update);
    
};