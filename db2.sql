-- --------------------------------------------------------
-- Host:                         10.10.5.2
-- Server version:               8.0.26 - Source distribution
-- Server OS:                    Linux
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for wms_inbound
CREATE DATABASE IF NOT EXISTS `wms_inbound` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `wms_inbound`;

-- Dumping structure for procedure wms_inbound.InventoryMassUpload
DELIMITER //
CREATE PROCEDURE `InventoryMassUpload`()
BEGIN



    DECLARE i int DEFAULT 1;



    WHILE i <= 32 DO



        INSERT INTO wms_inbound.tbl_receivingitems (`IBN`, `ItemID`, `CustomerID`, `PalletID`, `PalletType`, `StoringTypeID`, `ChargeTypeID`, `ItemStatusID`, `Beg_Quantity`, `Beg_Weight`, `Quantity`, `Weight`, `ExpiryDate`, `ProdDate`, `Batch`, `QAReason`, `Checked`, `ForPutaway`, `QRCode`, `ItemRemark`) VALUES('IBN000000001',178,26,5420,1,2,1,2,1,12,1,12,'44557','No Production Date','No Batch','GOOD','TRUE',6,'No QRCode','No Remark');



        SET i = i + 1;



    END WHILE;



    SET i=1;



    WHILE i <= 36 DO



        INSERT INTO wms_inbound.tbl_receivingitems (`IBN`, `ItemID`, `CustomerID`, `PalletID`, `PalletType`, `StoringTypeID`, `ChargeTypeID`, `ItemStatusID`, `Beg_Quantity`, `Beg_Weight`, `Quantity`, `Weight`, `ExpiryDate`, `ProdDate`, `Batch`, `QAReason`, `Checked`, `ForPutaway`, `QRCode`, `ItemRemark`) VALUES('IBN000000001',178,26,5409,1,2,1,2,1,12,1,12,'44557','No Production Date','No Batch','GOOD','TRUE',7,'No QRCode','No Remark');



        SET i = i + 1;



    END WHILE;



    SET i=1;



    WHILE i <= 48 DO



        INSERT INTO wms_inbound.tbl_receivingitems (`IBN`, `ItemID`, `CustomerID`, `PalletID`, `PalletType`, `StoringTypeID`, `ChargeTypeID`, `ItemStatusID`, `Beg_Quantity`, `Beg_Weight`, `Quantity`, `Weight`, `ExpiryDate`, `ProdDate`, `Batch`, `QAReason`, `Checked`, `ForPutaway`, `QRCode`, `ItemRemark`) VALUES('IBN000000001',178,26,5399,1,2,1,2,1,12,1,12,'44557','No Production Date','No Batch','GOOD','TRUE',8,'No QRCode','No Remark');



        SET i = i + 1;



    END WHILE;



    SET i=1;



    WHILE i <= 1 DO



        INSERT INTO wms_inbound.tbl_receivingitems (`IBN`, `ItemID`, `CustomerID`, `PalletID`, `PalletType`, `StoringTypeID`, `ChargeTypeID`, `ItemStatusID`, `Beg_Quantity`, `Beg_Weight`, `Quantity`, `Weight`, `ExpiryDate`, `ProdDate`, `Batch`, `QAReason`, `Checked`, `ForPutaway`, `QRCode`, `ItemRemark`) VALUES('IBN000000001',178,26,5408,1,2,1,2,1,12,1,12,'44562','No Production Date','No Batch','GOOD','TRUE',9,'No QRCode','No Remark');



        SET i = i + 1;



    END WHILE;



    SET i=1;



    WHILE i <= 1 DO



        INSERT INTO wms_inbound.tbl_receivingitems (`IBN`, `ItemID`, `CustomerID`, `PalletID`, `PalletType`, `StoringTypeID`, `ChargeTypeID`, `ItemStatusID`, `Beg_Quantity`, `Beg_Weight`, `Quantity`, `Weight`, `ExpiryDate`, `ProdDate`, `Batch`, `QAReason`, `Checked`, `ForPutaway`, `QRCode`, `ItemRemark`) VALUES('IBN000000001',178,26,5416,1,2,1,2,1,12,1,12,'44563','No Production Date','No Batch','GOOD','TRUE',10,'No QRCode','No Remark');



        SET i = i + 1;



    END WHILE;



    SET i=1;



    WHILE i <= 1 DO



        INSERT INTO wms_inbound.tbl_receivingitems (`IBN`, `ItemID`, `CustomerID`, `PalletID`, `PalletType`, `StoringTypeID`, `ChargeTypeID`, `ItemStatusID`, `Beg_Quantity`, `Beg_Weight`, `Quantity`, `Weight`, `ExpiryDate`, `ProdDate`, `Batch`, `QAReason`, `Checked`, `ForPutaway`, `QRCode`, `ItemRemark`) VALUES('IBN000000001',178,26,5416,1,2,1,2,1,12,1,12,'44567','No Production Date','No Batch','GOOD','TRUE',11,'No QRCode','No Remark');



        SET i = i + 1;



    END WHILE;



    



END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.sp_customers_additem
DELIMITER //
CREATE PROCEDURE `sp_customers_additem`(
-- GENERATEGLACIERCODE
IN __custid INT,
IN __cat INT,
IN __desc VARCHAR(255),

-- INFO  TO ADD
IN __clientsku VARCHAR(45),
IN __matstype VARCHAR(191),
IN __mintemp VARCHAR(191),
IN __maxtemp VARCHAR(45),
IN __length DOUBLE,
IN __width DOUBLE,
IN __height DOUBLE,
IN __weight DOUBLE,
IN __pcspercase INT,
IN __casesperpallet INT,
IN __uomid INT,
IN __repqty INT,
IN __parentcode VARCHAR(45),
IN __subcat INT,
IN __shelflife INT,
IN __price DOUBLE,
IN __itemclass VARCHAR(45),
IN __priceclass VARCHAR(45),
IN __minqty INT,
IN __maxqty INT,
IN __user INT
)
BEGIN
DECLARE _clientsku VARCHAR(191);

DECLARE _count INT;
DECLARE _alpha VARCHAR(26);
DECLARE _category VARCHAR(1);
DECLARE _desc VARCHAR(1);
DECLARE _custcode VARCHAR(45);
DECLARE _code VARCHAR(45);
DECLARE _glaciercode VARCHAR(45);
DECLARE _ifexist INT;

IF __clientsku = 0 THEN
SET _clientsku = null;
else
SET _clientsku = __clientsku;
END IF;

SET _alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
SET _category = (SUBSTRING(_alpha,__cat,1));
SET _desc = (SUBSTRING(__desc,1,1));
SET _custcode = (SELECT CustomerCode FROM wms_cloud.tbl_customers WHERE CustomerID=__custid);
SET _code = (CONCAT(SUBSTRING(_custcode,1,2),SUBSTRING(_custcode,-3)));

-- SELECT _glaciercode;
REPEAT
SET _count = (SELECT COUNT(*)+1 FROM wms_cloud.tbl_items WHERE ItemCustomerID=__custid);
SET _glaciercode = CONCAT(_code,_category,_desc,LPAD(_count,4,0));

SET _ifexist = (SELECT COUNT(*) FROM wms_cloud.tbl_items WHERE ItemCode = _glaciercode);
IF _ifexist = 0 THEN
	INSERT INTO wms_cloud.tbl_items(`ItemCode`,`Client_SKU`,`ItemDesc`,`ItemCustomerID`,`MaterialType`,`Category`,`MinTemp`,`MaxTemp`,`Length`,`Width`,`Height`, `Weight`, `PiecesPerCase`,`CasesPerPallet`,`UOMID`,`RepQTY`, `ParentCode`, `SubCat`, `ShelfLife`, `Price`, `Status`, `ItemClass`, `PriceClass`, `MinQty`, `MaxQty`)
VALUES (_glaciercode, _clientsku, __desc, __custid, __matstype, __cat, __mintemp, __maxtemp, __length, __width, __height, __weight, __pcspercase, __casesperpallet, __uomid, __repqty, __parentcode, __subcat, __shelflife, __price, 'Hold', __itemclass, __priceclass, __minqty, __maxqty);

CALL wms_warehouse.sp_user_logs(_glaciercode,'Maintenance','Customers','Add Items',__user);
END IF;
UNTIL _ifexist = 0
END REPEAT;

END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.sp_customers_itemregistration
DELIMITER //
CREATE PROCEDURE `sp_customers_itemregistration`(
-- GENERATEGLACIERCODE
IN __custid INT,
IN __cat INT,
IN __desc VARCHAR(255),

-- INFO  TO ADD
IN __clientsku VARCHAR(45),
IN __matstype VARCHAR(191),
IN __mintemp VARCHAR(191),
IN __maxtemp VARCHAR(45),
IN __length DOUBLE,
IN __width DOUBLE,
IN __height DOUBLE,
IN __weight DOUBLE,
IN __pcspercase INT,
IN __casesperpallet INT,
IN __uomid INT,
IN __repqty INT,
IN __parentcode VARCHAR(45),
IN __subcat INT,
IN __shelflife INT,
IN __price DOUBLE,
IN __itemclass VARCHAR(45),
IN __priceclass VARCHAR(45),
IN __minqty INT,
IN __maxqty INT
)
BEGIN

DECLARE _count INT;
DECLARE _alpha VARCHAR(26);
DECLARE _category VARCHAR(1);
DECLARE _desc VARCHAR(1);
DECLARE _custcode VARCHAR(45);
DECLARE _code VARCHAR(45);
DECLARE _glaciercode VARCHAR(45);
DECLARE _ifexist INT;

SET _alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
SET _category = (SUBSTRING(_alpha,__cat,1));
SET _desc = (SUBSTRING(__desc,1,1));
SET _custcode = (SELECT CustomerCode FROM wms_cloud.tbl_customers WHERE CustomerID=__custid);
SET _code = (CONCAT(SUBSTRING(_custcode,1,2),SUBSTRING(_custcode,-3)));


-- SELECT _glaciercode;
REPEAT
SET _count = (SELECT COUNT(*)+1 FROM wms_cloud.tbl_items WHERE ItemCustomerID=__custid);
SET _glaciercode = CONCAT(_code,_category,_desc,LPAD(_count,4,0));

SET _ifexist = (SELECT COUNT(*) FROM wms_cloud.tbl_items WHERE ItemCode = _glaciercode);
IF _ifexist = 0 THEN
	INSERT INTO wms_cloud.tbl_items(`ItemCode`,`Client_SKU`,`ItemDesc`,`ItemCustomerID`,`MaterialType`,`Category`,`MinTemp`,`MaxTemp`,`Length`,`Width`,`Height`, `Weight`, `PiecesPerCase`,`CasesPerPallet`,`UOMID`,`RepQTY`, `ParentCode`, `SubCat`, `ShelfLife`, `Price`, `Status`, `ItemClass`, `PriceClass`, `MinQty`, `MaxQty`)
VALUES (_glaciercode, __clientsku, __desc, __custid, __matstype, __cat, __mintemp, __maxtemp, __length, __width, __height, __weight, __pcspercase, __casesperpallet, __uomid, __repqty, __parentcode, __subcat, __shelflife, __price, 'Hold', __itemclass, __priceclass, __minqty, __maxqty);
END IF;
UNTIL _ifexist = 0
END REPEAT;

END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.SP_GenerateIBN
DELIMITER //
CREATE PROCEDURE `SP_GenerateIBN`(
	IN `__USER` VARCHAR(200)

)
BEGIN DECLARE __return VARCHAR(200); SET __return =(

SELECT TempIBN+1

FROM wms_inbound.tbl_temp

LIMIT 1);

UPDATE wms_inbound.tbl_temp SET TempIBN=TempIBN+1; SET __return =(CONCAT("IBN", LPAD(__RETURN,9,0)));

INSERT INTO wms_inbound.tbl_receiving (`IBN`, `StatusID`, `CreatedBy`,`created_at`) VALUES (__return, 0, __USER, NOW());

SELECT __return; END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.SP_PUTAway
DELIMITER //
CREATE PROCEDURE `SP_PUTAway`(

	IN `__IBN` VARCHAR(200)

)
BEGIN

SELECT palletid, 



 systempid, 



 manualpid, 



 itemdesc, 



 beg_quantity, 



 beg_weight,



 roomname,



 colname,



 customerid,



 Lcode,



 forputaway,



 pallettype,



 uom_abv

FROM vw_putaway

WHERE IBN = __IBN

ORDER BY palletid DESC; END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.sp_putaway_ibnpalletlist
DELIMITER //
CREATE PROCEDURE `sp_putaway_ibnpalletlist`(
IN __pid INT)
BEGIN
SELECT B.RoomName, A.RoomCode FROM wms_inbound.tbl_locassignment A
                LEFT JOIN wms_inbound.tbl_room B ON A.RoomCode = B.RoomCode
                WHERE A.PalletID = __pid;
END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.sp_putaway_listofrooms
DELIMITER //
CREATE PROCEDURE `sp_putaway_listofrooms`(
IN __roomcode VARCHAR(45),
IN __custid INT,
IN __keys VARCHAR(250))
BEGIN

IF (__keys != '' OR __keys != null) THEN
	SELECT LocationID,
    CONCAT(ColName, '-', RIGHT(LCode, 1)),
    LocStatus,
    ColName
    FROM wms_inbound.tbl_locations
    WHERE RoomCode = __roomcode
    AND (ReservedClient = __custid OR CustomerID = __custid)
    AND LoadStatus = 1
    AND CONCAT(ColName, '-', RIGHT(LCode, 1)) like CONCAT('%',__keys,'%')
    ORDER BY RIGHT(LCode, 1) DESC, ColName ASC;
ELSE
	SELECT LocationID,
    CONCAT(ColName, '-', RIGHT(LCode, 1)) as location,
    LocStatus,
    ColName
    FROM wms_inbound.tbl_locations
    WHERE RoomCode = __roomcode
    AND (ReservedClient = __custid OR CustomerID = __custid)
    AND LoadStatus = 1
    ORDER BY RIGHT(LCode, 1) DESC, ColName ASC;
END IF;
END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.SP_PUTAWAY_openPutawayPendingModal
DELIMITER //
CREATE PROCEDURE `SP_PUTAWAY_openPutawayPendingModal`()
BEGIN
    SELECT DISTINCT(A.IBN),
	C.CompanyName,
    B.CreatedBy,
    B.LastUpdatedBy,
    B.created_at
    FROM wms_inbound.tbl_receivingitems A
    LEFT JOIN wms_inbound.tbl_receiving B on A.IBN = B.IBN
    LEFT JOIN wms_cloud.tbl_customers C on B.CusID = C.CustomerID
    WHERE A.ForPutaway >= 2 AND B.StatusID <> 3 AND StatusID <> 5
    ORDER BY A.IBN DESC;
END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.SP_PUTAWAY_putawayhistory
DELIMITER //
CREATE PROCEDURE `SP_PUTAWAY_putawayhistory`(
IN __ibn VARCHAR(45),
IN __palletid INT)
BEGIN
    SELECT A.Reason,
    A.PalletID,
    B.ColName,
	B.LCode,
    C.ColName,
    C.LCode
    FROM wms_inbound.tbl_putawayhistory A
    LEFT JOIN wms_inbound.tbl_locations B ON A.FromLocationID = B.LocationID
    LEFT JOIN wms_inbound.tbl_locations C ON A.ToLocationID = C.LocationID
    WHERE A.PalletID = __palletid AND A.IBN = __ibn;
END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.sp_putaway_qaconfirm
DELIMITER //
CREATE PROCEDURE `sp_putaway_qaconfirm`(
IN __ibn VARCHAR(45),
IN __userid INT
)
BEGIN
DECLARE _no_of_confirmed_pallets INT;
DECLARE _no_of_confirmed_pallet_locations INT;

SET _no_of_confirmed_pallets = (SELECT count(*) FROM wms_inbound.tbl_receivingitems WHERE IBN = __ibn AND ForPutaway = 5);

SET _no_of_confirmed_pallet_locations = (SELECT count(*) FROM wms_inbound.tbl_receivingitems WHERE IBN = __ibn AND ForPutaway < 4);

IF _no_of_confirmed_pallets > 0 THEN
	SELECT "QACONFIRMED";
ELSE
	IF _no_of_confirmed_pallet_locations > 0 THEN
		SELECT "False";
    ELSE
		UPDATE wms_inbound.tbl_receivingitems SET ForPutaway = 5 WHERE IBN = __ibn AND PalletType in (1,2);
        
        INSERT INTO wms_warehouse.tbl_systemlogs (transaction_no, module, submodule, activity, user_id, datetimestamp) VALUES (__ibn, 'Inbound', 'Putaway', 'QA Confirmed!', __userid, NOW());
        
        SELECT "0";
    END IF;
END IF;

END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.sp_putaway_room_list
DELIMITER //
CREATE PROCEDURE `sp_putaway_room_list`(
IN __itemcategory VARCHAR(45),
IN __ibn VARCHAR(45))
BEGIN
DECLARE _CustomerID INT;

SET _CustomerID = (SELECT CustomerID FROM wms_inbound.tbl_receivingitems WHERE IBN = __ibn LIMIT 1);

SELECT A.RoomCode, A.RoomName
FROM wms_inbound.tbl_room A
LEFT JOIN wms_inbound.tbl_locations B on A.RoomCode = B.RoomCode
LEFT JOIN wms_cloud.tbl_roomtypes C on A.RoomTypeID = C.id
WHERE C.type LIKE CONCAT('%', LEFT(__itemcategory, 5), '%')
AND B.ReservedClient = _CustomerID OR B.CustomerID = _CustomerID
AND (B.LocStatus = 3 OR B.LocStatus = 6)
AND A.CustomerID = _CustomerID
GROUP BY A.RoomCode, A.RoomName ORDER BY A.RoomName;

END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.SP_RECEIVING_additemsummary
DELIMITER //
CREATE PROCEDURE `SP_RECEIVING_additemsummary`(
IN __itemid INT,
IN __ibn VARCHAR(45),
IN __qtywgt INT)
BEGIN
DECLARE __itemdesc VARCHAR(45);
DECLARE __weight DOUBLE;
DECLARE __checkifadded INT;
DECLARE __storagetype VARCHAR(45);

DECLARE __currentqty DOUBLE;
DECLARE __update_qty DOUBLE;
DECLARE __update_wgt DOUBLE;
DECLARE __insert_wgt DOUBLE;

SET __itemdesc = (SELECT ItemDesc FROM wms_cloud.tbl_items WHERE ItemID = __itemid);
SET __weight = (SELECT Weight FROM wms_cloud.tbl_items WHERE ItemID = __itemid);

SET __checkifadded = (SELECT COUNT(*) FROM wms_inbound.tbl_receivingitemsummary where ItemID = __itemid AND IBN = __ibn);

IF __checkifadded > 0 THEN -- if already added
	SET __currentqty = (SELECT Beg_Quantity FROM wms_inbound.tbl_receivingitemsummary where ItemID = __itemid AND IBN = __ibn);
	IF __weight > 0 THEN -- IF FW
		SET __update_qty = __qtywgt + __currentqty;
        SET __update_wgt = __update_qty * __weight;
    ELSE -- IF CW
		SET __update_qty = __qtywgt + __currentqty;
        SET __update_wgt = __update_qty;
    END IF;
    
	UPDATE wms_inbound.tbl_receivingitemsummary
	SET Beg_Quantity=__update_qty,
	Beg_Weight=__update_wgt,
	Quantity=__update_qty,
	Weight=__update_wgt
	WHERE IBN = __ibn AND ItemID = __itemid;
    
ELSE -- if new item to add
	IF __weight > 0 THEN -- IF FW
		SET __insert_wgt = __qtywgt * __weight;
        SET __storagetype = 1;
    ELSE -- IF CW
		SET __insert_wgt = __qtywgt;
        SET __storagetype = 2;
    END IF;
    INSERT INTO wms_inbound.tbl_receivingitemsummary (IBN, ItemID, Beg_Quantity, Beg_Weight, Quantity, Weight, StorageType)
	VALUES (__ibn, __itemid, __qtywgt, __insert_wgt, __qtywgt, __insert_wgt, __storagetype);
END IF;
END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.SP_RECEIVING_addmultiitem
DELIMITER //
CREATE PROCEDURE `SP_RECEIVING_addmultiitem`(
in __ibn varchar(45),
in __itemid int,
in __custid int,
in __syspid int,
in __pallettype int,
in __storagetype int,
in __chargetype int,
in __item_status int,
in __qty int,
in __wght double,
in __expdate varchar(45),
in __prodate varchar(45),
in __batch varchar(45),
in __qastatus varchar(45),
in __qrcode varchar(45),
in __itemremarks varchar(255))
begin
	if __expdate = 0 and __prodate = 0 then
        insert into wms_inbound.tbl_receivingitems (`ibn`, `itemid`, `customerid`, `palletid`, `pallettype`, `storingtypeid`, `chargetypeid`, `itemstatusid`, `beg_quantity`, `beg_weight`,`quantity`, `weight`, `batch`, `qareason`, `QRCode`, `itemremark`, `ispick`, `isout`) values (__ibn, __itemid, __custid, __syspid, __pallettype, __storagetype, __chargetype, __item_status, __qty, __wght, __qty, __wght, __batch, __qastatus, __qrcode, __itemremarks, 0, 0);
    elseif __expdate <> 0 and __prodate = 0 then
        insert into wms_inbound.tbl_receivingitems (`ibn`, `itemid`, `customerid`, `palletid`, `pallettype`, `storingtypeid`, `chargetypeid`, `itemstatusid`, `beg_quantity`, `beg_weight`, `quantity`, `weight`, `expirydate`, `batch`, `qareason`, `QRCode`, `itemremark`, `ispick`, `isout`) values (__ibn, __itemid, __custid, __syspid, __pallettype, __storagetype, __chargetype, __item_status, __qty, __wght, __qty, __wght, __expdate, __batch, __qastatus, __qrcode, __itemremarks, 0, 0);
	elseif __expdate = 0 and __prodate <> 0 then
        insert into wms_inbound.tbl_receivingitems (`ibn`, `itemid`, `customerid`, `palletid`, `pallettype`, `storingtypeid`, `chargetypeid`,`itemstatusid`, `beg_quantity`, `beg_weight`,`quantity`, `weight`, `proddate`, `batch`, `qareason`, `QRCode`, `itemremark`, `ispick`, `isout`) values (__ibn, __itemid, __custid, __syspid, __pallettype, __storagetype, __chargetype, __item_status, __qty, __wght, __qty, __wght, __prodate, __batch, __qastatus, __qrcode, __itemremarks, 0, 0);
	elseif __expdate <> 0 and __prodate <> 0 then
        insert into wms_inbound.tbl_receivingitems (`ibn`, `itemid`, `customerid`, `palletid`, `pallettype`, `storingtypeid`, `chargetypeid`, `itemstatusid`, `beg_quantity`, `beg_weight`, `quantity`, `weight`, `expirydate`, `proddate`, `batch`, `qareason`, `QRCode`, `itemremark`, `ispick`, `isout`) values (__ibn, __itemid, __custid, __syspid, __pallettype, __storagetype, __chargetype, __item_status, __qty, __wght, __qty, __wght, __expdate, __prodate, __batch, __qastatus, __qrcode, __itemremarks, 0, 0);
    end if;
end//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.SP_RECEIVING_addpallet
DELIMITER //
CREATE PROCEDURE `SP_RECEIVING_addpallet`(IN __PALLETNUMBER INT,
										   IN __ITEMSPERPALLET INT,
                                           IN __IBN VARCHAR(200),
                                           IN __MANUALPID INT,
                                           IN __ITEMID INT,
                                           IN __CUSID INT,
                                           IN __PALLETTYPE INT,
                                           IN __STORAGETYPEID INT,
                                           IN __CHARGETYPE INT,
                                           IN __STATUS INT,
                                           IN __WEIGHT DOUBLE,
                                           IN __EXPIRY DATETIME,
                                           IN __PRODUCTION DATETIME,
                                           IN __BATCH VARCHAR(200),
                                           IN __QASTATUS VARCHAR(200),
                                           IN __ITEMREMARK VARCHAR(200))
BEGIN
		DECLARE LOOPER INT DEFAULT 0;
        

		__PALLETMAKER: LOOP
        SET LOOPER = LOOPER+1;
        
        IF LOOPER > __PALLETNUMBER THEN
        INSERT INTO wms_inbound.tbl_pallets(IBN,MANUALPID) values(__IBN,__MANUALPID);
        
        SET __MANUALPID = __MANUALPID+1;
        
        ITERATE __PALLETMAKER;
        END IF;
        LEAVE __PALLETMAKER;
		END LOOP __PALLETMAKER;
        
        CREATE TEMPORARY TABLE TT_PALLETNUMBERS
        (
        SELECT PALLETID FROM wms_inbound.tbl_pallets 
        WHERE IBN  =__IBN
        );
        
		UPDATE TT_PALLETNUMBERS A
		LEFT JOIN wms_inbound.tbl_pallets B ON
		A.PALLETID = B.PALLETID
		SET B.SYSTEMPID = (CONCAT('PID', LPAD(B.ID,9,0))); 
        
        
END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.SP_RECEIVING_addsingleitem
DELIMITER //
CREATE PROCEDURE `SP_RECEIVING_addsingleitem`(
in __ibn varchar(45),
in __itemid int,
in __custid int,
in __syspid int,
in __pallettype int,
in __storagetype int,
in __chargetype int,
in __item_status int,
in __wght double,
in __expdate varchar(45),
in __prodate varchar(45),
in __batch varchar(45),
in __qastatus varchar(45),
in __itemremarks varchar(255),
in __totalpalletweight int,
in __itemperpallet int,
in __weight_per_item double,
in __zero_pallettag int
)
begin
DECLARE zero_pallettag INT;
DECLARE _batch varchar(45);

IF __batch in ('No Batch', 'NA', 'N/A', 'No', 'No batch code', 'No bacth', ' No batch', 'Lot Code', ' NA', ' N/A', '', 'No Batch/Lot Code') THEN
	SET _batch = null;
ELSE
	SET _batch = __batch;
END IF;

if __pallettype = 3 THEN -- ZERO PALLETS
	IF __zero_pallettag IS NULL THEN
		SET zero_pallettag = null;
	ELSE
		SET zero_pallettag = __zero_pallettag;
	END IF;
    
	if __expdate = 0 and __prodate = 0 then
		if __storagetype = 1 then
			insert into wms_inbound.tbl_receivingitems (`ibn`,`itemid`,`customerid`, `PalletID`, `pallettype`,`storingtypeid`, `chargetypeid`, `itemstatusid`, `beg_quantity`,`beg_weight`,`quantity`,`weight`, `batch`, `qareason`, `qrcode`, `itemremark`,`ispick`,`isout`) values (__ibn,__itemid, __custid, zero_pallettag, __pallettype,__storagetype,__chargetype,__item_status, 1,__wght, 1, __wght, _batch, __qastatus, 'No QRCode', __itemremarks, 0, 0);
		else
			insert into wms_inbound.tbl_receivingitems (`ibn`,`itemid`,`customerid`, `PalletID`, `pallettype`,`storingtypeid`,`chargetypeid`,`itemstatusid`,`beg_quantity`,`beg_weight`,`quantity`,`weight`, `batch`, `qareason`, `qrcode`, `itemremark`,`ispick`,`isout`) values (__ibn,__itemid,__custid, zero_pallettag, __pallettype,__storagetype,__chargetype,__item_status, 1,__weight_per_item, 1, __weight_per_item,  _batch, __qastatus, 'No QRCode', __itemremarks, 0, 0);
		end if;
        
    elseif __expdate <> 0 and __prodate = 0 then
		if __storagetype = 1 then
			insert into wms_inbound.tbl_receivingitems (`ibn`,`itemid`,`customerid`, `PalletID`, `pallettype`,`storingtypeid`,`chargetypeid`,`itemstatusid`,`beg_quantity`,`beg_weight`,`quantity`,`weight`, `batch`, `qareason`, `qrcode`, `itemremark`,`ispick`,`isout`,`expirydate`) values (__ibn,__itemid,__custid, zero_pallettag, __pallettype,__storagetype,__chargetype,__item_status, 1,__wght, 1, __wght, _batch, __qastatus, 'No QRCode', __itemremarks, 0, 0, __expdate);
		else
			insert into wms_inbound.tbl_receivingitems (`ibn`,`itemid`,`customerid`, `PalletID`, `pallettype`,`storingtypeid`,`chargetypeid`,`itemstatusid`,`beg_quantity`,`beg_weight`,`quantity`,`weight`, `batch`, `qareason`, `qrcode`, `itemremark`,`ispick`,`isout`,`expirydate`) values (__ibn,__itemid,__custid, zero_pallettag, __pallettype,__storagetype,__chargetype,__item_status, 1,__weight_per_item, 1, __weight_per_item,  _batch, __qastatus, 'No QRCode', __itemremarks, 0, 0, __expdate);
		end if;
        
	elseif __expdate = 0 and __prodate <> 0 then
		if __storagetype = 1 then
			insert into wms_inbound.tbl_receivingitems (`ibn`,`itemid`,`customerid`, `PalletID`, `pallettype`,`storingtypeid`,`chargetypeid`,`itemstatusid`,`beg_quantity`,`beg_weight`,`quantity`,`weight`, `batch`, `qareason`, `qrcode`, `itemremark`,`ispick`,`isout`,`proddate`) values (__ibn,__itemid,__custid, zero_pallettag, __pallettype,__storagetype,__chargetype,__item_status, 1,__wght, 1, __wght, _batch, __qastatus, 'No QRCode', __itemremarks, 0, 0, __prodate);
		else
			insert into wms_inbound.tbl_receivingitems (`ibn`,`itemid`,`customerid`, `PalletID`, `pallettype`,`storingtypeid`,`chargetypeid`,`itemstatusid`,`beg_quantity`,`beg_weight`,`quantity`,`weight`, `batch`, `qareason`, `qrcode`, `itemremark`,`ispick`,`isout`,`proddate`) values (__ibn,__itemid,__custid, zero_pallettag, __pallettype,__storagetype,__chargetype,__item_status, 1,__weight_per_item, 1, __weight_per_item,  _batch, __qastatus, 'No QRCode', __itemremarks, 0, 0, __prodate);
		end if;
        
	elseif __expdate <> 0 and __prodate <> 0 then
		if __storagetype = 1 then
			insert into wms_inbound.tbl_receivingitems (`ibn`,`itemid`,`customerid`, `PalletID`, `pallettype`,`storingtypeid`,`chargetypeid`,`itemstatusid`,`beg_quantity`,`beg_weight`,`quantity`,`weight`, `batch`, `qareason`, `qrcode`, `itemremark`,`ispick`,`isout`,`proddate`,`expirydate`) values (__ibn, __itemid, __custid, zero_pallettag,  __pallettype, __storagetype,__chargetype, __item_status, 1,__wght, 1, __wght, _batch, __qastatus, 'No QRCode', __itemremarks, 0, 0, __prodate, __expdate);
		else
			insert into wms_inbound.tbl_receivingitems (`ibn`,`itemid`,`customerid`, `PalletID`, `pallettype`,`storingtypeid`,`chargetypeid`,`itemstatusid`,`beg_quantity`,`beg_weight`,`quantity`,`weight`, `batch`, `qareason`, `qrcode`, `itemremark`,`ispick`,`isout`,`proddate`,`expirydate`) values (__ibn,__itemid,__custid, zero_pallettag, __pallettype,__storagetype,__chargetype,__item_status, 1,__weight_per_item, 1, __weight_per_item,  _batch, __qastatus, 'No QRCode', __itemremarks, 0, 0, __prodate, __expdate);
		end if;
    end if;
    
else -- STANDARD & GUARANTEED

	if __expdate = 0 and __prodate = 0 then
		if __storagetype = 1 then
			insert into wms_inbound.tbl_receivingitems (`ibn`,`itemid`,`customerid`,`palletid`,`pallettype`,`storingtypeid`,`chargetypeid`,`itemstatusid`,`beg_quantity`,`beg_weight`,`quantity`,`weight`, `batch`, `qareason`, `qrcode`, `itemremark`,`ispick`,`isout`) values (__ibn,__itemid,__custid,__syspid,__pallettype,__storagetype, __chargetype, __item_status, 1,__wght, 1, __wght, _batch, __qastatus, 'No QRCode', __itemremarks, 0, 0);
		else
			insert into wms_inbound.tbl_receivingitems (`ibn`,`itemid`,`customerid`,`palletid`,`pallettype`,`storingtypeid`,`chargetypeid`,`itemstatusid`,`beg_quantity`,`beg_weight`,`quantity`,`weight`, `batch`, `qareason`, `qrcode`, `itemremark`,`ispick`,`isout`) values (__ibn,__itemid,__custid,__syspid,__pallettype,__storagetype,__chargetype,__item_status, 1,__weight_per_item, 1, __weight_per_item,  _batch, __qastatus, 'No QRCode', __itemremarks, 0, 0);
		end if;
        
    elseif __expdate <> 0 and __prodate = 0 then
		if __storagetype = 1 then
			insert into wms_inbound.tbl_receivingitems (`ibn`,`itemid`,`customerid`,`palletid`,`pallettype`,`storingtypeid`,`chargetypeid`,`itemstatusid`,`beg_quantity`,`beg_weight`,`quantity`,`weight`, `batch`, `qareason`, `qrcode`, `itemremark`,`ispick`,`isout`,`expirydate`) values (__ibn,__itemid,__custid,__syspid,__pallettype,__storagetype,__chargetype,__item_status, 1,__wght, 1, __wght, _batch, __qastatus, 'No QRCode', __itemremarks, 0, 0, __expdate);
		else
			insert into wms_inbound.tbl_receivingitems (`ibn`,`itemid`,`customerid`,`palletid`,`pallettype`,`storingtypeid`,`chargetypeid`,`itemstatusid`,`beg_quantity`,`beg_weight`,`quantity`,`weight`, `batch`, `qareason`, `qrcode`, `itemremark`,`ispick`,`isout`,`expirydate`) values (__ibn,__itemid,__custid,__syspid,__pallettype,__storagetype,__chargetype,__item_status, 1,__weight_per_item, 1, __weight_per_item,  _batch, __qastatus, 'No QRCode', __itemremarks, 0, 0, __expdate);
		end if;
        
	elseif __expdate = 0 and __prodate <> 0 then
		if __storagetype = 1 then
			insert into wms_inbound.tbl_receivingitems (`ibn`,`itemid`,`customerid`,`palletid`,`pallettype`,`storingtypeid`,`chargetypeid`,`itemstatusid`,`beg_quantity`,`beg_weight`,`quantity`,`weight`, `batch`, `qareason`, `qrcode`, `itemremark`,`ispick`,`isout`,`proddate`) values (__ibn,__itemid,__custid,__syspid,__pallettype,__storagetype,__chargetype,__item_status, 1,__wght, 1, __wght, _batch, __qastatus, 'No QRCode', __itemremarks, 0, 0, __prodate);
		else
			insert into wms_inbound.tbl_receivingitems (`ibn`,`itemid`,`customerid`,`palletid`,`pallettype`,`storingtypeid`,`chargetypeid`,`itemstatusid`,`beg_quantity`,`beg_weight`,`quantity`,`weight`, `batch`, `qareason`, `qrcode`, `itemremark`,`ispick`,`isout`,`proddate`) values (__ibn,__itemid,__custid,__syspid,__pallettype,__storagetype,__chargetype,__item_status, 1,__weight_per_item, 1, __weight_per_item,  _batch, __qastatus, 'No QRCode', __itemremarks, 0, 0, __prodate);
		end if;
        
	elseif __expdate <> 0 and __prodate <> 0 then
		if __storagetype = 1 then
			insert into wms_inbound.tbl_receivingitems (`ibn`,`itemid`,`customerid`,`palletid`,`pallettype`,`storingtypeid`,`chargetypeid`,`itemstatusid`,`beg_quantity`,`beg_weight`,`quantity`,`weight`, `batch`, `qareason`, `qrcode`, `itemremark`,`ispick`,`isout`,`proddate`,`expirydate`) values (__ibn, __itemid, __custid, __syspid, __pallettype, __storagetype,__chargetype, __item_status, 1,__wght, 1, __wght, _batch, __qastatus, 'No QRCode', __itemremarks, 0, 0, __prodate, __expdate);
		else
			insert into wms_inbound.tbl_receivingitems (`ibn`,`itemid`,`customerid`,`palletid`,`pallettype`,`storingtypeid`,`chargetypeid`,`itemstatusid`,`beg_quantity`,`beg_weight`,`quantity`,`weight`, `batch`, `qareason`, `qrcode`, `itemremark`,`ispick`,`isout`,`proddate`,`expirydate`) values (__ibn,__itemid,__custid,__syspid,__pallettype,__storagetype,__chargetype,__item_status, 1,__weight_per_item, 1, __weight_per_item,  _batch, __qastatus, 'No QRCode', __itemremarks, 0, 0, __prodate, __expdate);
		end if;
    end if;
end if;
end//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.SP_RECEIVING_delete_asn
DELIMITER //
CREATE PROCEDURE `SP_RECEIVING_delete_asn`(IN __receivingsummaryid INT,
IN __IBN VARCHAR(45))
BEGIN
	DECLARE __ITEM INT;
    
    SET __ITEM = (SELECT ItemID FROM wms_inbound.tbl_receivingitemsummary WHERE ReceivingItemSummaryID = __receivingsummaryid AND IBN = __IBN );
    
	DELETE FROM wms_inbound.tbl_receivingitemsummary WHERE ReceivingItemSummaryID = __receivingsummaryid AND IBN = __IBN;
    
    DELETE FROM wms_inbound.tbl_receivingitems WHERE IBN = __IBN AND ItemID = __ITEM;
    
END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.SP_RECEIVING_end_receiving_process
DELIMITER //
CREATE PROCEDURE `SP_RECEIVING_end_receiving_process`(
IN `__IBN` VARCHAR(45)
)
BEGIN
DECLARE _countpallettype INT;
DECLARE _palletype_exist INT;
SET _countpallettype = (SELECT COUNT(DISTINCT(PalletType)) FROM wms_inbound.tbl_receivingitems where IBN = __IBN);
SET _palletype_exist = (SELECT COUNT(DISTINCT(PalletType)) FROM wms_inbound.tbl_receivingitems where IBN = __IBN AND PalletType = 3);

IF _countpallettype = 1 AND _palletype_exist = 1 THEN
	UPDATE wms_inbound.tbl_receiving SET StatusID = 3, TimeFinish = NOW() WHERE IBN = __IBN;
ELSE
	UPDATE wms_inbound.tbl_receiving SET StatusID = 4, TimeFinish = NOW() WHERE IBN = __IBN;
END IF;

END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.sp_receiving_existingloc_zero
DELIMITER //
CREATE PROCEDURE `sp_receiving_existingloc_zero`(
IN __itemid INT,
IN __custid INT
)
BEGIN
	create temporary table receiving_categorieslist(
	SELECT C.ItemCategoryID, D.id FROM wms_inbound.tbl_receivingitemsummary A
	LEFT JOIN wms_cloud.tbl_items B on A.ItemID = B.ItemID
	LEFT JOIN wms_cloud.tbl_categories C on B.Category = C.ItemCategoryID
	LEFT JOIN wms_cloud.tbl_itemsubcategories D on B.SubCat = D.id
	where A.ItemID = __itemid
	GROUP BY C.ItemCategoryID, D.id
	);

	SELECT GROUP_CONCAT(DISTINCT(D.PalletID) SEPARATOR ','), CONCAT('PID',LPAD(D.PalletID,6,0),' - ',D.ManualPID),A.ItemID
	FROM wms_cloud.tbl_items A
	INNER JOIN receiving_categorieslist B on B.ItemCategoryID = A.Category AND B.id = A.SubCat
	INNER JOIN wms_inbound.tbl_receivingitems C on A.ItemID = C.ItemID
	INNER JOIN wms_inbound.tbl_pallets D on C.PalletID = D.PalletID
    LEFT JOIN wms_inbound.tbl_locations E on C.PalletID = E.PalletID
	where
    -- A.ItemCustomerID = __custid
    -- E.ReservedClient = __custid
    ((E.ReservedClient = __custid OR C.CustomerID = __custid) OR (D.LocationID is null OR D.LocationID = ''))
    AND
	C.Quantity > 0
	AND C.ispick = 0
	AND C.isout = 0
	AND C.Checked = 'True'
	AND C.ForPutaway in (0,6,7,8)
	GROUP BY C.PalletID
	ORDER BY C.PalletID, A.ItemID;
    
	drop temporary table receiving_categorieslist;
END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.sp_receiving_fillitemsearch_zero
DELIMITER //
CREATE PROCEDURE `sp_receiving_fillitemsearch_zero`(
IN __storagetype VARCHAR(45),
IN __ibn VARCHAR(45),
IN __pid int
)
BEGIN
DECLARE _countexisting INT;

create temporary table getcategorieslist(
select B.Category, B.subcat from wms_inbound.tbl_receivingitems A
INNER JOIN wms_cloud.tbl_items B on A.itemid = B.ItemID
where A.PalletID = __pid
group by B.Category, B.subcat);

IF __storagetype = 'fw' THEN

	SET _countexisting = (select count(*) from wms_inbound.tbl_receivingitemsummary A
	INNER JOIN wms_cloud.tbl_items C on A.ItemID = C.ItemID
	INNER JOIN getcategorieslist D on C.category = D.category and C.subcat = D.subcat
	where A.IBN = __ibn
	AND C.Weight > 0
    AND C.Status = 'Active');
    
    IF _countexisting = 0 THEN
		SELECT _countexisting;
    ELSE
		select A.ItemID, C.ItemDesc, C.ItemCode, C.Client_SKU from wms_inbound.tbl_receivingitemsummary A
		INNER JOIN wms_cloud.tbl_items C on A.ItemID = C.ItemID
		INNER JOIN getcategorieslist D on C.category = D.category and C.subcat = D.subcat
		where A.IBN = __ibn
		AND C.Weight > 0
		AND C.Status = 'Active'
		GROUP BY A.ItemID;
    END IF;
	
ELSE
	SET _countexisting = (select count(*) from wms_inbound.tbl_receivingitemsummary A
	INNER JOIN wms_cloud.tbl_items C on A.ItemID = C.ItemID
	INNER JOIN getcategorieslist D on C.category = D.category and C.subcat = D.subcat
	where A.IBN = __ibn
	AND C.Weight = 0
    AND C.Status = 'Active');
    
    IF _countexisting = 0 THEN
		SELECT _countexisting;
    ELSE
		select A.ItemID, C.ItemDesc, C.ItemCode, C.Client_SKU from wms_inbound.tbl_receivingitemsummary A
		INNER JOIN wms_cloud.tbl_items C on A.ItemID = C.ItemID
		INNER JOIN getcategorieslist D on C.category = D.category and C.subcat = D.subcat
		where A.IBN = __ibn
		AND C.Weight = 0
		AND C.Status = 'Active'
		GROUP BY A.ItemID;
    END IF;
END IF;


drop temporary table getcategorieslist;
END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.sp_receiving_generatepid
DELIMITER //
CREATE PROCEDURE `sp_receiving_generatepid`(
IN __manualpid VARCHAR(45))
BEGIN
DECLARE _temppid INT;

SET _temppid = (SELECT TempPID FROM wms_inbound.tbl_temp LIMIT 1);
UPDATE wms_inbound.tbl_temp SET TempPID = lpad(_temppid+1,6,0);
INSERT INTO wms_inbound.tbl_pallets(`PalletID`, `SystemPID`, `ManualPID`) VALUES(_temppid, (concat("PID", lpad(_temppid,6,0))), __manualpid);

SELECT lpad(_temppid,6,0);
END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.sp_receiving_getitemlocationsbycategory
DELIMITER //
CREATE PROCEDURE `sp_receiving_getitemlocationsbycategory`()
BEGIN
	SELECT * FROM wms_inbound.tbl_receivingitemsummary A
    WHERE A.IBN = 'IBN000000680';
END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.sp_receiving_listallpallettype
DELIMITER //
CREATE PROCEDURE `sp_receiving_listallpallettype`()
BEGIN
	SELECT * from wms_cloud.tbl_pallettype where PalletTypeID != 2;
END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.sp_receiving_loc_assignment_checker
DELIMITER //
CREATE PROCEDURE `sp_receiving_loc_assignment_checker`(
IN __pid int
)
BEGIN
DECLARE _exist INT;
DECLARE _roomcode VARCHAR (45);

SET _exist = (SELECT COUNT(*) from wms_inbound.tbl_locassignment where palletid = __pid);
SET _roomcode = (SELECT RoomCode FROM wms_inbound.tbl_locations where PalletID = 14233);

IF _exist = 0 THEN
	INSERT INTO wms_inbound.tbl_locassignment(PalletID, RoomCode, Room_Reason) VALUES(__pid, _roomcode, 'PUTAWAY');
END IF;

END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.SP_RECEIVING_onprocessIBN
DELIMITER //
CREATE PROCEDURE `SP_RECEIVING_onprocessIBN`()
BEGIN
    SELECT IBN, CompanyName, CreatedBy, LastUpdatedBy, created_at FROM wms_inbound.tbl_receiving A
    LEFT JOIN wms_cloud.tbl_customers B on A.CusID =B.CustomerID
    WHERE A.StatusID = 2
    AND A.StatusID <> 4
    AND A.StatusID <> 3
    ORDER BY IBN DESC;
END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.SP_RECEIVING_openIBN
DELIMITER //
CREATE PROCEDURE `SP_RECEIVING_openIBN`()
BEGIN
	SELECT IBN, CompanyName, CreatedBy, created_at, LastUpdatedBy FROM wms_inbound.tbl_receiving A
    LEFT JOIN wms_cloud.tbl_customers B on A.CusID = B.CustomerID
    WHERE A.StatusID = 0
    AND A.StatusID <> 4
    AND A.StatusID <> 3
    ORDER BY IBN DESC;
END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.SP_RECEIVING_pendingIBN
DELIMITER //
CREATE PROCEDURE `SP_RECEIVING_pendingIBN`()
BEGIN
    SELECT IBN, CompanyName, CreatedBy, LastUpdatedBy, created_at FROM wms_inbound.tbl_receiving A
    LEFT JOIN wms_cloud.tbl_customers B on A.CusID = B.CustomerID
    WHERE A.StatusID = 1
    AND A.StatusID <> 4
    AND A.StatusID <> 3
    ORDER BY IBN DESC;
END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.SP_RECEIVING_save_details
DELIMITER //
CREATE PROCEDURE `SP_RECEIVING_save_details`(
IN __timestart VARCHAR(45),
IN __statusid INT,
IN __customer_id INT,
IN __receivingdate VARCHAR(45),
IN __asn VARCHAR(45),
IN __container VARCHAR(45),
IN __vehicleplate VARCHAR(45),
IN __custreference VARCHAR(45),
IN __otherreference VARCHAR(45),
IN __seal VARCHAR(45),
IN __remarks VARCHAR(45),
IN __gatepass VARCHAR(45),
IN __loadingbay VARCHAR(45),
IN __checker VARCHAR(45),
IN __requestedby VARCHAR(45),
IN __requestorpd VARCHAR(45),
IN __supplier VARCHAR(45),
IN __lastupdatedby VARCHAR(45),
IN __trucktype INT,
IN __ibn VARCHAR(45),
IN __userid INT)
BEGIN
IF __timestart = 'notimestart' AND __customer_id = 0 THEN
	UPDATE wms_inbound.tbl_receiving SET StatusID=__statusid, ReceivingDate=__receivingdate, ASN=__asn, Container=__container, VehiclePlate=__vehicleplate, CustomerReference=__custreference, OtherReference=__otherreference, Seal=__seal, Remarks=__remarks, GatePass=__gatepass, LoadingBay=__loadingbay, Checker=__checker, RequestedBy=__requestedby, RequestorPD=__requestorpd, Supplier=__supplier, LastUpdatedBy=__lastupdatedby, TruckType=__trucktype  WHERE IBN =__ibn;

ELSEIF __timestart = 'notimestart' AND __customer_id > 0 THEN
	UPDATE wms_inbound.tbl_receiving SET StatusID=__statusid, CusID=__customer_id, ReceivingDate=__receivingdate, ASN=__asn, Container=__container, VehiclePlate=__vehicleplate, CustomerReference=__custreference, OtherReference=__otherreference, Seal=__seal, Remarks=__remarks, GatePass=__gatepass, LoadingBay=__loadingbay, Checker=__checker, RequestedBy=__requestedby, RequestorPD=__requestorpd, Supplier=__supplier, LastUpdatedBy=__lastupdatedby, TruckType=__trucktype  WHERE IBN =__ibn;

ELSEIF __timestart <> 'notimestart' AND __customer_id = 0 THEN
	UPDATE wms_inbound.tbl_receiving SET StatusID=__statusid, ReceivingDate=__receivingdate, ASN=__asn, Container=__container, VehiclePlate=__vehicleplate, CustomerReference=__custreference, OtherReference=__otherreference, Seal=__seal, Remarks=__remarks, TimeStart=__timestart, GatePass=__gatepass, LoadingBay=__loadingbay, Checker=__checker, RequestedBy=__requestedby, RequestorPD=__requestorpd, Supplier=__supplier, LastUpdatedBy=__lastupdatedby, TruckType=__trucktype  WHERE IBN =__ibn;

ELSE
	UPDATE wms_inbound.tbl_receiving SET StatusID=__statusid, CusID=__customer_id, ReceivingDate=__receivingdate, ASN=__asn, Container=__container, VehiclePlate=__vehicleplate, CustomerReference=__custreference, OtherReference=__otherreference, Seal=__seal, Remarks=__remarks, TimeStart=__timestart, GatePass=__gatepass, LoadingBay=__loadingbay, Checker=__checker, RequestedBy=__requestedby, RequestorPD=__requestorpd, Supplier=__supplier, LastUpdatedBy=__lastupdatedby, TruckType=__trucktype  WHERE IBN =__ibn;
END IF;

INSERT INTO wms_warehouse.tbl_systemlogs (transaction_no, module, submodule, activity, user_id, datetimestamp) VALUES (__ibn, "Inbound", "Receiving", "Checking of Items", __userid, NOW());

END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.sp_room_addroomlocations
DELIMITER //
CREATE PROCEDURE `sp_room_addroomlocations`(
IN __roomcode VARCHAR(45),
IN __lcode VARCHAR(45),
IN __columncode VARCHAR(45),
IN __locstatus INT,
IN __loadstatus INT,
IN __minweight DOUBLE,
IN __maxweight DOUBLE)
BEGIN

INSERT INTO wms_inbound.tbl_locations (`RoomCode`, `LCode`, `ColumnCode`, `LocStatus`, `ColStatus`, `LoadStatus`, `MinWeight`, `MaxWeight`, `ColName`)
VALUES (__roomcode, __lcode, __columncode, __locstatus, 1, __loadstatus, __minweight, __maxweight, __columncode);

END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.SP_room_assignment
DELIMITER //
CREATE PROCEDURE `SP_room_assignment`(
	IN `_roomcode` VARCHAR(45),
	IN `_reason` VARCHAR(200),
	IN `_pid` VARCHAR(45),
    IN __userid INT,
    IN __ibn VARCHAR(45)
)
BEGIN

INSERT INTO wms_inbound.tbl_locassignment (PalletID, RoomCode, Room_Reason) VALUES (_pid, _roomcode, _reason);

UPDATE wms_inbound.tbl_receivingitems SET ForPutaway = 3

WHERE PalletID = _pid AND IBN = __ibn AND Pallettype in (1,2);

insert into wms_warehouse.tbl_systemlogs (transaction_no, module, submodule, activity, user_id, datetimestamp)
values (__ibn, 'Inbound', 'Putaway', 'Confirm Location - Puller', __userid, now());

END//
DELIMITER ;

-- Dumping structure for procedure wms_inbound.sp_room_details
DELIMITER //
CREATE PROCEDURE `sp_room_details`(
IN __roomname VARCHAR(45),
IN __roomtype INT,
IN __roomrate DOUBLE,
IN __xrows INT,
IN __ycolumns INT,
IN __zlevels INT,
IN __roomstatus VARCHAR(45),
IN __mintemp VARCHAR(45),
IN __maxtemp VARCHAR(45),
IN __user INT)
BEGIN
DECLARE _newroomcode VARCHAR(45);
DECLARE _ifexist INT;

REPEAT
	SET _newroomcode = (
    SELECT CONCAT('RM',LPAD(REPLACE(RoomCode,'RM','')+1,4,0))
    FROM wms_inbound.tbl_room
    ORDER BY RoomID DESC LIMIT 1
    );
    
    SET _ifexist = (
    SELECT COUNT(RoomID)
    FROM wms_inbound.tbl_room
    WHERE RoomCode = _newroomcode);
    
    IF _ifexist = 0 THEN
		INSERT INTO wms_inbound.tbl_room (`RoomName`,`RoomCode`,`RoomTypeID`, `RoomRate`, `XVal`, `YVal`, `ZVal`, `RoomStatus`, `MinTemp`, `MaxTemp`) VALUES (__roomname, _newroomcode, __roomtype, __roomrate, __xrows, __ycolumns, __zlevels, __roomstatus, __mintemp, __maxtemp);
        SELECT _newroomcode;
        CALL wms_warehouse.sp_user_logs(_newroomcode,'Maintenance','Rooms','Add Room',__user);
    END IF;
    
UNTIL _ifexist = 0
END REPEAT;

END//
DELIMITER ;

-- Dumping structure for table wms_inbound.tbl_locassignment
CREATE TABLE IF NOT EXISTS `tbl_locassignment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `PalletID` int DEFAULT NULL,
  `RoomCode` varchar(45) DEFAULT NULL,
  `Room_Reason` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9337 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table wms_inbound.tbl_locationpostguaranteedhistory
CREATE TABLE IF NOT EXISTS `tbl_locationpostguaranteedhistory` (
  `id` int NOT NULL,
  `RoomCode` varchar(45) DEFAULT NULL,
  `LocationCode` varchar(45) DEFAULT NULL,
  `ReservedTo` varchar(45) DEFAULT NULL,
  `User` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_inbound.tbl_locations
CREATE TABLE IF NOT EXISTS `tbl_locations` (
  `LocationID` int NOT NULL AUTO_INCREMENT,
  `RoomCode` varchar(45) DEFAULT NULL,
  `LCode` varchar(45) DEFAULT NULL,
  `ColName` varchar(45) DEFAULT NULL,
  `PalName` varchar(45) DEFAULT NULL,
  `PalletID` varchar(50) DEFAULT NULL,
  `LocStatus` int DEFAULT NULL,
  `ColStatus` int DEFAULT NULL,
  `CustomerID` int DEFAULT NULL,
  `LoadStatus` int DEFAULT NULL,
  `ColumnCode` varchar(45) DEFAULT NULL,
  `MaxWeight` double DEFAULT NULL,
  `MinWeight` double DEFAULT NULL,
  `StartRent` varchar(45) DEFAULT NULL,
  `EndRent` varchar(45) DEFAULT NULL,
  `ReservedClient` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`LocationID`)
) ENGINE=InnoDB AUTO_INCREMENT=51376 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_inbound.tbl_pallets
CREATE TABLE IF NOT EXISTS `tbl_pallets` (
  `PalletID` int NOT NULL AUTO_INCREMENT,
  `SystemPID` varchar(45) DEFAULT NULL,
  `ManualPID` varchar(45) DEFAULT NULL,
  `LocationID` varchar(50) DEFAULT NULL,
  `IBN` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`PalletID`),
  KEY `tbl_pallets_idx_palletid` (`PalletID`)
) ENGINE=InnoDB AUTO_INCREMENT=29047 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_inbound.tbl_putawayhistory
CREATE TABLE IF NOT EXISTS `tbl_putawayhistory` (
  `id` int NOT NULL,
  `IBN` varchar(45) DEFAULT NULL,
  `Reason` varchar(255) DEFAULT NULL,
  `PalletID` int DEFAULT NULL,
  `FromLocationID` int DEFAULT NULL,
  `ToLocationID` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_inbound.tbl_receiving
CREATE TABLE IF NOT EXISTS `tbl_receiving` (
  `ReceivingID` int NOT NULL AUTO_INCREMENT,
  `StatusID` int DEFAULT NULL,
  `IBN` varchar(255) DEFAULT NULL,
  `CusID` int DEFAULT NULL,
  `ReceivingDate` datetime DEFAULT NULL,
  `ASN` varchar(45) DEFAULT NULL,
  `Container` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `VehiclePlate` varchar(45) DEFAULT NULL,
  `CustomerReference` varchar(45) DEFAULT NULL,
  `OtherReference` varchar(45) DEFAULT NULL,
  `Seal` varchar(45) DEFAULT NULL,
  `Remarks` varchar(45) DEFAULT NULL,
  `TimeStart` datetime DEFAULT NULL,
  `TimeFinish` datetime DEFAULT NULL,
  `GatePass` varchar(45) DEFAULT NULL,
  `LoadingBay` varchar(45) DEFAULT NULL,
  `Checker` varchar(45) DEFAULT NULL,
  `RequestedBy` varchar(45) DEFAULT NULL,
  `Location` varchar(45) DEFAULT NULL,
  `RequestorPD` varchar(45) DEFAULT NULL,
  `Supplier` varchar(45) DEFAULT NULL,
  `TruckType` varchar(50) DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  `LastUpdatedBy` varchar(45) DEFAULT NULL,
  `EndDate` datetime DEFAULT NULL,
  `FromCP` text,
  `CPStatus_id` int DEFAULT NULL,
  `Warehouse_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ReceivingID`)
) ENGINE=InnoDB AUTO_INCREMENT=1259 DEFAULT CHARSET=utf8mb3 COMMENT='`FromCP` text DEFAULT NULL,\r\n  `CPStatus_id` int(11) DEFAULT NULL,\r\n  `Warehouse_id` int(11) DEFAULT NULL,';

-- Data exporting was unselected.

-- Dumping structure for table wms_inbound.tbl_receivingitems
CREATE TABLE IF NOT EXISTS `tbl_receivingitems` (
  `ReceivingItemID` int NOT NULL AUTO_INCREMENT,
  `IBN` varchar(45) DEFAULT NULL,
  `ItemID` int DEFAULT NULL,
  `CustomerID` int DEFAULT NULL,
  `TempPID` varchar(50) DEFAULT NULL,
  `PalletID` int DEFAULT NULL,
  `PalletType` int DEFAULT NULL,
  `StoringTypeID` int DEFAULT NULL,
  `ChargeTypeID` int DEFAULT NULL,
  `ItemStatusID` int DEFAULT NULL,
  `Beg_Quantity` double DEFAULT NULL,
  `Beg_Weight` double DEFAULT NULL,
  `Quantity` double DEFAULT NULL,
  `Weight` double DEFAULT NULL,
  `ExpiryDate` datetime DEFAULT NULL,
  `ProdDate` datetime DEFAULT NULL,
  `Batch` varchar(45) DEFAULT NULL,
  `QAReason` varchar(45) DEFAULT NULL,
  `Checked` varchar(45) DEFAULT 'False',
  `ForPutaway` int DEFAULT '1',
  `QRCode` varchar(45) DEFAULT NULL,
  `ItemRemark` varchar(255) DEFAULT NULL,
  `ispick` int DEFAULT NULL,
  `isout` int DEFAULT NULL,
  PRIMARY KEY (`ReceivingItemID`),
  KEY `tbl_receivingitems_idx_custom_storin_forput_receiv_quanti` (`CustomerID`,`StoringTypeID`,`ForPutaway`,`ReceivingItemID`,`Quantity`)
) ENGINE=InnoDB AUTO_INCREMENT=2121459 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_inbound.tbl_receivingitemsummary
CREATE TABLE IF NOT EXISTS `tbl_receivingitemsummary` (
  `ReceivingItemSummaryID` int NOT NULL AUTO_INCREMENT,
  `IBN` varchar(45) DEFAULT NULL,
  `ItemID` int DEFAULT NULL,
  `Beg_Quantity` double DEFAULT NULL,
  `Beg_Weight` double DEFAULT NULL,
  `Quantity` double DEFAULT NULL,
  `Weight` double DEFAULT NULL,
  `StorageType` varchar(45) DEFAULT NULL,
  `ExpiryDate` datetime DEFAULT NULL,
  PRIMARY KEY (`ReceivingItemSummaryID`)
) ENGINE=InnoDB AUTO_INCREMENT=1383 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_inbound.tbl_roles
CREATE TABLE IF NOT EXISTS `tbl_roles` (
  `roleid` int NOT NULL AUTO_INCREMENT,
  `rolename` varchar(45) DEFAULT NULL,
  `roleaccess` text,
  PRIMARY KEY (`roleid`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_inbound.tbl_room
CREATE TABLE IF NOT EXISTS `tbl_room` (
  `RoomID` int NOT NULL AUTO_INCREMENT,
  `RoomName` varchar(45) DEFAULT NULL,
  `RoomCode` varchar(45) DEFAULT NULL,
  `RoomTypeID` int DEFAULT NULL,
  `RoomRate` double DEFAULT NULL,
  `RoomStatus` varchar(45) DEFAULT NULL,
  `CustomerID` int DEFAULT NULL,
  `StartRent` varchar(45) DEFAULT NULL,
  `EndRent` varchar(45) DEFAULT NULL,
  `MinTemp` varchar(45) DEFAULT NULL,
  `MaxTemp` varchar(45) DEFAULT NULL,
  `XVal` int DEFAULT NULL,
  `YVal` int DEFAULT NULL,
  `ZVal` int DEFAULT NULL,
  `Capacity` int DEFAULT NULL,
  PRIMARY KEY (`RoomID`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_inbound.tbl_temp
CREATE TABLE IF NOT EXISTS `tbl_temp` (
  `id` int NOT NULL,
  `TempPID` int DEFAULT NULL,
  `TempIBN` int DEFAULT NULL,
  `TempOBD` int DEFAULT NULL,
  `TempCusCode` int DEFAULT NULL,
  `TempRoomCode` int DEFAULT NULL,
  `TempItemSummaryCount` int DEFAULT NULL,
  `TempZeroPID` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_inbound.tbl_users
CREATE TABLE IF NOT EXISTS `tbl_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `phase` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for procedure wms_inbound.test
DELIMITER //
CREATE PROCEDURE `test`(
-- GENERATEGLACIERCODE
IN __custid INT,
IN __cat INT,
IN __desc VARCHAR(255),

-- INFO  TO ADD
IN __clientsku VARCHAR(45),
IN __matstype VARCHAR(191),
IN __mintemp VARCHAR(191),
IN __maxtemp VARCHAR(45),
IN __length DOUBLE,
IN __width DOUBLE,
IN __height DOUBLE,
IN __weight DOUBLE,
IN __pcspercase INT,
IN __casesperpallet INT,
IN __uomid INT,
IN __repqty INT,
IN __parentcode VARCHAR(45),
IN __subcat INT,
IN __shelflife INT,
IN __price DOUBLE,
IN __itemclass VARCHAR(45),
IN __priceclass VARCHAR(45),
IN __minqty INT,
IN __maxqty INT,
IN __user INT
)
BEGIN

DECLARE _count INT;
DECLARE _alpha VARCHAR(26);
DECLARE _category VARCHAR(1);
DECLARE _desc VARCHAR(1);
DECLARE _custcode VARCHAR(45);
DECLARE _code VARCHAR(45);
DECLARE _glaciercode VARCHAR(45);
DECLARE _ifexist INT;

SET _alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
SET _category = (SUBSTRING(_alpha,__cat,1));
SET _desc = (SUBSTRING(__desc,1,1));
SET _custcode = (SELECT CustomerCode FROM wms_cloud.tbl_customers WHERE CustomerID=__custid);
SET _code = (CONCAT(SUBSTRING(_custcode,1,2),SUBSTRING(_custcode,-3)));


-- SELECT _glaciercode;
REPEAT
SET _count = (SELECT COUNT(*)+1 FROM wms_cloud.tbl_items WHERE ItemCustomerID=__custid);
SET _glaciercode = CONCAT(_code,_category,_desc,LPAD(_count,4,0));

SET _ifexist = (SELECT COUNT(*) FROM wms_cloud.tbl_items WHERE ItemCode = _glaciercode);
IF _ifexist = 0 THEN
	INSERT INTO wms_cloud.tbl_items(`ItemCode`,`Client_SKU`,`ItemDesc`,`ItemCustomerID`,`MaterialType`,`Category`,`MinTemp`,`MaxTemp`,`Length`,`Width`,`Height`, `Weight`, `PiecesPerCase`,`CasesPerPallet`,`UOMID`,`RepQTY`, `ParentCode`, `SubCat`, `ShelfLife`, `Price`, `Status`, `ItemClass`, `PriceClass`, `MinQty`, `MaxQty`)
VALUES (_glaciercode, __clientsku, __desc, __custid, __matstype, __cat, __mintemp, __maxtemp, __length, __width, __height, __weight, __pcspercase, __casesperpallet, __uomid, __repqty, __parentcode, __subcat, __shelflife, __price, 'Hold', __itemclass, __priceclass, __minqty, __maxqty);

CALL wms_warehouse.sp_user_logs(_glaciercode,'Maintenance','Customers','Add Items',__user);
END IF;
UNTIL _ifexist = 0
END REPEAT;

END//
DELIMITER ;

-- Dumping structure for view wms_inbound.vw_putaway
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_putaway` (
	`PalletID` INT(10) NULL,
	`SystemPID` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`ManualPID` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`itemdesc` TEXT NULL COLLATE 'utf8_general_ci',
	`beg_quantity` DOUBLE NULL,
	`beg_weight` DOUBLE NULL,
	`RoomName` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`ColName` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`CustomerID` INT(10) NULL,
	`LCode` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`ForPutaway` INT(10) NULL,
	`PalletType` INT(10) NULL,
	`UOM_Abv` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`IBN` VARCHAR(45) NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Dumping structure for view wms_inbound.vw_putaway
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_putaway`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `wms_inbound`.`vw_putaway` AS select `wms_inbound`.`tbl_receivingitems`.`PalletID` AS `PalletID`,`wms_inbound`.`tbl_pallets`.`SystemPID` AS `SystemPID`,`wms_inbound`.`tbl_pallets`.`ManualPID` AS `ManualPID`,group_concat(distinct `wms_cloud`.`tbl_items`.`ItemDesc` separator '/') AS `itemdesc`,round(sum(`wms_inbound`.`tbl_receivingitems`.`Beg_Quantity`),0) AS `beg_quantity`,round(sum(`wms_inbound`.`tbl_receivingitems`.`Beg_Weight`),2) AS `beg_weight`,`wms_inbound`.`tbl_room`.`RoomName` AS `RoomName`,`wms_inbound`.`tbl_locations`.`ColName` AS `ColName`,`wms_inbound`.`tbl_receivingitems`.`CustomerID` AS `CustomerID`,`wms_inbound`.`tbl_locations`.`LCode` AS `LCode`,`wms_inbound`.`tbl_receivingitems`.`ForPutaway` AS `ForPutaway`,`wms_inbound`.`tbl_receivingitems`.`PalletType` AS `PalletType`,`wms_cloud`.`tbl_weightuom`.`UOM_Abv` AS `UOM_Abv`,`wms_inbound`.`tbl_receivingitems`.`IBN` AS `IBN` from (((((`wms_inbound`.`tbl_receivingitems` left join `wms_inbound`.`tbl_pallets` on((`wms_inbound`.`tbl_receivingitems`.`PalletID` = `wms_inbound`.`tbl_pallets`.`PalletID`))) left join `wms_inbound`.`tbl_locations` on((`wms_inbound`.`tbl_pallets`.`LocationID` = `wms_inbound`.`tbl_locations`.`LocationID`))) left join `wms_inbound`.`tbl_room` on((`wms_inbound`.`tbl_locations`.`RoomCode` = `wms_inbound`.`tbl_room`.`RoomCode`))) left join `wms_cloud`.`tbl_items` on((`wms_inbound`.`tbl_receivingitems`.`ItemID` = `wms_cloud`.`tbl_items`.`ItemID`))) left join `wms_cloud`.`tbl_weightuom` on((`wms_cloud`.`tbl_items`.`UOMID` = `wms_cloud`.`tbl_weightuom`.`UOMID`))) where (`wms_inbound`.`tbl_receivingitems`.`ForPutaway` >= 2) group by `wms_inbound`.`tbl_pallets`.`PalletID`,`wms_inbound`.`tbl_receivingitems`.`CustomerID`,`wms_inbound`.`tbl_receivingitems`.`Checked`,`wms_inbound`.`tbl_receivingitems`.`PalletID`,`wms_inbound`.`tbl_room`.`RoomName`,`wms_inbound`.`tbl_receivingitems`.`ForPutaway`,`wms_inbound`.`tbl_receivingitems`.`PalletType`,`wms_cloud`.`tbl_weightuom`.`UOM_Abv`;


-- Dumping database structure for wms_outbound
CREATE DATABASE IF NOT EXISTS `wms_outbound` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `wms_outbound`;

-- Dumping structure for procedure wms_outbound.sp_add_actual_pick
DELIMITER //
CREATE PROCEDURE `sp_add_actual_pick`(
	in `__pck` varchar(200),
	in `__receivingitemid` int,
	in `__itemid` int
)
begin
update wms_inbound.tbl_receivingitems set ispick = 2
where receivingitemid = __receivingitemid;
delete
from wms_outbound.tbl_actual_pick
where pck = __pck and itemid = __itemid and receivingitemid = __receivingitemid;
insert into wms_outbound.tbl_actual_pick(pck,itemid,receivingitemid, status) values(__pck,__itemid,__receivingitemid,'PICKED'); end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_add_manual
DELIMITER //
CREATE PROCEDURE `sp_add_manual`(
	in `__expiry` varchar(200),
	in `__itemid` int,
	in `__palletid` int,
	in `__amount` int,
	in `__pck` varchar(200),
	in `__orderedquantity` int,
	in `__itemstatusid` int
)
begin
create temporary table tmp_rx(
select __pck, receivingitemid,a.itemid, a.quantity, a.weight
from wms_inbound.tbl_receivingitems a
where a.itemid = __itemid 
and a.palletid = __palletid 
and a.expirydate = __expiry 
and a.quantity > 0 
and a.itemstatusid = __itemstatusid 
and a.ispick <> 2 
and a.isout = 0
limit __amount
);
update wms_inbound.tbl_receivingitems a
inner join tmp_rx b on a.receivingitemid = b.receivingitemid 
set a.ispick = 1
where a.ispick = 0;
insert into wms_outbound.tbl_pickingitems (`pck`, `receivingitemid`, `itemid`, `quantity`, `weight`) 
 (
select *
from tmp_rx);
drop temporary table tmp_rx; end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_add_manual_cw
DELIMITER //
CREATE PROCEDURE `sp_add_manual_cw`(
	in `__itemid` int,
	in `__pck` varchar(200),
	in `__receivingitemid` int
)
begin
create temporary table tmp_rx_cw(
select __pck, a.receivingitemid, a.itemid, a.quantity, a.weight
from wms_inbound.tbl_receivingitems a
where a.receivingitemid = __receivingitemid and a.ispick <> 2 and a.isout = 0
);
update wms_inbound.tbl_receivingitems a
inner join tmp_rx_cw b on a.receivingitemid = b.receivingitemid set a.ispick = 1
where a.ispick = 0;
insert into wms_outbound.tbl_pickingitems (`pck`, `receivingitemid`, `itemid`, `quantity`, `weight`) 
 (
select *
from tmp_rx_cw);
drop temporary table tmp_rx_cw; end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_allocated_list
DELIMITER //
CREATE PROCEDURE `sp_allocated_list`(
	in `__ord` varchar(200),
	in `__pck` varchar(200)
)
begin declare __picklistid int; 

set __picklistid =(
select id
from wms_outbound.tbl_picking
where `ord` = __ord and `pck` = __pck);

select 
a.id, 
concat(d.systempid,'-',d.manualpid) as pallet, 
concat(e.colname,'-',right(e.lcode, 1)) as location, 
coalesce(f.client_sku,f.itemcode) as sku,
f.itemdesc as itemdesc, 
count(distinct(b.receivingid)) as allocated_qty,
g.uom_abv as uom,
ROUND(sum(c.weight),2) as allocated_weight,
(case when a.expirydate is null then 'NO EXPIRY' else date(a.expirydate) end) as expirydate,
sum(case when c.ispick = 1 then 1 else 0 end) indicator
from wms_outbound.tbl_allocations a
left join wms_outbound.tbl_allocation_details b on a.id = b.allocid
left join wms_inbound.tbl_receivingitems c on b.receivingid = c.receivingitemid
left join wms_inbound.tbl_pallets d on c.palletid = d.palletid
left join wms_inbound.tbl_locations e on e.palletid = d.palletid
left join wms_cloud.tbl_items f on c.itemid = f.itemid
left join wms_cloud.tbl_weightuom g on f.uomid = g.uomid
where a.pickingid = __picklistid
group by a.id
order by a.itemid asc; 
end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_allocated_list_groupbyitemid
DELIMITER //
CREATE PROCEDURE `sp_allocated_list_groupbyitemid`(
	in `__ord` varchar(200),
	in `__pck` varchar(200)
)
begin 
	declare __picklistid int; 
    set __picklistid =(
select id
from wms_outbound.tbl_picking
where `ord` = __ord and `pck` = __pck);


select 
a.id, 
concat(d.systempid,'-',d.manualpid) as pallet, 
concat(e.colname,'-',right(e.lcode, 1)) as location, 
coalesce(f.client_sku,f.itemcode) as sku,
f.itemdesc as itemdesc, 
count(distinct(b.receivingid)) as allocated_qty,
g.uom_abv as uom,
ROUND(sum(c.weight),2) as allocated_weight,
(case when a.expirydate is null then 'NO EXPIRY' else date(a.expirydate) end) as expirydate,
sum(case when c.ispick = 1 then 1 else 0 end) indicator
from wms_outbound.tbl_allocations a
left join wms_outbound.tbl_allocation_details b on a.id = b.allocid
left join wms_inbound.tbl_receivingitems c on b.receivingid = c.receivingitemid
left join wms_inbound.tbl_pallets d on c.palletid = d.palletid
left join wms_inbound.tbl_locations e on e.palletid = d.palletid
left join wms_cloud.tbl_items f on c.itemid = f.itemid
left join wms_cloud.tbl_weightuom g on f.uomid = g.uomid
where a.pickingid = __picklistid
group by d.palletid
order by a.itemid asc; 
end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_allocation_clear
DELIMITER //
CREATE PROCEDURE `sp_allocation_clear`(
	in `__palletid` int,
	in `__weight` double,
	in `__expiry` varchar(200),
	in `__status` varchar(200),
	in `__ord` varchar(200),
	in `__pck` varchar(200),
	in `__rxvcode` int,
	in `__qty` int
)
begin
declare __picklistid int;
declare __allocid int;
declare __itemid int;

set __itemid =(
select itemid
from wms_inbound.tbl_receivingitems
where `receivingitemid` = __rxvcode);

set __picklistid =(
select id
from wms_outbound.tbl_picking
where `ord` = __ord and pck = __pck);

set __allocid =(
select id
from wms_outbound.tbl_allocations a
where a.palletid = __palletid and a.itemid = __itemid and a.pickingid = __picklistid);

update wms_outbound.tbl_allocation_details a
left join wms_inbound.tbl_receivingitems b on a.receivingid = b.receivingitemid set b.ispick = 0
where a.picklistid = __picklistid and a.allocid = __allocid;

delete
from wms_outbound.tbl_allocation_details
where picklistid = __picklistid and allocid = __allocid;

delete
from wms_outbound.tbl_allocations
where pickingid = __picklistid and palletid = __palletid and itemid = __itemid;

end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_allocation_plus
DELIMITER //
CREATE PROCEDURE `sp_allocation_plus`(

	IN `__PALLETID` INT,

	IN `__WEIGHTED` DOUBLE,

	IN `__EXPIRYDATE` VARCHAR(200),

	IN `____STATUS` VARCHAR(200),

	IN `__ORD` VARCHAR(200),

	IN `__PCK` VARCHAR(200),

	IN `__rxvcode` INT,

	IN `__QTY` INT,
	
	IN `__userid` INT
)
BEGIN 
	DECLARE __picklistid INT; 
	DECLARE __ALLOCID INT; 
	DECLARE __isexist INT DEFAULT 0; 
	DECLARE __ITEMID INT; 
    DECLARE __STATUS VARCHAR(200);

	DECLARE __EXPIRY VARCHAR(200); 

	DECLARE __WEIGHT DOUBLE;

	SET __STATUS =(SELECT B.ItemStatus
	FROM wms_inbound.tbl_receivingitems A
	LEFT JOIN wms_cloud.tbl_itemstatus B ON A.ItemStatusID = B.ItemStatusID
	WHERE `ReceivingItemID` = __rxvcode 
    LIMIT 1);

	SET __WEIGHT =(SELECT COALESCE(Weight,0)
	FROM wms_inbound.tbl_receivingitems
	WHERE `ReceivingItemID` = __rxvcode
	LIMIT 1);

	SET __EXPIRY = (SELECT COALESCE(DATE(ExpiryDate),'NO EXPIRY')
	FROM wms_inbound.tbl_receivingitems
	WHERE `ReceivingItemID` = __rxvcode
	LIMIT 1);

	SET __ITEMID =(
	SELECT ItemID
	FROM wms_inbound.tbl_receivingitems
	WHERE `ReceivingItemID` = __rxvcode
	LIMIT 1);

	SET __picklistid =(
	SELECT id
	FROM wms_outbound.tbl_picking
	WHERE `ORD` = __ORD AND PCK = __PCK
	LIMIT 1);

	SET __isexist =(
	SELECT COALESCE(qty,0)
	FROM wms_outbound.tbl_allocations
	WHERE `pickingid` = __picklistid 
	AND `palletid` = __PALLETID 
	AND `weight` = __WEIGHT 
	AND `status` = __STATUS 
	AND `itemid` = __ITEMID
    AND COALESCE(DATE(expirydate),'NO EXPIRY') = __EXPIRY
	LIMIT 1);

 

	 IF __isexist > 0 THEN 

	 IF __EXPIRY = 'NO EXPIRY' THEN

	UPDATE wms_outbound.tbl_allocations SET qty=qty+__QTY
	WHERE palletid = __PALLETID 
    AND `weight` = __WEIGHT 
    AND `status` = __STATUS 
    AND `itemid` = __ITEMID 
    AND `pickingid` = __picklistid
	LIMIT 1; 

	SET __ALLOCID =(
	SELECT id
	FROM wms_outbound.tbl_allocations A
	WHERE A.palletid = __PALLETID 
    AND A.weight = __WEIGHT 
    AND A.status = __STATUS 
    AND A.itemid = __ITEMID
    AND A.pickingid = __picklistid
	LIMIT 1);

	CREATE TEMPORARY TABLE TT_allocated
	(
	SELECT A.ReceivingItemID
	FROM wms_inbound.tbl_receivingitems A
	LEFT JOIN wms_cloud.tbl_itemstatus B ON A.Itemstatusid = B.itemstatusid
	WHERE A.ItemID = __ITEMID 
    AND A.weight = __WEIGHT 
    AND B.Itemstatus = __STATUS 
    AND A.PalletID = __PALLETID 
    AND A.ispick = 0 
    AND A.isout = 0
    AND ((A.forputaway >= 6) OR (A.forputaway = 0))
	LIMIT __QTY
	); 
    
    ELSE

	UPDATE wms_outbound.tbl_allocations 
    SET qty=qty+__QTY
	WHERE palletid = __PALLETID 
	AND weight = __WEIGHT 
	AND DATE(expirydate) = __EXPIRY 
	AND status = __STATUS 
	AND itemid = __ITEMID 
	AND pickingid = __picklistid
	LIMIT 1; 


	SET __ALLOCID =(
	SELECT id
	FROM wms_outbound.tbl_allocations A
	WHERE A.palletid = __PALLETID 
	AND A.weight = __WEIGHT 
	AND DATE(expirydate) = __EXPIRY 
	AND A.status = __STATUS 
	AND A.itemid = __ITEMID
    AND A.pickingid = __picklistid
	LIMIT 1);

	CREATE TEMPORARY TABLE TT_allocated
	(
	SELECT A.receivingitemid
	FROM wms_inbound.tbl_receivingitems A
	LEFT JOIN wms_cloud.tbl_itemstatus B ON A.Itemstatusid = B.itemstatusid
	WHERE A.ItemID = __ITEMID 
	AND A.weight = __WEIGHT 
	AND DATE(A.ExpiryDate) = __EXPIRY 
	AND B.Itemstatus = __STATUS 
	AND A.PalletID = __PALLETID 
	AND A.ispick = 0 
	AND A.isout = 0
    AND ((A.forputaway >= 6) OR (A.forputaway = 0))
	LIMIT __QTY
	); 

	END IF;

	INSERT INTO wms_outbound.tbl_allocation_details(picklistid,allocid,receivingid, status)
	(
	SELECT __picklistid,__ALLOCID, receivingitemid,'MANUALPICK'
	FROM TT_allocated
	);

	UPDATE TT_allocated A
	LEFT JOIN wms_inbound.tbl_receivingitems B ON A.receivingitemid = B.receivingitemid 
	SET B.ispick = 1;

	DROP TABLE TT_allocated; 

ELSE 


 IF __EXPIRY = 'NO EXPIRY' THEN

	INSERT INTO wms_outbound.tbl_allocations(`pickingid`, `palletid`, `expirydate`, `weight`, `itemid`, `qty`,`status`)
	(
	SELECT __picklistid, A.palletid, A.expirydate, A.weight, A.ITEMID,__QTY,B.Itemstatus
	FROM wms_inbound.tbl_receivingitems A
	LEFT JOIN wms_cloud.tbl_itemstatus B ON A.itemstatusid = B.itemstatusid
	WHERE A.palletid = __PALLETID 
    AND A.weight = __WEIGHT 
    AND B.Itemstatus = __STATUS 
    AND A.ItemID = __ITEMID
	AND A.ispick = 0 
	AND A.isout = 0
    AND ((A.forputaway >= 6) OR (A.forputaway = 0))
	LIMIT 1
	); 

	SET __ALLOCID =(
	SELECT id
	FROM wms_outbound.tbl_allocations A
	WHERE A.palletid = __PALLETID 
	AND A.weight = __WEIGHT 
	AND A.status = __STATUS 
	AND A.itemid = __ITEMID
    AND A.pickingid = __picklistid
	LIMIT 1);

	CREATE TEMPORARY TABLE TT_allocated
	(
	SELECT A.receivingitemid
	FROM wms_inbound.tbl_receivingitems A
	LEFT JOIN wms_cloud.tbl_itemstatus B ON A.Itemstatusid = B.itemstatusid
	WHERE A.ItemID = __ITEMID 
	AND A.weight = __WEIGHT 
	AND B.Itemstatus = __STATUS 
	AND A.PalletID = __PALLETID 
	AND A.ispick = 0 
	AND A.isout = 0
    AND ((A.forputaway >= 6) OR (A.forputaway = 0))
	LIMIT __QTY
	);

 ELSE

	INSERT INTO wms_outbound.tbl_allocations(`pickingid`, `palletid`, `expirydate`, `weight`, `itemid`, `qty`,`status`)
	 (
	SELECT __picklistid, A.PalletID, A.ExpiryDate, A.Weight, A.ItemID,__QTY,B.ItemStatus
	FROM wms_inbound.tbl_receivingitems A
	LEFT JOIN wms_cloud.tbl_itemstatus B ON A.itemstatusid = B.ItemStatusID
	WHERE A.PalletID = __PALLETID 
	AND A.Weight = __WEIGHT 
	AND DATE(A.ExpiryDate) = __EXPIRY 
	AND B.ItemStatus = __STATUS 
	AND A.ItemID = __ITEMID
	AND A.ispick = 0 
	AND A.isout = 0
    AND ((A.forputaway >= 6) OR (A.forputaway = 0))
	LIMIT 1
	); 


	SET __ALLOCID =(
	SELECT id
	FROM wms_outbound.tbl_allocations A
	WHERE A.palletid = __PALLETID 
    AND A.weight = __WEIGHT 
    AND DATE(A.expirydate) = __EXPIRY 
    AND A.status = __STATUS 
    AND A.itemid = __ITEMID
    AND A.pickingid = __picklistid
	LIMIT 1);

	CREATE TEMPORARY TABLE TT_allocated
	 (
	SELECT A.ReceivingItemID
	FROM wms_inbound.tbl_receivingitems A
	LEFT JOIN wms_cloud.tbl_itemstatus B ON A.ItemStatusID = B.itemstatusid
	WHERE A.ItemID = __ITEMID 
	AND A.Weight = __WEIGHT 
	AND DATE(A.ExpiryDate) = __EXPIRY 
	AND B.Itemstatus = __STATUS 
	AND A.PalletID = __PALLETID 
	AND A.ispick = 0 
	AND A.isout = 0
    AND ((A.forputaway >= 6) OR (A.forputaway = 0))
	LIMIT __QTY
	); 

END IF ;

	INSERT INTO wms_outbound.tbl_allocation_details(picklistid,allocid,receivingid, status)
	 (
	SELECT __picklistid,__ALLOCID,receivingitemid,'MANUALPICK'
	FROM TT_allocated
	);

	UPDATE TT_allocated A
	LEFT JOIN wms_inbound.tbl_receivingitems B ON A.ReceivingItemID = B.ReceivingItemID 
    SET B.ispick = 1;






DROP TABLE TT_allocated; 

END IF;

 call wms_reports.sp_picking_logs(__PCK,'MANUAL PICK',__PALLETID,__QTY,__userid);

	SELECT COALESCE(QTY,0)
	FROM wms_outbound.tbl_allocations
	WHERE `pickingid` = __picklistid 
	AND `palletid` = __PALLETID 
	AND `weight` = __WEIGHT 
	AND `status` = __STATUS 
	AND `itemid` = __ITEMID

LIMIT 1; 
END//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_cluster_actual_collapse
DELIMITER //
CREATE PROCEDURE `sp_cluster_actual_collapse`(

	in `__palletid` int,

	in `__itemid` int

)
begin declare iscw double; set iscw = (

select weight

from wms_cloud.tbl_items

where itemid = __itemid);

 

 if (iscw <> 0) then

select 
 c.container, 
 sum(a.quantity) as totalitems,
 a.weight as perpiece, 
(case when a.expirydate is null then 'NO EXPIRY' else date(a.expirydate) end), 
 d.itemstatus, 
 a.receivingitemid
from wms_inbound.tbl_receivingitems a
left join wms_cloud.tbl_items b on a.itemid= b.itemid
left join wms_inbound.tbl_receiving c on a.ibn = c.ibn
left join wms_cloud.tbl_itemstatus d on a.itemstatusid = d.itemstatusid
where a.palletid = __palletid 
and a.itemid = __itemid 
and a.ispick = 0 
and a.isout = 0 
and a.quantity > 0 
and a.checked = 'True' 
and ((a.forputaway > 1) or (a.forputaway = 0))
group by a.expirydate,a.weight,b.itemcode,d.itemstatusid; 

else

select 
 c.container, 
 sum(a.quantity) as totalitems,
 a.weight as perpiece, 
(case when a.expirydate is null then 'NO EXPIRY' else date(a.expirydate) end), 
 d.itemstatus, 
 a.receivingitemid
from wms_inbound.tbl_receivingitems a
left join wms_cloud.tbl_items b on a.itemid= b.itemid
left join wms_inbound.tbl_receiving c on a.ibn = c.ibn
left join wms_cloud.tbl_itemstatus d on a.itemstatusid = d.itemstatusid
where a.palletid = __palletid 
and a.itemid = __itemid 
and a.ispick = 0 
and a.isout = 0 
and a.quantity > 0 
and a.checked = 'True' 
and ((a.forputaway > 1) or (a.forputaway = 0))
and a.quantity = 1
group by a.expirydate,a.weight,b.itemcode,d.itemstatusid; 

end if; 
end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_cluster_collapse
DELIMITER //
CREATE PROCEDURE `sp_cluster_collapse`(

	in `__palletid` int,

	in `__itemid` int

)
begin declare iscw double; set iscw = (

select weight
from wms_cloud.tbl_items
where itemid = __itemid);

 if (iscw <> 0) then

select 
c.container, 
sum(a.quantity) as totalitems,
a.weight as perpiece, 
(case when a.expirydate is null then 'NO EXPIRY' else date(a.expirydate) end), 
d.itemstatus, 
a.receivingitemid
from wms_inbound.tbl_receivingitems a
left join wms_cloud.tbl_items b on a.itemid= b.itemid
left join wms_inbound.tbl_receiving c on a.ibn = c.ibn
left join wms_cloud.tbl_itemstatus d on a.itemstatusid = d.itemstatusid
where a.palletid = __palletid 
and a.itemid = __itemid 
and a.ispick = 0
and a.isout = 0 
and a.quantity > 0 
and a.checked = 'True' 
and ((a.forputaway > 1) or (a.forputaway = 0))
group by a.expirydate,a.weight,b.itemcode,d.itemstatusid; 

else

select 
c.container, 
sum(a.quantity) as totalitems,
a.weight as perpiece, 
(case when a.expirydate is null then 'NO EXPIRY' else date(a.expirydate) end),
d.itemstatus, 
a.receivingitemid
from wms_inbound.tbl_receivingitems a
left join wms_cloud.tbl_items b on a.itemid= b.itemid
left join wms_inbound.tbl_receiving c on a.ibn = c.ibn
left join wms_cloud.tbl_itemstatus d on a.itemstatusid = d.itemstatusid
where a.palletid = __palletid 
and a.itemid = __itemid 
and a.ispick = 0 
and a.isout = 0 
and a.quantity > 0 
and a.checked = 'True' 
and ((a.forputaway > 1) or (a.forputaway = 0))
and a.quantity = 1
group by a.expirydate,a.weight,b.itemcode,d.itemstatusid; 
end if; 
end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_cw_add
DELIMITER //
CREATE PROCEDURE `sp_cw_add`(
	in `__pck` varchar(200),
	in `__receivingitemid` int,
	in `__itemid` int,
	in `__quantity` double,
	in `__weight` double
)
begin
update wms_inbound.tbl_receivingitems a set a.ispick = 1
where a.ispick = 0 and a.receivingitemid = __receivingitemid;
insert into wms_outbound.tbl_pickingitems (`pck`, `receivingitemid`, `itemid`, `quantity`, `weight`) values (__pck, __receivingitemid, __itemid, __quantity, __weight); end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_del_actual_pick
DELIMITER //
CREATE PROCEDURE `sp_del_actual_pick`(
	in `__pck` varchar(200),
	in `__receivingitemid` int,
	in `__itemid` int
)
begin
update wms_outbound.tbl_actual_pick a
left join wms_inbound.tbl_receivingitems b on a.receivingitemid = b.receivingitemid 
set b.ispick = 1
where a.receivingitemid = __receivingitemid;

delete
from wms_outbound.tbl_actual_pick
where pck = __pck 
and receivingitemid = __receivingitemid 
and itemid = __itemid; 
end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_fpo
DELIMITER //
CREATE PROCEDURE `sp_fpo`(
	in `__palletid` int,
	in `__itemid` int,
	in `__pck` varchar(200),
	in `__ord` varchar(200)
)
begin declare __picklistid int; declare __allocid int; declare __counter int; set __picklistid =(
select id
from wms_outbound.tbl_picking
where `ord` = __ord and `pck` = __pck);
delete
from wms_outbound.tbl_allocations
where pickingid = __picklistid and palletid = __palletid and itemid = __itemid;
insert into wms_outbound.tbl_allocations(`pickingid`, `palletid`, `expirydate`, `weight`, `itemid`, `qty`,`status`)
 (
select __picklistid, a.palletid, a.expirydate, a.weight, a.itemid, 0, b.itemstatus
from wms_inbound.tbl_receivingitems a
left join wms_cloud.tbl_itemstatus b on a.itemstatusid = b.itemstatusid
where a.palletid = __palletid and a.ispick = 0 and a.isout = 0 and a.itemid = __itemid
limit 1
); set __allocid =(
select id
from wms_outbound.tbl_allocations a
where a.palletid = __palletid and a.itemid = __itemid and a.pickingid = __picklistid);
delete
from wms_outbound.tbl_allocation_details
where picklistid = __picklistid and allocid = __allocid;
update wms_outbound.tbl_allocation_details a
left join wms_inbound.tbl_receivingitems b on a.receivingid = b.receivingitemid set b.ispick = 0
where a.picklistid = __picklistid and allocid = __allocid;
create temporary table tt_allocated_pallet
 (
select a.receivingitemid
from wms_inbound.tbl_receivingitems a
left join wms_cloud.tbl_itemstatus b on a.itemstatusid = b.itemstatusid
where a.itemid = __itemid and a.palletid = __palletid and a.ispick = 0 and a.isout = 0
);
insert into wms_outbound.tbl_allocation_details(picklistid,allocid,receivingid, status)
 (
select __picklistid,__allocid,receivingitemid,'ACTIVE'
from tt_allocated_pallet
);
update tt_allocated_pallet a
left join wms_inbound.tbl_receivingitems b on a.receivingitemid = b.receivingitemid set b.ispick = 1;
drop table tt_allocated_pallet; set __counter=(
select count(*)
from wms_outbound.tbl_allocations a
left join wms_outbound.tbl_allocation_details b on a.id = b.allocid
where a.itemid = __itemid and a.palletid = __palletid and a.pickingid = __picklistid);
update wms_outbound.tbl_allocations set qty = __counter
where pickingid = __picklistid and palletid = __palletid and itemid = __itemid; end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_fpo_closed
DELIMITER //
CREATE PROCEDURE `sp_fpo_closed`(
	in `__palletid` int,
	in `__itemid` int,
	in `__pck` varchar(200),
	in `__ord` varchar(200)
)
begin 

			declare __picklistid int; 

			declare __allocid int; 

			declare __counter int; 

			set __picklistid =(
			select id
			from wms_outbound.tbl_picking
			where `ord` = __ord and `pck` = __pck);

			set __allocid =(
			select id
			from wms_outbound.tbl_allocations a
			where a.palletid = __palletid 
			and a.itemid = __itemid 
			and a.pickingid = __picklistid);


			update wms_outbound.tbl_allocation_details a
			left join wms_inbound.tbl_receivingitems b on a.receivingid = b.receivingitemid set b.ispick = 0
			where a.picklistid = __picklistid 
			and allocid = __allocid;


			delete
			from wms_outbound.tbl_allocation_details
			where picklistid = __picklistid 
			and allocid = __allocid;


			delete
			from wms_outbound.tbl_allocations
			where pickingid = __picklistid 
			and palletid = __palletid 
			and itemid = __itemid; 

end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_fpo_open
DELIMITER //
CREATE PROCEDURE `sp_fpo_open`(
	in `__palletid` int,
	in `__itemid` int,
	in `__pck` varchar(200),
	in `__ord` varchar(200),
    in `__userid` int
)
begin 
	declare __picklistid int; 

	declare __allocid int; 

	declare __counter int; 

	set __picklistid =(select id
	from wms_outbound.tbl_picking
	where `ord` = __ord and `pck` = __pck); 

	set __allocid =(
	select id
	from wms_outbound.tbl_allocations a
	where a.palletid = __palletid and a.itemid = __itemid and a.pickingid = __picklistid);

	update wms_outbound.tbl_allocation_details a
	left join wms_inbound.tbl_receivingitems b on a.receivingid = b.receivingitemid 
    set b.ispick = 0
	where a.picklistid = __picklistid 
    and allocid = __allocid;

	delete
	from wms_outbound.tbl_allocation_details
	where picklistid = __picklistid 
    and allocid = __allocid;

	delete
	from wms_outbound.tbl_allocations
	where pickingid = __picklistid 
    and palletid = __palletid 
    and itemid = __itemid;

	insert into wms_outbound.tbl_allocations(`pickingid`, `palletid`, `expirydate`, `weight`, `itemid`, `qty`,`status`)
	(
	select __picklistid, a.palletid, a.expirydate, a.weight, a.itemid, 0, b.itemstatus
	from wms_inbound.tbl_receivingitems a
	left join wms_cloud.tbl_itemstatus b on a.itemstatusid = b.itemstatusid
	where a.palletid = __palletid 
    and a.ispick = 0 
    and a.isout = 0 
    and a.itemid = __itemid
    and ((a.forputaway >= 6) or (a.forputaway = 0))
	limit 1
	);

	set __allocid =(
	select id
	from wms_outbound.tbl_allocations a
	where a.palletid = __palletid and a.itemid = __itemid and a.pickingid = __picklistid);

	create temporary table tt_allocated_pallet
	(
	select a.receivingitemid
	from wms_inbound.tbl_receivingitems a
	left join wms_cloud.tbl_itemstatus b on a.itemstatusid = b.itemstatusid
	where a.itemid = __itemid 
    and a.palletid = __palletid 
    and a.ispick = 0 
    and a.isout = 0
    and ((a.forputaway >= 6) or (a.forputaway = 0))
	);

	update tt_allocated_pallet a
	left join wms_inbound.tbl_receivingitems b on a.receivingitemid = b.receivingitemid 
    set b.ispick = 1;

	insert into wms_outbound.tbl_allocation_details(picklistid,allocid,receivingid, status)
	(
	select __picklistid,__allocid,receivingitemid,'FPO'
	from tt_allocated_pallet
	);

	drop table tt_allocated_pallet; 

	set __counter=(
	select count(*)
	from wms_outbound.tbl_allocations a
	left join wms_outbound.tbl_allocation_details b on a.id = b.allocid
	where a.itemid = __itemid and a.palletid = __palletid and a.pickingid = __picklistid);

	update wms_outbound.tbl_allocations set qty = __counter
	where pickingid = __picklistid and palletid = __palletid and itemid = __itemid;
    
    call wms_reports.sp_picking_logs(__pck,'FPO PICK',__palletid,__counter,__userid);

 end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_fw_add
DELIMITER //
CREATE PROCEDURE `sp_fw_add`(
	in `__pck` varchar(200),
	in `__receivingitemid` int,
	in `__itemid` int,
	in `__quantity` double,
	in `__weight` double
)
begin
update wms_inbound.tbl_receivingitems a set a.ispick = 1
where a.ispick = 0 and a.receivingitemid = __receivingitemid;
insert into wms_outbound.tbl_pickingitems (`pck`, `receivingitemid`, `itemid`, `quantity`, `weight`) values (__pck, __receivingitemid, __itemid, __quantity, __weight); end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_generatedr
DELIMITER //
CREATE PROCEDURE `sp_generatedr`(
	in `__user` varchar(200)
)
begin declare __return varchar(200); set __return =(
select tempdr+1
from wms_outbound.tbl_temp
limit 1);
update wms_outbound.tbl_temp set tempdr=tempdr+1; set __return =(concat("DR", lpad(__return,9,0)));
insert into wms_outbound.tbl_dr (`dr`, `statusid`, `createdby`,`created_at`) values (__return, 0, __user,now());
select __return; end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_generateobd
DELIMITER //
CREATE PROCEDURE `sp_generateobd`(
	in `__user` varchar(200)
)
begin declare __return varchar(200); set __return =(
select tempobd+1
from wms_outbound.tbl_temp
limit 1);
update wms_outbound.tbl_temp set tempobd=tempobd+1; set __return =(concat("OBD", lpad(__return,9,0)));
insert into wms_outbound.tbl_issuances (`obd`, `statusid`, `createdby`,`created_at`) values (__return, 0, __user,now());
select __return; end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_generateord
DELIMITER //
CREATE PROCEDURE `sp_generateord`(
	in `__user` varchar(200)
)
begin declare __return varchar(200); set __return =(
select tempord+1
from wms_outbound.tbl_temp
limit 1);
update wms_outbound.tbl_temp set tempord=tempord+1; set __return =(concat("ORD", lpad(__return,9,0)));
insert into wms_outbound.tbl_ordering (`ord`, `statusid`, `createdby`,`orderdate`) values (__return, 0, __user, now());
select __return; end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_generatepck
DELIMITER //
CREATE PROCEDURE `sp_generatepck`(
	in `__user` varchar(200)
)
begin declare __return varchar(200); set __return =(
select temppicklistid+1
from wms_outbound.tbl_temp
limit 1);
update wms_outbound.tbl_temp set temppicklistid =temppicklistid+1; set __return =(concat("PCK", lpad(__return,9,0)));
insert into wms_outbound.tbl_picking(`pck`, `statusid`, `createdby`,`created_at`) values (__return,0,__user,now());
select __return; end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_generatepicklistid
DELIMITER //
CREATE PROCEDURE `sp_generatepicklistid`()
begin declare __return int; set __return =(
select temppicklistid
from wms_outbound.tbl_temp
limit 1);
update wms_outbound.tbl_temp set temppicklistid =temppicklistid+1;
select __return; end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_getorderingitem
DELIMITER //
CREATE PROCEDURE `sp_getorderingitem`(
	in `__ord` varchar(200)
)
begin
select
oi.id,
itemcode,
client_sku,
itemdesc,
uom_abv, sum(oi.quantity),
oi.itemid,
oi.status,
(sum(f.quantity)),
(sum(f.weight)),
uom.uomid,
(sum(g.weight) / sum(g.quantity)) as ave
from wms_outbound.tbl_orderingitems oi
left join wms_cloud.tbl_items item on oi.itemid = item.itemid
left join wms_cloud.tbl_weightuom uom on item.uomid = uom.uomid
left join wms_outbound.tbl_picking pck on oi.ord = pck.ord
left join wms_outbound.tbl_pickingitems f on pck.pck = f.pck
left join wms_inbound.tbl_receivingitems g on g.itemid = item.itemid and g.quantity > 0 and g.checked = 'true'
where oi.ord = __ord
group by oi.itemid, oi.id, f.itemid; end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_get_ordering
DELIMITER //
CREATE PROCEDURE `sp_get_ordering`(
	in `__user` varchar(200)
)
begin 
		declare __ord varchar(200);
        
         set __ord = (select tempord from wms_outbound.tbl_temp limit 1);
					
         update wms_outbound.tbl_temp set tempord=tempord+1;
                    
         set __ord = concat('ORD',lpad(__ord,9,'0'));
         
         insert into wms_outbound.tbl_ordering(ord,statusid,createdby, created_at) values(__ord,0,__user,now());
        
        select __ord;
end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_get_orderingitem
DELIMITER //
CREATE PROCEDURE `sp_get_orderingitem`(
	in `__ord` varchar(200)
)
begin
select
oi.id,
itemcode,
coalesce(client_sku,itemcode),
itemdesc,
uom_abv, sum(oi.quantity),
oi.itemid,
oi.status,
(sum(f.quantity)),
(sum(f.weight)),
uom.uomid,
(sum(g.weight) / sum(g.quantity)) as ave
from wms_outbound.tbl_orderingitems oi
left join wms_cloud.tbl_items item on oi.itemid = item.itemid
left join wms_cloud.tbl_weightuom uom on item.uomid = uom.uomid
left join wms_outbound.tbl_picking pck on oi.ord = pck.ord
left join wms_outbound.tbl_pickingitems f on pck.pck = f.pck
left join wms_inbound.tbl_receivingitems g on g.itemid = item.itemid 
and g.quantity > 0 
and g.checked = 'true'
where oi.ord = __ord
group by oi.itemid, oi.id, f.itemid; end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_get_ordering_items
DELIMITER //
CREATE PROCEDURE `sp_get_ordering_items`(
	in `__ord` varchar(200)
)
begin
select 
a.id, 
b.itemcode, 
coalesce(b.client_sku,b.itemcode),
b.itemdesc, 
c.uom, 
a.quantity,
b.itemid,
a.status,
c.uomid,
 (a.quantity * coalesce(a.weight,b.weight))
from wms_outbound.tbl_orderingitems a
left join wms_cloud.tbl_items b on a.itemid = b.itemid
left join wms_cloud.tbl_weightuom c on b.uomid = c.uomid
where ord = __ord; end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_get_orders_for_issuance
DELIMITER //
CREATE PROCEDURE `sp_get_orders_for_issuance`()
begin
select id, obd, issuancedate, wms_cloud.tbl_customers.companyname
from wms_outbound.tbl_issuances
inner join wms_cloud.tbl_customers on wms_outbound.tbl_issuances.customerid = wms_cloud.tbl_customers.customerid
where statusid = 3; end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_get_orders_for_issuance_delivered
DELIMITER //
CREATE PROCEDURE `sp_get_orders_for_issuance_delivered`(
	in `__id` int
)
begin
update wms_outbound.tbl_issuances set statusid = 6
where id = __id;
select id, obd
from wms_outbound.tbl_issuances
where statusid = 3; end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_issuance_add_pallet
DELIMITER //
CREATE PROCEDURE `sp_issuance_add_pallet`(
	in `__obd` varchar(200),
	in `__pck` varchar(200),
	in `__itemid` int,
	in `__palletid` int
)
begin
declare __items int;

create temporary table tt_for_issuance
(
select b.receivingitemid
from wms_outbound.tbl_actual_pick a
left join wms_inbound.tbl_receivingitems b on a.receivingitemid = b.receivingitemid
where pck = __pck 
and a.itemid = __itemid 
and b.palletid = __palletid
and a.status = 'PICKED'
);

set __items = (select count(*) from tt_for_issuance);

if __items > 0 then

				update wms_outbound.tbl_actual_pick a
				left join wms_inbound.tbl_receivingitems b on a.receivingitemid = b.receivingitemid 
                set a.status = 'ISSUANCED'
				where a.pck = __pck 
                and a.itemid = __itemid 
                and b.palletid = __palletid;
                
				update tt_for_issuance a
				left join wms_inbound.tbl_receivingitems b on a.receivingitemid = b.receivingitemid set b.ispick = 3;
                
				insert into wms_outbound.tbl_issuancelist(obd,pck,palletid,itemid,receivingitemid)
				(
				select 
                __obd,
                __pck,
                __palletid,
                __itemid,receivingitemid
				from tt_for_issuance
				);
                
				delete
				from wms_outbound.tbl_palletout
				where obd = __obd;
                
				insert into wms_outbound.tbl_palletout(obd, palletid, remaining_qty, willdeduct, afterissuance)
				(
				select 
                __obd as obd,
				a.palletid as palletid,
				count(distinct(b.receivingitemid))  as remaining_qty,
				count(distinct(a.id)) as willdeduct,
                (count(distinct(b.receivingitemid)) - count(distinct(a.id))) as afterissuance
				from wms_outbound.tbl_issuancelist a
				join wms_inbound.tbl_receivingitems b 
                on a.palletid = b.palletid 
                and b.isout = 0 
                and ((b.checked = 'True') || (b.checked = 'TRUE'))
                and ((b.forputaway = 0) or (b.forputaway > 1)) 
                and b.quantity > 0  
				where a.obd = __obd
				group by a.palletid
				);

else 
	select 'ITEMS ALREADY PICKED FOR ISSUANCED';
drop temporary table tt_for_issuance;
 end if;
end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_issuance_cancelpick
DELIMITER //
CREATE PROCEDURE `sp_issuance_cancelpick`(
															in `__pck` varchar(200)
															)
begin declare __issuanced int default 0; 

set __issuanced = (
select count(*)
from wms_outbound.tbl_picking a
left join wms_outbound.tbl_actual_pick b on b.pck = a.pck
where a.pck = __pck 
and b.status = 'issuanced');

if __issuanced > 0 then
select 'Unable to Return, Picklist has already been deducted'; 

else
update wms_outbound.tbl_picking set statusid = 2
where pck = __pck;
select 'DONE'; 
end if; 
end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_issuance_getpalletchanges
DELIMITER //
CREATE PROCEDURE `sp_issuance_getpalletchanges`(
	in `__obd` varchar(200)
)
begin

	delete
	from wms_outbound.tbl_palletout
	where obd = __obd;
                
	insert into wms_outbound.tbl_palletout(obd, palletid, remaining_qty, willdeduct, afterissuance)
	(
	select 
	__obd as obd,
	a.palletid as palletid,
	count(distinct(b.receivingitemid))  as remaining_qty,
	count(distinct(a.id)) as willdeduct,
	(count(distinct(b.receivingitemid)) - count(distinct(a.id))) as afterissuance
	from wms_outbound.tbl_issuancelist a
	join wms_inbound.tbl_receivingitems b 
	on a.palletid = b.palletid 
	and b.isout = 0 
	and b.checked = 'True' 
	and ((b.forputaway = 0) or (b.forputaway > 1)) 
    and b.quantity > 0  
	where a.obd = __obd
	group by a.palletid
	);
    
	select 
    *,
    concat(b.systempid,' - ',b.manualpid)
	from wms_outbound.tbl_palletout a 
	left join wms_inbound.tbl_pallets b on a.palletid = b.palletid
	where a.palletid is not null 
	and obd = __obd
	group by a.palletid; 

end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_issuance_get_pick_items
DELIMITER //
CREATE PROCEDURE `sp_issuance_get_pick_items`(
																in `__pck` varchar(200)
																)
begin
select 
concat(f.systempid,' - ',f.manualpid), 
coalesce(e.client_sku,itemcode),
e.itemdesc,
g.uom_abv, 
count(a.id), 
sum(d.weight),
f.palletid,
d.itemid
from wms_outbound.tbl_actual_pick a
left join wms_outbound.tbl_picking b on a.pck = b.pck
left join wms_inbound.tbl_receivingitems d on a.receivingitemid = d.receivingitemid
left join wms_cloud.tbl_items e on d.itemid = e.itemid
left join wms_inbound.tbl_pallets f on d.palletid = f.palletid
left join wms_cloud.tbl_weightuom g on e.uomid = g.uomid
where a.pck = __pck 
and a.status = 'PICKED'
group by f.palletid,e.itemid; 
end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_issuance_openobd
DELIMITER //
CREATE PROCEDURE `sp_issuance_openobd`(
    in `__obd` varchar(200),
    in `__user` varchar(200),
    in `__role` int
)
begin
select 
                        a.customerid, 
                        b.companyname, 
                        a.obd, 
                        a.supplier, 
                        a.issuancedate, 
                        a.trucktypeid, 
                        c.trucktype, 
                        a.plate, 
                        a.container, 
                        a.otherref, 
                        a.customerreference, 
                        a.remarks, 
                        a.timestart, 
                        a.timefinish, 
                        a.seal, 
                        a.loadingbay, 
                        a.gatepass, 
                        a.requestedby, 
                        a.checker, 
                        a.requestorpd
from wms_outbound.tbl_issuances a
left join wms_cloud.tbl_customers b on a.customerid = b.customerid
left join wms_cloud.tbl_trucktypes c on a.trucktypeid = c.trucktypeid
where a.obd = __obd;
	
    if __role != 2 then
		update wms_outbound.tbl_issuances set statusid = 2, lastupdatedby = __user where obd = __obd;
	else
		update wms_outbound.tbl_issuances set statusid = 2 where obd = __obd;
	end if;
end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_issuance_open_issuance_items
DELIMITER //
CREATE PROCEDURE `sp_issuance_open_issuance_items`(
	in `__obd` varchar(200)
)
begin
select 
concat(e.systempid,' - ',e.manualpid), 
coalesce(c.client_sku,c.itemcode),
c.itemdesc,
d.uom_abv, 
count(a.receivingitemid), 
sum(b.weight),
a.itemid,
e.palletid,
 a.id
from wms_outbound.tbl_issuancelist a
left join wms_inbound.tbl_receivingitems b on a.receivingitemid = b.receivingitemid
left join wms_cloud.tbl_items c on b.itemid = c.itemid
left join wms_cloud.tbl_weightuom d on c.uomid = d.uomid
left join wms_inbound.tbl_pallets e on b.palletid = e.palletid
where a.obd = __obd
group by a.palletid,a.itemid; end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_issuance_palletid
DELIMITER //
CREATE PROCEDURE `sp_issuance_palletid`(
	in `__obd` varchar(200)
)
begin

create temporary table TT_pallet_holder
(
select 
palletid
from wms_outbound.tbl_issuancelist
where obd = __obd
group by palletid
);

select 
sum(B.quantity), 
B.palletid, 
loc.locationid
from TT_pallet_holder A 
left join wms_inbound.tbl_receivingitems B on A.palletid = B.palletid
left join wms_inbound.tbl_pallets C on B.palletid = C.palletid
left join wms_inbound.tbl_locations D on C.locationid = D.locationid
group by palletid;

drop temporary table TT_pallet_holder;

end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_issuance_picklist_show
DELIMITER //
CREATE PROCEDURE `sp_issuance_picklist_show`(
	in `__customerid` int
)
begin
select c.pck
from wms_outbound.tbl_ordering a
left join wms_outbound.tbl_orderingitems b on a.ord = b.ord
left join wms_outbound.tbl_picking c on a.ord = c.ord
left join wms_outbound.tbl_actual_pick d on c.pck = d.pck and b.itemid = d.itemid
where ((c.statusid = 3) or (c.statusid = 5)) and a.customerid = __customerid AND d.status != 'ISSUANCED'
group by c.pck
having count(d.id) > 0
order by c.pck asc; end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_issuance_recalculatepalletout
DELIMITER //
CREATE PROCEDURE `sp_issuance_recalculatepalletout`(
											in __obd varchar(250)
											)
BEGIN

				delete
				from wms_outbound.tbl_palletout
				where obd = __obd;
                
				insert into wms_outbound.tbl_palletout(obd, palletid, remaining_qty, willdeduct, afterissuance)
				(
				select 
                __obd as obd,
				a.palletid as palletid,
				count(distinct(b.receivingitemid))  as remaining_qty,
				count(distinct(a.id)) as willdeduct,
                (count(distinct(b.receivingitemid)) - count(distinct(a.id))) as afterissuance
				from wms_outbound.tbl_issuancelist a
				join wms_inbound.tbl_receivingitems b 
                on a.palletid = b.palletid 
                and b.isout = 0 
                and ((b.forputaway = 0) or (b.forputaway >= 6)) 
                and b.quantity > 0  
				where a.obd = __obd
				group by a.palletid
				);
END//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_issuance_removeissuanceitem
DELIMITER //
CREATE PROCEDURE `sp_issuance_removeissuanceitem`(
	in `__issuanceid` int
)
begin 
declare __obd varchar(200); 

declare __pck varchar(200); 

declare __itemid int;
 
declare __palletid int; 

set __pck = (
select pck
from wms_outbound.tbl_issuancelist
where id = __issuanceid); set __obd = (
select obd
from wms_outbound.tbl_issuancelist
where id = __issuanceid); 

set __itemid = (
				select itemid
				from wms_outbound.tbl_issuancelist
				where id = __issuanceid); 
                
set __palletid = (
				select palletid
				from wms_outbound.tbl_issuancelist
				where id = __issuanceid);
                
				update wms_outbound.tbl_issuancelist a
				left join wms_inbound.tbl_receivingitems b on a.receivingitemid = b.receivingitemid set ispick = 2
				where a.palletid = __palletid and a.obd = __obd and a.itemid = __itemid;


				update wms_outbound.tbl_actual_pick a
				left join wms_inbound.tbl_receivingitems b on a.receivingitemid = b.receivingitemid set a.status = 'PICKED'
				where a.pck = __pck and a.itemid = __itemid and b.palletid = __palletid;
				delete
				from wms_outbound.tbl_issuancelist
				where obd = __obd and itemid = __itemid and palletid = __palletid and pck = __pck;

				delete
				from wms_outbound.tbl_palletout
				where obd = __obd;

				insert into wms_outbound.tbl_palletout(obd, palletid, remaining_qty, willdeduct, afterissuance)
				(
				select 
				 __obd as obd,
				a.palletid as palletid,
				(case when a.isout=0 
                and a.checked = 'True' 
                and ((a.forputaway = 0) or (a.forputaway >1))  
                and b.palletid = a.palletid 
                and a.quantity > 0
                then count(distinct(a.receivingitemid)) 
                else count(distinct(a.receivingitemid)) end) as remaining_qty, 
                count(distinct(b.id)) as willdeduct,
                
				((case when a.isout=0 
                and a.checked = 'True' 
                and ((a.forputaway = 0) or (a.forputaway >1)) 
                and b.palletid = a.palletid 
                and a.quantity > 0
                then count(distinct(a.receivingitemid)) 
                else count(distinct(a.receivingitemid)) end) - count(distinct(b.id))) as afterissuance
				from wms_inbound.tbl_receivingitems a
				join wms_outbound.tbl_issuancelist b on a.palletid = b.palletid
				where b.obd = __obd
				group by a.palletid
				);
                
                end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_issuance_saveissuance
DELIMITER //
CREATE PROCEDURE `sp_issuance_saveissuance`(
	in `__obd` varchar(200),
	in `__statusid` int,
	in `__customerid` int,
	in `__supplier` varchar(200),
	in `__issuancedate` varchar(200),
	in `__trucktypeid` int,
	in `__plate` varchar(200),
	in `__container` varchar(200),
	in `__otherref` varchar(200),
	in `__customerreference` varchar(200),
	in `__remarks` varchar(200),
	in `__timestart` varchar(200),
	in `__timefinish` varchar(200),
	in `__seal` varchar(200),
	in `__loadingbay` varchar(200),
	in `__gatepass` varchar(200),
	in `__requestedby` varchar(200),
	in `__checker` varchar(200),
	in `__requestorpd` varchar(200),
	in `__lastupdatedby` varchar(200)
)
begin
update wms_outbound.tbl_issuances set statusid = __statusid, 
 customerid = __customerid,
 supplier = __supplier, 
 issuancedate = __issuancedate, 
 trucktypeid = __trucktypeid, 
 plate = __plate, 
 container = __container, 
 otherref = __otherref, 
 customerreference = __customerreference, 
 remarks = __remarks, 
 timestart = __timestart, 
 timefinish = __timefinish, 
 seal = __seal, 
 loadingbay = __loadingbay, 
 gatepass = __gatepass, 
 requestedby = __requestedby, 
 checker = __checker, 
 requestorpd = __requestorpd, 
 lastupdatedby = __lastupdatedby
where obd = __obd; end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_issuance_show_specific_item
DELIMITER //
CREATE PROCEDURE `sp_issuance_show_specific_item`(
	in `__issuanceid` int
)
begin declare __obd varchar(200); 

declare __pck varchar(200); 

declare __itemid int; 

declare __palletid int; 

set __obd = (
select obd
from wms_outbound.tbl_issuancelist
where id = __issuanceid); 

set __pck = (
select pck
from wms_outbound.tbl_issuancelist
where id = __issuanceid); 

set __itemid = (
select itemid
from wms_outbound.tbl_issuancelist
where id = __issuanceid); 

set __palletid = (
select palletid
from wms_outbound.tbl_issuancelist
where id = __issuanceid);


create temporary table tt_issuance_ids
(
select receivingitemid as ids
from wms_outbound.tbl_issuancelist
where obd = __obd 
and pck = __pck 
and itemid = __itemid 
and palletid =__palletid
);

select 
concat(d.systempid,' - ',d.manualpid) as pallet,
concat(e.colname,'-', left(e.lcode,1)) as location,
coalesce(b.client_sku,b.itemcode),
b.itemdesc,
1,
c.uom_abv,
a.weight,
f.itemstatus,
case when a.expirydate is null then "NO EXPIRY" else a.expirydate end
from wms_inbound.tbl_receivingitems a
left join wms_cloud.tbl_items b on a.itemid = b.itemid
left join wms_cloud.tbl_weightuom c on b.uomid = c.uomid
left join wms_inbound.tbl_pallets d on a.palletid = d.palletid
left join wms_inbound.tbl_locations e on e.palletid = d.palletid
left join wms_cloud.tbl_itemstatus f on a.itemstatusid = f.itemstatusid
where a.receivingitemid in (
select ids
from tt_issuance_ids);
drop temporary table tt_issuance_ids; end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_issuance_submitissuance
DELIMITER //
CREATE PROCEDURE `sp_issuance_submitissuance`(
	in `__obd` varchar(200),
	in `__customerid` int,
	in `__supplier` varchar(200),
	in `__issuancedate` varchar(200),
	in `__trucktypeid` int,
	in `__plate` varchar(200),
	in `__container` varchar(200),
	in `__otherreference` varchar(200),
	in `__jocaw` varchar(200),
	in `__remarks` varchar(200),
	in `__timestart` varchar(200),
	in `__timefinish` varchar(200),
	in `__seal` varchar(200),
	in `__loadingbay` varchar(200),
	in `__gatepass` varchar(200),
	in `__requestedby` varchar(200),
	in `__checker` varchar(200),
	in `__requestorpd` varchar(200),
	in `__user` varchar(200)
)
begin
declare __addedpck int;
set __addedpck = (select count(*) from wms_outbound.tbl_issuancelist where obd = __obd);
if __addedpck > 0 then

update wms_outbound.tbl_issuances set statusid = 3, 
 customerid = __customerid, 
 supplier = __supplier, 
 issuancedate = __issuancedate, 
 trucktypeid = __trucktypeid, 
 plate = __plate, 
 container = __container, 
 otherref = __otherreference, 
 customerreference = __jocaw, 
 remarks = __remarks, 
 timestart = __timestart, 
 timefinish = __timefinish, 
 seal = __seal, 
 loadingbay = __loadingbay, 
 gatepass = __gatepass, 
 requestedby = __requestedby, 
 checker = __checker, 
 requestorpd = __requestorpd, 
 lastupdatedby = __user
where obd = __obd;

create temporary table tt_rxv
 (
select receivingitemid,palletid
from wms_outbound.tbl_issuancelist
where obd = __obd
);

update tt_rxv a
left join wms_inbound.tbl_receivingitems b on a.receivingitemid = b.receivingitemid set b.quantity = 0,
			b.weight = 0,
			b.ispick = 3,
			b.isout =1;
            
insert into wms_reports.tbl_issuance_receipt(obd,rcv_id,datetimestamp,ir_status)
 (
select __obd,receivingitemid, now(),'ISSUED'
from tt_rxv
);

create temporary table tt_pck_closer
 (
select 
a.pck, 
sum(case when b.status = 'PICKED' then 1 else 0 end) as picked
from wms_outbound.tbl_picking a
left join wms_outbound.tbl_actual_pick b on a.pck = b.pck
where a.statusid = 3
group by a.pck
having picked = 0
);

update tt_pck_closer a
left join wms_outbound.tbl_picking b on a.pck = b.pck set b.statusid = 5;

update wms_inbound.tbl_locations 
set locstatus = 1, 
loadstatus = 1, 
reservedclient = null, 
palletid = null
where palletid in (
select palletid
from wms_outbound.tbl_palletout
where obd = __obd and afterissuance = 0
group by palletid);

drop temporary table tt_pck_closer;
drop temporary table tt_rxv;

UPDATE wms_outbound.tbl_issuances 
SET IssuanceDate=NOW() 
WHERE OBD = __obd;

select __addedpck;
else
select __addedpck;
end if;
end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_issuance_tracker
DELIMITER //
CREATE PROCEDURE `sp_issuance_tracker`(
	in `__rcv_id` int,
	in `__obd` varchar(45),
	in `__pck` varchar(45)
)
begin
update wms_inbound.tbl_receivingitems set quantity = 0, weight = 0, ispick = 2, isout = 1
where receivingitemid = __rcv_id;
insert into wms_reports.tbl_issuance_receipt(pck, obd, rcv_id, datetimestamp, ir_status) values(__pck, __obd, __rcv_id, now(), 'ISSUED'); end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_manual_actual_cluster
DELIMITER //
CREATE PROCEDURE `sp_manual_actual_cluster`(
	in `__itemid` varchar(200)
)
begin
select 
concat(c.colname, '-',right(c.lcode, 1)) as locations, 
concat(b.systempid, '-', b.manualpid) as pid, 
count(distinct(a.receivingitemid)),
b.palletid,
b.manualpid,
a.itemid, 
round(sum(a.weight), 2)
from wms_inbound.tbl_receivingitems a
left join wms_inbound.tbl_pallets b on b.palletid = a.palletid
left join wms_inbound.tbl_locations c on b.palletid = c.palletid
where a.itemid = __itemid 
and a.ispick = 0 
and a.isout = 0 
and a.checked = 'True' 
and ((a.forputaway > 1) or (a.forputaway = 0))
group by locations
order by a.expirydate asc; end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_manual_cluster
DELIMITER //
CREATE PROCEDURE `sp_manual_cluster`(
	in `__itemid` int
)
begin
select concat(c.colname, '-',right(c.lcode, 1)) as locations,
concat(b.systempid, '-', b.manualpid) as pid,
count(distinct(a.receivingitemid)),
b.palletid,
b.manualpid,
a.itemid, 
round(sum(a.weight), 2)
from wms_inbound.tbl_receivingitems a
left join wms_inbound.tbl_pallets b on b.palletid = a.palletid
left join wms_inbound.tbl_locations c on b.palletid = c.palletid
where a.itemid = __itemid 
and a.ispick = 0 
and a.isout = 0 
and a.checked = 'True' 
and ((a.forputaway >= 6) or (a.forputaway = 0))
and a.quantity = 1
group by a.palletid
order by a.expirydate asc; end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_manual_pick
DELIMITER //
CREATE PROCEDURE `sp_manual_pick`(
	in `__item_id` int,
	in `__uom_id` int
)
begin
		
 if (__uom_id <> 12) then
select 
concat(colname, '-',right(lcode, 1)), 
concat(systempid, '-', manualpid),
e.container,
itemcode,
client_sku,
itemdesc,
uom_abv, 
sum(a.quantity), 
truncate(sum(a.weight),2),
coalesce(date(expirydate),'NO EXPIRY'),
a.itemid,
a.palletid,
a.itemstatusid,
c.itemstatus
from wms_inbound.tbl_receivingitems a
left join wms_cloud.tbl_items b on a.itemid = b.itemid and a.ispick = 0
left join wms_cloud.tbl_itemstatus c on a.itemstatusid = c.itemstatusid
left join wms_cloud.tbl_weightuom d on b.uomid = d.uomid
left join wms_inbound.tbl_receiving e on a.ibn = e.ibn
left join wms_inbound.tbl_pallets f on a.palletid = f.palletid
left join wms_inbound.tbl_locations g on f.locationid = g.locationid
where a.itemid = __item_id 
and checked = 'True' 
and a.quantity > 0 
and a.receivingitemid 
and a.ispick = 0
and ((a.forputaway = 6) or (a.forputaway = 0))
group by a.palletid, a.itemid, a.expirydate, a.itemstatusid
order by expirydate asc, 
columncode desc, 
a.palletid; 

else

select 
concat(colname, '-',right(lcode, 1)), 
concat(systempid, '-', manualpid),
e.container,
itemcode,
client_sku,
itemdesc,
uom_abv,
sum(a.quantity), 
sum(a.weight),
coalesce(date(expirydate),'NO EXPIRY'),
a.itemid,
a.palletid,
a.receivingitemid,
a.itemstatusid,
c.itemstatus
from wms_inbound.tbl_receivingitems a
left join wms_cloud.tbl_items b on a.itemid = b.itemid and a.ispick=0
left join wms_cloud.tbl_itemstatus c on a.itemstatusid = c.itemstatusid
left join wms_cloud.tbl_weightuom d on b.uomid = d.uomid
left join wms_inbound.tbl_receiving e on a.ibn = e.ibn
left join wms_inbound.tbl_pallets f on a.palletid = f.palletid
left join wms_inbound.tbl_locations g on f.locationid = g.locationid
where a.itemid = __item_id 
and checked = 'True' 
and a.quantity > 0 
and a.receivingitemid 
and a.ispick=0
and ((a.forputaway = 6) or (a.forputaway = 0))
order by expirydate asc, 
columncode desc, 
a.palletid; 
end if; 
end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_openissuanceitems
DELIMITER //
CREATE PROCEDURE `sp_openissuanceitems`(
	in `__obd` varchar(200)
)
begin
select concat(e.systempid,'-',e.manualpid), coalesce(c.client_sku,c.itemcode),
								c.itemdesc,
								d.uom_abv, count(a.receivingitemid), sum(b.weight),
								a.itemid,
								e.palletid,
 a.id
from wms_outbound.tbl_issuancelist a
left join wms_inbound.tbl_receivingitems b on a.receivingitemid = b.receivingitemid
left join wms_cloud.tbl_items c on b.itemid = c.itemid
left join wms_cloud.tbl_weightuom d on c.uomid = d.uomid
left join wms_inbound.tbl_pallets e on b.palletid = e.palletid
where a.obd = __obd
group by a.palletid,a.itemid; end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_ordering_addpartial
DELIMITER //
CREATE PROCEDURE `sp_ordering_addpartial`(
	in `__ord` varchar(200),
	in `__itemid` int,
	in `__quantity` int
)
begin
declare __counter int;
declare __sum int;
declare __existingqty int;
declare __availableqty int;

set __availableqty = (
					  select sum(quantity)
					  from wms_inbound.tbl_receivingitems
					  where itemid = __itemid 
					  and ispick = 0
					  and isout = 0
					  and ((forputaway = 0) 
                      or (forputaway >= 6))
					  );


set __counter = (
				select count(id)
				from wms_outbound.tbl_orderingitems
				where itemid = __itemid 
                and ord = __ord
                );

IF __counter > 0 THEN

SET __existingqty = (
						select sum(quantity)
						from wms_outbound.tbl_orderingitems 
                        where itemid = __itemid 
                        and ord = __ord);
    
SET __sum = __quantity + __existingqty;
    
    IF __sum <= __availableqty THEN
    
		update wms_outbound.tbl_orderingitems 
        set quantity = quantity+__quantity
		where itemid = __itemid 
        and ord = __ord;
        SELECT "SUCCESS";
    ELSE
		SELECT "EXCEEDED";
    END IF;
    
ELSE
	IF __quantity <= __availableqty THEN
		insert into wms_outbound.tbl_orderingitems 
        (ord, itemid, quantity) 
        values (__ord, __itemid, __quantity);
        
		SELECT "SUCCESS";
	ELSE
		SELECT "EXCEEDED";
    END IF;
END IF;
end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_ordering_endorder
DELIMITER //
CREATE PROCEDURE `sp_ordering_endorder`(
										in __ord varchar(250),
                                        in __customerid int,
                                        in __orderdate datetime,
                                        in __pickupdate datetime,
                                        in __custref varchar(250),
                                        in __otherref varchar(250),
                                        in __remarks varchar(250),
                                        in __user varchar(250)
										)
BEGIN
	
			declare __counter int;

			set __counter = (select count(*) 
            FROM wms_outbound.tbl_orderingitems 
            where ord = __ord);

			if __counter > 0 then
            
			UPDATE wms_outbound.tbl_ordering 
            SET StatusID = 3, 
            CustomerID = __customerid,
            OrderDate = __orderdate,
            PickupDate = __pickupdate,
            CustomerReference = __custref,
            OtherReference = __otherref,
            Remarks = __remarks,
            LastUpdatedBy = __user
            WHERE ORD = __ord;
            
            select 1;
            
            else
            
            select 0;
            
			end if;
END//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_ordering_fillorderingitems
DELIMITER //
CREATE PROCEDURE `sp_ordering_fillorderingitems`(
	in `__cusid` int
)
begin
select 
 a.itemid, 
 a.itemcode, 
 coalesce(a.client_sku,a.itemcode),
 a.itemdesc, 
 c.uom_abv, sum(b.quantity), sum(b.weight)
from wms_cloud.tbl_items a
left join wms_inbound.tbl_receivingitems b on a.itemid = b.itemid
left join wms_cloud.tbl_weightuom c on a.uomid = c.uomid
left join wms_inbound.tbl_receiving d on b.ibn = d.ibn
where b.quantity > 0 
and b.ispick = 0 
and b.isout = 0 
and b.checked = 'True' 
and ((b.forputaway = 0) or (b.forputaway >= 6))
and a.itemcustomerid = __cusid
group by a.itemid; 

end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_ordering_get_sku_details
DELIMITER //
CREATE PROCEDURE `sp_ordering_get_sku_details`(
												in __itemid int
												)
BEGIN

            select 
            b.itemid,
            coalesce(b.client_sku,b.itemcode),
            b.itemdesc,
            sum(a.quantity),
            sum(a.weight) 
            from wms_inbound.tbl_receivingitems a
            right join wms_cloud.tbl_items b on a.itemid = b.itemid
            where a.itemid = __itemid
            and a.ispick = 0 
			and a.isout = 0 
			and a.checked = 'True' 
			and ((a.forputaway >= 6) or (a.forputaway = 0))
			and a.quantity = 1
            group by b.itemid;

END//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_ordering_openordmodal
DELIMITER //
CREATE PROCEDURE `sp_ordering_openordmodal`()
BEGIN
SELECT A.ORD, B.CompanyName, A.CreatedBy, A.LastUpdatedBy, A.created_at 
FROM wms_outbound.tbl_ordering A
LEFT JOIN wms_cloud.tbl_customers B ON A.CustomerID = B.CustomerID 
WHERE StatusID = 0 
ORDER BY ORD DESC;
END//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_ordering_openpendingordmodal
DELIMITER //
CREATE PROCEDURE `sp_ordering_openpendingordmodal`()
BEGIN
SELECT A.ORD, B.CompanyName, A.CreatedBy, A.LastUpdatedBy, A.created_at
FROM wms_outbound.tbl_ordering A
LEFT JOIN wms_cloud.tbl_customers B ON A.CustomerID = B.CustomerID 
WHERE A.StatusID = 1 
ORDER BY ORD DESC;
END//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_ordering_openprocessordmodal
DELIMITER //
CREATE PROCEDURE `sp_ordering_openprocessordmodal`()
BEGIN
SELECT A.ORD, B.CompanyName, A.CreatedBy, A.LastUpdatedBy, A.created_at
FROM wms_outbound.tbl_ordering A
LEFT JOIN wms_cloud.tbl_customers B ON A.CustomerID = B.CustomerID 
WHERE A.StatusID = 2
ORDER BY ORD DESC;
END//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_ordering_saveordering
DELIMITER //
CREATE PROCEDURE `sp_ordering_saveordering`(
											in __statusid int,
                                            in __customerid int,
											in __orderdate datetime,
                                            in __pickupdate datetime,
                                            in __custref varchar(2250),
                                            in __otherref varchar(2250),
                                            in __remarks varchar(2250),
                                            in __user varchar(2250),
                                            in __ord varchar(2250)
                                            )
BEGIN
			UPDATE wms_outbound.tbl_ordering SET 
            StatusID = __statusid, 
            CustomerID = __customerid, 
            OrderDate = __orderdate, 
            PickupDate = __pickupdate, 
            CustomerReference = __custref, 
            OtherReference = __otherref, 
            Remarks = __remarks, 
            LastUpdatedBy = __user 
            WHERE ORD = __ord;
END//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_picking_allocate_close
DELIMITER //
CREATE PROCEDURE `sp_picking_allocate_close`(in __allocid int,
											 in __settings varchar(200),
											 in __ord varchar(200),
                                             in __pck varchar(200))
begin
		declare __palletid int;
        
        declare __itemid int;
        
        set __palletid=(select palletid from wms_outbound.tbl_allocations where id = __allocid);
        
        set __itemid=(select itemid from wms_outbound.tbl_allocations where id = __allocid);

		if __settings <> 'peralloc' then
        
        create temporary table tt_get_allocated
        (
        select c.receivingid from wms_outbound.tbl_picking a
        left join wms_outbound.tbl_allocations b on b.pickingid = a.id
        left join wms_outbound.tbl_allocation_details c on b.id = c.allocid
        where a.ord = __ord
        and a.pck = __pck
        and b.palletid = __palletid
        );
        
        update tt_get_allocated a
        left join wms_inbound.tbl_receivingitems b
        on a.receivingid = b.receivingitemid
        set ispick = 1;
        
        
        delete from wms_outbound.tbl_actual_pick 
        where receivingitemid in (select * from tt_get_allocated);
        
        drop temporary table tt_get_allocated;
        
        else 
        
		create temporary table tt_get_allocated
        (
        select c.receivingid from wms_outbound.tbl_picking a
        left join wms_outbound.tbl_allocations b on b.pickingid = a.id
        left join wms_outbound.tbl_allocation_details c on b.id = c.allocid
        where a.ord = __ord
        and a.pck = __pck
        and b.id = __allocid
        );
        
		update tt_get_allocated a
        left join wms_inbound.tbl_receivingitems b
        on a.receivingid = b.receivingitemid
        set ispick = 1;
        
        delete from wms_outbound.tbl_actual_pick 
        where receivingitemid in (select * from tt_get_allocated);
        
        drop temporary table tt_get_allocated;
        end if;

end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_picking_allocate_open
DELIMITER //
CREATE PROCEDURE `sp_picking_allocate_open`(in __allocid int,
											 in __settings varchar(200),
											 in __ord varchar(200),
                                             in __pck varchar(200))
begin
		declare __palletid int;
        
        declare __itemid int;
        
        set __palletid=(select palletid from wms_outbound.tbl_allocations where id = __allocid);
        
        set __itemid=(select itemid from wms_outbound.tbl_allocations where id = __allocid);

		if __settings <> 'peralloc' then
        
        create temporary table tt_get_allocated
        (
        select c.receivingid from wms_outbound.tbl_picking a
        left join wms_outbound.tbl_allocations b on b.pickingid = a.id
        left join wms_outbound.tbl_allocation_details c on b.id = c.allocid and b.pickingid = c.picklistid
        where a.ord = __ord
        and b.itemid = __itemid
        and a.pck = __pck
        and b.palletid = __palletid
        );
        
        delete from tbl_actual_pick 
        where pck = __pck
        and receivingitemid in (select * from tt_get_allocated);
        
        update tt_get_allocated a
        left join wms_inbound.tbl_receivingitems b
        on a.receivingid = b.receivingitemid
        set ispick = 2;
        
        insert into wms_outbound.tbl_actual_pick(pck,itemid,receivingitemid, status)
		(
		select __pck,__itemid, receivingid, 'PICKED'
		from tt_get_allocated
		);
        
        drop temporary table tt_get_allocated;
        
        else 
        
		create temporary table tt_get_allocated
        (
        select c.receivingid from wms_outbound.tbl_picking a
        left join wms_outbound.tbl_allocations b on b.pickingid = a.id
        left join wms_outbound.tbl_allocation_details c on b.id = c.allocid and b.pickingid = c.picklistid
        where a.ord = __ord
        and b.itemid = __itemid
        and a.pck = __pck
        and b.id = __allocid
        );
        
		update tt_get_allocated a
        left join wms_inbound.tbl_receivingitems b
        on a.receivingid = b.receivingitemid
        set ispick = 2;
        
		insert into wms_outbound.tbl_actual_pick(pck,itemid,receivingitemid, status)
		(
		select __pck,__itemid, receivingid, 'PICKED'
		from tt_get_allocated
		);
        
        drop temporary table tt_get_allocated;
        end if;

end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_picking_allocation_category
DELIMITER //
CREATE PROCEDURE `sp_picking_allocation_category`( 
													IN __itemid int,
                                                    IN __category varchar(50)
												  )
BEGIN


            
            if __category = 'container' then
            
			select d.container 
            from wms_inbound.tbl_receivingitems a
            left join wms_inbound.tbl_pallets b on b.palletid = a.palletid
			left join wms_inbound.tbl_locations c on b.palletid = c.palletid
			left join wms_inbound.tbl_receiving d on a.ibn = d.ibn
            where a.itemid = __itemid
            and a.ispick = 0 
			and a.isout = 0 
			and a.checked = 'True' 
			and ((a.forputaway >= 6) or (a.forputaway = 0))
			and a.quantity = 1
            group by d.container;
            
            elseif __category = 'expiry' then
            
			select 
            coalesce(DATE(a.expirydate),'NO EXPIRY') 
            from wms_inbound.tbl_receivingitems a
            where a.itemid = __itemid
            and a.ispick = 0 
			and a.isout = 0 
			and a.checked = 'True' 
			and ((a.forputaway >= 6) or (a.forputaway = 0))
			and a.quantity = 1
            group by coalesce(DATE(a.expirydate),'NO EXPIRY');
            
            elseif __category = 'prod' then
            
            select 
            coalesce(DATE(a.proddate),'NO PRODUCTION DATE') 
            from wms_inbound.tbl_receivingitems a
            where a.itemid = __itemid
            and a.ispick = 0 
			and a.isout = 0 
			and a.checked = 'True' 
			and ((a.forputaway >= 6) or (a.forputaway = 0))
			and a.quantity = 1
            group by coalesce(DATE(a.proddate),'NO PRODUCTION DATE');
            
            elseif __category = 'pallet' then
            
			select 
            b.systempid as pid
            from wms_inbound.tbl_receivingitems a
            left join wms_inbound.tbl_pallets b on b.palletid = a.palletid
			left join wms_inbound.tbl_locations c on b.palletid = c.palletid
			left join wms_inbound.tbl_receiving d on a.ibn = d.ibn
            where a.itemid = __itemid
            and a.ispick = 0 
			and a.isout = 0 
			and a.checked = 'True' 
			and ((a.forputaway >= 6) or (a.forputaway = 0))
			and a.quantity = 1
            group by concat(b.systempid, '-', b.manualpid);

			elseif __category = 'itemstats' then

			select 
            b.ItemStatus
            from wms_inbound.tbl_receivingitems a
            left join wms_cloud.tbl_itemstatus b on a.ItemStatusID = b.ItemStatusID
            where a.itemid = __itemid
            and a.ispick = 0 
			and a.isout = 0 
			and a.checked = 'True' 
			and ((a.forputaway >= 6) or (a.forputaway = 0))
			and a.quantity = 1
            group by b.ItemStatusID;

            end if;

			
END//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_picking_allocation_category_search
DELIMITER //
CREATE PROCEDURE `sp_picking_allocation_category_search`(
														in __itemid int,
                                                        in __category varchar(50),
                                                        in __value varchar(50)
														)
BEGIN
			if __category = 'all' then
            
			call wms_outbound.sp_manual_cluster(__itemid);
                        
			elseif __category = 'batch' then
            
            select 
            concat(c.colname, '-',right(c.lcode, 1)) as locations,
			concat(b.systempid, '-', b.manualpid) as pid,
			count(distinct(a.receivingitemid)),
			b.palletid,
			b.manualpid,
			a.itemid, 
			round(sum(a.weight), 2)
			from wms_inbound.tbl_receivingitems a
			left join wms_inbound.tbl_pallets b on b.palletid = a.palletid
			left join wms_inbound.tbl_locations c on b.palletid = c.palletid
            left join wms_inbound.tbl_receiving d on a.ibn = d.ibn
			where a.itemid = __itemid 
			and a.ispick = 0 
			and a.isout = 0 
			and a.checked = 'True' 
			and ((a.forputaway >= 6) or (a.forputaway = 0))
			and a.quantity = 1
            and coalesce(a.batch, 'No Batch/Lot Code') = __value
			group by a.palletid
			order by a.expirydate asc;

			elseif __category = 'container' then
            select 
            concat(c.colname, '-',right(c.lcode, 1)) as locations,
			concat(b.systempid, '-', b.manualpid) as pid,
			count(distinct(a.receivingitemid)),
			b.palletid,
			b.manualpid,
			a.itemid, 
			round(sum(a.weight), 2)
			from wms_inbound.tbl_receivingitems a
			left join wms_inbound.tbl_pallets b on b.palletid = a.palletid
			left join wms_inbound.tbl_locations c on b.palletid = c.palletid
            left join wms_inbound.tbl_receiving d on a.ibn = d.ibn
			where a.itemid = __itemid 
			and a.ispick = 0 
			and a.isout = 0 
			and a.checked = 'True' 
			and ((a.forputaway >= 6) or (a.forputaway = 0))
			and a.quantity = 1
            and coalesce(d.container, 'No Batch/Lot Code') = __value
			group by a.palletid
			order by a.expirydate asc;


			elseif __category = 'expiry' then
            select 
            concat(c.colname, '-',right(c.lcode, 1)) as locations,
			concat(b.systempid, '-', b.manualpid) as pid,
			count(distinct(a.receivingitemid)),
			b.palletid,
			b.manualpid,
			a.itemid, 
			round(sum(a.weight), 2)
			from wms_inbound.tbl_receivingitems a
			left join wms_inbound.tbl_pallets b on b.palletid = a.palletid
			left join wms_inbound.tbl_locations c on b.palletid = c.palletid
            left join wms_inbound.tbl_receiving d on a.ibn = d.ibn
			where a.itemid = __itemid 
			and a.ispick = 0 
			and a.isout = 0 
			and a.checked = 'True' 
			and ((a.forputaway >= 6) or (a.forputaway = 0))
			and a.quantity = 1
            and coalesce(date(a.expirydate), 'NO EXPIRY') = __value
			group by a.palletid
			order by a.expirydate asc;
            
            elseif __category = 'prod' then
            select 
            concat(c.colname, '-',right(c.lcode, 1)) as locations,
			concat(b.systempid, '-', b.manualpid) as pid,
			count(distinct(a.receivingitemid)),
			b.palletid,
			b.manualpid,
			a.itemid, 
			round(sum(a.weight), 2)
			from wms_inbound.tbl_receivingitems a
			left join wms_inbound.tbl_pallets b on b.palletid = a.palletid
			left join wms_inbound.tbl_locations c on b.palletid = c.palletid
            left join wms_inbound.tbl_receiving d on a.ibn = d.ibn
			where a.itemid = __itemid 
			and a.ispick = 0 
			and a.isout = 0 
			and a.checked = 'True' 
			and ((a.forputaway >= 6) or (a.forputaway = 0))
			and a.quantity = 1
            and coalesce(date(a.proddate), 'NO PRODUCTION DATE') = __value
			group by a.palletid
			order by a.expirydate asc;

			elseif __category = 'pallet' then
            select 
            concat(c.colname, '-',right(c.lcode, 1)) as locations,
			concat(b.systempid, '-', b.manualpid) as pid,
			count(distinct(a.receivingitemid)),
			b.palletid,
			b.manualpid,
			a.itemid, 
			round(sum(a.weight), 2)
			from wms_inbound.tbl_receivingitems a
			left join wms_inbound.tbl_pallets b on b.palletid = a.palletid
			left join wms_inbound.tbl_locations c on b.palletid = c.palletid
            left join wms_inbound.tbl_receiving d on a.ibn = d.ibn
			where a.itemid = __itemid 
			and a.ispick = 0 
			and a.isout = 0 
			and a.checked = 'True' 
			and ((a.forputaway >= 6) or (a.forputaway = 0))
			and a.quantity = 1
            and b.systempid = __value
			group by a.palletid
			order by a.expirydate asc;
            
            elseif __category = 'itemstats' then
            select 
            concat(c.colname, '-',right(c.lcode, 1)) as locations,
			concat(b.systempid, '-', b.manualpid) as pid,
			count(distinct(a.receivingitemid)),
			b.palletid,
			b.manualpid,
			a.itemid, 
			round(sum(a.weight), 2)
			from wms_inbound.tbl_receivingitems a
			left join wms_inbound.tbl_pallets b on b.palletid = a.palletid
			left join wms_inbound.tbl_locations c on b.palletid = c.palletid
            left join wms_inbound.tbl_receiving d on a.ibn = d.ibn
            left join wms_cloud.tbl_itemstatus e on a.ItemStatusID = e.ItemStatusID
			where a.itemid = __itemid 
			and a.ispick = 0 
			and a.isout = 0 
			and a.checked = 'True' 
			and ((a.forputaway >= 6) or (a.forputaway = 0))
			and a.quantity = 1
            and e.ItemStatus = __value
			group by a.palletid
			order by a.expirydate asc;

		end if;
END//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_picking_deleteallocation
DELIMITER //
CREATE PROCEDURE `sp_picking_deleteallocation`(
																in __id int,
                                                                in __userid int
                                                                )
begin
		declare __palletid int;
        
        declare __qty int;
        
        declare __pck varchar(20);
        
        set __palletid=(select palletid from wms_outbound.tbl_allocations where id = __id);
        
        set __qty=(select qty from wms_outbound.tbl_allocations where id = __id);
        
        set __pck=(SELECT B.PCK FROM wms_outbound.tbl_allocations A
					left join wms_outbound.tbl_picking B on A.pickingid = B.id
                    where A.id = __id
					group by B.id);
        
		 create temporary table tt_fordelete
         (
         select receivingid from wms_outbound.tbl_allocation_details
         where allocid = __id
         );
         
         update tt_fordelete a
         left join wms_inbound.tbl_receivingitems b on a.receivingid = b.receivingitemid 
         set b.ispick =0;
         
         delete from wms_outbound.tbl_allocations where id = __id;
         
         delete from wms_outbound.tbl_allocation_details where allocid = __id;
         
         delete from wms_outbound.tbl_actual_pick where receivingitemid in (select * from tt_fordelete);
         
		call wms_reports.sp_picking_logs(__pck,'DELETED PICK',__palletid,__qty,__userid);

		drop temporary table tt_fordelete;
end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_picking_getcontainer
DELIMITER //
CREATE PROCEDURE `sp_picking_getcontainer`(
											in __itemid int
											)
begin
			
select b.container from wms_inbound.tbl_receivingitems a
right join wms_inbound.tbl_receiving b on a.ibn = b.ibn
where a.itemid = __itemid
and a.ispick = 0 
and a.isout = 0 
and ((a.forputaway = 0) or (a.forputaway >= 6))
group by b.container;
end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_picking_manual_cluster_container
DELIMITER //
CREATE PROCEDURE `sp_picking_manual_cluster_container`(
														in __itemid int,
                                                        in __container varchar(200)
														)
begin

if __container = 'ALL' then

select concat(c.colname, '-',right(c.lcode, 1)) as locations,
concat(b.systempid, '-', b.manualpid) as pid,
count(distinct(a.receivingitemid)),
b.palletid,
b.manualpid,
a.itemid, 
d.container,
round(sum(a.weight), 2)
from wms_inbound.tbl_receivingitems a
left join wms_inbound.tbl_pallets b on b.palletid = a.palletid
left join wms_inbound.tbl_locations c on b.palletid = c.palletid
left join wms_inbound.tbl_receiving d on a.ibn = d.ibn
where a.itemid = __itemid
and a.ispick = 0 
and a.isout = 0 
and a.checked = 'True' 
and ((a.forputaway > 1) or (a.forputaway = 0))
and a.quantity = 1
group by a.palletid
order by a.expirydate asc;

else 
select concat(c.colname, '-',right(c.lcode, 1)) as locations,
concat(b.systempid, '-', b.manualpid) as pid,
count(distinct(a.receivingitemid)),
b.palletid,
b.manualpid,
a.itemid, 
d.container,
round(sum(a.weight), 2)
from wms_inbound.tbl_receivingitems a
left join wms_inbound.tbl_pallets b on b.palletid = a.palletid
left join wms_inbound.tbl_locations c on b.palletid = c.palletid
left join wms_inbound.tbl_receiving d on a.ibn = d.ibn
where a.itemid = __itemid
and a.ispick = 0 
and a.isout = 0 
and a.checked = 'True' 
and ((a.forputaway > 1) or (a.forputaway = 0))
and a.quantity = 1
and d.container = __container
group by a.palletid
order by a.expirydate asc;
end if;
end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_picking_openpck
DELIMITER //
CREATE PROCEDURE `sp_picking_openpck`(
	in `__pck` varchar(200),
	in `__user` varchar(200),
    in `__role` int
)
begin
	if __role != 2 then
		update wms_outbound.tbl_picking set statusid = 2, lastupdatedby = __user where pck = __pck;
	else
		update wms_outbound.tbl_picking set statusid = 2 where pck = __pck;
	end if;
select
 pck,
 pck.ord,
 pickingdate,
 pickingremarks,
 ord.customerid,
 companyname,
 orderdate,
 customerreference,
 otherreference,
 remarks,
 ord.PickupDate
from wms_outbound.tbl_picking pck
left join wms_outbound.tbl_ordering ord on pck.ord = ord.ord
left join wms_cloud.tbl_customers cus on ord.customerid = cus.customerid
where pck = __pck; end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_print_full_palletpicklist
DELIMITER //
CREATE PROCEDURE `sp_print_full_palletpicklist`(
	in `__pck` varchar(100),
	in `__from` int,
	in `__limit` int
)
begin
select concat(e.colname, '-',
right(e.lcode, 1)), concat(d.systempid, ' - ', d.manualpid),
 g.container,
 h.itemcode,
 h.itemdesc,
 i.uom_abv, sum(j.quantity),
 h.weight,
 b.qty,
 b.weight,
left(b.expirydate, 10), group_concat(distinct f.itemremark), group_concat(distinct b.status),
 (
select sum(bb.beg_quantity)
from wms_outbound.tbl_actual_pick aa
left join wms_inbound.tbl_receivingitems bb on aa.receivingitemid = bb.receivingitemid
where b.palletid = bb.palletid and aa.pck = a.pck),
 (
select sum(bb.beg_weight)
from wms_outbound.tbl_actual_pick aa
left join wms_inbound.tbl_receivingitems bb on aa.receivingitemid = bb.receivingitemid
where b.palletid = bb.palletid and aa.pck = a.pck)
from wms_outbound.tbl_picking a
left join wms_outbound.tbl_allocations b on a.id = b.pickingid
left join wms_outbound.tbl_allocation_details c on b.id = c.allocid
left join wms_inbound.tbl_pallets d on b.palletid = d.palletid
left join wms_inbound.tbl_locations e on d.palletid = e.palletid
left join wms_inbound.tbl_receivingitems f on c.receivingid = f.receivingitemid
left join wms_inbound.tbl_receiving g on f.ibn = g.ibn
left join wms_cloud.tbl_items h on b.itemid = h.itemid
left join wms_cloud.tbl_weightuom i on h.uomid = i.uomid
left join wms_outbound.tbl_orderingitems j on a.ord = j.ord
where a.pck = __pck
group by b.id
limit __from, __limit; end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_room_addroomlocations
DELIMITER //
CREATE PROCEDURE `sp_room_addroomlocations`(
IN __roomcode VARCHAR(45),
IN __lcode VARCHAR(45),
IN __columncode VARCHAR(45),
IN __locstatus INT,
IN __loadstatus INT,
IN __minweight DOUBLE,
IN __maxweight DOUBLE)
BEGIN

INSERT INTO wms_inbound.tbl_locations (`RoomCode`, `LCode`, `ColumnCode`, `LocStatus`, `ColStatus`, `LoadStatus`, `MinWeight`, `MaxWeight`, `ColName`)
VALUES (__roomcode, __lcode, __columncode, __locstatus, 1, __loadstatus, __minweight, __maxweight, __columncode);

END//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_room_details
DELIMITER //
CREATE PROCEDURE `sp_room_details`(
IN __roomname VARCHAR(45),
IN __roomtype INT,
IN __roomrate DOUBLE,
IN __xrows INT,
IN __ycolumns INT,
IN __zlevels INT,
IN __roomstatus VARCHAR(45),
IN __mintemp VARCHAR(45),
IN __maxtemp VARCHAR(45))
BEGIN
DECLARE _newroomcode VARCHAR(45);
DECLARE _ifexist INT;

REPEAT
	SET _newroomcode = (
    SELECT CONCAT('RM',LPAD(REPLACE(RoomCode,'RM','')+1,4,0))
    FROM wms_inbound.tbl_room
    ORDER BY RoomID DESC LIMIT 1
    );
    
    SET _ifexist = (
    SELECT COUNT(RoomID)
    FROM wms_inbound.tbl_room
    WHERE RoomCode = _newroomcode);
    
    IF _ifexist = 0 THEN
		INSERT INTO wms_inbound.tbl_room (`RoomName`,`RoomCode`,`RoomTypeID`, `RoomRate`, `XVal`, `YVal`, `ZVal`, `RoomStatus`, `MinTemp`, `MaxTemp`) VALUES (__roomname, _newroomcode, __roomtype, __roomrate, __xrows, __ycolumns, __zlevels, __roomstatus, __mintemp, __maxtemp);
        SELECT _newroomcode;
    END IF;
    
UNTIL _ifexist = 0
END REPEAT;

END//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_show_actual_list
DELIMITER //
CREATE PROCEDURE `sp_show_actual_list`(
	in `__pck` varchar(200),
	in `__itemid` int
)
begin
select concat(d.systempid,'-',d.manualpid) as pallet, 
concat(e.colname,'-',right(e.lcode, 1)) as location, coalesce(c.client_sku, c.itemcode) as sku,
 c.itemdesc as itemdesc, count(a.id) as qty,
 f.uom_abv as uom,
 b.weight as weight, coalesce(DATE(b.expirydate),'NO EXPIRY') as expiry
from wms_outbound.tbl_actual_pick a
left join wms_inbound.tbl_receivingitems b on a.receivingitemid = b.receivingitemid
left join wms_cloud.tbl_items c on b.itemid = c.itemid
left join wms_inbound.tbl_pallets d on b.palletid = d.palletid
left join wms_inbound.tbl_locations e on d.palletid = e.palletid
left join wms_cloud.tbl_weightuom f on c.uomid = f.uomid
where a.pck = __pck and a.itemid = __itemid
group by a.id; end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_show_actual_pick
DELIMITER //
CREATE PROCEDURE `sp_show_actual_pick`(
	in `__pck` varchar(200)
)
begin
select c.itemid,
coalesce(h.client_sku,h.itemcode) as clientsku,
h.itemdesc as itemdesc,
coalesce(c.quantity,0) as orderedqty,
coalesce(count(distinct(f.id)),0) as allocqty,
coalesce(count(distinct(g.id)),0) as actualpick,
b.customerid,
c.itemid
from wms_outbound.tbl_picking a
left join wms_outbound.tbl_ordering b on a.ord = b.ord
left join wms_outbound.tbl_orderingitems c on b.ord = c.ord
left join wms_outbound.tbl_allocations d on a.id = d.pickingid and c.itemid = d.itemid
left join wms_outbound.tbl_allocation_details f on d.id = f.allocid
left join wms_outbound.tbl_actual_pick g on a.pck = g.pck and c.itemid = g.itemid
left join wms_cloud.tbl_items h on c.itemid = h.itemid
where a.pck = __pck
group by c.itemid
order by c.itemid asc;
end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_show_allocated_list
DELIMITER //
CREATE PROCEDURE `sp_show_allocated_list`(
	in `__allocatedid` int
)
begin
select concat(d.systempid,'-',d.manualpid) as pallet, 
concat(e.colname,'-',
right(e.lcode, 1)) as location, 
coalesce(f.client_sku,f.itemcode) as sku,
f.itemdesc as itemdesc,
c.quantity as qty,
g.uom_abv as uom, cast(c.weight as decimal(10,2)) as weight, 
(case when c.expirydate is null then 'NO EXPIRY' else date(c.expirydate) end),
c.receivingitemid,
c.itemid
from wms_outbound.tbl_allocations a
left join wms_outbound.tbl_allocation_details b on a.id = b.allocid
left join wms_inbound.tbl_receivingitems c on b.receivingid = c.receivingitemid
left join wms_inbound.tbl_pallets d on c.palletid = d.palletid
left join wms_inbound.tbl_locations e on e.palletid = d.palletid
left join wms_cloud.tbl_items f on c.itemid = f.itemid
left join wms_cloud.tbl_weightuom g on f.uomid = g.uomid
where a.id = __allocatedid 
and c.ispick = 1 
and c.isout = 0 
and c.quantity !=0
group by c.receivingitemid;
end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_show_allocated_list_palletid
DELIMITER //
CREATE PROCEDURE `sp_show_allocated_list_palletid`(
																in `__allocatedid` int
                                                                )
begin

declare __palletid int;

declare __pickingid int;

set __palletid = (select palletid from wms_outbound.tbl_allocations where id = __allocatedid);

set __pickingid = (select pickingid from wms_outbound.tbl_allocations where id = __allocatedid);


select 
concat(d.systempid,'-',d.manualpid) as pallet, 
concat(e.colname,'-',right(e.lcode, 1)) as location, 
coalesce(f.client_sku,f.itemcode) as sku,
f.itemdesc as itemdesc,
c.quantity as qty,
g.uom_abv as uom, 
cast(c.weight as decimal(10,2)) as weight, 
(case when c.expirydate is null then 'NO EXPIRY' else date(c.expirydate) end),
c.receivingitemid,
c.itemid
from wms_outbound.tbl_allocations a
left join wms_outbound.tbl_allocation_details b on a.id = b.allocid
left join wms_inbound.tbl_receivingitems c on b.receivingid = c.receivingitemid
left join wms_inbound.tbl_pallets d on c.palletid = d.palletid
left join wms_inbound.tbl_locations e on e.palletid = d.palletid
left join wms_cloud.tbl_items f on c.itemid = f.itemid
left join wms_cloud.tbl_weightuom g on f.uomid = g.uomid
where a.palletid = __palletid 
and a.pickingid = __pickingid
and c.ispick = 1 
and c.isout = 0 
and c.quantity !=0
group by c.receivingitemid; 

end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_submit_picking
DELIMITER //
CREATE PROCEDURE `sp_submit_picking`(
	in `__ord` varchar(200),
	in `__pck` varchar(200),
	in `__pickingremarks` varchar(200)
)
begin 

declare __picklist int; 
declare __counter int;

set __picklist = (
			select 
			id
			from wms_outbound.tbl_picking
			where ord = __ord 
			and pck = __pck
            );
set __counter = (
			select 
			count(*)
			from wms_outbound.tbl_actual_pick
			where pck = __pck
            );
			
			if __counter > 0 then

			update wms_outbound.tbl_picking 
            set statusid = 3,
            ord = __ord, 
			pickingdate = now(), 
			pickingremarks = __pickingremarks
			where pck = __pck;
                        
			update wms_outbound.tbl_allocation_details a
			left join wms_inbound.tbl_receivingitems b on a.receivingid = b.receivingitemid set b.ispick = 0
			where a.picklistid = __picklist 
            and b.ispick = 1; 
            
            select 'done';
            
            else
            
            select 'null';
            
            end if;
            
end//
DELIMITER ;

-- Dumping structure for procedure wms_outbound.sp_tbl_outbound_report
DELIMITER //
CREATE PROCEDURE `sp_tbl_outbound_report`(
	in `fromdate` datetime,
	in `todate` datetime
)
begin
select
	issuancedate,
	i.obd,
	otherref,
	c.companyname,
	(
select sum(quantity)
from tbl_issuances ic
left join tbl_issuancelist il on ic.obd = il.obd
left join tbl_actualpick ap on il.picklistid = ap.picklistid
where i.obd = il.obd
order by ic.issuancedate asc) quantity,
	(
select sum(weight)
from tbl_issuances ic
left join tbl_issuancelist il on ic.obd = il.obd
left join tbl_actualpick ap on il.picklistid = ap.picklistid
where i.obd = il.obd
order by ic.issuancedate asc) weight, sum(palletout) palletout,
	checker,
	timestart,
	timefinish,
	remarks
from tbl_issuances i
left join wms_inbound.tbl_customers c on i.customerid = c.customerid
left join wms_outbound.tbl_issuancelist il on i.obd = il.obd
left join wms_outbound.tbl_picklist pl on il.picklistid = pl.id
where issuancedate between `fromdate` and `todate`
group by i.obd
order by issuancedate asc; end//
DELIMITER ;

-- Dumping structure for table wms_outbound.tbl_actual_pick
CREATE TABLE IF NOT EXISTS `tbl_actual_pick` (
  `id` int NOT NULL AUTO_INCREMENT,
  `PCK` varchar(45) DEFAULT NULL,
  `itemid` int DEFAULT NULL,
  `receivingitemid` int DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=581455 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_outbound.tbl_allocations
CREATE TABLE IF NOT EXISTS `tbl_allocations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pickingid` int DEFAULT NULL,
  `palletid` int DEFAULT NULL,
  `expirydate` varchar(200) DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `itemid` int DEFAULT NULL,
  `qty` int DEFAULT NULL,
  `status` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27266 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_outbound.tbl_allocation_details
CREATE TABLE IF NOT EXISTS `tbl_allocation_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `picklistid` int DEFAULT NULL,
  `allocid` int DEFAULT NULL,
  `receivingid` int DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=638167 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_outbound.tbl_dr
CREATE TABLE IF NOT EXISTS `tbl_dr` (
  `id` int NOT NULL AUTO_INCREMENT,
  `DR` varchar(45) DEFAULT NULL,
  `StatusID` int DEFAULT NULL,
  `CustomerID` int DEFAULT NULL,
  `Supplier` varchar(45) DEFAULT NULL,
  `IssuanceDate` varchar(45) DEFAULT NULL,
  `TruckTypeID` int DEFAULT NULL,
  `Plate` varchar(45) DEFAULT NULL,
  `Container` varchar(45) DEFAULT NULL,
  `OtherRef` varchar(45) DEFAULT NULL,
  `CustomerReference` varchar(45) DEFAULT NULL,
  `Remarks` varchar(45) DEFAULT NULL,
  `TimeStart` varchar(45) DEFAULT NULL,
  `TimeFinish` varchar(45) DEFAULT NULL,
  `Seal` varchar(45) DEFAULT NULL,
  `LoadingBay` varchar(45) DEFAULT NULL,
  `GatePass` varchar(45) DEFAULT NULL,
  `RequestedBy` varchar(45) DEFAULT NULL,
  `Checker` varchar(45) DEFAULT NULL,
  `RequestorPD` varchar(45) DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  `LastUpdatedBy` varchar(45) DEFAULT NULL,
  `EndDate` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_outbound.tbl_dritems
CREATE TABLE IF NOT EXISTS `tbl_dritems` (
  `id` int NOT NULL AUTO_INCREMENT,
  `DR` varchar(45) DEFAULT NULL,
  `PCK` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_outbound.tbl_issuancelist
CREATE TABLE IF NOT EXISTS `tbl_issuancelist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `OBD` varchar(45) DEFAULT NULL,
  `PCK` varchar(45) DEFAULT NULL,
  `PalletID` int DEFAULT NULL,
  `itemid` int DEFAULT NULL,
  `Receivingitemid` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=536130 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_outbound.tbl_issuances
CREATE TABLE IF NOT EXISTS `tbl_issuances` (
  `id` int NOT NULL AUTO_INCREMENT,
  `OBD` varchar(45) DEFAULT NULL,
  `StatusID` int DEFAULT NULL,
  `CustomerID` int DEFAULT NULL,
  `Supplier` varchar(45) DEFAULT NULL,
  `IssuanceDate` datetime DEFAULT NULL,
  `TruckTypeID` int DEFAULT NULL,
  `Plate` varchar(45) DEFAULT NULL,
  `Container` varchar(45) DEFAULT NULL,
  `OtherRef` varchar(45) DEFAULT NULL,
  `CustomerReference` varchar(45) DEFAULT NULL,
  `Remarks` varchar(45) DEFAULT NULL,
  `TimeStart` varchar(45) DEFAULT NULL,
  `TimeFinish` varchar(45) DEFAULT NULL,
  `Seal` varchar(45) DEFAULT NULL,
  `LoadingBay` varchar(45) DEFAULT NULL,
  `GatePass` varchar(45) DEFAULT NULL,
  `RequestedBy` varchar(45) DEFAULT NULL,
  `Checker` varchar(45) DEFAULT NULL,
  `RequestorPD` varchar(45) DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  `LastUpdatedBy` varchar(45) DEFAULT NULL,
  `EndDate` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2652 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_outbound.tbl_ordering
CREATE TABLE IF NOT EXISTS `tbl_ordering` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ORD` varchar(45) DEFAULT NULL,
  `StatusID` int DEFAULT NULL,
  `CustomerID` int DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  `LastUpdatedBy` varchar(45) DEFAULT NULL,
  `OrderDate` varchar(45) DEFAULT NULL,
  `PickupDate` varchar(45) DEFAULT NULL,
  `Remarks` varchar(45) DEFAULT NULL,
  `CustomerReference` varchar(45) DEFAULT NULL,
  `OtherReference` varchar(45) DEFAULT NULL,
  `FromCP` text,
  `CPO` varchar(50) DEFAULT NULL,
  `CPStatus_id` int DEFAULT NULL,
  `DRStatus` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2930 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_outbound.tbl_orderingitems
CREATE TABLE IF NOT EXISTS `tbl_orderingitems` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ORD` varchar(45) DEFAULT NULL,
  `ItemID` int DEFAULT NULL,
  `Quantity` double DEFAULT NULL,
  `Status` int DEFAULT '1',
  `weight` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6280 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_outbound.tbl_palletout
CREATE TABLE IF NOT EXISTS `tbl_palletout` (
  `id` int NOT NULL AUTO_INCREMENT,
  `obd` varchar(45) DEFAULT NULL,
  `palletid` varchar(45) DEFAULT NULL,
  `remaining_qty` int DEFAULT NULL,
  `willdeduct` int DEFAULT NULL,
  `afterissuance` int DEFAULT NULL,
  `ispalletout` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=208323 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_outbound.tbl_picking
CREATE TABLE IF NOT EXISTS `tbl_picking` (
  `id` int NOT NULL AUTO_INCREMENT,
  `PCK` varchar(45) DEFAULT NULL,
  `ORD` varchar(45) DEFAULT NULL,
  `StatusID` int DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  `LastUpdatedBy` varchar(45) DEFAULT NULL,
  `PickingDate` datetime DEFAULT NULL,
  `PickingRemarks` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2848 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_outbound.tbl_temp
CREATE TABLE IF NOT EXISTS `tbl_temp` (
  `id` int NOT NULL,
  `TempORD` int DEFAULT NULL,
  `TempPCK` int DEFAULT NULL,
  `TempOBD` int DEFAULT NULL,
  `TempPicklistID` int DEFAULT NULL,
  `TempDR` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.


-- Dumping database structure for wms_reports
CREATE DATABASE IF NOT EXISTS `wms_reports` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `wms_reports`;

-- Dumping structure for view wms_reports.inventory_masterlistreport_receiving
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `inventory_masterlistreport_receiving` (
	`CustomerID` INT(10) UNSIGNED NULL,
	`CompanyName` VARCHAR(191) NULL COLLATE 'utf8_general_ci',
	`Weight` DOUBLE NOT NULL,
	`PalletID` BIGINT(19) NOT NULL,
	`ReceivingDate` VARCHAR(10) NULL COLLATE 'utf8_general_ci',
	`TransactionNumber` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`ItemCategoryID` INT(10) UNSIGNED NULL,
	`ItemCategory` VARCHAR(191) NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Dumping structure for procedure wms_reports.picklist
DELIMITER //
CREATE PROCEDURE `picklist`(IN __PCK VARCHAR(100), IN __LIMIT INT)
BEGIN
	SELECT
                        CONCAT(E.ColName, '-', RIGHT(E.LCode, 1)),
                        CONCAT(D.SystemPID, ' - ', D.ManualPID),
                        G.Container,
                        H.ItemCode,
                        H.ItemDesc,
                        I.UOM_Abv,
                        0,
                        H.Weight,
                        COUNT(C.receivingid),
                        SUM(F.Beg_Weight),
                        CASE
                            WHEN LEFT(B.expirydate, 10) = '0000-00-00' THEN 'No Expiry'
                            WHEN B.expirydate IS NULL THEN 'No Expiry'
                            ELSE LEFT(B.expirydate, 10)
                        END,
                        GROUP_CONCAT(DISTINCT F.ItemRemark),
                        GROUP_CONCAT(DISTINCT L.ItemStatus),
                        COUNT(K.receivingitemid),
                        SUM(K.Beg_Weight),
                        K.receivingitemid
                    FROM wms_outbound.tbl_picking A
                    LEFT JOIN wms_outbound.tbl_allocations B ON A.id = B.pickingid
                    LEFT JOIN wms_outbound.tbl_allocation_details C ON B.id = C.allocid
                    LEFT JOIN wms_inbound.tbl_pallets D ON B.palletid = D.PalletID
                    LEFT JOIN wms_inbound.tbl_locations E ON D.PalletID = E.PalletID
                    LEFT JOIN wms_inbound.tbl_receivingitems F ON C.receivingid = F.ReceivingItemID
                    LEFT JOIN wms_inbound.tbl_receiving G ON F.IBN = G.IBN
                    LEFT JOIN wms_cloud.tbl_items H ON B.itemid = H.ItemID
                    LEFT JOIN wms_cloud.tbl_weightuom I ON H.UOMID = I.UOMID
                    LEFT JOIN wms_reports.tbl_actual_pick_with_weight K ON F.receivingitemid = K.receivingitemid
                    LEFT JOIN wms_cloud.tbl_itemstatus L ON F.ItemStatusID = L.ItemStatusID
                    WHERE A.PCK = __PCK
                    GROUP BY B.palletid, B.id
                    LIMIT __LIMIT, 5;
END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.sp_admin_tools
DELIMITER //
CREATE PROCEDURE `sp_admin_tools`()
BEGIN
					SELECT
                    C.ItemDesc AS ItemDesc,
                    SUM(A.Beg_Quantity) AS RecQty,
                    SUM(A.Quantity) AS RecQty,
                    UOM_Abv,
                    CASE
                        WHEN LEFT(ExpiryDate, 10) = '0000-00-00' THEN 'No Expiry'
                        WHEN ExpiryDate IS NULL THEN 'No Expiry'
                        ELSE LEFT(ExpiryDate, 10)
                    END AS ExpiryDate,
                    CONCAT(SystemPID, ' - ', ManualPID) AS PID,
                    CONCAT(ColName, '-', RIGHT(LCode, 1)) AS Loc,
                    Client_SKU,
                    H.ItemStatus,
                    COUNT(I.receivingid),
                    COUNT(J.receivingitemid),
                    COUNT(K.Receivingitemid),
                    L.CompanyName
                FROM wms_inbound.tbl_receivingitems A
                LEFT JOIN wms_inbound.tbl_receiving B ON A.IBN = B.IBN AND A.isout = 0 
                LEFT JOIN wms_cloud.tbl_items C ON A.ItemID = C.ItemID
                LEFT JOIN wms_inbound.tbl_pallets D ON A.PalletID = D.PalletID
                LEFT JOIN wms_cloud.tbl_weightuom E ON C.UOMID = E.UOMID
                LEFT JOIN wms_inbound.tbl_locations F ON D.LocationID = F.LocationID
                LEFT JOIN wms_inbound.tbl_room G ON F.RoomCode = G.RoomCode
                LEFT JOIN wms_cloud.tbl_itemstatus H ON A.ItemStatusID = H.ItemStatusID
                LEFT JOIN wms_outbound.tbl_allocation_details I ON A.ReceivingItemID = I.receivingid
                LEFT JOIN wms_outbound.tbl_actual_pick J ON A.ReceivingItemID = J.receivingitemid
                LEFT JOIN wms_outbound.tbl_issuancelist K ON A.ReceivingItemID = K.receivingitemid
                LEFT JOIN wms_cloud.tbl_customers L ON A.CustomerID = L.CustomerID
                WHERE A.CustomerID != 16
                GROUP BY A.PalletID, A.ItemID, A.ItemStatusID;
END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.sp_admin_tools_bypck
DELIMITER //
CREATE PROCEDURE `sp_admin_tools_bypck`()
BEGIN
				SELECT
					J.PCK,
                    CONCAT(SystemPID, ' - ', ManualPID) AS PID,
                    CONCAT(ColName, '-', RIGHT(LCode, 1)) AS Loc,
                    Client_SKU,
                    H.ItemStatus,
                    COUNT(I.receivingid),
                    COUNT(J.receivingitemid),
                    COUNT(K.Receivingitemid),
                    L.CompanyName
                FROM wms_inbound.tbl_receivingitems A
                LEFT JOIN wms_cloud.tbl_items C ON A.ItemID = C.ItemID
                LEFT JOIN wms_inbound.tbl_pallets D ON A.PalletID = D.PalletID
                LEFT JOIN wms_inbound.tbl_locations F ON D.LocationID = F.LocationID
                LEFT JOIN wms_cloud.tbl_itemstatus H ON A.ItemStatusID = H.ItemStatusID
                LEFT JOIN wms_outbound.tbl_allocation_details I ON A.ReceivingItemID = I.receivingid
                LEFT JOIN wms_outbound.tbl_actual_pick J ON A.ReceivingItemID = J.receivingitemid
                LEFT JOIN wms_outbound.tbl_issuancelist K ON A.ReceivingItemID = K.receivingitemid
                LEFT JOIN wms_cloud.tbl_customers L ON A.CustomerID = L.CustomerID
                WHERE A.CustomerID != 16 AND J.PCK IS NOT NULL
                GROUP BY A.PalletID, A.ItemID, A.ItemStatusID, J.PCK;
END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_Ageing_Dashboard
DELIMITER //
CREATE PROCEDURE `SP_Ageing_Dashboard`(

	IN `__CustomerID` INT

)
BEGIN

	SELECT

		SUM(CASE

			WHEN ExpiryDate <= CURDATE() AND ExpiryDate IS NOT NULL AND ExpiryDate != '0000-00-00 00:00:00' THEN Quantity ELSE 0

		END) Expired,

        SUM(CASE

			WHEN ExpiryDate BETWEEN NOW() + INTERVAL 1 DAY AND DATE_ADD(NOW(), INTERVAL 3 MONTH) THEN Quantity ELSE 0

		END) LessSix,

        SUM(CASE

			WHEN ExpiryDate BETWEEN DATE_ADD(NOW(), INTERVAL 3 MONTH) AND DATE_ADD(NOW(), INTERVAL 6 MONTH) THEN Quantity ELSE 0

		END) AS LessSix,

        SUM(CASE

			WHEN ExpiryDate BETWEEN NOW() + INTERVAL 6 MONTH AND DATE_ADD(NOW(), INTERVAL 25 YEAR) THEN Quantity ELSE 0

		END) AS MoreSix,

        SUM(CASE

			WHEN (ExpiryDate = '0000-00-00 00:00:00' OR ExpiryDate IS NULL) THEN Quantity ELSE 0

		END) AS NoExpiry

	FROM wms_inbound.tbl_receivingitems

	LEFT JOIN wms_inbound.tbl_receiving ON wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN

	WHERE CustomerID = __CustomerID AND (ForPutAway = 0 OR ForPutAway > 1);

END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_Ageing_Dashboard_BySKU
DELIMITER //
CREATE PROCEDURE `SP_Ageing_Dashboard_BySKU`(

	IN `__CustomerID` INT,

	IN `__ItemID` INT

)
BEGIN

	SELECT

		IFNULL(SUM(CASE

			WHEN ExpiryDate <= CURDATE() AND ExpiryDate IS NOT NULL AND ExpiryDate != '0000-00-00 00:00:00' THEN Quantity ELSE 0

		END), 0) Expired,

        IFNULL(SUM(CASE

			WHEN ExpiryDate BETWEEN NOW() + INTERVAL 1 DAY AND DATE_ADD(NOW(), INTERVAL 3 MONTH) THEN Quantity ELSE 0

		END), 0) LessSix,

        IFNULL(SUM(CASE

			WHEN ExpiryDate BETWEEN DATE_ADD(NOW(), INTERVAL 3 MONTH) AND DATE_ADD(NOW(), INTERVAL 6 MONTH) THEN Quantity ELSE 0

		END), 0) AS LessSix,

        IFNULL(SUM(CASE

			WHEN ExpiryDate BETWEEN NOW() + INTERVAL 6 MONTH AND DATE_ADD(NOW(), INTERVAL 25 YEAR) THEN Quantity ELSE 0

		END), 0) AS MoreSix,

        IFNULL(SUM(CASE

			WHEN (ExpiryDate = '0000-00-00 00:00:00' OR ExpiryDate IS NULL) THEN Quantity ELSE 0

		END), 0) AS NoExpiry,

        

        

        IFNULL(SUM(CASE

			WHEN ExpiryDate <= CURDATE() AND ExpiryDate IS NOT NULL AND ExpiryDate != '0000-00-00 00:00:00' THEN Weight ELSE 0

		END), 0) Expired,

        IFNULL(SUM(CASE

			WHEN ExpiryDate BETWEEN NOW() + INTERVAL 1 DAY AND DATE_ADD(NOW(), INTERVAL 3 MONTH) THEN Weight ELSE 0

		END), 0) LessSix,

        IFNULL(SUM(CASE

			WHEN ExpiryDate BETWEEN DATE_ADD(NOW(), INTERVAL 3 MONTH) AND DATE_ADD(NOW(), INTERVAL 6 MONTH) THEN Weight ELSE 0

		END), 0) AS LessSix,

        IFNULL(SUM(CASE

			WHEN ExpiryDate BETWEEN NOW() + INTERVAL 6 MONTH AND DATE_ADD(NOW(), INTERVAL 25 YEAR) THEN Weight ELSE 0

		END), 0) AS MoreSix,

        IFNULL(SUM(CASE

			WHEN (ExpiryDate = '0000-00-00 00:00:00' OR ExpiryDate IS NULL) THEN Weight ELSE 0

		END), 0) AS NoExpiry

	FROM wms_inbound.tbl_receivingitems

	LEFT JOIN wms_inbound.tbl_receiving ON wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN

	WHERE CustomerID = __CustomerID AND wms_inbound.tbl_receiving.StatusID = 3 AND ItemID = __ItemID;

END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_ageing_dashboard_onclick_expired
DELIMITER //
CREATE PROCEDURE `SP_ageing_dashboard_onclick_expired`(IN `__CustomerID` INT, IN `__ItemID` INT)
BEGIN

	IF __ItemID IS NULL THEN

				SELECT 

                    Client_SKU,

                    ItemDesc,

                    COUNT(Client_SKU),

                    SUM(Quantity),

                    SUM(wms_inbound.tbl_receivingitems.Weight),

                    CASE

                        WHEN LEFT(ExpiryDate, 10) = '0000-00-00' THEN 'No Expiry'

                        ELSE LEFT(ExpiryDate, 10)

                    END,

                    IF(DATEDIFF(ExpiryDate, CURDATE()) < 1,

                        'Expired',

                        DATEDIFF(ExpiryDate, CURDATE())),

                    ItemCode

                FROM

                    wms_inbound.tbl_receivingitems

                        LEFT JOIN

                    wms_inbound.tbl_receiving ON wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN

                        LEFT JOIN

                    wms_cloud.tbl_items ON wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID

				WHERE Quantity > 0 AND (ForPutAway = 0 OR ForPutAway > 1) AND wms_inbound.tbl_receivingitems.CustomerID = __CustomerID 

                AND LEFT(ExpiryDate, 10) <= CURDATE() AND (LEFT(ExpiryDate, 10) != '0000-00-00' OR ExpiryDate IS NOT NULL)

                        GROUP BY ExpiryDate, wms_inbound.tbl_receivingitems.ItemID;

                        

	ELSE

                        

			SELECT 

                    Client_SKU,

                    ItemDesc,

                    COUNT(Client_SKU),

                    SUM(Quantity),

                    SUM(wms_inbound.tbl_receivingitems.Weight),

                    LEFT(ExpiryDate, 10),

                    IF(DATEDIFF(ExpiryDate, CURDATE()) < 1,

                        'Expired',

                        DATEDIFF(ExpiryDate, CURDATE())),

                    ItemCode

                FROM

                    wms_inbound.tbl_receivingitems

                        LEFT JOIN

                    wms_inbound.tbl_receiving ON wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN

                        LEFT JOIN

                    wms_cloud.tbl_items ON wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID

				WHERE Quantity > 0 AND (ForPutAway = 0 OR ForPutAway > 1) AND wms_inbound.tbl_receivingitems.CustomerID = __CustomerID AND wms_cloud.tbl_items.ItemID = __ItemID

                AND LEFT(ExpiryDate, 10) <= CURDATE() AND LEFT(ExpiryDate, 10) != '0000-00-00'

                        GROUP BY ExpiryDate, wms_inbound.tbl_receivingitems.ItemID;

	END IF;

END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_ageing_dashboard_onclick_lessSix
DELIMITER //
CREATE PROCEDURE `SP_ageing_dashboard_onclick_lessSix`(IN `__CustomerID` INT, IN `__DateFrom` DATETIME, IN `__DateTo` DATETIME, IN `__ItemID` INT)
BEGIN

	IF __ItemID IS NULL THEN

				SELECT 

                    Client_SKU,

                    ItemDesc,

                    COUNT(Client_SKU),

                    SUM(Quantity),

                    SUM(wms_inbound.tbl_receivingitems.Weight),

                    CASE

                        WHEN LEFT(ExpiryDate, 10) = '0000-00-00' THEN 'No Expiry'

                        ELSE LEFT(ExpiryDate, 10)

                    END,

                    IF(DATEDIFF(ExpiryDate, CURDATE()) < 1,

                        'Expired',

                        DATEDIFF(ExpiryDate, CURDATE())),

                    ItemCode

                FROM

                    wms_inbound.tbl_receivingitems

                        LEFT JOIN

                    wms_inbound.tbl_receiving ON wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN

                        LEFT JOIN

                    wms_cloud.tbl_items ON wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID

				WHERE Quantity > 0 AND (ForPutAway = 0 OR ForPutAway > 1) AND wms_inbound.tbl_receivingitems.CustomerID = __CustomerID 

                AND LEFT(ExpiryDate, 10) BETWEEN __DateFrom AND __DateTo

                        GROUP BY ExpiryDate, wms_inbound.tbl_receivingitems.ItemID;

                        

	ELSE	

				

                SELECT 

                    Client_SKU,

                    ItemDesc,

                    COUNT(Client_SKU),

                    SUM(Quantity),

                    SUM(wms_inbound.tbl_receivingitems.Weight),

                    LEFT(ExpiryDate, 10),

                    IF(DATEDIFF(ExpiryDate, CURDATE()) < 1,

                        'Expired',

                        DATEDIFF(ExpiryDate, CURDATE())),

                    ItemCode

                FROM

                    wms_inbound.tbl_receivingitems

                        LEFT JOIN

                    wms_inbound.tbl_receiving ON wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN

                        LEFT JOIN

                    wms_cloud.tbl_items ON wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID

				WHERE Quantity > 0 AND (ForPutAway = 0 OR ForPutAway > 1) AND wms_inbound.tbl_receivingitems.CustomerID = __CustomerID AND wms_inbound.tbl_receivingitems.ItemID = __ItemID

                AND LEFT(ExpiryDate, 10) BETWEEN __DateFrom AND __DateTo

                        GROUP BY ExpiryDate, wms_inbound.tbl_receivingitems.ItemID;

    END IF;

END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_ageing_dashboard_onclick_lessThree
DELIMITER //
CREATE PROCEDURE `SP_ageing_dashboard_onclick_lessThree`(IN `__CustomerID` INT, IN `__DateFrom` DATETIME, IN `__DateTo` DATETIME, IN `__ItemID` INT)
BEGIN

	IF __ItemID IS NULL THEN

				SELECT 

                    Client_SKU,

                    ItemDesc,

                    COUNT(Client_SKU),

                    SUM(Quantity),

                    SUM(wms_inbound.tbl_receivingitems.Weight),

                    CASE

                        WHEN LEFT(ExpiryDate, 10) = '0000-00-00' THEN 'No Expiry'

                        ELSE LEFT(ExpiryDate, 10)

                    END,

                    IF(DATEDIFF(ExpiryDate, CURDATE()) < 1,

                        'Expired',

                        DATEDIFF(ExpiryDate, CURDATE())),

                    ItemCode

                FROM

                    wms_inbound.tbl_receivingitems

                        LEFT JOIN

                    wms_inbound.tbl_receiving ON wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN

                        LEFT JOIN

                    wms_cloud.tbl_items ON wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID

				WHERE Quantity > 0 AND (ForPutAway = 0 OR ForPutAway > 1) AND wms_inbound.tbl_receivingitems.CustomerID = __CustomerID 

                AND LEFT(ExpiryDate, 10) BETWEEN CURDATE() + INTERVAL 1 DAY AND __DateTo

                        GROUP BY ExpiryDate, wms_inbound.tbl_receivingitems.ItemID;

	ELSE		

    

    

				SELECT 

                    Client_SKU,

                    ItemDesc,

                    COUNT(Client_SKU),

                    SUM(Quantity),

                    SUM(wms_inbound.tbl_receivingitems.Weight),

                    LEFT(ExpiryDate, 10),

                    IF(DATEDIFF(ExpiryDate, CURDATE()) < 1,

                        'Expired',

                        DATEDIFF(ExpiryDate, CURDATE())),

                    ItemCode

                FROM

                    wms_inbound.tbl_receivingitems

                        LEFT JOIN

                    wms_inbound.tbl_receiving ON wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN

                        LEFT JOIN

                    wms_cloud.tbl_items ON wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID

				WHERE Quantity > 0 AND (ForPutAway = 0 OR ForPutAway > 1) AND wms_inbound.tbl_receivingitems.CustomerID = __CustomerID AND wms_inbound.tbl_receivingitems.ItemID = __ItemID

                AND LEFT(ExpiryDate, 10) BETWEEN CURDATE() + INTERVAL 1 DAY AND __DateTo

                        GROUP BY ExpiryDate, wms_inbound.tbl_receivingitems.ItemID;

    END IF;

END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_ageing_dashboard_onclick_moreSix
DELIMITER //
CREATE PROCEDURE `SP_ageing_dashboard_onclick_moreSix`(IN `__CustomerID` INT, IN `__DateFrom` DATETIME, IN `__DateTo` DATETIME, IN `__ItemID` INT)
BEGIN

	IF __ItemID IS NULL THEN

			SELECT 

                    Client_SKU,

                    ItemDesc,

                    COUNT(Client_SKU),

                    SUM(Quantity),

                    SUM(wms_inbound.tbl_receivingitems.Weight),

                    CASE

                        WHEN LEFT(ExpiryDate, 10) = '0000-00-00' THEN 'No Expiry'

                        ELSE LEFT(ExpiryDate, 10)

                    END,

                    IF(DATEDIFF(ExpiryDate, CURDATE()) < 1,

                        'Expired',

                        DATEDIFF(ExpiryDate, CURDATE())),

                    ItemCode

                FROM

                    wms_inbound.tbl_receivingitems

                        LEFT JOIN

                    wms_inbound.tbl_receiving ON wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN

                        LEFT JOIN

                    wms_cloud.tbl_items ON wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID

				WHERE Quantity > 0 AND (ForPutAway = 0 OR ForPutAway > 1) AND wms_inbound.tbl_receivingitems.CustomerID = __CustomerID 

                AND LEFT(ExpiryDate, 10) BETWEEN __DateFrom AND __DateTo

                        GROUP BY ExpiryDate, wms_inbound.tbl_receivingitems.ItemID;

	ELSE 

    

			SELECT 

                    Client_SKU,

                    ItemDesc,

                    COUNT(Client_SKU),

                    SUM(Quantity),

                    SUM(wms_inbound.tbl_receivingitems.Weight),

                    LEFT(ExpiryDate, 10),

                    IF(DATEDIFF(ExpiryDate, CURDATE()) < 1,

                        'Expired',

                        DATEDIFF(ExpiryDate, CURDATE())),

                    ItemCode

                FROM

                    wms_inbound.tbl_receivingitems

                        LEFT JOIN

                    wms_inbound.tbl_receiving ON wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN

                        LEFT JOIN

                    wms_cloud.tbl_items ON wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID

				WHERE Quantity > 0 AND (ForPutAway = 0 OR ForPutAway > 1) AND wms_inbound.tbl_receivingitems.CustomerID = __CustomerID AND wms_inbound.tbl_receivingitems.ItemID = __ItemID

                AND LEFT(ExpiryDate, 10) BETWEEN __DateFrom AND __DateTo

                        GROUP BY ExpiryDate, wms_inbound.tbl_receivingitems.ItemID;

    END IF;

END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_ageing_dashboard_onclick_noExpiry
DELIMITER //
CREATE PROCEDURE `SP_ageing_dashboard_onclick_noExpiry`(IN `__CustomerID` INT, IN `__ItemID` INT)
BEGIN

	IF __ItemID IS NULL THEN

				SELECT 

                    Client_SKU,

                    ItemDesc,

                    COUNT(Client_SKU),

                    SUM(Quantity),

                    SUM(wms_inbound.tbl_receivingitems.Weight),

                    CASE

                        WHEN LEFT(ExpiryDate, 10) = '0000-00-00' THEN 'No Expiry'

                        ELSE LEFT(ExpiryDate, 10)

                    END,

                    IF(DATEDIFF(ExpiryDate, CURDATE()) < 1,

                        'Expired',

                        DATEDIFF(ExpiryDate, CURDATE())),

                    ItemCode

                FROM

                    wms_inbound.tbl_receivingitems

                        LEFT JOIN

                    wms_inbound.tbl_receiving ON wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN

                        LEFT JOIN

                    wms_cloud.tbl_items ON wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID

				WHERE Quantity > 0 AND (ForPutAway = 0 OR ForPutAway > 1) AND wms_inbound.tbl_receivingitems.CustomerID = __CustomerID 

                AND LEFT(ExpiryDate, 10) = '0000-00-00' OR ExpiryDate IS NULL

                        GROUP BY ExpiryDate, wms_inbound.tbl_receivingitems.ItemID;

                        

      ELSE                  

                        

				SELECT 

                    Client_SKU,

                    ItemDesc,

                    COUNT(Client_SKU),

                    SUM(Quantity),

                    SUM(wms_inbound.tbl_receivingitems.Weight),

                    LEFT(ExpiryDate, 10),

                    IF(DATEDIFF(ExpiryDate, CURDATE()) < 1,

                        'Expired',

                        DATEDIFF(ExpiryDate, CURDATE())),

                    ItemCode

                FROM

                    wms_inbound.tbl_receivingitems

                        LEFT JOIN

                    wms_inbound.tbl_receiving ON wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN

                        LEFT JOIN

                    wms_cloud.tbl_items ON wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID

				WHERE Quantity > 0 AND (ForPutAway = 0 OR ForPutAway > 1) AND wms_inbound.tbl_receivingitems.CustomerID = __CustomerID AND wms_inbound.tbl_receivingitems.ItemID = __ItemID

                AND LEFT(ExpiryDate, 10) = '0000-00-00' OR ExpiryDate IS NULL

                        GROUP BY ExpiryDate, wms_inbound.tbl_receivingitems.ItemID;

                        

		END IF;

END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.sp_beginning_invchiller
DELIMITER //
CREATE PROCEDURE `sp_beginning_invchiller`(IN __CustomerID INT, IN __datebackward DATE)
BEGIN
	SELECT 
		SUM(Beg_Pallet),
        SUM(Beg_Weight),
        0 AS Out_Pallet,
        0 AS Out_Weight
	FROM wms_reports.tbl_view_inv_details_inbound_chiller
	WHERE CustomerID = __CustomerID AND ReceivingDate <= __datebackward
    
    UNION ALL
    
    SELECT 
        0 AS `Beg_Weight`,
        0 AS `Beg_Pallet`,
        (SELECT 
                COUNT(DISTINCT `A`.`palletid`)
            FROM
                (((wms_outbound.`tbl_palletout` `A`
                LEFT JOIN wms_outbound.`tbl_issuances` `BB` ON ((`A`.`obd` = `BB`.`OBD`)))
                LEFT JOIN `wms_inbound`.`tbl_receivingitems` `C` ON ((`A`.`palletid` = `C`.`PalletID`)))
                LEFT JOIN `wms_cloud`.`tbl_items` `D` ON ((`C`.`ItemID` = `D`.`ItemID`)))
            WHERE
                ((`A`.`afterissuance` = 0)
                    AND (`D`.`Category` = 3)
                    AND ((`BB`.`StatusID` = 3)
                    OR (`BB`.`StatusID` = 6))
                    AND (`A`.`obd` = `b`.`OBD`))) AS `Out_Pallet`,
        SUM(`c`.`Beg_Weight`) AS `Out_Weight`
    FROM
        `wms_outbound`.`tbl_issuances` `a`
        LEFT JOIN `wms_outbound`.`tbl_issuancelist` `b` ON `a`.`OBD` = `b`.`OBD` 
        LEFT JOIN `wms_inbound`.`tbl_receivingitems` `c` ON `b`.`Receivingitemid` = `c`.`ReceivingItemID`
        LEFT JOIN `wms_inbound`.`tbl_pallets` `e` ON `c`.`PalletID` = `e`.`PalletID`
        LEFT JOIN `wms_cloud`.`tbl_items` `d` ON `b`.`itemid` = `d`.`ItemID`

    WHERE
        
            (((`a`.`StatusID` = 3)
            OR (`a`.`StatusID` = 6))
            AND (`d`.`Category` = 3)
			AND a.CustomerID = __CustomerID AND LEFT(IssuanceDate, 10) <= __datebackward)
		GROUP BY `a`.`OBD`
	;
    
END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.sp_beginning_invcontrolledtemp
DELIMITER //
CREATE PROCEDURE `sp_beginning_invcontrolledtemp`(IN __CustomerID INT, IN __datebackward DATE)
BEGIN
	SELECT 
		SUM(Beg_Pallet),
        SUM(Beg_Weight),
        0 AS Out_Pallet,
        0 AS Out_Weight
	FROM wms_reports.tbl_view_inv_details_inbound_controlledtemp
	WHERE CustomerID = __CustomerID AND ReceivingDate <= __datebackward
    
    UNION ALL
    
    SELECT 
        0 AS `Beg_Weight`,
        0 AS `Beg_Pallet`,
        (SELECT 
                COUNT(DISTINCT `A`.`palletid`)
            FROM
                (((wms_outbound.`tbl_palletout` `A`
                LEFT JOIN wms_outbound.`tbl_issuances` `BB` ON ((`A`.`obd` = `BB`.`OBD`)))
                LEFT JOIN `wms_inbound`.`tbl_receivingitems` `C` ON ((`A`.`palletid` = `C`.`PalletID`)))
                LEFT JOIN `wms_cloud`.`tbl_items` `D` ON ((`C`.`ItemID` = `D`.`ItemID`)))
            WHERE
                ((`A`.`afterissuance` = 0)
                    AND (`D`.`Category` = 4)
                    AND ((`BB`.`StatusID` = 3)
                    OR (`BB`.`StatusID` = 6))
                    AND (`A`.`obd` = `b`.`OBD`))) AS `Out_Pallet`,
        SUM(`c`.`Beg_Weight`) AS `Out_Weight`
    FROM
        `wms_outbound`.`tbl_issuances` `a`
        LEFT JOIN `wms_outbound`.`tbl_issuancelist` `b` ON `a`.`OBD` = `b`.`OBD` 
        LEFT JOIN `wms_inbound`.`tbl_receivingitems` `c` ON `b`.`Receivingitemid` = `c`.`ReceivingItemID`
        LEFT JOIN `wms_inbound`.`tbl_pallets` `e` ON `c`.`PalletID` = `e`.`PalletID`
        LEFT JOIN `wms_cloud`.`tbl_items` `d` ON `b`.`itemid` = `d`.`ItemID`

    WHERE
        
            (((`a`.`StatusID` = 3)
            OR (`a`.`StatusID` = 6))
            AND (`d`.`Category` = 4)
			AND a.CustomerID = __CustomerID AND LEFT(IssuanceDate, 10) <= __datebackward)
		GROUP BY `a`.`OBD`
	;
    
END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.sp_beginning_invfreezer
DELIMITER //
CREATE PROCEDURE `sp_beginning_invfreezer`(IN __CustomerID INT, IN __datebackward DATE)
BEGIN
	SELECT 
		SUM(Beg_Pallet),
        SUM(Beg_Weight),
        0 AS Out_Pallet,
        0 AS Out_Weight
	FROM wms_reports.tbl_view_inv_details_inbound_freezer
	WHERE CustomerID = __CustomerID AND ReceivingDate <= __datebackward
    
    UNION ALL
    
	SELECT 
        0 AS `Beg_Weight`,
        0 AS `Beg_Pallet`,
        (SELECT 
                COUNT(DISTINCT `A`.`palletid`)
            FROM
                (((wms_outbound.`tbl_palletout` `A`
                LEFT JOIN wms_outbound.`tbl_issuances` `BB` ON ((`A`.`obd` = `BB`.`OBD`)))
                LEFT JOIN `wms_inbound`.`tbl_receivingitems` `C` ON ((`A`.`palletid` = `C`.`PalletID`)))
                LEFT JOIN `wms_cloud`.`tbl_items` `D` ON ((`C`.`ItemID` = `D`.`ItemID`)))
            WHERE
                ((`A`.`afterissuance` = 0)
                    AND (`D`.`Category` = 1)
                    AND ((`BB`.`StatusID` = 3)
                    OR (`BB`.`StatusID` = 6))
                    AND (`A`.`obd` = `b`.`OBD`))) AS `Out_Pallet`,
        SUM(`c`.`Beg_Weight`) AS `Out_Weight`
    FROM
        `wms_outbound`.`tbl_issuances` `a`
        LEFT JOIN `wms_outbound`.`tbl_issuancelist` `b` ON `a`.`OBD` = `b`.`OBD` 
        LEFT JOIN `wms_inbound`.`tbl_receivingitems` `c` ON `b`.`Receivingitemid` = `c`.`ReceivingItemID`
        LEFT JOIN `wms_inbound`.`tbl_pallets` `e` ON `c`.`PalletID` = `e`.`PalletID`
        LEFT JOIN `wms_cloud`.`tbl_items` `d` ON `b`.`itemid` = `d`.`ItemID`

    WHERE
        
            (((`a`.`StatusID` = 3)
            OR (`a`.`StatusID` = 6))
            AND (`d`.`Category` = 1)
			AND a.CustomerID = __CustomerID AND LEFT(IssuanceDate, 10) <= __datebackward)
		GROUP BY `a`.`OBD`
	;
    
END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.sp_beginning_invfreezericecream
DELIMITER //
CREATE PROCEDURE `sp_beginning_invfreezericecream`(IN __CustomerID INT, IN __datebackward DATE)
BEGIN
	SELECT 
		SUM(Beg_Pallet),
        SUM(Beg_Weight),
        0 AS Out_Pallet,
        0 AS Out_Weight
	FROM wms_reports.tbl_view_inv_details_inbound_freezericecream
	WHERE CustomerID = __CustomerID AND ReceivingDate <= __datebackward
    
    UNION ALL
    
    SELECT 
        0 AS `Beg_Weight`,
        0 AS `Beg_Pallet`,
        (SELECT 
                COUNT(DISTINCT `A`.`palletid`)
            FROM
                (((wms_outbound.`tbl_palletout` `A`
                LEFT JOIN wms_outbound.`tbl_issuances` `BB` ON ((`A`.`obd` = `BB`.`OBD`)))
                LEFT JOIN `wms_inbound`.`tbl_receivingitems` `C` ON ((`A`.`palletid` = `C`.`PalletID`)))
                LEFT JOIN `wms_cloud`.`tbl_items` `D` ON ((`C`.`ItemID` = `D`.`ItemID`)))
            WHERE
                ((`A`.`afterissuance` = 0)
                    AND (`D`.`Category` = 2)
                    AND ((`BB`.`StatusID` = 3)
                    OR (`BB`.`StatusID` = 6))
                    AND (`A`.`obd` = `b`.`OBD`))) AS `Out_Pallet`,
        SUM(`c`.`Beg_Weight`) AS `Out_Weight`
    FROM
        `wms_outbound`.`tbl_issuances` `a`
        LEFT JOIN `wms_outbound`.`tbl_issuancelist` `b` ON `a`.`OBD` = `b`.`OBD` 
        LEFT JOIN `wms_inbound`.`tbl_receivingitems` `c` ON `b`.`Receivingitemid` = `c`.`ReceivingItemID`
        LEFT JOIN `wms_inbound`.`tbl_pallets` `e` ON `c`.`PalletID` = `e`.`PalletID`
        LEFT JOIN `wms_cloud`.`tbl_items` `d` ON `b`.`itemid` = `d`.`ItemID`

    WHERE
        
            (((`a`.`StatusID` = 3)
            OR (`a`.`StatusID` = 6))
            AND (`d`.`Category` = 2)
			AND a.CustomerID = __CustomerID AND LEFT(IssuanceDate, 10) <= __datebackward)
		GROUP BY `a`.`OBD`
	;
    
END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.sp_cp_palletutilization
DELIMITER //
CREATE PROCEDURE `sp_cp_palletutilization`(IN __CustomerID INT)
BEGIN
	SELECT
                        rt.type,
                        COUNT(DISTINCT ri.PalletID)
                      FROM wms_inbound.tbl_receivingitems ri
                      LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
                      LEFT JOIN wms_inbound.tbl_pallets pal on ri.PalletID = pal.PalletID
                      LEFT JOIN wms_inbound.tbl_locations loc on pal.LocationID = loc.LocationID
                      LEFT JOIN wms_inbound.tbl_room room on loc.RoomCode = room.RoomCode
                      LEFT JOIN wms_cloud.tbl_roomtypes rt on room.RoomTypeID = rt.id
                      WHERE ri.Quantity > 0 AND ri.CustomerID = __CustomerID AND (ForPutAway = 0 OR ForPutAway > 1)
                      GROUP BY rt.id;
END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_inbound_dashboard_planned
DELIMITER //
CREATE PROCEDURE `SP_inbound_dashboard_planned`(

	IN `__CustomerID` INT,

	IN `__From` DATETIME,

	IN `__To` DATETIME

)
BEGIN

	

	CREATE TEMPORARY TABLE TT_PLANNEDDATE

	(

		SELECT A.date, 0 AS counter FROM 

		(SELECT adddate('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) date FROM

		(SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t0,

		(SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t1,

		(SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t2,

		(SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t3,

		(SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t4) A

		WHERE A.date BETWEEN __From AND __To

		GROUP BY A.date

		ORDER BY A.date

	);





    SELECT A.DATE, COALESCE(SUM(Quantity),0), COALESCE(SUM(Weight),0)

    FROM TT_PLANNEDDATE A

    LEFT JOIN wms_clientportal.tbl_inbound B ON DAY(A.DATE) = DAY(B.Date_created) AND MONTH(A.DATE) = MONTH(B.Date_created) AND YEAR(A.DATE) = YEAR(B.Date_created) 

    LEFT JOIN wms_clientportal.tbl_inbounditems C ON B.CPI = C.CPI AND B.CusID = __CustomerID

    GROUP BY A.Date

    ORDER BY A.Date;

    

    DROP TABLE TT_PLANNEDDATE;

END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_inbound_dashboard_planned_by_item
DELIMITER //
CREATE PROCEDURE `SP_inbound_dashboard_planned_by_item`(

	IN `__CustomerID` INT,

	IN `__From` DATETIME,

	IN `__To` DATETIME,

	IN `__ItemID` INT

)
BEGIN

CREATE TEMPORARY TABLE TT_PLANNEDDATE

	(

SELECT A.date, 0 AS counter

FROM 

		(

SELECT ADDDATE('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) DATE

FROM

		(

SELECT 0 i UNION

SELECT 1 UNION

SELECT 2 UNION

SELECT 3 UNION

SELECT 4 UNION

SELECT 5 UNION

SELECT 6 UNION

SELECT 7 UNION

SELECT 8 UNION

SELECT 9) t0,

		(

SELECT 0 i UNION

SELECT 1 UNION

SELECT 2 UNION

SELECT 3 UNION

SELECT 4 UNION

SELECT 5 UNION

SELECT 6 UNION

SELECT 7 UNION

SELECT 8 UNION

SELECT 9) t1,

		(

SELECT 0 i UNION

SELECT 1 UNION

SELECT 2 UNION

SELECT 3 UNION

SELECT 4 UNION

SELECT 5 UNION

SELECT 6 UNION

SELECT 7 UNION

SELECT 8 UNION

SELECT 9) t2,

		(

SELECT 0 i UNION

SELECT 1 UNION

SELECT 2 UNION

SELECT 3 UNION

SELECT 4 UNION

SELECT 5 UNION

SELECT 6 UNION

SELECT 7 UNION

SELECT 8 UNION

SELECT 9) t3,

		(

SELECT 0 i UNION

SELECT 1 UNION

SELECT 2 UNION

SELECT 3 UNION

SELECT 4 UNION

SELECT 5 UNION

SELECT 6 UNION

SELECT 7 UNION

SELECT 8 UNION

SELECT 9) t4) A

WHERE A.date BETWEEN __From AND __To

GROUP BY A.date

ORDER BY A.date

	);

SELECT A.DATE, COALESCE(SUM(Quantity),0), COALESCE(SUM(Weight),0)

FROM TT_PLANNEDDATE A

LEFT JOIN wms_clientportal.tbl_inbound B ON DAY(A.DATE) = DAY(B.Date_created) AND MONTH(A.DATE) = MONTH(B.Date_created) AND YEAR(A.DATE) = YEAR(B.Date_created)

LEFT JOIN wms_clientportal.tbl_inbounditems C ON B.CPI = C.CPI AND B.CusID = __CustomerID AND C.ItemID = __ItemID

GROUP BY A.Date

ORDER BY A.Date;

DROP TABLE TT_PLANNEDDATE; END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_inbound_dashboard_received
DELIMITER //
CREATE PROCEDURE `SP_inbound_dashboard_received`(

	IN `__CustomerID` INT,

	IN `__From` DATETIME,

	IN `__To` DATETIME

)
BEGIN

CREATE TEMPORARY TABLE TT_RECEIVEDDATE

	(

SELECT A.date, 0 AS counter

FROM 

		(

SELECT ADDDATE('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) DATE

FROM

		(

SELECT 0 i UNION

SELECT 1 UNION

SELECT 2 UNION

SELECT 3 UNION

SELECT 4 UNION

SELECT 5 UNION

SELECT 6 UNION

SELECT 7 UNION

SELECT 8 UNION

SELECT 9) t0,

		(

SELECT 0 i UNION

SELECT 1 UNION

SELECT 2 UNION

SELECT 3 UNION

SELECT 4 UNION

SELECT 5 UNION

SELECT 6 UNION

SELECT 7 UNION

SELECT 8 UNION

SELECT 9) t1,

		(

SELECT 0 i UNION

SELECT 1 UNION

SELECT 2 UNION

SELECT 3 UNION

SELECT 4 UNION

SELECT 5 UNION

SELECT 6 UNION

SELECT 7 UNION

SELECT 8 UNION

SELECT 9) t2,

		(

SELECT 0 i UNION

SELECT 1 UNION

SELECT 2 UNION

SELECT 3 UNION

SELECT 4 UNION

SELECT 5 UNION

SELECT 6 UNION

SELECT 7 UNION

SELECT 8 UNION

SELECT 9) t3,

		(

SELECT 0 i UNION

SELECT 1 UNION

SELECT 2 UNION

SELECT 3 UNION

SELECT 4 UNION

SELECT 5 UNION

SELECT 6 UNION

SELECT 7 UNION

SELECT 8 UNION

SELECT 9) t4) A

WHERE A.date BETWEEN __From AND __To

GROUP BY A.date

ORDER BY A.date

	);

SELECT A.DATE, COALESCE(SUM(Beg_Quantity),0), COALESCE(SUM(Beg_Weight),0)

FROM TT_RECEIVEDDATE A

LEFT JOIN wms_inbound.tbl_receiving B ON DAY(A.DATE) = DAY(B.ReceivingDate) AND MONTH(A.DATE) = MONTH(B.ReceivingDate) AND YEAR(A.DATE) = YEAR(B.ReceivingDate)

LEFT JOIN wms_inbound.tbl_receivingitems C ON B.IBN = C.IBN AND CustomerID = __CustomerID AND B.StatusID >= 2

GROUP BY A.Date

ORDER BY A.Date;

DROP TABLE TT_RECEIVEDDATE; END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_inbound_dashboard_received_by_item
DELIMITER //
CREATE PROCEDURE `SP_inbound_dashboard_received_by_item`(

	IN `__CustomerID` INT,

	IN `__From` DATETIME,

	IN `__To` DATETIME,

	IN `__ItemID` INT

)
BEGIN

CREATE TEMPORARY TABLE TT_RECEIVEDDATE

	(

SELECT A.date, 0 AS counter

FROM 

		(

SELECT ADDDATE('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) DATE

FROM

		(

SELECT 0 i UNION

SELECT 1 UNION

SELECT 2 UNION

SELECT 3 UNION

SELECT 4 UNION

SELECT 5 UNION

SELECT 6 UNION

SELECT 7 UNION

SELECT 8 UNION

SELECT 9) t0,

		(

SELECT 0 i UNION

SELECT 1 UNION

SELECT 2 UNION

SELECT 3 UNION

SELECT 4 UNION

SELECT 5 UNION

SELECT 6 UNION

SELECT 7 UNION

SELECT 8 UNION

SELECT 9) t1,

		(

SELECT 0 i UNION

SELECT 1 UNION

SELECT 2 UNION

SELECT 3 UNION

SELECT 4 UNION

SELECT 5 UNION

SELECT 6 UNION

SELECT 7 UNION

SELECT 8 UNION

SELECT 9) t2,

		(

SELECT 0 i UNION

SELECT 1 UNION

SELECT 2 UNION

SELECT 3 UNION

SELECT 4 UNION

SELECT 5 UNION

SELECT 6 UNION

SELECT 7 UNION

SELECT 8 UNION

SELECT 9) t3,

		(

SELECT 0 i UNION

SELECT 1 UNION

SELECT 2 UNION

SELECT 3 UNION

SELECT 4 UNION

SELECT 5 UNION

SELECT 6 UNION

SELECT 7 UNION

SELECT 8 UNION

SELECT 9) t4) A

WHERE A.date BETWEEN __From AND __To

GROUP BY A.date

ORDER BY A.date

	);

SELECT A.DATE, COALESCE(SUM(Beg_Quantity),0), COALESCE(SUM(Beg_Weight),0)

FROM TT_RECEIVEDDATE A

LEFT JOIN wms_inbound.tbl_receiving B ON DAY(A.DATE) = DAY(B.ReceivingDate) AND MONTH(A.DATE) = MONTH(B.ReceivingDate) AND YEAR(A.DATE) = YEAR(B.ReceivingDate)

LEFT JOIN wms_inbound.tbl_receivingitems C ON B.IBN = C.IBN AND CustomerID = __CustomerID AND B.StatusID >= 2 AND C.ItemID = __ItemID

GROUP BY A.Date

ORDER BY A.Date;

DROP TABLE TT_RECEIVEDDATE; END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_inbtransaction_report
DELIMITER //
CREATE PROCEDURE `SP_inbtransaction_report`(IN __CustomerID INT, IN __SubFilter INT,
IN __DateFROM DATE, IN __DateTO DATE, IN __CoSubFilter VARCHAR(100))
BEGIN
	IF __CustomerID <> 0 THEN
    
		IF __SubFilter = 1 AND (__CoSubFilter <> 0 OR __CoSubFilter <> '') THEN
        
			SELECT 
				A.ReceivingDate AS ReceivingDate,
				A.IBN AS IBN,
				E.CompanyName AS CompanyName,
				SUM(CASE
					WHEN (B.QAReason = 'GOOD') THEN B.Beg_Quantity
				END) AS GOODQTY,
				SUM(CASE
					WHEN (B.QAReason <> 'GOOD') THEN B.Beg_Quantity
				END) AS HOLDQTY,
				SUM(B.Beg_Quantity) AS QTY,
				SUM(B.Beg_Weight) AS WGT,
				GROUP_CONCAT(CONCAT(C.Length,
							'x',
							C.Width,
							'x',
							C.Height)
					SEPARATOR ',') AS CBM,
				SUM(((C.Length * C.Width) * C.Height)) AS CBM2,
				COUNT(DISTINCT PalletID) AS PalletIn,
				GROUP_CONCAT(DISTINCT A.Container) AS Container,
				A.Checker AS Checker,
				(CASE
					WHEN (A.StatusID = 5) THEN 'Cancel IBN'
					WHEN
						((A.StatusID = 3)
							OR (A.StatusID = 4))
					THEN
						'Done Receiving'
					WHEN (A.StatusID = 2) THEN 'Received In Progress'
					WHEN (A.StatusID = 1) THEN 'For Receiving'
				END) AS StatusID,
				GROUP_CONCAT(DISTINCT B.QAReason) AS QAReason
			FROM
				wms_inbound.tbl_receiving A
				LEFT JOIN wms_inbound.tbl_receivingitems B ON A.IBN = B.IBN
				LEFT JOIN wms_cloud.tbl_items C ON B.ItemID = C.ItemID
				LEFT JOIN wms_cloud.tbl_itemstatus D ON B.ItemStatusID = D.ItemStatusID
				LEFT JOIN wms_cloud.tbl_customers E ON A.CusID = E.CustomerID
				LEFT JOIN wms_reports.tbl_ibnstatus F ON A.StatusID = F.status_id
			WHERE CusID = __CustomerID AND LEFT(ReceivingDate, 10) BETWEEN __DateFROM AND __DateTO
			AND A.IBN = __CoSubFilter
			GROUP BY A.IBN;

		ELSEIF __SubFilter = 2 AND (__CoSubFilter <> 0 OR __CoSubFilter <> '') THEN
        
			SELECT 
				A.ReceivingDate AS ReceivingDate,
				A.IBN AS IBN,
				E.CompanyName AS CompanyName,
				SUM(CASE
					WHEN (B.QAReason = 'GOOD') THEN B.Beg_Quantity
				END) AS GOODQTY,
				SUM(CASE
					WHEN (B.QAReason <> 'GOOD') THEN B.Beg_Quantity
				END) AS HOLDQTY,
				SUM(B.Beg_Quantity) AS QTY,
				SUM(B.Beg_Weight) AS WGT,
				GROUP_CONCAT(CONCAT(C.Length,
							'x',
							C.Width,
							'x',
							C.Height)
					SEPARATOR ',') AS CBM,
				SUM(((C.Length * C.Width) * C.Height)) AS CBM2,
				COUNT(DISTINCT PalletID) AS PalletIn,
				GROUP_CONCAT(DISTINCT A.Container) AS Container,
				A.Checker AS Checker,
				(CASE
					WHEN (A.StatusID = 5) THEN 'Cancel IBN'
					WHEN
						((A.StatusID = 3)
							OR (A.StatusID = 4))
					THEN
						'Done Receiving'
					WHEN (A.StatusID = 2) THEN 'Received In Progress'
					WHEN (A.StatusID = 1) THEN 'For Receiving'
				END) AS StatusID,
				GROUP_CONCAT(DISTINCT B.QAReason) AS QAReason
			FROM
				wms_inbound.tbl_receiving A
				LEFT JOIN wms_inbound.tbl_receivingitems B ON A.IBN = B.IBN
				LEFT JOIN wms_cloud.tbl_items C ON B.ItemID = C.ItemID
				LEFT JOIN wms_cloud.tbl_itemstatus D ON B.ItemStatusID = D.ItemStatusID
				LEFT JOIN wms_cloud.tbl_customers E ON A.CusID = E.CustomerID
				LEFT JOIN wms_reports.tbl_ibnstatus F ON A.StatusID = F.status_id
			WHERE CusID = __CustomerID AND LEFT(ReceivingDate, 10) BETWEEN __DateFROM AND __DateTO
			AND A.Container = __CoSubFilter
			GROUP BY A.IBN;

		ELSEIF __SubFilter = 3 AND (__CoSubFilter <> 0 OR __CoSubFilter <> '') THEN
        
			SELECT 
				A.ReceivingDate AS ReceivingDate,
				A.IBN AS IBN,
				E.CompanyName AS CompanyName,
				SUM(CASE
					WHEN (B.QAReason = 'GOOD') THEN B.Beg_Quantity
				END) AS GOODQTY,
				SUM(CASE
					WHEN (B.QAReason <> 'GOOD') THEN B.Beg_Quantity
				END) AS HOLDQTY,
				SUM(B.Beg_Quantity) AS QTY,
				SUM(B.Beg_Weight) AS WGT,
				GROUP_CONCAT(CONCAT(C.Length,
							'x',
							C.Width,
							'x',
							C.Height)
					SEPARATOR ',') AS CBM,
				SUM(((C.Length * C.Width) * C.Height)) AS CBM2,
				COUNT(DISTINCT PalletID) AS PalletIn,
				GROUP_CONCAT(DISTINCT A.Container) AS Container,
				A.Checker AS Checker,
				(CASE
					WHEN (A.StatusID = 5) THEN 'Cancel IBN'
					WHEN
						((A.StatusID = 3)
							OR (A.StatusID = 4))
					THEN
						'Done Receiving'
					WHEN (A.StatusID = 2) THEN 'Received In Progress'
					WHEN (A.StatusID = 1) THEN 'For Receiving'
				END) AS StatusID,
				GROUP_CONCAT(DISTINCT B.QAReason) AS QAReason
			FROM
				wms_inbound.tbl_receiving A
				LEFT JOIN wms_inbound.tbl_receivingitems B ON A.IBN = B.IBN
				LEFT JOIN wms_cloud.tbl_items C ON B.ItemID = C.ItemID
				LEFT JOIN wms_cloud.tbl_itemstatus D ON B.ItemStatusID = D.ItemStatusID
				LEFT JOIN wms_cloud.tbl_customers E ON A.CusID = E.CustomerID
				LEFT JOIN wms_reports.tbl_ibnstatus F ON A.StatusID = F.status_id
			WHERE CusID = __CustomerID AND LEFT(ReceivingDate, 10) BETWEEN __DateFROM AND __DateTO
			AND F.statusname = __CoSubFilter
			GROUP BY A.IBN;
            
		ELSE
        
			SELECT 
				A.ReceivingDate AS ReceivingDate,
				A.IBN AS IBN,
				E.CompanyName AS CompanyName,
				SUM(CASE
					WHEN (B.QAReason = 'GOOD') THEN B.Beg_Quantity
				END) AS GOODQTY,
				SUM(CASE
					WHEN (B.QAReason <> 'GOOD') THEN B.Beg_Quantity
				END) AS HOLDQTY,
				SUM(B.Beg_Quantity) AS QTY,
				SUM(B.Beg_Weight) AS WGT,
				GROUP_CONCAT(CONCAT(C.Length,
							'x',
							C.Width,
							'x',
							C.Height)
					SEPARATOR ',') AS CBM,
				SUM(((C.Length * C.Width) * C.Height)) AS CBM2,
				COUNT(DISTINCT PalletID) AS PalletIn,
				GROUP_CONCAT(DISTINCT A.Container) AS Container,
				A.Checker AS Checker,
				(CASE
					WHEN (A.StatusID = 5) THEN 'Cancel IBN'
					WHEN
						((A.StatusID = 3)
							OR (A.StatusID = 4))
					THEN
						'Done Receiving'
					WHEN (A.StatusID = 2) THEN 'Received In Progress'
					WHEN (A.StatusID = 1) THEN 'For Receiving'
				END) AS StatusID,
				GROUP_CONCAT(DISTINCT B.QAReason) AS QAReason
			FROM
				wms_inbound.tbl_receiving A
				LEFT JOIN wms_inbound.tbl_receivingitems B ON A.IBN = B.IBN
				LEFT JOIN wms_cloud.tbl_items C ON B.ItemID = C.ItemID
				LEFT JOIN wms_cloud.tbl_itemstatus D ON B.ItemStatusID = D.ItemStatusID
				LEFT JOIN wms_cloud.tbl_customers E ON A.CusID = E.CustomerID
				LEFT JOIN wms_reports.tbl_ibnstatus F ON A.StatusID = F.status_id
			WHERE CusID = __CustomerID AND LEFT(ReceivingDate, 10) BETWEEN __DateFROM AND __DateTO
			GROUP BY A.IBN;
        END IF;
        
	ELSE
    
		IF __SubFilter = 1 AND (__CoSubFilter <> 0 OR __CoSubFilter <> '') THEN
        
			SELECT 
				A.ReceivingDate AS ReceivingDate,
				A.IBN AS IBN,
				E.CompanyName AS CompanyName,
				SUM(CASE
					WHEN (B.QAReason = 'GOOD') THEN B.Beg_Quantity
				END) AS GOODQTY,
				SUM(CASE
					WHEN (B.QAReason <> 'GOOD') THEN B.Beg_Quantity
				END) AS HOLDQTY,
				SUM(B.Beg_Quantity) AS QTY,
				SUM(B.Beg_Weight) AS WGT,
				GROUP_CONCAT(CONCAT(C.Length,
							'x',
							C.Width,
							'x',
							C.Height)
					SEPARATOR ',') AS CBM,
				SUM(((C.Length * C.Width) * C.Height)) AS CBM2,
				COUNT(DISTINCT PalletID) AS PalletIn,
				GROUP_CONCAT(DISTINCT A.Container) AS Container,
				A.Checker AS Checker,
				(CASE
					WHEN (A.StatusID = 5) THEN 'Cancel IBN'
					WHEN
						((A.StatusID = 3)
							OR (A.StatusID = 4))
					THEN
						'Done Receiving'
					WHEN (A.StatusID = 2) THEN 'Received In Progress'
					WHEN (A.StatusID = 1) THEN 'For Receiving'
				END) AS StatusID,
				GROUP_CONCAT(DISTINCT B.QAReason) AS QAReason
			FROM
				wms_inbound.tbl_receiving A
				LEFT JOIN wms_inbound.tbl_receivingitems B ON A.IBN = B.IBN
				LEFT JOIN wms_cloud.tbl_items C ON B.ItemID = C.ItemID
				LEFT JOIN wms_cloud.tbl_itemstatus D ON B.ItemStatusID = D.ItemStatusID
				LEFT JOIN wms_cloud.tbl_customers E ON A.CusID = E.CustomerID
				LEFT JOIN wms_reports.tbl_ibnstatus F ON A.StatusID = F.status_id
			WHERE LEFT(ReceivingDate, 10) BETWEEN __DateFROM AND __DateTO
			AND A.IBN = __CoSubFilter
			GROUP BY A.IBN;

		ELSEIF __SubFilter = 2 AND (__CoSubFilter <> 0 OR __CoSubFilter <> '') THEN
        
			SELECT 
				A.ReceivingDate AS ReceivingDate,
				A.IBN AS IBN,
				E.CompanyName AS CompanyName,
				SUM(CASE
					WHEN (B.QAReason = 'GOOD') THEN B.Beg_Quantity
				END) AS GOODQTY,
				SUM(CASE
					WHEN (B.QAReason <> 'GOOD') THEN B.Beg_Quantity
				END) AS HOLDQTY,
				SUM(B.Beg_Quantity) AS QTY,
				SUM(B.Beg_Weight) AS WGT,
				GROUP_CONCAT(CONCAT(C.Length,
							'x',
							C.Width,
							'x',
							C.Height)
					SEPARATOR ',') AS CBM,
				SUM(((C.Length * C.Width) * C.Height)) AS CBM2,
				COUNT(DISTINCT PalletID) AS PalletIn,
				GROUP_CONCAT(DISTINCT A.Container) AS Container,
				A.Checker AS Checker,
				(CASE
					WHEN (A.StatusID = 5) THEN 'Cancel IBN'
					WHEN
						((A.StatusID = 3)
							OR (A.StatusID = 4))
					THEN
						'Done Receiving'
					WHEN (A.StatusID = 2) THEN 'Received In Progress'
					WHEN (A.StatusID = 1) THEN 'For Receiving'
				END) AS StatusID,
				GROUP_CONCAT(DISTINCT B.QAReason) AS QAReason
			FROM
				wms_inbound.tbl_receiving A
				LEFT JOIN wms_inbound.tbl_receivingitems B ON A.IBN = B.IBN
				LEFT JOIN wms_cloud.tbl_items C ON B.ItemID = C.ItemID
				LEFT JOIN wms_cloud.tbl_itemstatus D ON B.ItemStatusID = D.ItemStatusID
				LEFT JOIN wms_cloud.tbl_customers E ON A.CusID = E.CustomerID
				LEFT JOIN wms_reports.tbl_ibnstatus F ON A.StatusID = F.status_id
			WHERE LEFT(ReceivingDate, 10) BETWEEN __DateFROM AND __DateTO
			AND A.Container = __CoSubFilter
			GROUP BY A.IBN;

		ELSEIF __SubFilter = 3 AND (__CoSubFilter <> 0 OR __CoSubFilter <> '') THEN
        
			SELECT 
				A.ReceivingDate AS ReceivingDate,
				A.IBN AS IBN,
				E.CompanyName AS CompanyName,
				SUM(CASE
					WHEN (B.QAReason = 'GOOD') THEN B.Beg_Quantity
				END) AS GOODQTY,
				SUM(CASE
					WHEN (B.QAReason <> 'GOOD') THEN B.Beg_Quantity
				END) AS HOLDQTY,
				SUM(B.Beg_Quantity) AS QTY,
				SUM(B.Beg_Weight) AS WGT,
				GROUP_CONCAT(CONCAT(C.Length,
							'x',
							C.Width,
							'x',
							C.Height)
					SEPARATOR ',') AS CBM,
				SUM(((C.Length * C.Width) * C.Height)) AS CBM2,
				COUNT(DISTINCT PalletID) AS PalletIn,
				GROUP_CONCAT(DISTINCT A.Container) AS Container,
				A.Checker AS Checker,
				(CASE
					WHEN (A.StatusID = 5) THEN 'Cancel IBN'
					WHEN
						((A.StatusID = 3)
							OR (A.StatusID = 4))
					THEN
						'Done Receiving'
					WHEN (A.StatusID = 2) THEN 'Received In Progress'
					WHEN (A.StatusID = 1) THEN 'For Receiving'
				END) AS StatusID,
				GROUP_CONCAT(DISTINCT B.QAReason) AS QAReason
			FROM
				wms_inbound.tbl_receiving A
				LEFT JOIN wms_inbound.tbl_receivingitems B ON A.IBN = B.IBN
				LEFT JOIN wms_cloud.tbl_items C ON B.ItemID = C.ItemID
				LEFT JOIN wms_cloud.tbl_itemstatus D ON B.ItemStatusID = D.ItemStatusID
				LEFT JOIN wms_cloud.tbl_customers E ON A.CusID = E.CustomerID
				LEFT JOIN wms_reports.tbl_ibnstatus F ON A.StatusID = F.status_id
			WHERE LEFT(ReceivingDate, 10) BETWEEN __DateFROM AND __DateTO
			AND F.statusname = __CoSubFilter
			GROUP BY A.IBN;
            
		ELSE
        
			SELECT 
				A.ReceivingDate AS ReceivingDate,
				A.IBN AS IBN,
				E.CompanyName AS CompanyName,
				SUM(CASE
					WHEN (B.QAReason = 'GOOD') THEN B.Beg_Quantity
				END) AS GOODQTY,
				SUM(CASE
					WHEN (B.QAReason <> 'GOOD') THEN B.Beg_Quantity
				END) AS HOLDQTY,
				SUM(B.Beg_Quantity) AS QTY,
				SUM(B.Beg_Weight) AS WGT,
				GROUP_CONCAT(CONCAT(C.Length,
							'x',
							C.Width,
							'x',
							C.Height)
					SEPARATOR ',') AS CBM,
				SUM(((C.Length * C.Width) * C.Height)) AS CBM2,
				COUNT(DISTINCT PalletID) AS PalletIn,
				GROUP_CONCAT(DISTINCT A.Container) AS Container,
				A.Checker AS Checker,
				(CASE
					WHEN (A.StatusID = 5) THEN 'Cancel IBN'
					WHEN
						((A.StatusID = 3)
							OR (A.StatusID = 4))
					THEN
						'Done Receiving'
					WHEN (A.StatusID = 2) THEN 'Received In Progress'
					WHEN (A.StatusID = 1) THEN 'For Receiving'
				END) AS StatusID,
				GROUP_CONCAT(DISTINCT B.QAReason) AS QAReason
			FROM
				wms_inbound.tbl_receiving A
				LEFT JOIN wms_inbound.tbl_receivingitems B ON A.IBN = B.IBN
				LEFT JOIN wms_cloud.tbl_items C ON B.ItemID = C.ItemID
				LEFT JOIN wms_cloud.tbl_itemstatus D ON B.ItemStatusID = D.ItemStatusID
				LEFT JOIN wms_cloud.tbl_customers E ON A.CusID = E.CustomerID
				LEFT JOIN wms_reports.tbl_ibnstatus F ON A.StatusID = F.status_id
			WHERE LEFT(ReceivingDate, 10) BETWEEN __DateFROM AND __DateTO
			GROUP BY A.IBN;
        END IF;
        
    END IF;
END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_inbtransaction_reportTester
DELIMITER //
CREATE PROCEDURE `SP_inbtransaction_reportTester`(IN __CustomerID INT, IN __SubFilter INT,
IN __DateFROM DATE, IN __DateTO DATE, IN __CoSubFilter VARCHAR(100))
BEGIN
	IF __CustomerID <> 0 THEN
    
		IF __SubFilter = 1 AND __CoSubFilter <> 0 THEN
        
			SELECT 
				0,
				A.IBN AS IBN,
				E.CompanyName AS CompanyName,
				SUM(CASE
					WHEN (B.QAReason = 'GOOD') THEN B.Beg_Quantity
				END) AS GOODQTY,
				SUM(CASE
					WHEN (B.QAReason <> 'GOOD') THEN B.Beg_Quantity
				END) AS HOLDQTY,
				SUM(B.Beg_Quantity) AS QTY,
				SUM(B.Beg_Weight) AS WGT,
				GROUP_CONCAT(CONCAT(C.Length,
							'x',
							C.Width,
							'x',
							C.Height)
					SEPARATOR ',') AS CBM,
				SUM(((C.Length * C.Width) * C.Height)) AS CBM2,
				COUNT(DISTINCT PalletID) AS PalletIn,
				GROUP_CONCAT(DISTINCT A.Container) AS Container,
				A.Checker AS Checker,
				(CASE
					WHEN (A.StatusID = 5) THEN 'Cancel IBN'
					WHEN
						((A.StatusID = 3)
							OR (A.StatusID = 4))
					THEN
						'Done Receiving'
					WHEN (A.StatusID = 2) THEN 'Received In Progress'
					WHEN (A.StatusID = 1) THEN 'For Receiving'
				END) AS StatusID,
				GROUP_CONCAT(DISTINCT B.QAReason) AS QAReason
			FROM
				wms_inbound.tbl_receiving A
				LEFT JOIN wms_inbound.tbl_receivingitems B ON A.IBN = B.IBN
				LEFT JOIN wms_cloud.tbl_items C ON B.ItemID = C.ItemID
				LEFT JOIN wms_cloud.tbl_itemstatus D ON B.ItemStatusID = D.ItemStatusID
				LEFT JOIN wms_cloud.tbl_customers E ON A.CusID = E.CustomerID
				LEFT JOIN wms_reports.tbl_ibnstatus F ON A.StatusID = F.status_id
			WHERE CusID = __CustomerID AND LEFT(ReceivingDate, 10) BETWEEN __DateFROM AND __DateTO
			AND A.IBN = __CoSubFilter
			GROUP BY A.IBN;

		ELSEIF __SubFilter = 2 AND __CoSubFilter <> 0 THEN
        
			SELECT 
				1,
				A.IBN AS IBN,
				E.CompanyName AS CompanyName,
				SUM(CASE
					WHEN (B.QAReason = 'GOOD') THEN B.Beg_Quantity
				END) AS GOODQTY,
				SUM(CASE
					WHEN (B.QAReason <> 'GOOD') THEN B.Beg_Quantity
				END) AS HOLDQTY,
				SUM(B.Beg_Quantity) AS QTY,
				SUM(B.Beg_Weight) AS WGT,
				GROUP_CONCAT(CONCAT(C.Length,
							'x',
							C.Width,
							'x',
							C.Height)
					SEPARATOR ',') AS CBM,
				SUM(((C.Length * C.Width) * C.Height)) AS CBM2,
				COUNT(DISTINCT PalletID) AS PalletIn,
				GROUP_CONCAT(DISTINCT A.Container) AS Container,
				A.Checker AS Checker,
				(CASE
					WHEN (A.StatusID = 5) THEN 'Cancel IBN'
					WHEN
						((A.StatusID = 3)
							OR (A.StatusID = 4))
					THEN
						'Done Receiving'
					WHEN (A.StatusID = 2) THEN 'Received In Progress'
					WHEN (A.StatusID = 1) THEN 'For Receiving'
				END) AS StatusID,
				GROUP_CONCAT(DISTINCT B.QAReason) AS QAReason
			FROM
				wms_inbound.tbl_receiving A
				LEFT JOIN wms_inbound.tbl_receivingitems B ON A.IBN = B.IBN
				LEFT JOIN wms_cloud.tbl_items C ON B.ItemID = C.ItemID
				LEFT JOIN wms_cloud.tbl_itemstatus D ON B.ItemStatusID = D.ItemStatusID
				LEFT JOIN wms_cloud.tbl_customers E ON A.CusID = E.CustomerID
				LEFT JOIN wms_reports.tbl_ibnstatus F ON A.StatusID = F.status_id
			WHERE CusID = __CustomerID AND LEFT(ReceivingDate, 10) BETWEEN __DateFROM AND __DateTO
			AND A.Container = __CoSubFilter
			GROUP BY A.IBN;

		ELSEIF __SubFilter = 3 AND __CoSubFilter <> 0 THEN
        
			SELECT 
				2,
				A.IBN AS IBN,
				E.CompanyName AS CompanyName,
				SUM(CASE
					WHEN (B.QAReason = 'GOOD') THEN B.Beg_Quantity
				END) AS GOODQTY,
				SUM(CASE
					WHEN (B.QAReason <> 'GOOD') THEN B.Beg_Quantity
				END) AS HOLDQTY,
				SUM(B.Beg_Quantity) AS QTY,
				SUM(B.Beg_Weight) AS WGT,
				GROUP_CONCAT(CONCAT(C.Length,
							'x',
							C.Width,
							'x',
							C.Height)
					SEPARATOR ',') AS CBM,
				SUM(((C.Length * C.Width) * C.Height)) AS CBM2,
				COUNT(DISTINCT PalletID) AS PalletIn,
				GROUP_CONCAT(DISTINCT A.Container) AS Container,
				A.Checker AS Checker,
				(CASE
					WHEN (A.StatusID = 5) THEN 'Cancel IBN'
					WHEN
						((A.StatusID = 3)
							OR (A.StatusID = 4))
					THEN
						'Done Receiving'
					WHEN (A.StatusID = 2) THEN 'Received In Progress'
					WHEN (A.StatusID = 1) THEN 'For Receiving'
				END) AS StatusID,
				GROUP_CONCAT(DISTINCT B.QAReason) AS QAReason
			FROM
				wms_inbound.tbl_receiving A
				LEFT JOIN wms_inbound.tbl_receivingitems B ON A.IBN = B.IBN
				LEFT JOIN wms_cloud.tbl_items C ON B.ItemID = C.ItemID
				LEFT JOIN wms_cloud.tbl_itemstatus D ON B.ItemStatusID = D.ItemStatusID
				LEFT JOIN wms_cloud.tbl_customers E ON A.CusID = E.CustomerID
				LEFT JOIN wms_reports.tbl_ibnstatus F ON A.StatusID = F.status_id
			WHERE CusID = __CustomerID AND LEFT(ReceivingDate, 10) BETWEEN __DateFROM AND __DateTO
			AND F.statusname = __CoSubFilter
			GROUP BY A.IBN;
            
		ELSE
        
			SELECT 
				3,
				A.IBN AS IBN,
				E.CompanyName AS CompanyName,
				SUM(CASE
					WHEN (B.QAReason = 'GOOD') THEN B.Beg_Quantity
				END) AS GOODQTY,
				SUM(CASE
					WHEN (B.QAReason <> 'GOOD') THEN B.Beg_Quantity
				END) AS HOLDQTY,
				SUM(B.Beg_Quantity) AS QTY,
				SUM(B.Beg_Weight) AS WGT,
				GROUP_CONCAT(CONCAT(C.Length,
							'x',
							C.Width,
							'x',
							C.Height)
					SEPARATOR ',') AS CBM,
				SUM(((C.Length * C.Width) * C.Height)) AS CBM2,
				COUNT(DISTINCT PalletID) AS PalletIn,
				GROUP_CONCAT(DISTINCT A.Container) AS Container,
				A.Checker AS Checker,
				(CASE
					WHEN (A.StatusID = 5) THEN 'Cancel IBN'
					WHEN
						((A.StatusID = 3)
							OR (A.StatusID = 4))
					THEN
						'Done Receiving'
					WHEN (A.StatusID = 2) THEN 'Received In Progress'
					WHEN (A.StatusID = 1) THEN 'For Receiving'
				END) AS StatusID,
				GROUP_CONCAT(DISTINCT B.QAReason) AS QAReason
			FROM
				wms_inbound.tbl_receiving A
				LEFT JOIN wms_inbound.tbl_receivingitems B ON A.IBN = B.IBN
				LEFT JOIN wms_cloud.tbl_items C ON B.ItemID = C.ItemID
				LEFT JOIN wms_cloud.tbl_itemstatus D ON B.ItemStatusID = D.ItemStatusID
				LEFT JOIN wms_cloud.tbl_customers E ON A.CusID = E.CustomerID
				LEFT JOIN wms_reports.tbl_ibnstatus F ON A.StatusID = F.status_id
			WHERE CusID = __CustomerID AND LEFT(ReceivingDate, 10) BETWEEN __DateFROM AND __DateTO
			GROUP BY A.IBN;
        END IF;
        
	ELSE
    
		IF __SubFilter = 1 THEN
        
			IF __CoSubFilter <> 0 OR __CoSubFilter <> '' THEN
				SELECT 
					A.ReceivingDate AS ReceivingDate,
					A.IBN AS IBN,
					E.CompanyName AS CompanyName,
					SUM(CASE
						WHEN (B.QAReason = 'GOOD') THEN B.Beg_Quantity
					END) AS GOODQTY,
					SUM(CASE
						WHEN (B.QAReason <> 'GOOD') THEN B.Beg_Quantity
					END) AS HOLDQTY,
					SUM(B.Beg_Quantity) AS QTY,
					SUM(B.Beg_Weight) AS WGT,
					GROUP_CONCAT(CONCAT(C.Length,
								'x',
								C.Width,
								'x',
								C.Height)
						SEPARATOR ',') AS CBM,
					SUM(((C.Length * C.Width) * C.Height)) AS CBM2,
					COUNT(DISTINCT PalletID) AS PalletIn,
					GROUP_CONCAT(DISTINCT A.Container) AS Container,
					A.Checker AS Checker,
					(CASE
						WHEN (A.StatusID = 5) THEN 'Cancel IBN'
						WHEN
							((A.StatusID = 3)
								OR (A.StatusID = 4))
						THEN
							'Done Receiving'
						WHEN (A.StatusID = 2) THEN 'Received In Progress'
						WHEN (A.StatusID = 1) THEN 'For Receiving'
					END) AS StatusID,
					GROUP_CONCAT(DISTINCT B.QAReason) AS QAReason
				FROM
					wms_inbound.tbl_receiving A
					LEFT JOIN wms_inbound.tbl_receivingitems B ON A.IBN = B.IBN
					LEFT JOIN wms_cloud.tbl_items C ON B.ItemID = C.ItemID
					LEFT JOIN wms_cloud.tbl_itemstatus D ON B.ItemStatusID = D.ItemStatusID
					LEFT JOIN wms_cloud.tbl_customers E ON A.CusID = E.CustomerID
					LEFT JOIN wms_reports.tbl_ibnstatus F ON A.StatusID = F.status_id
				WHERE CusID = __CustomerID AND LEFT(ReceivingDate, 10) BETWEEN __DateFROM AND __DateTO
				AND A.IBN = __CoSubFilter
				GROUP BY A.IBN;
            ELSE
				SELECT 
					A.ReceivingDate AS ReceivingDate,
					A.IBN AS IBN,
					E.CompanyName AS CompanyName,
					SUM(CASE
						WHEN (B.QAReason = 'GOOD') THEN B.Beg_Quantity
					END) AS GOODQTY,
					SUM(CASE
						WHEN (B.QAReason <> 'GOOD') THEN B.Beg_Quantity
					END) AS HOLDQTY,
					SUM(B.Beg_Quantity) AS QTY,
					SUM(B.Beg_Weight) AS WGT,
					GROUP_CONCAT(CONCAT(C.Length,
								'x',
								C.Width,
								'x',
								C.Height)
						SEPARATOR ',') AS CBM,
					SUM(((C.Length * C.Width) * C.Height)) AS CBM2,
					COUNT(DISTINCT PalletID) AS PalletIn,
					GROUP_CONCAT(DISTINCT A.Container) AS Container,
					A.Checker AS Checker,
					(CASE
						WHEN (A.StatusID = 5) THEN 'Cancel IBN'
						WHEN
							((A.StatusID = 3)
								OR (A.StatusID = 4))
						THEN
							'Done Receiving'
						WHEN (A.StatusID = 2) THEN 'Received In Progress'
						WHEN (A.StatusID = 1) THEN 'For Receiving'
					END) AS StatusID,
					GROUP_CONCAT(DISTINCT B.QAReason) AS QAReason
				FROM
					wms_inbound.tbl_receiving A
					LEFT JOIN wms_inbound.tbl_receivingitems B ON A.IBN = B.IBN
					LEFT JOIN wms_cloud.tbl_items C ON B.ItemID = C.ItemID
					LEFT JOIN wms_cloud.tbl_itemstatus D ON B.ItemStatusID = D.ItemStatusID
					LEFT JOIN wms_cloud.tbl_customers E ON A.CusID = E.CustomerID
					LEFT JOIN wms_reports.tbl_ibnstatus F ON A.StatusID = F.status_id
				WHERE CusID = __CustomerID AND LEFT(ReceivingDate, 10) BETWEEN __DateFROM AND __DateTO
				GROUP BY A.IBN;
            END IF;

		ELSEIF __SubFilter = 2 AND __CoSubFilter <> 0 THEN
        
			SELECT 
				11,
				A.IBN AS IBN,
				E.CompanyName AS CompanyName,
				SUM(CASE
					WHEN (B.QAReason = 'GOOD') THEN B.Beg_Quantity
				END) AS GOODQTY,
				SUM(CASE
					WHEN (B.QAReason <> 'GOOD') THEN B.Beg_Quantity
				END) AS HOLDQTY,
				SUM(B.Beg_Quantity) AS QTY,
				SUM(B.Beg_Weight) AS WGT,
				GROUP_CONCAT(CONCAT(C.Length,
							'x',
							C.Width,
							'x',
							C.Height)
					SEPARATOR ',') AS CBM,
				SUM(((C.Length * C.Width) * C.Height)) AS CBM2,
				COUNT(DISTINCT PalletID) AS PalletIn,
				GROUP_CONCAT(DISTINCT A.Container) AS Container,
				A.Checker AS Checker,
				(CASE
					WHEN (A.StatusID = 5) THEN 'Cancel IBN'
					WHEN
						((A.StatusID = 3)
							OR (A.StatusID = 4))
					THEN
						'Done Receiving'
					WHEN (A.StatusID = 2) THEN 'Received In Progress'
					WHEN (A.StatusID = 1) THEN 'For Receiving'
				END) AS StatusID,
				GROUP_CONCAT(DISTINCT B.QAReason) AS QAReason
			FROM
				wms_inbound.tbl_receiving A
				LEFT JOIN wms_inbound.tbl_receivingitems B ON A.IBN = B.IBN
				LEFT JOIN wms_cloud.tbl_items C ON B.ItemID = C.ItemID
				LEFT JOIN wms_cloud.tbl_itemstatus D ON B.ItemStatusID = D.ItemStatusID
				LEFT JOIN wms_cloud.tbl_customers E ON A.CusID = E.CustomerID
				LEFT JOIN wms_reports.tbl_ibnstatus F ON A.StatusID = F.status_id
			WHERE LEFT(ReceivingDate, 10) BETWEEN __DateFROM AND __DateTO
			AND A.Container = __CoSubFilter
			GROUP BY A.IBN;

		ELSEIF __SubFilter = 3 AND __CoSubFilter <> 0 THEN
        
			SELECT 
				21,
				A.IBN AS IBN,
				E.CompanyName AS CompanyName,
				SUM(CASE
					WHEN (B.QAReason = 'GOOD') THEN B.Beg_Quantity
				END) AS GOODQTY,
				SUM(CASE
					WHEN (B.QAReason <> 'GOOD') THEN B.Beg_Quantity
				END) AS HOLDQTY,
				SUM(B.Beg_Quantity) AS QTY,
				SUM(B.Beg_Weight) AS WGT,
				GROUP_CONCAT(CONCAT(C.Length,
							'x',
							C.Width,
							'x',
							C.Height)
					SEPARATOR ',') AS CBM,
				SUM(((C.Length * C.Width) * C.Height)) AS CBM2,
				COUNT(DISTINCT PalletID) AS PalletIn,
				GROUP_CONCAT(DISTINCT A.Container) AS Container,
				A.Checker AS Checker,
				(CASE
					WHEN (A.StatusID = 5) THEN 'Cancel IBN'
					WHEN
						((A.StatusID = 3)
							OR (A.StatusID = 4))
					THEN
						'Done Receiving'
					WHEN (A.StatusID = 2) THEN 'Received In Progress'
					WHEN (A.StatusID = 1) THEN 'For Receiving'
				END) AS StatusID,
				GROUP_CONCAT(DISTINCT B.QAReason) AS QAReason
			FROM
				wms_inbound.tbl_receiving A
				LEFT JOIN wms_inbound.tbl_receivingitems B ON A.IBN = B.IBN
				LEFT JOIN wms_cloud.tbl_items C ON B.ItemID = C.ItemID
				LEFT JOIN wms_cloud.tbl_itemstatus D ON B.ItemStatusID = D.ItemStatusID
				LEFT JOIN wms_cloud.tbl_customers E ON A.CusID = E.CustomerID
				LEFT JOIN wms_reports.tbl_ibnstatus F ON A.StatusID = F.status_id
			WHERE LEFT(ReceivingDate, 10) BETWEEN __DateFROM AND __DateTO
			AND F.statusname = __CoSubFilter
			GROUP BY A.IBN;
            
		ELSE
        
			SELECT 
				31,
				A.IBN AS IBN,
				E.CompanyName AS CompanyName,
				SUM(CASE
					WHEN (B.QAReason = 'GOOD') THEN B.Beg_Quantity
				END) AS GOODQTY,
				SUM(CASE
					WHEN (B.QAReason <> 'GOOD') THEN B.Beg_Quantity
				END) AS HOLDQTY,
				SUM(B.Beg_Quantity) AS QTY,
				SUM(B.Beg_Weight) AS WGT,
				GROUP_CONCAT(CONCAT(C.Length,
							'x',
							C.Width,
							'x',
							C.Height)
					SEPARATOR ',') AS CBM,
				SUM(((C.Length * C.Width) * C.Height)) AS CBM2,
				COUNT(DISTINCT PalletID) AS PalletIn,
				GROUP_CONCAT(DISTINCT A.Container) AS Container,
				A.Checker AS Checker,
				(CASE
					WHEN (A.StatusID = 5) THEN 'Cancel IBN'
					WHEN
						((A.StatusID = 3)
							OR (A.StatusID = 4))
					THEN
						'Done Receiving'
					WHEN (A.StatusID = 2) THEN 'Received In Progress'
					WHEN (A.StatusID = 1) THEN 'For Receiving'
				END) AS StatusID,
				GROUP_CONCAT(DISTINCT B.QAReason) AS QAReason
			FROM
				wms_inbound.tbl_receiving A
				LEFT JOIN wms_inbound.tbl_receivingitems B ON A.IBN = B.IBN
				LEFT JOIN wms_cloud.tbl_items C ON B.ItemID = C.ItemID
				LEFT JOIN wms_cloud.tbl_itemstatus D ON B.ItemStatusID = D.ItemStatusID
				LEFT JOIN wms_cloud.tbl_customers E ON A.CusID = E.CustomerID
				LEFT JOIN wms_reports.tbl_ibnstatus F ON A.StatusID = F.status_id
			WHERE LEFT(ReceivingDate, 10) BETWEEN __DateFROM AND __DateTO
			GROUP BY A.IBN;
        END IF;
        
    END IF;
END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_INVENTORYMASTERLIST
DELIMITER //
CREATE PROCEDURE `SP_INVENTORYMASTERLIST`(

	IN `__datebackward` VARCHAR(100),

	IN `__datefrom` VARCHAR(100),

	IN `__dateto` VARCHAR(100)

)
BEGIN

SELECT 

 CompanyName, SUM(CASE WHEN r.ReceivingDate BETWEEN '2000-01-01' AND __datebackward THEN ri.Beg_Weight END) AS BW, COUNT(DISTINCT(CASE WHEN r.ReceivingDate BETWEEN '2000-01-01' AND __datebackward THEN PalletID END)) AS BP, SUM(CASE WHEN r.ReceivingDate BETWEEN __datefrom AND __dateto THEN ri.Beg_Weight END) AS IW, COUNT(DISTINCT(CASE WHEN r.ReceivingDate BETWEEN __datefrom AND __dateto THEN PalletID END)) AS IP,



 (

SELECT IFNULL(SUM(Weight), 0)

FROM wms_outbound.tbl_actualpick ap

LEFT JOIN wms_outbound.tbl_picklist pl ON ap.PicklistID = pl.id

LEFT JOIN wms_outbound.tbl_issuancelist il ON pl.id = il.PicklistID

LEFT JOIN wms_outbound.tbl_issuances i ON il.OBD = i.OBD

WHERE i.CustomerID = cus.CustomerID AND i.IssuanceDate BETWEEN __datefrom AND __dateto) AS Weight,



 (

SELECT IFNULL(SUM(PalletOut), 0)

FROM wms_outbound.tbl_picklist pl

LEFT JOIN wms_outbound.tbl_issuancelist il ON pl.id = il.PicklistID

LEFT JOIN wms_outbound.tbl_issuances i ON il.OBD = i.OBD

WHERE i.CustomerID = cus.CustomerID AND i.IssuanceDate BETWEEN __datefrom AND __dateto) AS Outbound,

 

 (

SELECT IFNULL(SUM(Weight), 0)

FROM wms_outbound.tbl_actualpick ap

LEFT JOIN wms_outbound.tbl_picklist pl ON ap.PicklistID = pl.id

LEFT JOIN wms_outbound.tbl_issuancelist il ON pl.id = il.PicklistID

LEFT JOIN wms_outbound.tbl_issuances i ON il.OBD = i.OBD

WHERE i.CustomerID = cus.CustomerID AND i.IssuanceDate BETWEEN '2000-01-01' AND __datebackward) AS Weight,



 (

SELECT IFNULL(SUM(PalletOut), 0)

FROM wms_outbound.tbl_picklist pl

LEFT JOIN wms_outbound.tbl_issuancelist il ON pl.id = il.PicklistID

LEFT JOIN wms_outbound.tbl_issuances i ON il.OBD = i.OBD

WHERE i.CustomerID = cus.CustomerID AND i.IssuanceDate BETWEEN '2000-01-01' AND __datebackward) AS Outbound,

 

 cus.CustomerID

FROM wms_cloud.tbl_customers cus

LEFT JOIN wms_inbound.tbl_receiving r ON cus.CustomerID = r.CusID

LEFT JOIN wms_inbound.tbl_receivingitems ri ON r.IBN = ri.IBN

WHERE Checked = 'TRUE'

GROUP BY cus.CustomerID; END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_INVENTORYMASTERLIST_ALLCUTOFF
DELIMITER //
CREATE PROCEDURE `SP_INVENTORYMASTERLIST_ALLCUTOFF`(

	IN `__CustomerID` INT,

	IN `__date` VARCHAR(100)

)
BEGIN

SELECT 

									ReceivingDate AS ReceivingDate,

									ri.IBN, SUM(Beg_Weight) AS Beg_Weight, COUNT(DISTINCT PalletID) AS PalletID

FROM wms_inbound.tbl_receivingitems ri

LEFT JOIN wms_inbound.tbl_receiving r ON ri.IBN = r.IBN

LEFT JOIN wms_cloud.tbl_items item ON ri.ItemID = item.ItemID

LEFT JOIN wms_cloud.tbl_categories cat ON item.Category = cat.ItemCategoryID

WHERE ri.CustomerID = __CustomerID AND

LEFT(`ReceivingDate`, 10) = __date AND Checked = 'TRUE'

GROUP BY ri.IBN; END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_INVENTORYMASTERLIST_BY_CUSTOMER
DELIMITER //
CREATE PROCEDURE `SP_INVENTORYMASTERLIST_BY_CUSTOMER`(IN __CustomerID INT, IN __datebackward DATETIME, IN __datefrom DATETIME, IN __dateto DATETIME)
BEGIN

					SELECT  

                        CompanyName,

                        SUM( case when LEFT(C.ReceivingDate, 10) between '2000-01-01' AND __datebackward then B.Beg_Weight end) as BW,



                        COUNT(distinct(case when LEFT(C.ReceivingDate, 10) between  '2000-01-01' AND __datebackward then PalletID end)) as BP,



                        IFNULL(SUM( case when LEFT(C.ReceivingDate, 10) between  __datefrom AND __dateto then B.Beg_Weight end), 0) as IW,



                        COUNT(distinct(case when LEFT(C.ReceivingDate, 10) between __datefrom AND __dateto then PalletID end)) as IP,



						(SELECT

							SUM(Beg_Weight) AS Out_Weight

						FROM wms_outbound.tbl_issuances A

						LEFT JOIN wms_outbound.tbl_issuancelist B ON A.OBD = B.OBD

						LEFT JOIN wms_inbound.tbl_receivingitems C ON B.ReceivingItemID = C.ReceivingItemID

						WHERE (A.StatusID = 3 OR A.StatusID = 6) AND LEFT(IssuanceDate, 10) 

                        BETWEEN __datefrom AND __dateto AND A.CustomerID = __CustomerID

						) AS Weight,



                        (SELECT

							COUNT(A.obd) 

						FROM wms_outbound.tbl_palletout A

						LEFT JOIN wms_outbound.tbl_issuances B ON A.OBD = B.OBD

						WHERE afterissuance = 0 AND (B.StatusID = 3 OR B.StatusID = 6) 

                        AND LEFT(IssuanceDate, 10) BETWEEN __datefrom AND __dateto AND B.CustomerID = __CustomerID) AS Outbound,

                        

                        (SELECT
                            SUM(Beg_Weight) AS Out_Weight
                        FROM wms_outbound.tbl_issuances A
                        LEFT JOIN wms_outbound.tbl_issuancelist B ON A.OBD = B.OBD
                        LEFT JOIN wms_inbound.tbl_receivingitems C ON B.ReceivingItemID = C.ReceivingItemID
                        WHERE (A.StatusID = 3 OR A.StatusID = 6) AND LEFT(IssuanceDate, 10) BETWEEN '2000-01-01' AND __datebackward AND A.CustomerID = __CustomerID
                        ) AS Weight,

                        (SELECT
                            COUNT(A.palletid) 
                        FROM wms_outbound.tbl_palletout A
                        LEFT JOIN wms_outbound.tbl_issuances B ON A.OBD = B.OBD
                        WHERE afterissuance = 0 AND (B.StatusID = 3 OR B.StatusID = 6) 
                        AND LEFT(IssuanceDate, 10) BETWEEN '2000-01-01' AND __datebackward AND B.CustomerID = __CustomerID) AS Outbound,

                        A.CustomerID,
						
                        (SELECT 
							COUNT(DISTINCT FromPallet)
						  FROM wms_warehouse.tbl_itemtransfers A
                          LEFT JOIN wms_warehouse.tbl_ithistory B ON A.IT = B.IT
                          WHERE B.CustomerID = __CustomerID AND LEFT(EndDate, 10) BETWEEN '2000-01-01' AND __datebackward
                          AND isdeleted <> 1 AND new_qty = 0
                        ) AS InITBackPal,
                        
                        
                        (SELECT 
							IFNULL(SUM(weight), 0)
						  FROM wms_warehouse.tbl_itemtransfers A
                          LEFT JOIN wms_warehouse.tbl_ithistory B ON A.IT = B.IT
                          WHERE B.CustomerID = __CustomerID AND LEFT(EndDate, 10) BETWEEN '2000-01-01' AND __datebackward
                          AND isdeleted <> 1
                        ) AS InITBackWgt,
                        
                        
                        (SELECT 
							COUNT(DISTINCT FromPallet)
						  FROM wms_warehouse.tbl_itemtransfers A
                          LEFT JOIN wms_warehouse.tbl_ithistory B ON A.IT = B.IT
                          WHERE B.CustomerID = __CustomerID AND LEFT(EndDate, 10) BETWEEN __datefrom AND __dateto
                          AND isdeleted <> 1 AND new_qty = 0
                        ) AS InITToPal,
                        
                        
                        (SELECT 
							IFNULL(SUM(weight), 0)
						  FROM wms_warehouse.tbl_itemtransfers A
                          LEFT JOIN wms_warehouse.tbl_ithistory B ON A.IT = B.IT
                          WHERE B.CustomerID = __CustomerID AND LEFT(EndDate, 10) BETWEEN __datefrom AND __dateto
                          AND isdeleted <> 1
                        ) AS InITToWgt
                        
                        FROM wms_cloud.tbl_customers A
                        LEFT JOIN wms_inbound.tbl_receivingitems B ON A.CustomerID = B.CustomerID
                        LEFT JOIN wms_inbound.tbl_receiving C ON B.IBN = C.IBN
                        AND C.StatusID != 5 AND Checked = 'TRUE' AND (ForPutaway = 0 OR ForPutaway >= 2) WHERE A.CustomerID = __CustomerID
						GROUP BY A.CustomerID;

END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_INVENTORYMASTERLIST_BY_NOCUSTOMER
DELIMITER //
CREATE PROCEDURE `SP_INVENTORYMASTERLIST_BY_NOCUSTOMER`(IN __CustomerID INT, IN __datebackward DATETIME, IN __datefrom DATETIME, IN __dateto DATETIME)
BEGIN				



					DECLARE __CusID VARCHAR(250);

                    

                    SET __CusID = (SELECT GROUP_CONCAT(DISTINCT CustomerID) FROM wms_inbound.tbl_receivingitems);

                    

					SELECT  

                        CompanyName,

                        SUM( case when LEFT(r.ReceivingDate, 10) between '2000-01-01' AND __datebackward then ri.Beg_Weight end) as BW,



                        COUNT(distinct(case when LEFT(r.ReceivingDate, 10) between  '2000-01-01' AND __datebackward then PalletID end)) as BP,



                        SUM( case when LEFT(r.ReceivingDate, 10) between  __datefrom AND __dateto then ri.Beg_Weight end) as IW,



                        COUNT(distinct(case when LEFT(r.ReceivingDate, 10) between __datefrom AND __dateto then PalletID end)) as IP,



						(SELECT

							SUM(Beg_Weight) AS Out_Weight

						FROM wms_outbound.tbl_issuances A

						LEFT JOIN wms_outbound.tbl_issuancelist B ON A.OBD = B.OBD

						LEFT JOIN wms_inbound.tbl_receivingitems C ON B.ReceivingItemID = C.ReceivingItemID

						LEFT JOIN wms_outbound.tbl_palletout D ON A.OBD = D.OBD

						WHERE (A.StatusID = 3 OR A.StatusID = 6) AND LEFT(IssuanceDate, 10) 

                        BETWEEN __datefrom AND __dateto AND A.CustomerID = cus.CustomerID

						) AS Weight,



                        (SELECT

							COUNT(A.obd) 

						FROM wms_outbound.tbl_palletout A

						LEFT JOIN wms_outbound.tbl_issuances B ON A.OBD = B.OBD

						WHERE afterissuance = 0 AND (B.StatusID = 3 OR B.StatusID = 6) 

                        AND LEFT(IssuanceDate, 10) BETWEEN __datefrom AND __dateto 

                        ) AS Outbound,

                        

                        (SELECT

							SUM(Beg_Weight) AS Out_Weight

						FROM wms_outbound.tbl_issuances A

						LEFT JOIN wms_outbound.tbl_issuancelist B ON A.OBD = B.OBD

						LEFT JOIN wms_inbound.tbl_receivingitems C ON B.ReceivingItemID = C.ReceivingItemID

						LEFT JOIN wms_outbound.tbl_palletout D ON A.OBD = D.OBD

						WHERE (A.StatusID = 3 OR A.StatusID = 6) AND LEFT(IssuanceDate, 10) 

                        BETWEEN '2000-01-01' AND __datebackward 

						) AS Weight,



                        (SELECT

							COUNT(A.obd) 

						FROM wms_outbound.tbl_palletout A

						LEFT JOIN wms_outbound.tbl_issuances B ON A.OBD = B.OBD

						WHERE afterissuance = 0 AND (B.StatusID = 3 OR B.StatusID = 6) 

                        AND LEFT(IssuanceDate, 10) BETWEEN '2000-01-01' AND __datebackward

                        ) AS Outbound,

                        

                        cus.CustomerID

                        FROM wms_cloud.tbl_customers cus

                        LEFT JOIN wms_inbound.tbl_receiving r ON cus.CustomerID = r.CusID

                        LEFT JOIN wms_inbound.tbl_receivingitems ri ON r.IBN = ri.IBN

                        WHERE Checked = 'TRUE' AND r.StatusID = 3 GROUP BY cus.CustomerID;

END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_Inventory_Details_ByChiller
DELIMITER //
CREATE PROCEDURE `SP_Inventory_Details_ByChiller`(IN __CustomerID INT,  IN __DateFrom DATETIME, IN __DateTo DATETIME)
BEGIN
	create temporary table wms_reports.TT_INBOUNDDATE_INV_CHILLER
	(
		select A.date from 
		(select adddate('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) date from
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) A
		where A.date between __DateFrom and __DateTo
		group by A.date
		order by A.date
	);
    
    
    create temporary table wms_reports.TT_IT_INV_CHILLER
	(
		select A.date from 
		(select adddate('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) date from
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) A
		where A.date between __DateFrom and __DateTo
		group by A.date
		order by A.date
	);
    
    create temporary table wms_reports.TT_OUTBOUNDDATE_INV_CHILLER
	(
		select A.date from 
		(select adddate('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) date from
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) A
		where A.date between __DateFrom and __DateTo
		group by A.date
		order by A.date
	);
    
    
    create temporary table wms_reports.tbl_sp_details_inbound_chiller(
			SELECT 
        LEFT(`a`.`ReceivingDate`, 10) AS `ReceivingDate`,
        `a`.`IBN` AS `ControlNumber`,
        SUM(`b`.`Beg_Weight`) AS `Beg_Weight`,
        0 AS `Out_Weight`,
        COUNT(DISTINCT `b`.`PalletID`) AS `Beg_Pallet`,
        0 AS `Out_Pallet`,
        `b`.`CustomerID` AS `CustomerID`,
        `b`.`PalletID` AS `PalletID`
    FROM
        ((`wms_inbound`.`tbl_receiving` `a`
        LEFT JOIN `wms_inbound`.`tbl_receivingitems` `b` ON ((`a`.`IBN` = `b`.`IBN`)))
        LEFT JOIN `wms_cloud`.`tbl_items` `c` ON ((`b`.`ItemID` = `c`.`ItemID`)))
    WHERE
        ((`a`.`StatusID` <> 5)
            AND (`b`.`Checked` = 'TRUE')
            AND ((`b`.`ForPutaway` = 0)
            OR (`b`.`ForPutaway` >= 2))
            AND (`c`.`Category` = 3)
            AND CustomerID =  __CustomerID
            AND (LEFT(`a`.`ReceivingDate`, 10) BETWEEN __DateFrom and __DateTo)
            )
    GROUP BY `b`.`PalletID`
    );
    
    create temporary table wms_reports.tbl_sp_details_outbound_chiller(
			SELECT 
			LEFT(`a`.`IssuanceDate`, 10) AS `ReceivingDate`,
			`a`.`OBD` AS `ControlNumber`,
			0 AS `Beg_Weight`,
			SUM(`c`.`Beg_Weight`) AS `Out_Weight`,
			0 AS `Beg_Pallet`,
			(SELECT 
					COUNT(DISTINCT `A`.`palletid`)
				FROM
					(((wms_outbound.`tbl_palletout` `A`
					LEFT JOIN wms_outbound.`tbl_issuances` `BB` ON ((`A`.`obd` = `BB`.`OBD`)))
					LEFT JOIN `wms_inbound`.`tbl_receivingitems` `C` ON ((`A`.`palletid` = `C`.`PalletID`)))
					LEFT JOIN `wms_cloud`.`tbl_items` `D` ON ((`C`.`ItemID` = `D`.`ItemID`)))
				WHERE
					((`A`.`afterissuance` = 0)
						AND (`D`.`Category` = 3)
						AND ((`BB`.`StatusID` = 3)
						OR (`BB`.`StatusID` = 6))
						AND (`A`.`obd` = `b`.`OBD`))) AS `Out_Pallet`,
			`a`.`CustomerID` AS `CustomerID`
		FROM
			((((wms_outbound.`tbl_issuances` `a`
			LEFT JOIN wms_outbound.`tbl_issuancelist` `b` ON ((`a`.`OBD` = `b`.`OBD`)))
			LEFT JOIN `wms_inbound`.`tbl_receivingitems` `c` ON ((`b`.`Receivingitemid` = `c`.`ReceivingItemID`)))
			LEFT JOIN `wms_inbound`.`tbl_pallets` `e` ON ((`c`.`PalletID` = `e`.`PalletID`)))
			LEFT JOIN `wms_cloud`.`tbl_items` `d` ON ((`b`.`itemid` = `d`.`ItemID`)))
		WHERE
			(((`a`.`StatusID` = 3)
            OR (`a`.`StatusID` = 6))
            AND (LEFT(`a`.`IssuanceDate`, 10) BETWEEN __DateFrom and __DateTo)
            AND (`d`.`Category` = 3)
            AND a.CustomerID = __CustomerID)
		GROUP BY `a`.`OBD`
    );
SELECT
*
FROM
(

SELECT
		A.Date,
		B.ControlNumber,
		SUM(Beg_Weight) AS Beg_Weight,
		0 AS Out_Weight,
		SUM(Beg_Pallet) AS Beg_Pallet,
		0 AS Out_Pallet
	FROM wms_reports.TT_INBOUNDDATE_INV_CHILLER A
	LEFT JOIN wms_reports.tbl_sp_details_inbound_chiller B ON DAY(A.DATE) = DAY(B.ReceivingDate) AND 
    MONTH(A.DATE) = MONTH(B.ReceivingDate) AND YEAR(A.DATE) = YEAR(B.ReceivingDate) AND CustomerID = __CustomerID
	GROUP BY B.ControlNumber, A.Date
    
UNION ALL

SELECT
		AA.Date,
		B.ControlNumber,
		0,
		SUM(Out_Weight) AS Out_Weight,
		0 AS Beg_Pallet,
		IFNULL(Out_Pallet, 0) AS Out_Pallet
	FROM wms_reports.TT_OUTBOUNDDATE_INV_CHILLER AA
	LEFT JOIN wms_reports.tbl_sp_details_outbound_chiller B ON DAY(AA.DATE) = DAY(B.ReceivingDate) AND 
    MONTH(AA.DATE) = MONTH(B.ReceivingDate) AND YEAR(AA.DATE) = YEAR(B.ReceivingDate) AND CustomerID = __CustomerID
    WHERE B.ControlNumber IS NOT NULL
    GROUP BY B.ControlNumber, AA.Date
    
UNION ALL

	SELECT
		AAA.Date,
		B.IT,
		0,
		0,
		0 AS Beg_Pallet,
		COUNT(DISTINCT FromPallet) AS Out_Pallet
	FROM wms_reports.TT_IT_INV_CHILLER AAA
    LEFT JOIN wms_warehouse.tbl_ithistory B ON DAY(AAA.DATE) = DAY(B.EndDate) AND 
    MONTH(AAA.DATE) = MONTH(B.EndDate) AND YEAR(AAA.DATE) = YEAR(B.EndDate) AND CustomerID = __CustomerID
    LEFT JOIN wms_warehouse.tbl_itemtransfers C ON C.IT = B.IT
    LEFT JOIN wms_inbound.tbl_receivingitems D ON C.FromPallet = D.PalletID
    LEFT JOIN wms_cloud.tbl_items E ON D.ItemID = E.ItemID
    WHERE B.IT IS NOT NULL AND Category = 3 AND new_qty = 0
    GROUP BY B.IT, AAA.Date

) AS G

ORDER BY Date;
    
    DROP TABLE wms_reports.TT_INBOUNDDATE_INV_CHILLER;
    DROP TABLE wms_reports.TT_OUTBOUNDDATE_INV_CHILLER;
    DROP TABLE wms_reports.TT_IT_INV_CHILLER;
    DROP TABLE wms_reports.tbl_sp_details_outbound_chiller;
    DROP TABLE wms_reports.tbl_sp_details_inbound_chiller;
    
END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_Inventory_Details_ByControlledTemp
DELIMITER //
CREATE PROCEDURE `SP_Inventory_Details_ByControlledTemp`(IN __CustomerID INT,  IN __DateFrom DATETIME, IN __DateTo DATETIME)
BEGIN

	create temporary table wms_reports.TT_INBOUNDDATE_INV_CONTROLLEDTEMP

	(

		select A.date from 

		(select adddate('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) date from

		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0,

		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1,

		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2,

		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3,

		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) A

		where A.date between __DateFrom and __DateTo

		group by A.date

		order by A.date

	);

    
	create temporary table wms_reports.TT_IT_INV_CONTROLLEDTEMP
	(
		select A.date from 
		(select adddate('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) date from
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) A
		where A.date between __DateFrom and __DateTo
		group by A.date
		order by A.date
	);
    

    create temporary table wms_reports.TT_OUTBOUNDDATE_INV_CONTROLLEDTEMP

	(

		select A.date from 

		(select adddate('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) date from

		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0,

		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1,

		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2,

		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3,

		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) A

		where A.date between __DateFrom and __DateTo

		group by A.date

		order by A.date

	);
	
    create temporary table wms_reports.tbl_sp_details_inbound_controlledtemp(
			SELECT 
        LEFT(`a`.`ReceivingDate`, 10) AS `ReceivingDate`,
        `a`.`IBN` AS `ControlNumber`,
        SUM(`b`.`Beg_Weight`) AS `Beg_Weight`,
        0 AS `Out_Weight`,
        COUNT(DISTINCT `b`.`PalletID`) AS `Beg_Pallet`,
        0 AS `Out_Pallet`,
        `b`.`CustomerID` AS `CustomerID`,
        `b`.`PalletID` AS `PalletID`
    FROM
        ((`wms_inbound`.`tbl_receiving` `a`
        LEFT JOIN `wms_inbound`.`tbl_receivingitems` `b` ON ((`a`.`IBN` = `b`.`IBN`)))
        LEFT JOIN `wms_cloud`.`tbl_items` `c` ON ((`b`.`ItemID` = `c`.`ItemID`)))
    WHERE
        ((`a`.`StatusID` <> 5)
            AND (`b`.`Checked` = 'TRUE')
            AND ((`b`.`ForPutaway` = 0)
            OR (`b`.`ForPutaway` >= 2))
            AND (`c`.`Category` = 4)
            AND CustomerID =  __CustomerID
            AND (LEFT(`a`.`ReceivingDate`, 10) BETWEEN __DateFrom and __DateTo)
            )
    GROUP BY `b`.`PalletID`
    );
    
    create temporary table wms_reports.tbl_sp_details_outbound_controlledtemp(
			SELECT 
			LEFT(`a`.`IssuanceDate`, 10) AS `ReceivingDate`,
			`a`.`OBD` AS `ControlNumber`,
			0 AS `Beg_Weight`,
			SUM(`c`.`Beg_Weight`) AS `Out_Weight`,
			0 AS `Beg_Pallet`,
			(SELECT 
					COUNT(DISTINCT `A`.`palletid`)
				FROM
					(((wms_outbound.`tbl_palletout` `A`
					LEFT JOIN wms_outbound.`tbl_issuances` `BB` ON ((`A`.`obd` = `BB`.`OBD`)))
					LEFT JOIN `wms_inbound`.`tbl_receivingitems` `C` ON ((`A`.`palletid` = `C`.`PalletID`)))
					LEFT JOIN `wms_cloud`.`tbl_items` `D` ON ((`C`.`ItemID` = `D`.`ItemID`)))
				WHERE
					((`A`.`afterissuance` = 0)
						AND (`D`.`Category` = 4)
						AND ((`BB`.`StatusID` = 3)
						OR (`BB`.`StatusID` = 6))
						AND (`A`.`obd` = `b`.`OBD`))) AS `Out_Pallet`,
			`a`.`CustomerID` AS `CustomerID`
		FROM
			((((wms_outbound.`tbl_issuances` `a`
			LEFT JOIN wms_outbound.`tbl_issuancelist` `b` ON ((`a`.`OBD` = `b`.`OBD`)))
			LEFT JOIN `wms_inbound`.`tbl_receivingitems` `c` ON ((`b`.`Receivingitemid` = `c`.`ReceivingItemID`)))
			LEFT JOIN `wms_inbound`.`tbl_pallets` `e` ON ((`c`.`PalletID` = `e`.`PalletID`)))
			LEFT JOIN `wms_cloud`.`tbl_items` `d` ON ((`b`.`itemid` = `d`.`ItemID`)))
		WHERE
			(((`a`.`StatusID` = 3)
            OR (`a`.`StatusID` = 6))
            AND (LEFT(`a`.`IssuanceDate`, 10) BETWEEN __DateFrom and __DateTo)
            AND (`d`.`Category` = 4)
            AND a.CustomerID = __CustomerID)
		GROUP BY `a`.`OBD`
    );
   

SELECT
*
FROM
(

SELECT
		A.Date,
		B.ControlNumber,
		SUM(Beg_Weight) AS Beg_Weight,
		0 AS Out_Weight,
		SUM(Beg_Pallet) AS Beg_Pallet,
		0 AS Out_Pallet
	FROM wms_reports.TT_INBOUNDDATE_INV_CONTROLLEDTEMP A
	LEFT JOIN wms_reports.tbl_sp_details_inbound_controlledtemp B ON DAY(A.DATE) = DAY(B.ReceivingDate) AND 
    MONTH(A.DATE) = MONTH(B.ReceivingDate) AND YEAR(A.DATE) = YEAR(B.ReceivingDate) AND CustomerID = __CustomerID
	GROUP BY B.ControlNumber, A.Date
    
UNION ALL

SELECT
		AA.Date,
		B.ControlNumber,
		0,
		SUM(Out_Weight) AS Out_Weight,
		0 AS Beg_Pallet,
		IFNULL(Out_Pallet, 0) AS Out_Pallet
	FROM wms_reports.TT_OUTBOUNDDATE_INV_CONTROLLEDTEMP AA
	LEFT JOIN wms_reports.tbl_sp_details_outbound_controlledtemp B ON DAY(AA.DATE) = DAY(B.ReceivingDate) AND 
    MONTH(AA.DATE) = MONTH(B.ReceivingDate) AND YEAR(AA.DATE) = YEAR(B.ReceivingDate) AND CustomerID = __CustomerID
    WHERE B.ControlNumber IS NOT NULL
    GROUP BY B.ControlNumber, AA.Date
    
UNION ALL

	SELECT
		AAA.Date,
		B.IT,
		0,
		0,
		0 AS Beg_Pallet,
		COUNT(DISTINCT FromPallet) AS Out_Pallet
	FROM wms_reports.TT_IT_INV_CONTROLLEDTEMP AAA
    LEFT JOIN wms_warehouse.tbl_ithistory B ON DAY(AAA.DATE) = DAY(B.EndDate) AND 
    MONTH(AAA.DATE) = MONTH(B.EndDate) AND YEAR(AAA.DATE) = YEAR(B.EndDate) AND CustomerID = __CustomerID
    LEFT JOIN wms_warehouse.tbl_itemtransfers C ON C.IT = B.IT
    LEFT JOIN wms_inbound.tbl_receivingitems D ON C.FromPallet = D.PalletID
    LEFT JOIN wms_cloud.tbl_items E ON D.ItemID = E.ItemID
    WHERE B.IT IS NOT NULL AND Category = 4 AND new_qty = 0
    GROUP BY B.IT, AAA.Date

) AS G

ORDER BY Date;

    

    DROP TABLE wms_reports.TT_INBOUNDDATE_INV_CONTROLLEDTEMP;

    DROP TABLE wms_reports.TT_OUTBOUNDDATE_INV_CONTROLLEDTEMP;
    
    DROP TABLE wms_reports.TT_IT_INV_CONTROLLEDTEMP;
    
    DROP TABLE wms_reports.tbl_sp_details_outbound_controlledtemp;
    
    DROP TABLE wms_reports.tbl_sp_details_inbound_controlledtemp;

    

END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_Inventory_Details_ByFreezer
DELIMITER //
CREATE PROCEDURE `SP_Inventory_Details_ByFreezer`(IN __CustomerID INT,  IN __DateFrom DATETIME, IN __DateTo DATETIME)
BEGIN
	create temporary table wms_reports.TT_INBOUNDDATE_INV_FREEZER
	(
		select A.date from 
		(select adddate('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) date from
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) A
		where A.date between __DateFrom and __DateTo
		group by A.date
		order by A.date
	);
    
    create temporary table wms_reports.TT_IT_INV_FREEZER
	(
		select A.date from 
		(select adddate('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) date from
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) A
		where A.date between __DateFrom and __DateTo
		group by A.date
		order by A.date
	);
    
    create temporary table wms_reports.TT_OUTBOUNDDATE_INV_FREEZER
	(
		select A.date from 
		(select adddate('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) date from
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) A
		where A.date between __DateFrom and __DateTo
		group by A.date
		order by A.date
	);
	
    create temporary table wms_reports.tbl_sp_details_inbound_freezer(
			SELECT 
        LEFT(`a`.`ReceivingDate`, 10) AS `ReceivingDate`,
        `a`.`IBN` AS `ControlNumber`,
        SUM(`b`.`Beg_Weight`) AS `Beg_Weight`,
        0 AS `Out_Weight`,
        COUNT(DISTINCT `b`.`PalletID`) AS `Beg_Pallet`,
        0 AS `Out_Pallet`,
        `b`.`CustomerID` AS `CustomerID`,
        `b`.`PalletID` AS `PalletID`
    FROM
        ((`wms_inbound`.`tbl_receiving` `a`
        LEFT JOIN `wms_inbound`.`tbl_receivingitems` `b` ON ((`a`.`IBN` = `b`.`IBN`)))
        LEFT JOIN `wms_cloud`.`tbl_items` `c` ON ((`b`.`ItemID` = `c`.`ItemID`)))
    WHERE
        ((`a`.`StatusID` <> 5)
            AND (`b`.`Checked` = 'TRUE')
            AND ((`b`.`ForPutaway` = 0)
            OR (`b`.`ForPutaway` >= 2))
            AND (`c`.`Category` = 1)
            AND CustomerID =  __CustomerID
            AND (LEFT(`a`.`ReceivingDate`, 10) BETWEEN __DateFrom and __DateTo)
            )
    GROUP BY `b`.`PalletID`
    );
    
    
    create temporary table wms_reports.tbl_sp_details_outbound_freezer(
			SELECT 
			LEFT(`a`.`IssuanceDate`, 10) AS `ReceivingDate`,
			`a`.`OBD` AS `ControlNumber`,
			0 AS `Beg_Weight`,
			SUM(`c`.`Beg_Weight`) AS `Out_Weight`,
			0 AS `Beg_Pallet`,
			(SELECT 
					COUNT(DISTINCT `A`.`palletid`)
				FROM
					(((wms_outbound.`tbl_palletout` `A`
					LEFT JOIN wms_outbound.`tbl_issuances` `BB` ON ((`A`.`obd` = `BB`.`OBD`)))
					LEFT JOIN `wms_inbound`.`tbl_receivingitems` `C` ON ((`A`.`palletid` = `C`.`PalletID`)))
					LEFT JOIN `wms_cloud`.`tbl_items` `D` ON ((`C`.`ItemID` = `D`.`ItemID`)))
				WHERE
					((`A`.`afterissuance` = 0)
						AND (`D`.`Category` = 1)
						AND ((`BB`.`StatusID` = 3)
						OR (`BB`.`StatusID` = 6))
						AND (`A`.`obd` = `b`.`OBD`))) AS `Out_Pallet`,
			`a`.`CustomerID` AS `CustomerID`
		FROM
			((((wms_outbound.`tbl_issuances` `a`
			LEFT JOIN wms_outbound.`tbl_issuancelist` `b` ON ((`a`.`OBD` = `b`.`OBD`)))
			LEFT JOIN `wms_inbound`.`tbl_receivingitems` `c` ON ((`b`.`Receivingitemid` = `c`.`ReceivingItemID`)))
			LEFT JOIN `wms_inbound`.`tbl_pallets` `e` ON ((`c`.`PalletID` = `e`.`PalletID`)))
			LEFT JOIN `wms_cloud`.`tbl_items` `d` ON ((`b`.`itemid` = `d`.`ItemID`)))
		WHERE
			(((`a`.`StatusID` = 3)
            OR (`a`.`StatusID` = 6))
            AND (LEFT(`a`.`IssuanceDate`, 10) BETWEEN __DateFrom and __DateTo)
            AND (`d`.`Category` = 1)
            AND a.CustomerID = __CustomerID)
		GROUP BY `a`.`OBD`
    
    );
    
SELECT
*
FROM
(

SELECT
		A.Date,
		B.ControlNumber,
		SUM(Beg_Weight) AS Beg_Weight,
		0 AS Out_Weight,
		SUM(Beg_Pallet) AS Beg_Pallet,
		0 AS Out_Pallet
	FROM wms_reports.TT_INBOUNDDATE_INV_FREEZER A
	LEFT JOIN wms_reports.tbl_sp_details_inbound_freezer B ON DAY(A.DATE) = DAY(B.ReceivingDate) AND 
    MONTH(A.DATE) = MONTH(B.ReceivingDate) AND YEAR(A.DATE) = YEAR(B.ReceivingDate) AND CustomerID = __CustomerID
	GROUP BY B.ControlNumber, A.Date
    
UNION ALL

SELECT
		AA.Date,
		B.ControlNumber,
		0,
		SUM(Out_Weight) AS Out_Weight,
		0 AS Beg_Pallet,
		IFNULL(Out_Pallet, 0) AS Out_Pallet
	FROM wms_reports.TT_OUTBOUNDDATE_INV_FREEZER AA
	LEFT JOIN wms_reports.tbl_sp_details_outbound_freezer B ON DAY(AA.DATE) = DAY(B.ReceivingDate) AND 
    MONTH(AA.DATE) = MONTH(B.ReceivingDate) AND YEAR(AA.DATE) = YEAR(B.ReceivingDate) AND CustomerID = __CustomerID
    WHERE B.ControlNumber IS NOT NULL
    GROUP BY B.ControlNumber, AA.Date
    
UNION ALL

	SELECT
		AAA.Date,
		B.IT,
		0,
		IF(__CustomerID = 39, 23.03, 0),
		0 AS Beg_Pallet,
		COUNT(DISTINCT FromPallet) AS Out_Pallet
	FROM wms_reports.TT_IT_INV_FREEZER AAA
    LEFT JOIN wms_warehouse.tbl_ithistory B ON DAY(AAA.DATE) = DAY(B.EndDate) AND 
    MONTH(AAA.DATE) = MONTH(B.EndDate) AND YEAR(AAA.DATE) = YEAR(B.EndDate) AND CustomerID = __CustomerID
    LEFT JOIN wms_warehouse.tbl_itemtransfers C ON C.IT = B.IT 
    LEFT JOIN wms_inbound.tbl_receivingitems D ON C.FromPallet = D.PalletID 
    LEFT JOIN wms_cloud.tbl_items E ON D.ItemID = E.ItemID
    WHERE B.IT IS NOT NULL AND Category = 1 AND new_qty = 0 AND isdeleted <> 1
    GROUP BY B.IT, AAA.Date

) AS G

ORDER BY Date;
    
    DROP TABLE wms_reports.TT_INBOUNDDATE_INV_FREEZER;
    DROP TABLE wms_reports.TT_OUTBOUNDDATE_INV_FREEZER;
    DROP TABLE wms_reports.TT_IT_INV_FREEZER;
    DROP TABLE wms_reports.tbl_sp_details_outbound_freezer;
    DROP TABLE wms_reports.tbl_sp_details_inbound_freezer;
    
END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_Inventory_Details_ByIceCream
DELIMITER //
CREATE PROCEDURE `SP_Inventory_Details_ByIceCream`(IN __CustomerID INT,  IN __DateFrom DATETIME, IN __DateTo DATETIME)
BEGIN
	create temporary table wms_reports.TT_INBOUNDDATE_INV_ICECREAM
	(
		select A.date from 
		(select adddate('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) date from
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) A
		where A.date between __DateFrom and __DateTo
		group by A.date
		order by A.date
	);
    
    create temporary table wms_reports.TT_IT_INV_ICECREAMFREEZER
	(
		select A.date from 
		(select adddate('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) date from
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) A
		where A.date between __DateFrom and __DateTo
		group by A.date
		order by A.date
	);
    
    
    create temporary table wms_reports.TT_OUTBOUNDDATE_INV_ICECREAM
	(
		select A.date from 
		(select adddate('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) date from
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3,
		(select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) A
		where A.date between __DateFrom and __DateTo
		group by A.date
		order by A.date
	);
    
    create temporary table wms_reports.tbl_sp_details_inbound_freezericecream(
			SELECT 
        LEFT(`a`.`ReceivingDate`, 10) AS `ReceivingDate`,
        `a`.`IBN` AS `ControlNumber`,
        SUM(`b`.`Beg_Weight`) AS `Beg_Weight`,
        0 AS `Out_Weight`,
        COUNT(DISTINCT `b`.`PalletID`) AS `Beg_Pallet`,
        0 AS `Out_Pallet`,
        `b`.`CustomerID` AS `CustomerID`,
        `b`.`PalletID` AS `PalletID`
    FROM
        ((`wms_inbound`.`tbl_receiving` `a`
        LEFT JOIN `wms_inbound`.`tbl_receivingitems` `b` ON ((`a`.`IBN` = `b`.`IBN`)))
        LEFT JOIN `wms_cloud`.`tbl_items` `c` ON ((`b`.`ItemID` = `c`.`ItemID`)))
    WHERE
        ((`a`.`StatusID` <> 5)
            AND (`b`.`Checked` = 'TRUE')
            AND ((`b`.`ForPutaway` = 0)
            OR (`b`.`ForPutaway` >= 2))
            AND (`c`.`Category` = 2)
            AND CustomerID =  __CustomerID
            AND (LEFT(`a`.`ReceivingDate`, 10) BETWEEN __DateFrom and __DateTo)
            )
    GROUP BY `b`.`PalletID`
    );
    
    create temporary table wms_reports.tbl_sp_details_outbound_freezericecream(
			SELECT 
			LEFT(`a`.`IssuanceDate`, 10) AS `ReceivingDate`,
			`a`.`OBD` AS `ControlNumber`,
			0 AS `Beg_Weight`,
			SUM(`c`.`Beg_Weight`) AS `Out_Weight`,
			0 AS `Beg_Pallet`,
			(SELECT 
					COUNT(DISTINCT `A`.`palletid`)
				FROM
					(((wms_outbound.`tbl_palletout` `A`
					LEFT JOIN wms_outbound.`tbl_issuances` `BB` ON ((`A`.`obd` = `BB`.`OBD`)))
					LEFT JOIN `wms_inbound`.`tbl_receivingitems` `C` ON ((`A`.`palletid` = `C`.`PalletID`)))
					LEFT JOIN `wms_cloud`.`tbl_items` `D` ON ((`C`.`ItemID` = `D`.`ItemID`)))
				WHERE
					((`A`.`afterissuance` = 0)
						AND (`D`.`Category` = 2)
						AND ((`BB`.`StatusID` = 3)
						OR (`BB`.`StatusID` = 6))
						AND (`A`.`obd` = `b`.`OBD`))) AS `Out_Pallet`,
			`a`.`CustomerID` AS `CustomerID`
		FROM
			((((wms_outbound.`tbl_issuances` `a`
			LEFT JOIN wms_outbound.`tbl_issuancelist` `b` ON ((`a`.`OBD` = `b`.`OBD`)))
			LEFT JOIN `wms_inbound`.`tbl_receivingitems` `c` ON ((`b`.`Receivingitemid` = `c`.`ReceivingItemID`)))
			LEFT JOIN `wms_inbound`.`tbl_pallets` `e` ON ((`c`.`PalletID` = `e`.`PalletID`)))
			LEFT JOIN `wms_cloud`.`tbl_items` `d` ON ((`b`.`itemid` = `d`.`ItemID`)))
		WHERE
			(((`a`.`StatusID` = 3)
            OR (`a`.`StatusID` = 6))
            AND (LEFT(`a`.`IssuanceDate`, 10) BETWEEN __DateFrom and __DateTo)
            AND (`d`.`Category` = 2)
            AND a.CustomerID = __CustomerID)
		GROUP BY `a`.`OBD`
    );
SELECT
*
FROM
(

SELECT
		A.Date,
		B.ControlNumber,
		SUM(Beg_Weight) AS Beg_Weight,
		0 AS Out_Weight,
		SUM(Beg_Pallet) AS Beg_Pallet,
		0 AS Out_Pallet
	FROM wms_reports.TT_INBOUNDDATE_INV_ICECREAM A
	LEFT JOIN wms_reports.tbl_sp_details_inbound_freezericecream B ON DAY(A.DATE) = DAY(B.ReceivingDate) AND 
    MONTH(A.DATE) = MONTH(B.ReceivingDate) AND YEAR(A.DATE) = YEAR(B.ReceivingDate) AND CustomerID = __CustomerID
	GROUP BY B.ControlNumber, A.Date
    
UNION ALL

SELECT
		AA.Date,
		B.ControlNumber,
		0,
		SUM(Out_Weight) AS Out_Weight,
		0 AS Beg_Pallet,
		IFNULL(Out_Pallet, 0) AS Out_Pallet
	FROM wms_reports.TT_OUTBOUNDDATE_INV_ICECREAM AA
	LEFT JOIN wms_reports.tbl_sp_details_outbound_freezericecream B ON DAY(AA.DATE) = DAY(B.ReceivingDate) AND 
    MONTH(AA.DATE) = MONTH(B.ReceivingDate) AND YEAR(AA.DATE) = YEAR(B.ReceivingDate) AND CustomerID = __CustomerID
    WHERE B.ControlNumber IS NOT NULL
    GROUP BY B.ControlNumber, AA.Date

UNION ALL

	SELECT
		AAA.Date,
		B.IT,
		0,
		0,
		0 AS Beg_Pallet,
		COUNT(DISTINCT FromPallet) AS Out_Pallet
	FROM wms_reports.TT_IT_INV_ICECREAMFREEZER AAA
    LEFT JOIN wms_warehouse.tbl_ithistory B ON DAY(AAA.DATE) = DAY(B.EndDate) AND 
    MONTH(AAA.DATE) = MONTH(B.EndDate) AND YEAR(AAA.DATE) = YEAR(B.EndDate) AND CustomerID = __CustomerID
    LEFT JOIN wms_warehouse.tbl_itemtransfers C ON C.IT = B.IT
    LEFT JOIN wms_inbound.tbl_receivingitems D ON C.FromPallet = D.PalletID
    LEFT JOIN wms_cloud.tbl_items E ON D.ItemID = E.ItemID
    WHERE B.IT IS NOT NULL AND Category = 2 AND new_qty = 0
    GROUP BY B.IT, AAA.Date
) AS G

ORDER BY Date;
    
    DROP TABLE wms_reports.TT_INBOUNDDATE_INV_ICECREAM;
    DROP TABLE wms_reports.TT_OUTBOUNDDATE_INV_ICECREAM;
    DROP TABLE wms_reports.TT_IT_INV_ICECREAMFREEZER;
    DROP TABLE wms_reports.tbl_sp_details_outbound_freezericecream;
    DROP TABLE wms_reports.tbl_sp_details_inbound_freezericecream;
    
END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.sp_nonconformingproducts
DELIMITER //
CREATE PROCEDURE `sp_nonconformingproducts`(IN __CustomerID INT)
BEGIN
						SELECT 
                          ItemDesc, 
                          SUM(Beg_Quantity), 
                          UOM_Abv, SUM(ri.Beg_Weight), 
                          stat.ItemStatus 
                        FROM wms_inbound.tbl_receivingitems ri
                        LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
                        LEFT JOIN wms_cloud.tbl_items item ON ri.ItemID = item.ItemID
                        LEFT JOIN wms_cloud.tbl_weightuom uom ON item.UOMID = uom.UOMID
                        LEFT JOIN wms_cloud.tbl_itemstatus stat ON ri.ItemStatusID = stat.ItemStatusID
                        WHERE ri.ItemStatusID != 2 AND (ForPutAway = 0 OR ForPutAway > 1) AND ri.CustomerID = __CustomerID AND Quantity > 0
                        GROUP BY ri.ItemStatusID
                        ORDER BY SUM(Quantity) DESC;
END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.sp_ord_delivered_status
DELIMITER //
CREATE PROCEDURE `sp_ord_delivered_status`(IN `__ID` INT)
BEGIN
	DECLARE __ORD VARCHAR(100);
    
	SET __ORD = (
		SELECT 
		A.ORD
		FROM wms_outbound.tbl_ordering A
		LEFT JOIN wms_outbound.tbl_picking D ON A.ORD = D.ORD
		LEFT JOIN wms_outbound.tbl_issuancelist E ON D.PCK = E.PCK
		LEFT JOIN wms_outbound.tbl_issuances F ON E.OBD = F.OBD
		WHERE F.id = __ID
        GROUP BY A.ORD);

		UPDATE wms_outbound.tbl_ordering SET DRStatus = 'Delivered' WHERE ORD = __ORD;

		
END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_outbound_dashboard_delivered
DELIMITER //
CREATE PROCEDURE `SP_outbound_dashboard_delivered`(

	IN `__CustomerID` INT,

	IN `__From` DATETIME,

	IN `__To` DATETIME

)
BEGIN

CREATE TEMPORARY TABLE TT_ORDERDATE_DELIVERED

	(

SELECT A.date, 0 AS counter

FROM 

		(

SELECT ADDDATE('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) DATE

FROM

		(

SELECT 0 i UNION

SELECT 1 UNION

SELECT 2 UNION

SELECT 3 UNION

SELECT 4 UNION

SELECT 5 UNION

SELECT 6 UNION

SELECT 7 UNION

SELECT 8 UNION

SELECT 9) t0,

		(

SELECT 0 i UNION

SELECT 1 UNION

SELECT 2 UNION

SELECT 3 UNION

SELECT 4 UNION

SELECT 5 UNION

SELECT 6 UNION

SELECT 7 UNION

SELECT 8 UNION

SELECT 9) t1,

		(

SELECT 0 i UNION

SELECT 1 UNION

SELECT 2 UNION

SELECT 3 UNION

SELECT 4 UNION

SELECT 5 UNION

SELECT 6 UNION

SELECT 7 UNION

SELECT 8 UNION

SELECT 9) t2,

		(

SELECT 0 i UNION

SELECT 1 UNION

SELECT 2 UNION

SELECT 3 UNION

SELECT 4 UNION

SELECT 5 UNION

SELECT 6 UNION

SELECT 7 UNION

SELECT 8 UNION

SELECT 9) t3,

		(

SELECT 0 i UNION

SELECT 1 UNION

SELECT 2 UNION

SELECT 3 UNION

SELECT 4 UNION

SELECT 5 UNION

SELECT 6 UNION

SELECT 7 UNION

SELECT 8 UNION

SELECT 9) t4) A

WHERE A.date BETWEEN __From AND __To

GROUP BY A.date

ORDER BY A.date

	);

SELECT A.DATE, COALESCE(SUM(Quantity),0), COALESCE(SUM(C.Weight),0)

FROM TT_ORDERDATE_DELIVERED A

LEFT JOIN wms_outbound.tbl_ordering B ON DAY(A.DATE) = DAY(B.OrderDate) AND MONTH(A.DATE) = MONTH(B.OrderDate) AND YEAR(A.DATE) = YEAR(B.OrderDate)

LEFT JOIN wms_outbound.tbl_orderingitems C ON B.ORD = C.ORD AND B.CustomerID = __CustomerID AND DRStatus = 'Delivered' 

LEFT JOIN wms_cloud.tbl_items D ON C.ItemID = D.ItemID

GROUP BY A.Date

ORDER BY A.Date;

DROP TABLE TT_ORDERDATE_DELIVERED; END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_outbound_dashboard_undelivered
DELIMITER //
CREATE PROCEDURE `SP_outbound_dashboard_undelivered`(

	IN `__CustomerID` INT,

	IN `__From` DATETIME,

	IN `__To` DATETIME

)
BEGIN

CREATE TEMPORARY TABLE TT_ORDERDATE

	(

SELECT A.date, 0 AS counter

FROM 

		(

SELECT ADDDATE('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) DATE

FROM

		(

SELECT 0 i UNION

SELECT 1 UNION

SELECT 2 UNION

SELECT 3 UNION

SELECT 4 UNION

SELECT 5 UNION

SELECT 6 UNION

SELECT 7 UNION

SELECT 8 UNION

SELECT 9) t0,

		(

SELECT 0 i UNION

SELECT 1 UNION

SELECT 2 UNION

SELECT 3 UNION

SELECT 4 UNION

SELECT 5 UNION

SELECT 6 UNION

SELECT 7 UNION

SELECT 8 UNION

SELECT 9) t1,

		(

SELECT 0 i UNION

SELECT 1 UNION

SELECT 2 UNION

SELECT 3 UNION

SELECT 4 UNION

SELECT 5 UNION

SELECT 6 UNION

SELECT 7 UNION

SELECT 8 UNION

SELECT 9) t2,

		(

SELECT 0 i UNION

SELECT 1 UNION

SELECT 2 UNION

SELECT 3 UNION

SELECT 4 UNION

SELECT 5 UNION

SELECT 6 UNION

SELECT 7 UNION

SELECT 8 UNION

SELECT 9) t3,

		(

SELECT 0 i UNION

SELECT 1 UNION

SELECT 2 UNION

SELECT 3 UNION

SELECT 4 UNION

SELECT 5 UNION

SELECT 6 UNION

SELECT 7 UNION

SELECT 8 UNION

SELECT 9) t4) A

WHERE A.date BETWEEN __From AND __To

GROUP BY A.date

ORDER BY A.date

	);

SELECT A.DATE, COALESCE(SUM(Quantity),0), D.Weight

FROM TT_ORDERDATE A

LEFT JOIN wms_outbound.tbl_ordering B ON DAY(A.DATE) = DAY(B.OrderDate) AND MONTH(A.DATE) = MONTH(B.OrderDate) AND YEAR(A.DATE) = YEAR(B.OrderDate)

LEFT JOIN wms_outbound.tbl_orderingitems C ON B.ORD = C.ORD AND B.CustomerID = __CustomerID AND (B.DRStatus != 'Delivered' OR B.DRStatus IS NULL)

LEFT JOIN wms_cloud.tbl_items D ON C.ItemID = D.ItemID

GROUP BY A.Date

ORDER BY A.Date;

DROP TABLE TT_ORDERDATE; END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.sp_pallettag_alreadyprinted
DELIMITER //
CREATE PROCEDURE `sp_pallettag_alreadyprinted`(IN __PalletID INT)
BEGIN
	
    declare __count int;
    
    set __count = (SELECT COUNT(PalletID) FROM wms_reports.tbl_alreadyprintpid WHERE PalletID = __PalletID);
    
    IF __count > 0 THEN
		SELECT 0;
    ELSE
		INSERT INTO wms_reports.tbl_alreadyprintpid (IBNPrint, PalletID, PrintPID) VALUES ('0', __PalletID, 'True');
    END IF;
END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_PALLETUTILIZATION_ADD_GUARANTEED
DELIMITER //
CREATE PROCEDURE `SP_PALLETUTILIZATION_ADD_GUARANTEED`()
BEGIN 

DECLARE __Guaranteed INT;
DECLARE __Pallet_Occupied INT;
DECLARE __Pallet_Out INT; 

SET __Guaranteed = (
SELECT SUM(`wms_cloud`.`tbl_customers`.`FreezerGuaranteed`) + SUM(`wms_cloud`.`tbl_customers`.`IceCreamFreezerGuaranteed`) + 
SUM(`wms_cloud`.`tbl_customers`.`ChillerGuaranteed`) + SUM(`wms_cloud`.`tbl_customers`.`DryGuaranteed`) AS `Guaranteed`
FROM
 `wms_cloud`.`tbl_customers`
); 

SET __Pallet_Occupied = (
	SELECT COUNT(PalletID) FROM wms_reports.tbl_view_palletout WHERE PalletIDLoc IS NOT NULL
);


SET __Pallet_Out = (
	SELECT COUNT(PalletID) FROM wms_reports.tbl_view_palletout WHERE Quantity = 0 AND PalletIDLoc IS NOT NULL
);

INSERT INTO wms_reports.tbl_palletutilization (`guaranteed`, `date_created`, `pallet_occupied`, `pallet_out`) 
VALUES (__Guaranteed, NOW(), __Pallet_Occupied, __Pallet_Out);

END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.sp_palletutilization_pertempcat
DELIMITER //
CREATE PROCEDURE `sp_palletutilization_pertempcat`()
BEGIN
			  SELECT 
                    IFNULL(F.type, 'UnAssigned') AS Temp,
                    F.Capacity,
                    0,
                    COUNT(DISTINCT(A.PalletID)),
                    0
                FROM wms_inbound.tbl_receivingitems A
                LEFT JOIN wms_inbound.tbl_receiving ON A.IBN = wms_inbound.tbl_receiving.IBN AND A.isout = 0
                LEFT JOIN wms_inbound.tbl_pallets C ON A.PalletID = C.PalletID
                LEFT JOIN wms_inbound.tbl_locations D ON C.LocationID = D.LocationID
                LEFT JOIN wms_inbound.tbl_room E ON D.RoomCode = E.RoomCode
                LEFT JOIN wms_cloud.tbl_roomtypes F ON E.RoomTypeID = F.id
                WHERE (ForPutaway = 0 OR ForPutaway >= 2)
                AND A.Quantity > 0 
                AND Checked = 'True' AND ReceivingDate < NOW()
                AND F.type IS NOT NULL
                GROUP BY F.id;

END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.sp_picking_logs
DELIMITER //
CREATE PROCEDURE `sp_picking_logs`(
									in __pck varchar(150),
                                    in __movement varchar(150),
									in __palletid int,
                                    in __qty int,
                                    in __userid int
									)
BEGIN
			insert into wms_reports.tbl_picking_logs(pck,movement,palletid,qty,userid,datestamp)
            values(__pck,__movement,__palletid,__qty,__userid,NOW());
END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.sp_printcts
DELIMITER //
CREATE PROCEDURE `sp_printcts`(IN __ibn VARCHAR(100), IN __limit INT)
BEGIN
	SELECT
                    CONCAT(SystemPID, '-', ManualPID),
                    GROUP_CONCAT(DISTINCT CONCAT(ItemCode, '-', Client_SKU) SEPARATOR '/'),
                    GROUP_CONCAT(Distinct ItemDesc SEPARATOR '/'),
                    GROUP_CONCAT(Distinct UOM_Abv SEPARATOR '/'),
                    sum(Beg_Quantity),
                    sum(Beg_Weight),
                    GROUP_CONCAT(Distinct IFNULL(LEFT(ExpiryDate, 10), 'No Expiry') SEPARATOR '/')
                FROM wms_inbound.tbl_receivingitems
                LEFT JOIN wms_inbound.tbl_pallets on wms_inbound.tbl_receivingitems.PalletID = wms_inbound.tbl_pallets.PalletID
                LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                LEFT JOIN wms_cloud.tbl_weightuom on wms_cloud.tbl_items.UOMID = wms_cloud.tbl_weightuom.UOMID
                WHERE wms_inbound.tbl_receivingitems.IBN = __ibn
                GROUP BY wms_inbound.tbl_pallets.PalletID, wms_cloud.tbl_weightuom.UOM_Abv, wms_inbound.tbl_receivingitems.ExpiryDate 
                LIMIT __limit, 5;
END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.sp_printpaf
DELIMITER //
CREATE PROCEDURE `sp_printpaf`(IN __ibn VARCHAR(100), IN __limit INT)
BEGIN

                    SELECT
                        GROUP_CONCAT(DISTINCT ItemDesc SEPARATOR 'twowowow'),
                        GROUP_CONCAT(DISTINCT UOM_Abv),
                        SUM(Beg_Quantity),
                        SUM(Beg_Weight),
                        GROUP_CONCAT(DISTINCT IFNULL(LEFT(ExpiryDate, 10), 'No Expiry')),
                        CONCAT(SystemPID, ' / ', ManualPID),
                        CONCAT(ColName, '-', RIGHT(LCode, 1)) as loc
                    FROM wms_inbound.tbl_receivingitems
                    LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                    LEFT JOIN wms_cloud.tbl_weightuom on wms_cloud.tbl_items.UOMID = wms_cloud.tbl_weightuom.UOMID
                    LEFT JOIN wms_inbound.tbl_pallets on wms_inbound.tbl_receivingitems.PalletID = wms_inbound.tbl_pallets.PalletID
                    LEFT JOIN wms_inbound.tbl_locations on wms_inbound.tbl_pallets.LocationID = wms_inbound.tbl_locations.LocationID
                    WHERE wms_inbound.tbl_receivingitems.IBN = __ibn AND ForPutaway != 1
                    GROUP BY wms_inbound.tbl_receivingitems.PalletID
                    ORDER BY wms_inbound.tbl_receivingitems.PalletID LIMIT __limit, 5;
                
END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.sp_printpallettag
DELIMITER //
CREATE PROCEDURE `sp_printpallettag`(IN __ibn VARCHAR(100), IN __pid INT)
BEGIN	
		IF __pid IS NULL THEN
				SELECT
                    SystemPID,
                    ManualPID,
                    ItemDesc,
                    CompanyName,
                    Client_SKU,
                    ItemCode,
                    SUM(Beg_Quantity),
                    UOM_Abv,
                    SUM(Beg_Weight),
                    GROUP_CONCAT(DISTINCT LEFT(ExpiryDate, 10)),
                    ReceivingDate,
                    ItemStatus,
                    Batch,
                    Container,
                    ItemCode
                FROM wms_inbound.tbl_receiving
                LEFT JOIN wms_inbound.tbl_receivingitems on wms_inbound.tbl_receiving.IBN = wms_inbound.tbl_receivingitems.IBN
                LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                LEFT JOIN wms_cloud.tbl_weightuom on wms_cloud.tbl_items.UOMID = wms_cloud.tbl_weightuom.UOMID
                LEFT JOIN wms_cloud.tbl_itemstatus on wms_inbound.tbl_receivingitems.ItemStatusID = wms_cloud.tbl_itemstatus.ItemStatusID
                LEFT JOIN wms_cloud.tbl_customers on wms_inbound.tbl_receiving.CusID = wms_cloud.tbl_customers.CustomerID
                LEFT JOIN wms_inbound.tbl_pallets on wms_inbound.tbl_receivingitems.PalletID = wms_inbound.tbl_pallets.PalletID 
                WHERE wms_inbound.tbl_receiving.IBN = __ibn AND ForPutAway = 1
                GROUP BY wms_inbound.tbl_receivingitems.PalletID, wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ItemStatusID;
		ELSE 
				SELECT
                    SystemPID,
                    ManualPID,
                    ItemDesc,
                    CompanyName,
                    Client_SKU,
                    ItemCode,
                    SUM(Beg_Quantity),
                    UOM_Abv,
                    SUM(Beg_Weight),
                    GROUP_CONCAT(DISTINCT LEFT(ExpiryDate, 10)),
                    ReceivingDate,
                    ItemStatus,
                    Batch,
                    Container,
                    ItemCode
                FROM wms_inbound.tbl_receiving
                LEFT JOIN wms_inbound.tbl_receivingitems on wms_inbound.tbl_receiving.IBN = wms_inbound.tbl_receivingitems.IBN
                LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                LEFT JOIN wms_cloud.tbl_weightuom on wms_cloud.tbl_items.UOMID = wms_cloud.tbl_weightuom.UOMID
                LEFT JOIN wms_cloud.tbl_itemstatus on wms_inbound.tbl_receivingitems.ItemStatusID = wms_cloud.tbl_itemstatus.ItemStatusID
                LEFT JOIN wms_cloud.tbl_customers on wms_inbound.tbl_receiving.CusID = wms_cloud.tbl_customers.CustomerID
                LEFT JOIN wms_inbound.tbl_pallets on wms_inbound.tbl_receivingitems.PalletID = wms_inbound.tbl_pallets.PalletID 
                WHERE wms_inbound.tbl_receiving.IBN = __ibn and wms_inbound.tbl_receivingitems.PalletID = __pid
                GROUP BY wms_inbound.tbl_receivingitems.PalletID, wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ItemStatusID;
		END IF;
END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_PrintPalletTagStatus
DELIMITER //
CREATE PROCEDURE `SP_PrintPalletTagStatus`(IN __IBN VARCHAR(100), IN __PalletID INT)
BEGIN
	DECLARE __counter INT;
	SET __counter = (SELECT PalletID FROM wms_reports.tbl_alreadyprintpid WHERE IBNPrint = __IBN AND PalletID = __PalletID);
    
	IF __counter > 0 THEN
		SELECT 0;
    ELSE
		INSERT INTO wms_reports.tbl_alreadyprintpid (IBNPrint, PalletID, PrintPID) VALUES (__IBN, __PalletID, 'True');
	END IF;
END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_PrintPicklist
DELIMITER //
CREATE PROCEDURE `SP_PrintPicklist`(IN __PCK VARCHAR(100), IN __LIMIT INT)
BEGIN
					SELECT
                        CONCAT(E.ColName, '-', RIGHT(E.LCode, 1)),
                        CONCAT(D.SystemPID, ' - ', D.ManualPID),
                        G.Container,
                        H.ItemCode,
                        H.ItemDesc,
                        I.UOM_Abv,
                        0,
                        0,
                        B.qty,
                        SUM(F.Beg_Weight),
                        CASE
                            WHEN LEFT(B.expirydate, 10) = '0000-00-00' THEN 'No Expiry'
                            WHEN B.expirydate IS NULL THEN 'No Expiry'
                            ELSE LEFT(B.expirydate, 10)
                        END,
                        GROUP_CONCAT(DISTINCT F.ItemRemark),
                        GROUP_CONCAT(DISTINCT L.ItemStatus),
                        COUNT(K.receivingitemid),
                        SUM(K.Beg_Weight),
                        K.receivingitemid
                    FROM wms_outbound.tbl_picking A
                    LEFT JOIN wms_outbound.tbl_allocations B ON A.id = B.pickingid
                    LEFT JOIN wms_outbound.tbl_allocation_details C ON B.id = C.allocid
                    LEFT JOIN wms_inbound.tbl_pallets D ON B.palletid = D.PalletID
                    LEFT JOIN wms_inbound.tbl_locations E ON D.PalletID = E.PalletID
                    LEFT JOIN wms_inbound.tbl_receivingitems F ON C.receivingid = F.ReceivingItemID
                    LEFT JOIN wms_inbound.tbl_receiving G ON F.IBN = G.IBN
                    LEFT JOIN wms_cloud.tbl_items H ON B.itemid = H.ItemID
                    LEFT JOIN wms_cloud.tbl_weightuom I ON H.UOMID = I.UOMID
                    LEFT JOIN wms_reports.tbl_actual_pick_with_weight K ON F.receivingitemid = K.receivingitemid
                    LEFT JOIN wms_cloud.tbl_itemstatus L ON F.ItemStatusID = L.ItemStatusID
                    WHERE A.PCK = __PCK
                    GROUP BY B.palletid, B.id
                    LIMIT __LIMIT, 5;
END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.SP_PrintPicklist2
DELIMITER //
CREATE PROCEDURE `SP_PrintPicklist2`(IN __PCK VARCHAR(100), IN __LIMIT INT)
BEGIN
						SELECT
						CONCAT(F.ColName, '-', RIGHT(F.LCode, 1)),
                        CONCAT(D.SystemPID, ' - ', D.ManualPID),
                        B.Container,
                        C.ItemCode,
                        C.ItemDesc,
                        M.UOM_Abv,
                        0,
                        0,
                        COUNT(I.receivingid),
                        SUM(A.Beg_Weight),
                        CASE
                            WHEN LEFT(A.expirydate, 10) = '0000-00-00' THEN 'No Expiry'
                            WHEN A.expirydate IS NULL THEN 'No Expiry'
                            ELSE LEFT(A.expirydate, 10)
                        END,
                        GROUP_CONCAT(DISTINCT A.ItemRemark),
                        GROUP_CONCAT(DISTINCT H.ItemStatus),
                        COUNT(J.receivingitemid),
                        SUM(J.Beg_Weight)
                FROM wms_inbound.tbl_receivingitems A
                LEFT JOIN wms_inbound.tbl_receiving B ON A.IBN = B.IBN
                LEFT JOIN wms_cloud.tbl_items C ON A.ItemID = C.ItemID
                LEFT JOIN wms_inbound.tbl_pallets D ON A.PalletID = D.PalletID
                LEFT JOIN wms_inbound.tbl_locations F ON D.LocationID = F.LocationID
                LEFT JOIN wms_cloud.tbl_itemstatus H ON A.ItemStatusID = H.ItemStatusID
                LEFT JOIN wms_outbound.tbl_allocation_details I ON A.ReceivingItemID = I.receivingid
                LEFT JOIN wms_reports.tbl_actual_pick_with_weight J ON A.ReceivingItemID = J.receivingitemid
                LEFT JOIN wms_outbound.tbl_issuancelist K ON A.ReceivingItemID = K.receivingitemid
                LEFT JOIN wms_cloud.tbl_customers L ON A.CustomerID = L.CustomerID
                LEFT JOIN wms_cloud.tbl_weightuom M ON C.UOMID = M.UOMID
                WHERE I.picklistid = __PCK
                GROUP BY A.PalletID, A.ItemID, A.ItemStatusID, J.PCK
				LIMIT __LIMIT, 5;
END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.sp_printsas
DELIMITER //
CREATE PROCEDURE `sp_printsas`(IN __ibn VARCHAR(100), IN __limit INT)
BEGIN
	SELECT
                        ItemDesc,
                        UOM_Abv,
                        SUM(Beg_Quantity),
                        SUM(Beg_Weight),
                        CASE
                            WHEN LEFT(ExpiryDate, 10) = '0000-00-00' THEN 'No Expiry'
                            WHEN ExpiryDate IS NULL THEN 'No Expiry'
                            ELSE LEFT(ExpiryDate, 10)
                        END,
                        CONCAT(SystemPID, ' / ', ManualPID),
                        ItemStatus
                    FROM wms_inbound.tbl_receivingitems
                    LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                    LEFT JOIN wms_cloud.tbl_weightuom on wms_cloud.tbl_items.UOMID = wms_cloud.tbl_weightuom.UOMID
                    LEFT JOIN wms_cloud.tbl_itemstatus on wms_inbound.tbl_receivingitems.ItemStatusID = wms_cloud.tbl_itemstatus.ItemStatusID
                    LEFT JOIN wms_inbound.tbl_pallets on wms_inbound.tbl_receivingitems.PalletID = wms_inbound.tbl_pallets.PalletID
                    WHERE wms_inbound.tbl_receivingitems.IBN = __ibn GROUP BY wms_inbound.tbl_receivingitems.PalletID, ItemDesc, ExpiryDate, ItemStatus, UOM_Abv 
                    LIMIT __limit, 12;
END//
DELIMITER ;

-- Dumping structure for procedure wms_reports.sp_printsws
DELIMITER //
CREATE PROCEDURE `sp_printsws`(IN __obd VARCHAR(100), IN __limit INT)
BEGIN
	SELECT 
                        C.ItemDesc,
                        D.UOM,
                        COUNT(B.PalletID),
                        SUM(E.Beg_Weight),
                        CASE
                            WHEN LEFT(E.ExpiryDate, 10) = '0000-00-00' THEN 'No Expiry'
                            WHEN E.ExpiryDate IS NULL THEN 'No Expiry'
                            ELSE LEFT(E.ExpiryDate, 10)
                        END,
                        CONCAT(SystemPID, '-', ManualPID),
                        GROUP_CONCAT(DISTINCT ItemStatus),
                        GROUP_CONCAT(DISTINCT QAReason)
                    FROM wms_outbound.tbl_issuances A
                    LEFT JOIN wms_outbound.tbl_issuancelist B ON A.OBD = B.OBD
                    LEFT JOIN wms_cloud.tbl_items C ON B.ItemID = C.ItemID
                    LEFT JOIN wms_cloud.tbl_weightuom D ON C.UOMID = D.UOMID
                    LEFT JOIN wms_inbound.tbl_receivingitems E ON B.Receivingitemid = E.ReceivingItemID
                    LEFT JOIN wms_inbound.tbl_pallets F ON E.PalletID = F.PalletID
                    LEFT JOIN wms_cloud.tbl_itemstatus G ON E.ItemStatusID = G.ItemStatusID
                    WHERE ItemDesc IS NOT NULL AND A.OBD = __obd
                    GROUP BY E.ExpiryDate, E.PalletID, B.itemid LIMIT __limit, 12;
END//
DELIMITER ;

-- Dumping structure for view wms_reports.tbl_actual_pick_with_weight
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `tbl_actual_pick_with_weight` (
	`id` INT(10) NOT NULL,
	`PCK` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`itemid` INT(10) NULL,
	`receivingitemid` INT(10) NULL,
	`status` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`Beg_Weight` DOUBLE NULL
) ENGINE=MyISAM;

-- Dumping structure for table wms_reports.tbl_alreadyprintpid
CREATE TABLE IF NOT EXISTS `tbl_alreadyprintpid` (
  `id` int NOT NULL AUTO_INCREMENT,
  `IBNPrint` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `PalletID` int DEFAULT NULL,
  `PrintPID` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `ManualPIDPrint` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8488 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table wms_reports.tbl_ibnstatus
CREATE TABLE IF NOT EXISTS `tbl_ibnstatus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status_id` int DEFAULT NULL,
  `statusname` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for view wms_reports.tbl_issuancelist_cbm
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `tbl_issuancelist_cbm` (
	`id` INT(10) NOT NULL,
	`OBD` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`PCK` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`PalletID` INT(10) NULL,
	`itemid` INT(10) NULL,
	`Receivingitemid` INT(10) NULL,
	`CBM` DOUBLE NULL,
	`CBM2` TEXT NULL COLLATE 'utf8mb4_0900_ai_ci'
) ENGINE=MyISAM;

-- Dumping structure for table wms_reports.tbl_issuance_receipt
CREATE TABLE IF NOT EXISTS `tbl_issuance_receipt` (
  `id` int NOT NULL AUTO_INCREMENT,
  `PCK` varchar(45) DEFAULT NULL,
  `OBD` varchar(45) DEFAULT NULL,
  `rcv_id` int DEFAULT NULL,
  `datetimestamp` datetime DEFAULT NULL,
  `ir_status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=497859 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for view wms_reports.tbl_itr_report
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `tbl_itr_report` (
	`ReceivingItemID` INT(10) NULL,
	`ReceivingDate` DATETIME NULL,
	`IBN` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`Client_SKU` VARCHAR(191) NULL COLLATE 'utf8_general_ci',
	`ItemDesc` VARCHAR(191) NULL COLLATE 'utf8_general_ci',
	`GOODQTY` DOUBLE NULL,
	`HOLDQTY` DOUBLE NULL,
	`QTY` DOUBLE NULL,
	`WGT` DOUBLE NULL,
	`QAReason` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`Container` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`StatusID` VARCHAR(20) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`ItemStatus` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`CusID` INT(10) NULL,
	`WarehouseID` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`CustomerReference` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`Checker` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`CBM` TEXT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`CBM2` DOUBLE NULL,
	`CompanyName` VARCHAR(191) NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Dumping structure for view wms_reports.tbl_itr_reportcp
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `tbl_itr_reportcp` (
	`ReceivingItemID` INT(10) NULL,
	`ReceivingDate` DATETIME NULL,
	`IBN` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`Client_SKU` VARCHAR(191) NULL COLLATE 'utf8_general_ci',
	`ItemDesc` VARCHAR(191) NULL COLLATE 'utf8_general_ci',
	`GOODQTY` DOUBLE NULL,
	`HOLDQTY` DOUBLE NULL,
	`QTY` DOUBLE NULL,
	`WGT` DOUBLE NULL,
	`QAReason` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`Container` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`StatusID` VARCHAR(20) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`ItemStatus` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`CusID` INT(10) NULL,
	`WarehouseID` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`CustomerReference` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`Checker` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`ASN` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`CPStatus_id` INT(10) NULL,
	`CP_QTY` DOUBLE NULL,
	`CP_WGT` DOUBLE NULL
) ENGINE=MyISAM;

-- Dumping structure for table wms_reports.tbl_movementransaction
CREATE TABLE IF NOT EXISTS `tbl_movementransaction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `function` varchar(200) DEFAULT NULL,
  `from` varchar(200) DEFAULT NULL,
  `to` varchar(200) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `user` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table wms_reports.tbl_palletutilization
CREATE TABLE IF NOT EXISTS `tbl_palletutilization` (
  `id` int NOT NULL AUTO_INCREMENT,
  `guaranteed` int DEFAULT NULL,
  `date_created` varchar(45) DEFAULT NULL,
  `pallet_occupied` int DEFAULT NULL,
  `pallet_out` int DEFAULT NULL,
  `status_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_reports.tbl_picking_logs
CREATE TABLE IF NOT EXISTS `tbl_picking_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pck` varchar(145) DEFAULT NULL,
  `movement` varchar(145) DEFAULT NULL,
  `palletid` varchar(145) DEFAULT NULL,
  `qty` varchar(145) DEFAULT NULL,
  `userid` varchar(145) DEFAULT NULL,
  `datestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16335 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_reports.tbl_printpicklist
CREATE TABLE IF NOT EXISTS `tbl_printpicklist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `PCK` varchar(45) DEFAULT NULL,
  `Status` varchar(45) DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1597 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for view wms_reports.tbl_roomtypes_capacity
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `tbl_roomtypes_capacity` (
	`id` INT(10) NOT NULL,
	`Capacity` DECIMAL(32,0) NULL,
	`type` VARCHAR(45) NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Dumping structure for table wms_reports.tbl_userlogs_details
CREATE TABLE IF NOT EXISTS `tbl_userlogs_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userlogs_id` int DEFAULT NULL,
  `details` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for view wms_reports.tbl_view_inv_details_inbound_chiller
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `tbl_view_inv_details_inbound_chiller` (
	`ReceivingDate` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`ControlNumber` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`Beg_Weight` DOUBLE NULL,
	`Out_Weight` INT(10) NOT NULL,
	`Beg_Pallet` BIGINT(19) NOT NULL,
	`Out_Pallet` INT(10) NOT NULL,
	`CustomerID` INT(10) NULL
) ENGINE=MyISAM;

-- Dumping structure for view wms_reports.tbl_view_inv_details_inbound_controlledtemp
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `tbl_view_inv_details_inbound_controlledtemp` (
	`ReceivingDate` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`ControlNumber` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`Beg_Weight` DOUBLE NULL,
	`Out_Weight` INT(10) NOT NULL,
	`Beg_Pallet` BIGINT(19) NOT NULL,
	`Out_Pallet` INT(10) NOT NULL,
	`CustomerID` INT(10) NULL
) ENGINE=MyISAM;

-- Dumping structure for view wms_reports.tbl_view_inv_details_inbound_freezer
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `tbl_view_inv_details_inbound_freezer` (
	`ReceivingDate` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`ControlNumber` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`Beg_Weight` DOUBLE NULL,
	`Out_Weight` INT(10) NOT NULL,
	`Beg_Pallet` BIGINT(19) NOT NULL,
	`Out_Pallet` INT(10) NOT NULL,
	`CustomerID` INT(10) NULL,
	`PalletID` INT(10) NULL
) ENGINE=MyISAM;

-- Dumping structure for view wms_reports.tbl_view_inv_details_inbound_freezericecream
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `tbl_view_inv_details_inbound_freezericecream` (
	`ReceivingDate` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`ControlNumber` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`Beg_Weight` DOUBLE NULL,
	`Out_Weight` INT(10) NOT NULL,
	`Beg_Pallet` BIGINT(19) NOT NULL,
	`Out_Pallet` INT(10) NOT NULL,
	`CustomerID` INT(10) NULL
) ENGINE=MyISAM;

-- Dumping structure for view wms_reports.tbl_view_inv_details_outbound_chiller
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `tbl_view_inv_details_outbound_chiller` (
	`ReceivingDate` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`ControlNumber` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`Beg_Weight` INT(10) NOT NULL,
	`Out_Weight` DOUBLE NULL,
	`Beg_Pallet` INT(10) NOT NULL,
	`Out_Pallet` BIGINT(19) NULL,
	`CustomerID` INT(10) NULL
) ENGINE=MyISAM;

-- Dumping structure for view wms_reports.tbl_view_inv_details_outbound_controlledtemp
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `tbl_view_inv_details_outbound_controlledtemp` (
	`ReceivingDate` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`ControlNumber` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`Beg_Weight` INT(10) NOT NULL,
	`Out_Weight` DOUBLE NULL,
	`Beg_Pallet` INT(10) NOT NULL,
	`Out_Pallet` BIGINT(19) NULL,
	`CustomerID` INT(10) NULL
) ENGINE=MyISAM;

-- Dumping structure for view wms_reports.tbl_view_inv_details_outbound_freezer
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `tbl_view_inv_details_outbound_freezer` (
	`ReceivingDate` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`ControlNumber` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`Beg_Weight` INT(10) NOT NULL,
	`Out_Weight` DOUBLE NULL,
	`Beg_Pallet` INT(10) NOT NULL,
	`Out_Pallet` BIGINT(19) NULL,
	`CustomerID` INT(10) NULL
) ENGINE=MyISAM;

-- Dumping structure for view wms_reports.tbl_view_inv_details_outbound_freezericecream
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `tbl_view_inv_details_outbound_freezericecream` (
	`ReceivingDate` VARCHAR(10) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`ControlNumber` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`Beg_Weight` INT(10) NOT NULL,
	`Out_Weight` DOUBLE NULL,
	`Beg_Pallet` INT(10) NOT NULL,
	`Out_Pallet` BIGINT(19) NULL,
	`CustomerID` INT(10) NULL
) ENGINE=MyISAM;

-- Dumping structure for view wms_reports.tbl_view_issuancelist
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `tbl_view_issuancelist` (
	`id` INT(10) NOT NULL,
	`OBD` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`PCK` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`PalletID` INT(10) NULL,
	`itemid` INT(10) NULL,
	`Receivingitemid` INT(10) NULL
) ENGINE=MyISAM;

-- Dumping structure for view wms_reports.tbl_view_outboundreport
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `tbl_view_outboundreport` (
	`OBD` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`PCK` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`Issued_Weight` DOUBLE NOT NULL,
	`Issued_Quantity` BIGINT(19) NOT NULL
) ENGINE=MyISAM;

-- Dumping structure for view wms_reports.tbl_view_palletout
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `tbl_view_palletout` (
	`PalletID` INT(10) NULL,
	`Quantity` DOUBLE NULL,
	`RoomCode` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`PalletIDLoc` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`Temp` VARCHAR(45) NOT NULL COLLATE 'utf8_general_ci',
	`Capacity` INT(10) NULL,
	`ReservedClient` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`CustomerID` INT(10) NULL
) ENGINE=MyISAM;

-- Dumping structure for view wms_reports.tbl_view_palletutilzation_byroom
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `tbl_view_palletutilzation_byroom` (
	`PalletID` INT(10) NULL,
	`Quantity` DOUBLE NULL,
	`RoomCode` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`PalletIDLoc` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`Temp` VARCHAR(45) NOT NULL COLLATE 'utf8_general_ci',
	`Capacity` INT(10) NULL,
	`ReservedClient` VARCHAR(45) NULL COLLATE 'utf8_general_ci',
	`CustomerID` INT(10) NULL
) ENGINE=MyISAM;

-- Dumping structure for view wms_reports.inventory_masterlistreport_receiving
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `inventory_masterlistreport_receiving`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `wms_reports`.`inventory_masterlistreport_receiving` AS select `cus`.`CustomerID` AS `CustomerID`,`cus`.`CompanyName` AS `CompanyName`,ifnull(sum(`ri`.`Beg_Weight`),0) AS `Weight`,count(distinct `ri`.`PalletID`) AS `PalletID`,left(`rec`.`ReceivingDate`,10) AS `ReceivingDate`,`rec`.`IBN` AS `TransactionNumber`,`cat`.`ItemCategoryID` AS `ItemCategoryID`,`cat`.`ItemCategory` AS `ItemCategory` from ((((`wms_inbound`.`tbl_receivingitems` `ri` left join `wms_inbound`.`tbl_receiving` `rec` on((`ri`.`IBN` = `rec`.`IBN`))) left join `wms_cloud`.`tbl_customers` `cus` on((`ri`.`CustomerID` = `cus`.`CustomerID`))) left join `wms_cloud`.`tbl_items` `item` on((`ri`.`ItemID` = `item`.`ItemID`))) left join `wms_cloud`.`tbl_categories` `cat` on((`item`.`Category` = `cat`.`ItemCategoryID`))) where ((`rec`.`ReceivingDate` between '2000-01-01' and '2030-01-01') and ((`ri`.`ForPutaway` = 0) or (`ri`.`ForPutaway` >= 2)) and (`rec`.`StatusID` <> 5)) group by `cus`.`CustomerID`,`rec`.`ReceivingDate`,`cat`.`ItemCategoryID`;

-- Dumping structure for view wms_reports.tbl_actual_pick_with_weight
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `tbl_actual_pick_with_weight`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `wms_reports`.`tbl_actual_pick_with_weight` AS select `a`.`id` AS `id`,`a`.`PCK` AS `PCK`,`a`.`itemid` AS `itemid`,`a`.`receivingitemid` AS `receivingitemid`,`a`.`status` AS `status`,`b`.`Beg_Weight` AS `Beg_Weight` from (`wms_outbound`.`tbl_actual_pick` `a` left join `wms_inbound`.`tbl_receivingitems` `b` on((`a`.`receivingitemid` = `b`.`ReceivingItemID`)));

-- Dumping structure for view wms_reports.tbl_issuancelist_cbm
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `tbl_issuancelist_cbm`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `wms_reports`.`tbl_issuancelist_cbm` AS select `a`.`id` AS `id`,`a`.`OBD` AS `OBD`,`a`.`PCK` AS `PCK`,`a`.`PalletID` AS `PalletID`,`a`.`itemid` AS `itemid`,`a`.`Receivingitemid` AS `Receivingitemid`,sum(((`b`.`Length` * `b`.`Width`) * `b`.`Height`)) AS `CBM`,group_concat(((`b`.`Length` * `b`.`Width`) * `b`.`Height`) separator ',') AS `CBM2` from (`wms_outbound`.`tbl_issuancelist` `a` left join `wms_cloud`.`tbl_items` `b` on((`a`.`itemid` = `b`.`ItemID`))) group by `a`.`PCK`;

-- Dumping structure for view wms_reports.tbl_itr_report
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `tbl_itr_report`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `wms_reports`.`tbl_itr_report` AS select `ri`.`ReceivingItemID` AS `ReceivingItemID`,`rec`.`ReceivingDate` AS `ReceivingDate`,`rec`.`IBN` AS `IBN`,`item`.`Client_SKU` AS `Client_SKU`,`item`.`ItemDesc` AS `ItemDesc`,(case when (`ri`.`QAReason` = 'GOOD') then sum(`ri`.`Beg_Quantity`) end) AS `GOODQTY`,(case when (`ri`.`QAReason` <> 'GOOD') then sum(`ri`.`Beg_Quantity`) end) AS `HOLDQTY`,sum(`ri`.`Beg_Quantity`) AS `QTY`,sum(`ri`.`Beg_Weight`) AS `WGT`,`ri`.`QAReason` AS `QAReason`,`rec`.`Container` AS `Container`,(case when (`rec`.`StatusID` = 5) then 'Cancel IBN' when ((`rec`.`StatusID` = 3) or (`rec`.`StatusID` = 4)) then 'Done Receiving' when (`rec`.`StatusID` = 2) then 'Received In Progress' when (`rec`.`StatusID` = 1) then 'For Receiving' end) AS `StatusID`,`itemstat`.`ItemStatus` AS `ItemStatus`,`rec`.`CusID` AS `CusID`,`cus`.`WarehouseID` AS `WarehouseID`,`rec`.`CustomerReference` AS `CustomerReference`,`rec`.`Checker` AS `Checker`,group_concat(concat(`item`.`Length`,'x',`item`.`Width`,'x',`item`.`Height`) separator ',') AS `CBM`,sum(((`item`.`Length` * `item`.`Width`) * `item`.`Height`)) AS `CBM2`,`cus`.`CompanyName` AS `CompanyName` from (((((`wms_inbound`.`tbl_receiving` `rec` left join `wms_inbound`.`tbl_receivingitems` `ri` on((`rec`.`IBN` = `ri`.`IBN`))) left join `wms_cloud`.`tbl_items` `item` on((`ri`.`ItemID` = `item`.`ItemID`))) left join `wms_cloud`.`tbl_materials` `mat` on((`item`.`MaterialType` = `mat`.`MaterialID`))) left join `wms_cloud`.`tbl_itemstatus` `itemstat` on((`ri`.`ItemStatusID` = `itemstat`.`ItemStatusID`))) left join `wms_cloud`.`tbl_customers` `cus` on((`ri`.`CustomerID` = `cus`.`CustomerID`))) group by `ri`.`ItemID`,`ri`.`ItemStatusID`,`itemstat`.`ItemStatus`,`rec`.`Container`,`rec`.`IBN`;

-- Dumping structure for view wms_reports.tbl_itr_reportcp
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `tbl_itr_reportcp`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `wms_reports`.`tbl_itr_reportcp` AS select `ri`.`ReceivingItemID` AS `ReceivingItemID`,`rec`.`ReceivingDate` AS `ReceivingDate`,`rec`.`IBN` AS `IBN`,`item`.`Client_SKU` AS `Client_SKU`,`item`.`ItemDesc` AS `ItemDesc`,(case when (`ri`.`QAReason` = 'GOOD') then sum(`ri`.`Beg_Quantity`) end) AS `GOODQTY`,(case when (`ri`.`QAReason` = 'HOLD') then sum(`ri`.`Beg_Quantity`) end) AS `HOLDQTY`,sum(`ri`.`Beg_Quantity`) AS `QTY`,sum(`ri`.`Beg_Weight`) AS `WGT`,`ri`.`QAReason` AS `QAReason`,`rec`.`Container` AS `Container`,(case when (`rec`.`StatusID` = 3) then 'Done Receiving' when (`rec`.`StatusID` = 2) then 'Received In Progress' when (`rec`.`StatusID` = 1) then 'For Receiving' end) AS `StatusID`,`itemstat`.`ItemStatus` AS `ItemStatus`,`rec`.`CusID` AS `CusID`,`cus`.`WarehouseID` AS `WarehouseID`,`rec`.`CustomerReference` AS `CustomerReference`,`rec`.`Checker` AS `Checker`,`rec`.`ASN` AS `ASN`,`rec`.`CPStatus_id` AS `CPStatus_id`,sum(`cpibnitems`.`Beg_Quantity`) AS `CP_QTY`,sum(`cpibnitems`.`Beg_Weight`) AS `CP_WGT` from (((((((`wms_inbound`.`tbl_receiving` `rec` left join `wms_inbound`.`tbl_receivingitems` `ri` on((`rec`.`IBN` = `ri`.`IBN`))) left join `wms_cloud`.`tbl_items` `item` on((`ri`.`ItemID` = `item`.`ItemID`))) left join `wms_cloud`.`tbl_materials` `mat` on((`item`.`MaterialType` = `mat`.`MaterialID`))) left join `wms_cloud`.`tbl_itemstatus` `itemstat` on((`ri`.`ItemStatusID` = `itemstat`.`ItemStatusID`))) left join `wms_cloud`.`tbl_customers` `cus` on((`ri`.`CustomerID` = `cus`.`CustomerID`))) left join `tbl_inbound` `cpibn` on((`rec`.`ASN` = `cpibn`.`CPI`))) left join `tbl_inbounditems` `cpibnitems` on((`cpibn`.`CPI` = `cpibnitems`.`CPI`))) group by `ri`.`ItemID`,`ri`.`ItemStatusID`,`itemstat`.`ItemStatus`,`rec`.`Container`,`rec`.`IBN`;

-- Dumping structure for view wms_reports.tbl_roomtypes_capacity
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `tbl_roomtypes_capacity`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `wms_reports`.`tbl_roomtypes_capacity` AS select `a`.`id` AS `id`,sum(`b`.`Capacity`) AS `Capacity`,`a`.`type` AS `type` from (`wms_cloud`.`tbl_roomtypes` `a` left join `wms_inbound`.`tbl_room` `b` on((`a`.`id` = `b`.`RoomTypeID`))) group by `a`.`id`;

-- Dumping structure for view wms_reports.tbl_view_inv_details_inbound_chiller
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `tbl_view_inv_details_inbound_chiller`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `wms_reports`.`tbl_view_inv_details_inbound_chiller` AS select left(`a`.`ReceivingDate`,10) AS `ReceivingDate`,`a`.`IBN` AS `ControlNumber`,sum(`b`.`Beg_Weight`) AS `Beg_Weight`,0 AS `Out_Weight`,count(distinct `b`.`PalletID`) AS `Beg_Pallet`,0 AS `Out_Pallet`,`b`.`CustomerID` AS `CustomerID` from ((`wms_inbound`.`tbl_receiving` `a` left join `wms_inbound`.`tbl_receivingitems` `b` on((`a`.`IBN` = `b`.`IBN`))) left join `wms_cloud`.`tbl_items` `c` on((`b`.`ItemID` = `c`.`ItemID`))) where ((`a`.`StatusID` <> 5) and (`b`.`Checked` = 'TRUE') and ((`b`.`ForPutaway` = 0) or (`b`.`ForPutaway` >= 2)) and (`c`.`Category` = 3)) group by `b`.`PalletID`;

-- Dumping structure for view wms_reports.tbl_view_inv_details_inbound_controlledtemp
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `tbl_view_inv_details_inbound_controlledtemp`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `wms_reports`.`tbl_view_inv_details_inbound_controlledtemp` AS select left(`a`.`ReceivingDate`,10) AS `ReceivingDate`,`a`.`IBN` AS `ControlNumber`,sum(`b`.`Beg_Weight`) AS `Beg_Weight`,0 AS `Out_Weight`,count(distinct `b`.`PalletID`) AS `Beg_Pallet`,0 AS `Out_Pallet`,`b`.`CustomerID` AS `CustomerID` from ((`wms_inbound`.`tbl_receiving` `a` left join `wms_inbound`.`tbl_receivingitems` `b` on((`a`.`IBN` = `b`.`IBN`))) left join `wms_cloud`.`tbl_items` `c` on((`b`.`ItemID` = `c`.`ItemID`))) where ((`a`.`StatusID` <> 5) and (`b`.`Checked` = 'TRUE') and ((`b`.`ForPutaway` = 0) or (`b`.`ForPutaway` >= 2)) and (`c`.`Category` = 4)) group by `b`.`PalletID`;

-- Dumping structure for view wms_reports.tbl_view_inv_details_inbound_freezer
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `tbl_view_inv_details_inbound_freezer`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `wms_reports`.`tbl_view_inv_details_inbound_freezer` AS select left(`a`.`ReceivingDate`,10) AS `ReceivingDate`,`a`.`IBN` AS `ControlNumber`,sum(`b`.`Beg_Weight`) AS `Beg_Weight`,0 AS `Out_Weight`,count(distinct `b`.`PalletID`) AS `Beg_Pallet`,0 AS `Out_Pallet`,`b`.`CustomerID` AS `CustomerID`,`b`.`PalletID` AS `PalletID` from ((`wms_inbound`.`tbl_receiving` `a` left join `wms_inbound`.`tbl_receivingitems` `b` on((`a`.`IBN` = `b`.`IBN`))) left join `wms_cloud`.`tbl_items` `c` on((`b`.`ItemID` = `c`.`ItemID`))) where ((`a`.`StatusID` <> 5) and (`b`.`Checked` = 'TRUE') and ((`b`.`ForPutaway` = 0) or (`b`.`ForPutaway` >= 2)) and (`c`.`Category` = 1)) group by `b`.`PalletID`;

-- Dumping structure for view wms_reports.tbl_view_inv_details_inbound_freezericecream
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `tbl_view_inv_details_inbound_freezericecream`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `wms_reports`.`tbl_view_inv_details_inbound_freezericecream` AS select left(`a`.`ReceivingDate`,10) AS `ReceivingDate`,`a`.`IBN` AS `ControlNumber`,sum(`b`.`Beg_Weight`) AS `Beg_Weight`,0 AS `Out_Weight`,count(distinct `b`.`PalletID`) AS `Beg_Pallet`,0 AS `Out_Pallet`,`b`.`CustomerID` AS `CustomerID` from ((`wms_inbound`.`tbl_receiving` `a` left join `wms_inbound`.`tbl_receivingitems` `b` on((`a`.`IBN` = `b`.`IBN`))) left join `wms_cloud`.`tbl_items` `c` on((`b`.`ItemID` = `c`.`ItemID`))) where ((`a`.`StatusID` <> 5) and (`b`.`Checked` = 'TRUE') and ((`b`.`ForPutaway` = 0) or (`b`.`ForPutaway` >= 2)) and (`c`.`Category` = 2)) group by `b`.`PalletID`;

-- Dumping structure for view wms_reports.tbl_view_inv_details_outbound_chiller
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `tbl_view_inv_details_outbound_chiller`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `wms_reports`.`tbl_view_inv_details_outbound_chiller` AS select left(`a`.`IssuanceDate`,10) AS `ReceivingDate`,`a`.`OBD` AS `ControlNumber`,0 AS `Beg_Weight`,sum(`c`.`Beg_Weight`) AS `Out_Weight`,0 AS `Beg_Pallet`,(select count(distinct `A`.`palletid`) from (((`wms_outbound`.`tbl_palletout` `A` left join `wms_outbound`.`tbl_issuances` `BB` on((`A`.`obd` = `BB`.`OBD`))) left join `wms_inbound`.`tbl_receivingitems` `C` on((`A`.`palletid` = `C`.`PalletID`))) left join `wms_cloud`.`tbl_items` `D` on((`C`.`ItemID` = `D`.`ItemID`))) where ((`A`.`afterissuance` = 0) and (`D`.`Category` = 3) and ((`BB`.`StatusID` = 3) or (`BB`.`StatusID` = 6)) and (`A`.`obd` = `b`.`OBD`))) AS `Out_Pallet`,`a`.`CustomerID` AS `CustomerID` from (((`wms_outbound`.`tbl_issuances` `a` left join `wms_outbound`.`tbl_issuancelist` `b` on((`a`.`OBD` = `b`.`OBD`))) left join `wms_inbound`.`tbl_receivingitems` `c` on((`b`.`Receivingitemid` = `c`.`ReceivingItemID`))) left join `wms_cloud`.`tbl_items` `d` on((`b`.`itemid` = `d`.`ItemID`))) where (((`a`.`StatusID` = 3) or (`a`.`StatusID` = 6)) and (left(`a`.`IssuanceDate`,10) between '2000-01-01' and '2060-01-01') and (`d`.`Category` = 3)) group by `a`.`OBD`;

-- Dumping structure for view wms_reports.tbl_view_inv_details_outbound_controlledtemp
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `tbl_view_inv_details_outbound_controlledtemp`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `wms_reports`.`tbl_view_inv_details_outbound_controlledtemp` AS select left(`a`.`IssuanceDate`,10) AS `ReceivingDate`,`a`.`OBD` AS `ControlNumber`,0 AS `Beg_Weight`,sum(`c`.`Beg_Weight`) AS `Out_Weight`,0 AS `Beg_Pallet`,(select count(distinct `A`.`palletid`) from (((`wms_outbound`.`tbl_palletout` `A` left join `wms_outbound`.`tbl_issuances` `BB` on((`A`.`obd` = `BB`.`OBD`))) left join `wms_inbound`.`tbl_receivingitems` `C` on((`A`.`palletid` = `C`.`PalletID`))) left join `wms_cloud`.`tbl_items` `D` on((`C`.`ItemID` = `D`.`ItemID`))) where ((`A`.`afterissuance` = 0) and (`D`.`Category` = 4) and ((`BB`.`StatusID` = 3) or (`BB`.`StatusID` = 6)) and (`A`.`obd` = `b`.`OBD`))) AS `Out_Pallet`,`a`.`CustomerID` AS `CustomerID` from ((((`wms_outbound`.`tbl_issuances` `a` left join `wms_outbound`.`tbl_issuancelist` `b` on((`a`.`OBD` = `b`.`OBD`))) left join `wms_inbound`.`tbl_receivingitems` `c` on((`b`.`Receivingitemid` = `c`.`ReceivingItemID`))) left join `wms_inbound`.`tbl_pallets` `e` on((`c`.`PalletID` = `e`.`PalletID`))) left join `wms_cloud`.`tbl_items` `d` on((`b`.`itemid` = `d`.`ItemID`))) where (((`a`.`StatusID` = 3) or (`a`.`StatusID` = 6)) and (left(`a`.`IssuanceDate`,10) between '2000-01-01' and '2060-01-01') and (`d`.`Category` = 4)) group by `a`.`OBD`;

-- Dumping structure for view wms_reports.tbl_view_inv_details_outbound_freezer
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `tbl_view_inv_details_outbound_freezer`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `wms_reports`.`tbl_view_inv_details_outbound_freezer` AS select left(`a`.`IssuanceDate`,10) AS `ReceivingDate`,`a`.`OBD` AS `ControlNumber`,0 AS `Beg_Weight`,sum(`c`.`Beg_Weight`) AS `Out_Weight`,0 AS `Beg_Pallet`,(select count(distinct `A`.`palletid`) from (((`wms_outbound`.`tbl_palletout` `A` left join `wms_outbound`.`tbl_issuances` `BB` on((`A`.`obd` = `BB`.`OBD`))) left join `wms_inbound`.`tbl_receivingitems` `C` on((`A`.`palletid` = `C`.`PalletID`))) left join `wms_cloud`.`tbl_items` `D` on((`C`.`ItemID` = `D`.`ItemID`))) where ((`A`.`afterissuance` = 0) and (`D`.`Category` = 1) and ((`BB`.`StatusID` = 3) or (`BB`.`StatusID` = 6)) and (`A`.`obd` = `b`.`OBD`))) AS `Out_Pallet`,`a`.`CustomerID` AS `CustomerID` from ((((`wms_outbound`.`tbl_issuances` `a` left join `wms_outbound`.`tbl_issuancelist` `b` on((`a`.`OBD` = `b`.`OBD`))) left join `wms_inbound`.`tbl_receivingitems` `c` on((`b`.`Receivingitemid` = `c`.`ReceivingItemID`))) left join `wms_inbound`.`tbl_pallets` `e` on((`c`.`PalletID` = `e`.`PalletID`))) left join `wms_cloud`.`tbl_items` `d` on((`b`.`itemid` = `d`.`ItemID`))) where (((`a`.`StatusID` = 3) or (`a`.`StatusID` = 6)) and (left(`a`.`IssuanceDate`,10) between '2000-01-01' and '2060-01-01') and (`d`.`Category` = 1)) group by `a`.`OBD`;

-- Dumping structure for view wms_reports.tbl_view_inv_details_outbound_freezericecream
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `tbl_view_inv_details_outbound_freezericecream`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `wms_reports`.`tbl_view_inv_details_outbound_freezericecream` AS select left(`a`.`IssuanceDate`,10) AS `ReceivingDate`,`a`.`OBD` AS `ControlNumber`,0 AS `Beg_Weight`,sum(`c`.`Beg_Weight`) AS `Out_Weight`,0 AS `Beg_Pallet`,(select count(distinct `A`.`palletid`) from (((`wms_outbound`.`tbl_palletout` `A` left join `wms_outbound`.`tbl_issuances` `BB` on((`A`.`obd` = `BB`.`OBD`))) left join `wms_inbound`.`tbl_receivingitems` `C` on((`A`.`palletid` = `C`.`PalletID`))) left join `wms_cloud`.`tbl_items` `D` on((`C`.`ItemID` = `D`.`ItemID`))) where ((`A`.`afterissuance` = 0) and (`D`.`Category` = 2) and ((`BB`.`StatusID` = 3) or (`BB`.`StatusID` = 6)) and (`A`.`obd` = `b`.`OBD`))) AS `Out_Pallet`,`a`.`CustomerID` AS `CustomerID` from (((`wms_outbound`.`tbl_issuances` `a` left join `wms_outbound`.`tbl_issuancelist` `b` on((`a`.`OBD` = `b`.`OBD`))) left join `wms_inbound`.`tbl_receivingitems` `c` on((`b`.`Receivingitemid` = `c`.`ReceivingItemID`))) left join `wms_cloud`.`tbl_items` `d` on((`b`.`itemid` = `d`.`ItemID`))) where (((`a`.`StatusID` = 3) or (`a`.`StatusID` = 6)) and (left(`a`.`IssuanceDate`,10) between '2000-01-01' and '2060-01-01') and (`d`.`Category` = 2)) group by `a`.`OBD`;

-- Dumping structure for view wms_reports.tbl_view_issuancelist
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `tbl_view_issuancelist`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `wms_reports`.`tbl_view_issuancelist` AS select `wms_outbound`.`tbl_issuancelist`.`id` AS `id`,`wms_outbound`.`tbl_issuancelist`.`OBD` AS `OBD`,`wms_outbound`.`tbl_issuancelist`.`PCK` AS `PCK`,`wms_outbound`.`tbl_issuancelist`.`PalletID` AS `PalletID`,`wms_outbound`.`tbl_issuancelist`.`itemid` AS `itemid`,`wms_outbound`.`tbl_issuancelist`.`Receivingitemid` AS `Receivingitemid` from `wms_outbound`.`tbl_issuancelist` group by `wms_outbound`.`tbl_issuancelist`.`PCK`;

-- Dumping structure for view wms_reports.tbl_view_outboundreport
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `tbl_view_outboundreport`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `wms_reports`.`tbl_view_outboundreport` AS select `A`.`OBD` AS `OBD`,`A`.`PCK` AS `PCK`,ifnull(sum(`B`.`Beg_Weight`),0) AS `Issued_Weight`,count(distinct `A`.`Receivingitemid`) AS `Issued_Quantity` from (`wms_outbound`.`tbl_issuancelist` `A` left join `wms_inbound`.`tbl_receivingitems` `B` on((`A`.`Receivingitemid` = `B`.`ReceivingItemID`))) group by `A`.`PCK`,`A`.`OBD`;

-- Dumping structure for view wms_reports.tbl_view_palletout
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `tbl_view_palletout`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `wms_reports`.`tbl_view_palletout` AS select `A`.`PalletID` AS `PalletID`,sum(`A`.`Quantity`) AS `Quantity`,`B`.`RoomCode` AS `RoomCode`,`B`.`PalletID` AS `PalletIDLoc`,ifnull(`D`.`type`,'UnAssigned') AS `Temp`,`C`.`Capacity` AS `Capacity`,`B`.`ReservedClient` AS `ReservedClient`,`A`.`CustomerID` AS `CustomerID` from ((((`wms_inbound`.`tbl_receivingitems` `A` left join `wms_inbound`.`tbl_pallets` `Z` on((`A`.`PalletID` = `Z`.`PalletID`))) left join `wms_inbound`.`tbl_locations` `B` on((`Z`.`LocationID` = `B`.`LocationID`))) left join `wms_inbound`.`tbl_room` `C` on((`B`.`RoomCode` = `C`.`RoomCode`))) left join `wms_cloud`.`tbl_roomtypes` `D` on((`C`.`RoomTypeID` = `D`.`id`))) where ((`A`.`ForPutaway` > 1) or (`A`.`ForPutaway` = 0)) group by `A`.`PalletID`;

-- Dumping structure for view wms_reports.tbl_view_palletutilzation_byroom
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `tbl_view_palletutilzation_byroom`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `wms_reports`.`tbl_view_palletutilzation_byroom` AS select `A`.`PalletID` AS `PalletID`,sum(`A`.`Quantity`) AS `Quantity`,`B`.`RoomCode` AS `RoomCode`,`B`.`PalletID` AS `PalletIDLoc`,ifnull(`D`.`type`,'UnAssigned') AS `Temp`,`C`.`Capacity` AS `Capacity`,`B`.`ReservedClient` AS `ReservedClient`,`A`.`CustomerID` AS `CustomerID` from ((((`wms_inbound`.`tbl_receivingitems` `A` left join `wms_inbound`.`tbl_pallets` `Z` on((`A`.`PalletID` = `Z`.`PalletID`))) left join `wms_inbound`.`tbl_locations` `B` on((`Z`.`LocationID` = `B`.`LocationID`))) left join `wms_inbound`.`tbl_room` `C` on((`B`.`RoomCode` = `C`.`RoomCode`))) left join `wms_cloud`.`tbl_roomtypes` `D` on((`C`.`RoomTypeID` = `D`.`id`))) where ((`A`.`ForPutaway` > 1) or (`A`.`ForPutaway` = 0)) group by `C`.`RoomCode`;


-- Dumping database structure for wms_warehouse
CREATE DATABASE IF NOT EXISTS `wms_warehouse` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `wms_warehouse`;

-- Dumping structure for procedure wms_warehouse.sp_inventorymanagement_roomsearch
DELIMITER //
CREATE PROCEDURE `sp_inventorymanagement_roomsearch`(

											IN __items VARCHAR(20),

                                            IN __keys VARCHAR(200)

                                            )
BEGIN

DECLARE _items INT;

IF (__keys IS NULL OR __keys = '') AND __items <> 'all' THEN

	SET _items = __items ;

	SELECT A.RoomID,

	A.RoomName,

	B.type,

	A.RoomCode,

	(SUM(IF(C.LocStatus = 1, 1, 0)) - SUM(IF(C.LoadStatus = 3, 1, 0)) - SUM(IF(C.LocStatus = 6, 1, 0)) - SUM(IF(C.LocStatus = 3, 1, 0))) AS available,

	COUNT(C.LocationID)

	FROM wms_inbound.tbl_room A

	LEFT JOIN wms_cloud.tbl_roomtypes B on A.RoomTypeID = B.id

	LEFT JOIN wms_inbound.tbl_locations C on A.RoomCode = C.RoomCode

	GROUP BY C.RoomCode, A.RoomID LIMIT _items;

ELSEIF (__keys IS NULL OR __keys = '') AND __items = 'all' THEN

	SELECT A.RoomID,

	A.RoomName,

	B.type,

	A.RoomCode,

	(SUM(IF(C.LocStatus = 1, 1, 0)) - SUM(IF(C.LoadStatus = 3, 1, 0)) - SUM(IF(C.LocStatus = 6, 1, 0)) - SUM(IF(C.LocStatus = 3, 1, 0))) AS available,

	COUNT(C.LocationID)

	FROM wms_inbound.tbl_room A

	LEFT JOIN wms_cloud.tbl_roomtypes B on A.RoomTypeID = B.id

	LEFT JOIN wms_inbound.tbl_locations C on A.RoomCode = C.RoomCode

	GROUP BY C.RoomCode, A.RoomID;

ELSEIF (__keys IS NOT NULL OR __keys != '') AND __items = 'all' THEN

	SELECT A.RoomID,

	A.RoomName,

	B.type,

	A.RoomCode,

	(SUM(IF(C.LocStatus = 1, 1, 0)) - SUM(IF(C.LoadStatus = 3, 1, 0)) - SUM(IF(C.LocStatus = 6, 1, 0)) - SUM(IF(C.LocStatus = 3, 1, 0))) AS available,

	COUNT(C.LocationID)

	FROM wms_inbound.tbl_room A

	LEFT JOIN wms_cloud.tbl_roomtypes B on A.RoomTypeID = B.id

	LEFT JOIN wms_inbound.tbl_locations C on A.RoomCode = C.RoomCode

    WHERE (A.RoomName LIKE CONCAT('%',__keys,'%') OR A.RoomCode LIKE CONCAT('%',__keys,'%'))

	GROUP BY C.RoomCode, A.RoomID;

ELSEIF (__keys IS NOT NULL OR __keys != '') AND __items <> 'all' THEN

	SET _items = __items ;

	SELECT A.RoomID,

	A.RoomName,

	B.type,

	A.RoomCode,

	(SUM(IF(C.LocStatus = 1, 1, 0)) - SUM(IF(C.LoadStatus = 3, 1, 0)) - SUM(IF(C.LocStatus = 6, 1, 0)) - SUM(IF(C.LocStatus = 3, 1, 0))) AS available,

	COUNT(C.LocationID)

	FROM wms_inbound.tbl_room A

	LEFT JOIN wms_cloud.tbl_roomtypes B on A.RoomTypeID = B.id

	LEFT JOIN wms_inbound.tbl_locations C on A.RoomCode = C.RoomCode

    WHERE (A.RoomName LIKE CONCAT('%',__keys,'%') OR A.RoomCode LIKE CONCAT('%',__keys,'%'))

	GROUP BY C.RoomCode, A.RoomID LIMIT _items;

END IF;

END//
DELIMITER ;

-- Dumping structure for procedure wms_warehouse.sp_pallettransfer_deletetotransfer
DELIMITER //
CREATE PROCEDURE `sp_pallettransfer_deletetotransfer`(

											IN __ctrl VARCHAR(45),

                                            IN __pid INT

                                            )
BEGIN



DELETE FROM wms_warehouse.tbl_pallettransfers WHERE PT = __ctrl and PalletID = __pid;



END//
DELIMITER ;

-- Dumping structure for procedure wms_warehouse.sp_pallettransfer_generatept
DELIMITER //
CREATE PROCEDURE `sp_pallettransfer_generatept`(

IN __custid INT,

IN __billable VARCHAR(45),

IN __user VARCHAR(45))
BEGIN

	DECLARE temp_pt_id INT;

	SET temp_pt_id = (SELECT TempPT FROM wms_warehouse.tbl_temp LIMIT 1);

	UPDATE wms_warehouse.tbl_temp SET TempPT = temp_pt_id + 1;

    

    INSERT INTO wms_warehouse.tbl_pthistory (`PT`, `CustomerID`, `Billable`, `Date`, `CreatedBy`, `SystemDateCreated`, `LastUpdatedBy`, `Status`)

    VALUES ((concat("PT", LPAD(temp_pt_id,9,0))), __custid, __billable, NOW(), __user, NOW(), __user, 0);

    

    SELECT `PT`, `Date` FROM wms_warehouse.tbl_pthistory WHERE PT = (concat("PT", LPAD(temp_pt_id,9,0)));

END//
DELIMITER ;

-- Dumping structure for procedure wms_warehouse.sp_pallettransfer_onprocesslist
DELIMITER //
CREATE PROCEDURE `sp_pallettransfer_onprocesslist`()
BEGIN



SELECT A.PT,

B.CompanyName,

A.CreatedBy,

A.LastUpdatedBy,

A.SystemDateCreated

FROM wms_warehouse.tbl_pthistory A

LEFT JOIN wms_cloud.tbl_customers B on A.CustomerID = B.CustomerID

WHERE A.Status = 1

ORDER BY A.PT DESC;



END//
DELIMITER ;

-- Dumping structure for procedure wms_warehouse.sp_pallettransfer_openpending
DELIMITER //
CREATE PROCEDURE `sp_pallettransfer_openpending`(

IN __userid VARCHAR(45),

IN __ptno VARCHAR(45))
BEGIN



UPDATE wms_warehouse.tbl_pthistory SET status = 1, LastUpdatedBy = __userid WHERE PT = __ptno;



SELECT A.PT,

A.CustomerID,

B.CompanyName,

A.Date,

A.Billable

FROM wms_warehouse.tbl_pthistory A

LEFT JOIN wms_cloud.tbl_customers B on A.CustomerID = B.CustomerID

WHERE A.PT = __ptno;



END//
DELIMITER ;

-- Dumping structure for procedure wms_warehouse.sp_pallettransfer_palletlist
DELIMITER //
CREATE PROCEDURE `sp_pallettransfer_palletlist`(

IN __custid INT)
BEGIN
	SELECT DISTINCT A.PalletID,

    CONCAT(A.SystemPID, '-', A.ManualPID) as PID,

    GROUP_CONCAT(DISTINCT C.ItemDesc SEPARATOR '/'),

    SUM(B.Quantity),

    SUM(B.Weight),

    GROUP_CONCAT(DISTINCT 
    CASE
		WHEN (B.ExpiryDate = NULL) THEN 'No Expiry'
        ELSE DATE_FORMAT(DATE(B.ExpiryDate), "%Y-%b-%d")
    END
    SEPARATOR ',<br>'),

    GROUP_CONCAT(DISTINCT D.UOM_Abv SEPARATOR '/'),

    CONCAT(E.ColName, '-', RIGHT(E.LCode, 1)) as location,

    E.RoomCode,

    A.LocationID,

    H.RoomName

    FROM wms_inbound.tbl_pallets A

    LEFT JOIN wms_inbound.tbl_receivingitems B on A.PalletID = B.PalletID

    LEFT JOIN wms_cloud.tbl_items C on B.ItemID = C.ItemID

    LEFT JOIN wms_cloud.tbl_weightuom D on C.UOMID = D.UOMID

    LEFT JOIN wms_inbound.tbl_locations E on A.LocationID = E.LocationID

    LEFT JOIN wms_inbound.tbl_room H on E.RoomCode = H.RoomCode

    WHERE B.ForPutaway IN (0,6,7,8)

    AND B.CustomerID = __custid

    AND A.PalletID NOT IN (

		SELECT F.PalletID

        FROM wms_warehouse.tbl_pallettransfers F

        LEFT JOIN wms_warehouse.tbl_pthistory G on F.PT = G.PT

        WHERE G.Status != 2)

	AND B.Quantity > 0

    GROUP BY A.PalletID

    ORDER BY A.SystemPID;


END//
DELIMITER ;

-- Dumping structure for procedure wms_warehouse.sp_pallettransfer_pendinglist
DELIMITER //
CREATE PROCEDURE `sp_pallettransfer_pendinglist`()
BEGIN



SELECT A.PT,

B.CompanyName,

A.CreatedBy,

A.LastUpdatedBy,

A.SystemDateCreated

FROM wms_warehouse.tbl_pthistory A

LEFT JOIN wms_cloud.tbl_customers B on A.CustomerID = B.CustomerID

WHERE A.Status = 0

ORDER BY A.PT DESC;



END//
DELIMITER ;

-- Dumping structure for procedure wms_warehouse.sp_pallettransfer_totransfer
DELIMITER //
CREATE PROCEDURE `sp_pallettransfer_totransfer`(

											IN __ctrl VARCHAR(45)

                                            )
BEGIN

SELECT B.PalletID,

concat(B.SystemPID, '-', B.ManualPID),

GROUP_CONCAT(distinct C.ItemDesc SEPARATOR '/'),

SUM(A.Quantity),

SUM(A.Weight),

E.FromLoc,

E.ToLoc,

GROUP_CONCAT(distinct D.UOM_Abv SEPARATOR '/'),

E.Reason

FROM wms_inbound.tbl_receivingitems A

LEFT JOIN wms_inbound.tbl_pallets B ON A.PalletID = B.PalletID

LEFT JOIN wms_cloud.tbl_items C ON A.ItemID = C.ItemID

LEFT JOIN wms_cloud.tbl_weightuom D ON C.UOMID = D.UOMID

LEFT JOIN wms_warehouse.tbl_pallettransfers E on B.PalletID = E.PalletID

WHERE E.PT = __ctrl

GROUP BY B.PalletID, E.FromLoc, E.ToLoc, E.Reason;

END//
DELIMITER ;

-- Dumping structure for procedure wms_warehouse.sp_pallettransfer_transferpallet
DELIMITER //
CREATE PROCEDURE `sp_pallettransfer_transferpallet`(

											IN __oldloc_id INT,

											IN __loc_id INT,

                                            IN __ctrl VARCHAR(45),

                                            IN __pid INT,

                                            IN __reason VARCHAR(45)

                                            )
BEGIN

DECLARE __oldloc VARCHAR(45);

DECLARE __newloc VARCHAR(45);



SET __oldloc = (SELECT CONCAT(ColName, '-', RIGHT(LCode, 1)) 

				FROM wms_inbound.tbl_locations 

                WHERE LocationID = __oldloc_id

                );



SET __newloc = (SELECT CONCAT(ColName, '-', RIGHT(LCode, 1))

				FROM wms_inbound.tbl_locations

				WHERE LocationID = __loc_id

                );

                

INSERT INTO wms_warehouse.tbl_pallettransfers (`PT`, `PalletID`, `FromLocID`, `FromLoc`, `ToLocID`, `ToLoc`, `Reason`) VALUES (__ctrl, __pid, __oldloc_id, __oldloc, __loc_id, __newloc, __reason);

END//
DELIMITER ;

-- Dumping structure for procedure wms_warehouse.sp_pallettrasnfer_opentransfermap
DELIMITER //
CREATE PROCEDURE `sp_pallettrasnfer_opentransfermap`(

IN __pid INT,

IN __custid INT)
BEGIN

DECLARE __itemcategory VARCHAR(45);



SET __itemcategory = (

SELECT C.ItemCategory

FROM wms_inbound.tbl_receivingitems A

LEFT JOIN wms_cloud.tbl_items B on A.ItemID = B.ItemID

LEFT JOIN wms_cloud.tbl_categories C on B.Category = C.ItemCategoryID

WHERE  A.PalletID = __pid

GROUP BY C.ItemCategoryID);



SELECT A.RoomCode,

A.RoomName

FROM wms_inbound.tbl_room A

LEFT JOIN wms_inbound.tbl_locations B on A.RoomCode = B.RoomCode

LEFT JOIN wms_cloud.tbl_roomtypes C on A.RoomTypeID = C.id

WHERE C.type LIKE CONCAT('%', LEFT(__itemcategory, 5), '%')

AND (B.ReservedClient = __custid OR B.CustomerID = __custid)

AND (B.LocStatus = 3 OR B.LocStatus = 6)

AND A.CustomerID = __custid

GROUP BY A.RoomCode, A.RoomName;

END//
DELIMITER ;

-- Dumping structure for procedure wms_warehouse.sp_user_logs
DELIMITER //
CREATE PROCEDURE `sp_user_logs`(

	IN `_ibn` VARCHAR(200),

	IN `_module` VARCHAR(200),

	IN `_submodule` VARCHAR(200),

	IN `_activity` VARCHAR(200),

	IN `_userid` INT

)
BEGIN

INSERT INTO wms_warehouse.tbl_systemlogs (transaction_no, module, submodule, activity, user_id, datetimestamp) 
VALUES (_ibn, _module, _submodule, _activity, _userid, NOW()); 

END//
DELIMITER ;

-- Dumping structure for table wms_warehouse.tbl_adjustmenthistory
CREATE TABLE IF NOT EXISTS `tbl_adjustmenthistory` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ADJ` varchar(45) DEFAULT NULL,
  `CustomerID` int DEFAULT NULL,
  `Billable` varchar(45) DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  `LastUpdatedBy` varchar(45) DEFAULT NULL,
  `SystemDateCreated` varchar(45) DEFAULT NULL,
  `Type` int DEFAULT NULL,
  `Status` int DEFAULT '1',
  `EndDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_warehouse.tbl_adjustmentitems
CREATE TABLE IF NOT EXISTS `tbl_adjustmentitems` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ADJ` varchar(45) DEFAULT NULL,
  `PalletID` varchar(45) DEFAULT NULL,
  `ItemID` int DEFAULT NULL,
  `RXID` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `Qty_Changed` int DEFAULT NULL,
  `Old_Qty` double DEFAULT NULL,
  `New_Qty` double DEFAULT NULL,
  `Old_Wgt` double DEFAULT NULL,
  `New_Wgt` double DEFAULT NULL,
  `Exp_Changed` int DEFAULT NULL,
  `Old_Exp` varchar(45) DEFAULT NULL,
  `New_Exp` varchar(45) DEFAULT NULL,
  `Status_Changed` int DEFAULT NULL,
  `Old_Status` int DEFAULT NULL,
  `New_Status` int DEFAULT NULL,
  `QR_Changed` int DEFAULT NULL,
  `Old_QR` varchar(45) DEFAULT NULL,
  `New_QR` varchar(45) DEFAULT NULL,
  `Reason` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `Type` varchar(45) DEFAULT NULL,
  `IBN` varchar(50) DEFAULT NULL,
  `isdeleted` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_warehouse.tbl_adjustmentitems_exp
CREATE TABLE IF NOT EXISTS `tbl_adjustmentitems_exp` (
  `id` int NOT NULL,
  `ADJ` varchar(45) DEFAULT NULL,
  `ReceivingItemID` int DEFAULT NULL,
  `Old_Exp` datetime DEFAULT NULL,
  `New_Exp` datetime DEFAULT NULL,
  `Reason` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `Quantity` double DEFAULT NULL,
  `Weight` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_warehouse.tbl_adjustmentitems_itm
CREATE TABLE IF NOT EXISTS `tbl_adjustmentitems_itm` (
  `id` int NOT NULL,
  `ADJ` varchar(45) DEFAULT NULL,
  `ReceivingItemID` int DEFAULT NULL,
  `OldItemID` int DEFAULT NULL,
  `NewItemID` int DEFAULT NULL,
  `Quantity` double DEFAULT NULL,
  `Weight` double DEFAULT NULL,
  `Reason` longtext CHARACTER SET utf8 COLLATE utf8_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_warehouse.tbl_adjustmentitems_status
CREATE TABLE IF NOT EXISTS `tbl_adjustmentitems_status` (
  `id` int NOT NULL,
  `ADJ` varchar(45) DEFAULT NULL,
  `ReceivingItemID` int DEFAULT NULL,
  `Quantity` double DEFAULT NULL,
  `Weight` double DEFAULT NULL,
  `OldStatusID` int DEFAULT NULL,
  `NewStatusID` int DEFAULT NULL,
  `Reason` longtext CHARACTER SET utf8 COLLATE utf8_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_warehouse.tbl_cchistory
CREATE TABLE IF NOT EXISTS `tbl_cchistory` (
  `id` int NOT NULL AUTO_INCREMENT,
  `CC` varchar(45) DEFAULT NULL,
  `CustomerID` int DEFAULT NULL,
  `CountDate` datetime DEFAULT NULL,
  `Status` int DEFAULT NULL,
  `Type` int DEFAULT NULL,
  `isBlind` int DEFAULT NULL,
  `RoomCode` varchar(50) DEFAULT NULL,
  `ItemID` int DEFAULT NULL,
  `ItemMovement` varchar(50) DEFAULT NULL,
  `PriceClass` varchar(50) DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  `LastUpdatedBy` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=554 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_warehouse.tbl_ccitems
CREATE TABLE IF NOT EXISTS `tbl_ccitems` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ReceivingitemID` int DEFAULT NULL,
  `CC` varchar(45) DEFAULT NULL,
  `PID` varchar(45) DEFAULT NULL,
  `ItemDesc` varchar(225) DEFAULT NULL,
  `Quantity` double DEFAULT NULL,
  `Weight` double DEFAULT NULL,
  `UOM` varchar(45) DEFAULT NULL,
  `ExpiryDate` datetime DEFAULT NULL,
  `Location` varchar(45) DEFAULT NULL,
  `ActualLocation` varchar(45) DEFAULT NULL,
  `ActualQuantity` double DEFAULT NULL,
  `ActualWeight` double DEFAULT NULL,
  `ActualExpiry` datetime DEFAULT NULL,
  `Remarks` varchar(45) DEFAULT NULL,
  `QRCode` varchar(45) DEFAULT NULL,
  `HitOrMiss` int DEFAULT NULL,
  `ItemStatus` int DEFAULT NULL,
  `ActualItemStatus` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3559 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_warehouse.tbl_itemtransfers
CREATE TABLE IF NOT EXISTS `tbl_itemtransfers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `IT` varchar(45) DEFAULT NULL,
  `ReceivingItemID` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `FromPallet` int DEFAULT NULL,
  `old_qty` int DEFAULT NULL,
  `new_qty` int DEFAULT NULL,
  `ToPallet` int DEFAULT NULL,
  `transferred_item_qty` varchar(50) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `Reason` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `isdeleted` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_warehouse.tbl_ithistory
CREATE TABLE IF NOT EXISTS `tbl_ithistory` (
  `id` int NOT NULL AUTO_INCREMENT,
  `IT` varchar(45) DEFAULT NULL,
  `CustomerID` int DEFAULT NULL,
  `Billable` varchar(45) DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  `LastUpdatedBy` varchar(45) DEFAULT NULL,
  `SystemDateCreated` varchar(45) DEFAULT NULL,
  `Status` int DEFAULT NULL,
  `EndDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_warehouse.tbl_pallettransfers
CREATE TABLE IF NOT EXISTS `tbl_pallettransfers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `PT` varchar(45) DEFAULT NULL,
  `PalletID` int DEFAULT NULL,
  `FromLocID` int DEFAULT NULL,
  `FromLoc` varchar(45) DEFAULT NULL,
  `ToLocID` int DEFAULT NULL,
  `ToLoc` varchar(45) DEFAULT NULL,
  `Reason` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=546 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_warehouse.tbl_pthistory
CREATE TABLE IF NOT EXISTS `tbl_pthistory` (
  `id` int NOT NULL AUTO_INCREMENT,
  `PT` varchar(45) DEFAULT NULL,
  `CustomerID` int DEFAULT NULL,
  `Billable` varchar(45) DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  `LastUpdatedBy` varchar(45) DEFAULT NULL,
  `SystemDateCreated` datetime DEFAULT NULL,
  `Status` int DEFAULT NULL,
  `EndDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_warehouse.tbl_rephistory
CREATE TABLE IF NOT EXISTS `tbl_rephistory` (
  `id` int NOT NULL AUTO_INCREMENT,
  `REP` varchar(45) DEFAULT NULL,
  `CustomerID` varchar(45) DEFAULT NULL,
  `RoomCode` varchar(45) DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  `LastUpdatedBy` varchar(45) DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `SystemDateCreated` datetime DEFAULT NULL,
  `Status` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_warehouse.tbl_repitems
CREATE TABLE IF NOT EXISTS `tbl_repitems` (
  `id` int NOT NULL AUTO_INCREMENT,
  `REP` varchar(45) DEFAULT NULL,
  `LocationID` int DEFAULT NULL,
  `PalletID` int DEFAULT NULL,
  `ItemID` int DEFAULT NULL,
  `Quantity` double DEFAULT NULL,
  `Weight` double DEFAULT NULL,
  `Expiry` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_warehouse.tbl_systemlogs
CREATE TABLE IF NOT EXISTS `tbl_systemlogs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transaction_no` varchar(255) NOT NULL,
  `module` varchar(255) NOT NULL,
  `submodule` varchar(255) NOT NULL,
  `activity` varchar(255) NOT NULL,
  `user_id` int NOT NULL,
  `datetimestamp` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43727 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table wms_warehouse.tbl_temp
CREATE TABLE IF NOT EXISTS `tbl_temp` (
  `id` int NOT NULL,
  `TempAdj` int DEFAULT '1',
  `TempPT` int DEFAULT NULL,
  `TempIT` int DEFAULT NULL,
  `TempUC` int DEFAULT NULL,
  `TempIC` int DEFAULT NULL,
  `TempREP` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_warehouse.tbl_uchistory
CREATE TABLE IF NOT EXISTS `tbl_uchistory` (
  `id` int NOT NULL AUTO_INCREMENT,
  `UC` varchar(45) DEFAULT NULL,
  `CustomerID` int DEFAULT NULL,
  `Billable` varchar(45) DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  `LastUpdatedBy` varchar(45) DEFAULT NULL,
  `SystemDateCreated` datetime DEFAULT NULL,
  `Status` int DEFAULT NULL,
  `EndDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tbl_uchistory_idx_status` (`Status`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table wms_warehouse.tbl_uomconverted
CREATE TABLE IF NOT EXISTS `tbl_uomconverted` (
  `id` int NOT NULL AUTO_INCREMENT,
  `UC` varchar(45) DEFAULT NULL,
  `PalletID` varchar(255) DEFAULT NULL,
  `ReceivingItemID` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `OldItemID` int DEFAULT NULL,
  `QuantityToConvert` double DEFAULT NULL,
  `WeightToConvert` double DEFAULT NULL,
  `PiecesPerCase` double DEFAULT NULL,
  `NewItemID` int DEFAULT NULL,
  `ConvertedQuantity` double DEFAULT NULL,
  `ConvertedWeight` double DEFAULT NULL,
  `Reason` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `is_deleted` varchar(45) DEFAULT NULL,
  `uc_status` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tbl_uomconverted_idx_uc` (`UC`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
