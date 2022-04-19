-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.22-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for wms_clientportal
CREATE DATABASE IF NOT EXISTS `wms_clientportal` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `wms_clientportal`;

-- Dumping structure for procedure wms_clientportal.Generate_CPI
DELIMITER //
CREATE PROCEDURE `Generate_CPI`(
	IN `in_CPI` VARCHAR(200),
	IN `in_userid` VARCHAR(200),
	IN `in_datenow` VARCHAR(200),
	IN `in_usersID` VARCHAR(200),
	IN `in_createdby` VARCHAR(200),
	IN `in_warehouse` VARCHAR(200)
)
BEGIN
INSERT INTO wms_clientportal.tbl_inbound (`CPI`, `CusID`, `Date_created`, `Status`, `UsersID`) VALUES (in_CPI, in_userid, in_datenow, 0, in_usersID);
INSERT INTO wms_inbound.tbl_receiving (`StatusID`, `CusID`, `CreatedBy`, `LastUpdatedBy`,`FromCP`, `Warehouse_id`, `CPStatus_id`, `ASN`) VALUES (0, in_userid, in_createdby, in_createdby, 'True', in_warehouse, 0, in_CPI); END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_AddedItemsSummary
DELIMITER //
CREATE PROCEDURE `SP_AddedItemsSummary`(IN `__cpi` VARCHAR(200))
BEGIN

	SELECT ii.ReceivingItemID, 

		ii.CPI, 

        i.ItemID, 

        i.ItemDesc, 

        i.ItemCode, 

        i.Client_SKU, 

        uom.UOM_Abv, 

        SUM(ii.Quantity), 

        ii.StorageType, 

        ii.ExpiryDate, 

        SUM(ii.beg_Weight) 

	FROM wms_clientportal.tbl_inbounditems ii

	LEFT JOIN wms_cloud.tbl_items i ON ii.ItemID = i.ItemID

	LEFT JOIN wms_cloud.tbl_weightuom uom ON i.UOMID = uom.UOMID 

	WHERE ii.CPI = __cpi

    GROUP BY i.ItemID, ii.ExpiryDate, ii.ReceivingItemID;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_AvailableItems
DELIMITER //
CREATE PROCEDURE `SP_AvailableItems`(IN `__storagetype` INT, IN `__userid` INT)
BEGIN

	if(__storagetype <> 1) then

		SELECT ItemID, ItemDesc, ItemCode, Client_SKU 

		FROM wms_cloud.tbl_items 

		WHERE ItemCustomerID = __userid

		AND Weight = 0 

		AND Status = 'Active';

	else

		SELECT ItemID, ItemDesc, ItemCode, Client_SKU 

		FROM wms_cloud.tbl_items 

		WHERE ItemCustomerID = __userid

		AND Weight >= 1 

		AND Status = 'Active';

	end if;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_CountOpenCPO
DELIMITER //
CREATE PROCEDURE `SP_CountOpenCPO`(IN `__user_id` INT)
BEGIN

	SELECT COUNT(*)

	FROM wms_clientportal.tbl_storeorder so

	WHERE so.UserID = __user_id AND so.Order_Status = 0;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_CPI_openLimit
DELIMITER //
CREATE PROCEDURE `SP_CPI_openLimit`(IN `__userID` INT)
BEGIN

	SELECT COUNT(*)

	FROM wms_inbound.tbl_receiving r

	LEFT JOIN wms_clientportal.tbl_inbound cpi ON r.ASN = cpi.CPI

	WHERE r.CPStatus_id = 0 AND cpi.UsersID = __userID;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_CPO_openLimit
DELIMITER //
CREATE PROCEDURE `SP_CPO_openLimit`(IN `__userID` VARCHAR(200))
BEGIN

	SELECT COUNT(*)

	FROM wms_clientportal.tbl_storeorder so

	WHERE so.Order_Status = 0 AND so.UserID = __userID;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_forApproveBtn
DELIMITER //
CREATE PROCEDURE `SP_forApproveBtn`(IN `__userID` INT)
BEGIN

	SELECT cu.role_id 

	FROM wms_cloud.tbl_customers_users cu

	LEFT JOIN wms_cloud.tbl_customers c ON cu.CommonCode = c.CustomerCommonCode

	WHERE cu.id = __userID;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_forApproveSetIBN
DELIMITER //
CREATE PROCEDURE `SP_forApproveSetIBN`(IN `__IBN` VARCHAR(200), IN `__CPI_no` VARCHAR(200))
BEGIN

	UPDATE wms_inbound.tbl_receiving SET IBN = __IBN WHERE ASN = __CPI_no;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_forApproveUpdateStatus
DELIMITER //
CREATE PROCEDURE `SP_forApproveUpdateStatus`(IN `__CPI_no` VARCHAR(200))
BEGIN

	UPDATE wms_inbound.tbl_receiving SET CPStatus_id = 4, StatusID = 1 WHERE ASN = __CPI_no;

    

    UPDATE wms_clientportal.tbl_inbound SET Status = 4 WHERE CPI = __CPI_no;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_Generate_CPI
