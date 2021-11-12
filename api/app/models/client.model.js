const sql = require("./db");

// constructor
const Client = function(customer) {
  this.name = customer.name;
  this.address = customer.address;
  this.phoneNumber = customer.phoneNumber;
  this.email = customer.email;
  this.password = customer.password;
  this.enterpriseName = customer.enterpriseName;
  this.Online = customer.Online;
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
  sql.query('SELECT * FROM `Products` WHERE AvailableQuantity > 0',function (err, results, fields) {
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

Client.findOrders = (reque, result) => {
  console.log(reque+" este el email");
  sql.query('SELECT ord.OrderId,prod.ProductId,proper.Quantity,prod.UnityPrice,prod.Title,prod.PictureURL,ord.CreationDate,ord.StatusId FROM Orders as ord   INNER JOIN Clients ON ord.ClientId = Clients.ClientId   INNER JOIN OrderHistories AS ordHis ON ord.OrderId = ordHis.OrderId   INNER JOIN ProductsPerOrderHistory AS proper ON ordHis.OrderHistoryId = proper.OrderHistoryId   INNER JOIN Products AS prod ON proper.ProductId = prod.ProductId WHERE Clients.Email="'+reque+'";',function (err, results, fields) {
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
