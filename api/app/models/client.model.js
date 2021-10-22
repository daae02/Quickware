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
module.exports = Client;
