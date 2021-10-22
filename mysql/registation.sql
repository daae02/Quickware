
use quickwaredb;
DELIMITER //
 
 
CREATE PROCEDURE RegisterUser(
	IN pName NVARCHAR(100),
    IN pAddress NVARCHAR(500),
    IN pPhoneNumber VARCHAR(12),
    IN pEmail VARCHAR(300),
    IN pPassword NVARCHAR(13),
    IN pEnterpriseName NVARCHAR(100)
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
	SELECT COUNT(*) INTO @emailRegisted FROM Clients WHERE email = pEmail ;
    IF  (@emailRegisted != 0)
    THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El email ya esta en uso', MYSQL_ERRNO = MailInUSe;
	END IF;
    
    START TRANSACTION;
		INSERT INTO Clients  (Name, Address, PhoneNumber, Email, Password, creationDate, EnterpriseName)
        VALUES (pName,  pAddress, pPhoneNumber, pEmail, SHA(pPassword), SYSDATE(), pEnterpriseName);
	COMMIT;
END//
DELIMITER ;