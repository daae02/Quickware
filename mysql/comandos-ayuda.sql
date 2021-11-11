use quickwaredb;
select * from Clients;

delete from Clients WHERE ClientId < 7;

select * from Products;

select * from `Status`;
INSERT INTO 
	`Status`(Name)
VALUES
	("En despacho"),("Despachado"),("Entregado");
    
select * from `Orders`;   
INSERT INTO 
	`Orders`(ClientId, StatusId, CreationDate, EstimatedDeliveryDate, TotalPrice, Checksum)
VALUES   
	(7, 1, NOW(), DATE_ADD(NOW(), INTERVAL (RAND()*(10-3)+3) DAY), RAND()*(1000-3)+3,  MD5(CONCAT(ClientId, StatusId, CreationDate, EstimatedDeliveryDate, TotalPrice)));

select * from `OrderHistories`;  
INSERT INTO 
	`OrderHistories`(OrderId, Datetime, HistoryPrice, OrderHistoriescol)
VALUES   
	(1, NOW(), RAND()*(1000-3)+3,  "LOL");
    
select * from `ProductsPerOrderHistory`;  
INSERT INTO 
	`ProductsPerOrderHistory`(ProductId, Quantity, OrderHistoryId)
VALUES   
	(161, 4, 1),(162, 3, 1),(163, 2, 1),(164, 1, 1),(165, 5, 1);
 
   
SELECT ord.OrderId,prod.ProductId,proper.Quantity,prod.UnityPrice,prod.Title,prod.PictureURL FROM `Orders` as ord 
INNER JOIN Clients ON ord.ClientId = Clients.ClientId 
INNER JOIN OrderHistories AS ordHis ON ord.OrderId = ordHis.OrderId 
INNER JOIN ProductsPerOrderHistory AS proper ON ordHis.OrderHistoryId = proper.OrderHistoryId 
INNER JOIN Products AS prod ON proper.ProductId = prod.ProductId 
WHERE Email="leonardo@gmail.com";

CALL LogIn ("leonardo@gmail.com","Aa.@www1");
UPDATE Clients 
SET Clients.Online = 0
WHERE Password = SHA(CONCAT("Aa.@www1",",","leonardo@gmail.com"));
        
SET SQL_SAFE_UPDATES = 0;

DROP PROCEDURE `LogIn`;

SELECT * FROM `Products` WHERE AvailableQuantity > 0;

delete from Products;

INSERT INTO 
	`Products`(AvailableQuantity, UnityPrice, Title, Description, PictureURL)
