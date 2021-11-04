const sql = require("./db");

// constructor
const Dealer = function(dealer) {
  this.name = dealer.name;
  this.phoneNumber = dealer.phoneNumber;
  this.email = dealer.email;
  this.vehicleId = dealer.vehicleId;
  this.password = dealer.password;
};
Dealer.find = (reque, result) => {
    sql.query('SELECT DealerId, Name, Email, PhoneNumber, VehicleId FROM `Dealers`',function (err, results, fields) {
    if (err) {
        console.log("error: ", err);
        result(err, null);     
        return;
      }
      console.log(results);
      result(null,results);    
    });
  };
Dealer.create = (newDealer, result) => {
    sql.execute("CALL RegisterDealer(?,?,?,?,?)", [newDealer.name,newDealer.phoneNumber,newDealer.email,newDealer.password,newDealer.vehicleId], (err, res) => {
      if (err) {
        console.log("error: ", err);
        result(err, null);     
        return;
      }
  
      console.log("created customer: ", { id: res.insertId, ...newCustomer });
      result(null, { id: res.insertId, ...newCustomer });     
    });
};
  module.exports = Dealer;