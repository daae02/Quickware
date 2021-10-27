const sql = require("./db");

// constructor
const Client = function(customer) {
  this.name = customer.name;
  this.address = customer.address;
  this.phoneNumber = customer.phoneNumber;
  this.email = customer.email;
  this.password = customer.password;
  this.enterpriseName = customer.enterpriseName;
};

Client.create = (newCustomer, result) => {
    sql.execute("CALL RegisterUser(?,?,?,?,?,?)", [newCustomer.name, newCustomer.address,newCustomer.phoneNumber,newCustomer.email, newCustomer.password,newCustomer.enterpriseName], (err, res) => {
      if (err) {
        console.log("error: ", err);
        result(err, null);     
        return;
      }
  
      console.log("created customer: ", { id: res.insertId, ...newCustomer });
      result(null, { id: res.insertId, ...newCustomer });     
    });
};
Client.logIn = (email,pass, result) => {
    console.log(email,pass)
    sql.execute("CALL logIn(?,?)",[email, pass], (err, res) => {
      if (err) {
        console.log("error: ", err);
        result(err, null);     
        return;
      }
      console.log(res);
      result(null,res[0]);  
    });
};
Client.find = (reque, result) => {
  sql.query('SELECT * FROM `Clients`',function (err, results, fields) {
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

module.exports = Client;