VALUES
	(RAND()*(1000-1)+1,RAND()*(1000-1)+1,'Martillo','Marron Claro y Madera de Roble','img/pro/img6.jpg'),
	(RAND()*(1000-1)+1,RAND()*(1000-1)+1,'Alicate','Acero inoxidable','img/pro/img5.jpg'),
    (RAND()*(1000-1)+1,RAND()*(1000-1)+1,'Martillo Hidráulico','- Peso operativo: 7.000 kg','img/pro/img4.jpg'),    
    (RAND()*(1000-1)+1,RAND()*(1000-1)+1,'Martillo de uña','Acero inoxidable','img/pro/img3.png'),
    (RAND()*(1000-1)+1,RAND()*(1000-1)+1,'Martillo de bola','Acero inoxidable y Madera de Roble','img/pro/img2.jpg'),
    (RAND()*(1000-1)+1,RAND()*(1000-1)+1,'Martillo de perforación','Acero inoxidable y Madera de Roble','img/pro/img1.jpg'),
    (RAND()*(1000-1)+1,RAND()*(1000-1)+1,'Martillo 2','Marron Claro y Madera de Roble','img/pro/img6.jpg'),
	(RAND()*(1000-1)+1,RAND()*(1000-1)+1,'Alicate 2','Acero inoxidable','img/pro/img5.jpg'),
    (RAND()*(1000-1)+1,RAND()*(1000-1)+1,'Martillo Hidráulico 2','- Peso operativo: 7.000 kg','img/pro/img4.jpg'),    
    (RAND()*(1000-1)+1,RAND()*(1000-1)+1,'Martillo de uña 2','Acero inoxidable','img/pro/img3.png'),
    (RAND()*(1000-1)+1,RAND()*(1000-1)+1,'Martillo de bola 2','Acero inoxidable y Madera de Roble','img/pro/img2.jpg'),
    (RAND()*(1000-1)+1,RAND()*(1000-1)+1,'Martillo de perforación 2','Acero inoxidable y Madera de Roble','img/pro/img1.jpg'),
    (RAND()*(1000-1)+1,RAND()*(1000-1)+1,'Martillo 3','Marron Claro y Madera de Roble','img/pro/img6.jpg'),
	(RAND()*(1000-1)+1,RAND()*(1000-1)+1,'Alicate 3','Acero inoxidable','img/pro/img5.jpg'),
    (RAND()*(1000-1)+1,RAND()*(1000-1)+1,'Martillo Hidráulico 3','- Peso operativo: 7.000 kg','img/pro/img4.jpg'),    
    (RAND()*(1000-1)+1,RAND()*(1000-1)+1,'Martillo de uña 3','Acero inoxidable','img/pro/img3.png'),
    (RAND()*(1000-1)+1,RAND()*(1000-1)+1,'Martillo de bola 3','Acero inoxidable y Madera de Roble','img/pro/img2.jpg'),
    (RAND()*(1000-1)+1,RAND()*(1000-1)+1,'Martillo de perforación 3','Acero inoxidable y Madera de Roble','img/pro/img1.jpg'),
    (RAND()*(1000-1)+1,RAND()*(1000-1)+1,'Martillo 4','Marron Claro y Madera de Roble','img/pro/img6.jpg'),
	(RAND()*(1000-1)+1,RAND()*(1000-1)+1,'Alicate 4','Acero inoxidable','img/pro/img5.jpg'),
    (RAND()*(1000-1)+1,RAND()*(1000-1)+1,'Martillo Hidráulico 4','- Peso operativo: 7.000 kg','img/pro/img4.jpg'),    
    (RAND()*(1000-1)+1,RAND()*(1000-1)+1,'Martillo de uña 4','Acero inoxidable','img/pro/img3.png'),
    (RAND()*(1000-1)+1,RAND()*(1000-1)+1,'Martillo de bola 4','Acero inoxidable y Madera de Roble','img/pro/img2.jpg'),
    (RAND()*(1000-1)+1,RAND()*(1000-1)+1,'Martillo de perforación 4','Acero inoxidable y Madera de Roble','img/pro/img1.jpg');
    
    https://cr.epaenlinea.com/pub/media/version20200605/catalog/product/cache/a83b746ef25730b9cb1cc414bac0f04a/1/2/1246118_3.jpg
	https://cr.epaenlinea.com/pub/media/version20200605/catalog/product/cache/a83b746ef25730b9cb1cc414bac0f04a/1/2/1202002_4.jpg
    https://img.directindustry.es/images_di/photo-g/56338-2816173.jpg    
    https://www.mndelgolfo.com/blog/wp-content/uploads/2017/01/martillo-truper-640x360.png
    https://www.mndelgolfo.com/blog/wp-content/uploads/2017/01/martillo-de-bola-truper-640x360.jpg
    https://www.mndelgolfo.com/blog/wp-content/uploads/2017/01/martillo-de-perforacion.jpg
    https://www.mndelgolfo.com/blog/wp-content/uploads/2017/01/mazo-de-hule-pretul-640x360.jpg       
    https://www.mndelgolfo.com/blog/wp-content/uploads/2017/01/martillo-tapicero-truper-640x360.jpg   
    https://www.mndelgolfo.com/blog/wp-content/uploads/2017/01/martillo-para-mecanico-640x360.jpg       
    https://www.unionferretera.com/7347-large_default/alicates-universales-aisladas-wiha.jpg   
    https://cr.epaenlinea.com/pub/media/version20200605/catalog/product/cache/a83b746ef25730b9cb1cc414bac0f04a/1/2/1202017_7.jpg   
    https://entaban.es/323-thickbox_default/alicates-de-corte-lateral-bahco-cromado-plateado-con-filos-progresivos.jpg   
    https://m.media-amazon.com/images/I/51-Xr-cZI4L._AC_SY355_.jpg
    https://m.media-amazon.com/images/I/51w0VZjPNiL._AC_SX425_.jpg
    https://cdn.shopify.com/s/files/1/0580/5922/7336/products/stanley-84-272-stanley-84-272-image-es_ar-ecommerce-alicate_para_retencion_anillos_seeguer_stanley_grande.jpg
    https://www.planetaelectronico.com/images/productos/thumbnails/alicate-crimpar-terminal-faston-y-telefonico-no-aislados-1-11726_thumb_450x450.png  
    https://m.media-amazon.com/images/I/71vNYIuhRUL._AC_SY355_.jpg  
    http://dam-assets.fluke.com/s3fs-public/F-inpp10_02a_w.jpg   
    http://upload.wikimedia.org/wikipedia/commons/5/51/Tool-pliers.jpg'
    https://www.ingmecafenix.com/wp-content/uploads/2018/08/alicates-taladrador.jpg'
    
    
    
    
    
    
    
    
    
    
    
    
    
    