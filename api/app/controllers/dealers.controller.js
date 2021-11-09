const Dealer = require("../models/dealer.model.js");
/*
exports.create = (req, res) => {
    // Validate request
    if (!req.body) {
      res.status(400).send({
        message: "Content can not be empty!"
      });
    }
    // Create a Customer
    const client = new Client({
        name: req.body.name,
        address: req.body.address,
        phoneNumber: req.body.phoneNumber,
        email: req.body.email, 
        password: req.body.password,   
        enterpriseName: req.body.enterpriseName
    });
    console.log("Created");
    // Save Customer in the database
    Client.create(client, (err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while creating the Customer."
        });
      else res.send(data);
    });
  };
*/
  exports.find = (req, res) => {
    Dealer.find("", (err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while find clients."
        });
      else res.send(data);
    });
  };
  exports.create = (req, res) => {
    // Validate request
    if (!req.body) {
      res.status(400).send({
        message: "Content can not be empty!"
      });
    }
    // Create a Customer
    console.log(req.body);
    const dealer = new Dealer({
        name: req.body.name,
        phoneNumber: req.body.phoneNumber,
        email: req.body.email, 
        password: req.body.password,   
        vehicleId: req.body.vehicleId
    });
    
    Dealer.create(dealer, (err, data) => {
      if (err)
        res.status(500).send({
          message: err.message || "Some error occurred while creating the Customer.",
          code: err.sqlState
        });
      else res.send({message:"Inserted", code: 0});
    });
  };
/*
  exports.logIn = (req, res) => {
    if (!req.body) {
      res.status(400).send({
        message: "Content can not be empty!"
      });
    }
    Client.logIn(req.body.email,req.body.password,(err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while find clients."
        });
      else res.send(data);
    });
  };
*/