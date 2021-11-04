use quickwaredb;
DELIMITER //
 

CREATE PROCEDURE RegisterDealer(
	IN pName NVARCHAR(100),
    IN pPhoneNumber VARCHAR(12),
    IN pEmail VARCHAR(300),
    IN pPassword NVARCHAR(100),
    IN pVehicleId VARCHAR(9)
)
BEGIN
	DECLARE MailInUSe INT DEFAULT(53000);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		GET DIAGNOSTICS CONDITION 1 @err_no = MYSQL_ERRNO, @message = MESSAGE_TEXT;
        -- si es un exception de sql, ambos campos vienen en el diagnostics
        -- pero si es una excepction forzada por el programador solo viene el ERRNO, el texto no
        IF (ISNULL(@message)) THEN -- quiere decir q es una excepcion forzada del programador
			SET @message = 'aqui saco el mensaje de un catalogo de mensajes que fue creado por equipo de desarrollo';            
        ELSE
			-- es un exception de SQL que no queremos que salga hacia la capa de aplicacion
            -- tengo que guardar el error en una bitácora de errores... patron de bitacora
            -- sustituyo el texto del mensaje
            SET @message = CONCAT('Internal error: ', @message);
        END IF;
        RESIGNAL SET MESSAGE_TEXT = @message;
	END;
	SELECT COUNT(*) INTO @emailRegistered FROM Dealers WHERE email = pEmail ;
    IF  (@emailRegistered != 0)
    THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El email ya esta en uso', MYSQL_ERRNO = MailInUSe;
	END IF;
    
    SELECT COUNT(*) INTO @phoneNumberRegistered FROM Dealers WHERE PhoneNumber = pPhoneNumber ;
    IF  (@phoneNumberRegistered != 0)
    THEN
		SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'El numero de telefono ya esta en uso', MYSQL_ERRNO = MailInUSe;
	END IF;
	SELECT COUNT(*) INTO @vehicleIdRegistered FROM Dealers WHERE VehicleId = pVehicleId ;
    IF  (@vehicleIdRegistered != 0)
    THEN
		SIGNAL SQLSTATE '45002' SET MESSAGE_TEXT = 'La placa ya esta en uso', MYSQL_ERRNO = MailInUSe;
	END IF;
    START TRANSACTION;
		INSERT INTO Dealers  (Name, PhoneNumber, Email,VehicleId, Password)
        VALUES (pName, pPhoneNumber, pEmail,pVehicleId, SHA(CONCAT(pPassword,",",pEmail)));
	COMMIT;
END//
DELIMITER ;