DELIMITER //
CREATE PROCEDURE `SP_Generate_CPI`(IN `__in_CPI` VARCHAR(200), IN `__in_userid` VARCHAR(200), IN `__in_datenow` VARCHAR(200), IN `__in_usersID` VARCHAR(200), IN `__in_createdby` VARCHAR(200), IN `__in_warehouse` VARCHAR(200))
BEGIN

	INSERT INTO wms_clientportal.tbl_inbound (`CPI`, `CusID`, `Date_created`, `Status`, `UsersID`) VALUES (__in_CPI, __in_userid, __in_datenow, '0', __in_usersID);

    

    INSERT INTO wms_inbound.tbl_receiving (`StatusID`, `CusID`, `CreatedBy`, `LastUpdatedBy`,`FromCP`, `Warehouse_id`, `CPStatus_id`, `ASN`) VALUES ('0', __in_userid, __in_createdby, __in_createdby, 'True', __in_warehouse, '0', __in_CPI);

    

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_Generate_CPO
DELIMITER //
CREATE PROCEDURE `SP_Generate_CPO`(IN `__commoncode` VARCHAR(200), IN `__Warehouse` VARCHAR(200), IN `__CPO` VARCHAR(200), IN `__datenow` VARCHAR(200), IN `__usersID` VARCHAR(200))
BEGIN

	INSERT INTO wms_clientportal.tbl_storeorder (CustomerCommon, WarehouseID, CPO, Date_Created, UserID, Order_Status) VALUES (__commoncode, __Warehouse, __CPO, __datenow, __usersID, 0);

    

    INSERT INTO wms_outbound.tbl_ordering (FromCP, CPStatus_id, CPO) VALUES ('true', 0, __CPO);

    

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_GetAllOrderedItems
DELIMITER //
CREATE PROCEDURE `SP_GetAllOrderedItems`(IN `__usersID` INT, IN `__CPO` VARCHAR(200))
BEGIN

	SELECT soi.id, soi.SO, i.ItemDesc, uom.UOM_Abv, soi.Quantity, soi.Weight, soi.GivenQty, soi.id

	FROM wms_clientportal.tbl_storeorder so

	LEFT JOIN wms_clientportal.tbl_storeorderitems soi ON so.CPO = soi.CPO

	LEFT JOIN wms_cloud.tbl_items i ON i.ItemID = soi.ItemID

	LEFT JOIN wms_cloud.tbl_weightuom uom ON i.UOMID = uom.UOMID

	WHERE so.UserID = __usersID AND soi.CPO = __CPO;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_GetASNDetails
DELIMITER //
CREATE PROCEDURE `SP_GetASNDetails`(IN `__asn_cpi` VARCHAR(200))
BEGIN

	SELECT 

		ASN, 

        Warehouse_id, 

        Supplier, 

        Container, 

        VehiclePlate, 

        Seal, 

        RequestedBy,

		  ReceivingDate, 

        CusID, 

        TruckType, 

        Remarks, 

        CPStatus_id 

	FROM wms_inbound.tbl_receiving 

    WHERE FromCP = 'True' AND ASN = __asn_cpi LIMIT 1;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_GetCPODetails
DELIMITER //
CREATE PROCEDURE `SP_GetCPODetails`(IN `__CPO` VARCHAR(200))
BEGIN

	SELECT so.WarehouseID, so.CPO, so.StoreID, so.SO, so.Remarks

	FROM wms_clientportal.tbl_storeorder so

	WHERE so.CPO = __CPO;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_GetForApprovalCount_p
DELIMITER //
CREATE PROCEDURE `SP_GetForApprovalCount_p`(IN `__userID` VARCHAR(200))
BEGIN

	SELECT COUNT(*)

	FROM wms_clientportal.tbl_inbound i

	WHERE i.`Status` = 2 AND i.UsersID = __userID;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_GetForApprovalCount_tm
DELIMITER //
CREATE PROCEDURE `SP_GetForApprovalCount_tm`(IN `__commoncode` VARCHAR(200))
BEGIN

	SELECT COUNT(*)

            FROM wms_clientportal.tbl_inbound i

            LEFT JOIN wms_cloud.tbl_customers_users cu ON i.UsersID = cu.id

            WHERE i.`Status` = 2 AND cu.CommonCode = __commoncode;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_GetForApprovallist_p
DELIMITER //
CREATE PROCEDURE `SP_GetForApprovallist_p`(IN `__userID` VARCHAR(200))
BEGIN

	SELECT i.CPI, date_format(i.Date_created, '%d-%m-%Y'), i.CreatedBy, i.LastUpdatedBy

	FROM wms_clientportal.tbl_inbound i

	WHERE i.`Status` = 2 AND i.UsersID = __userID;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_GetForApprovallist_tm
DELIMITER //
CREATE PROCEDURE `SP_GetForApprovallist_tm`(IN `__cusID` VARCHAR(200))
BEGIN

	SELECT i.CPI, date_format(i.Date_created, '%d-%m-%Y'), i.CreatedBy, i.LastUpdatedBy

	FROM wms_clientportal.tbl_inbound i

	WHERE i.`Status` = 2 AND i.cusID = __cusID;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_GetItemDetailsCanEdit
DELIMITER //
CREATE PROCEDURE `SP_GetItemDetailsCanEdit`(IN `__id` INT)
BEGIN

	SELECT * FROM wms_clientportal.tbl_inbounditems WHERE ReceivingItemID = __id;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_GetListofOrder
DELIMITER //
CREATE PROCEDURE `SP_GetListofOrder`(IN `__CPO` VARCHAR(200))
BEGIN

	SELECT soi.id, i.ItemDesc, uom.UOM_Abv, soi.Quantity, soi.Weight, soi.GivenQty, soi.CPO,i.Client_SKU

	FROM wms_clientportal.tbl_storeorder so 

	LEFT JOIN wms_clientportal.tbl_storeorderitems soi ON so.CPO = soi.CPO 

	LEFT JOIN wms_cloud.tbl_items i ON soi.ItemID = i.ItemID

	LEFT JOIN wms_cloud.tbl_weightuom uom ON i.UOMID = uom.UOMID

	WHERE soi.cpo = __CPO

	ORDER BY soi.ItemID, soi.id;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_GetOnProcessCount
