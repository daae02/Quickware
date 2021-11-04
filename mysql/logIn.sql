CREATE DEFINER=`root`@`%` PROCEDURE `LogIn`(
    IN pEmail NVARCHAR(500),
    IN pPassword NVARCHAR(13)
)
BEGIN
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
    SELECT Name, PhoneNumber, Email, EnterpriseName FROM Clients WHERE Password = SHA(CONCAT(pPassword,",",pEmail));
    START TRANSACTION;
		IF (select @@sql_safe_updates = 1)
		THEN
			SET SQL_SAFE_UPDATES = 0;
		END IF;
		UPDATE Clients 
        SET Clients.Online = 1
        WHERE Password = SHA(CONCAT(pPassword,",",pEmail));
    COMMIT;
END