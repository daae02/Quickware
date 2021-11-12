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
  Dealer.random = (reque, result) => {
    sql.query('SELECT Name, DealerId from Dealers ORDER BY RAND() LIMIT 1',function (err, results, fields) {
      // error will be an Error if one occurred during the query
      // results will contain the results of the query
      // fields will contain information about the returned results fields (if any)
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
  
      console.log("created customer: ", { id: res.insertId, ...newDealer });
      result(null, { id: res.insertId, ...newDealer });     
    });
};
Dealer.orders = (id, result) => {
  sql.execute("CALL getOrders(?)", [id], (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(err, null);     
      return;
    }
    console.log(res[0])
    result(null,res[0]);     
  });
};
Dealer.update = (id, result) => {
  sql.execute("CALL updateOrder(?)", [id], (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(err, null);     
      return;
    }
    result(null,{ok:1});     
  });
};
module.exports = Dealer;