DELIMITER //
CREATE PROCEDURE `SP_GetOnProcessCount`(IN `__userID` VARCHAR(200))
BEGIN

	SELECT COUNT(*)

	FROM wms_clientportal.tbl_inbound i

	WHERE i.`Status` = 2 AND i.UsersID = __userID;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_GetOnProcessList
DELIMITER //
CREATE PROCEDURE `SP_GetOnProcessList`(IN `__cusID` VARCHAR(200))
BEGIN

	SELECT i.CPI, date_format(i.Date_created, '%d-%m-%Y'), cu.CusName

        FROM wms_clientportal.tbl_inbound i

        LEFT JOIN wms_cloud.tbl_customers_users cu ON i.UsersID = cu.id

        WHERE i.`Status` = 2 AND i.UsersID = __cusID;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_GetOpenCount
DELIMITER //
CREATE PROCEDURE `SP_GetOpenCount`(IN `__userID` VARCHAR(200))
BEGIN

	SELECT COUNT(*)

	FROM wms_clientportal.tbl_inbound i

	WHERE i.`Status` = 0 AND i.UsersID = __userID;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_GetOpenIBNList
DELIMITER //
CREATE PROCEDURE `SP_GetOpenIBNList`(IN `__cusID` VARCHAR(200))
BEGIN

	SELECT i.CPI, date_format(i.Date_created, '%d-%m-%Y'), cu.CusName

        FROM wms_clientportal.tbl_inbound i

        LEFT JOIN wms_cloud.tbl_customers_users cu ON i.UsersID = cu.id

        WHERE i.`Status` = 0 AND i.UsersID = __cusID;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_GetOrderDetail
DELIMITER //
CREATE PROCEDURE `SP_GetOrderDetail`(IN `__item_id` INT)
BEGIN

	SELECT so.id, so.Date_Created, so.StoreID, so.CPO, wh.Warehouse

	FROM wms_clientportal.tbl_storeorder so

	LEFT JOIN wms_cloud.tbl_warehouses wh ON so.WarehouseID = wh.WarehouseID

	WHERE so.id = __item_id;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_GetORDList
DELIMITER //
CREATE PROCEDURE `SP_GetORDList`(
	IN `__commoncode` VARCHAR(200)
)
BEGIN
SELECT so.CPO, DATE_FORMAT(so.Date_Created, '%d-%m-%Y'), SUM(soi.Weight), wh.Warehouse, so.Order_Status, o.ORD, so.id, CONCAT(SUM(i.Length) * SUM(i.Width) * SUM(i.Height)), so.CustomerCommon
FROM wms_clientportal.tbl_storeorder so
LEFT JOIN wms_cloud.tbl_warehouses wh ON so.WarehouseID = wh.WarehouseID
LEFT JOIN wms_clientportal.tbl_storeorderitems soi ON so.CPO = soi.CPO
LEFT JOIN wms_outbound.tbl_ordering o ON so.CPO = o.CPO
LEFT JOIN wms_cloud.tbl_items i ON soi.ItemID = i.ItemID
WHERE so.Order_Status IN ('1', '2') 
AND so.CustomerCommon = __commoncode
GROUP BY soi.CPO
ORDER BY soi.CPO DESC; 
END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_GetPendingCount
DELIMITER //
CREATE PROCEDURE `SP_GetPendingCount`(IN `__userID` VARCHAR(200))
BEGIN

	SELECT COUNT(*)

	FROM wms_clientportal.tbl_inbound i

	LEFT JOIN wms_cloud.tbl_customers_users cu ON i.UsersID = cu.id

	WHERE i.`Status` = 1 AND cu.CommonCode = __userID;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_GetPendingList
DELIMITER //
CREATE PROCEDURE `SP_GetPendingList`(IN `__cusID` VARCHAR(200))
BEGIN

	SELECT i.CPI, date_format(i.Date_created, '%d-%m-%Y'), i.CreatedBy, i.LastUpdatedBy

	FROM wms_clientportal.tbl_inbound i

	WHERE i.`Status` = 1 AND i.CusID = __cusID;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_GetSumOfListOrder
DELIMITER //
CREATE PROCEDURE `SP_GetSumOfListOrder`(IN `__CPO` VARCHAR(200))
BEGIN

	SELECT SUM(soi.Quantity), SUM(soi.Weight), SUM(soi.GivenQty)

	FROM wms_clientportal.tbl_storeorderitems soi

	WHERE soi.CPO = __CPO;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_gettrucks
DELIMITER //
CREATE PROCEDURE `SP_gettrucks`()
BEGIN

	SELECT * FROM wms_cloud.tbl_trucktypes;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_GetUOM
DELIMITER //
CREATE PROCEDURE `SP_GetUOM`(IN `__ItemID` VARCHAR(200))
BEGIN

	SELECT uom.UOMID, uom.UOM_Abv 

    FROM wms_cloud.tbl_weightuom uom 

    LEFT JOIN wms_cloud.tbl_items items ON uom.UOMID = items.UOMID 

    WHERE ItemID = __ItemID;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_getwarehouses
