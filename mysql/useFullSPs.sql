DELIMITER //
CREATE PROCEDURE assingDealer()
BEGIN
	SELECT Orders.OrderId INTO @cOrder
	FROM Orders
	LEFT JOIN OrdersPerDealer ON OrdersPerDealer.OrderId = Orders.OrderId
	WHERE OrdersPerDealer.OrderId IS NULL ORDER BY rand() LIMIT 1;
	SELECT DealerId into @cDealer FROM Dealers ORDER BY RAND() LIMIT 1;
	INSERT INTO OrdersPerDealer(DealerId,OrderId)
	VALUES(@cDealer,@cOrder);
END//
CALL assingDealer();
SELECT * FROM OrdersPerDealer;

DELIMITER //
CREATE PROCEDURE getOrders(
	IN pDealerInt INT
)
BEGIN
SELECT ords.OrderId, cli.EnterpriseName, cli.Name, cli.Address,cli.PhoneNumber,sta.StatusId FROM OrdersPerDealer as ordpdeal
INNER JOIN Orders as ords ON ordpdeal.OrderId = ords.OrderId
INNER JOIN Clients as cli ON cli.ClientId = ords.ClientId
INNER JOIN Status as sta ON sta.StatusId = ords.StatusId
INNER JOIN Dealers as deal ON deal.DealerId = ordpdeal.DealerId
WHERE deal.DealerId = pDealerInt AND sta.StatusId < 4
ORDER BY RAND();
END//