INSERT INTO Status(StatusId,Name)
VALUES(0,"En espera"),(1,"Empacado"),(2,"Listo Para Despacho"),(3,"Despachado"),(4,"Entregado"),(5,"Cancelado");
SELECT * FROM Status;
DELETE FROM Status WHERE StatusId = 16;
SET  @num := 0;
UPDATE Status SET id = @num := (@num+1);
DELIMITER //
CREATE PROCEDURE generateOrders()
BEGIN
	SET @inter = 0;
    WHILE @inter < 10 DO
		SELECT ClientId into @cId FROM Clients ORDER BY RAND() LIMIT 1;
		SET  @cTotal = FLOOR(RAND()*(900001 ))+100000;
		INSERT INTO Orders (ClientId, StatusId, CreationDate, EstimatedDeliveryDate, TotalPrice, Checksum)
		VALUES(@cId,2,curdate(),ADDDATE(curdate(), INTERVAL 7 DAY), @cTotal,MD5(CONCAT(@cId,2,curdate(),ADDDATE(curdate(), INTERVAL 7 DAY), @cTotal)));
        SET @inter = @inter + 1;
	END WHILE;
END//
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
CREATE PROCEDURE updateOrder(
	IN oId INT
)
BEGIN
	UPDATE Orders
    SET StatusId = StatusId+1
    WHERE Orders.orderId = oId;
END//