DELIMITER //
CREATE PROCEDURE `SP_getwarehouses`(
	IN `__usercommoncode` VARCHAR(50)
)
BEGIN
	SELECT DISTINCT(cus.WarehouseID), wh.Warehouse
	FROM wms_cloud.tbl_customers AS cus
	LEFT JOIN wms_cloud.tbl_warehouses AS wh ON cus.WarehouseID = wh.WarehouseID
	LEFT JOIN wms_cloud.tbl_customers_users cu ON cu.CommonCode = cus.CustomerCommonCode
	WHERE cu.CommonCode = "__usercommoncode";
END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_GetWeight
DELIMITER //
CREATE PROCEDURE `SP_GetWeight`(IN `__storagType` VARCHAR(200), IN `__selected_item` VARCHAR(200))
BEGIN

	SELECT ItemID, Weight

	FROM wms_cloud.tbl_items

	WHERE Weight >= 1 

	AND ItemID = __selected_item;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_openOpenCPOModal
DELIMITER //
CREATE PROCEDURE `SP_openOpenCPOModal`(IN `__userID` INT)
BEGIN

	SELECT so.CPO, cu.CusEmail, date_format(so.Date_Created, '%d-%m-%Y')

	FROM wms_clientportal.tbl_storeorder so

	LEFT JOIN wms_cloud.tbl_customers_users cu ON so.UserID = cu.id

	WHERE so.UserID = __userID AND so.Order_Status = 0;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_openOrderLimit
DELIMITER //
CREATE PROCEDURE `SP_openOrderLimit`(IN `__userID` VARCHAR(200))
BEGIN

	SELECT COUNT(*)

	FROM wms_clientportal.tbl_storeorder so

	WHERE so.Order_Status = 0 AND so.UserID = __userID;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_OrderFWorCW
DELIMITER //
CREATE PROCEDURE `SP_OrderFWorCW`(IN `__selected_item` VARCHAR(200))
BEGIN

	SELECT i.Weight FROM wms_cloud.tbl_items i WHERE ItemID = __selected_item;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_OrderingGetItem
DELIMITER //
CREATE PROCEDURE `SP_OrderingGetItem`(IN `__itemid` INT)
BEGIN

	SELECT soi.GivenQty, soi.Weight FROM wms_clientportal.tbl_storeorderitems soi WHERE soi.id = __itemid;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_OrderRemoveItem
DELIMITER //
CREATE PROCEDURE `SP_OrderRemoveItem`(
	IN `__itemid` INT
)
BEGIN

	UPDATE wms_clientportal.tbl_storeorderitems SET isFloat = 2 WHERE id = __itemid;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_Order_GetAllItems
DELIMITER //
CREATE PROCEDURE `SP_Order_GetAllItems`(IN `__userid` INT)
BEGIN

	SELECT wms_inbound.tbl_receivingitems.ItemID, wms_cloud.tbl_items.ItemDesc, wms_inbound.tbl_receivingitems.CustomerID, wms_cloud.tbl_items.Client_SKU

	FROM wms_inbound.tbl_receivingitems

	LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN

	LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID

	WHERE wms_inbound.tbl_receivingitems.Quantity > 0 

	AND wms_inbound.tbl_receivingitems.Checked = 'True'

	AND wms_inbound.tbl_receivingitems.CustomerID = __userid

	GROUP BY wms_inbound.tbl_receivingitems.ItemID

	ORDER BY wms_inbound.tbl_receivingitems.ItemID;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_PutOrderToOpen
DELIMITER //
CREATE PROCEDURE `SP_PutOrderToOpen`(IN `__itemid` VARCHAR(200))
BEGIN

	UPDATE wms_clientportal.tbl_storeorder SET Order_Status = 0 WHERE id = __itemid;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_RemoveCPOTrans
DELIMITER //
CREATE PROCEDURE `SP_RemoveCPOTrans`(
	IN `__CPO` VARCHAR(200),
	IN `__item_id` VARCHAR(200)
)
BEGIN

	UPDATE wms_clientportal.tbl_storeorderitems SET isFloat = 2 WHERE CPO = __CPO;
	
	UPDATE wms_clientportal.tbl_storeorder SET Order_Status = 0 WHERE id = __item_id;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_removeItem
DELIMITER //
CREATE PROCEDURE `SP_removeItem`(
	IN `__id` INT
)
BEGIN

	UPDATE wms_clientportal.tbl_inbounditems SET StatusID = 2 WHERE ReceivingItemID = __id;
	
END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_ReturntoPending
DELIMITER //
CREATE PROCEDURE `SP_ReturntoPending`(IN `__in_cpi` VARCHAR(200), IN `__in_selected_warehouse` VARCHAR(200), IN `__in_supplier_name` VARCHAR(200), IN `__in_container_no` VARCHAR(200), IN `__in_vehicle_plateno` VARCHAR(200), IN `__in_seal_no` VARCHAR(200), IN `__in_client_rep` VARCHAR(200), IN `__in_date_arrival` VARCHAR(200), IN `__in_remarks` VARCHAR(200), IN `__in_selected_truck` VARCHAR(200), IN `__in_createdby` VARCHAR(200))
BEGIN

	UPDATE wms_inbound.tbl_receiving 

    SET 

		ReceivingDate = __in_date_arrival, 

		Container = __in_container_no, 

		VehiclePlate = __in_vehicle_plateno, 

		Seal = __in_seal_no, 

		Supplier = __in_supplier_name, 

		RequestedBy = __in_client_rep, 

		Warehouse_id = __in_selected_warehouse, 

		LastUpdatedBy = __in_createdby, 

		CPStatus_id = 1, 

		Remarks = __in_remarks,

        TruckType = __in_selected_truck

    WHERE ASN = __in_cpi;

    

    UPDATE wms_clientportal.tbl_inbound i 

    SET 

		i.Status = 1  

    WHERE i.CPI = __in_cpi;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_SubmitASN
DELIMITER //
CREATE PROCEDURE `SP_SubmitASN`(IN `__in_cpi` VARCHAR(200), IN `__in_selected_warehouse` VARCHAR(200), IN `__in_supplier_name` VARCHAR(200), IN `__in_container_no` VARCHAR(200), IN `__in_vehicle_plateno` VARCHAR(200), IN `__in_seal_no` VARCHAR(200), IN `__in_client_rep` VARCHAR(200), IN `__in_date_arrival` VARCHAR(200), IN `__in_remarks` VARCHAR(200), IN `__in_selected_truck` VARCHAR(200))
BEGIN

	UPDATE wms_inbound.tbl_receiving 

	SET 

		ReceivingDate = __in_date_arrival, 

		Container = __in_container_no, 

		VehiclePlate = __in_vehicle_plateno, 

		Seal = __in_seal_no, 

		Supplier = __in_supplier_name, 

		RequestedBy = __in_client_rep, 

		Warehouse_id = __in_selected_warehouse, 

		CPStatus_id = 2, 

		TruckType = __in_selected_truck, 

		Remarks = __in_remarks 

	WHERE ASN = __in_cpi;

	

    UPDATE wms_clientportal.tbl_inbound i 

    SET 

		i.Status = 2 

	WHERE i.CPI = __in_cpi;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_SubmitCompleteASN
DELIMITER //
CREATE PROCEDURE `SP_SubmitCompleteASN`(IN `__CPI_no` VARCHAR(200))
BEGIN

	UPDATE wms_inbound.tbl_receiving SET CPStatus_id = 3 WHERE ASN = __CPI_no;

    

    UPDATE wms_clientportal.tbl_inbound i SET i.Status = 3  WHERE i.CPI = __CPI_no;

END//
DELIMITER ;

-- Dumping structure for procedure wms_clientportal.SP_SubmitForApproval
DELIMITER //
CREATE PROCEDURE `SP_SubmitForApproval`(
	IN `__CPO` VARCHAR(200)
)
BEGIN

	UPDATE wms_clientportal.tbl_storeorder SET Order_Status = '1' WHERE CPO = __CPO;

   UPDATE wms_outbound.tbl_ordering SET CPStatus_id = '1' WHERE CPO = __CPO;

END//
DELIMITER ;

-- Dumping structure for table wms_clientportal.tbl_inbound
CREATE TABLE IF NOT EXISTS `tbl_inbound` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `CPI` varchar(50) DEFAULT NULL,
  `CusID` int(11) DEFAULT NULL,
  `CreatedBy` varchar(50) DEFAULT NULL,
  `LastUpdatedBy` varchar(50) DEFAULT NULL,
  `Date_created` timestamp NULL DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  `UsersID` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table wms_clientportal.tbl_inbound: ~0 rows (approximately)
/*!40000 ALTER TABLE `tbl_inbound` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_inbound` ENABLE KEYS */;

-- Dumping structure for table wms_clientportal.tbl_inbounditems
CREATE TABLE IF NOT EXISTS `tbl_inbounditems` (
  `ReceivingItemID` int(11) NOT NULL AUTO_INCREMENT,
  `CPI` varchar(50) DEFAULT NULL,
  `ItemID` int(11) DEFAULT NULL,
  `Beg_Quantity` double DEFAULT NULL,
  `Beg_Weight` double DEFAULT NULL,
  `Quantity` double DEFAULT NULL,
  `Weight` double DEFAULT NULL,
  `StorageType` varchar(50) DEFAULT NULL,
  `ExpiryDate` timestamp NULL DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  `UserID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ReceivingItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table wms_clientportal.tbl_inbounditems: ~0 rows (approximately)
/*!40000 ALTER TABLE `tbl_inbounditems` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_inbounditems` ENABLE KEYS */;

-- Dumping structure for table wms_clientportal.tbl_order
CREATE TABLE IF NOT EXISTS `tbl_order` (
  `SO` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table wms_clientportal.tbl_order: ~0 rows (approximately)
/*!40000 ALTER TABLE `tbl_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_order` ENABLE KEYS */;

-- Dumping structure for table wms_clientportal.tbl_storeorder
CREATE TABLE IF NOT EXISTS `tbl_storeorder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `SO` varchar(50) DEFAULT NULL,
  `CustomerCommon` varchar(50) DEFAULT NULL,
  `StoreID` varchar(50) DEFAULT NULL,
  `StoreReference` varchar(50) DEFAULT NULL,
  `Remarks` longtext DEFAULT NULL,
  `WarehouseID` int(11) DEFAULT NULL,
  `CPO` varchar(50) DEFAULT NULL,
  `Date_Created` timestamp NULL DEFAULT NULL,
  `Pickup_date` timestamp NULL DEFAULT NULL,
  `UserID` int(11) DEFAULT NULL,
  `Order_Status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- Dumping data for table wms_clientportal.tbl_storeorder: ~1 rows (approximately)
/*!40000 ALTER TABLE `tbl_storeorder` DISABLE KEYS */;
INSERT INTO `tbl_storeorder` (`id`, `SO`, `CustomerCommon`, `StoreID`, `StoreReference`, `Remarks`, `WarehouseID`, `CPO`, `Date_Created`, `Pickup_date`, `UserID`, `Order_Status`) VALUES
	(3, 'Store1', 'MPI0013', 'test', NULL, 'test', 5, 'CPO000000001', '2022-03-03 10:17:55', '0000-00-00 00:00:00', 11, 2),
	(4, 'store2', 'MPI0013', 'test2', NULL, 'test', 5, 'CPO000000002', '2022-03-03 11:33:40', '2022-03-23 11:38:00', 11, 2),
	(5, 'Store3', 'MPI0013', 'test', NULL, 'test', 5, 'CPO000000003', '2022-03-03 11:36:02', '2022-03-31 11:35:00', 11, 2),
	(6, 'Store1', 'MPI0013', '1', NULL, '1', 5, 'CPO000000004', '2022-03-03 11:51:07', '2022-03-31 11:49:00', 10, 2),
	(7, 'Store1', 'MPI0013', '1', NULL, '1', 5, 'CPO000000005', '2022-03-03 12:08:28', '2022-03-30 12:08:00', 10, 2),
	(8, 'Store8', 'MPI0013', 'test', NULL, 'test', 5, 'CPO000000006', '2022-03-03 13:53:45', '2022-03-16 13:53:00', 11, 1),
	(9, 'Store8', 'MPI0013', 'test', NULL, 'test', 5, 'CPO000000007', '2022-03-03 13:55:40', '2022-04-01 13:55:00', 11, 1),
	(10, 'Store8', 'MPI0013', 'test', NULL, 'test', 5, 'CPO000000008', '2022-03-03 14:35:14', '2022-03-29 14:35:00', 11, 1);
/*!40000 ALTER TABLE `tbl_storeorder` ENABLE KEYS */;

-- Dumping structure for table wms_clientportal.tbl_storeorderitems
CREATE TABLE IF NOT EXISTS `tbl_storeorderitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `SO` varchar(50) DEFAULT NULL,
  `ItemID` int(11) NOT NULL,
  `Quantity` double DEFAULT NULL,
  `Weight` double DEFAULT NULL,
  `GivenQty` double DEFAULT NULL,
  `CPO` varchar(50) DEFAULT NULL,
  `isFloat` int(11) DEFAULT NULL,
  `UserID` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=282 DEFAULT CHARSET=utf8;

-- Dumping data for table wms_clientportal.tbl_storeorderitems: ~24 rows (approximately)
/*!40000 ALTER TABLE `tbl_storeorderitems` DISABLE KEYS */;
INSERT INTO `tbl_storeorderitems` (`id`, `SO`, `ItemID`, `Quantity`, `Weight`, `GivenQty`, `CPO`, `isFloat`, `UserID`) VALUES
	(145, 'Store1', 388, 1000, 6480, 1000, 'CPO000000001', 2, 11),
	(146, 'Store1', 389, 1, 86.4, 1, 'CPO000000001', 1, 11),
	(147, 'Store1', 390, 1, 201.6, 1, NULL, 2, 11),
	(148, 'Store1', 391, 1, 324, 1, NULL, 2, 11),
	(149, 'Store1', 392, 1, 86.4, 1, 'CPO000000001', 1, 11),
	(150, 'Store1', 393, 1, 201.6, 1, 'CPO000000001', 1, 11),
	(151, 'Store1', 394, 1, 324, 1, NULL, 2, 11),
	(152, 'Store1', 395, 1, 86.4, 1, NULL, 2, 11),
	(153, 'Store1', 396, 1, 201.6, 1, 'CPO000000001', 1, 11),
	(154, 'Store1', 397, 1, 324, 1, 'CPO000000001', 1, 11),
	(155, 'Store1', 398, 1, 86.4, 1, 'CPO000000001', 1, 11),
	(156, 'Store1', 399, 1, 201.6, 1, 'CPO000000001', 1, 11),
	(157, 'Store1', 400, 1, 324, 1, NULL, 2, 11),
	(158, 'Store1', 401, 1, 86.4, 1, 'CPO000000001', 1, 11),
	(159, 'Store1', 402, 1, 201.6, 1, NULL, 2, 11),
	(160, 'Store1', 403, 1, 324, 1, NULL, 2, 11),
	(161, 'Store1', 404, 1, 86.4, 1, NULL, 2, 11),
	(162, 'Store1', 405, 1, 201.6, 1, NULL, 2, 11),
	(163, 'Store1', 406, 1, 324, 1, 'CPO000000001', 1, 11),
	(164, 'Store1', 407, 1, 86.4, 1, 'CPO000000001', 1, 11),
	(165, 'Store1', 408, 1, 201.6, 1, NULL, 2, 11),
	(166, 'Store1', 2121, 1, 324, 1, NULL, 2, 11),
	(167, 'Store1', 2184, 1, 86.4, 1, NULL, 2, 11),
	(168, 'Store1', 2479, 1, 201.6, 1, NULL, 2, 11),
	(169, 'store2', 398, 10, 80, 10, 'CPO000000002', 1, 11),
	(170, 'store2', 406, 20, 291.6, 20, 'CPO000000002', 1, 11),
	(171, 'Store3', 407, 10, 89.3, 10, 'CPO000000003', 1, 11),
	(172, 'Store3', 390, 10, 86.4, 10, 'CPO000000003', 1, 11),
	(173, 'Store1', 388, 1, 324, 1, 'CPO000000004', 1, 10),
	(174, 'Store1', 389, 1, 86.4, 1, 'CPO000000004', 1, 10),
	(175, 'Store1', 390, 1, 201.6, 1, NULL, 2, 10),
	(176, 'Store1', 391, 1, 324, 1, NULL, 2, 10),
	(177, 'Store1', 392, 1, 86.4, 1, 'CPO000000004', 1, 10),
	(178, 'Store1', 393, 1, 201.6, 1, 'CPO000000004', 1, 10),
	(179, 'Store1', 394, 1, 324, 1, NULL, 2, 10),
	(180, 'Store1', 395, 1, 86.4, 1, NULL, 2, 10),
	(181, 'Store1', 396, 1, 201.6, 1, 'CPO000000004', 1, 10),
	(182, 'Store1', 397, 1, 324, 1, 'CPO000000004', 1, 10),
	(183, 'Store1', 398, 1, 86.4, 1, 'CPO000000004', 1, 10),
	(184, 'Store1', 399, 1, 201.6, 1, 'CPO000000004', 1, 10),
	(185, 'Store1', 400, 1, 324, 1, NULL, 2, 10),
	(186, 'Store1', 401, 1, 86.4, 1, 'CPO000000004', 1, 10),
	(187, 'Store1', 402, 1, 201.6, 1, NULL, 2, 10),
	(188, 'Store1', 403, 1, 324, 1, NULL, 2, 10),
	(189, 'Store1', 404, 1, 86.4, 1, NULL, 2, 10),
	(190, 'Store1', 405, 1, 201.6, 1, NULL, 2, 10),
	(191, 'Store1', 406, 1, 324, 1, 'CPO000000004', 1, 10),
	(192, 'Store1', 407, 1, 86.4, 1, NULL, 2, 10),
	(193, 'Store1', 408, 1, 201.6, 1, NULL, 2, 10),
	(194, 'Store1', 2121, 1, 324, 1, NULL, 2, 10),
	(195, 'Store1', 2184, 1, 86.4, 1, NULL, 2, 10),
	(196, 'Store1', 2479, 1, 201.6, 1, NULL, 2, 10),
	(197, 'Store1', 388, 2, 12.96, 2, 'CPO000000005', 1, 10),
	(198, 'Store1', 389, 1, 8.93, 1, 'CPO000000005', 1, 10),
	(199, 'Store1', 390, 1, 8.64, 1, 'CPO000000005', 1, 10),
	(200, 'Store1', 391, 1, 11.52, 1, NULL, 2, 10),
	(201, 'Store1', 392, 1, 12, 1, 'CPO000000005', 1, 10),
	(202, 'Store1', 393, 1, 8.16, 1, 'CPO000000005', 1, 10),
	(203, 'Store1', 394, 1, 8.93, 1, NULL, 2, 10),
	(204, 'Store1', 395, 1, 8, 1, NULL, 2, 10),
	(205, 'Store1', 396, 1, 8, 1, 'CPO000000005', 1, 10),
	(206, 'Store1', 397, 1, 8, 1, 'CPO000000005', 1, 10),
	(207, 'Store1', 398, 1, 8, 1, 'CPO000000005', 1, 10),
	(208, 'Store1', 399, 1, 6.72, 1, 'CPO000000005', 1, 10),
	(209, 'Store1', 400, 1, 8, 1, NULL, 2, 10),
	(210, 'Store1', 401, 1, 9.6, 1, 'CPO000000005', 1, 10),
	(211, 'Store1', 402, 1, 8, 1, NULL, 2, 10),
	(212, 'Store1', 403, 1, 8, 1, NULL, 2, 10),
	(213, 'Store1', 404, 1, 6.48, 1, NULL, 2, 10),
	(214, 'Store1', 405, 1, 8, 1, NULL, 2, 10),
	(215, 'Store1', 406, 1, 14.58, 1, 'CPO000000005', 1, 10),
	(216, 'Store1', 407, 1, 8.93, 1, 'CPO000000005', 1, 10),
	(217, 'Store1', 408, 1, 8.93, 1, NULL, 2, 10),
	(218, 'Store1', 2121, 1, 0, 1, 'CPO000000005', 1, 10),
	(219, 'Store1', 2184, 1, 1, 1, NULL, 2, 10),
	(220, 'Store1', 2479, 1, 10, 1, NULL, 2, 10),
	(221, 'Store8', 388, 1, 6.48, 1, NULL, 2, 10),
	(222, 'Store8', 389, 1, 8.93, 1, NULL, 2, 10),
	(223, 'Store8', 390, 1, 8.64, 1, NULL, 2, 10),
	(224, 'Store8', 391, 1, 11.52, 1, NULL, 2, 10),
	(225, 'Store8', 388, 1, 6.48, 1, NULL, 2, 10),
	(226, 'Store8', 389, 1, 8.93, 1, NULL, 2, 10),
	(227, 'Store8', 390, 1, 8.64, 1, NULL, 2, 10),
	(228, 'Store8', 391, 1, 11.52, 1, NULL, 2, 10),
	(229, 'Store8', 388, 1, 6.48, 1, 'CPO000000006', 1, 11),
	(230, 'Store8', 389, 1, 8.93, 1, 'CPO000000006', 1, 11),
	(231, 'Store8', 390, 1, 8.64, 1, 'CPO000000006', 1, 11),
	(232, 'Store8', 391, 1, 11.52, 1, NULL, 2, 11),
	(233, 'Store8', 388, 1, 6.48, 1, 'CPO000000007', 1, 11),
	(234, 'Store8', 389, 1, 8.93, 1, 'CPO000000007', 1, 11),
	(235, 'Store8', 390, 1, 8.64, 1, 'CPO000000007', 1, 11),
	(236, 'Store8', 391, 1, 11.52, 1, NULL, 2, 11),
	(237, 'Store8', 388, 1, 6.48, 1, NULL, 2, 11),
	(238, 'Store8', 389, 1, 8.93, 1, 'CPO000000008', 1, 11),
	(239, 'Store8', 390, 1, 8.64, 1, NULL, 2, 11),
	(240, 'Store8', 391, 1, 11.52, 1, NULL, 2, 11),
	(241, 'Store8', 388, 1, 6.48, 1, NULL, 2, 11),
	(242, 'Store8', 389, 1, 8.93, 1, NULL, 2, 11),
	(243, 'Store8', 390, 1, 8.64, 1, NULL, 2, 11),
	(244, 'Store8', 391, 1, 11.52, 1, NULL, 2, 11),
	(245, 'Store8', 388, 1, 6.48, 1, NULL, 2, 11),
	(246, 'Store8', 389, 1, 8.93, 1, NULL, 2, 11),
	(247, 'Store8', 390, 1, 8.64, 1, NULL, 2, 11),
	(248, 'Store8', 391, 1, 11.52, 1, NULL, 2, 11),
	(249, 'Store8', 388, 1, 6.48, 1, NULL, 2, 11),
	(250, 'Store8', 389, 1, 8.93, 1, NULL, 2, 11),
	(251, 'Store8', 390, 1, 8.64, 1, NULL, 2, 11),
	(252, 'Store8', 391, 1, 11.52, 1, NULL, 2, 11),
	(253, 'Store8', 388, 1, 6.48, 1, NULL, 2, 11),
	(254, 'Store8', 389, 1, 8.93, 1, NULL, 2, 11),
	(255, 'Store8', 390, 1, 8.64, 1, NULL, 2, 11),
	(256, 'Store8', 391, 1, 11.52, 1, NULL, 2, 11),
	(257, 'Store8', 388, 1, 6.48, 1, NULL, 2, 11),
	(258, 'Store8', 389, 1, 8.93, 1, NULL, 2, 11),
	(259, 'Store8', 390, 1, 8.64, 1, NULL, 2, 11),
	(260, 'Store8', 391, 1, 11.52, 1, NULL, 2, 11),
	(261, 'Store8', 388, 1, 6.48, 1, NULL, 2, 11),
	(262, 'Store8', 389, 1, 8.93, 1, NULL, 2, 11),
	(263, 'Store8', 390, 1, 8.64, 1, NULL, 2, 11),
	(264, 'Store8', 391, 1, 11.52, 1, NULL, 2, 11),
	(265, 'Store8', 388, 1, 6.48, 1, NULL, 2, 11),
	(266, 'Store8', 389, 1, 8.93, 1, NULL, 2, 11),
	(267, 'Store8', 390, 1, 8.64, 1, NULL, 2, 11),
	(268, 'Store8', 391, 1, 11.52, 1, NULL, 2, 11),
	(269, 'Store8', 388, 1, 6.48, 1, NULL, 2, 11),
	(270, 'Store8', 389, 1, 8.93, 1, NULL, 2, 11),
	(271, 'Store8', 390, 1, 8.64, 1, NULL, 2, 11),
	(272, 'Store8', 391, 1, 11.52, 1, NULL, 2, 11),
	(273, 'Store8', 388, 1, 6.48, 1, NULL, 2, 11),
	(274, 'Store8', 389, 1, 8.93, 1, NULL, 2, 11),
	(275, 'Store8', 390, 1, 8.64, 1, NULL, 2, 11),
	(276, 'Store8', 391, 1, 11.52, 1, NULL, 2, 11),
	(277, 'Store8', 388, 1, 6.48, 1, 'CPO000000008', 1, 11),
	(278, 'Store8', 389, 1, 8.93, 1, 'CPO000000008', 1, 11),
	(279, 'Store8', 390, 1, 8.64, 1, 'CPO000000008', 1, 11),
	(280, 'Store8', 391, 1, 11.52, 1, NULL, 2, 11),
	(281, 'Store8', 401, 10, 96, 10, 'CPO000000008', 1, 11);
/*!40000 ALTER TABLE `tbl_storeorderitems` ENABLE KEYS */;

-- Dumping structure for table wms_clientportal.tbl_temp
CREATE TABLE IF NOT EXISTS `tbl_temp` (
  `id` int(11) NOT NULL,
  `TempSO` int(11) DEFAULT NULL,
  `TempCPI` int(11) DEFAULT NULL,
  `TempCPO` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table wms_clientportal.tbl_temp: ~0 rows (approximately)
/*!40000 ALTER TABLE `tbl_temp` DISABLE KEYS */;
INSERT INTO `tbl_temp` (`id`, `TempSO`, `TempCPI`, `TempCPO`) VALUES
	(1, 2, 0, 8);
/*!40000 ALTER TABLE `tbl_temp` ENABLE KEYS */;

-- Dumping structure for table wms_clientportal.tbl_users_session
CREATE TABLE IF NOT EXISTS `tbl_users_session` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `session_start` timestamp NULL DEFAULT NULL,
  `session_stop` timestamp NULL DEFAULT NULL,
  `session_status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Dumping data for table wms_clientportal.tbl_users_session: ~0 rows (approximately)
/*!40000 ALTER TABLE `tbl_users_session` DISABLE KEYS */;
INSERT INTO `tbl_users_session` (`id`, `user_id`, `session_start`, `session_stop`, `session_status`) VALUES
	(1, 10, '2022-03-03 10:24:45', NULL, 'active');
/*!40000 ALTER TABLE `tbl_users_session` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
