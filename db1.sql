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


-- Dumping database structure for wms_clientportal
CREATE DATABASE IF NOT EXISTS `wms_clientportal` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
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
  `id` int NOT NULL AUTO_INCREMENT,
  `CPI` varchar(50) DEFAULT NULL,
  `CusID` int DEFAULT NULL,
  `CreatedBy` varchar(50) DEFAULT NULL,
  `LastUpdatedBy` varchar(50) DEFAULT NULL,
  `Date_created` timestamp NULL DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  `UsersID` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_clientportal.tbl_inbound: ~23 rows (approximately)
/*!40000 ALTER TABLE `tbl_inbound` DISABLE KEYS */;
INSERT INTO `tbl_inbound` (`id`, `CPI`, `CusID`, `CreatedBy`, `LastUpdatedBy`, `Date_created`, `Status`, `UsersID`) VALUES
	(1, 'CPI000000001', 16, 'Mondelez Planner', 'Mondelez Planner', '2022-03-18 07:54:15', '3', 11),
	(2, 'CPI000000002', 16, 'Mondelez Planner', 'Mondelez Planner', '2022-03-22 19:13:05', '3', 11),
	(3, 'CPI000000003', 16, 'Mondelez Planner', 'Mondelez Planner', '2022-03-22 19:15:26', '3', 11),
	(4, 'CPI000000004', 16, 'Mondelez Planner', 'Mondelez Planner', '2022-03-23 15:38:10', '3', 11),
	(5, 'CPI000000005', 18, 'Andrew P Borbon', 'Andrew P Borbon', '2022-03-25 11:45:27', '3', 3),
	(6, 'CPI000000006', 18, 'Andrew P Borbon', 'Andrew P Borbon', '2022-03-26 11:41:24', '3', 3),
	(7, 'CPI000000007', 18, 'Andrew P Borbon', 'Andrew P Borbon', '2022-03-26 11:43:57', '3', 3),
	(8, 'CPI000000008', 85, 'Ms. Janice Alfonso', 'Ms. Janice Alfonso', '2022-03-29 10:49:56', '3', 30),
	(9, 'CPI000000009', 85, 'Ms. Janice Alfonso', 'Ms. Janice Alfonso', '2022-03-31 14:47:56', '3', 30),
	(10, 'CPI000000010', 85, 'Ms. Janice Alfonso', 'Ms. Janice Alfonso', '2022-03-31 16:26:06', '3', 30),
	(11, 'CPI000000011', 85, 'Ms. Janice Alfonso', 'Ms. Janice Alfonso', '2022-04-01 15:38:41', '3', 30),
	(12, 'CPI000000012', 85, 'Ms. Janice Alfonso', 'Ms. Janice Alfonso', '2022-04-02 09:14:15', '3', 30),
	(13, 'CPI000000013', 85, 'Ms. Janice Alfonso', 'Ms. Janice Alfonso', '2022-04-05 09:01:43', '3', 30),
	(14, 'CPI000000014', 18, 'Andrew P Borbon', 'Andrew P Borbon', '2022-04-05 11:14:40', '3', 3),
	(15, 'CPI000000015', 85, 'Ms. Janice Alfonso', 'Ms. Janice Alfonso', '2022-04-05 15:16:24', '3', 30),
	(16, 'CPI000000016', 18, 'Andrew P Borbon', 'Andrew P Borbon', '2022-04-06 08:38:39', '3', 3),
	(17, 'CPI000000017', 18, 'Andrew P Borbon', 'Andrew P Borbon', '2022-04-06 08:47:02', '3', 3),
	(18, 'CPI000000018', 85, 'Ms. Janice Alfonso', 'Ms. Janice Alfonso', '2022-04-06 15:45:10', '3', 30),
	(19, 'CPI000000019', 85, 'Ms. Janice Alfonso', 'Ms. Janice Alfonso', '2022-04-07 10:30:36', '3', 30),
	(20, 'CPI000000020', 18, 'Andrew P Borbon', 'Andrew P Borbon', '2022-04-11 08:05:33', '3', 3),
	(21, 'CPI000000021', 18, 'Andrew P Borbon', 'Andrew P Borbon', '2022-04-11 09:14:08', '3', 3),
	(22, 'CPI000000022', 16, 'Aaron Joseph A. Lozano', 'Aaron Joseph A. Lozano', '2022-04-11 09:47:15', '3', 10),
	(23, 'CPI000000023', 16, 'Aaron Joseph A. Lozano', 'Aaron Joseph A. Lozano', '2022-04-11 10:05:05', '3', 10),
	(24, 'CPI000000024', 85, 'Ms. Janice Alfonso', 'Ms. Janice Alfonso', '2022-04-13 15:15:35', '3', 30);
/*!40000 ALTER TABLE `tbl_inbound` ENABLE KEYS */;

-- Dumping structure for table wms_clientportal.tbl_inbounditems
CREATE TABLE IF NOT EXISTS `tbl_inbounditems` (
  `ReceivingItemID` int NOT NULL AUTO_INCREMENT,
  `CPI` varchar(50) DEFAULT NULL,
  `ItemID` int DEFAULT NULL,
  `Beg_Quantity` double DEFAULT NULL,
  `Beg_Weight` double DEFAULT NULL,
  `Quantity` double DEFAULT NULL,
  `Weight` double DEFAULT NULL,
  `StorageType` varchar(50) DEFAULT NULL,
  `ExpiryDate` timestamp NULL DEFAULT NULL,
  `StatusID` int DEFAULT NULL,
  `UserID` int DEFAULT NULL,
  PRIMARY KEY (`ReceivingItemID`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_clientportal.tbl_inbounditems: ~118 rows (approximately)
/*!40000 ALTER TABLE `tbl_inbounditems` DISABLE KEYS */;
INSERT INTO `tbl_inbounditems` (`ReceivingItemID`, `CPI`, `ItemID`, `Beg_Quantity`, `Beg_Weight`, `Quantity`, `Weight`, `StorageType`, `ExpiryDate`, `StatusID`, `UserID`) VALUES
	(1, 'CPI000000001', 388, 10, 64.8, 10, 64.8, '1', '2022-03-19 00:00:00', 1, 11),
	(2, 'CPI000000001', 389, 10, 89.3, 10, 89.3, '1', '2022-03-26 00:00:00', 1, 11),
	(3, 'CPI000000001', 2121, 20, 0, 20, 0, '2', '2022-03-19 00:00:00', 1, 11),
	(4, NULL, 71, 50, 350, 50, 350, '1', '2021-01-01 00:00:00', 2, 4),
	(5, NULL, 72, 10, 70, 10, 70, '1', '2021-01-25 00:00:00', 2, 4),
	(6, NULL, 73, 30, 150, 30, 150, '1', '2021-01-12 00:00:00', 2, 4),
	(7, NULL, 74, 12, 72, 12, 72, '1', '2021-01-13 00:00:00', 2, 4),
	(8, NULL, 75, 10, 80, 10, 80, '1', '2021-01-14 00:00:00', 2, 4),
	(9, NULL, 76, 40, 400, 40, 400, '1', '2021-01-15 00:00:00', 2, 4),
	(10, 'CPI000000002', 388, 10, 64.8, 10, 64.8, '1', '2022-03-22 00:00:00', 1, 11),
	(11, 'CPI000000002', 389, 10, 89.3, 10, 89.3, '1', '2022-03-23 00:00:00', 1, 11),
	(12, 'CPI000000002', 390, 10, 86.4, 10, 86.4, '1', '2022-03-24 00:00:00', 1, 11),
	(13, 'CPI000000002', 391, 10, 115.2, 10, 115.2, '1', '2022-03-25 00:00:00', 1, 11),
	(14, 'CPI000000002', 392, 10, 120, 10, 120, '1', '2022-03-26 00:00:00', 1, 11),
	(15, 'CPI000000002', 393, 10, 81.6, 10, 81.6, '1', '2022-03-27 00:00:00', 1, 11),
	(16, 'CPI000000002', 394, 10, 89.3, 10, 89.3, '1', '2022-03-28 00:00:00', 1, 11),
	(17, 'CPI000000002', 395, 10, 80, 10, 80, '1', '2022-03-29 00:00:00', 1, 11),
	(18, 'CPI000000002', 396, 10, 80, 10, 80, '1', '2022-03-30 00:00:00', 1, 11),
	(19, 'CPI000000002', 397, 10, 80, 10, 80, '1', '2022-03-31 00:00:00', 1, 11),
	(20, 'CPI000000002', 398, 10, 80, 10, 80, '1', '2022-04-01 00:00:00', 1, 11),
	(21, 'CPI000000002', 399, 10, 67.2, 10, 67.2, '1', '2022-04-02 00:00:00', 1, 11),
	(22, 'CPI000000002', 400, 10, 80, 10, 80, '1', '2022-04-03 00:00:00', 1, 11),
	(23, 'CPI000000002', 401, 10, 96, 10, 96, '1', '2022-04-04 00:00:00', 1, 11),
	(24, 'CPI000000002', 402, 10, 80, 10, 80, '1', '2022-04-05 00:00:00', 1, 11),
	(25, 'CPI000000002', 403, 10, 80, 10, 80, '1', '2022-04-06 00:00:00', 1, 11),
	(26, 'CPI000000002', 404, 10, 64.8, 10, 64.8, '1', '2022-04-07 00:00:00', 1, 11),
	(27, 'CPI000000002', 405, 10, 80, 10, 80, '1', '2022-04-08 00:00:00', 1, 11),
	(28, 'CPI000000002', 406, 10, 145.8, 10, 145.8, '1', '2022-04-09 00:00:00', 1, 11),
	(29, 'CPI000000002', 407, 10, 89.3, 10, 89.3, '1', '2022-04-10 00:00:00', 1, 11),
	(30, 'CPI000000002', 408, 10, 89.3, 10, 89.3, '1', '2022-04-11 00:00:00', 1, 11),
	(31, 'CPI000000002', 2121, 10, 0, 10, 0, '2', '2022-04-12 00:00:00', 1, 11),
	(32, 'CPI000000002', 2184, 10, 10, 10, 10, '1', '2022-04-13 00:00:00', 1, 11),
	(33, 'CPI000000002', 2479, 10, 100, 10, 100, '1', '2022-04-14 00:00:00', 1, 11),
	(34, 'CPI000000003', 388, 15, 97.2, 15, 97.2, '1', '2022-03-24 00:00:00', 1, 11),
	(35, 'CPI000000003', 2121, 15, 0, 15, 0, '2', '2022-03-30 00:00:00', 1, 11),
	(36, 'CPI000000022', 388, 10, 64.8, 10, 64.8, '1', '2022-03-22 00:00:00', 1, 10),
	(37, 'CPI000000022', 389, 10, 89.3, 10, 89.3, '1', '2022-03-23 00:00:00', 1, 10),
	(38, 'CPI000000022', 390, 10, 86.4, 10, 86.4, '1', '2022-03-24 00:00:00', 1, 10),
	(39, 'CPI000000022', 391, 10, 115.2, 10, 115.2, '1', '2022-03-25 00:00:00', 1, 10),
	(40, 'CPI000000022', 392, 10, 120, 10, 120, '1', '2022-03-26 00:00:00', 1, 10),
	(41, 'CPI000000022', 393, 10, 81.6, 10, 81.6, '1', '2022-03-27 00:00:00', 1, 10),
	(42, 'CPI000000022', 394, 10, 89.3, 10, 89.3, '1', '2022-03-28 00:00:00', 1, 10),
	(43, 'CPI000000022', 395, 10, 80, 10, 80, '1', '2022-03-29 00:00:00', 1, 10),
	(44, 'CPI000000022', 396, 10, 80, 10, 80, '1', '2022-03-30 00:00:00', 1, 10),
	(45, 'CPI000000022', 397, 10, 80, 10, 80, '1', '2022-03-31 00:00:00', 1, 10),
	(46, 'CPI000000022', 398, 10, 80, 10, 80, '1', '2022-04-01 00:00:00', 1, 10),
	(47, 'CPI000000022', 399, 10, 67.2, 10, 67.2, '1', '2022-04-02 00:00:00', 1, 10),
	(48, 'CPI000000022', 400, 10, 80, 10, 80, '1', '2022-04-03 00:00:00', 1, 10),
	(49, 'CPI000000022', 401, 10, 96, 10, 96, '1', '2022-04-04 00:00:00', 1, 10),
	(50, 'CPI000000022', 402, 10, 80, 10, 80, '1', '2022-04-05 00:00:00', 1, 10),
	(51, 'CPI000000022', 403, 10, 80, 10, 80, '1', '2022-04-06 00:00:00', 1, 10),
	(52, 'CPI000000022', 404, 10, 64.8, 10, 64.8, '1', '2022-04-07 00:00:00', 1, 10),
	(53, 'CPI000000022', 405, 10, 80, 10, 80, '1', '2022-04-08 00:00:00', 1, 10),
	(54, 'CPI000000022', 406, 10, 145.8, 10, 145.8, '1', '2022-04-09 00:00:00', 1, 10),
	(55, 'CPI000000022', 407, 10, 89.3, 10, 89.3, '1', '2022-04-10 00:00:00', 1, 10),
	(56, 'CPI000000022', 408, 10, 89.3, 10, 89.3, '1', '2022-04-11 00:00:00', 1, 10),
	(57, 'CPI000000022', 2121, 10, 0, 10, 0, '2', '2022-04-12 00:00:00', 1, 10),
	(58, 'CPI000000022', 2184, 10, 10, 10, 10, '1', '2022-04-13 00:00:00', 1, 10),
	(59, 'CPI000000022', 2479, 10, 100, 10, 100, '1', '2022-04-14 00:00:00', 1, 10),
	(60, 'CPI000000004', 389, 10, 89.3, 10, 89.3, '1', '2022-03-27 00:00:00', 1, 11),
	(61, 'CPI000000004', 390, 10, 86.4, 10, 86.4, '1', '2022-04-09 00:00:00', 1, 11),
	(62, 'CPI000000004', 2479, 10, 100, 10, 100, '1', '2022-04-09 00:00:00', 1, 11),
	(63, 'CPI000000004', 2121, 10, 100, 10, 100, '2', '2022-03-25 00:00:00', 1, 11),
	(64, 'CPI000000005', 97, 28, 196, 28, 196, '1', '2023-08-04 00:00:00', 1, 3),
	(65, 'CPI000000006', 109, 142, 1136, 142, 1136, '1', '2023-01-27 00:00:00', 1, 3),
	(66, 'CPI000000006', 75, 123, 984, 123, 984, '1', '2023-01-27 00:00:00', 1, 3),
	(67, 'CPI000000006', 387, 160, 160, 160, 160, '1', '2023-01-27 00:00:00', 1, 3),
	(68, 'CPI000000006', 80, 521, 2605, 521, 2605, '1', '2023-01-27 00:00:00', 1, 3),
	(69, 'CPI000000006', 90, 64, 512, 64, 512, '1', '2023-01-27 00:00:00', 1, 3),
	(70, 'CPI000000007', 109, 646, 5168, 646, 5168, '1', '2023-01-27 00:00:00', 1, 3),
	(71, 'CPI000000007', 75, 38, 304, 38, 304, '1', '2023-01-27 00:00:00', 1, 3),
	(72, 'CPI000000007', 89, 86, 602, 86, 602, '1', '2023-01-27 00:00:00', 1, 3),
	(73, NULL, 2478, 540, 0, 540, 0, '2', '2022-12-20 00:00:00', 2, 30),
	(74, 'CPI000000008', 3824, 540, 540, 540, 540, '1', '2022-12-20 00:00:00', 1, 30),
	(75, 'CPI000000008', 3825, 189, 189, 189, 189, '1', '2022-12-02 00:00:00', 1, 30),
	(76, 'CPI000000009', 3839, 2800, 28000, 2800, 28000, '1', '2024-02-07 00:00:00', 1, 30),
	(77, 'CPI000000010', 3843, 788, 22.93763, 788, 22.93763, '2', '2023-12-28 00:00:00', 1, 30),
	(78, NULL, 2956, 537, 0, 537, 0, '2', '2023-02-01 00:00:00', 2, 30),
	(79, NULL, 3857, 591, 0, 591, 0, '2', '2023-02-01 00:00:00', 2, 30),
	(80, 'CPI000000011', 3858, 385, 0, 385, 0, '2', '2023-02-01 00:00:00', 1, 30),
	(81, 'CPI000000011', 3859, 177, 0, 177, 0, '2', '2023-02-01 00:00:00', 1, 30),
	(82, 'CPI000000011', 3856, 537, 0, 537, 0, '2', '2023-02-01 00:00:00', 1, 30),
	(83, 'CPI000000011', 3857, 54, 0, 54, 0, '2', '2023-02-01 00:00:00', 1, 30),
	(84, 'CPI000000012', 3860, 742, 0, 742, 0, '2', '2022-03-03 00:00:00', 1, 30),
	(85, 'CPI000000013', 3870, 1, 0, 1, 0, '2', '2024-01-01 00:00:00', 1, 30),
	(86, 'CPI000000014', 102, 1800, 18000, 1800, 18000, '1', '2022-05-06 00:00:00', 1, 3),
	(87, 'CPI000000014', 114, 5, 5, 5, 5, '1', '2022-05-20 00:00:00', 1, 3),
	(88, 'CPI000000015', 2956, 269, 0, 269, 0, '2', '2024-01-18 00:00:00', 1, 30),
	(89, 'CPI000000015', 2956, 538, 0, 538, 0, '2', '2022-01-18 00:00:00', 1, 30),
	(90, 'CPI000000015', 3858, 206, 0, 206, 0, '2', '2022-01-18 00:00:00', 1, 30),
	(91, 'CPI000000015', 3859, 97, 0, 97, 0, '2', '2022-01-18 00:00:00', 1, 30),
	(92, 'CPI000000016', 98, 1267, 19005, 1267, 19005, '1', '2022-04-08 00:00:00', 1, 3),
	(93, 'CPI000000016', 99, 500, 5000, 500, 5000, '1', '2022-04-08 00:00:00', 1, 3),
	(94, 'CPI000000017', 101, 900, 9000, 900, 9000, '1', '2022-04-08 00:00:00', 1, 3),
	(95, 'CPI000000018', 2461, 100, 1000, 100, 1000, '1', '2024-01-01 00:00:00', 1, 30),
	(96, 'CPI000000018', 2460, 300, 3000, 300, 3000, '1', '2024-01-01 00:00:00', 1, 30),
	(97, 'CPI000000018', 2462, 60, 600, 60, 600, '1', '2024-01-01 00:00:00', 1, 30),
	(98, 'CPI000000018', 2456, 250, 2500, 250, 2500, '1', '2024-01-01 00:00:00', 1, 30),
	(99, 'CPI000000018', 2455, 137, 1370, 137, 1370, '1', '2024-01-01 00:00:00', 1, 30),
	(100, 'CPI000000018', 2459, 341, 3410, 341, 3410, '1', '2024-01-01 00:00:00', 1, 30),
	(101, 'CPI000000019', 3860, 1450, 0, 1450, 0, '2', '2023-12-21 00:00:00', 1, 30),
	(102, 'CPI000000020', 387, 581, 581, 581, 581, '1', '2022-04-13 00:00:00', 1, 3),
	(103, 'CPI000000020', 74, 25, 150, 25, 150, '1', '2022-04-13 00:00:00', 1, 3),
	(104, 'CPI000000021', 74, 232, 1392, 232, 1392, '1', '2022-04-12 00:00:00', 1, 3),
	(105, 'CPI000000021', 73, 10, 50, 10, 50, '1', '2022-04-12 00:00:00', 1, 3),
	(106, 'CPI000000021', 72, 126, 882, 126, 882, '1', '2022-04-12 00:00:00', 1, 3),
	(107, 'CPI000000021', 75, 39, 312, 39, 312, '1', '2022-04-12 00:00:00', 1, 3),
	(108, 'CPI000000021', 80, 249, 1245, 249, 1245, '1', '2022-04-12 00:00:00', 1, 3),
	(109, 'CPI000000021', 79, 105, 735, 105, 735, '1', '2022-04-12 00:00:00', 1, 3),
	(110, 'CPI000000021', 88, 50, 300, 50, 300, '1', '2022-04-12 00:00:00', 1, 3),
	(111, 'CPI000000021', 93, 10, 110, 10, 110, '1', '2022-04-12 00:00:00', 1, 3),
	(112, 'CPI000000021', 97, 85, 595, 85, 595, '1', '2022-04-12 00:00:00', 1, 3),
	(113, 'CPI000000021', 106, 6, 120, 6, 120, '1', '2022-04-12 00:00:00', 1, 3),
	(114, 'CPI000000021', 109, 2, 16, 2, 16, '1', '2022-04-12 00:00:00', 1, 3),
	(115, 'CPI000000021', 122, 10, 80, 10, 80, '1', '2022-04-12 00:00:00', 1, 3),
	(116, 'CPI000000022', 388, 10, 64.8, 10, 64.8, '1', '2022-04-14 00:00:00', 1, 10),
	(117, 'CPI000000023', 388, 10, 64.8, 10, 64.8, '1', '2022-04-20 00:00:00', 1, 10),
	(118, 'CPI000000023', 389, 10, 89.3, 10, 89.3, '1', '2022-04-16 00:00:00', 1, 10),
	(119, 'CPI000000024', 3987, 1190, 0, 1190, 0, '2', '2024-01-04 00:00:00', 1, 30);
/*!40000 ALTER TABLE `tbl_inbounditems` ENABLE KEYS */;

-- Dumping structure for table wms_clientportal.tbl_order
CREATE TABLE IF NOT EXISTS `tbl_order` (
  `SO` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_clientportal.tbl_order: ~0 rows (approximately)
/*!40000 ALTER TABLE `tbl_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_order` ENABLE KEYS */;

-- Dumping structure for table wms_clientportal.tbl_storeorder
CREATE TABLE IF NOT EXISTS `tbl_storeorder` (
  `id` int NOT NULL AUTO_INCREMENT,
  `SO` varchar(50) DEFAULT NULL,
  `CustomerCommon` varchar(50) DEFAULT NULL,
  `StoreID` varchar(50) DEFAULT NULL,
  `StoreReference` varchar(50) DEFAULT NULL,
  `Remarks` longtext,
  `WarehouseID` int DEFAULT NULL,
  `CPO` varchar(50) DEFAULT NULL,
  `Date_Created` timestamp NULL DEFAULT NULL,
  `Pickup_date` timestamp NULL DEFAULT NULL,
  `UserID` int DEFAULT NULL,
  `Order_Status` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_clientportal.tbl_storeorder: ~90 rows (approximately)
/*!40000 ALTER TABLE `tbl_storeorder` DISABLE KEYS */;
INSERT INTO `tbl_storeorder` (`id`, `SO`, `CustomerCommon`, `StoreID`, `StoreReference`, `Remarks`, `WarehouseID`, `CPO`, `Date_Created`, `Pickup_date`, `UserID`, `Order_Status`) VALUES
	(3, 'Store1', 'MPI0013', 'test', NULL, 'test', 5, 'CPO000000001', '2022-03-03 10:17:55', '0000-00-00 00:00:00', 11, 2),
	(4, 'store2', 'MPI0013', 'test2', NULL, 'test', 5, 'CPO000000002', '2022-03-03 11:33:40', '2022-03-23 11:38:00', 11, 2),
	(5, 'Store3', 'MPI0013', 'test', NULL, 'test', 5, 'CPO000000003', '2022-03-03 11:36:02', '2022-03-31 11:35:00', 11, 2),
	(6, 'Store1', 'MPI0013', '1', NULL, '1', 5, 'CPO000000004', '2022-03-03 11:51:07', '2022-03-31 11:49:00', 10, 2),
	(7, 'Store1', 'MPI0013', '1', NULL, '1', 5, 'CPO000000005', '2022-03-03 12:08:28', '2022-03-30 12:08:00', 10, 2),
	(8, 'Store8', 'MPI0013', 'test', NULL, 'test', 5, 'CPO000000006', '2022-03-03 13:53:45', '2022-03-16 13:53:00', 11, 1),
	(9, 'Store8', 'MPI0013', 'test', NULL, 'test', 5, 'CPO000000007', '2022-03-03 13:55:40', '2022-04-01 13:55:00', 11, 1),
	(10, 'Store8', 'MPI0013', 'test', NULL, 'test', 5, 'CPO000000008', '2022-03-03 14:35:14', '2022-03-29 14:35:00', 11, 1),
	(11, 'Store1', 'AAC0015', 'test', NULL, 'test', 5, 'CPO000000009', '2022-03-18 08:25:53', '2022-03-19 08:25:00', 4, 0),
	(12, 'test1', 'MPI0013', 'test1', NULL, 'test1', 5, 'CPO000000010', '2022-03-22 19:43:56', '2022-03-22 19:43:00', 10, 2),
	(13, 'test2', 'MPI0013', 'testing', NULL, 'test', 5, 'CPO000000011', '2022-03-22 20:04:31', '2022-03-22 20:03:00', 10, 2),
	(14, '123', 'MPI0013', '123', NULL, '', 5, 'CPO000000012', '2022-03-23 15:39:30', '2022-04-09 15:38:00', 11, 2),
	(15, '', 'CIE0133', '', NULL, '', 5, 'CPO000000013', '2022-03-24 11:52:47', '2022-03-24 11:49:00', 30, 2),
	(16, 'ALSONS', 'AAC0015', 'BANG BANG', NULL, '', 5, 'CPO000000014', '2022-03-24 15:47:55', '2022-03-25 08:00:00', 3, 2),
	(17, '', 'CIE0133', '', NULL, '', 5, 'CPO000000015', '2022-03-25 14:08:13', '2022-03-25 14:07:00', 30, 2),
	(18, '2022-041 / 2022-042', 'AAC0015', 'JC SEAFOODS', NULL, '', 5, 'CPO000000016', '2022-03-25 16:45:23', '2022-03-26 05:00:00', 3, 2),
	(19, '2022-193', 'AAC0015', 'BANG BANG', NULL, '', 5, 'CPO000000017', '2022-03-25 16:47:11', '2022-03-26 08:00:00', 3, 2),
	(20, '', 'CIE0133', '', NULL, '', 5, 'CPO000000018', '2022-03-28 08:40:03', '2022-03-28 08:39:00', 30, 2),
	(21, '2022-194', 'AAC0015', 'BANG BANG', NULL, '', 5, 'CPO000000019', '2022-03-28 12:03:56', '2022-03-29 12:03:00', 3, 2),
	(22, 'MEATWORLD', 'AAC0015', '2022198', NULL, '', 5, 'CPO000000020', '2022-03-28 16:08:25', '2022-03-29 05:00:00', 3, 2),
	(23, 'MEATWORLD', 'AAC0015', '2022-195', NULL, '', 5, 'CPO000000021', '2022-03-28 16:10:47', '2022-03-29 05:00:00', 3, 2),
	(24, 'MEATWORLD', 'AAC0015', '2022-196', NULL, '', 5, 'CPO000000022', '2022-03-28 16:12:29', '2022-03-29 05:00:00', 3, 2),
	(25, 'MEATWORLD', 'AAC0015', '2022-197', NULL, '', 5, 'CPO000000023', '2022-03-28 16:13:21', '2022-03-28 16:12:00', 3, 2),
	(26, '2022-199', 'AAC0015', 'MEATWORLD', NULL, '', 5, 'CPO000000024', '2022-03-28 16:15:16', '2022-03-29 05:00:00', 3, 2),
	(27, '2022-201', 'AAC0015', 'SOLID GLOBAL', NULL, '', 5, 'CPO000000025', '2022-03-28 16:16:28', '2022-05-29 05:00:00', 3, 2),
	(28, '2022-200', 'AAC0015', 'BANG BANG', NULL, '', 5, 'CPO000000026', '2022-03-28 16:17:29', '2022-03-29 05:00:00', 3, 2),
	(29, '2022-202', 'AAC0015', 'ANA ARANETA', NULL, '', 5, 'CPO000000027', '2022-03-28 16:18:41', '2022-03-29 05:00:00', 3, 2),
	(30, '2022-008', 'AAC0015', 'PULL OUT SLIP', NULL, '', 5, 'CPO000000028', '2022-03-28 17:12:20', '2022-03-29 05:00:00', 3, 2),
	(31, '', 'CIE0133', '', NULL, '', 5, 'CPO000000029', '2022-03-29 08:20:49', '2022-03-29 08:19:00', 30, 2),
	(32, '', 'CIE0133', '', NULL, '', 5, 'CPO000000030', '2022-03-30 09:14:47', '2022-03-30 09:13:00', 30, 2),
	(33, '', 'CIE0133', '', NULL, '', 5, 'CPO000000031', '2022-03-30 10:09:00', '2022-03-30 10:08:00', 30, 2),
	(34, '2022-204', 'AAC0015', 'ZENITH FOODS', NULL, '', 5, 'CPO000000032', '2022-03-30 15:02:59', '2022-03-30 15:02:00', 3, 2),
	(35, '2022-203', 'AAC0015', 'ZENITH', NULL, '', 5, 'CPO000000033', '2022-03-30 15:04:12', '2022-05-31 05:00:00', 3, 2),
	(36, '2022-016', 'AAC0015', 'RPS', NULL, '', 5, 'CPO000000034', '2022-03-30 15:07:18', '2022-03-31 05:00:00', 3, 2),
	(37, '2022-207', 'AAC0015', 'SOLID', NULL, '', 5, 'CPO000000035', '2022-03-30 16:40:34', '2022-03-31 08:00:00', 3, 2),
	(38, '2022-205', 'AAC0015', 'G3', NULL, '', 5, 'CPO000000036', '2022-03-30 16:48:05', '2022-03-31 08:00:00', 3, 2),
	(39, '2022-206', 'AAC0015', 'CHUCKS', NULL, '', 5, 'CPO000000037', '2022-03-30 16:49:08', '2022-03-31 08:00:00', 3, 2),
	(40, '', 'CIE0133', '', NULL, '', 5, 'CPO000000038', '2022-03-31 08:24:16', '2022-03-31 08:22:00', 30, 2),
	(41, '', 'CIE0133', '', NULL, '', 5, 'CPO000000039', '2022-03-31 14:45:25', '2022-03-31 14:44:00', 30, 2),
	(42, '', 'CIE0133', '', NULL, '', 5, 'CPO000000040', '2022-04-01 10:39:58', '2022-04-01 10:37:00', 30, 2),
	(43, '', 'CIE0133', '', NULL, '', 5, 'CPO000000041', '2022-04-01 10:44:26', '2022-04-01 10:43:00', 30, 2),
	(44, '2022-213', 'AAC0015', 'BANG BANG', NULL, '', 5, 'CPO000000042', '2022-04-01 15:11:47', '2022-04-02 08:00:00', 3, 2),
	(45, '2022-211', 'AAC0015', 'TAPA KING', NULL, '', 5, 'CPO000000043', '2022-04-02 14:09:45', '2022-04-04 08:00:00', 3, 2),
	(46, '2022-212', 'AAC0015', 'BANG BANG', NULL, '', 5, 'CPO000000044', '2022-04-02 14:10:42', '2022-04-04 08:00:00', 3, 2),
	(47, '', 'AAC0015', 'RPS', NULL, '', 5, 'CPO000000045', '2022-04-02 14:38:19', '2022-04-04 08:00:00', 3, 2),
	(48, '', 'CIE0133', '', NULL, '', 5, 'CPO000000046', '2022-04-04 16:13:01', '2022-04-04 16:12:00', 30, 0),
	(49, '', 'CIE0133', '', NULL, '', 5, 'CPO000000047', '2022-04-04 09:15:36', '2022-04-04 09:14:00', 30, 2),
	(50, '2022-008', 'AAC0015', 'RPS', NULL, '', 5, 'CPO000000048', '2022-04-04 14:55:31', '2022-04-05 08:00:00', 3, 2),
	(51, '2022-216', 'AAC0015', 'ERIN', NULL, '', 5, 'CPO000000049', '2022-04-04 14:57:35', '2022-04-05 05:00:00', 3, 2),
	(52, '2022-217', 'AAC0015', 'ANA ARANETA', NULL, '', 5, 'CPO000000050', '2022-04-04 14:58:39', '2022-04-05 05:00:00', 3, 2),
	(53, '2022-214', 'AAC0015', 'G3', NULL, '', 5, 'CPO000000051', '2022-04-04 15:02:01', '2022-04-05 05:00:00', 3, 2),
	(54, '2022-218', 'AAC0015', 'MII - 218', NULL, '', 5, 'CPO000000052', '2022-04-04 15:03:30', '2022-04-05 05:00:00', 3, 2),
	(55, '2022-218', 'AAC0015', 'MII - 218', NULL, '', 5, 'CPO000000053', '2022-04-04 15:04:52', '2022-04-05 05:00:00', 3, 2),
	(56, '', 'CIE0133', '', NULL, '', 5, 'CPO000000054', '2022-04-04 16:14:33', '2022-04-04 16:13:00', 30, 2),
	(57, '2022-220', 'AAC0015', 'BANG BANG', NULL, '', 5, 'CPO000000055', '2022-04-04 16:23:12', '2022-04-05 05:00:00', 3, 2),
	(58, '2022-215', 'AAC0015', 'COOPTECH', NULL, '', 5, 'CPO000000056', '2022-04-04 16:24:49', '2022-04-05 05:00:00', 3, 2),
	(59, '', 'CIE0133', '', NULL, '', 5, 'CPO000000057', '2022-04-05 09:14:23', '2022-04-05 09:13:00', 30, 2),
	(60, '', 'CIE0133', '', NULL, '', 5, 'CPO000000058', '2022-04-05 09:53:27', '2022-04-05 09:52:00', 30, 2),
	(61, '', 'CIE0133', '', NULL, '', 5, 'CPO000000059', '2022-04-05 14:26:36', '2022-04-05 14:23:00', 30, 2),
	(62, '', 'CIE0133', '', NULL, '', 5, 'CPO000000060', '2022-04-05 14:50:59', '2022-04-05 14:50:00', 30, 2),
	(63, '2022-223', 'AAC0015', 'MII - 223', NULL, '', 5, 'CPO000000061', '2022-04-05 16:11:05', '2022-04-06 05:00:00', 3, 2),
	(64, '2022-225', 'AAC0015', 'MII - 225', NULL, '', 5, 'CPO000000062', '2022-04-05 16:11:58', '2022-04-06 05:00:00', 3, 2),
	(65, '2022-226', 'AAC0015', 'MII - 226', NULL, '', 5, 'CPO000000063', '2022-04-05 16:12:51', '2022-04-06 05:00:00', 3, 2),
	(66, '2022-224', 'AAC0015', 'MII - 224', NULL, '', 5, 'CPO000000064', '2022-04-05 16:14:43', '2022-04-06 05:00:00', 3, 2),
	(67, '2022-045/046', 'AAC0015', 'JC SEAFOODS', NULL, '', 5, 'CPO000000065', '2022-04-05 16:38:05', '2022-04-06 05:00:00', 3, 2),
	(68, '', 'CIE0133', '', NULL, '', 5, 'CPO000000066', '2022-04-06 08:05:52', '2022-04-06 08:05:00', 30, 2),
	(69, '2022-227', 'AAC0015', 'MII - 227', NULL, '', 5, 'CPO000000067', '2022-04-06 16:09:25', '2022-04-07 05:00:00', 3, 2),
	(70, '2022-230', 'AAC0015', 'MII - 230', NULL, '', 5, 'CPO000000068', '2022-04-06 16:10:15', '2022-04-07 05:00:00', 3, 2),
	(71, '2022-232', 'AAC0015', 'MII - 232', NULL, '', 5, 'CPO000000069', '2022-04-06 16:15:55', '2022-04-07 05:00:00', 3, 2),
	(72, '2022-228', 'AAC0015', 'MII 228', NULL, '', 5, 'CPO000000070', '2022-04-06 16:56:37', '2022-04-07 05:00:00', 3, 2),
	(73, '2022-229', 'AAC0015', 'MII - 229', NULL, '', 5, 'CPO000000071', '2022-04-06 16:57:44', '2022-04-07 05:00:00', 3, 2),
	(74, '2022-231', 'AAC0015', 'MII - 231', NULL, '', 5, 'CPO000000072', '2022-04-06 16:58:39', '2022-04-07 05:00:00', 3, 2),
	(75, '2022-233', 'AAC0015', 'MII - 233', NULL, '', 5, 'CPO000000073', '2022-04-06 16:59:29', '2022-04-07 05:00:00', 3, 2),
	(76, '', 'CIE0133', '', NULL, '', 5, 'CPO000000074', '2022-04-06 17:05:56', '2022-04-06 17:04:00', 30, 2),
	(77, '', 'CIE0133', '', NULL, '', 5, 'CPO000000075', '2022-04-07 07:53:31', '2022-04-07 07:52:00', 30, 2),
	(78, '', 'CIE0133', '', NULL, '', 5, 'CPO000000076', '2022-04-07 10:46:03', '2022-04-07 10:44:00', 30, 2),
	(79, '2022-234', 'AAC0015', 'ZENITH', NULL, '', 5, 'CPO000000077', '2022-04-07 16:42:54', '2022-04-08 05:00:00', 3, 2),
	(80, '2022-236', 'AAC0015', 'BANG BANG', NULL, '', 5, 'CPO000000082', '2022-04-07 16:45:54', '2022-04-08 05:00:00', 3, 2),
	(81, '2022-235', 'AAC0015', 'REYNOSO', NULL, '', 5, 'CPO000000083', '2022-04-07 16:46:35', '2022-04-08 05:00:00', 3, 2),
	(82, '', 'CIE0133', '', NULL, '', 5, 'CPO000000084', '2022-04-08 08:19:39', '2022-04-08 08:16:00', 30, 2),
	(83, '', 'CIE0133', '', NULL, '', 5, 'CPO000000085', '2022-04-08 09:29:02', '2022-04-08 09:28:00', 30, 2),
	(84, '', 'CIE0133', '', NULL, '', 5, 'CPO000000086', '2022-04-08 13:59:12', '2022-04-08 13:52:00', 30, 2),
	(85, '', 'CIE0133', '', NULL, '', 5, 'CPO000000087', '2022-04-08 16:24:06', '2022-04-08 16:23:00', 30, 2),
	(86, '2022-242', 'AAC0015', 'ORIENTAL', NULL, '', 5, 'CPO000000088', '2022-04-08 16:50:30', '2022-04-11 05:00:00', 3, 2),
	(87, '2022-241', 'AAC0015', 'ARTEMIS', NULL, '', 5, 'CPO000000089', '2022-04-08 16:54:36', '2022-04-11 05:00:00', 3, 2),
	(88, '2022-240', 'AAC0015', 'ARTEMIS-240', NULL, '', 5, 'CPO000000090', '2022-04-08 16:55:24', '2022-04-11 05:00:00', 3, 2),
	(89, '2022-239', 'AAC0015', 'ZENITH', NULL, '', 5, 'CPO000000091', '2022-04-08 16:56:16', '2022-04-11 05:00:00', 3, 2),
	(90, '2022-237', 'AAC0015', 'BANG BANG', NULL, '', 5, 'CPO000000092', '2022-04-11 09:49:56', '2022-04-11 08:00:00', 3, 2),
	(91, '', 'CIE0133', '', NULL, '', 5, 'CPO000000093', '2022-04-12 09:31:27', '2022-04-12 09:29:00', 30, 2),
	(92, '2022-253', 'AAC0015', 'BANG BANG', NULL, '', 5, 'CPO000000094', '2022-04-13 16:27:16', '2022-04-16 08:00:00', 3, 2),
	(93, '2022-251', 'AAC0015', 'ZENITH', NULL, '', 5, 'CPO000000095', '2022-04-13 16:27:59', '2022-04-18 05:00:00', 3, 2),
	(94, '2022-256', 'AAC0015', 'BANG BANG', NULL, '', 5, 'CPO000000096', '2022-04-13 16:28:39', '2022-04-16 08:00:00', 3, 2),
	(95, '2022-255', 'AAC0015', 'TAPA KING', NULL, '', 5, 'CPO000000097', '2022-04-13 16:29:21', '2022-04-18 08:00:00', 3, 2),
	(96, '', 'CIE0133', '', NULL, '', 5, 'CPO000000098', '2022-04-18 08:49:41', '2022-04-18 08:48:00', 30, 2),
	(97, '', 'CIE0133', '', NULL, '', 5, 'CPO000000099', '2022-04-19 08:38:09', '2022-04-19 08:37:00', 30, 2),
	(98, '', 'CIE0133', '', NULL, '', 5, 'CPO000000100', '2022-04-19 14:41:39', '2022-04-19 14:39:00', 30, 2);
/*!40000 ALTER TABLE `tbl_storeorder` ENABLE KEYS */;

-- Dumping structure for table wms_clientportal.tbl_storeorderitems
CREATE TABLE IF NOT EXISTS `tbl_storeorderitems` (
  `id` int NOT NULL AUTO_INCREMENT,
  `SO` varchar(50) DEFAULT NULL,
  `ItemID` int NOT NULL,
  `Quantity` double DEFAULT NULL,
  `Weight` double DEFAULT NULL,
  `GivenQty` double DEFAULT NULL,
  `CPO` varchar(50) DEFAULT NULL,
  `isFloat` int DEFAULT NULL,
  `UserID` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_clientportal.tbl_storeorderitems: ~171 rows (approximately)
/*!40000 ALTER TABLE `tbl_storeorderitems` DISABLE KEYS */;
INSERT INTO `tbl_storeorderitems` (`id`, `SO`, `ItemID`, `Quantity`, `Weight`, `GivenQty`, `CPO`, `isFloat`, `UserID`) VALUES
	(1, 'Store1', 72, 10, 70, 10, 'CPO000000009', 2, 4),
	(2, 'Store1', 73, 100000, 500000, 100000, NULL, 2, 4),
	(3, 'Store1', 98, 10, 150, 10, 'CPO000000009', 2, 4),
	(4, 'Store1', 272, 50, 500, 50, 'CPO000000009', 2, 4),
	(5, 'test1', 388, 25, 162, 25, 'CPO000000010', 1, 10),
	(6, 'test2', 389, 10, 89.3, 10, 'CPO000000011', 1, 10),
	(7, 'test2', 390, 10, 86.4, 10, 'CPO000000011', 1, 10),
	(8, 'test2', 391, 5, 57.6, 5, 'CPO000000011', 1, 10),
	(9, 'test2', 392, 10, 120, 10, 'CPO000000011', 1, 10),
	(10, 'test2', 393, 5, 40.8, 5, 'CPO000000011', 1, 10),
	(11, 'test2', 394, 10, 89.3, 10, 'CPO000000011', 1, 10),
	(12, '123', 396, 10, 80, 10, 'CPO000000012', 1, 11),
	(13, '123', 2479, 100000, 1000000, 100000, NULL, 2, 11),
	(14, '123', 407, 10, 89.3, 10, 'CPO000000012', 1, 11),
	(15, '', 2452, 150, 1500, 150, 'CPO000000013', 1, 30),
	(16, '', 2918, 200, 2000, 200, 'CPO000000013', 1, 30),
	(17, '', 2471, 160, 0, 160, 'CPO000000013', 1, 30),
	(18, '', 2465, 250, 3750, 250, 'CPO000000013', 1, 30),
	(19, 'ALSONS', 387, 20, 20, 20, 'CPO000000014', 1, 3),
	(20, '', 2465, 250, 3750, 250, 'CPO000000015', 1, 30),
	(21, '', 2471, 192, 0, 192, 'CPO000000015', 1, 30),
	(22, '2022-041', 73, 30, 150, 30, 'CPO000000016', 1, 3),
	(23, '2022-041', 72, 10, 70, 10, 'CPO000000016', 1, 3),
	(24, '2022-041', 87, 5, 35, 5, 'CPO000000016', 1, 3),
	(25, '2022-041', 75, 43, 344, 43, 'CPO000000016', 1, 3),
	(26, '2022-041 / 2022-042', 285, 94, 940, 94, 'CPO000000016', 1, 3),
	(27, '2022-041 / 2022-042', 282, 10, 100, 10, 'CPO000000016', 1, 3),
	(28, '2022-041 / 2022-042', 284, 5, 50, 5, 'CPO000000016', 1, 3),
	(29, '2022-193', 387, 50, 50, 50, 'CPO000000017', 1, 3),
	(30, '', 3557, 160, 0, 160, 'CPO000000018', 1, 30),
	(31, '2022-194', 387, 24, 24, 24, 'CPO000000019', 1, 3),
	(32, 'MEATWORLD', 75, 23, 184, 23, 'CPO000000020', 1, 3),
	(33, 'MEATWORLD', 89, 40, 280, 40, 'CPO000000020', 1, 3),
	(34, 'MEATWORLD', 109, 206, 1648, 206, 'CPO000000020', 1, 3),
	(35, 'MEATWORLD', 90, 31, 248, 31, 'CPO000000021', 1, 3),
	(36, 'MEATWORLD', 109, 172, 1376, 172, 'CPO000000021', 1, 3),
	(37, 'MEATWORLD', 90, 2998, 23984, 2998, NULL, 2, 3),
	(38, 'MEATWORLD', 90, 29, 232, 29, 'CPO000000022', 1, 3),
	(39, 'MEATWORLD', 109, 28, 224, 28, 'CPO000000022', 1, 3),
	(40, 'MEATWORLD', 90, 4, 32, 4, 'CPO000000023', 1, 3),
	(41, 'MEATWORLD', 109, 86, 688, 86, 'CPO000000023', 1, 3),
	(42, '2022-199', 75, 15, 120, 15, 'CPO000000024', 1, 3),
	(43, '2022-199', 89, 26, 182, 26, 'CPO000000024', 1, 3),
	(44, '2022-199', 109, 169, 1352, 169, 'CPO000000024', 1, 3),
	(45, '2022-201', 72, 1, 7, 1, 'CPO000000025', 1, 3),
	(46, '2022-201', 97, 1, 7, 1, 'CPO000000025', 1, 3),
	(47, '2022-200', 387, 28, 28, 28, 'CPO000000026', 1, 3),
	(48, '2022-202', 75, 1, 8, 1, 'CPO000000027', 1, 3),
	(49, '2022-202', 97, 1, 7, 1, 'CPO000000027', 1, 3),
	(50, '2022-008', 3463, 1, 10, 1, 'CPO000000028', 1, 3),
	(51, '', 2452, 200, 2000, 200, NULL, 2, 30),
	(52, '', 2958, 200, 2000, 200, 'CPO000000029', 1, 30),
	(53, '', 2438, 520, 10400, 520, 'CPO000000030', 1, 30),
	(54, '', 3824, 375, 0, 375, 'CPO000000031', 1, 30),
	(55, '2022-204', 103, 300, 3000, 300, 'CPO000000032', 1, 3),
	(56, '2022-203', 103, 300, 3000, 300, 'CPO000000033', 1, 3),
	(57, '2022-016', 112, 2, 1, 2, 'CPO000000034', 1, 3),
	(58, '2022-207', 72, 1, 7, 1, 'CPO000000035', 1, 3),
	(59, '2022-207', 75, 1, 8, 1, 'CPO000000035', 1, 3),
	(60, '2022-207', 98, 1, 15, 1, 'CPO000000035', 1, 3),
	(61, '2022-207', 97, 1, 7, 1, 'CPO000000035', 1, 3),
	(62, '2022-205', 98, 2, 30, 2, 'CPO000000036', 1, 3),
	(63, '2022-205', 273, 2, 9.6, 2, 'CPO000000036', 1, 3),
	(64, '2022-205', 97, 5, 35, 5, 'CPO000000036', 1, 3),
	(65, '2022-205', 72, 5, 35, 5, 'CPO000000036', 1, 3),
	(66, '2022-205', 87, 5, 35, 5, 'CPO000000036', 1, 3),
	(67, '2022-205', 88, 2, 12, 2, 'CPO000000036', 1, 3),
	(68, '2022-205', 93, 2, 22, 2, 'CPO000000036', 1, 3),
	(69, '2022-205', 94, 1, 6, 1, 'CPO000000036', 1, 3),
	(70, '2022-205', 75, 5, 40, 5, 'CPO000000036', 1, 3),
	(71, '2022-206', 75, 3, 24, 3, 'CPO000000037', 1, 3),
	(72, '', 2452, 50, 500, 50, 'CPO000000038', 1, 30),
	(73, '', 3824, 45, 0, 45, 'CPO000000038', 1, 30),
	(74, '', 3839, 210, 2100, 210, 'CPO000000039', 1, 30),
	(75, '', 3825, 30, 0, 30, 'CPO000000039', 1, 30),
	(76, '', 3848, 166, 0, 166, 'CPO000000040', 1, 30),
	(77, '', 2473, 62, 0, 62, 'CPO000000040', 1, 30),
	(78, '', 3847, 36, 0, 36, 'CPO000000040', 1, 30),
	(79, '', 3851, 35, 0, 35, 'CPO000000040', 1, 30),
	(80, '', 3850, 166, 0, 166, 'CPO000000041', 1, 30),
	(81, '2022-213', 387, 24, 24, 24, 'CPO000000042', 1, 3),
	(82, '2022-211', 80, 200, 1000, 200, 'CPO000000043', 1, 3),
	(83, '2022-212', 387, 20, 20, 20, 'CPO000000044', 1, 3),
	(84, '', 112, 2, 1, 2, 'CPO000000045', 1, 3),
	(85, '', 2919, 361, 3610, 361, NULL, 2, 30),
	(86, '', 2919, 240, 2400, 240, 'CPO000000046', 2, 30),
	(87, '', 2920, 120, 1200, 120, 'CPO000000046', 2, 30),
	(88, '', 2919, 240, 2400, 240, 'CPO000000047', 1, 30),
	(89, '', 2920, 120, 1200, 120, 'CPO000000047', 1, 30),
	(90, '2022-008', 3823, 18, 1.8, 18, 'CPO000000048', 1, 3),
	(91, '2022-216', 72, 1, 7, 1, 'CPO000000049', 1, 3),
	(92, '2022-216', 87, 3, 21, 3, 'CPO000000049', 1, 3),
	(93, '2022-216', 97, 1, 7, 1, 'CPO000000049', 1, 3),
	(94, '2022-217', 93, 1, 11, 1, 'CPO000000050', 1, 3),
	(95, '2022-217', 97, 1, 7, 1, 'CPO000000050', 1, 3),
	(96, '2022-214', 273, 7, 33.6, 7, 'CPO000000051', 1, 3),
	(97, '2022-214', 97, 5, 35, 5, 'CPO000000051', 1, 3),
	(98, '2022-214', 101, 1, 10, 1, 'CPO000000051', 1, 3),
	(99, '2022-214', 88, 5, 30, 5, 'CPO000000051', 1, 3),
	(100, '2022-214', 87, 5, 35, 5, 'CPO000000051', 1, 3),
	(101, '2022-214', 72, 5, 35, 5, 'CPO000000051', 1, 3),
	(102, '2022-214', 75, 5, 40, 5, 'CPO000000051', 1, 3),
	(103, '2022-218', 74, 15, 90, 15, 'CPO000000052', 1, 3),
	(104, '2022-218', 74, 16, 96, 16, 'CPO000000053', 1, 3),
	(105, '', 3825, 15, 0, 15, 'CPO000000046', 1, 30),
	(106, '', 3825, 15, 0, 15, 'CPO000000054', 1, 30),
	(107, '2022-220', 387, 24, 24, 24, 'CPO000000055', 1, 3),
	(108, '2022-215', 79, 1, 7, 1, 'CPO000000056', 1, 3),
	(109, '2022-215', 72, 1, 7, 1, 'CPO000000056', 1, 3),
	(110, '2022-215', 84, 1, 8, 1, 'CPO000000056', 1, 3),
	(111, '2022-215', 75, 1, 8, 1, 'CPO000000056', 1, 3),
	(112, '', 3848, 25, 0, 25, 'CPO000000057', 1, 30),
	(113, '', 3847, 36, 0, 36, 'CPO000000057', 1, 30),
	(114, '', 3844, 25, 0, 25, 'CPO000000058', 1, 30),
	(115, '', 2465, 250, 3750, 250, 'CPO000000059', 1, 30),
	(116, '', 2471, 160, 0, 160, 'CPO000000059', 1, 30),
	(117, '', 2452, 300, 3000, 300, 'CPO000000059', 1, 30),
	(118, '', 3851, 60, 0, 60, 'CPO000000059', 1, 30),
	(119, '', 3850, 168, 0, 168, 'CPO000000059', 1, 30),
	(120, '', 2473, 50, 0, 50, 'CPO000000059', 1, 30),
	(121, '', 3825, 15, 0, 15, 'CPO000000060', 1, 30),
	(122, '2022-223', 109, 63, 504, 63, 'CPO000000061', 1, 3),
	(123, '2022-223', 89, 14, 98, 14, 'CPO000000061', 1, 3),
	(124, '2022-225', 273, 38, 182.4, 38, 'CPO000000062', 1, 3),
	(125, '2022-226', 97, 5, 35, 5, 'CPO000000063', 1, 3),
	(126, '2022-224', 89, 6, 42, 6, 'CPO000000064', 1, 3),
	(127, '2022-224', 109, 62, 496, 62, 'CPO000000064', 1, 3),
	(128, '2022-224', 273, 60, 288, 60, 'CPO000000064', 1, 3),
	(129, '2022-045/046', 272, 10, 100, 10, 'CPO000000065', 1, 3),
	(130, '2022-045/046', 2954, 8, 80, 8, 'CPO000000065', 1, 3),
	(131, '2022-045/046', 79, 40, 280, 40, 'CPO000000065', 1, 3),
	(132, '2022-045/046', 88, 10, 60, 10, 'CPO000000065', 1, 3),
	(133, '2022-045/046', 87, 10, 70, 10, 'CPO000000065', 1, 3),
	(134, '2022-045/046', 75, 40, 320, 40, 'CPO000000065', 1, 3),
	(135, '', 3839, 70, 700, 70, 'CPO000000066', 1, 30),
	(136, '2022-227', 98, 396, 5940, 396, 'CPO000000067', 1, 3),
	(137, '2022-227', 101, 184, 1840, 184, 'CPO000000067', 1, 3),
	(138, '2022-230', 101, 175, 1750, 175, 'CPO000000068', 1, 3),
	(139, '2022-232', 98, 222, 3330, 222, 'CPO000000069', 1, 3),
	(140, '2022-232', 99, 98, 980, 98, 'CPO000000069', 1, 3),
	(141, '2022-228', 98, 24, 360, 24, 'CPO000000070', 1, 3),
	(142, '2022-228', 101, 71, 710, 71, 'CPO000000070', 1, 3),
	(143, '2022-229', 98, 83, 1245, 83, 'CPO000000071', 1, 3),
	(144, '2022-229', 99, 147, 1470, 147, 'CPO000000071', 1, 3),
	(145, '2022-231', 98, 250, 3750, 250, 'CPO000000072', 1, 3),
	(146, '2022-233', 101, 174, 1740, 174, 'CPO000000073', 1, 3),
	(147, '', 3839, 560, 5600, 560, 'CPO000000074', 1, 30),
	(148, '', 3839, 210, 2100, 210, 'CPO000000075', 1, 30),
	(149, '', 3847, 36, 0, 36, 'CPO000000076', 1, 30),
	(150, '2022-234', 102, 120, 1200, 120, 'CPO000000077', 1, 3),
	(151, '2022-236', 387, 120, 120, 120, NULL, 2, 3),
	(152, '2022-236', 387, 60, 60, 60, 'CPO000000082', 1, 3),
	(153, '2022-235', 271, 20, 200, 20, 'CPO000000083', 1, 3),
	(154, '', 3859, 30, 0, 30, 'CPO000000084', 1, 30),
	(155, '', 3839, 280, 2800, 280, 'CPO000000084', 1, 30),
	(156, '', 2958, 200, 2000, 200, 'CPO000000085', 1, 30),
	(157, '', 2956, 90, 0, 90, 'CPO000000086', 1, 30),
	(158, '', 3859, 90, 0, 90, 'CPO000000086', 1, 30),
	(159, '', 3839, 70, 700, 70, 'CPO000000087', 1, 30),
	(160, '2022-242', 101, 10, 100, 10, 'CPO000000088', 1, 3),
	(161, '2022-242', 103, 14, 140, 14, NULL, 2, 3),
	(162, '2022-242', 103, 12, 120, 12, 'CPO000000088', 1, 3),
	(163, '2022-241', 103, 14, 140, 14, 'CPO000000089', 1, 3),
	(164, '2022-240', 74, 53, 318, 53, 'CPO000000090', 1, 3),
	(165, '2022-239', 102, 110, 1100, 110, 'CPO000000091', 1, 3),
	(166, '2022-237', 387, 45, 45, 45, 'CPO000000092', 1, 3),
	(167, '', 3839, 210, 2100, 210, 'CPO000000093', 1, 30),
	(168, '', 3847, 108, 0, 108, 'CPO000000093', 1, 30),
	(169, '2022-253', 387, 36, 36, 36, 'CPO000000094', 1, 3),
	(170, '2022-251', 102, 110, 1100, 110, 'CPO000000095', 1, 3),
	(171, '2022-256', 387, 20, 20, 20, 'CPO000000096', 1, 3),
	(172, '2022-255', 80, 150, 750, 150, 'CPO000000097', 1, 3),
	(173, '', 2465, 100, 1500, 100, 'CPO000000098', 1, 30),
	(174, '', 2956, 90, 0, 90, 'CPO000000098', 1, 30),
	(175, '', 2956, 30, 0, 30, 'CPO000000099', 1, 30),
	(176, '', 3839, 210, 2100, 210, 'CPO000000099', 1, 30),
	(177, '', 2918, 40, 400, 40, 'CPO000000099', 1, 30),
	(178, '', 2918, 400, 4000, 400, 'CPO000000100', 1, 30),
	(179, '', 2471, 160, 0, 160, 'CPO000000100', 1, 30),
	(180, '', 2920, 120, 1200, 120, 'CPO000000100', 1, 30),
	(181, '', 3839, 280, 2800, 280, 'CPO000000100', 1, 30),
	(182, '', 3844, 25, 0, 25, 'CPO000000100', 1, 30),
	(183, '', 3987, 80, 0, 80, 'CPO000000100', 1, 30);
/*!40000 ALTER TABLE `tbl_storeorderitems` ENABLE KEYS */;

-- Dumping structure for table wms_clientportal.tbl_temp
CREATE TABLE IF NOT EXISTS `tbl_temp` (
  `id` int NOT NULL,
  `TempSO` int DEFAULT NULL,
  `TempCPI` int DEFAULT NULL,
  `TempCPO` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table wms_clientportal.tbl_temp: ~0 rows (approximately)
/*!40000 ALTER TABLE `tbl_temp` DISABLE KEYS */;
INSERT INTO `tbl_temp` (`id`, `TempSO`, `TempCPI`, `TempCPO`) VALUES
	(1, 2, 24, 100);
/*!40000 ALTER TABLE `tbl_temp` ENABLE KEYS */;

-- Dumping structure for table wms_clientportal.tbl_users_session
CREATE TABLE IF NOT EXISTS `tbl_users_session` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `session_start` timestamp NULL DEFAULT NULL,
  `session_stop` timestamp NULL DEFAULT NULL,
  `session_status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_clientportal.tbl_users_session: ~125 rows (approximately)
/*!40000 ALTER TABLE `tbl_users_session` DISABLE KEYS */;
INSERT INTO `tbl_users_session` (`id`, `user_id`, `session_start`, `session_stop`, `session_status`) VALUES
	(1, 10, '2022-03-03 16:03:25', '2022-03-23 15:35:13', 'inactive'),
	(2, 10, '2022-03-03 16:18:53', '2022-03-23 15:35:13', 'inactive'),
	(3, 12, '2022-03-03 21:26:40', '2022-04-04 09:31:57', 'inactive'),
	(4, 12, '2022-03-03 22:12:00', '2022-04-04 09:31:57', 'inactive'),
	(5, 12, '2022-03-03 23:06:04', '2022-04-04 09:31:57', 'inactive'),
	(6, 12, '2022-03-03 23:27:37', '2022-04-04 09:31:57', 'inactive'),
	(7, 12, '2022-03-03 23:34:21', '2022-04-04 09:31:57', 'inactive'),
	(8, 15, '2022-03-17 13:47:44', '2022-03-17 14:11:42', 'inactive'),
	(9, 15, '2022-03-17 14:09:52', '2022-03-17 14:11:42', 'inactive'),
	(10, 15, '2022-03-17 14:26:56', '2022-03-17 19:51:21', 'inactive'),
	(11, 3, '2022-03-17 20:45:40', '2022-03-26 11:44:15', 'inactive'),
	(12, 10, '2022-03-17 20:55:05', '2022-03-23 15:35:13', 'inactive'),
	(13, 3, '2022-03-17 20:56:06', '2022-03-26 11:44:15', 'inactive'),
	(14, 10, '2022-03-18 07:31:48', '2022-03-23 15:35:13', 'inactive'),
	(15, 11, '2022-03-18 07:31:59', '2022-03-23 15:49:19', 'inactive'),
	(16, 10, '2022-03-18 08:01:48', '2022-03-23 15:35:13', 'inactive'),
	(17, 11, '2022-03-18 08:02:23', '2022-03-23 15:49:19', 'inactive'),
	(18, 10, '2022-03-18 08:05:51', '2022-03-23 15:35:13', 'inactive'),
	(19, 11, '2022-03-18 08:12:33', '2022-03-23 15:49:19', 'inactive'),
	(20, 4, '2022-03-18 08:14:50', '2022-03-18 08:14:33', 'inactive'),
	(21, 11, '2022-03-18 14:52:04', '2022-03-23 15:49:19', 'inactive'),
	(22, 3, '2022-03-19 09:41:01', '2022-03-26 11:44:15', 'inactive'),
	(23, NULL, '2022-03-19 09:41:01', '2022-03-18 08:14:33', 'inactive'),
	(24, 11, '2022-03-21 08:01:06', '2022-03-23 15:49:19', 'inactive'),
	(25, 10, '2022-03-21 08:51:23', '2022-03-23 15:35:13', 'inactive'),
	(26, 11, '2022-03-22 08:22:50', '2022-03-23 15:49:19', 'inactive'),
	(27, 11, '2022-03-22 19:06:19', '2022-03-23 15:49:19', 'inactive'),
	(28, 10, '2022-03-22 19:13:48', '2022-03-23 15:35:13', 'inactive'),
	(29, 11, '2022-03-22 19:14:42', '2022-03-23 15:49:19', 'inactive'),
	(30, 10, '2022-03-22 19:15:35', '2022-03-23 15:35:13', 'inactive'),
	(31, 10, '2022-03-23 15:35:08', '2022-03-23 15:35:13', 'inactive'),
	(32, 11, '2022-03-23 15:35:16', '2022-03-23 15:49:19', 'inactive'),
	(33, 11, '2022-03-23 15:37:04', '2022-03-23 15:49:19', 'inactive'),
	(34, 10, '2022-03-23 15:40:10', '2022-03-24 08:08:26', 'inactive'),
	(35, 11, '2022-03-23 15:43:22', '2022-03-23 15:49:19', 'inactive'),
	(36, 11, '2022-03-23 15:49:16', '2022-03-23 15:49:19', 'inactive'),
	(37, 3, '2022-03-23 21:11:28', '2022-03-26 11:44:15', 'inactive'),
	(38, 3, '2022-03-24 08:10:16', '2022-03-26 11:44:15', 'inactive'),
	(39, 1, '2022-03-24 08:11:10', '2022-03-25 13:40:48', 'inactive'),
	(40, 1, '2022-03-24 08:21:20', '2022-03-25 13:40:48', 'inactive'),
	(41, 30, '2022-03-24 08:21:38', '2022-03-24 08:21:54', 'inactive'),
	(42, 30, '2022-03-24 08:32:21', '2022-03-24 11:47:13', 'inactive'),
	(43, 3, '2022-03-24 11:15:18', '2022-03-26 11:44:15', 'inactive'),
	(44, 30, '2022-03-24 11:47:47', '2022-03-25 14:05:09', 'inactive'),
	(45, 2, '2022-03-24 15:38:30', '2022-03-25 14:05:10', 'inactive'),
	(46, 3, '2022-03-24 15:45:37', '2022-03-26 11:44:15', 'inactive'),
	(47, 3, '2022-03-24 15:54:38', '2022-03-26 11:44:15', 'inactive'),
	(48, 1, '2022-03-25 13:39:33', '2022-03-25 13:40:48', 'inactive'),
	(49, 10, '2022-03-25 13:59:25', '2022-03-25 16:49:50', 'inactive'),
	(50, 30, '2022-03-25 14:06:31', '2022-03-28 08:38:26', 'inactive'),
	(51, 2, '2022-03-25 15:42:12', '2022-03-25 16:51:11', 'inactive'),
	(52, 3, '2022-03-25 16:40:15', '2022-03-26 11:44:15', 'inactive'),
	(53, 11, '2022-03-25 16:50:07', '2022-03-28 08:38:29', 'inactive'),
	(54, 3, '2022-03-26 11:37:53', '2022-03-26 11:44:15', 'inactive'),
	(55, 30, '2022-03-28 08:39:08', '2022-03-29 07:26:25', 'inactive'),
	(56, 3, '2022-03-28 12:02:49', '2022-03-29 07:26:26', 'inactive'),
	(57, 30, '2022-03-29 08:19:42', '2022-03-29 18:53:16', 'inactive'),
	(58, 10, '2022-03-29 16:14:04', '2022-03-29 18:53:17', 'inactive'),
	(59, 11, '2022-03-29 17:40:44', '2022-03-29 18:53:18', 'inactive'),
	(60, 10, '2022-03-29 18:53:32', '2022-03-30 09:21:47', 'inactive'),
	(61, 30, '2022-03-30 07:55:02', '2022-03-30 10:07:49', 'inactive'),
	(62, 10, '2022-03-30 09:21:53', NULL, 'active'),
	(63, 30, '2022-03-30 10:08:10', NULL, 'active'),
	(64, 3, '2022-03-30 15:02:00', NULL, 'active'),
	(65, 10, '2022-03-30 17:39:01', NULL, 'active'),
	(66, 10, '2022-03-30 19:24:52', NULL, 'active'),
	(67, 10, '2022-03-30 19:24:58', NULL, 'active'),
	(68, 30, '2022-03-31 08:22:16', NULL, 'active'),
	(69, 30, '2022-03-31 14:44:13', NULL, 'active'),
	(70, 30, '2022-04-01 08:08:05', NULL, 'active'),
	(71, 3, '2022-04-01 15:10:52', NULL, 'active'),
	(72, 30, '2022-04-01 15:31:54', NULL, 'active'),
	(73, 30, '2022-04-02 09:13:20', NULL, 'active'),
	(74, 3, '2022-04-02 14:06:09', NULL, 'active'),
	(75, 30, '2022-04-04 09:08:00', NULL, 'active'),
	(76, 10, '2022-04-04 09:17:20', NULL, 'active'),
	(77, 3, '2022-04-04 09:20:12', NULL, 'active'),
	(78, 30, '2022-04-04 09:22:55', NULL, 'active'),
	(79, 12, '2022-04-04 09:26:26', '2022-04-04 09:31:57', 'inactive'),
	(80, 12, '2022-04-04 09:32:24', NULL, 'active'),
	(81, 3, '2022-04-04 14:53:58', NULL, 'active'),
	(82, 3, '2022-04-04 15:24:41', NULL, 'active'),
	(83, 3, '2022-04-04 15:25:18', NULL, 'active'),
	(84, 12, '2022-04-04 15:25:58', NULL, 'active'),
	(85, 3, '2022-04-04 15:38:37', NULL, 'active'),
	(86, 12, '2022-04-04 15:50:59', NULL, 'active'),
	(87, 12, '2022-04-04 15:54:01', NULL, 'active'),
	(88, 3, '2022-04-04 16:21:59', NULL, 'active'),
	(89, 12, '2022-04-04 18:48:32', NULL, 'active'),
	(90, 30, '2022-04-05 08:36:54', NULL, 'active'),
	(91, 3, '2022-04-05 11:12:22', NULL, 'active'),
	(92, 3, '2022-04-05 16:09:34', NULL, 'active'),
	(93, 30, '2022-04-06 08:05:26', NULL, 'active'),
	(94, 3, '2022-04-06 08:25:52', NULL, 'active'),
	(95, 3, '2022-04-06 14:55:58', NULL, 'active'),
	(96, 3, '2022-04-06 14:57:40', NULL, 'active'),
	(97, 3, '2022-04-06 15:00:26', NULL, 'active'),
	(98, 30, '2022-04-06 15:00:59', NULL, 'active'),
	(99, 12, '2022-04-06 15:02:39', NULL, 'active'),
	(100, 1, '2022-04-06 15:12:57', NULL, 'active'),
	(101, 3, '2022-04-06 16:07:21', NULL, 'active'),
	(102, 30, '2022-04-07 07:52:18', NULL, 'active'),
	(103, 10, '2022-04-07 14:14:55', NULL, 'active'),
	(104, 30, '2022-04-07 14:15:31', NULL, 'active'),
	(105, 30, '2022-04-07 14:35:26', NULL, 'active'),
	(106, 30, '2022-04-07 15:39:18', NULL, 'active'),
	(107, 3, '2022-04-07 16:25:17', NULL, 'active'),
	(108, 3, '2022-04-07 16:42:06', NULL, 'active'),
	(109, 12, '2022-04-07 17:29:08', NULL, 'active'),
	(110, 3, '2022-04-07 17:45:58', NULL, 'active'),
	(111, 3, '2022-04-07 17:46:17', NULL, 'active'),
	(112, 30, '2022-04-07 17:58:46', NULL, 'active'),
	(113, 30, '2022-04-08 08:17:17', NULL, 'active'),
	(114, 30, '2022-04-08 13:53:35', NULL, 'active'),
	(115, 30, '2022-04-08 14:07:58', NULL, 'active'),
	(116, 30, '2022-04-08 14:51:58', NULL, 'active'),
	(117, 30, '2022-04-08 15:40:29', NULL, 'active'),
	(118, 3, '2022-04-08 16:48:43', NULL, 'active'),
	(119, 59, '2022-04-09 06:59:56', NULL, 'active'),
	(120, 30, '2022-04-09 08:03:33', NULL, 'active'),
	(121, 3, '2022-04-11 08:03:01', NULL, 'active'),
	(122, 10, '2022-04-11 09:46:41', NULL, 'active'),
	(123, 30, '2022-04-12 09:29:58', NULL, 'active'),
	(124, 30, '2022-04-13 15:13:04', NULL, 'active'),
	(125, 3, '2022-04-13 16:26:30', NULL, 'active'),
	(126, 30, '2022-04-13 19:17:46', NULL, 'active'),
	(127, 4, '2022-04-13 19:18:15', NULL, 'active'),
	(128, 3, '2022-04-14 11:02:04', NULL, 'active'),
	(129, 30, '2022-04-18 08:48:05', NULL, 'active'),
	(130, 30, '2022-04-18 11:49:26', NULL, 'active'),
	(131, 30, '2022-04-19 08:37:07', NULL, 'active'),
	(132, 30, '2022-04-19 09:24:15', NULL, 'active'),
	(133, 30, '2022-04-19 11:43:42', NULL, 'active'),
	(134, 3, '2022-04-19 11:48:36', NULL, 'active'),
	(135, 30, '2022-04-19 11:50:30', NULL, 'active'),
	(136, 30, '2022-04-19 11:58:39', NULL, 'active'),
	(137, 3, '2022-04-19 12:03:07', NULL, 'active'),
	(138, 3, '2022-04-19 12:25:13', NULL, 'active'),
	(139, 3, '2022-04-19 13:28:42', NULL, 'active'),
	(140, 30, '2022-04-19 14:13:25', NULL, 'active'),
	(141, 30, '2022-04-19 14:39:20', NULL, 'active'),
	(142, 3, '2022-04-19 15:19:33', NULL, 'active');
/*!40000 ALTER TABLE `tbl_users_session` ENABLE KEYS */;


-- Dumping database structure for wms_cloud
CREATE DATABASE IF NOT EXISTS `wms_cloud` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `wms_cloud`;

-- Dumping structure for procedure wms_cloud.sp_customers_additem
DELIMITER //
CREATE PROCEDURE `sp_customers_additem`(
IN __itemcode VARCHAR(45),
IN __clientsku VARCHAR(45),
IN __itemdesc VARCHAR(255),
IN __custid INT,
IN __matstype VARCHAR(191),
IN __category VARCHAR(191),
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
IN __maxqty INT)
BEGIN

INSERT INTO `tbl_items`(`ItemCode`,`Client_SKU`,`ItemDesc`,`ItemCustomerID`,`MaterialType`,`Category`,`MinTemp`,`MaxTemp`,`Length`,`Width`,`Height`, `Weight`, `PiecesPerCase`,`CasesPerPallet`,`UOMID`,`RepQTY`, `ParentCode`, `SubCat`, `ShelfLife`, `Price`, `Status`, `ItemClass`, `PriceClass`, `MinQty`, `MaxQty`)
VALUES (__itemcode, __clientsku, __itemdesc, __custid, __matstype, __category, __mintemp, __maxtemp, __length, __width, __height, __weight, __pcspercase, __casesperpallet, __uomid, __repqty, __parentcode, __subcat, __shelflife, __price, 'Hold', __itemclass, __priceclass, __minqty, __maxqty);

END//
DELIMITER ;

-- Dumping structure for procedure wms_cloud.sp_customers_itemsearch
DELIMITER //
CREATE PROCEDURE `sp_customers_itemsearch`(
IN __items VARCHAR(45),
IN __keys VARCHAR(500),
IN __custid INT)
BEGIN
DECLARE _items INT;

IF __items <> 'all' AND (__keys IS NULL OR __keys = '') THEN
	SET _items = __items;
	SELECT
	A.ItemID,
	A.ItemCode,
	A.Client_SKU,
	A.ItemDesc,
	B.MaterialType,
	C.ItemCategory,
	E.name,
	A.MinTemp,
	A.MaxTemp,
	CONCAT(A.Length, 'x', A.Width, 'x', A.Height),
	A.PiecesPerCase,
	A.CasesPerPallet,
	D.UOM_Abv,
	A.RepQTY,
	A.ShelfLife,
	A.Status,
	A.Length,
	A.width,
	A.Height
	FROM tbl_items A
	LEFT JOIN tbl_materials B ON A.MaterialType = B.MaterialID
	LEFT JOIN tbl_categories C ON A.Category = C.ItemCategoryID
	LEFT JOIN tbl_weightuom D ON A.UOMID = D.UOMID
	LEFT JOIN tbl_itemsubcategories E on A.SubCat = E.id
	WHERE A.ItemCustomerID = __custid LIMIT _items;
ELSEIF __items = 'all' AND (__keys IS NULL OR __keys = '') THEN
	SELECT
	A.ItemID,
	A.ItemCode,
	A.Client_SKU,
	A.ItemDesc,
	B.MaterialType,
	C.ItemCategory,
	E.name,
	A.MinTemp,
	A.MaxTemp,
	CONCAT(A.Length, 'x', A.Width, 'x', A.Height),
	A.PiecesPerCase,
	A.CasesPerPallet,
	D.UOM_Abv,
	A.RepQTY,
	A.ShelfLife,
	A.Status,
	A.Length,
	A.width,
	A.Height
	FROM tbl_items A
	LEFT JOIN tbl_materials B ON A.MaterialType = B.MaterialID
	LEFT JOIN tbl_categories C ON A.Category = C.ItemCategoryID
	LEFT JOIN tbl_weightuom D ON A.UOMID = D.UOMID
	LEFT JOIN tbl_itemsubcategories E on A.SubCat = E.id
	WHERE A.ItemCustomerID = __custid;
ELSEIF __items <> 'all' AND (__keys IS NOT NULL OR __keys != '') THEN
	SET _items = __items;
	SELECT
	A.ItemID,
	A.ItemCode,
	A.Client_SKU,
	A.ItemDesc,
	B.MaterialType,
	C.ItemCategory,
	E.name,
	A.MinTemp,
	A.MaxTemp,
	CONCAT(A.Length, 'x', A.Width, 'x', A.Height),
	A.PiecesPerCase,
	A.CasesPerPallet,
	D.UOM_Abv,
	A.RepQTY,
	A.ShelfLife,
	A.Status,
	A.Length,
	A.width,
	A.Height
	FROM tbl_items A
	LEFT JOIN tbl_materials B ON A.MaterialType = B.MaterialID
	LEFT JOIN tbl_categories C ON A.Category = C.ItemCategoryID
	LEFT JOIN tbl_weightuom D ON A.UOMID = D.UOMID
	LEFT JOIN tbl_itemsubcategories E on A.SubCat = E.id
	WHERE A.ItemCustomerID = __custid
    AND (A.ItemID LIKE CONCAT('%',__keys,'%') OR
    A.ItemCode LIKE CONCAT('%',__keys,'%') OR
    A.Client_SKU LIKE CONCAT('%',__keys,'%') OR
    A.ItemDesc LIKE CONCAT('%',__keys,'%') OR
    A.ItemCustomerID LIKE CONCAT('%',__keys,'%') OR
    B.MaterialType LIKE CONCAT('%',__keys,'%') OR
    C.ItemCategory LIKE CONCAT('%',__keys,'%') OR
    A.MinTemp LIKE CONCAT('%',__keys,'%') OR
    A.MaxTemp LIKE CONCAT('%',__keys,'%') OR
    A.Length LIKE CONCAT('%',__keys,'%') OR
    A.Width LIKE CONCAT('%',__keys,'%') OR
    A.Height LIKE CONCAT('%',__keys,'%') OR
    A.PiecesPerCase LIKE CONCAT('%',__keys,'%') OR
    A.CasesPerPallet LIKE CONCAT('%',__keys,'%') OR
    D.UOM LIKE CONCAT('%',__keys,'%') OR
    A.RepQTY LIKE CONCAT('%',__keys,'%')) LIMIT _items;
ELSEIF __items = 'all' AND (__keys IS NOT NULL OR __keys != '') THEN
	SELECT
	A.ItemID,
	A.ItemCode,
	A.Client_SKU,
	A.ItemDesc,
	B.MaterialType,
	C.ItemCategory,
	E.name,
	A.MinTemp,
	A.MaxTemp,
	CONCAT(A.Length, 'x', A.Width, 'x', A.Height),
	A.PiecesPerCase,
	A.CasesPerPallet,
	D.UOM_Abv,
	A.RepQTY,
	A.ShelfLife,
	A.Status,
	A.Length,
	A.width,
	A.Height
	FROM tbl_items A
	LEFT JOIN tbl_materials B ON A.MaterialType = B.MaterialID
	LEFT JOIN tbl_categories C ON A.Category = C.ItemCategoryID
	LEFT JOIN tbl_weightuom D ON A.UOMID = D.UOMID
	LEFT JOIN tbl_itemsubcategories E on A.SubCat = E.id
	WHERE A.ItemCustomerID = __custid
    AND (A.ItemID LIKE CONCAT('%',__keys,'%') OR
    A.ItemCode LIKE CONCAT('%',__keys,'%') OR
    A.Client_SKU LIKE CONCAT('%',__keys,'%') OR
    A.ItemDesc LIKE CONCAT('%',__keys,'%') OR
    A.ItemCustomerID LIKE CONCAT('%',__keys,'%') OR
    B.MaterialType LIKE CONCAT('%',__keys,'%') OR
    C.ItemCategory LIKE CONCAT('%',__keys,'%') OR
    A.MinTemp LIKE CONCAT('%',__keys,'%') OR
    A.MaxTemp LIKE CONCAT('%',__keys,'%') OR
    A.Length LIKE CONCAT('%',__keys,'%') OR
    A.Width LIKE CONCAT('%',__keys,'%') OR
    A.Height LIKE CONCAT('%',__keys,'%') OR
    A.PiecesPerCase LIKE CONCAT('%',__keys,'%') OR
    A.CasesPerPallet LIKE CONCAT('%',__keys,'%') OR
    D.UOM LIKE CONCAT('%',__keys,'%') OR
    A.RepQTY LIKE CONCAT('%',__keys,'%'));
END IF;

END//
DELIMITER ;

-- Dumping structure for procedure wms_cloud.SP_fillitemsearchsummary
DELIMITER //
CREATE PROCEDURE `SP_fillitemsearchsummary`(
	IN `__ID` INT,
	IN `__storagetype` VARCHAR(100)
)
BEGIN

	if __storagetype <> 'FW' THEN
SELECT ItemID, ItemDesc, ItemCode, Client_SKU
FROM tbl_items
WHERE ItemCustomerID=__ID AND Weight = 0 AND STATUS = 'Active'; ELSE
SELECT ItemID, ItemDesc, ItemCode, Client_SKU
FROM tbl_items
WHERE ItemCustomerID=__ID AND Weight > 0 AND STATUS = 'Active'; END if; END//
DELIMITER ;

-- Dumping structure for procedure wms_cloud.SP_manualpick
DELIMITER //
CREATE PROCEDURE `SP_manualpick`(
	IN `__itemid` INT
)
BEGIN
SELECT CONCAT(ColName, '-',
RIGHT(LCode, 1)), CONCAT(SystemPID, '-', ManualPID),

						r.Container,

						ItemCode,

						Client_SKU,

						ItemDesc,

						UOM_Abv, SUM(ri.Quantity),

						ri.Weight,

						ExpiryDate,

						ri.ItemID,

						ri.PalletID,

						ri.ReceivingItemID,

						ri.ItemStatusID,

						iss.ItemStatus
FROM wms_inbound.tbl_receivingitems ri
LEFT JOIN wms_cloud.tbl_items item ON ri.ItemID = item.ItemID
LEFT JOIN wms_cloud.tbl_itemstatus iss ON ri.ItemStatusID = iss.ItemStatusID AND ri.ispick <> 2
LEFT JOIN wms_cloud.tbl_weightuom uom ON item.UOMID = uom.UOMID
LEFT JOIN wms_inbound.tbl_receiving r ON ri.IBN = r.IBN
LEFT JOIN wms_inbound.tbl_pallets pal ON ri.PalletID = pal.PalletID
LEFT JOIN wms_inbound.tbl_locations loc ON pal.LocationID = loc.LocationID
WHERE ri.ItemID = __itemid AND Checked = 'True' AND ri.Quantity > 0
GROUP BY ri.PalletID, ri.ItemID, ri.ExpiryDate, ri.ItemStatusID
ORDER BY ExpiryDate ASC, ColumnCode DESC, ri.PalletID; END//
DELIMITER ;

-- Dumping structure for table wms_cloud.tbl_annex_a
CREATE TABLE IF NOT EXISTS `tbl_annex_a` (
  `id` int NOT NULL AUTO_INCREMENT,
  `CustomerID` int DEFAULT NULL,
  `regular` double DEFAULT NULL,
  `legal` double DEFAULT NULL,
  `special` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_cloud.tbl_annex_a: ~143 rows (approximately)
/*!40000 ALTER TABLE `tbl_annex_a` DISABLE KEYS */;
INSERT INTO `tbl_annex_a` (`id`, `CustomerID`, `regular`, `legal`, `special`) VALUES
	(4, 7, 0, 0, 0),
	(5, 8, 0, 0, 0),
	(6, 9, 0, 0, 0),
	(7, 10, 0, 0, 0),
	(8, 11, 0, 0, 0),
	(9, 12, 0, 0, 0),
	(10, 13, 0, 0, 0),
	(11, 14, 0, 0, 0),
	(12, 15, 0, 0, 0),
	(13, 16, 0, 0, 0),
	(14, 17, 0, 0, 0),
	(15, 18, 0, 0, 0),
	(16, 19, 0, 0, 0),
	(17, 20, 0, 0, 0),
	(18, 21, 0, 0, 0),
	(19, 22, 0, 0, 0),
	(20, 23, 0, 0, 0),
	(21, 24, 0, 0, 0),
	(22, 25, 0, 0, 0),
	(23, 26, 0, 0, 0),
	(24, 27, 0, 0, 0),
	(25, 28, 0, 0, 0),
	(26, 29, 0, 0, 0),
	(27, 30, 0, 0, 0),
	(28, 31, 0, 0, 0),
	(29, 32, 0, 0, 0),
	(30, 33, 0, 0, 0),
	(31, 34, 0, 0, 0),
	(32, 35, 0, 0, 0),
	(33, 36, 0, 0, 0),
	(34, 37, 0, 0, 0),
	(35, 38, 0, 0, 0),
	(36, 39, 0, 0, 0),
	(37, 40, 0, 0, 0),
	(38, 41, 0, 0, 0),
	(39, 42, 0, 0, 0),
	(40, 43, 0, 0, 0),
	(41, 44, 0, 0, 0),
	(42, 45, 0, 0, 0),
	(43, 46, 0, 0, 0),
	(44, 47, 0, 0, 0),
	(45, 48, 0, 0, 0),
	(46, 49, 0, 0, 0),
	(47, 50, 0, 0, 0),
	(48, 51, 0, 0, 0),
	(49, 52, 0, 0, 0),
	(50, 53, 0, 0, 0),
	(51, 54, 0, 0, 0),
	(52, 55, 0, 0, 0),
	(53, 56, 0, 0, 0),
	(54, 57, 0, 0, 0),
	(55, 58, 0, 0, 0),
	(56, 59, 0, 0, 0),
	(57, 60, 0, 0, 0),
	(58, 61, 0, 0, 0),
	(59, 62, 0, 0, 0),
	(60, 63, 0, 0, 0),
	(61, 64, 0, 0, 0),
	(62, 65, 0, 0, 0),
	(63, 66, 0, 0, 0),
	(64, 67, 0, 0, 0),
	(65, 68, 0, 0, 0),
	(66, 69, 0, 0, 0),
	(67, 70, 0, 0, 0),
	(68, 71, 0, 0, 0),
	(69, 72, 0, 0, 0),
	(70, 73, 0, 0, 0),
	(71, 74, 0, 0, 0),
	(72, 75, 0, 0, 0),
	(73, 76, 0, 0, 0),
	(74, 77, 0, 0, 0),
	(75, 78, 0, 0, 0),
	(76, 79, 0, 0, 0),
	(77, 80, 0, 0, 0),
	(78, 81, 0, 0, 0),
	(79, 82, 0, 0, 0),
	(80, 83, 0, 0, 0),
	(81, 84, 642, 642, 500),
	(82, 85, 0, 0, 0),
	(83, 86, 0, 0, 0),
	(84, 87, 0, 0, 0),
	(85, 88, 0, 0, 0),
	(86, 89, 0, 0, 0),
	(87, 90, 0, 0, 0),
	(88, 91, 0, 0, 0),
	(89, 92, 0, 0, 0),
	(90, 93, 0, 0, 0),
	(91, 94, 0, 0, 0),
	(92, 95, 0, 0, 0),
	(93, 96, 0, 0, 0),
	(94, 97, 0, 0, 0),
	(95, 98, 0, 0, 0),
	(96, 99, 0, 0, 0),
	(97, 100, 0, 0, 0),
	(98, 101, 0, 0, 0),
	(99, 102, 0, 0, 0),
	(100, 103, 0, 0, 0),
	(101, 104, 0, 0, 0),
	(102, 105, 0, 0, 0),
	(103, 106, 0, 0, 0),
	(104, 107, 0, 0, 0),
	(105, 108, 0, 0, 0),
	(106, 109, 1, 1, 1),
	(107, 110, 0, 0, 0),
	(108, 115, 0, 0, 0),
	(109, 119, 0, 0, 0),
	(110, 120, 0, 0, 0),
	(111, 121, 0, 0, 0),
	(112, 122, 0, 0, 0),
	(113, 123, 0, 0, 0),
	(114, 125, 0, 0, 0),
	(115, 126, 0, 0, 0),
	(116, 127, 0, 0, 0),
	(117, 128, 0, 0, 0),
	(118, 129, 0, 0, 0),
	(119, 130, 0, 0, 0),
	(120, 131, 0, 0, 0),
	(121, 132, 0, 0, 0),
	(122, 133, 0, 0, 0),
	(123, 135, 0, 0, 0),
	(124, 136, 0, 0, 0),
	(125, 137, 0, 0, 0),
	(126, 138, 0, 0, 0),
	(127, 139, 0, 0, 0),
	(128, 140, 0, 0, 0),
	(129, 145, 0, 0, 0),
	(130, 146, 0, 0, 0),
	(131, 147, 0, 0, 0),
	(132, 148, 0, 0, 0),
	(133, 149, 0, 0, 0),
	(134, 150, 0, 0, 0),
	(135, 151, 0, 0, 0),
	(136, 152, 0, 0, 0),
	(137, 153, 0, 0, 0),
	(138, 154, 0, 0, 0),
	(139, 155, 0, 0, 0),
	(140, 156, 0, 0, 0),
	(141, 157, 0, 0, 0),
	(142, 158, 0, 0, 0),
	(143, 160, 0, 0, 0),
	(144, 160, 0, 0, 0),
	(145, 160, 0, 0, 0),
	(146, 163, 0, 0, 0),
	(147, 164, 0, 0, 0);
/*!40000 ALTER TABLE `tbl_annex_a` ENABLE KEYS */;

-- Dumping structure for table wms_cloud.tbl_annex_b
CREATE TABLE IF NOT EXISTS `tbl_annex_b` (
  `id` int NOT NULL AUTO_INCREMENT,
  `CustomerID` int DEFAULT NULL,
  `OTSC_A` double DEFAULT NULL,
  `OTSC_B` double DEFAULT NULL,
  `FR_A` double DEFAULT NULL,
  `FR_B` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_cloud.tbl_annex_b: ~142 rows (approximately)
/*!40000 ALTER TABLE `tbl_annex_b` DISABLE KEYS */;
INSERT INTO `tbl_annex_b` (`id`, `CustomerID`, `OTSC_A`, `OTSC_B`, `FR_A`, `FR_B`) VALUES
	(4, 7, 0, 0, 0, 0),
	(5, 8, 0, 0, 0, 0),
	(6, 9, 0, 0, 0, 0),
	(7, 10, 0, 0, 0, 0),
	(8, 11, 0, 0, 0, 0),
	(9, 12, 0, 0, 0, 0),
	(10, 13, 0, 0, 0, 0),
	(11, 14, 0, 0, 0, 0),
	(12, 15, 0, 0, 0, 0),
	(13, 16, 0, 0, 0, 0),
	(14, 17, 0, 0, 0, 0),
	(15, 18, 0, 0, 0, 0),
	(16, 19, 0, 0, 0, 0),
	(17, 20, 0, 0, 0, 0),
	(18, 21, 0, 0, 0, 0),
	(19, 22, 0, 0, 0, 0),
	(20, 23, 0, 0, 0, 0),
	(21, 24, 0, 0, 0, 0),
	(22, 25, 0, 0, 0, 0),
	(23, 26, 0, 0, 0, 0),
	(24, 27, 0, 0, 0, 0),
	(25, 28, 0, 0, 0, 0),
	(26, 29, 0, 0, 0, 0),
	(27, 30, 0, 0, 0, 0),
	(28, 31, 0, 0, 0, 0),
	(29, 32, 0, 0, 0, 0),
	(30, 33, 0, 0, 0, 0),
	(31, 34, 0, 0, 0, 0),
	(32, 35, 0, 0, 0, 0),
	(33, 36, 0, 0, 0, 0),
	(34, 37, 0, 0, 0, 0),
	(35, 38, 0, 0, 0, 0),
	(36, 39, 0, 0, 0, 0),
	(37, 40, 0, 0, 0, 0),
	(38, 41, 0, 0, 0, 0),
	(39, 42, 0, 0, 0, 0),
	(40, 43, 0, 0, 0, 0),
	(41, 44, 0, 0, 0, 0),
	(42, 45, 0, 0, 0, 0),
	(43, 46, 0, 0, 0, 0),
	(44, 47, 0, 0, 0, 0),
	(45, 48, 0, 0, 0, 0),
	(46, 49, 0, 0, 0, 0),
	(47, 50, 0, 0, 0, 0),
	(48, 51, 0, 0, 0, 0),
	(49, 52, 0, 0, 0, 0),
	(50, 53, 0, 0, 0, 0),
	(51, 54, 0, 0, 0, 0),
	(52, 55, 0, 0, 0, 0),
	(53, 56, 0, 0, 0, 0),
	(54, 57, 0, 0, 0, 0),
	(55, 58, 0, 0, 0, 0),
	(56, 59, 0, 0, 0, 0),
	(57, 60, 0, 0, 0, 0),
	(58, 61, 0, 0, 0, 0),
	(59, 62, 0, 0, 0, 0),
	(60, 63, 0, 0, 0, 0),
	(61, 64, 0, 0, 0, 0),
	(62, 65, 0, 0, 0, 0),
	(63, 66, 0, 0, 0, 0),
	(64, 67, 0, 0, 0, 0),
	(65, 68, 0, 0, 0, 0),
	(66, 69, 0, 0, 0, 0),
	(67, 70, 0, 0, 0, 0),
	(68, 71, 0, 0, 0, 0),
	(69, 72, 0, 0, 0, 0),
	(70, 73, 0, 0, 0, 0),
	(71, 74, 0, 0, 0, 0),
	(72, 75, 0, 0, 0, 0),
	(73, 76, 0, 0, 0, 0),
	(74, 77, 0, 0, 0, 0),
	(75, 78, 0, 0, 0, 0),
	(76, 79, 0, 0, 0, 0),
	(77, 80, 0, 0, 0, 0),
	(78, 81, 0, 0, 0, 0),
	(79, 82, 0, 0, 0, 0),
	(80, 83, 0, 0, 0, 0),
	(81, 84, 6834, 4670, 500, 650),
	(82, 85, 0, 0, 0, 0),
	(83, 86, 0, 0, 0, 0),
	(84, 87, 0, 0, 0, 0),
	(85, 88, 0, 0, 0, 0),
	(86, 89, 0, 0, 0, 0),
	(87, 90, 0, 0, 0, 0),
	(88, 91, 0, 0, 0, 0),
	(89, 92, 0, 0, 0, 0),
	(90, 93, 0, 0, 0, 0),
	(91, 94, 0, 0, 0, 0),
	(92, 95, 0, 0, 0, 0),
	(93, 96, 0, 0, 0, 0),
	(94, 97, 0, 0, 0, 0),
	(95, 98, 0, 0, 0, 0),
	(96, 99, 0, 0, 0, 0),
	(97, 100, 0, 0, 0, 0),
	(98, 101, 0, 0, 0, 0),
	(99, 102, 0, 0, 0, 0),
	(100, 103, 0, 0, 0, 0),
	(101, 104, 0, 0, 0, 0),
	(102, 105, 0, 0, 0, 0),
	(103, 106, 0, 0, 0, 0),
	(104, 107, 0, 0, 0, 0),
	(105, 108, 0, 0, 0, 0),
	(106, 109, 1, 1, 1, 1),
	(107, 110, 0, 0, 0, 0),
	(108, 115, 0, 0, 0, 0),
	(109, 119, 0, 0, 0, 0),
	(110, 120, 0, 0, 0, 0),
	(111, 121, 0, 0, 0, 0),
	(112, 122, 0, 0, 0, 0),
	(113, 123, 0, 0, 0, 0),
	(114, 125, 0, 0, 0, 0),
	(115, 126, 0, 0, 0, 0),
	(116, 127, 0, 0, 0, 0),
	(117, 128, 0, 0, 0, 0),
	(118, 129, 0, 0, 0, 0),
	(119, 130, 0, 0, 0, 0),
	(120, 131, 0, 0, 0, 0),
	(121, 132, 0, 0, 0, 0),
	(122, 133, 0, 0, 0, 0),
	(123, 135, 0, 0, 0, 0),
	(124, 136, 0, 0, 0, 0),
	(125, 137, 0, 0, 0, 0),
	(126, 138, 0, 0, 0, 0),
	(127, 139, 0, 0, 0, 0),
	(128, 140, 0, 0, 0, 0),
	(129, 145, 0, 0, 0, 0),
	(130, 146, 0, 0, 0, 0),
	(131, 147, 0, 0, 0, 0),
	(132, 148, 0, 0, 0, 0),
	(133, 149, 0, 0, 0, 0),
	(134, 150, 0, 0, 0, 0),
	(135, 151, 0, 0, 0, 0),
	(136, 152, 0, 0, 0, 0),
	(137, 153, 0, 0, 0, 0),
	(138, 154, 0, 0, 0, 0),
	(139, 155, 0, 0, 0, 0),
	(140, 156, 0, 0, 0, 0),
	(141, 157, 0, 0, 0, 0),
	(142, 158, 0, 0, 0, 0),
	(143, 160, 0, 0, 0, 0),
	(144, 160, 0, 0, 0, 0),
	(145, 163, 0, 0, 0, 0),
	(146, 164, 0, 0, 0, 0);
/*!40000 ALTER TABLE `tbl_annex_b` ENABLE KEYS */;

-- Dumping structure for table wms_cloud.tbl_annex_c
CREATE TABLE IF NOT EXISTS `tbl_annex_c` (
  `id` int NOT NULL AUTO_INCREMENT,
  `CustomerID` int DEFAULT NULL,
  `2FCV` double DEFAULT NULL,
  `4FCV` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_cloud.tbl_annex_c: ~143 rows (approximately)
/*!40000 ALTER TABLE `tbl_annex_c` DISABLE KEYS */;
INSERT INTO `tbl_annex_c` (`id`, `CustomerID`, `2FCV`, `4FCV`) VALUES
	(4, 7, 0, 0),
	(5, 8, 0, 0),
	(6, 9, 0, 0),
	(7, 10, 0, 0),
	(8, 11, 0, 0),
	(9, 12, 0, 0),
	(10, 13, 0, 0),
	(11, 14, 0, 0),
	(12, 15, 0, 0),
	(13, 16, 0, 0),
	(14, 17, 0, 0),
	(15, 18, 0, 0),
	(16, 19, 0, 0),
	(17, 20, 0, 0),
	(18, 21, 0, 0),
	(19, 22, 0, 0),
	(20, 23, 0, 0),
	(21, 24, 0, 0),
	(22, 25, 0, 0),
	(23, 26, 0, 0),
	(24, 27, 0, 0),
	(25, 28, 0, 0),
	(26, 29, 0, 0),
	(27, 30, 0, 0),
	(28, 31, 0, 0),
	(29, 32, 0, 0),
	(30, 33, 0, 0),
	(31, 34, 0, 0),
	(32, 35, 0, 0),
	(33, 36, 0, 0),
	(34, 37, 0, 0),
	(35, 38, 0, 0),
	(36, 39, 0, 0),
	(37, 40, 0, 0),
	(38, 41, 0, 0),
	(39, 42, 0, 0),
	(40, 43, 0, 0),
	(41, 44, 0, 0),
	(42, 45, 0, 0),
	(43, 46, 0, 0),
	(44, 47, 0, 0),
	(45, 48, 0, 0),
	(46, 49, 0, 0),
	(47, 50, 0, 0),
	(48, 51, 0, 0),
	(49, 52, 0, 0),
	(50, 53, 0, 0),
	(51, 54, 0, 0),
	(52, 55, 0, 0),
	(53, 56, 0, 0),
	(54, 57, 0, 0),
	(55, 58, 0, 0),
	(56, 59, 0, 0),
	(57, 60, 0, 0),
	(58, 61, 0, 0),
	(59, 62, 0, 0),
	(60, 63, 0, 0),
	(61, 64, 0, 0),
	(62, 65, 0, 0),
	(63, 66, 0, 0),
	(64, 67, 0, 0),
	(65, 68, 0, 0),
	(66, 69, 0, 0),
	(67, 70, 0, 0),
	(68, 71, 0, 0),
	(69, 72, 0, 0),
	(70, 73, 0, 0),
	(71, 74, 0, 0),
	(72, 75, 0, 0),
	(73, 76, 0, 0),
	(74, 77, 0, 0),
	(75, 78, 0, 0),
	(76, 79, 0, 0),
	(77, 80, 0, 0),
	(78, 81, 0, 0),
	(79, 82, 0, 0),
	(80, 83, 0, 0),
	(81, 84, 2500, 3500),
	(82, 85, 0, 0),
	(83, 86, 0, 0),
	(84, 87, 0, 0),
	(85, 88, 0, 0),
	(86, 89, 0, 0),
	(87, 90, 0, 0),
	(88, 91, 0, 0),
	(89, 92, 0, 0),
	(90, 93, 0, 0),
	(91, 94, 0, 0),
	(92, 95, 0, 0),
	(93, 96, 0, 0),
	(94, 97, 0, 0),
	(95, 98, 0, 0),
	(96, 99, 0, 0),
	(97, 100, 0, 0),
	(98, 101, 0, 0),
	(99, 102, 0, 0),
	(100, 103, 0, 0),
	(101, 104, 0, 0),
	(102, 105, 0, 0),
	(103, 106, 0, 0),
	(104, 107, 0, 0),
	(105, 108, 0, 0),
	(106, 109, 1, 1),
	(107, 110, 0, 0),
	(108, 115, 0, 0),
	(109, 119, 0, 0),
	(110, 120, 0, 0),
	(111, 121, 0, 0),
	(112, 122, 0, 0),
	(113, 123, 0, 0),
	(114, 125, 0, 0),
	(115, 126, 0, 0),
	(116, 127, 0, 0),
	(117, 128, 0, 0),
	(118, 129, 0, 0),
	(119, 130, 0, 0),
	(120, 131, 0, 0),
	(121, 132, 0, 0),
	(122, 133, 0, 0),
	(123, 135, 0, 0),
	(124, 136, 0, 0),
	(125, 137, 0, 0),
	(126, 138, 0, 0),
	(127, 139, 0, 0),
	(128, 140, 0, 0),
	(129, 145, 0, 0),
	(130, 146, 0, 0),
	(131, 147, 0, 0),
	(132, 148, 0, 0),
	(133, 149, 0, 0),
	(134, 150, 0, 0),
	(135, 151, 0, 0),
	(136, 152, 0, 0),
	(137, 153, 0, 0),
	(138, 154, 0, 0),
	(139, 155, 0, 0),
	(140, 156, 0, 0),
	(141, 157, 0, 0),
	(142, 158, 0, 0),
	(143, 160, 0, 0),
	(144, 160, 0, 0),
	(145, 160, 0, 0),
	(146, 163, 0, 0),
	(147, 164, 0, 0);
/*!40000 ALTER TABLE `tbl_annex_c` ENABLE KEYS */;

-- Dumping structure for table wms_cloud.tbl_annex_d
CREATE TABLE IF NOT EXISTS `tbl_annex_d` (
  `id` int NOT NULL AUTO_INCREMENT,
  `CustomerID` int DEFAULT NULL,
  `BR` double DEFAULT NULL,
  `BE` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_cloud.tbl_annex_d: ~143 rows (approximately)
/*!40000 ALTER TABLE `tbl_annex_d` DISABLE KEYS */;
INSERT INTO `tbl_annex_d` (`id`, `CustomerID`, `BR`, `BE`) VALUES
	(1, 7, 0, 0),
	(2, 8, 0, 0),
	(3, 9, 0, 0),
	(4, 10, 0, 0),
	(5, 11, 0, 0),
	(6, 12, 0, 0),
	(7, 13, 0, 0),
	(8, 14, 0, 0),
	(9, 15, 0, 0),
	(10, 16, 0, 0),
	(11, 17, 0, 0),
	(12, 18, 0, 0),
	(13, 19, 0, 0),
	(14, 20, 0, 0),
	(15, 21, 0, 0),
	(16, 22, 0, 0),
	(17, 23, 0, 0),
	(18, 24, 0, 0),
	(19, 25, 0, 0),
	(20, 26, 0, 0),
	(21, 27, 0, 0),
	(22, 28, 0, 0),
	(23, 29, 0, 0),
	(24, 30, 0, 0),
	(25, 31, 0, 0),
	(26, 32, 0, 0),
	(27, 33, 0, 0),
	(28, 34, 0, 0),
	(29, 35, 0, 0),
	(30, 36, 0, 0),
	(31, 37, 0, 0),
	(32, 38, 0, 0),
	(33, 39, 0, 0),
	(34, 40, 0, 0),
	(35, 41, 0, 0),
	(36, 42, 0, 0),
	(37, 43, 0, 0),
	(38, 44, 0, 0),
	(39, 45, 0, 0),
	(40, 46, 0, 0),
	(41, 47, 0, 0),
	(42, 48, 0, 0),
	(43, 49, 0, 0),
	(44, 50, 0, 0),
	(45, 51, 0, 0),
	(46, 52, 0, 0),
	(47, 53, 0, 0),
	(48, 54, 0, 0),
	(49, 55, 0, 0),
	(50, 56, 0, 0),
	(51, 57, 0, 0),
	(52, 58, 0, 0),
	(53, 59, 0, 0),
	(54, 60, 0, 0),
	(55, 61, 0, 0),
	(56, 62, 0, 0),
	(57, 63, 0, 0),
	(58, 64, 0, 0),
	(59, 65, 0, 0),
	(60, 66, 0, 0),
	(61, 67, 0, 0),
	(62, 68, 0, 0),
	(63, 69, 0, 0),
	(64, 70, 0, 0),
	(65, 71, 0, 0),
	(66, 72, 0, 0),
	(67, 73, 0, 0),
	(68, 74, 0, 0),
	(69, 75, 0, 0),
	(70, 76, 0, 0),
	(71, 77, 0, 0),
	(72, 78, 0, 0),
	(73, 79, 0, 0),
	(74, 80, 0, 0),
	(75, 81, 0, 0),
	(76, 82, 0, 0),
	(77, 83, 0, 0),
	(78, 84, 8250, 2000),
	(79, 85, 0, 0),
	(80, 86, 0, 0),
	(81, 87, 0, 0),
	(82, 88, 0, 0),
	(83, 89, 0, 0),
	(84, 90, 0, 0),
	(85, 91, 0, 0),
	(86, 92, 0, 0),
	(87, 93, 0, 0),
	(88, 94, 0, 0),
	(89, 95, 0, 0),
	(90, 96, 0, 0),
	(91, 97, 0, 0),
	(92, 98, 0, 0),
	(93, 99, 0, 0),
	(94, 100, 0, 0),
	(95, 101, 0, 0),
	(96, 102, 0, 0),
	(97, 103, 0, 0),
	(98, 104, 0, 0),
	(99, 105, 0, 0),
	(100, 106, 0, 0),
	(101, 107, 0, 0),
	(102, 108, 0, 0),
	(103, 109, 1, 1),
	(104, 110, 0, 0),
	(105, 115, 0, 0),
	(106, 119, 0, 0),
	(107, 120, 0, 0),
	(108, 121, 0, 0),
	(109, 122, 0, 0),
	(110, 123, 0, 0),
	(111, 125, 0, 0),
	(112, 126, 0, 0),
	(113, 127, 0, 0),
	(114, 128, 0, 0),
	(115, 129, 0, 0),
	(116, 130, 0, 0),
	(117, 131, 0, 0),
	(118, 132, 0, 0),
	(119, 133, 0, 0),
	(120, 135, 0, 0),
	(121, 136, 0, 0),
	(122, 137, 0, 0),
	(123, 138, 0, 0),
	(124, 139, 0, 0),
	(125, 140, 0, 0),
	(126, 145, 0, 0),
	(127, 146, 0, 0),
	(128, 147, 0, 0),
	(129, 148, 0, 0),
	(130, 149, 0, 0),
	(131, 150, 0, 0),
	(132, 151, 0, 0),
	(133, 152, 0, 0),
	(134, 153, 0, 0),
	(135, 154, 0, 0),
	(136, 155, 0, 0),
	(137, 156, 0, 0),
	(138, 157, 0, 0),
	(139, 158, 0, 0),
	(140, 160, 0, 0),
	(141, 160, 0, 0),
	(142, 160, 0, 0),
	(143, 163, 0, 0),
	(144, 164, 0, 0);
/*!40000 ALTER TABLE `tbl_annex_d` ENABLE KEYS */;

-- Dumping structure for table wms_cloud.tbl_categories
CREATE TABLE IF NOT EXISTS `tbl_categories` (
  `ItemCategoryID` int unsigned NOT NULL AUTO_INCREMENT,
  `ItemCategory` varchar(191) NOT NULL,
  `rmtype_id` int DEFAULT NULL,
  PRIMARY KEY (`ItemCategoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_cloud.tbl_categories: ~4 rows (approximately)
/*!40000 ALTER TABLE `tbl_categories` DISABLE KEYS */;
INSERT INTO `tbl_categories` (`ItemCategoryID`, `ItemCategory`, `rmtype_id`) VALUES
	(1, 'Freezer', 4),
	(2, 'Freezer - Ice Cream', 4),
	(3, 'Chiller', 3),
	(4, 'Controlled Temp', 1);
/*!40000 ALTER TABLE `tbl_categories` ENABLE KEYS */;

-- Dumping structure for table wms_cloud.tbl_colstatus
CREATE TABLE IF NOT EXISTS `tbl_colstatus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_cloud.tbl_colstatus: ~2 rows (approximately)
/*!40000 ALTER TABLE `tbl_colstatus` DISABLE KEYS */;
INSERT INTO `tbl_colstatus` (`id`, `status`) VALUES
	(1, 'Available'),
	(2, 'Not Available');
/*!40000 ALTER TABLE `tbl_colstatus` ENABLE KEYS */;

-- Dumping structure for table wms_cloud.tbl_customercreditstatusid
CREATE TABLE IF NOT EXISTS `tbl_customercreditstatusid` (
  `id` int NOT NULL AUTO_INCREMENT,
  `val` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_cloud.tbl_customercreditstatusid: ~3 rows (approximately)
/*!40000 ALTER TABLE `tbl_customercreditstatusid` DISABLE KEYS */;
INSERT INTO `tbl_customercreditstatusid` (`id`, `val`) VALUES
	(1, 'Updated'),
	(2, 'With AR'),
	(3, 'Over Limit');
/*!40000 ALTER TABLE `tbl_customercreditstatusid` ENABLE KEYS */;

-- Dumping structure for table wms_cloud.tbl_customers
CREATE TABLE IF NOT EXISTS `tbl_customers` (
  `CustomerID` int unsigned NOT NULL AUTO_INCREMENT,
  `CustomerName` varchar(191) DEFAULT NULL,
  `CompanyName` varchar(191) DEFAULT NULL,
  `CustomerNumber` varchar(191) DEFAULT NULL,
  `CustomerEmail` varchar(191) DEFAULT NULL,
  `CustomerAddress` varchar(191) DEFAULT NULL,
  `CustomerCity` varchar(191) DEFAULT NULL,
  `CustomerCode` varchar(191) DEFAULT NULL,
  `CustomerCommonCode` varchar(191) DEFAULT NULL,
  `CustomerTradeName` varchar(191) DEFAULT NULL,
  `CustomerApprovalStatusID` int DEFAULT NULL,
  `FreezerGuaranteed` int DEFAULT '0',
  `IceCreamFreezerGuaranteed` int DEFAULT NULL,
  `ChillerGuaranteed` int DEFAULT NULL,
  `DryGuaranteed` int DEFAULT NULL,
  `hold` tinyint(1) DEFAULT NULL,
  `StartEnrollmentDate` datetime DEFAULT NULL,
  `sr_exclusiveperpallet` double DEFAULT '0',
  `sr_exclusiveperweight` double DEFAULT '0',
  `sr_guaranteedperpallet` double DEFAULT '0',
  `sr_guaranteedperweight` double DEFAULT '0',
  `sr_commonperpallet` double DEFAULT '0',
  `sr_commonperweight` double DEFAULT '0',
  `hc_pr_peruom` double DEFAULT '0',
  `hc_or_deposit_perpallet` double DEFAULT '0',
  `hc_or_deposit_perweight` double DEFAULT '0',
  `hc_or_withdrawal_perpallet` double DEFAULT '0',
  `hc_or_withdrawal_perweight` double DEFAULT '0',
  `WarehouseID` varchar(50) DEFAULT NULL,
  `Contract_End` datetime DEFAULT NULL,
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_cloud.tbl_customers: ~142 rows (approximately)
/*!40000 ALTER TABLE `tbl_customers` DISABLE KEYS */;
INSERT INTO `tbl_customers` (`CustomerID`, `CustomerName`, `CompanyName`, `CustomerNumber`, `CustomerEmail`, `CustomerAddress`, `CustomerCity`, `CustomerCode`, `CustomerCommonCode`, `CustomerTradeName`, `CustomerApprovalStatusID`, `FreezerGuaranteed`, `IceCreamFreezerGuaranteed`, `ChillerGuaranteed`, `DryGuaranteed`, `hold`, `StartEnrollmentDate`, `sr_exclusiveperpallet`, `sr_exclusiveperweight`, `sr_guaranteedperpallet`, `sr_guaranteedperweight`, `sr_commonperpallet`, `sr_commonperweight`, `hc_pr_peruom`, `hc_or_deposit_perpallet`, `hc_or_deposit_perweight`, `hc_or_withdrawal_perpallet`, `hc_or_withdrawal_perweight`, `WarehouseID`, `Contract_End`) VALUES
	(7, 'Ms. Maria Theresa Dioso', 'Tom N Toms Phils., Inc.', '(034)4320919/09178367190', 'gon701@naver.com', '26th Lacson St., Brgy. Mandalagan, Bacolod City, Negros Occidental, 6100', 'Bacolod', 'TGK0002', 'TGK0002', 'HORECA', NULL, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(8, 'Ms. Marilyn Park', 'AMRN Meat Trading', '(639)9271780438', 'amrnmeat@yahoo.com', '3258 B Riverview Comp. Tambo Paranaque', 'Paranaque', 'AMP0004', 'AMP0004', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(9, 'Mr. Sammy S. Garcia', 'Jam Seafoods Traders Inc.', '(02)8325575', 'van@jamseafoods.com', '9794 Santan St., Vitalez Compound. Balato, Paranaque City', 'Paranaque', 'JSG0005', 'JSG0005', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(10, 'Mr. Reynaldo R. Sy / Reynaldo M. Retiza', 'Mang Kiko Catering Services, Inc.', '8154795 loc 123 / 09178197488', 'seachamp@seachamp.com.ph', 'Lot 94 C Electronics Avenue FTI Complex Western Bicutan, Taguig', 'Taguig', 'MRS0006', 'MRS0006', 'HORECA', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(11, 'Mr. Raquel R. Mughal', 'Raquel-Abbas Pharmaceuticals & General Merchandise', '(02)8357547', 'yanmund08@gmail.com', 'No. 7 Madre Isabella di Rocis St., Multinational Village, Paranaque City', 'Paranaque', 'RRM0007', 'RRM0007', 'DISTRIBUTOR', NULL, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(12, 'Ms. Anna Marie G. Sy', 'Seachamp Foods Corporation', '(02)8154795', 'seachamp@seachamp.com.ph', 'Lot 94 C Electronics Avenue FTI Complex Western Bicutan, Taguig', 'Taguig', 'SAS0008', 'SAS0008', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(13, 'Mr. Reynaldo R. Sy / Reynaldo M. Retiza', 'Seachamp International Export Corporation', '(02)8154795', 'seachamp@seachamp.com.ph', 'Lot 94 C Electronics Avenue FTI Complex Western Bicutan, Taguig', 'Taguig', 'SRS0009', 'SRS0009', 'DISTRIBUTOR', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(15, 'Mr. Chester Chua / Mr. Hans Shao / Ms. Jovy', 'Baijia Frozen Food Corporation', '4789398  / 5196910', 'joviesabangan@gmail.com', '81-A SGT. Mariano St., Don Carlos Pasay City', 'Pasay', 'BFF0012', 'BFF0012', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(16, 'Mr. Aaron Joseph A. Lozano', 'Mondelez Philippines Inc.', '(639)9178411791', 'Cristina.Maranan@mdlz.com', '8378 Dr. A Santos Avenue Paranaque City', 'Paranaque', 'MPI0013', 'MPI0013', 'FOOD MANUFACTURER', NULL, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(17, 'Ms. Gracey M. Jose', 'Global Pacific Distribution Network Corporation', '(02)4773079', 'kenneth.angan-angan@globalpacific.com.ph', '302 Millenium Place Meralco Ave., Ortigas Center, Brgy. San Antonio, Pasig City', 'Pasig', 'GPD0014', 'GPD0014', 'DISTRIBUTOR', NULL, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(18, 'Mr. Andrew P. Borbon', 'Alsons Aquaculture Corporation', '9178829508', 'apborbon@saranganibay.com.ph', 'Alsons Bldg. 2286 Pasong Tamo Ext. Barangay Magallanes, Makati City', 'Makati', 'AAC0015', 'AAC0015', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(19, 'Ms. Marilyn De Mesa', 'Anderlude Seafoods Corporation', '(639)9173288162', 'anderludeseafoods@yahoo.com', 'PFDA Davao  Fishport Complex Daliao Toril, Davao City', 'Davao', 'ASC0016', 'ASC0016', 'FOOD MANUFACTURER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(20, 'Mr. Vecent Q. David / Mr. Arturo Hernando', 'Classic Fine Foods Philippines Inc.', '(02)8891676', 'b.mendoza@classic.com.ph', '26th Flr., Yuchengco Tower 1, RCBC Plaza, Ayala Ave., Makati City', 'Makati', 'CFF0017', 'CFF0017', 'HORECA', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(21, 'Mr. Kenneth C. Kokseng / Wilford Lapon', 'Cebu Golden Restaurant Inc. / Golden Cowrie', '(032)2312481 / 09335315783 / 09237160603', 'cowriefinance.roselle@gmail.com , cowrieacctg.audit@gmail.com , cowrieaccounting@gmail.com', 'Salinas Drive Lahug Cebu City', 'Cebu', 'CGC0018', 'CGC0018', 'HORECA', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(22, 'Me. Peter Martin Sia', 'KLT Fruits Inc.', '7471039/7479612', '', 'Unit 610 Globe Telecom Plaza Tower 1 Madison cor Pioneer St. Mandaluyong City', 'Mandaluyong', 'KFI0019', 'KFI0019', 'DISTRIBUTOR', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(23, 'Ms. Leonora L. Corrales / Florence Ortisano', 'Lexerl Trading', '8032097 /  09176521112', 'earlcorrales@lexerl.com', '482-488 Real St. Almanza Uno, Las Pinas City', 'Las Pinas', 'LLC0020', 'LLC0020', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(24, 'Mr. Patrick Tong', 'Link Import Export Enterprise Inc.', '(639)9175268228', 'linkieei@compass.com.ph , fslinkieei@gmail.com', 'Rm 509 Federation Center Bldg. Muelle De Binondo San Nicolas Manila', 'Manila', 'LIE0021', 'LIE0021', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(25, 'Mr. Bryan Flores / Rolly Freyra', 'Lucky Chan', '09176755777 / 09661974003', 'bryanchan861224@gmail.com', '#2 Kaingin Road Sto.Nino Paranaque City', 'Paranaque', 'LBF0022', 'LBF0022', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(26, 'Ms. Cindy Dela Cruz ', 'Meatplus Trading Corp', '09176729176 / 2444619 / 2444620', 'treasury@meatplus.ph , joeyalbert.meatplus@gmail.com', '2057 Velasquez St. Barangay 097 Zone 08 Tondo Manila', 'Manila', 'MTC0023', 'MTC0023', 'HORECA', NULL, 0, 0, 0, 0, 0, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(27, 'Mr. Gerald Egasse', 'Minute Gourmet, Inc. / GERALD.ph', '(639)9177722977', 'ge@minutegourmet.ph', 'Unit 3A Maxfel Bldg. Jose Corazon De Jesus Street Barangay Poblacion Santa Maria Bulacan', 'Bulacan', 'MGI0024', 'MGI0024', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(28, 'Ms. Maria Eloisa Raya', 'Quezon Poultry & Livestocks Corporation', '', 'quezonpoultrybaras@gmail.com', '', '', 'QPL0025', 'QPL0025', 'FOOD MANUFACTURER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(29, 'Mr. Kenjie Norbertus G. Del Rosario', 'Rare Global Food Trading', '(639)9178606420', 'kenjie_delrosario@yahoo.com', 'Benson Industrial Cold Storage, Irenaville Subd. Brgy. Bf Homes, Sucat Paranaque City', 'Paranaque', 'RGF0026', 'RGF0026', 'FOOD MANUFACTURER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(30, 'Mr. Joshua Aragon', 'Zagana', '(639)9178010461', 'josh@zagana.com', '3rd Floor Ablaza Building 117 E, Rodriguez Sr. Ave. brgy. Tatalon, Quezon City Metro Manila 1102', 'Quezon', 'ZJA0027', 'ZJA0027', 'DISTRIBUTOR', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(31, 'Ms. Maribel Palo', 'Wisk Fine', '(639)9175681244', 'maribel.palo@wisk.com.ph', '4th Floor, Tower One & Exchange Plaza, Ayala Triangle, Ayala Avenue, Makati City', 'Makati', 'WFF0029', 'WFF0029', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(32, 'Mr. Emmanuel A. Baizas', 'Baimeats Agri Trading', '(639)9989524507', 'baimeatsagritrading@gmail.com', '2/F Salonga Building Cagayan Valley Rd. Tabang Plaridel Bulacan', 'Bulacan', 'BAT0031', 'BAT0031', 'DISTRIBUTOR', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(33, 'Mr. Jon Del Rosario', 'Fagokho Corporation', '(639)9177105486', 'teresa.vasquez@ramennagi.com.ph', '', '', 'FCC0032', 'FCC0032', 'HORECA', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(34, 'Ms. Stephanie Wang', 'Fil Ez Travel Corp', '(639)9158891696', '', 'A 521 Sea Residence Diokno Blvd. Pasay City', 'Pasay', 'FTC0033', 'FTC0033', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(35, 'Mr. Shakespeare Ang', 'Golden Orchard Distribution Inc', '(639)9178633100', 'goldorchard27@gmail.com', '', '', 'GOD0035', 'GOD0035', 'DISTRIBUTOR', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(36, 'Mr. Eun Hong Kim', 'GSGM INC', '(639)276235860', 'gsgm.ph@gmail.com', 'Lot 7, Block 28 BF Martinville Manuyo Dos City of Las Pinas Fourth District', 'Las Pinas', 'GIE0036', 'GIE0036', 'DISTRIBUTOR', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(37, 'Mr. James Lee / Fhemmy Manglanlan', 'Gabrien Food Corporation', '8552560 / 8552561', 'yulickfoodscorp@gmail.com', '1016 Roxas Boulevard Tambo Paranaque City', 'Paranaque', 'GFC0037', 'GFC0037', 'DISTRIBUTOR', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(39, 'Ms. Leah B. Garceron', 'Ifresh Corporation', '(02)6333645', 'neil.delrosario@rrgroup.com.ph', 'Unit 1201 Jollibee Plaza Bldg., F. Ortigas Center San Antonio Pasig City', 'Pasig', 'IFC0039', 'IFC0039', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(40, 'Mr. Ralph Francis Dela Cruz / Bryan Kenneth', 'Dragon JJ8 F & B Trading Corp', '09664179015 / 09270870965', 'angdeux@naver.com', 'Lot 14 Blk. 7 Anunas Angeles City, Pampanga', 'Angelez', 'DJJ0040', 'DJJ0040', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(41, 'Ms. Evelyn De Leon', 'Bollore Logistics Philippines Inc.', '(639)9176339203', 'ryan-alvin.vizcarra@bollore.com', '3rd Floor formation Bldg. B Amvel Business Park Dr A Santos Ave. San Dionisio, City of Paranaque', 'Paranaque', 'BLP0046', 'BLP0046', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(42, 'Ms. Rosalinda Caldito', 'New Zealand Creamery Inc.', '(639)9178052612', 'it.admin@nzcreameryinc.com , linda.caldito@newzealandcreameryinc.com', '6409 Camia St. Brgy. Guadalupe Viejo, Makati City', 'Makati', 'NZC0047', 'NZC0047', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(43, 'Ms. Gene Rono', 'Ten Knots Development Corporation', '(02)9025974', 'grono@elnidoresorts.com', '3rd Floor Alveo Corporate Center, 728 28th St.,Bonifacio Global City, 1634 Taguig Philippines', 'Taguig', 'TKD0049', 'TKD0049', 'HORECA', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(44, 'Mr. Andrew', 'AFC Seafoods Corporation', '(639)9662362999', 'alvaradojovelyn7@gmail.com', 'Lcu Compound #140 Northbay Blvd.St North Bay Blvd.Kaunlaran District, Navotas City 1485', 'Navotas', 'ASC0050', 'ASC0050', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(45, 'Ms. Nene Cruz', 'Maxs Kitchen Inc', '8299449 / 8299076 / 8299338', 'rbplaza@maxschicken.com , epgutierrez@maxschicken.com', '11 Flr., Ecoplaza Bldg., 2305 Chino Roces Ext., Magallanes, Makati City', 'Makati', 'MKI0052', 'MKI0052', 'HORECA', NULL, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(46, 'Ms. Pearl Villareal Nuqui', 'Magic Corn Philippines Inc.', '', 'pearl@magiccorn.com', '', 'Paranaque', 'MCP0053', 'MCP0053', 'DISTRIBUTOR', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(47, 'Mr. Edan Marri Canete ', 'Alcon Laboratories Philippines Inc', '(632) 7725266', '', '801 8 Floor Tower 1, Rockwell Business Center, Ortigas Avenue Pasig City', 'Pasig', 'ALP0054', 'ALP0054', 'DISTRIBUTOR', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(48, 'Ms. Ruby Alonzo', 'Tiger Resort Leisure and Entertainment Inc', '(02)8807555', '', 'Okada Mnl, New Seaside Dr., Entertaintment City Tambo, Paranaque', 'Paranaque', 'TRL0055', 'TRL0055', 'HORECA', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(49, 'Ms. Maureen Managing', 'PILMICO Animal Nutrition Corporation', '63 8862740/ 8862800', 'rudy.anthony.jbeily@aboitiz.com / sergio.latido@aboitiz.com', 'Aboitiz Corporate Center, Gov. Manuel A. Cuenco Ave. Kasambagan Cebu City', 'Tarlac', 'PAN0056', 'PAN0056', 'DISTRIBUTOR', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(50, 'Mr. Leofredo Martinez', 'The Real American Doughnut Co Inc.', '(02)8370244', 'mscastillo@krispykreme.com.ph', '11Flr Ecoplaza Bldg., 2305 Chino Roces Ave., Ext. Makati City', 'Taguig', 'TRA0058', 'TRA0058', 'DISTRIBUTOR', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(51, 'Ms.Rufina Cipriano', 'MASUMA Foods Inc', '88370321 loc 107/112', 'rbcipriano@contis.ph', 'Lot 91 B Bagsakan Road, Western Bicutan City Taguig', 'Bicutan', 'MFI0059', 'MFI0059', 'FOOD MANUFACTURER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(52, 'Ms. Ellen S. Espiritu', 'Yellow Cab Pizza Co', '(639)9989602079', 'msespiritu@maxsgourpinc.com', '11f Ecoplaza Building , 2305 Chino Roces Ave. Extension Makati City', 'Makati', 'YCP0060', 'YCP0060', 'HORECA', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(53, 'Ms. Anne Moraga', 'Frozenlink Inc', '(639)9950875060', 'sales.frozenlink@glacier.com.ph', 'Amvel Business Park, Barangay San Dionisio Paranaque City', 'Paranaque', 'FIT0061', 'FIT0061', 'DISTRIBUTOR', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(55, 'Mr. Reynaldo Malaluan  / Care of Ms. Kris Go', 'Bongabong Coconut Farmers Multipurpose Cooperative', '(639)9178017038', 'sdri.kris@gmail.com', 'Umali Street Poblacion, Bongabong Oriental Mindoro', 'Mindoro', 'BCF0063', 'BCF0063', 'DISTRIBUTOR', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(56, 'Ms. Quenniee Alejandro', 'Rizalyn Manio Manaloto', '(639)9175275094', 'qyalejandro1991@yahoo.com', '152 Balensula St. Bagong Bayan, Cut Cut Angeles City', 'Angeles', 'RMM0065', 'RMM0065', 'DISTRIBUTOR', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(57, 'Mr. Davidson Tangca', 'Uysen Marketing', '(02)6667777', 'uysenmktg@yahoo.com', 'RM 308-A The Teoff Centre Bldg. 355 Escolta Cor. T Pinpin & San Vicente Sts. Brgy.291 Zone 27 Binondo', 'Manila', 'UMT0066', 'UMT0066', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(58, '', 'Two World Traders', '', '', '', '', 'TWT0067', 'TWT0067', '', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(59, 'Mr. Ronaldo Lloren Fulgar', '99 Yabu Food Delivery Service', '09288232296 / 09277232296', 'Olanfulgar0317@gmail.com', '1938 D Dominga St., Pasay City', 'Pasay', 'YFD0068', 'YFD0068', 'DISTRIBUTOR', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(60, 'Mr. Kim Villena ', 'Artemisplus Express Inc', '(02)5530193', '', 'Lot 86 Avocado Road FTI Complex Taguig City ', 'Taguig', 'AEI0079', 'AEI0079', 'HORECA', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(61, 'Mr. Maurito Bongbong Lateo', 'Auszeal Inc', '8232699 / 8318649', 'domluansing.auszeal@gmail.com', '', 'paranaque', 'AIL0083', 'AIL0083', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(62, 'Ms. Janice Alfonso', 'CN Salamat Trading Company', '9063692 / 8100725 loc 109', 'janice.cnsalamat@gmail.com', 'Unit C7, Arcadia Square Guadalupe, Makati City', 'Makati', 'CST0083', 'CST0083', 'DISTRIBUTOR ', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(63, 'Mr. Ryan Serrano', 'Cookie Bridge Connection Inc.', '(639)9175237926', 'ryandyserrano@gmail.com', 'RM 306-B Henrys Building No. 80 Ortigas Ave Greenhills San Juan City 1502', 'San Juan', 'CBC0088', 'CBC0088', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(64, 'Mr. Alexander Palamoria Madridejo', 'Everlasting One Trading', '2450564 / 09333153251', 'Everlastingone@yahoo.com', 'Blk 4 Lot 7 Champaca St., UPS IV Paranaque City', 'Paranaque ', 'EOT0089', 'EOT0089', 'DISTRIBUTOR', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(65, 'Mr. Gian', 'Magnetica Electronic Inc.', '(639)9258085666', 'gian@pca.com', 'No. 059 Gov. Camerino Compound, Medecion 1-D, Imus Cavite', 'Cavite', 'MEI0090', 'MEI0090', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(66, 'Ms. Mayonie Morgado', 'Lmeyerf Pharma Inc', '(639)9171096620', 'mayonie.morgado@lmeyerf.com', '5f Solar Century Tower 100 Tordesillas Cor. HV Dela Costa Sts. Salcedo Village Makati City', 'Makati', 'LPI0091', 'LPI0091', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(67, 'Mr. Alberto Sanchez / Joni B. Cabilangan / Elmer Barasan', 'Vanguard Distribution and Logistics', '8872383 / 09082999433 / 09266386200', 'ebarasan.vanguard@gmail.com', '#800 Queensway Ave., Gourdous Bldg. Barrio Ibayo, Paranaque City', 'Paranaque', 'VDL0092', 'VDL0092', 'DISTRIBUTOR', NULL, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(68, 'Mr. SA Jaihyung', 'Hwayo Trading Inc', '(02)5014414', 'hwayodavid@gmail.com', '3F 590 Remedios Circle Brgy. 702 Zone 077 Manila, Metro Manila', 'Manila', 'HTI0093', 'HTI0093', 'HORECA', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(70, 'Ms. Audrey E.M.Yee', 'Supermega KYC Enterprise Inc', '09177941251 / 0917 7011683', 'kyc.main@gmail.com', 'Lot1 A5 Unit B Quirino Ave., San Dionisio, Paranaque City ', 'Paranque', 'SKE0101', 'SKE0101', 'DISTRIBUTOR', NULL, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(72, 'Ms. Robielyn Salamat Sartorio', 'Super Sale Food Solution Inc', '09178508089 / 09055539781', 'supersalefoodsolutionco@gmail.com', 'Amvel Business Park, Barangay San Dionisio Paranaque City', 'Cavite', 'SSF0110', 'SSF0110', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(73, 'Ms. Queenie Alejandro', 'Shanty International Trading', '09175275094 / 09257834888 /  09175275094', 'qyalejandro1991@yahoo.com', '#1080 Reina Regente Binondo Manila', 'Manila', 'SIT0111', 'SIT0111', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(74, 'Mr. Angelo Baroro', 'San Miguel Foods Inc.', '(639)9171472827', 'abaroro@sanmiguel.com.ph , apagente@sanmiguel.com.ph , lrebancos@sanmiguel.com.ph', '100 E Rodriguez Jr Avenue (C5 Road) Brgy. Ugong Pasig city', 'Pasig', 'SMF0112', 'SMF0112', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(75, 'Mr. Janzen de Jesus', 'The Golden Ruler Food Corporation', '(639)9177022662', 'admin@meetfreshph.com', '28 Malaya St., Malanday, Marikina 1805', 'Marikina', 'TGR0113', 'TGR0113', 'DISTRIBUTOR', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(76, 'Ms. Karen Alberto', 'Mann Trade Link Corporation', '(639)9669816950', 'ksfreshagro@gmail.com', 'Suite 2702 One Corporate Centre, Julia Vargas Cor. Meralco Ave. Ortigas Center Pasig', 'Pasig', 'MTL0115', 'MTL0115', 'FOOD MANUFACTURER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(77, 'Mr. James Edward Ko', 'Consolidated Dairy & Frozen Food Corporation', '(02)8210187', 'jamesko_03@yahoo.com', '18/F Units A-B San Fernando Tower Plaza del Conde,San Fernando St., Binondo Manila', 'Paranaque', 'CDF0119', 'CDF0119', 'DISTRIBUTOR ', NULL, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(78, 'Ms. Jayvelette Masangkay', 'MTDM Trading', '(02)5279707', 'mtdmtrading@yahoo.com.ph , Jmasangkay@mtdmtrading.com', 'Rm. 508-A Champ Building Anda Circle Port Area Manila', 'Manila', 'MTD0118', 'MTD0118', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(79, 'Ms. Imelda R. Banaag', 'IBX Cargo Corporation', '(02)8542703', 'ibxcargo@gmail.com', 'Salinas Drive Lahug Cebu City', 'Paranaque', 'ICC0123', 'ICC0123', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(81, 'Mr. Crispin Aquino', 'HAVI Logistics Inc', '', 'joyce.santos@havi.com', '', 'Marikina', 'HLI0127', 'HLI0127', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(82, 'Ms. Christine Reyes', 'YUSEN LOGISTICS PHILIPPINES INC', '(639)9171485318', 'christine.reyes@ph.yusen-logistics.com', '', 'Paranaque', 'YLP0130', 'YLP0130', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(83, 'Mr. Dong Angelo Bautista', 'DON BANGUS', '(639)9175355655', 'donangelo247@gmail.com', 'Sual Pangasinan', 'Pangasinan', 'DDB0131', 'DDB0131', 'DISTRIBUTOR', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(84, 'Mr. Miles Alfonso', 'Test Customer - Sukiko Pilot', '', 'test@sukiko.com.ph', '', 'Manila', 'TCP0132', 'TCP0132', 'DISTRIBUTOR', NULL, 15, 0, 15, 0, 1, NULL, 0, 0, 75, 0.1, 100, 0.13, 15, 100, 0.13, 100, 0.13, '5', NULL),
	(85, 'Ms. Janice Alfonso', 'Calanca Import Export Co.', '9063692 / 8100725 loc 109', 'janice.cnsalamat@gmail.com', 'Unit 1016 #157 Roxas Boulevard, Baclaran Paranaque City', 'Paranaque', 'CIE0133', 'CIE0133', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(86, 'Mr. Ezekiel Lagman', 'Kairos Cargo Group Incorporated', '(639)9175126808', 'elagman@kairoscargogroup.com', '1255 Quirino  Ave San Dionisio Paranaque', 'Paranaque', 'KCG0135', 'KCG0135', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(87, 'Mr. Marvick Javelona ', 'MTRG General Merchandise', '88201933 / 09178517229', 'mtrg@bmpaglobal.com.ph', '2A Kabihasnan Road Brgy. San Dionisio PParanaque City', 'Paranaque', 'MGM0138', 'MGM0138', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(88, 'Ms. Djoanalle Tan', 'Al Hijaz Global Fruits and Vegetables Trading', '09069094000 / 09352921861', 'alhijazphil@gmail.com', '1658 Sing Along St. Malate, 075 Brgy 687, Manila', 'Manila', 'AGF0140', 'AGF0140', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(89, 'Ms. Maria Concepcion Santos Beltran', '3K Makbonitz Seafoods Trading', '', 'alvaradojovelyn7@gmail.com', 'Blk 21 Lot 37 Phase 2 EP Village, Pinagsama, City of Taguig', 'Taguig', '3MS0142', '3MS0142', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(90, 'Ms. Mary Grace I. Romatico', '101 New York Logisitics Corporation', '(02)85503690', '101nylcorporation@gmail.com', 'Unit 504, CT Alpha Tower, Investment Dr. Madrigal Bus. Park, Ayala Alabang Muntinlupa', 'Alabang', '1NY0143', '1NY0143', 'DISTRIBUTOR', NULL, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(91, 'Mr. Raul Bautista', 'VINA QUALITY CORPORATION', '8730442 / 09175820522', 'sales1.vinaquality@gmail.com , sales.ph@vinaquality.com', '118A Circle Road, Santos Village Zapote, Las Pinas City', 'Las Pinas', 'VQC0144', 'VQC0144', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(92, 'Mr. Danny Calangi / Arjay Catigbak', 'NORTHPOINT INC. (KFC)', '09178464806 / 09178077503', '', 'Lot 1 & 2 Road 2 Sta Maria Industrial Park Compound Bulac Sta Maria Bulacan 3022', 'Bulacan', 'NIK0145', 'NIK0145', 'HORECA', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(93, 'Ms. Luz Hyacinth Almoite', 'A Grace Frozen Food Ventures Inc.', '(639)9190689091', 'charlsscaliwagan123@gmail.com', '104 Almasiga St. Phase 5 D.C Hillside Subd. Davao City', 'Davao', 'AGF0146', 'AGF0146', 'FOOD MANUFACTURER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(94, 'Mr. Alvin C. Chua Jr.', 'ASIA PACIFIC AQUA MARINE INC.', '(639)9178818305', 'apami2015@gmail.com', 'Unit 534, Cityland Pasong Tamo Tower Chino Roces Ave., Makati City', 'Makati', 'APA0147', 'APA0147', 'FOOD MANUFACTURER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(95, 'Mr. Lysander  B. Quinones', 'Mitsui & Co. (Asia Pacific) PTE LTD Manila Branch', '', '', '36th Floor GT Tower International Ayala Avenue, Makati City', 'Makati', 'MCP0148', 'MCP0148', 'DISTRIBUTOR', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(96, 'Mr. Rhonald Faustino', 'AMBER GOLDEN CHAIN OF RESTAURANT CORPORATION', '(02)3724721', 'gina.ludovice@amber.com.ph', '103 Tomas Morato Cor. Scout Limbaga Brgy. Laging Handa Quezon City', 'Quezon', 'AGC0149', 'AGC0149', 'HORECA', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(97, 'Ms. Lani Duran', 'LANI M DURAN FISH TRADING', '(639)9217153761', '', 'Vifel 1 Compound C3 Rd. North Bay Blvd. Nbbs Proper. Navotsd City', 'Navotas', 'LMD0150', 'LMD0150', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(98, 'Ms. Chen Yi', 'HO FENG SUN PEACE INC.', '(639)9053906737', 'hfsunpeace@gmail.com', ' 8-K LEGASPI TOWER 300 ROXAS BLVD. BRGY 719 ZONE 078 MALATE, MANILA CITY ', 'Manila', 'HFS0151', 'HFS0151', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(99, '', 'GKLT CARGO FORWARDING', '', '', '', 'Paranaque', 'GCF0153', 'GCF0153', '', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(100, '', 'DAI HAI MARINE PRODUCTS CORPORATION', '', '', '', 'Masbate', 'DHM0154', 'DHM0154', '', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(102, 'Mr. Mark Jules De Juan', 'GOLDILOCKS BAKESHOP, INC', '(639)9178743124', 'MARK.DEJUAN@goldilocks.com', 'Shaw Blvd. Brgy Addition Hills', 'Mandaluyong', 'GBI0157', 'GBI0157', 'DISTRIBUTOR', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(103, 'Ms. Catherine Posas', 'GLOBAL FRESH PRODUCTS INC.', '(02)83106675', 'dfmanila@dizonfarms.net', 'Lot 91-A Bagsakan Rd FTI Taguig City', 'Taguig', 'GFP0158', 'GFP0158', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(104, 'Ms. Nicole T. Revira', 'CAMIRO CONSUMER GOODS TRADING', '(639)9280884810', 'camiroconsumergoods@gmail.com', '329 Unit 7/A 7/F The Big Orange Bldg. Edsa, Dist. 2, Caloocan City', 'Caloocan', 'CCG0159', 'CCG0159', 'TRADER/IMPORTER', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(105, '', 'GETZ HEALTHCARE PHILIPPINES', '', '', '5F, West Wing, Estancia Offices, Capitol Commons, Orando, Pasig City', 'Pasig', 'GHP0160', 'GHP0160', 'DISTRIBUTOR', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(107, 'Ms. Weng Torno', 'LYDIAS LECHON', '', '', '', 'Paranaque', 'LLL0163', 'LLL0163', 'HORECA', NULL, 0, NULL, NULL, NULL, 1, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(109, 'Mr. Christopher V. Sabilla', 'Nians Trading Inc', '(02)86673277', 'nianstrading@gmail.com', '2407 Rodriguez St., Brgy. 140 Zone 12, Dist. 1 Balut Tondo Manila', 'Manila', 'NES0168', 'NES0168', 'TRADER/IMPORTER', NULL, 2500, 0, 0, 0, 0, NULL, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, '5', NULL),
	(110, 'Ms. Regina Perdiz/ Mr. Christian Velasco', 'Samsung SDS Global SCL Philippines Co. Ltd.', '(632)4781857/(02)8019722/(02)8794374', 'regina.perdiz@samsung.com/C.Velasco@crif.com', 'CRIF D-B Philippines, Inc. 7th Floor, Grepalife Building 221 Sen. Gil Puyat Avenue, Makati City', 'Taguig', 'SCB0170', 'SCB0170', 'DISTRIBUTOR', NULL, 0, 0, 0, 1800, 0, NULL, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(111, 'Mr. Jerome Simagala', 'Southeast Asia Retail Inc', '2414508 /  09360466845', 'kleong@landers.ph', '1890 Paz Guanson St., Otis Paco Manila', 'Quezon', 'SA0171', 'SA0171', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(113, 'Mr. Aga Michael M. Roxas', 'E & L Faster Food Imports Inc.', '(632)6386166', '', '332 Pentecost Street, Saint Gregory Village, San Isidro, Cainta, Rizal', 'Antipolo', 'EAMR0173', 'EAMR0173', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(114, 'Ms.Grace Mercado', 'Integrated Aquaculture Specialists Inc', '(639)9173084634', 'gcm.intaq@yahoo.com', 'P. Remedio St., Banilad Mandaue City 6014', 'Mandaue', 'II0174', 'II0174', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(117, 'Ma. Teresa S. Baldonado', 'Mother and Daughter', '890-4042/895-9729', 'No Customer Email', '5615 Don Pedro Cor. Osias St. Poblacion Makati', 'Makati', 'MMTSB0178', 'MMTSB0178', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2021-12-28 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(118, 'No Customer Person', 'POULTRYMAX OMNIS, INC.', 'No Customer Number', 'No Customer Email', 'No Customer Address', 'No Customer City', 'PNCP0179', 'PNCP0179', 'DISTRIBUTOR', NULL, 0, 0, 0, 0, 0, '2021-12-28 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(119, 'Bernard Paul Reyes', 'DLA Logistics Services', '0915-451-3875', 'bernard.dlalogistics@gmail.com', 'B-1 L-14 Jerusalem St Dela Paz, Antipolo City 1870 ', 'Antipolo', 'DBPR0180', 'DBPR0180', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2021-12-29 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(120, 'No Contact Person', 'ENZED TRADE INC.		', 'No Customer Number', 'No Customer Email', 'No Customer Address', 'No Customer City', 'ENCP0181', 'ENCP0181', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2021-12-29 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(121, 'Malou Cruz', 'Alternatives Food  Corporation', '09175487979', 'No Customer Email', 'Unit 903 One Corporate Center, Doña Julia Vargas Ave. Pasig City', 'Pasig', 'AMC0182', 'AMC0182', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2021-12-29 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(123, 'Mr. Edwin Bernal', 'BE4CH Trading', 'No Customer Number', 'No Customer Email', 'B16 L19 P3 St., Raymond Home Brgy. Calendola San Pedro Laguna ', 'Laguna', 'BEB0184', 'BEB0184', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2021-12-30 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(124, 'unavailable', 'Bernardo Store', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'BU0194', 'BU0194', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-03-08 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(125, 'Richard Pador Usana', '62 Degrees Aqua Seafood Trading', 'Not available', 'Not available', '1977 Pedro Gil St. Brgy. 866 Zone 95 Sta. Ana Manila 1009', 'Manila', '6NA0196', '6NA0196', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-03-08 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(126, 'Simo M. Malca', 'Jewish Association of the Philippines Inc.', 'Not available', 'Not available', '110 HV Dela Costa corner tordesillas west salcedo village Makati City', 'Makati', 'JNA0197', 'JNA0197', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-03-08 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(127, 'Not Available', 'Botoys Litson Manok BBQ Liempo', 'Not Available', 'Not Available', 'Not Available', 'Not Available', 'BNA0200', 'BNA0200', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-03-08 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(128, 'Not Available', 'Ample General Merchandising', 'Not Available', 'Not Available', 'Not Available', 'Not Available', 'ANA0201', 'ANA0201', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-03-08 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(129, 'Jonell Hallare', 'KS LOTTE FOOD TRADE INC', '9354130310', 'kslotte.ph@gmail.com', 'Space C-4 Lot 49-03 kampupot St. Cor Ilang-Ilang, Timog Park, Pampang Angeles', 'Pampanga City', 'KJH0206', 'KJH0206', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-03-16 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(130, 'Kenjie Norbertus G. Del Rosario', 'Rare Global Food Trading', '9178606420', 'kenjie_delrosario@yahoo.com', 'Benson Industrial Cold Storage, Irenaville Subd. Brgy. Bf Homes, Sucat Parañaque City', 'Paranaque', 'RKNGDR0207', 'RKNGDR0207', 'FOOD MANUFACTURER', NULL, 0, 0, 0, 0, 0, '2022-03-16 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(131, 'Mr. Jang In Hyun / Ms. Josephine', 'Asia Dream Paradise Inc.', '7387093 / 0920-8925580', 'adplotte@gmail.com', 'Blk.3 lot 5 Tiongquiao St. BF Martinvile Brgy. Manuyo Dos Las Pinas City', 'Las Pinas', 'AMJIHMJ0208', 'AMJIHMJ0208', 'DISTRIBUTOR', NULL, 0, 0, 0, 0, 0, '2022-03-16 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(132, 'Mr. Richard Kevin Mesina', 'Frabelle Corporation', '9175840652', 'rmesina@jffoods.com.ph', '80 C3 Road, Caloocan City', 'Caloocan', 'FMRKM0211', 'FMRKM0211', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-03-16 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(133, 'Rhan Hwang', 'Marrijang Phil. Corp.', '09150369847', 'marizzang21@gmail.com', '237 Aguirre Avenue, BF Homes, Paranaque City Metro Manila', 'Paranaque', 'MRH0224', 'MRH0224', 'FOOD MANUFACTURER', NULL, 0, 0, 0, 0, 0, '2022-03-19 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(134, 'Mr. Emmanuel A. Baizas', 'Baimeats Agri Trading', '0998-9524507', 'baimeatsagritrading@gmail.com', '2/F Salonga Building Cagayan Valley Rd. Tabang Plaridel Bulacan', ' Bulacan', 'BMEAB0225', 'BMEAB0225', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-03-19 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(135, 'NOT AVAILABLE', 'JMCML', 'NOT AVAILABLE', 'NOT AVAILABLE', 'NOT AVAILABLE', 'NOT AVAILABLE', 'JNA0227', 'JNA0227', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-03-19 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(137, 'Mr. Tirso Ripoll', 'Tabaqueria De Filipinas, Inc.', '868-2788', 'tabako@tabaqueria.com', 'Edificio Belin Magsaysay Road Barangay San Antonio San Pedro Laguna', 'Laguna', 'TMTR0230', 'TMTR0230', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-03-21 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(138, 'Ms. Rina De Leon ', 'SOUTHERN GIANT STAR INTERNATIONAL SEAFOOD PROVIDERS INC., ', '0917-1271388 / 8245263 / 815-4403 local 8137', 'tin.southgiant@gmail.com', 'Lot 1 Blk 19 Aguila St., Gatchalian Subdivision Las Pinas City', 'Las Pinas', 'SMRDL0231', 'SMRDL0231', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-03-21 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(139, 'Ms.Luisa Vega', 'Doubleday Enterprises Inc.', '9082595264', 'sales@ddprimecuts.com', '2000 Penthouse Roxas Blvd. Malate Manila', 'NOT AVAILABLE', 'DMLV0232', 'DMLV0232', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-03-21 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(141, 'Mr. Romel Sotto ', 'Braders International Corp.', 'No customer number', 'No customer Email', '9794 Santan St., Vitalez Compound. Balato, Paranaque City', 'PARAÑAQUE', 'BMRS0234', 'BMRS0234', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-03-22 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(142, 'Emmanuel T. Manalo', 'Elarz Global Inc.', 'NO CONTACT PERSON', 'NO CUSTOMER EMAIL', '4384 B Valdez corner Molina Sts. Poblacion, Makati City', 'MAKATI', 'EETM0235', 'EETM0235', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-03-22 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(143, 'Mr. Raymond Sicat', 'Montessa Food Products', '0916-208-0938', 'raymondsicat@gmail.com', 'San Vicente, Macabebe Pampanga', 'PAMPANGA', 'MMRS0237', 'MMRS0237', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-03-22 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(144, 'NOT AVAILABLE', 'Quickflo Forwarders Inc.', 'NOT AVAILABLE', 'NOT AVAILABLE', 'NOT AVAILABLE', 'NOT AVAILABLE', 'QNA0238', 'QNA0238', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-03-22 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(145, 'NOT AVAILABLE', 'JHCS Marbel', 'NOT AVAILABLE', 'NOT AVAILABLE', 'NOT AVAILABLE', 'NOT AVAILABLE', 'NNA0239', 'NNA0239', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-03-22 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(146, 'SA Jaihyung', 'Hwayo Trading Inc.', '501-4414', 'hwayodavid@gmail.com', '3F 590 Remedios Circle Brgy. 702 Zone 077 Manila, Metro Manila', '-', 'HSJ0240', 'HSJ0240', 'HORECA', NULL, 0, 0, 0, 0, 0, '2022-03-24 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(147, 'NO AVAILABLE DETAILS', 'JARC GROUP', 'NO AVAILABLE DETAILS', 'NO AVAILABLE DETAILS', 'NO AVAILABLE DETAILS', 'NO AVAILABLE DETAILS', 'JNAD0241', 'JNAD0241', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-03-24 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(148, 'Micheal Miranda', 'MICHEAL MIRANDA', '09178342817', 'micheal_miranda@icloud.com', 'UNIT D NO 32 BUENMAR ST SUBDIVISION, SANTOLAN PASIG CITY 1610', 'PASIG CITY', 'MMM0242', 'MMM0242', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-03-25 00:00:00', 0, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(149, 'NOT AVAILABLE', 'TORREMILIANO', 'NOT AVAILABLE', 'NOT AVAILABLE', 'NOT AVAILABLE', 'NOT AVAILABLE', 'TNA0244', 'TNA0244', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-04-02 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(150, 'NOT AVAILABLE', 'JGS', 'NOT AVAILABLE', 'NOT AVAILABLE', 'NOT AVAILABLE', 'NOT AVAILABLE', 'JNA0246', 'JNA0246', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-04-02 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(151, 'NOT AVAILABLE', 'SLS', 'NOT AVAILABLE', 'NOT AVAILABLE', 'NOT AVAILABLE', 'NOT AVAILABLE', 'SNA0247', 'SNA0247', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-04-02 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(152, 'DAISY JANE VENTURINA', 'DAISY JANE VENTURINA', '09178688328', 'DAISYJANE@GMAIL.COM', 'KALIMBAS ST. STA CRUZ MANILA', 'MANILA', 'DDJV0249', '', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-04-06 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(153, 'John Paul L. Aclan', 'Peak Summit Distribution Concepts Corp.', '(02) 8255-9888', 'reynaldo.sapida@aclangroup.com', '3F Asian Star Bldg. Asean Drive, Filinvest Corporate City, Alabang, Muntinlupa City', 'Muntinlupa City', 'PJPLA0251', 'PJPLA0251', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-04-06 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(154, 'Mr. Hanz Christian Miniguez', 'HighTowers Storage & Trading Centre Inc.', 'NOT AVAILBLE', 'NOT AVAILBLE', 'San Antonio 1', 'Parañaque City', 'HMHCM0252', 'HMHCM0252', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-04-06 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(155, 'NOT AVAILABLE', 'GERALD.PH Inc.', 'NOT AVAILABLE', 'NOT AVAILABLE', 'NOT AVAILABLE', 'NOT AVAILABLE', 'GNA0253', 'GNA0253', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-04-07 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(156, 'Rodello Laraya', 'Allens Marine Products Trading', '0919-8647-759', 'rodellolaraya@yahoo.com', '107 Road 4, Pildera 2 Naia Compound', 'Pasay', 'ARL0254', 'ARL0254', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-04-07 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(157, 'Mr. Anton Luigi Khemlani', 'Fine Premium Food Distribution, Inc.', '0917-5352566', 'NOT AVAILABLE', '58-D Matahimik St. Teachers Village West ', 'Quezon', 'FMALK0255', 'FMALK0255', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-04-07 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(158, 'Mr. Raul Bautista', 'Vina Quality Corporation', '873-0442 / 0917-5820-522', 'sales1.vinaquality@gmail.com , sales.ph@vinaquality.com', '118A Circle Road, Santos Village Zapote', ' Las Pinas', 'VMRB0256', 'VMRB0256', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-04-07 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(159, 'Myrna Tan Rioflorido/ Marvick Javelona ', 'MTRG General Merchandise', '88201933 / 09178517229', 'mtrg@bmpaglobal.com.ph', '2A Kabihasnan Road Brgy. San Dionisio', ' Parañaque', 'MMTRMJ0257', 'MMTRMJ0257', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-04-07 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(160, 'Jeverps Manufacturing Corporation', 'Jeverps Manufacturing Corporation', 'NA', 'NA', 'NA', 'NA', '', '', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-04-08 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(161, 'NA', 'JPA OSTEEN CORPORATION', 'NA', 'NA', 'NA', 'NA', '', '', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-04-08 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(162, 'JINA CLEOFE', 'ORLANDO PRESTIGE', 'NA', 'NA', '', 'NA', '', '', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-04-12 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(163, 'Ms. Jong Ong', 'Hong Teng Music Pub Restaurant', 'NOT AVAILABLE', 'NOT AVAILABLE', 'NOT AVAILABLE', 'NOT AVAILABLE', 'HMJO0259', 'HMJO0259', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-04-18 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL),
	(164, 'NIKKI', 'H&N FROZEN MEAT TRADING', 'NA', 'NA', 'NA', 'NA', 'HN0260', 'HN0260', 'TRADER/IMPORTER', NULL, 0, 0, 0, 0, 0, '2022-04-19 00:00:00', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '5', NULL);
/*!40000 ALTER TABLE `tbl_customers` ENABLE KEYS */;

-- Dumping structure for table wms_cloud.tbl_customers_userlegends
CREATE TABLE IF NOT EXISTS `tbl_customers_userlegends` (
  `id` int NOT NULL,
  `type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table wms_cloud.tbl_customers_userlegends: ~5 rows (approximately)
/*!40000 ALTER TABLE `tbl_customers_userlegends` DISABLE KEYS */;
INSERT INTO `tbl_customers_userlegends` (`id`, `type`) VALUES
	(0, 'Superadmin'),
	(1, 'Top Management'),
	(2, 'Planner'),
	(3, 'QA'),
	(4, 'Glacier Inventory');
/*!40000 ALTER TABLE `tbl_customers_userlegends` ENABLE KEYS */;

-- Dumping structure for table wms_cloud.tbl_customers_users
CREATE TABLE IF NOT EXISTS `tbl_customers_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `CommonCode` varchar(50) DEFAULT NULL,
  `CusUsername` varchar(50) DEFAULT NULL,
  `CusPassword` varchar(255) DEFAULT NULL,
  `CusName` varchar(50) DEFAULT NULL,
  `CusEmail` varchar(50) DEFAULT NULL,
  `Contactno` varchar(50) DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  `CusUserStatus` int DEFAULT NULL,
  `Addedby` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table wms_cloud.tbl_customers_users: ~61 rows (approximately)
/*!40000 ALTER TABLE `tbl_customers_users` DISABLE KEYS */;
INSERT INTO `tbl_customers_users` (`id`, `CommonCode`, `CusUsername`, `CusPassword`, `CusName`, `CusEmail`, `Contactno`, `role_id`, `CusUserStatus`, `Addedby`) VALUES
	(1, '', 'admin', '$2y$10$Z5BhOPXlKCBddBhn8Ek2Jekhcu2I.ivnYCAxd4s0jLS7v8kLILD/K', 'Jayar Revis', 'jrevis029@gmail.com', '09052017229', 0, 1, 0),
	(2, 'MTC0023', 'meatplus', '$2y$10$GRXddEuHzHTFAY2Sd6jHI.15s87ZHF.hyCPQC0e8Lu79S4HZxFzn.', 'Fritz Daniel Martinez', 'meatplus@gmail.com', '09178457775  - 09055726819', 1, 1, 1),
	(3, 'AAC0015', 'alson_tp', '$2y$10$d.8ypMXgrf6kp3gfRJP22uA1ej1JnWP/jl26c/e41amLWqHcjDQkm', 'Andrew P Borbon', 'apborbon@saranganibay.com.ph', '029823056/ 029823002', 1, 1, 1),
	(4, 'AAC0015', 'alsonplanner', '$2y$10$5lWUJ1V/YHCIyts9YgCCoOHBuVqrAAWkiNMD/1zgXgSwmW9tXAB1u', 'Alson Planner', 'alsonplanner@gmail.com', '', 2, 1, 3),
	(5, 'MTC0023', 'meatplusplanner', '$2y$10$VGpqzIiIeE4yBlWl.q/J8uOaKjVnjnCbHREW5/6pH1T3gKSlcBMUq', 'Meatplus Planner', 'meatplusplanner@gmail.com', '', 2, 1, 2),
	(7, 'MTC0023', 'jrevis29', '$2y$10$UHgT92HNBnqQJqQKCS8Mnu3VFMP.EdP/cKC2Kk40VUklOh.dMMpDy', 'JAY-AR MARTIN REVIS', 'mjrevis@tip.edu.ph', '09052017229', 3, 1, 5),
	(8, 'NES0168', 'nians_tp', '$2y$10$BLNqAMbNoHBMoeImmReIIOIy6mW038fmZUIZf.ANhb6BHU.FmVCme', 'Edna Seranilla', 'nianstrading@gmail.com', '8667 - 3277', 1, 1, 7),
	(9, 'NES0168', 'nians_p', '$2y$10$Z3ralaXZ3ly5.jQss.fmN.BIxHATpsIiogWId18Hyy0aKlwgiAZq.', 'Nians Planner', 'niansplanner@gmail.com', '123123123', 2, 1, 8),
	(10, 'MPI0013', 'mondelez_tp', '$2y$10$btOPpPVWUKQcsfIvH1c/c.8JxmFmBnexpL1KMNjLKoLRfhF9jEPhu', 'Aaron Joseph A. Lozano', 'Cristina.Maranan@mdlz.com', '09178411791', 1, 1, 7),
	(11, 'MPI0013', 'mondelez_p', '$2y$10$yYwAcAIc0hOswepeCNJx7.qnCl4a0g1MTgwzQk.hMS7hwbAuA7BVa', 'Mondelez Planner', 'mondelezplanner@gmail.com', '123123123', 2, 1, 10),
	(12, 'SCB0170', 'samsung_tp', '$2y$10$plaejBqUEdrOA.BPyVyec.hDu5jjzzjCY9F1f8dS4MP.jIZpsCrXO', 'Chihyun Bae', 'g.porley@samsung.com', '8657 - 1840', 1, 1, 2),
	(13, 'SCB0170', 'samsung_p', '$2y$10$qO70suDLwBm//BFdFxYsN.q67MLeEdQaTEhVs73OY.89Iw35o3XuW', 'Samsung Planner', 'samsungplanner@gmail.com', '123123123', 2, 1, 12),
	(14, 'MPI0013', 'jay_ar', '$2y$10$FKxFruEnIJemzhipAv3.CeqIBZzSAMRRG.L6lzhzalnVJC4z03ZFW', 'Jay-ar', 'jay_ar', '093255625256', 2, 1, 10),
	(15, 'BEB0184', 'bea4ch_tp', '$2y$10$wOMM.nxOSc30LYQ9GDsYLegcbwj89J8pAYgG01o3x/qExJmVw.aYm', 'Mr. Edwin Bernal', 'No Customer Email', 'No Customer Email', 1, 1, 0),
	(16, 'BEB0184', 'bea4ch_p', '$2y$10$.T4LaRCTUcWa00IuQAmrfeM3y6k3Kb/6w7QALeqHM15KoG9rtl13q', 'bea4ch Planner', 'bea4chplanner@gmail.com', '', 2, 1, 15),
	(17, 'JSG0005', 'JSG0005', '$2y$10$VZz6DroXxnvHJOVJqRnTiuBfh.nh9pcN6oIoHHbfuknb4QtIbqasy', 'Mr. Sammy S. Garcia', 'van@jamseafoods.com', 'van@jamseafoods.com', 4, 1, 0),
	(18, 'RRM0007', 'RRM0007', '$2y$10$yqQpQMWux.6UGU1yYTm3oewkP0XgaPw793h/g47sPBpWr4g/SUOG6', 'Mr. Raquel R. Mughal', 'yanmund08@gmail.com', 'yanmund08@gmail.com', 4, 1, 0),
	(19, 'SAS0008', 'SAS0008', '$2y$10$bQXXV9.C.q.aYyUhg5jsh.pvI41wDblsfkBCxRX4mlWPrbsCWbwvS', 'Ms. Anna Marie G. Sy', 'seachamp@seachamp.com.ph', 'seachamp@seachamp.com.ph', 4, 1, 0),
	(20, 'MPI0013', 'MPI0013', '$2y$10$LOqEGQ31X.ZZSSz.oeuso.li09NPG46INZh0G8A7Y81TuC0aqgeEi', 'Mr. Aaron Joseph A. Lozano', 'Cristina.Maranan@mdlz.com', 'Cristina.Maranan@mdlz.com', 4, 1, 0),
	(21, 'GPD0014', 'GPD0014', '$2y$10$C1jSjAlcrvPyaJqkezMNlO4W3eYRdaTsUnyjSLHCgRPnGFpN5B8da', 'Ms. Gracey M. Jose', 'kenneth.angan-angan@globalpacific.com.ph', 'kenneth.angan-angan@globalpacific.com.ph', 4, 1, 0),
	(22, 'AAC0015', 'AAC0015', '$2y$10$zIWtGFEHoffjc0hAhWHK/e/wto/IzGsaJe0cOLuW/SE4/aIgn43xi', 'Mr. Andrew P. Borbon', 'apborbon@saranganibay.com.ph', 'apborbon@saranganibay.com.ph', 4, 1, 0),
	(23, 'IFC0039', 'IFC0039', '$2y$10$ULAnSATaX4ggProGVoakzejsludzk3HBu0FVI3djwocIOJXrOIHSW', 'Ms. Leah B. Garceron', 'neil.delrosario@rrgroup.com.ph', 'neil.delrosario@rrgroup.com.ph', 4, 1, 0),
	(24, 'DJJ0040', 'DJJ0040', '$2y$10$C.tPvkhAe0eKjcjUFmKmMO3.8wsIdPEYSsVUwn8Y40UGVv0WvwpHi', 'Mr. Ralph Francis Dela Cruz / Bryan Kenneth', 'angdeux@naver.com', 'angdeux@naver.com', 4, 1, 0),
	(25, 'AIL0083', 'AIL0083', '$2y$10$2uu8Pogq6FxKYM2oHuHt3eaSq3vYpQ9AADDp1ax/u2XxVPAfFFQri', 'Mr. Maurito Bongbong Lateo', 'domluansing.auszeal@gmail.com', 'domluansing.auszeal@gmail.com', 4, 1, 0),
	(26, 'SKE0101', 'SKE0101', '$2y$10$4KlSRodpS6C61hm1LvmYduZn03kSfYWWHCs8Br8fXvPX4VA.j519G', 'Ms. Audrey E.M.Yee', 'kyc.main@gmail.com', 'kyc.main@gmail.com', 4, 1, 0),
	(27, 'CDF0119', 'CDF0119', '$2y$10$ISfGOQQcGhKC6a3GYr7Ib.urTbbpXZe4MvrQO2jTwCNv53PlAw1/a', 'Mr. James Edward Ko', 'jamesko_03@yahoo.com', 'jamesko_03@yahoo.com', 4, 1, 0),
	(28, 'ICC0123', 'ICC0123', '$2y$10$OTmVHxUASu3t0NF.im5JBOPD6Gt5tObplw/RwxK1tjMqMD8eLq/qe', 'Ms. Imelda R. Banaag', 'ibxcargo@gmail.com', 'ibxcargo@gmail.com', 4, 1, 0),
	(29, 'YLP0130', 'YLP0130', '$2y$10$MB6jxV0k0H23lLlUpn9AEOR6cO1w2f5ovgi.cs4DNUuiFdgp8y3QG', 'Ms. Christine Reyes', 'christine.reyes@ph.yusen-logistics.com', 'christine.reyes@ph.yusen-logistics.com', 4, 1, 0),
	(30, 'CIE0133', 'calanca_tp', '$2y$10$wnMdO9cPOvbM04UTXH.Z0euDsWLuCA/4iTDoyA9AciUyg1pbsFG1e', 'Ms. Janice Alfonso', 'janice.cnsalamat@gmail.com', 'janice.cnsalamat@gmail.com', 1, 1, 0),
	(31, '1NY0143', '1NY0143', '$2y$10$Y85m2sVqdgy1YVaKqrAwO.V2NmAG6g6BzwHyhZUrQjVmHRmNv3AbS', 'Ms. Mary Grace I. Romatico', '101nylcorporation@gmail.com', '101nylcorporation@gmail.com', 4, 1, 0),
	(32, 'NES0168', 'NES0168', '$2y$10$CHuWco3ccPytmnAfsxMux.aXS2Y3mpxLU1UHhk6dJkaCu3gNCKxE.', 'Mr. Christopher V. Sabilla', 'nianstrading@gmail.com', 'nianstrading@gmail.com', 4, 1, 0),
	(33, 'SCB0170', 'SCB0170', '$2y$10$7OhRB3O3KO2q6uh6SGD.tOB1NuHPbg5iQ/pK/VuYuCslGlRRPAAuS', 'Ms. Regina Perdiz/ Mr. Christian Velasco', 'regina.perdiz@samsung.com/C.Velasco@crif.com', 'regina.perdiz@samsung.com/C.Velasco@crif.com', 4, 1, 0),
	(34, 'SA0171', 'SA0171', '$2y$10$xofbhn4C.EUyaBkGUGZAc.hLwLwhJ6zS9ssjeRqtPWUi/LMYMBTLW', 'Mr. Jerome Simagala', 'kleong@landers.ph', 'kleong@landers.ph', 4, 1, 0),
	(35, 'EAMR0173', 'EAMR0173', '$2y$10$vxFq9ENX9fzP.A/f7.yt1userI0fUjGZ9/vMWGxqW3AgywZtXynJK', 'Mr. Aga Michael M. Roxas', '', '', 4, 1, 0),
	(36, 'II0174', 'II0174', '$2y$10$avN093eAByRshEbBsKM7WesGgBvh6tDFq.6FyDTLOqIMbzDKtaZAG', 'Ms.Grace Mercado', 'gcm.intaq@yahoo.com', 'gcm.intaq@yahoo.com', 4, 1, 0),
	(37, 'MMTSB0178', 'MMTSB0178', '$2y$10$qzeR5OjVePixuRPq4Ahf3.C/GWRIZTTrj5Ue1swrVL1tnD5vwTSl2', 'Ma. Teresa S. Baldonado', 'No Customer Email', 'No Customer Email', 4, 1, 0),
	(38, 'PNCP0179', 'PNCP0179', '$2y$10$hNiKL3iIAsnJqv40B8R9ieQPt/fklEmaQa1PZkvMtEWCj/UXCP/2e', 'No Customer Person', 'No Customer Email', 'No Customer Email', 4, 1, 0),
	(39, 'DBPR0180', 'DBPR0180', '$2y$10$IjUqu/cdgrAz4tJa1pZPmO55efBiv2bL1EK5.jZN4k/XvLIMmk8uS', 'Bernard Paul Reyes', 'bernard.dlalogistics@gmail.com', 'bernard.dlalogistics@gmail.com', 4, 1, 0),
	(40, 'ENCP0181', 'ENCP0181', '$2y$10$/a4wHlRB1nssFX5QCkc1deiDgS9RMjhKHKE8wur.oF/BNRU/NpKOe', 'No Contact Person', 'No Customer Email', 'No Customer Email', 4, 1, 0),
	(41, 'AMC0182', 'AMC0182', '$2y$10$QnmfVEmBn3NPRaRy.F0mG.3XD8558V6rji1M/FnTfLTQ6gwGW1NLe', 'Malou Cruz', 'No Customer Email', 'No Customer Email', 4, 1, 0),
	(42, 'BEB0184', 'BEB0184', '$2y$10$86vCggGgbPGn7dGsOOiGOO3DgdGdMjbOyC0sC6d0bCPghjhsufp0G', 'Mr. Edwin Bernal', 'No Customer Email', 'No Customer Email', 4, 1, 0),
	(43, 'BU0194', 'BU0194', '$2y$10$Gflcck/YazihkQDzHt/55.rWbbttw4AxQlh99cc6zZV2Fvja28jkq', 'unavailable', 'unavailable', 'unavailable', 4, 1, 0),
	(44, '6NA0196', '6NA0196', '$2y$10$K9j1NOvO6dkX6XXLamQ//uz6vMWZIWUFLRi9etSlwvdlM6Kp6mPKC', 'Richard Pador Usana', 'Not available', 'Not available', 4, 1, 0),
	(45, 'JNA0197', 'JNA0197', '$2y$10$.JA5NvsITOsaD/tnmvC/2e277uZv7dEhlB41Tbon3.9ZBIw/U3XB6', 'Simo M. Malca', 'Not available', 'Not available', 4, 1, 0),
	(46, 'BNA0200', 'BNA0200', '$2y$10$MLGctgFqtUhMu2w8ZD/cp.0.m.pZJsyra6703KAmBFF4zAWWEpQre', 'Not Available', 'Not Available', 'Not Available', 4, 1, 0),
	(47, 'ANA0201', 'ANA0201', '$2y$10$XvdbfhyXB8jcMiB9l2IxPeMlfWU99EwMqbb/TXRDabLUh7o8lzjnO', 'Not Available', 'Not Available', 'Not Available', 4, 1, 0),
	(48, 'KJH0206', 'KJH0206', '$2y$10$05IFDuZYeKRDeNxjWrKzZuK/D606qFQ/MT1ro/gItRs49Ycwr3qDm', 'Jonell Hallare', 'kslotte.ph@gmail.com', 'kslotte.ph@gmail.com', 4, 1, 0),
	(49, 'RKNGDR0207', 'RKNGDR0207', '$2y$10$WCj6xgaB4tproFcXj5peTON6kx8L572oZ852TupvxYqoIaxBR9dG.', 'Kenjie Norbertus G. Del Rosario', 'kenjie_delrosario@yahoo.com', 'kenjie_delrosario@yahoo.com', 4, 1, 0),
	(50, 'AMJIHMJ0208', 'AMJIHMJ0208', '$2y$10$RJTzJYzWvtCfw5WZxjetf.oCx4nmXOLRfbsnVZOeUOJttoBfDZjj6', 'Mr. Jang In Hyun / Ms. Josephine', 'adplotte@gmail.com', 'adplotte@gmail.com', 4, 1, 0),
	(51, 'FMRKM0211', 'FMRKM0211', '$2y$10$XuQyEdV69smsfVahKQFNgOl/daS2h/vaOptOBYT1lbtbHNEkfMuHe', 'Mr. Richard Kevin Mesina', 'rmesina@jffoods.com.ph', 'rmesina@jffoods.com.ph', 4, 1, 0),
	(52, 'MRH0224', 'MRH0224', '$2y$10$TQ4AA5JBNarBrybIj0uCJ.Vt2v1WqJvos6Vf/THfcCJuneu5nQiRu', 'Rhan Hwang', 'marizzang21@gmail.com', 'marizzang21@gmail.com', 4, 1, 0),
	(53, 'BMEAB0225', 'BMEAB0225', '$2y$10$zpA5dKmeFQNLi95t7S2TBeOTKSKwYJ0eCU5oVTQAKBd1pwPKCOqSy', 'Mr. Emmanuel A. Baizas', 'baimeatsagritrading@gmail.com', 'baimeatsagritrading@gmail.com', 4, 1, 0),
	(54, 'JNA0227', 'JNA0227', '$2y$10$VpaT39F08iImErvl3SxFV.LXOULHN7y261L03cevFHS6zaOTqUf0O', 'NOT AVAILABLE', 'NOT AVAILABLE', 'NOT AVAILABLE', 4, 1, 0),
	(55, 'TMTR0230', 'TMTR0230', '$2y$10$bO3jQmHHd3WjKo2rXAorxeRSQgYCpKTIVLfcH7EgQ9isUu460DXRm', 'Mr. Tirso Ripoll', 'tabako@tabaqueria.com', 'tabako@tabaqueria.com', 4, 1, 0),
	(56, 'SMRDL0231', 'SMRDL0231', '$2y$10$o2QgakYVD0k337LE2wp1AON/T/50CZlfWR00XlcX0EtvYMlzbeHRW', 'Ms. Rina De Leon ', 'tin.southgiant@gmail.com', 'tin.southgiant@gmail.com', 4, 1, 0),
	(57, 'DMLV0232', 'DMLV0232', '$2y$10$t6M6JKkRuKF/qbcw4QvOKe7Gpd9Y4txS5XVX/drONqW.eQLTB5MSy', 'Ms.Luisa Vega', 'sales@ddprimecuts.com', 'sales@ddprimecuts.com', 4, 1, 0),
	(58, 'BMRS0234', 'BMRS0234', '$2y$10$EpUlH7dA9fWyNr1oiXmZbe75jNu8hXtry4QHBrnk2amymB2UBSVF2', 'Mr. Romel Sotto ', 'No customer Email', 'No customer Email', 4, 1, 0),
	(59, 'EETM0235', 'EETM0235', '$2y$10$A8zCv6aBe6waA4CKI0erD.udQBkAbzyFD2ZjD1aJ/eO7ZxpFV8jMC', 'Emmanuel T. Manalo', 'NO CUSTOMER EMAIL', 'NO CUSTOMER EMAIL', 4, 1, 0),
	(60, 'MMRS0237', 'MMRS0237', '$2y$10$48iEnZyqZxHhtfHbl/18Y.NwcpJPiLh1EDaCA8F38DGUTrs7AWbDK', 'Mr. Raymond Sicat', 'raymondsicat@gmail.com', 'raymondsicat@gmail.com', 4, 1, 0),
	(61, 'QNA0238', 'QNA0238', '$2y$10$vKoe.2yWlWv6ztsefHX8wumhG72uvLSFbxyJjIJzoxlGI3EUj1iLq', 'NOT AVAILABLE', 'NOT AVAILABLE', 'NOT AVAILABLE', 4, 1, 0),
	(62, 'NNA0239', 'NNA0239', '$2y$10$UiH7a7Q3KB61KdIZAPWZ1eq6ylfYUWIoMK1TeKpNrDjsGq4tzcOWm', 'NOT AVAILABLE', 'NOT AVAILABLE', 'NOT AVAILABLE', 4, 1, 0);
/*!40000 ALTER TABLE `tbl_customers_users` ENABLE KEYS */;

-- Dumping structure for table wms_cloud.tbl_defaultchargingtypeid
CREATE TABLE IF NOT EXISTS `tbl_defaultchargingtypeid` (
  `id` int NOT NULL AUTO_INCREMENT,
  `val` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_cloud.tbl_defaultchargingtypeid: ~3 rows (approximately)
/*!40000 ALTER TABLE `tbl_defaultchargingtypeid` DISABLE KEYS */;
INSERT INTO `tbl_defaultchargingtypeid` (`id`, `val`) VALUES
	(1, 'By Pallet'),
	(2, 'By Weight'),
	(3, 'By Rent');
/*!40000 ALTER TABLE `tbl_defaultchargingtypeid` ENABLE KEYS */;

-- Dumping structure for table wms_cloud.tbl_handlingchargetypeid
CREATE TABLE IF NOT EXISTS `tbl_handlingchargetypeid` (
  `id` int NOT NULL AUTO_INCREMENT,
  `val` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_cloud.tbl_handlingchargetypeid: ~2 rows (approximately)
/*!40000 ALTER TABLE `tbl_handlingchargetypeid` DISABLE KEYS */;
INSERT INTO `tbl_handlingchargetypeid` (`id`, `val`) VALUES
	(1, 'By Pallet'),
	(2, 'By Weight');
/*!40000 ALTER TABLE `tbl_handlingchargetypeid` ENABLE KEYS */;

-- Dumping structure for table wms_cloud.tbl_items
CREATE TABLE IF NOT EXISTS `tbl_items` (
  `ItemID` int unsigned NOT NULL AUTO_INCREMENT,
  `ItemCode` varchar(191) DEFAULT NULL,
  `Client_SKU` varchar(191) DEFAULT NULL,
  `ItemDesc` varchar(191) DEFAULT NULL,
  `ItemCustomerID` int DEFAULT NULL,
  `MaterialType` varchar(191) DEFAULT NULL,
  `Category` varchar(191) DEFAULT NULL,
  `MinTemp` varchar(191) DEFAULT NULL,
  `MaxTemp` varchar(45) DEFAULT NULL,
  `Length` double DEFAULT NULL,
  `Width` double DEFAULT NULL,
  `Height` double DEFAULT NULL,
  `Weight` double DEFAULT NULL,
  `PiecesPerCase` int DEFAULT NULL,
  `CasesPerPallet` int DEFAULT NULL,
  `UOMID` int DEFAULT NULL,
  `RepQTY` int DEFAULT NULL,
  `ParentCode` varchar(45) DEFAULT NULL,
  `SubCat` int DEFAULT NULL,
  `ShelfLife` int DEFAULT NULL,
  `Price` double DEFAULT NULL,
  `Status` varchar(45) DEFAULT NULL,
  `ItemClass` varchar(45) DEFAULT NULL,
  `PriceClass` varchar(45) DEFAULT NULL,
  `MinQty` int NOT NULL DEFAULT '0',
  `MaxQty` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ItemID`),
  KEY `tbl_items_idx_status_itemid` (`Status`,`ItemID`)
) ENGINE=InnoDB AUTO_INCREMENT=4018 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_cloud.tbl_items: ~3,495 rows (approximately)
/*!40000 ALTER TABLE `tbl_items` DISABLE KEYS */;
INSERT INTO `tbl_items` (`ItemID`, `ItemCode`, `Client_SKU`, `ItemDesc`, `ItemCustomerID`, `MaterialType`, `Category`, `MinTemp`, `MaxTemp`, `Length`, `Width`, `Height`, `Weight`, `PiecesPerCase`, `CasesPerPallet`, `UOMID`, `RepQTY`, `ParentCode`, `SubCat`, `ShelfLife`, `Price`, `Status`, `ItemClass`, `PriceClass`, `MinQty`, `MaxQty`) VALUES
	(71, 'AA015FF0001', '837', '(837) FRESH FROZEN DEBONED UNSEASONED XL (FFD - LOCAL 500-600)', 18, '2', '1', '-18', '', 1, 1, 1, 7, 13, 50, 3, 1, NULL, 3, 0, 0, 'Active', 'null', 'null', 0, 0),
	(72, 'AA015FF0002', '824', '(824) FRESH FROZEN DEBONED UNSEASONED L (FFD - LOCAL L(401-500))', 18, '2', '1', '-18', '', 1, 1, 1, 7, 18, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(73, 'AA015FF0003', '823', '(823) FRESH FROZEN DEBONED UNSEASONED M (FFD - LOCAL M(301-400))', 18, '2', '1', '-18', '', 1, 1, 1, 5, 20, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(74, 'AA015FF0004', '822', '(822) FRESH FROZEN DEBONED UNSEASONED S (FFD - LOCAL S(200-300))', 18, '2', '1', '-18', '', 1, 1, 1, 6, 15, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(75, 'AA015FF0005', '2376', '(2376) FRESH FROZEN DEBONED BELLY (BLY - LOCAL 400-450)', 18, '2', '1', '-18', '', 1, 1, 1, 8, 20, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(76, 'AA015FM0006', '616', '(616) MILKFISH FILLET (RETAIL) (MF - LOCAL 450-550)', 18, '2', '1', '-18', '', 1, 1, 1, 10, 1, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(77, 'AA015FF0007', '1854', '(1854) FRESH FROZEN DEBONED UNSEASONED - INSTI  (FFDI - LOCAL 300-350)', 18, '2', '1', '-18', '', 1, 1, 1, 13, 42, 25, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(78, 'AA015FF0008', '844', '(844) FRESH FROZEN DEBONED MARINATED XL (FFDM - LOCAL 56)', 18, '2', '1', '-18', '', 1, 1, 1, 7, 13, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(79, 'AA015FF0009', '825', '(825) FRESH FROZEN DEBONED MARINATED L (FFDM - LOCAL L(401-500))', 18, '2', '1', '-18', '', 1, 1, 1, 7, 18, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(80, 'AA015FF0010', '826', '(826) FRESH FROZEN DEBONED MARINATED M (FFDM - LOCAL M(301-400))', 18, '2', '1', '-18', '', 1, 1, 1, 5, 20, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(81, 'AA015FF0011', '827', '(827) FRESH FROZEN DEBONED MARINATED S (FFDM - LOCAL S(200-300))', 18, '2', '1', '-18', '', 1, 1, 1, 6, 15, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(82, 'AA015FF0012', '1807', '(1807) FRESH FROZEN DEBONED MARINATED - INSTI (FFDMI - LOCAL NEW(280-330))', 18, '2', '1', '-18', '', 1, 1, 1, 13, 45, 25, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(83, 'AA015FF0013', '2934', '(2934) FRESH FROZEN DEBONED MARINATED - INSTI (FFDMI - LOCAL 280-330)', 18, '2', '1', '-18', '', 1, 1, 1, 14, 45, 25, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(84, 'AA015FB0014', '840', '(840) BABY SPLIT MARINATED (BSM - LOCAL 400-450)', 18, '2', '1', '-18', '', 1, 1, 1, 8, 17, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(85, 'AA015FB0015', '741', '(741) BABY SPLIT MARINATED - SPICY (BSMS - LOCAL 400-450)', 18, '2', '1', '-18', '', 1, 1, 1, 7, 17, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(86, 'AA015FM0016', '887', '(887) MARINATED TOCINO (TOC-1 - LOCAL 454)', 18, '2', '1', '-18', '', 1, 1, 1, 9, 20, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(87, 'AA015FS0017', '831', '(831) SMOKED DEBONED L (SD - LOCAL L(401-500))', 18, '2', '1', '-18', '', 1, 1, 1, 7, 19, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(88, 'AA015FS0018', '830', '(830) SMOKED DEBONED M (SD - LOCAL M(301-400))', 18, '2', '1', '-18', '', 1, 1, 1, 6, 22, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(89, 'AA015FS0019', '829', '(829) SMOKED DEBONED S (SD - LOCAL S(200-300))', 18, '2', '1', '-18', '', 1, 1, 1, 7, 18, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(90, 'AA015FS0020', '838', '(838) SMOKED DEBONED XL (SD - LOCAL 500-600)', 18, '2', '1', '-18', '', 1, 1, 1, 8, 15, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(91, 'AA015FS0021', '915', '(915) SMOKE DEBONED BABY (SDB - LOCAL 400-550)', 18, '2', '1', '-18', '', 1, 1, 1, 7, 15, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(92, 'AA015FS0022', '2940', '(2940) SMOKED DEBONED INSTI (SDINSTI - LOCAL 270-320)', 18, '2', '1', '-18', '', 1, 1, 1, 14, 45, 25, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(93, 'AA015FB0023', '1711', '(1711) BAKED RELLENO (BRL - LOC. NEW(500-600))', 18, '2', '1', '-18', '', 1, 1, 1, 11, 24, 25, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(94, 'AA015FE0024', '2333', '(2333) EMBUTIDO (FEM - LOCAL 250G)', 18, '2', '1', '-18', '', 1, 1, 1, 6, 26, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(95, 'AA015FS0025', '950', '(950) SMOKED GROUND MILKFISH (SGM - LOCAL 250)', 18, '2', '1', '-18', '', 1, 1, 1, 15, 1, 25, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(96, 'AA015FS0026', '1020', '(1020) SEABASS (SEABASS - LOCAL 500-600)', 18, '2', '1', '-18', '', 1, 1, 1, 8, 14, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(97, 'AA015FP0027', '2600', '(2600) POMPANO (POM-IM2 - LOCAL 500-600)', 18, '2', '1', '-18', '', 1, 1, 1, 7, 14, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(98, 'AA015FS0028', '1534', '(1534) SARANGANI BAY PANGASIUS FILLET (SBPF (PA) - LOCAL 170-220)', 18, '2', '1', '-18', '', 1, 1, 1, 15, 30, 25, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(99, 'AA015FP0029', '2423', '(2423) PANGASIUS FILLET GRADE C - ROBINSONS (PFC-R - LOCAL 170-220)', 18, '2', '1', '-18', '', 1, 1, 1, 10, 10, 54, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(100, 'AA015FP0030', '2076', '(2076) PANGASIUS FILLET GRADE C - LARGE (PFC(L)-30 - LOCAL 220-260)', 18, '2', '1', '-18', '', 1, 1, 1, 10, 10, 56, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(101, 'AA015FS0031', '2805', '(2805) SARANGANI BAY RAW, PEELED AND DEVEINED (SBRPD 21/25 21/25)', 18, '2', '1', '-18', '', 1, 1, 1, 10, 10, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(102, 'AA015FR0032', '2915', '(2915) RAW, PEELED AND DEVEINED (RPD 91/110 91/110)', 18, '2', '1', '-18', '-25', 1, 1, 1, 10, 10, 50, 3, 1, NULL, 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(103, 'AA015FC0033', '1520', '(1520) COOKED, PEELED AND DEVEINED (CPD 91/110 91/110)', 18, '2', '1', '-18', '', 1, 1, 1, 10, 20, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(104, 'AA015FB0034', '2967', '(2967) BLACK HOSO TIGER SHRIMP (BLT - HOSO 16/20)', 18, '2', '1', '-18', '', 1, 1, 1, 10, 10, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(105, 'AA015FB0035', '2968', '(2968) BLACK HOSO TIGER SHRIMP (BLT - HOSO 21/25)', 18, '2', '1', '-18', '', 1, 1, 1, 10, 10, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(106, 'AA015FS0036', '2380', '( 2380) SALMON BELLY RETAIL (S-BELLY-R - LOCAL 450-550)', 18, '2', '1', '-18', '', 1, 1, 1, 20, 40, 25, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(107, 'AA015FS0037', '2598', '( 2598) SQUID RING (SQR - LOCAL 3-5CM(500G))', 18, '2', '1', '-18', '', 1, 1, 1, 10, 1, 35, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(108, 'AA015FS0038', '2597', '(2597) SQUID RING (SQR - LOCAL 3-5CM(1KG))', 18, '2', '1', '-18', '', 1, 1, 1, 10, 1, 35, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(109, 'AA015FA0039', '2969', '(2969) ALASKAN POLLOCK FILLET (APO-FILLET-R-LOCAL 170-227g / pc)', 18, '2', '1', '-18', '', 1, 1, 1, 8, 8, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(110, 'AA015FP0042', '2806', '(2806) PANGASIUS FILLET GRADE C - LARGE (PFC(L)-40 - LOCAL 220-260)', 18, '2', '1', '-18', '', 1, 1, 1, 10, 10, 49, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(111, 'AA015FP0043', '2369', '(2369) PANGASIUS FILLET GRADE C - LARGE (PFC(L)-30 - LOCAL 220-260)', 18, '2', '1', '-18', '', 1, 1, 1, 10, 10, 54, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(112, 'AA015FC0044', '1520BB', '(1520BB) COOKED, PEELED AND DEVEINED (CPD 91/110 91/110)', 18, '2', '1', '-18', '', 1, 1, 1, 0.5, 20, 1, 4, 1, 'AA015FC0033', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(114, 'AA015FR0047', '2915BB', '(2915BB) RAW, PEELED AND DEVEINED (RPD 91/110 91/110)', 18, '2', '1', '-18', '-25', 1, 1, 1, 1, 10, 1, 4, 1, 'AA015FR0032', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(115, 'AA015FF0048', '826BB', '(826BB) FRESH FROZEN DEBONED MARINATED M (FFDM - LOCAL M(301-400))', 18, '2', '1', '-18', '', 1, 1, 1, 0.32, 20, 1, 4, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(116, 'AA015FP0049', '1743', '(1743) PANGASIUS FILLET GRADE C - LARGE (PFC(L)-30 - LOCAL 220-260)', 18, '2', '1', '-18', '', 1, 1, 1, 10, 10, 49, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(117, 'AA015FD0041', '2971', '(2971) DORY KABAYAKI X 14.4KG', 18, '2', '1', '-18', '', 1, 1, 1, 14.4, 90, 30, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(118, 'AA015FV0040', '1245', '(1245) VANNAMEI - XL - MC2', 18, '2', '1', '-18', '', 1, 1, 1, 3, 6, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(119, 'AA015FC0045', 'TEMPO3', '(TEMPO3BB) CPD 21/25', 18, '2', '1', '-18', '', 1, 1, 1, 1, 10, 1, 4, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(120, 'AA015FD0051', '2971BB', '(2971BB) DORY KABAYAKI X 14.4KG', 18, '2', '1', '-18', '', 1, 1, 1, 14, 90, 30, 4, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(121, 'AA015FR0050', '2712', '(2712) RAW, PEELED AND DEVEINED (RPD 51/60 51/60)', 18, '2', '1', '-18', '', 1, 1, 1, 10, 10, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(122, 'AA015FF0052', '590', '( 590 ) FRESH FROZEN TILAPIA', 18, '2', '1', '-18', '', 1, 1, 1, 8, 15, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(123, 'AA015FS0053', 'LTC-0000002', '(LTC-0000002) SALMON HEADS / COPALIS ', 18, '2', '1', '-18', '', 1, 1, 1, 12.5, 1, 60, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(124, 'AA015FS0054', 'LTC-0000002\'\'', '(LTC-0000002\'\') SALMON HEADS / COPALIS ', 18, '2', '1', '-18', '', 1, 1, 1, 20, 1, 80, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(125, 'AA015FF0055', 'LTC-0000003', '(LTC-0000003) FROZEN SALMON BELLY FLAPS', 18, '2', '1', '-18', '', 1, 1, 1, 12, 1, 65, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(126, 'AA015FP0058', '(DA0001)', '(DA0001) POMPANO 500-600g 80% NW', 18, '2', '1', '-18', '', 1, 1, 1, 10, 20, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(127, 'AA015FB0059', '2967BB', '(2967BB) BLACK HOSO TIGER SHRIMP (BLT - HOSO 16/20)', 18, '2', '1', '-18', '', 1, 1, 1, 1, 10, 1, 4, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(128, 'AA015FB0060', '2968BB', '(2968BB) BLACK HOSO TIGER SHRIMP (BLT - HOSO 21/25)', 18, '2', '1', '-18', '', 1, 1, 1, 1, 10, 1, 4, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(129, 'AA015FP0005', '308', '(308) POMPANO IM-68-MC14', 18, '2', '1', '-18', '', 1, 1, 1, 10, 20, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(130, 'AA015FF0062', 'LTC-0000005', '(LTC-0000005) FROZEN CO TUNA PORTION ', 18, '2', '1', '-18', '', 1, 1, 1, 10, 20, 40, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(131, 'AA015FF0063', 'LTC-0000005\'', '(LTC-0000005\') FROZEN CO YELLOWPIN TUNA BELLY - RED STRAP', 18, '2', '1', '-18', '', 1, 1, 1, 10, 25, 49, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(132, 'AA015FF0064', 'LTC-0000005\'\'', '(LTC-0000005\'\') FROZEN CO YELLOWPIN TUNA LOIN', 18, '2', '1', '-18', '', 1, 1, 1, 20, 10, 25, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(133, 'AA015FF0065', 'LTC-0000005\'\'\'', '(LTC-0000005\'\'\')FROZEN YELLOWPIN TUNA BELLY - WHITE STRAP ', 18, '2', '1', '-18', '', 1, 1, 1, 10, 25, 49, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(134, 'AA015FF0066', 'LTC-0000005\'\'\'\'', '(LTC-0000005\'\'\'\') FROZEN YELLOWFIN TUNA KAMA', 18, '2', '1', '-18', '', 1, 1, 1, 10, 25, 42, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(135, 'AA015FF0070', 'LTC-0000001', '(LTC-0000001) FROZEN PANGASIUS FILLET', 18, '2', '1', '-18', '', 1, 1, 1, 10, 10, 56, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(136, 'AA015FF0071', '823BB', '(823BB) FRESH FROZEN DEBONED UNSEASONED M (FFD - LOCAL M(301-400))', 18, '2', '1', '-18', '', 1, 1, 1, 5.75, 20, 50, 4, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(137, 'AA015S0067', 'TEMPO 7', '(TEMPO 7) SARISARANGANI - MCI', 18, '2', '1', '-18', '', 1, 1, 1, 10, 20, 8, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(138, 'AA015FB0068', 'TEMPO 8', '(TEMPO 8) BALL DOMINGUEZ - MC2', 18, '2', '1', '-18', '', 1, 1, 1, 10, 20, 1, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(139, 'AA015FS0069', 'TEMPO 9', '(TEMPO 9) SAMPLE SEABASS - MC2', 18, '2', '1', '-18', '', 1, 1, 1, 10, 20, 2, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(140, 'AA015FP0072', '2806BB', '(2806BB) PANGASIUS FILLET GRADE C - LARGE (PFC(L)-40 - LOCAL 220-260)', 18, '2', '1', '-18', '', 1, 1, 1, 1, 10, 1, 4, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(141, 'AA015FF0073', 'LTC-0000007', '(LTC-0000007) FROZEN PD VANNAMEI SHRIMP, IQF 91/110', 18, '2', '1', '-18', '', 1, 1, 1, 10, 10, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(142, 'AA015FF0074', 'LTC-0000007\'', '(LTC-0000007\') FROZEN PD VANNAMEI SHRIMP, IQF 71/90', 18, '2', '1', '-18', '', 1, 1, 1, 10, 10, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(143, 'AA015FF0075', 'LTC-0000007\'\'', '(LTC-0000007\'\') FROZEN PD VANNAMEI SHRIMP, IQF 41/50', 18, '2', '1', '-18', '', 1, 1, 1, 10, 10, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(144, 'AA015FF0076', 'LTC-0000007\'\'\'', '(LTC-0000007\'\'\') FROZEN PD VANNAMEI SHRIMP, IQF 31/40', 18, '2', '1', '-18', '', 1, 1, 1, 10, 10, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(145, 'AA015FF0077', 'LTC-0000008', '(LTC-0000006) FROZEN PANGASIUS FILLET - YELLOW STRAP ', 18, '2', '1', '-18', '', 1, 1, 1, 10, 10, 54, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(146, 'AA015FF0079', '70', '(70) FRESH FROZEN DEBONED MILKFISH INSTITUTIONAL (300-400)', 18, '2', '1', '-18', '', 1, 1, 1, 9, 25, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(147, 'AA015FS0078', '2053', '(2053) SALMON BELLY FLAPS (S-BELLY (SB) -1-3)', 18, '2', '1', '-18', '', 1, 1, 1, 10, 1, 56, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(148, 'AA015FP0080', 'DA 0001\'', '(DA 0001\') POMPANO 500-600g 90% NW', 18, '2', '1', '-18', '', 1, 1, 1, 10, 20, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(149, 'AA015FP0081', 'DA 0001\'\'', '(DA 0001\'\') POMPANO 400-500g 80% NW', 18, '2', '1', '-18', '', 1, 1, 1, 10, 20, 50, 3, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(150, 'AA015C0082', 'CB', '(CB) CORRUGATED BOX', 18, '2', '1', '18', '', 1, 1, 1, 1, 10, 24, 25, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(151, 'AA015FD0084', '5000BB', '(5000BB) DORY KABAYAKI ', 18, '2', '1', '-18', '', 1, 1, 1, 1, 10, 1, 4, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(152, 'AA015FD0083', '5000', '(5000) DORY KABAYAKI ', 18, '2', '1', '-18', '', 1, 1, 1, 10, 30, 58, 8, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(153, 'AA015FF0085', '1675', '(1675) FFV-HOSO (J-41-UP) MC1 ', 18, '2', '1', '-18', '', 1, 1, 1, 10, 10, 30, 8, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(154, 'AA015FS0086', '2337', '(2337) S-BELLY (BP)', 18, '2', '1', '-18', '', 1, 1, 1, 10, 1, 25, 8, 1, NULL, 3, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(162, 'MT023AB0001', 'BF-029-DAW', 'BEEF BONE IN SHANK - DAWNMEAT', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(163, 'MT023AB0002', 'BF-029-DIE', 'BEEF BONE-IN SHANK - DIERICKX (22-28KG/BOX)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(164, 'MT023AB0003', 'BF-003-BOI', 'BEEF CHUCK - FRIBOI', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(165, 'MT023AB0004', 'BF-008-BOI', 'BEEF FOREQUARTER - FRIBOI (APPROX 20-30KG/BOX)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(166, 'MT023AB0005', 'BF-008-MIN', 'BEEF FOREQUARTER - MINERVA', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(167, 'MT023AB0006', 'BF-008-DIE', 'BEEF FOREQUARTER - DIERICKX', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 25, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(168, 'MT023AB0007', 'BF-010-BOI', 'BEEF KNUCKLES - FRIBOI', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(169, 'MT023AB0008', 'BF-039-DIE', 'BEEF MARROW BONE - DIERICKX (22-28KG/BOX)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(170, 'MT023AB0009', 'BF-013-CAR', 'BEEF SHORTPLATE - CARGILL EXCEL', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, 25, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(171, 'MT023AB0010', 'BF-016-MER', 'BEEF TRIMMINGS 80VL - MERCURIO', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(172, 'MT023AB0011', 'BF-016-MON', 'BEEF TRIMMINGS 80VL - MONDELLI', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(173, 'MT023AB0012', 'BF-017-CCT', 'BEEF TRIPE - CARGILL CIRCLE T', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 27.22, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(174, 'MT023AB0013', 'BF-017-FOU', 'BEEF TRIPE - FOUR STAR', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(175, 'MT023AC0014', 'PY-001-CVA', 'CHICKEN BREAST BLSL - CVALE (12KG/BOX)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 12, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(176, 'MT023AC0015', 'PY-001-CVA', 'CHICKEN BREAST BLSL - CVALE (15KG/BOX)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 15, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(177, 'MT023AC0016', 'PY-001-PEC', 'CHICKEN BREAST BLSL - PECO', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 18.14, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(178, 'MT023AC0017', 'PY-001-PER', 'CHICKEN BREAST BLSL - PERDIGAO (12KG/BOX)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 12, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(179, 'MT023AC0018', 'PY-001-SAD', 'CHICKEN BREAST BLSL - SADIA (10KG/BOX)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(180, 'MT023AC0019', 'PY-007-PER', 'CHICKEN LEG MEAT BLSL - PERDIGAO (12KG/BOX)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(181, 'MT023AC0020', 'PY-007-SAD', 'CHICKEN LEG MEAT BLSL - SADIA (12KG/BOX)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 12, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(182, 'MT023AC0021', 'PY-008-AUR', 'CHICKEN LEG MEAT BLSO - AURORA (12KG/BOX)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 12, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(183, 'MT023AC0022', 'PY-008-CVA', 'CHICKEN LEG MEAT BLSO - CVALE (15KG/BOX)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 15, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(184, 'MT023AC0023', 'PY-008-PER', 'CHICKEN LEG MEAT BLSO - PERDIGAO', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(185, 'MT023AC0024', 'PY-009-KOC', 'CHICKEN LEG QUARTER - KOCH (15KG/BOX)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(186, 'MT023AC0025', 'PY-009-M32', 'CHICKEN LEG QUARTER - MARJAC (10KG/BOX)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 10, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(187, 'MT023AC0026', 'PY-009-M32', 'CHICKEN LEG QUARTER - MARJAC (15KG/BOX)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 15, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(188, 'MT023AC0027', 'PY-009-PIL', 'CHICKEN LEG QUARTER - PILGRIMS (15KG/BOX)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(189, 'MT023AC0028', 'PY-012-JVE', 'CHICKEN WINGS  - JAN VAN EE (10KG/BOX)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(190, 'MT023AC0029', 'PY-012-AUR', 'CHICKEN WINGS - AURORA (15KG/BOX)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 15, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(191, 'MT023AC0030', 'PY-012-PER', 'CHICKEN WINGS - PERDIGAO (15KG/BOX)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(192, 'MT023AC0031', 'PY-012-BOS', 'CHICKEN WINGS 3 JOINTS - BOSCHER VOLAILLES (10KG/BOX)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(193, 'MT023AC0032', 'PY-012-PLU', 'CHICKEN WINGS - PLUKON (10KG/BOX)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(194, 'MT023AP0033', 'PK-002-ITA', 'PORK BACKFAT - AGRICOLA ITALIANA', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(195, 'MT023AP0034', 'PK-002-DEW', 'PORK BACKFAT - DE WAELE', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(196, 'MT023AP0035', 'PK-032-SAM', 'PORK BACKFAT SKIN ON - SAMI', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(197, 'MT023AP0036', 'PK-003-CRA', 'PORK BACKSKIN - CRANSWICK', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 10, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(198, 'MT023AP0037', 'PK-003-DCR', 'PORK BACKSKIN - DANISH CROWN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(199, 'MT023AP0038', 'PK-004-CRA', 'PORK BELLY BISO - CRANSWICK', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(200, 'MT023AP0039', 'PK-004-DCR', 'PORK BELLY BISO - DANISH CROWN (20-25KG/BOX)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(201, 'MT023AP0040', 'PK-039-BEN', 'PORK BELLY BISO DELI GRADE - BENS', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(202, 'MT023AP0041', 'PK-034-DRU', 'PORK BELLY BLSL - DRUMMOND', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(203, 'MT023AP0042', 'PK-034-ROU', 'PORK BELLY BLSL - ROUSSALY', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(204, 'MT023AP0043', 'PK-034-ROU', 'PORK BELLY BLSL - ROUSSALY-', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(205, 'MT023AP0044', 'PK-011-AUR', 'PORK COLLAR BUTT - AURORA', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(206, 'MT023AP0045', 'PK-011-PAM', 'PORK COLLAR BUTT - PAMPLONA', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 12, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(207, 'MT023AP0046', 'PK-016-SEF', 'PORK HEAD BONES - SEFICLO (APPROX 14-20KG/BOX)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, 35, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(208, 'MT023AP0047', 'PK-022-SMI', 'PORK LOIN - SMITHFIELD FARMLAND', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(209, 'MT023AP0048', 'PK-025-OLY', 'PORK SHOULDER - OLYMEL', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 27.22, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(210, 'MT023AP0049', 'FR-011-GEN', 'PORK BELLY BLSO 1BX - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(211, 'MT023AE0050', 'FP-008-GEN', 'EASY DELI KOREAN CHICKEN 750G - GEN x15kg (15packs)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(212, 'MT023AE0051', 'FB-015-GEN', 'EASY DELI BEEF BULALO CUT 500G - GEN x10kg (20packs)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(213, 'MT023AE0052', 'FR-050-GEN', 'EASY DELI PORK BACON MAPLE 500G - GEN x10kg (20packs)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(214, 'MT023AE0053', 'FR-034-GEN', 'EASY DELI GROUND PORK 500G - GEN x10kg (20packs)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(215, 'MT023AE0054', 'FP-007-GEN', 'EASY DELI CHICKEN WINGS 750G - GEN x15kg (15packs)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(216, 'MT023AE0055', 'FP-014-GEN', 'EASY DELI CHICKEN THIGHS 1KG - GEN x1kg (12packs)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(217, 'MT023AE0056', 'FR-020-GEN', 'EASY DELI PORK ADOBO CUT 500G - GEN x10kg (20packs)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(218, 'MT023AE0057', 'FR-022-GEN', 'EASY DELI PORK MENUDO CUT 500G - GEN x10kg (20packs)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(219, 'MT023AE0058', 'FR-041-GEN', 'EASY DELI PORK SAMGYUPSAL 500G - GEN x10kg (20packs)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(220, 'MT023AE0059', 'FP-015-GEN', 'EASY DELI CHICKEN DRUMSTICK 1KG - GEN x12kg (12packs)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(221, 'MT023AE0060', 'FB-017-GEN', 'EASY DELI BEEF KALDERETA CUT 500G - GEN x10kg (20packs)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(222, 'MT023AA0061', 'FP-020-GEN', 'ALL DAY EASY DELI CHICKEN LEG QUARTERS 750G - GEN x15kg (15packs)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(223, 'MT023AA0062', 'FP-017-GEN', 'ALL DAY EASY DELI CHICKEN CUT-UPS 1KG - GEN x12kg (12packs)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(224, 'MT023AE0063', 'FP-012-GEN', 'EASY DELI CHICKEN NUGGETS 180G - GEN x7.2kg', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(225, 'MT023AE0064', 'FP-009-GEN', 'EASY DELI CHICKEN TERIYAKI 750G - GEN x15kg (15packs)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(226, 'MT023AE0065', 'FB-015-GEN', 'EASY DELI BEEF BULALO CUT 500G - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 4, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(227, 'MT023AA0066', 'FP-017-GEN', 'ALL DAY EASY DELI CHICKEN CUT-UPS 1KG - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 4, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(228, 'MT023AE0067', 'FP-015-GEN', 'EASY DELI CHICKEN DRUMSTICK 1KG - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 4, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(229, 'MT023AA0068', 'FP-020-GEN', 'ALL DAY EASY DELI CHICKEN LEG QUARTERS 750G - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 4, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(230, 'MT023AE0069', 'FP-012-GEN', 'EASY DELI CHICKEN NUGGETS 180G - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 4, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(231, 'MT023AE0070', 'FP-009-GEN', 'EASY DELI CHICKEN TERIYAKI 750G - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 4, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(232, 'MT023AE0071', 'FP-014-GEN', 'EASY DELI CHICKEN THIGHS 1KG - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 4, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(233, 'MT023AE0072', 'FP-007-GEN', 'EASY DELI CHICKEN WINGS 750G - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 4, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(234, 'MT023AE0073', 'FR-020-GEN', 'EASY DELI PORK ADOBO CUT 500G - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 4, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(235, 'MT023AE0074', 'FR-022-GEN', 'EASY DELI PORK MENUDO CUT 500G - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 4, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(236, 'MT023AE0075', 'FB-017-GEN', 'EASY DELI BEEF KALDERETA CUT 500G - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 4, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(237, 'MT023AE0076', 'FP-008-GEN', 'EASY DELI KOREAN CHICKEN 750G - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 4, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(238, 'MT023AE0077', 'FR-034-GEN', 'EASY DELI GROUND PORK 500G - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 4, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(239, 'MT023AE0078', 'FR-050-GEN', 'EASY DELI PORK BACON MAPLE 500G - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 4, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(240, 'MT023AC0079', 'PY-001-SAD\'', 'CHICKEN BREAST BLSL - SADIA (PACK)', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 2.5, NULL, NULL, 4, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(241, 'MT023AB0080', 'FB-001-GEN', 'BEEF BACON 220G - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(242, 'MT023AP0081', NULL, 'PORK BELLY BLSO 1BX - BENS', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(243, 'MT023AE0082', 'FP-035-GEN', 'EASY DELI CHICKEN BREAST FILLET - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(244, 'MT023AE0083', 'FR-030-GEN', 'EASY DELI PORK LIEMPO CUT 500G - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(245, 'MT023AE0084', 'FR-078-GEN', 'EASY DELI PORK CUBES 500G - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(246, 'MT023AE0085', 'FB-074-GEN', 'EASY DELI BEEF CUBES 500G - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(247, 'MT023AB0086', 'FB-049-GEN', 'BEEF BACON REGULAR 2MM 500G - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(248, 'MT023AP0087', 'FR-009-GEN', 'PORK BELLY BACON CUT 1.5MM 400-500G - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(249, 'MT023AP0088', 'FR-059-GEN', 'PORK BACON REGULAR 2MM 500G - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(250, 'MT023AB0089', 'FB-003-GEN', 'BEEF SAMGYUPSAL CUT 1.5MM 300-400G - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(251, 'MT023AC0090', 'FP-034-GEN', 'CHICKEN BREAST SLICED - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(252, 'MT023AP0091', 'FR-067-GEN', 'PORK BACON MAPLE 2MM 1KG - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(253, 'MT023AE0092', 'FB-073-GEN', 'EASY DELI BEEF TENDERLOIN STEAK - GEN', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(254, 'MT023A0093', 'PK-011-CON', 'PORK COLLAR BUTT - CONESTOGA', 26, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 60, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(255, 'MT023A0094', 'PK-037-PAM', 'PORK BELLY BLSO - PAMPLONA', 26, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 36, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(256, 'MT023A0095', 'PK-001-3RE', 'PORK BACKBONES - 3 REYES', 26, '2', '1', '-25', '-18', 1, 1, 1, 10, 1, 56, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(257, 'MT023A0096', 'PK-041-OLY', 'PORK FRONT FEET - OLYMEL', 26, '2', '1', '-25', '-18', 1, 1, 1, 20, 1, 25, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(258, 'MT023A0097', 'PY-001-AUR', 'CHICKEN BREAST BLSL - AURORA', 26, '2', '1', '-25', '-18', 1, 1, 1, 12, 1, 56, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(259, 'MT023A0098', 'PK-014-CON', 'PORK FEMUR BONES - CONESTOGA', 26, '2', '1', '-25', '-18', 1, 1, 1, 10, 1, 50, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(260, 'MT023A0099', 'PK-035-SMI', 'PORK HAM BLSL - SMITHFIELD FARMLAND', 26, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 30, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(261, 'MT023A0100', 'PK-034-COO', 'PORK BELLY BLSL SHEET RIBBED - COOPERL', 26, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 35, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(262, 'MT023A0101', 'BF-044-AMH', 'BEEF TRIMMINGS 75CL - AMH', 26, '2', '1', '-25', '-18', 1, 1, 1, 27.2, 1, 25, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(263, 'MT023A0102', 'SD-008-OVI', 'NOBASHI 14G (750PCS) - OLIVIA - VIOLET', 26, '2', '1', '-25', '-18', 1, 1, 1, 10.5, 1, 36, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(264, 'MT023A0103', 'SD-011-GBL', 'PD 21-25 - BLACK', 26, '2', '1', '-25', '-18', 1, 1, 1, 10, 1, 50, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(265, 'MT023A0104', 'PK-034-COO', 'PORK BELLY BLSL SINGLE RIBBED - COOPERL', 26, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 35, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(266, 'MT023A0105', 'SD-016-GUE', 'PDTO 16-20 - BLUE', 26, '2', '1', '-25', '-18', 1, 1, 1, 10, 1, 50, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(267, 'MT023A0106', NULL, 'PD 41-50 - BLACK ', 26, '2', '1', '-25', '-18', 1, 1, 1, 10, 1, 50, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(268, 'MT023A0107', NULL, ' PD 31-40 - BLACK', 26, '2', '1', '-25', '-18', 1, 1, 1, 10, 1, 50, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(269, 'MT023A0108', 'PK-034-COO', 'PORK BELLY BLSL - COOPERL', 26, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 35, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(270, 'MT023A0109', 'PK-029-SEA', 'PORK TENDERLOIN - SEARA (18KG/BOX)', 26, '2', '1', '-25', '-18', 1, 1, 1, 18, 1, 40, 3, 1, '', 2, 365, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(271, 'AA015A0085', '310', 'POMPANO - IM2', 18, '2', '1', '-25', '-18', 1, 1, 1, 10, 1, 50, 3, 1, '', 2, 480, 1, 'Active', 'Fast Moving', 'High Value', 1, 50),
	(272, 'AA015A0086', '2724', 'FROZEN PEELED & DEVEINED TAIL-ON (31/40)', 18, '2', '1', '-25', '-18', 1, 1, 1, 10, 1, 50, 3, 1, '', 2, 365, 1, 'Active', 'Fast Moving', 'High Value', 1, 50),
	(273, 'AA015A0087', '2980', 'DORY KABAYAKI', 18, '2', '1', '-25', '-18', 1, 1, 1, 4.8, 1, 36, 3, 1, '', 2, 480, 1, 'Active', 'Fast Moving', 'High Value', 1, 36),
	(274, 'AA015A0088', '2077BB', 'FROZEN PEELED & DEVEINED (51/60)', 18, '2', '1', '-25', '-18', 1, 1, 1, 1, 10, 50, 4, 10, '2077', 3, 540, 1, 'Active', 'Fast Moving', 'High Value', 1, 10),
	(275, 'AA015A0089', '2724BB', 'FROZEN PEELED & DEVEINED TAIL-ON (\'31/40)', 18, '2', '1', '-25', '-18', 1, 1, 1, 1, 10, 50, 4, 10, '2724', 3, 540, 1, 'Active', 'Fast Moving', 'High Value', 1, 10),
	(276, 'AA015A0090', '2725BB', 'FROZEN PEELED & DEVEINED  (31/40)', 18, '2', '1', '-25', '-18', 1, 1, 1, 1, 10, 50, 4, 10, '2725', 3, 540, 1, 'Active', 'Fast Moving', 'High Value', 1, 10),
	(277, 'AA015A0091', '2741BB', '(2741BB) FROZEN PEELED & DEVEINED (21/25)', 18, '2', '1', '-25', '-18', 1, 1, 1, 1, 10, 50, 4, 10, '2741', 3, 540, 1, 'Active', 'Fast Moving', 'High Value', 1, 10),
	(278, 'AA015A0092', '2756BB', 'FROZEN PEELED & DEVEINED (91/110)', 18, '2', '1', '-25', '-18', 1, 1, 1, 1, 10, 50, 4, 10, '2756', 3, 540, 1, 'Active', 'Fast Moving', 'High Value', 1, 10),
	(279, 'AA015A0093', 'TEMPO13BB', '(TEMPO 13BB) SAMPLE - F. PANGASIUS FILLET', 18, '2', '1', '-25', '-18', 1, 1, 1, 1, 10, 50, 4, 10, '', 3, 540, 1, 'Active', 'Fast Moving', 'High Value', 1, 10),
	(281, 'AA015A0094', '2741', '(2741) FROZEN PEELED & DEVEINED 21/25', 18, '2', '1', '-25', '-18', 1, 1, 1, 10, 10, 45, 3, 1, '', 3, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 45),
	(282, 'AA015A0095', '2670', '(2670) FROZEN PEELED & DEVEINED 41/50', 18, '2', '1', '-25', '-18', 1, 1, 1, 10, 10, 45, 3, 1, '', 3, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 45),
	(283, 'AA015A0096', '2077', '(2077) FROZEN PEELED & DEVEINED 51/60', 18, '2', '1', '-25', '-18', 1, 1, 1, 10, 10, 45, 3, 1, '', 3, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 45),
	(284, 'AA015A0097', '2756', '(2756) FROZEN PEELED & DEVEINED 91/110', 18, '2', '1', '-25', '-20', 1, 1, 1, 10, 10, 45, 3, 1, '', 3, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 45),
	(285, 'AA015A0098', '2725', '(2725) FROZEN PEELED & DEVEINED 31/40', 18, '2', '1', '-25', '-18', 1, 1, 1, 10, 10, 45, 3, 1, '', 3, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 45),
	(286, 'YL130A0001', '130004985', 'AJINOMOTO GYOZA 570GX10', 82, '1', '1', '-25', '-18', 41, 23, 26, 5.7, 10, 40, 3, 1, '', 2, 365, 1, 'Active', 'Fast Moving', 'High Value', 1, 40),
	(287, 'YL130A0002', '130004996', 'AJINOMOTO KARAAGE 600GX10', 82, '1', '1', '-25', '-18', 41, 22, 21, 6, 10, 40, 3, 1, '', 2, 365, 1, 'Active', 'Fast Moving', 'High Value', 1, 40),
	(288, 'NE168A0001', 'NTI0001', 'PORK HAM BONELESS - HYLIFE', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 30, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 30),
	(289, 'NE168A0002', 'NTI0002', 'PORK HAM BLSL - OLYMEL', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 25, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 25),
	(290, 'NE168A0003', 'NTI0003', 'PORK HAM 4D - COMPAXO', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 25, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 25),
	(291, 'NE168A0004', 'NTI0004', 'PORK COLLAR BONELESS - WESTFORT', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 35, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 35),
	(292, 'NE168A0005', 'NTI0005', 'PORK SIRLOIN BONELESS - OLYMEL', 109, '2', '1', '-25', '-18', 1, 1, 1, 27.22, 1, 25, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 25),
	(293, 'NE168A0006', 'NTI0006', 'PORK SHOULDER 4D - COMPAXO', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 35, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 35),
	(294, 'NE168A0007', 'NTI0007', 'PORK WHOLE HEAD W/ TONGUE - OLYMEL', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 25, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 25),
	(295, 'NE168A0008', 'NTI0008', 'PORK SHOULDER BONE-IN - OLYMEL', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 30, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 30),
	(296, 'NE168A0009', 'NTI0009', 'PORK CARCASS FORE-END - VANROOI', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 25, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 25),
	(297, 'NE168A0010', 'NTI0010', 'PORK CARCASS MIDDLE - VANROOI', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 25, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 25),
	(298, 'NE168A0011', 'NTI0011', 'PORK CARCASS LEG - VANROOI', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 25, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 25),
	(299, 'NE168A0012', 'NTI0012', 'PORK LOIN END BONELESS RINDLESS - CONESTOGA', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 25, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 25),
	(300, 'NE168A0013', 'NTI0013', 'PORK SHOULDER BUTT BLSL - ALIMENTS ASTA', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 25, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 25),
	(301, 'NE168A0014', 'NTI0014', 'PORK HAM 4D BONELESS - COMPAXO', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 25, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 25),
	(302, 'NE168A0015', 'NTI0015', 'PORK HAM BLSL - ORVIANDE', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 25, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 25),
	(303, 'NE168A0016', 'NTI0016', 'PORK HEAD TONGUELESS - CONESTOGA', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 20, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 20),
	(304, 'NE168A0017', 'NTI0017', 'PORK LEGS 4D - SOPRACO BELLIPORC', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 30, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 30),
	(305, 'NE168A0018', 'NTI0018', 'PORK SHOULDER 4D - WESTFORT', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 40, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 40),
	(306, 'NE168A0019', 'NTI0019', 'PORK LEG BLSL - SEARA', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 40, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 40),
	(307, 'NE168A0020', 'NTI0020', 'PORK SHOULDER AND HAM BLSL - SODIPORC', 109, '2', '1', '-25', '-18', 1, 1, 1, 25, 1, 30, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 30),
	(308, 'NE168A0021', 'NTI0021', 'PORK SHOULDER BONELESS - DAWNPORK', 109, '1', '1', '-25', '-18', 1, 1, 1, 0, 1, 30, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 30),
	(309, 'NE168A0022', 'NTI0022', 'PORK SHOULDER BONE-IN HOCK-ON - KARRO', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 25, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 25),
	(310, 'NE168A0023', 'NTI0023', 'PORK HAM LEG BISO - FRIGO', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 36, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 36),
	(311, 'NE168A0024', 'NTI0024', 'PORK SHOULDER 4D BONELESS - IMACSA', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 30, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 30),
	(312, 'NE168A0025', 'NTI0025', 'PORK LOIN BLSL - LUCYPORC', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 40, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 40),
	(313, 'NE168A0026', 'NTI0026', 'BEEF ROBBED FOREQUARTER - ESTRELA', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 35, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 35),
	(314, 'NE168A0027', 'NTI0027', 'PORK SHOULDER BLSL - LUCYPORC', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 40, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 40),
	(315, 'NE168A0028', 'NTI0028', 'PORK HAM BONELESS - SEABOARD', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 28, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 28),
	(316, 'NE168A0029', 'NTI0029', 'PORK SHOULDER BONELESS - VLEESCENTRALE', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 40, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 40),
	(317, 'NE168A0030', 'NTI0030', 'PORK SHOULDER BONELESS 4D - VANROOI', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 40, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 40),
	(318, 'NE168A0031', 'NTI0031', 'PORK SHOULDER - FAMADESA', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 35, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 35),
	(319, 'NE168A0032', 'NTI0032', 'PORK SHOULDER BLSL - SEARA', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 35, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 35),
	(320, 'NE168A0033', 'NTI0033', 'PORK HAM LEG - WESTFORT', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 30, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 30),
	(321, 'NE168A0034', 'NTI0034', 'PORK LOIN BONELESS - SEABOARD', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 45, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 45),
	(322, 'SC170A0001', NULL, 'MODULE ESS - LITHIUM ION BATTERY', 110, '2', '4', '21', '25', 72, 45, 21, 20, 1, 10, 3, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 10),
	(323, 'SC170A0002', NULL, 'SWITCH GEAR', 110, '2', '4', '21', '25', 65, 66, 23, 20, 1, 12, 3, 1, '', 12, 0, 1, 'Active', 'Fast Moving', 'High Value', 1, 12),
	(324, 'SC170A0003', NULL, 'ACCESSORIES - MODULAR PLUG', 110, '2', '4', '21', '25', 53, 35, 14, 15, 1, 35, 3, 1, '', 12, 0, 1, 'Active', 'Fast Moving', 'High Value', 1, 35),
	(325, 'SC170A0004', NULL, 'SYSTEM BMS ASSY', 110, '2', '4', '21', '25', 35, 15, 55, 15, 1, 24, 3, 1, '', 12, 0, 1, 'Active', 'Fast Moving', 'High Value', 1, 24),
	(326, 'AA015A0099', '616BB', '(616BB) MILKFISH FILLET (RETAIL) (MF - LOCAL 450-550)', 18, '1', '1', '-18', '-25', 1, 1, 1, 1, 1, 50, 4, 1, NULL, 2, 365, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(327, 'AA015A0100', 'JFC-0000004', '(JFC-0000004) SALMON HEADS 400G+ 20KGS "COPALIS"', 18, '1', '1', '-18', '-25', 1, 1, 1, 20, 1, 35, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(328, 'MT023A0110', 'PY-001-OCK', 'CHICKEN BREAST BLSL - BOSTOCK', 26, '1', '1', '-18', '-25', 1, 1, 1, 6, 1, 40, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(329, 'MT023A0111', 'PY-002-OCK', 'CHICKEN BREAST BLSO - BOSTOCK', 26, '1', '1', '-18', '-25', 1, 1, 1, 6, 1, 40, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(330, 'MT023A0112', NULL, 'CHICKEN DRUMSTICK - BOSTOCK', 26, '1', '1', '-18', '-25', 1, 1, 1, 10, 1, 40, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(331, 'MT023A0113', NULL, 'CHICKEN PLAIN BUTTERFLY - BOSTOCK ', 26, '1', '1', '-18', '-25', 1, 1, 1, 6.25, 1, 40, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(332, 'MT023A0114', 'PY-012-OCK', 'CHICKEN WINGS - BOSTOCK', 26, '1', '1', '-18', '-25', 1, 1, 1, 10, 1, 40, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(333, 'MT023A0115', NULL, 'CHICKEN TENDERS - BOSTOCK', 26, '1', '1', '-18', '-25', 1, 1, 1, 6, 1, 40, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(334, 'MT023A0116', NULL, 'CHICKEN THIGH BISO - BOSTOCK ', 26, '1', '1', '-18', '-25', 1, 1, 1, 7, 1, 40, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(335, 'MT023A0117', 'PY-022-OCK', 'CHICKEN THIGH BLSO - BOSTOCK', 26, '1', '1', '-18', '-25', 1, 1, 1, 6.6, 1, 40, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(336, 'MT023A0118', 'PY-023-OCK', 'CHICKEN LEG - BOSTOCK ', 26, '1', '1', '-18', '-25', 1, 1, 1, 10, 1, 40, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(337, 'MT023A0119', 'PY-024-OCK', 'CHICKEN LIVER - BOSTOCK', 26, '1', '1', '-18', '-25', 1, 1, 1, 8, 1, 40, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(338, 'AA015A0101', '1534BB', '(1534) SARANGANI BAY PANGASIUS FILLET (SBPF (PA) - LOCAL 170-220)', 18, '1', '1', '-18', '-25', 1, 1, 1, 1, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(339, 'NE168A0035', 'NTI0035', 'BEEF HINDQUARTER TOPSIDE - SWIFT', 109, '1', '1', '-18', '-25', 1, 1, 1, 20.5, 1, 25, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(340, 'NE168A0036', 'NTI0036', 'PORK HAM BLSL - PORK KING', 109, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 32, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 32),
	(341, 'GP014A0001', '2', 'AVIKO SHOESTRING 7MM 1KGX12', 17, '1', '1', '-25', '-18', 1, 1, 1, 12, 1, 40, 3, 1, '', 5, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(342, 'GP014A0002', '22', 'FLECHARD BUTTER SELECTION 10KG', 17, '1', '1', '-25', '-18', 1, 1, 1, 10, 1, 75, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(343, 'GP014A0003', '23', 'FLECHARD FRENCH BUTTER 10KG', 17, '1', '1', '-25', '-18', 1, 1, 1, 10, 1, 72, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(344, 'GP014A0005', '3', 'AVIKO SHOESTRING 7MM 2.5KGX4', 17, '1', '1', '-25', '-18', 1, 1, 1, 10, 1, 48, 3, 1, '', 5, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(345, 'GP014A0004', '24', 'SEVONA DARK CHOCOLATE COMPOUND ID - 306 1KGX10', 17, '1', '4', '21', '25', 1, 1, 1, 10, 1, 72, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(346, 'GP014A0006', '25', 'BERYLS 8 PERCENT MILK CHOCOLATE COMPOUND 1KGX10', 17, '1', '4', '21', '25', 1, 1, 1, 10, 1, 72, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(347, 'GP014A0007', '26', 'ARLA WHIPPING CREAM 36 PERCENT UHT 1LX10 SEA', 17, '1', '3', '2', '8', 1, 1, 1, 10, 1, 66, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(348, 'GP014A0008', '27', 'SWISS VALLEY CREAM CHEESE 1.360KGX10', 17, '1', '3', '2', '8', 1, 1, 1, 13.6, 1, 63, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(349, 'GP014A0009', '28', '24,5PERCENT CC PLAIN ARLA PRO 4X1.5KG SEA', 17, '1', '3', '2', '8', 1, 1, 1, 6, 1, 84, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(350, 'GP014A0010', '29', 'ARLA PRO CREAM CHEESE PLAIN BLOCK 3X1.8KG', 17, '1', '3', '2', '8', 1, 1, 1, 5.4, 1, 120, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(351, 'GP014A0011', '30', 'ARLA PRO WHIP & COOK 30PERCENT FAT 1LX10', 17, '1', '3', '2', '8', 1, 1, 1, 10, 1, 64, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(354, 'GP014A0012', '5', 'SUNNY FARMS SHOESTRING 7MM 2000GX6', 17, '1', '1', '-25', '-18', 1, 1, 1, 12, 1, 1, 3, 1, '', 5, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(356, 'GP014A0013', '31', 'DANISH WHITE CHEESE 4X1600G APETINA', 17, '1', '3', '2', '8', 1, 1, 1, 6.4, 1, 45, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(357, 'GP014A0017', '32', 'WHITE CHEDDAR BLOCK 8X2.5KG ARLA PRO', 17, '1', '3', '2', '8', 1, 1, 1, 20, 1, 8, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(358, 'GP014A0016', '6', 'MASTER MARTINI MONNA LISA DELUXE 1LX12- CHILLED', 17, '1', '3', '2', '8', 1, 1, 1, 12, 1, 60, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(359, 'GP014A0018', '33', 'MASTER GOURMET GOLD - GP 12X1L', 17, '1', '3', '2', '8', 1, 1, 1, 12, 1, 60, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(360, 'GP014A0020', '34', 'CARAVELLA DARK FLAKES 8X2KG', 17, '1', '4', '21', '25', 1, 1, 1, 16, 1, 40, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(361, 'GP014A0021', '9', 'BUNGE NON DAIRY WHIP TOPPING 1LX12', 17, '1', '3', '2', '8', 1, 1, 1, 12, 1, 60, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(362, 'GP014A0022', '35', 'SUNNY FARMS SHOESTRING 7MM 1KGX12', 17, '1', '1', '-25', '-18', 1, 1, 1, 12, 1, 32, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(363, 'GP014A0048', '36', 'ARLA PRO NATURAL CHEDDAR BLOCK 8X2.5KG', 17, '1', '3', '2', '8', 1, 1, 1, 20, 1, 20, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(364, 'GP014A0024', '37', 'VIKING DANISH BRIE 12X125G', 17, '1', '3', '2', '8', 1, 1, 1, 1.5, 1, 205, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(365, 'GP014A0023', '11', 'BERYLS 19 PERCENT DARK CHOCOLATE COMPOUND 1KGX10', 17, '1', '4', '21', '25', 1, 1, 1, 10, 1, 72, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(366, 'GP014A0026', '38', 'VIKING DANISH CAMEMBERT 12X125G', 17, '1', '3', '2', '8', 1, 1, 1, 1.5, 1, 170, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(367, 'GP014A0027', '39', 'ARLA PRO HIGH STABILITY WHIPPING CREAM 10X1L', 17, '1', '3', '2', '8', 1, 1, 1, 1.5, 1, 100, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(368, 'GP014A0026', '12', 'BUTTER  SUNSHINE DAIRY CREAM UNSALTED 10KG/BOX', 17, '1', '1', '-25', '-18', 1, 1, 1, 10, 1, 70, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(369, 'GP014A0029', '21', 'AVIKO H SUPER CRUNCH 9.5MM3/8 4X2500G', 17, '1', '1', '-25', '-18', 1, 1, 1, 10, 1, 50, 3, 1, '', 5, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(370, 'GP014A0030', '20', 'ARLA PRO SWEET CREAM BUTTER UNSALTED', 17, '1', '1', '-25', '-18', 1, 1, 1, 10, 1, 90, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(371, 'GP014A0031', '19', 'ARLA PRO SWEET CREAM BUTTER SALTED', 17, '1', '1', '-25', '-18', 1, 1, 1, 10, 1, 90, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(372, 'GP014A0029', '17', 'MASTER MARTINI PLEASURE GOLD 1LX12', 17, '1', '3', '2', '8', 1, 1, 1, 12, 1, 60, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(373, 'GP014A0029', '13', 'MASTER MARTINI GIOIA PAIL 10KGX1', 17, '1', '4', '21', '25', 1, 1, 1, 10, 1, 36, 20, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(374, 'GP014A0031', '14', 'MASTER MARTINI GOURMET REGULAR 1LX12', 17, '3', '3', ' 2', '8', 1, 1, 1, 12, 1, 1, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(375, 'AA015A0102', 'TEMPO14BB', '(TEMPO14BB) RAW, PEELED AND DEVEINED (RPD 91/110)', 18, '1', '1', '-18', '-25', 1, 1, 1, 1, 10, 45, 4, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(376, 'GP014A0032', '15', 'BERYLS BITTERSWEET CHOCOLATE 1KGX10', 17, '1', '4', '21', '25', 1, 1, 1, 10, 1, 72, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(377, 'GP014A0033', '16', 'BERYLS CLASSIC COCOA POWDER 1KGX12', 17, '1', '4', '21', '25', 1, 1, 1, 12, 1, 24, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(378, 'GP014A0034', '1', 'AVIKO HASHBROWN', 17, '1', '1', '-25', '-18', 1, 1, 1, 10, 1, 2, 3, 2, '', 5, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(379, 'MT023A0120', NULL, 'PORK BACK BONE - KARRO FOODS (10 KGS/BOX)', 26, '1', '1', '-18', '-22', 1, 1, 1, 10, 1, 56, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 0, 0),
	(380, 'MT023A0121', 'PK-001-HFD', 'PORK BACKBONES - HOLA FOOD', 26, '1', '1', '-18', '-25', 1, 1, 1, 10, 1, 54, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(381, 'GP014D0035', '4', 'CONAPROLE UHT FULL CREAM MILK 1LX12', 17, '1', '4', '25', '30', 1, 1, 1, 12, 1, 10, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(382, 'GP014A0036', '07', 'BRAVO SWEETENED CONDENSED CREAMER 48CANSX390G', 17, '1', '4', '25', '30', 1, 1, 1, 18.72, 1, 42, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(383, 'GP014A0037', '08', 'MASTER MARTINI MONNA LISA DELUXE 1LX12- DRY', 17, '1', '4', '25', '30', 1, 1, 1, 12, 1, 3, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(384, 'GP014DA0038', '10', 'ARLA MILK GOODNESS FULL CREAM 12X1L', 17, '1', '4', '25', '30', 1, 1, 1, 12, 1, 3, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(385, 'GP014A0039', '18', 'MILK UHT LOW CREAM MILK ARLA ALL NATURAL 1L 12PACKS  ORCASE', 17, '1', '4', '25', '30', 1, 1, 1, 12, 1, 60, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(386, 'AA015A0103', '1616', '(1616) FFV HOSO - WS', 18, '1', '1', '-22', '-18', 1, 1, 1, 1, 1, 25, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(387, 'AA015A0104', '97', '(97) FFDI- LOCAL ', 18, '1', '1', '-22', '-18', 1, 1, 1, 1, 1, 25, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(388, 'MP013A0001', '4273356', 'CDM PANDAN COCONUT 6X12X90G', 16, '1', '4', '18', '21', 1, 1, 1, 6.48, 1, 75, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(389, 'MP013A0001', '4257095', 'CDM CASHEW & COOKIES 6X24X62G', 16, '1', '4', '18', '21', 1, 1, 1, 8.93, 1, 60, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(390, 'MP013A0002', '4000302', 'CDM MILK 12X24X30G', 16, '1', '4', '18', '21', 1, 1, 1, 8.64, 1, 48, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(391, 'MP013A0004', '4267078', 'CDM FRUIT & NUT 6X12X160G (SEA)', 16, '1', '4', '18', '21', 1, 1, 1, 11.52, 1, 60, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(392, 'MP013A0005', '4260328', 'CDM BITE SIZE ALMOND 24X50G', 16, '1', '4', '18', '21', 1, 1, 1, 12, 1, 72, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(393, 'MP013A0006', '4078445', 'CDM OREO CHOCO 34GX20 12CA SEA', 16, '1', '4', '18', '21', 1, 1, 1, 8.16, 1, 40, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(394, 'MP013A0005', '4257100', 'CDM MILK 6X24X62G', 16, '1', '4', '18', '21', 1, 1, 1, 8.93, 1, 60, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(395, 'MP013A0008', '4011316', 'TONE 200G BAG TINY DARK SEA 20CA', 16, '1', '4', '18', '21', 1, 1, 1, 8, 1, 40, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(396, 'MP013A0009', '4011313', 'TONE 200G TINY 8G MLK HK SG MY 20CA', 16, '1', '4', '18', '21', 1, 1, 1, 8, 1, 40, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(397, 'MP013A0008', '14609', 'TONE 100G TBL DARK 4X20CA', 16, '1', '4', '18', '21', 1, 1, 1, 8, 1, 65, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(398, 'MP013A0010', '13783', 'TBN WHITE TB 4/20/100G', 16, '1', '4', '18', '21', 1, 1, 1, 8, 1, 52, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(399, 'MP013A0012', '4047306', 'TOBLERONE MILK 8X24X35G', 16, '1', '4', '18', '21', 1, 1, 1, 6.72, 1, 40, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(400, 'MP013A0013', '4084899', 'TONE 100G TBL MILK 4X20CA', 16, '1', '4', '18', '21', 1, 1, 1, 8, 1, 52, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(401, 'MP013A0014', '4084989', 'TONE 50G TBL MILK 8X24CA', 16, '1', '4', '18', '21', 1, 1, 1, 9.6, 1, 30, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(402, 'MP013A0014', '13783', 'TBN WHITE TB 4 20 00G', 16, '1', '4', '18', '21', 1, 1, 1, 8, 1, 52, 1, 1, '', 10, 1, 1, 'Hold', 'Fast Moving', 'High Value', 1, 1),
	(403, 'MP013A0016', '630901', 'TOBLERONE CRUNCHY ALMONDS 100GX20X4', 16, '1', '4', '18', '21', 1, 1, 1, 8, 1, 65, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(404, 'MP013A0017', '4267080', 'CDM PLAIN 6X12X90G', 16, '1', '4', '18', '21', 1, 1, 1, 6.48, 1, 75, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(405, 'MP013A0017', '845024', 'TONE 100G TBL F&N 4X20CA', 16, '1', '4', '18', '21', 1, 1, 1, 8, 1, 65, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(406, 'MP013A0018', '4265029', 'CDM NEAPS DOYBAG 18PCS 40X81G', 16, '1', '4', '18', '21', 1, 1, 1, 14.58, 1, 36, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(407, 'MP013A0020', '4257096', 'CDM ROAST ALMOND 6X24X62G (CS)', 16, '1', '4', '18', '21', 1, 1, 1, 8.93, 1, 60, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(408, 'MP013A0021', '4257099', 'CDM FRUIT & NUT 6X24X62G', 16, '1', '4', '18', '21', 1, 1, 1, 8.93, 1, 60, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(409, 'AA015A0105', 'FDAT-0000011', 'YELLOWFIN TUNA SAKU CO 300-500G', 18, '1', '1', '-18', '-25', 1, 1, 1, 10, 1, 42, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(410, 'AA015A0105', 'FDAT-0000007', 'YELLOWFIN TUNA BELLY CO 300G', 18, '1', '1', '-18', '-25', 1, 1, 1, 10, 1, 42, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(411, 'AA015A0107', 'FDAT-0000010', 'YELLOWFIN TUNA LOIN CO 2KG-UP', 18, '1', '1', '-18', '-25', 1, 1, 1, 20, 1, 42, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(412, 'AA015A0107', 'FDAT-0000008', 'YELLOWFIN TUNA KAMA MEAT 300-500G', 18, '1', '1', '-18', '-25', 1, 1, 1, 10, 1, 42, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(413, 'AA015A0108', 'FDAT-0000009', 'YELLOWFIN TUNA STEAK CO 50-100G', 18, '1', '1', '-18', '-25', 1, 1, 1, 10, 1, 42, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(414, 'AA015A0110', 'FDAT- 0000008', 'YELLOWFIN TUNA KAMA MEAT 500G-UP', 18, '1', '1', '-18', '-25', 1, 1, 1, 10, 1, 42, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(415, 'MT023A0122', 'PY-008-COP', 'CHICKEN LEG MEAT BLSO- COPACOL ', 26, '1', '1', '-25', '-18', 1, 1, 1, 12, 1, 64, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(416, 'SA171A0001', '122850', 'PUD N CREME CAKE MIX 50lbs', 111, '2', '4', '21', '25', 1, 1, 1, 22.7, 1, 80, 9, 1, '', 10, 1, 1, 'In-Active', 'Fast Moving', 'High Value', 1, 1),
	(417, 'SA171A0002', '100088', 'COMPLETE CARROT CAKE W/O NUTS', 111, '2', '3', '21', '25', 1, 1, 1, 13.6, 1, 80, 9, 1, '', 7, 1, 1, 'In-Active', 'Fast Moving', 'High Value', 1, 1),
	(418, 'SA171A0003', '100086', 'CHOCOLATE CREME CAKE MIX 50lbs', 111, '2', '4', '21', '25', 1, 1, 1, 22.7, 1, 80, 9, 1, '', 10, 1, 1, 'In-Active', 'Fast Moving', 'High Value', 1, 1),
	(419, 'SA171A0004', NULL, 'Dulce de Leche Repostero 24lb-Tub', 111, '2', '4', '21', '25', 1, 1, 1, 10, 1, 80, 22, 1, 'SA171A0064', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(420, 'AA015A0111', '2983', '(2983) SQUID RINGS', 18, '1', '1', '-18', '-25', 1, 1, 1, 1, 1, 42, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(421, 'II174A0001', '3', 'CHICKEN SKIN BONELESS - SEARA (20KG/BOX)', 114, '1', '1', '-18', '-25', 1, 1, 1, 20, 1, 35, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(422, 'II174A0002', '4', 'BEEF HEAD MEAT - DAWN MEAT (25KG/BOX)', 114, '1', '1', '-18', '-25', 1, 1, 1, 25, 1, 30, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(423, 'TC132A0008', '1', '1x1x1', 84, '1', '1', '-18', '-25', 1, 1, 1, 30, 12, 25, 3, 100, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(424, 'MT023A0123', 'PK025AUR', 'AURORA PORK SHOULDER ', 26, '1', '1', '-18', '-25', 1, 1, 1, 25, 1, 30, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(425, 'AA015A0112', 'TEMPO15', 'SAMPLE', 18, '2', '1', '-22', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(426, 'AA015A0113', 'FDAT-0000002', 'GOLDEN POMFRET WHOLE 500-600G', 18, '1', '1', '-25', '-18', 1, 1, 1, 10, 1, 56, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(427, 'AA015A0114', 'FDAT-0000001', 'GOLDEN POMFRET WHOLE 400-500G', 18, '2', '1', '-25', '-18', 1, 1, 1, 10, 1, 56, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(428, 'MF059A0001', 'RMFD01000010036', 'Noodles Linguine - Dolce Vita - 500 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(429, 'MF059A0002', 'RMFD01000010001', 'Noodles Angel Hair - San Remo - 500 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(430, 'MF059A0003', 'RMFD01000010011', 'Noodles Sotanghon - Sapporo Longkow - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(431, 'MF059A0004', 'RMFD01000010007', 'Noodles Elbow Macaroni - Royal - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(432, 'MF059A0005', 'RMFD01100010001', 'Catsup Banana - UFC - 4 KG / Container', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 28, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(433, 'MF059A0006', 'RMFD01100010002', 'Catsup Tomato - Heinz - 3.23 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(434, 'MF059A0007', 'RMFD00700020049 ', 'Cheese Filled - Kraft Eden - 430G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(435, 'MF059A0008', 'RMFD01100110001', 'Tomato Paste  - Del Monte - 150 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(436, 'MF059A0009', 'RMFD01100110002', 'Tomato Paste  - Del Monte - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(437, 'MF059A0010', 'RMBV00100050001', 'MolassesÃƒâ€šÃ‚Â  - Brer Rabbit Full ÃƒÂ¢Ã¢â€šÂ¬Ã¢â‚¬Å“ 355 ML Ãƒâ€šÃ‚Â / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(438, 'MF059A0011', 'RMFD01400030002', 'Molasses  - Shamrock - 4.8 KG / Container', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 28, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(439, 'MF059A0012', 'RMFD01100020002', 'Fish Sauce  - Datu Puti - 1 L / Container', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 28, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(440, 'MF059A0013', 'RMFD01100070001', 'Sauce All Around - Mang Tomas - 550 G / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(441, 'MF059A0014', 'RMFD00700100002', 'Milk Evaporated  - Alaska - 370 ML / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(442, 'MF059A0015', 'RMFD00800200001', 'Soup Cream of Mushroom - Campbell`s - 284 ML / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(443, 'MF059A0016', 'RMFD00800200003', 'Soup Cream of Mushroom - Campbell`s - 298ML / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(444, 'MF059A0017', 'RMFD00800030011', 'Bread Crumbs Japanese Style - Happy Fiesta - 230 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(445, 'MF059A0018', 'RMFD00800030016', 'Bread Crumbs - Akadema Yellow - 5 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(446, 'MF059A0019', NULL, 'Bread Crumbs - Happy Fiesta - 1KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(447, 'TR058A0001', '21051210', '3-HOLES HOLDER TRAY FOR PET CUP  (50PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 50, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(448, 'MF059A0020', 'RMFD00800030001', 'Bread Crumbs  - Olsen - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(449, 'TR058A0002', '31021050', '3M SCRUBBING PAD - BLACK (1 PCS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(450, 'TR058A0003', '31021051', '3M SCRUBBING PAD - WHITE (1 PCS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(451, 'TR058A0004', '31021051', '3M SCRUBBING PAD - WHITE (1 PCS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(452, 'TR058A0005', '21011037', 'ACRYLIC CAKE STAND (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(453, 'TR058A0006', '310303675', 'ACTIGEL HAND SOAP SANITIZER DISP.', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(454, 'MF059A0021', 'RMFD00800170001', 'Salt Refined Iodized - Mc Cormick - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(455, 'TR058A0007', '41041046', 'ADVANCE ORDER AGREEMENT (3PLY/50SET/PAD)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 3, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(456, 'MF059A0022', 'RMDC00100010016', 'Candle Birthday Small Pink - Liwanag - 24 Piece / Box', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 3, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(457, 'TR058A0008', '31011061', 'ALL PURPOSE CLEANER (100 PCS / CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 100, 25, 10, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(458, 'MF059A0023', 'RMDC00100010017', 'Candle Birthday Small Blue - Liwanag - 24 Piece / Box', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 3, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(459, 'TR058A0009', '11021017', 'ALL PURPOSE FLOUR (25KG/ SACK)', 50, '1', '4', '15', '25', 1, 1, 1, 25, 1, 25, 9, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(460, 'TR058A0010', '11061000', 'ALL PURPOSE OLD FASHIONED- LT (50LB/SACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 9, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(461, 'MF059A0024', 'RMDC00100130002', 'Toothpick With Mint - 1,000 Piece / Box', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 3, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(462, 'TR058A0011', '31011060', 'ALL PURPOSE SANITIZER (100 PCS / CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 100, 25, 10, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(463, 'TR058A0012', '10906134', 'ALL SPICE POWDER (1KG/PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(464, 'MF059A0025', 'RMDC00100130003', 'Toothpick Cocktail -  - 1,000 Piece / Box', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 3, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(465, 'TR058A0013', '11041008', 'ALMONDS SLICED ROASTED  (500gm / Pack)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 12, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(466, 'TR058A0014', '41021200', 'ALUMINUM COFFEE TAMPER', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(467, 'MF059A0026', 'RMFD00800170002', 'Salt Rock Iodized - LJ - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(468, 'MF059A0026', 'RMDC00500010010', 'Cake Topper - Happy Holidays - - 10 Pieces / Box', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 3, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(469, 'MF059A0028', 'RMFD00800060001', 'Cornstarch  - Queen - 2 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(470, 'TR058A0015', '41041044', 'AM/ PM - MANAGERS CODE/ CHECKLIST', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(471, 'MF059A0029', 'RMGN00300360003', 'Microfiber Cloth White 24.9 x 30.3cm (50pcs/box) - - by Box', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 3, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(472, 'MF059A0029', 'RMFD00600030017', 'Chocolate Premium - Boyds - 1KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(473, 'TR058A0016', '41041043', 'AM/ PM - MANAGERS NOTATION', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(474, 'MF059A0031', 'RMGN00300360004', 'Microfiber Cloth White KENLEEN 24.9 x 30.3cm (50pcs/box) - - by Box', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 3, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(475, 'MF059A0031', 'RMFD01100060014', 'Olive Oil Pure - Dolce Vita - 5 L / Container', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 28, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(476, 'TR058A0017', '10431013', 'AMBIANTE WHIP CREAM(12X1 LITER/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(477, 'MF059A0033', 'RMOF00700070004', 'POS Tape Receipts 80mmx70mm - - 50 Roll / Box', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 3, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(478, 'MF059A0033', 'RMFD01100060011', 'Olive Oil Pure - Castelvetere - 5 L / Container', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 28, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(479, 'TR058A0018', '10431031', 'ANCHOR WHIPPING CREAM 200ML', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(480, 'MF059A0035', 'RMFD00700050028', 'Milk Powdered - Full Cream - 1KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(481, 'TR058A0019', '10851012', 'AOB DECADENT MILK CHOCOLATE (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(482, 'TR058A0020', '10851013', 'AOB FINEST BELGIAN CHOCOLATE (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(483, 'TR058A0021', '10851011', 'AOB PREMIUM MOCHA LATTE (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(484, 'MF059A0036', 'RMPD00100020002', 'Coffee Filter Basket Style 4.5 IN Base - Brew Rite - 1000 Piece / Box', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 3, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(485, 'MF059A0036', 'RMFD00700050006', 'Milk Fresh - Nestle - 250 ML / Tetra', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(486, 'MF059A0037', 'RMPD00100030003', 'Gloves Disposable Vinyl Food Grade Medium -  - 100 Piece / Box', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 3, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(487, 'TR058A0022', '10902212', 'APITO EXPRESSO PASTE (2KGS/JUG)', 50, '1', '4', '15', '25', 1, 1, 1, 2, 1, 25, 13, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(488, 'MF059A0038', 'RMFD00900080003', 'Kernel Corn Whole - Happy Fiesta - - 425 G / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(489, 'MF059A0040', 'RMFD00900080005', 'Kernel Corn Whole - Sunbest - - 425 G / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(490, 'TR058A0023', '10411008', 'ARISTO PRIMEUR MILKY (2KG/5SHEETS/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 2, 1, 25, 8, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(491, 'MF059A0041', 'RMFD00900080004', 'Kernel Corn Whole - Jolly - - 425 G / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(492, 'MF059A0040', 'RMPD00100030006', 'Gloves Disposable -  - 100 Piece / Box', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 3, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(493, 'MF059A0043', 'RMPD00100030009', 'Gloves Disposable Vinyl Food Grade Large -  - 100 Piece / Box', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 3, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(494, 'MF059A0043', 'RMFD00900090002', 'Mushroom Buttons Whole - Sun Best - 425 G / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(495, 'TR058A0024', '10833004', 'ARIZONA ASSTD IN CAN (460ML/24CAN/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 24, 25, 14, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(496, 'MF059A0045', 'RMFD00900090008', 'Mushroom Buttons Whole - Happy Fiesta - 425 G / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(497, 'MF059A0046', 'RMGN00300350003', 'Face Mask Pouch Bag Plain 4x1.5x7.5 IN - - 50 pcs / Bundle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 25, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(498, 'TR058A0025', '10814004', 'ARIZONA ASSTD IN GLASS (473ML/12BOT/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 12, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(499, 'TR058A0026', '10814005', 'ARIZONA ASSTD IN PET (591ML/24BOT/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 24, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(500, 'MF059A0047', 'RMDC00100010020', 'Candle Birthday Big Blue -  - 12 Piece / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(501, 'TR058A0027', '41041034', 'AUTHORIZATION TO DEDUCT', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(502, 'MF059A0047', 'RMFD01400040022', 'Sugar Refined Sugar - Victorias - 500 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(503, 'MF059A0049', 'RMFD01400040004', 'Sugar Refined White - - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(504, 'TR058A0028', '10122014', 'BACON (500GMS/ PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(505, 'MF059A0050', NULL, 'Sugar Refined White - - 500g / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(506, 'MF059A0051', 'RMBV00200050007Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â ', 'Sugar Refined White 7 G - Generic - 100 Sachet / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(507, 'MF059A0051', 'RMDC00100010021', 'Candle Birthday Big Pink -  - 12 Piece / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(508, 'TR058A0029', '61011004', 'BALLOONS, LONG  (100 PCS / PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 100, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(509, 'MF059A0053', 'RMBV00200050005', 'Sugar White 7 G - Conti`s - 100 Sachet / Pack', 51, '1', '4', '18', '25', 1, 1, 14, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(510, 'MF059A0054', 'RMBV00200050002', 'Sugar Refined White 7 G -  - 100 Sachet / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(511, 'MF059A0054', 'RMDC00100010022', 'Candle Tealight - - - 10 Pieces / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(512, 'MF059A0055', 'RMFD00700070002', 'Whipped Cream All Purpose - Nestle - 250 ML / Tetra', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(513, 'TR058A0030', '10906252', 'BANANA FILLING TOPPING (1KG/20PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(514, 'MF059A0056', 'RMDC00100010043', 'Candle Birthday Lavender 50pcs/pack - - by Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(515, 'TR058A0031', '41041045', 'BAR ORDER SLIP (50 SET/ PAD)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 50, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(516, 'MF059A0058', 'RMDC00100010044', 'Candle Birthday Blue 50pcs/pack - - by Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(517, 'MF059A0058', 'RMBV00200030004', 'Coffee Creamer  - Krem-Top - 450 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(518, 'TR058A0032', '12031186', 'BARRY CALLEBAUT DARK CHOCOLATE PEARLS (800GRAMS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(519, 'MF059A0060', 'RMDC00100070008', 'Plastic Fork w/ Tissue- Repacked - BIO - - 25set / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(520, 'TR058A0033', '12031008', 'BELCOLADE BLANC SELECTION (5KG/2PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 5, 2, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(521, 'MF059A0061', 'RMDC00100090008', 'Plastic Spoon & Fork + Tissue - Repacked - BIO - - 25 Set / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(522, 'MF059A0061', 'RMBV00200020012', 'Coffee Roasted Ground Decaf - Baristas Choice - 500 g / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(523, 'MF059A0062', 'RMDC00100100007', 'Straw Drinking White Bendable 8 Ãƒâ€šÃ‚Â¾ IN -  - 100 Pieces / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(524, 'TR058A0034', '12031087', 'BELCOLADE CHOCOLATE CHIPS (5KG/ 2PK/ CS)', 50, '1', '4', '15', '25', 1, 1, 1, 5, 2, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(525, 'MF059A0064', 'RMDC00100110001', 'Table Napkin Folded -  - 350 Piece / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(526, 'MF059A0064', 'RMFD00800030013', 'Bread Crumbs - Chefs Secret - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(527, 'TR058A0035', '12031210', 'BELCOLADE CHOCOLATE CHIPS 1KG/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(528, 'MF059A0066', 'RMFD02000020007', 'Coffee Classic - Nestle Nescafe - 50G/ Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(529, 'MF059A0066', 'RMDC00100110006', 'Table Napkin Folded 1-Ply With Logo w/o Oval 13x12 IN -  - 100 Piece / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(530, 'TR058A0036', '10906193', 'BELCOLADE DARK SELECTION DROPS (5KG/2PACK/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 5, 2, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(531, 'MF059A0068', 'RMFD02000020001', 'Coffee Classic - Nestle Nescafe - 100 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(532, 'MF059A0068', 'RMGN00200110001', 'Sponge  - Clean-up - 3 Piece / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(533, 'TR058A0037', '10851010', 'BELLAGIO SIPPING CHOCOLATE POWDER (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(534, 'MF059A0070', 'RMBV00200030001', 'Coffee Creamer 5G -  Nestle Coffeemate - 48 Sachet / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(535, 'MF059A0071', 'RMPD00100080002', 'Filter Paper Flat Sheet 25 IN x 14.8 IN -  - 100 Piece / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(536, 'TR058A0038', '41021259', 'BELT FOR RACK COVER', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(537, 'MF059A0071', 'RMBV00200020017', 'Coffee Whole Beans Roasted 500G - Premium Roast Arabica Boyds- Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(538, 'TR058A0039', '21011086', 'BIRTHDAY CANDLE GOLD 6PC/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 6, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(539, 'MF059A0073', 'RMPD00100080003', 'Filter Paper Flat Sheet 18 IN x 20 IN - - 30 Piece / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(540, 'MF059A0073', 'RMBV00200040003', 'Coffee Creamer 5 G - Conti`s - 100 Sachet / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(541, 'TR058A0040', '21011087', 'BIRTHDAY CANDLE ROSEGOLD', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(542, 'TR058A0041', '21051667', 'BIRTHDAY DOUGHNUT BOX 100PC/10PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(543, 'TR058A0042', '12031178', 'BLACK SESAME SEED, ROASTED (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(544, 'TR058A0043', '10852039', 'BLACK TEA POWDER LEMON LIPTON (320G/6PACKS/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(545, 'TR058A0044', '51021276', 'BLOW TORCH', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(546, 'MF059A0075', 'RMPK00100050006', 'Pastry Cups 1 OZ - - 1,500 Piece / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(547, 'TR058A0045', '10902166', 'BLUEBERRY FLAVOR (500G/BOTTLE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(548, 'TR058A0046', '10902160', 'BLUEBERRY FLAVOR 30ML', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(549, 'MF059A0076', 'RMPK00300020001', 'Paper Plate Laminated 9 IN -  - 25 Piece / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(550, 'MF059A0076', 'RMBV00200020018', 'Coffee High Roast - Nescafe Alegria - 250 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(551, 'TR058A0047', '21051197', 'BOX CHILD SURPRISE MUG (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(552, 'MF059A0078', 'RMPK00300020002', 'Paper Plate Laminated White 9 IN -  - 50 Piece / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(553, 'TR058A0048', '21051190', 'BOX W/ WINDOW (100PC/PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(554, 'MF059A0078', 'RMBV00200020016', 'Coffee Roasted Ground Beans - H&S Espresso Italiano- 500 g / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(555, 'MF059A0079', 'RMPK01600020001', 'Paper Straw Drinking White 8 IN - - 50 pcs / pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(556, 'TR058A0049', '21051192', 'BOX, FOR 12OZ MUGS (24PC/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(557, 'MF059A0081', 'RMPK01600020002', 'Paper Straw Drinking White 8 IN - - 100 pcs / pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(558, 'MF059A0081', 'RMBV00200040002', 'Coffee Creamer  - JC - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(559, 'TR058A0050', '21051193', 'BOX, FOR 16OZ MUGS (24PC/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(560, 'MF059A0083', 'RMPK01600020003', 'Paper Straw Drinking White Individually Wrap 10 IN - -100pcs/pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(561, 'MF059A0084', 'RMPK01600020005', 'Paper Straw Drinking White Individually Wrap 12mm x 225mm - -100pcs/Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(562, 'MF059A0084', 'RMBV00200020015', 'Coffee Roasted Ground Decaf - H&S Gourmet Decaf- 500 g / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(563, 'TR058A0051', '21051194', 'BOX, FOR THERMAL MUGS (24PCS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(564, 'MF059A0086', 'RMBV00200020014', 'Coffee Roasted Whole Beans - H&S - 500 g / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(565, 'MF059A0087', 'RMFD01400040021', 'Sugar Refined Brown - Biscom - 500 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(566, 'MF059A0088', 'RMFD01400040001', 'Sugar Brown - Peotraco - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(567, 'TR058A0052', '10906194', 'BRAUN TIRAMISU POWDER  (1KG/5PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(568, 'MF059A0089', 'RMFD01400040011', 'Sugar Brown - Sparkle - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(569, 'TR058A0053', '21061132', 'BREW BOX COVER (1 PCS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(570, 'TR058A0054', '21061133', 'BREW BOX JR COVER (100PC/ PK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(571, 'MF059A0090', 'RMBV00200050006Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â ', 'Sugar Refined Brown 7 G - Generic - 100 Sachet / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(572, 'MF059A0091', 'RMBV00200050004', 'Sugar Brown 7 G - Conti`s - 100 Sachet / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(573, 'MF059A0090', 'RMOF00100100009', '2018RB Order Slip - - by Pad ', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 35, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(574, 'TR058A0055', '21061131', 'BREW BOX JR PLASTIC CNTR (9PCS/ PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(575, 'MF059A0093', 'RMBV00100010002', 'Cola  - Coke - 330 ML / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(576, 'TR058A0056', '21061130', 'BREW BOX PLASTIC CNTR (1 PCS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(577, 'MF059A0094', 'RMBV00100020001', 'Coke Zero -  - 330 mL / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(578, 'TR058A0057', '11061009', 'BREWLESS YEAST DOUGHNUT MIX  (25KG/BAG)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 5, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(579, 'MF059A0095', 'RMBV00100010006', 'Cola Clear - Sprite - 330 ML / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(580, 'TR058A0058', '310300403', 'BTL/SPRAYER DEGREASER', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(581, 'MF059A0096', 'RMFD02000090006', 'Wine White - Don Garcia - 1 L / Tetra', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(582, 'TR058A0059', '310300401', 'BTL/SPRAYER MPC', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(583, 'MF059A0097', 'RMFD02000090003', 'Wine Red - Don Garcia - 1 L / Tetra', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(584, 'MF059A0097', 'RMDC00100010023', 'Candle #0 - Lavander - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(585, 'MF059A0099', 'RMFD02000010001', 'Pale Pilsen Light - San Miguel - 330 ML / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(586, 'TR058A0060', '310300407', 'BTL/SPRAYER SANITIZER', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(587, 'MF059A0099', 'RMDC00100010024', 'Candle #1 - Lavander - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(588, 'MF059A0101', 'RMFD02000010002', 'Pale Pilsen Regular - San Miguel - 330 ML / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(589, 'TR058A0061', '10902161', 'BUBBLEGUM FLAVOR 30ML', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(590, 'MF059A0101', 'RMDC00100010025', 'Candle #2 - Lavander - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(591, 'MF059A0103', 'RMDC00100010026', 'Candle #3 - Lavander - - by Piece', 51, '1', '4', '18', '25', 11, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(592, 'MF059A0103', 'RMBV00300010010', 'Juice Pineapple Unsweetened - Del Monte - 2.9 L / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(593, 'TR058A0062', '61021003', 'BULL CAP, GRAY', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(594, 'MF059A0104', 'RMDC00100010027', 'Candle #4 - Lavander - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(595, 'MF059A0106', 'RMFD00900140007', 'Pineapple Tidbits Extra Light Syrup - Dole - 3060 G / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(596, 'MF059A0106', 'RMDC00100010029', 'Candle #6 - Lavander - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(597, 'MF059A0108', 'RMDC00100010030', 'Candle #7 - Lavander - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(598, 'MF059A0109', 'RMDC00100010031', 'Candle #8 - Lavander - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(599, 'MF059A0109', 'RMBV00300010008', 'Juice Pineapple Unsweetened - Dole - 2.9 L / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(600, 'MF059A0111', 'RMDC00100010032', 'Candle #9 - Lavander - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(601, 'TR058A0063', '61021002', 'BULL CAP, RED (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(602, 'MF059A0112', NULL, 'Pineapple Slices -Dole - 822 G / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(603, 'TR058A0064', '61011006', 'BULLCAP, NAVY BLUE (10PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 10, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(604, 'MF059A0113', 'RMFD00900140009', 'Pineapple Tidbits Extra Heavy Syrup - Dole - 3060 G / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(605, 'MF059A0113', 'RMDC00100010028', 'Candle #5 - Lavander - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(606, 'TR058A0065', '41021082', 'BUTANE (230ML/BOTTLE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(607, 'MF059A0115', 'RMFD00900140006', 'Pineapple Tidbits Extra Light Syrup - Dole - 822 G / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(608, 'TR058A0066', '10411002', 'BUTTER OIL SUBSTITUTE 15KG/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 12, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(609, 'TR058A0067', '10721015', 'BUTTER, MIMETIC (KILO)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 12, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(610, 'MF059A0116', 'RMBV00300010012', 'Juice Pineapple Unsweetened - Dole - 1.36 L / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(611, 'MF059A0117', 'RMBV00300010009', 'Juice Pineapple Unsweetened - Del Monte - 1.36 L / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(612, 'TR058A0068', '11061004', 'BUTTERMILK (5KG/ SACK)', 50, '1', '4', '15', '25', 1, 1, 1, 5, 1, 25, 9, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(613, 'MF059A0118', 'RMBV00300030012', 'Juice Mix Iced Tea Raspberry - Sola -473ml / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(614, 'MF059A0119', 'RMBV00300030011', 'Juice Mix Iced Tea Lemon - Sola -473ml / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(615, 'TR058A0069', '10901167', 'CACAO IVORY WHITE CHOCOLATE COMPOUND (2.5KG/10BLOCKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 2.5, 10, 25, 7, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(616, 'MF059A0120', 'RMBV00300030013', 'Juice Mix Iced Tea Apple - Sola -473ml / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(617, 'TR058A0070', '10901166', 'CACAO IVORY WHITE COMPOUND CHOCOLATE BUTTONS (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(618, 'MF059A0120', 'RMDC00100010033', 'Candle #0 - Blue - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(619, 'MF059A0121', 'RMFD02000040002', 'Juice Lemon - Real Lemon - 1.4 L / Container', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 28, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(620, 'TR058A0071', '10901165', 'CACAO WHITE CHOCOLATE COMPOUND (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(621, 'TR058A0072', '12031011', 'CADBURRY DAIRY MILK CHOCOLATE (165G/12BARS/6PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 12, 25, 15, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(622, 'MF059A0123', 'RMDC00100010034', 'Candle #1 - Blue - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(623, 'MF059A0123', 'RMFD01300080025', 'Rice for Customer - KCs Premium Graded - 25 KG - - by Sack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 9, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(624, 'TR058A0073', '10906237', 'CAFÃƒÆ’Ã¢â‚¬Â° ESSENTIALS CHOCOHOLIC CHOICE POWDER (1588GRMS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(625, 'MF059A0124', 'RMDC00100010035', 'Candle #2 - Blue - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(626, 'MF059A0126', 'RMDC00100010036', 'Candle #3 - Blue - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(627, 'TR058A0074', '31011079', 'CAFETTO S15 CLEANING TABLET (100 PCS/BTL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 100, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(628, 'MF059A0126', 'RMFD01300080018', 'Rice For Customer - Mary Ann - 25 KG - - by Sack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 9, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(629, 'MF059A0127', 'RMDC00100010037', 'Candle #4 - Blue - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(630, 'TR058A0075', '31011065', 'CAFIZA TABLET (8PCS/PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 8, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(631, 'MF059A0129', 'RMDC00100010038', 'Candle #5 - Blue - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(632, 'MF059A0129', 'RMFD01300080029', 'Rice For Customer - FC Thai Jasmine - 25 KG - - by Sack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 9, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(633, 'TR058A0076', '21051146', 'CAKE BOX (5PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 5, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(634, 'MF059A0131', 'RMDC00100010039', 'Candle #6 - Blue - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(635, 'TR058A0077', '10901168', 'CALLEBAUT WHITE CHOCOLATE W2 CALLETS (2.5KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 2.5, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(636, 'TR058A0078', '41021193', 'CAMBRO SCALLOP TONG,   12 CLEAR', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(637, 'TR058A0079', '12031157', 'CANDIED BACON (500G/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(638, 'TR058A0080', '10906208', 'CANDY - GUMMY WORM (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(639, 'TR058A0081', '12031163', 'CANDY TOPPER - BLOODY EYES (240PCS/BOX)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 240, 25, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(640, 'TR058A0082', '12031187', 'CANDY TOPPER - CARROT 1.5 (240PCS/BOX)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 240, 25, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(641, 'MF059A0132', 'RMFD01300080030', 'Rice for Customer - DoÃƒÆ’Ã‚Â±a Martha - 25 KG / Sack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 9, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(642, 'MF059A0132', 'RMDC00100010040', 'Candle #7 - Blue - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(643, 'MF059A0134', 'RMDC00100010041', 'Candle #8 - Blue - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(644, 'MF059A0134', 'RMFD01100130008', 'Chiffon Oil - Probest - 17 KG / Container', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 28, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(645, 'MF059A0135', 'RMDC00100010042', 'Candle #9 - Blue - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(646, 'MF059A0137', 'RMFD01100130003', 'Vegetable Oil  - Marca Leon - 17 KG / Container', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 28, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(647, 'MF059A0138', 'RMFD01100140005', 'Vinegar  - Datu Puti - 3.785 L / Gal', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 27, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(648, 'MF059A0139', 'RMFD01100090002', 'Soy Sauce  - Silver Swan - 3.785 L / Gal ', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 27, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(649, 'TR058A0083', '12031154', 'CANDY TOPPER - CUSTOMIZED', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(650, 'MF059A0140', 'RMFD00800190003', 'Seasoning Liquid - Knorr - 3.8 L / Container', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 28, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(651, 'TR058A0084', '12031188', 'CANDY TOPPER - MINI BLOSSOMS, WHITE (240PCS/BOX)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 240, 1, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(652, 'MF059A0141', 'RMGN00300190001', 'Hand Towel  -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(653, 'TR058A0085', '12031169', 'CANDY TOPPER - ORNAMENT CAP (120PCS/BOX)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 120, 25, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(654, 'MF059A0141', 'RMFD00900130004', 'Pickle Relish  - RAM - 1 Gal / Container', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 28, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(655, 'MF059A0142', 'RMGN00300350001', 'Face Mask  -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(656, 'TR058A0086', '12031136', 'CANDY TOPPER - ROUND EYE  (BLACK & WHITE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(657, 'MF059A0144', 'RMGN00300360001', 'Head cap  -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(658, 'MF059A0145', 'RMGN00300590002', 'Bag Eco Non-Woven 12.5x12.5x12.5 IN -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(659, 'TR058A0087', '12031170', 'CANDY TOPPER - STAR, YELLOW (240PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 240, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(660, 'MF059A0145', 'RMFD00800140013', 'Ginger Ground - Mc Cormick - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(661, 'MF059A0146', 'RMGN00300590008', 'Bag Insulated Reg 13.25x13.25x8.9 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(662, 'TR058A0088', '12031093', 'CANDY TOPPER-BOO', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(663, 'MF059A0148', 'RMGN00300590009', 'Bag Insulated Mini 10.5x10.5x8.12 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(664, 'MF059A0148', 'RMFD00800150001', 'Rosemary Leaves Whole - Mc Cormick - 500 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(665, 'TR058A0089', '12031092', 'CANDY TOPPER-RIP', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(666, 'MF059A0149', 'RMGN00300590012', 'Insulated Bag for Cake Slice 34cm x 26.5cm x 7.8cm - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(667, 'TR058A0090', '12031095', 'CANDY TOPPER-SKULL', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(668, 'MF059A0151', 'RMFD00800160001 ', 'Sago Small - Sunshine - 500 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(669, 'MF059A0151', 'RMPD00100040024', 'Sticker Tamper Proof (Destructible ) 1.25x2.20 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(670, 'MF059A0153', 'RMPD00100040025', 'Sticker Tamper Proof (Satin) 1.25x2.20 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(671, 'MF059A0153', 'RMFD00800180003', 'Demi-Glace Sauce Mix - Knorr - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(672, 'TR058A0091', '12031094', 'CANDY TOPPER-SPIDER', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(673, 'MF059A0155', 'RMFD00800210002', 'Sinigang Mix - Maggi - - 1KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(674, 'TR058A0092', '10906209', 'CANDY TOPPER-TRIANGLE EYE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(675, 'MF059A0156', 'RMFD00800220003', 'Thyme Leaves Whole - Mc Cormick - 400 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(676, 'MF059A0157', 'RMFD00800220005', 'Thyme Leaves Powder - Mc Cormick - 800 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(677, 'MF059A0157', 'RMPD00100040019', 'Sticker Safe Food Handling Big -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(678, 'TR058A0093', '12031090', 'CANDY TOPPER-TRIANGLE NOSE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(679, 'MF059A0158', 'RMFD00800230002', 'Wasabi Paste  - S&W - 43 G / Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(680, 'MF059A0160', 'RMFD00800250001', 'Saffron  -Edman - 1 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(681, 'TR058A0094', '12031129', 'CANDY TOPPER-WHITE EYE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 16, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(682, 'MF059A0161', 'RMFD00800270001', 'Broth Powder Pork - Knorr - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(683, 'MF059A0162', 'RMFD00800270002', 'Broth Powder Chicken - Knorr - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(684, 'TR058A0095', '10711015', 'CANOLA SPRAY (500ML/12TINS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 12, 25, 17, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(685, 'TR058A0096', '41051212', 'CAP W/ KK EMBRO, BLACK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(686, 'TR058A0097', '10819001', 'CARAMEL SYRUP  (NEW PKG) (1L/6BT/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 6, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(687, 'MF059A0163', 'RMFD00800340001', 'Broth Cubes Shrimp  - Knorr - 60 G / 6 Piece / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(688, 'MF059A0164', 'RMPD00100100002', 'Tag Work Order -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(689, 'TR058A0098', '12031004', 'CARAT COVERLAUX DARK COINS (5KG/ 2PK/ CS)', 50, '1', '4', '15', '25', 1, 1, 1, 5, 2, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(690, 'MF059A0164', 'RMFD01300020001', 'Atsuete Seeds  -  - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(691, 'MF059A0165', 'RMPD00800310001', 'Apron Dark Blue -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(692, 'TR058A0099', '12031005', 'CARAT WHITE (5KG/2PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 5, 2, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(693, 'MF059A0167', 'RMPK00100030002', 'Glassine Bag  1 IN -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(694, 'MF059A0166', 'RMFD01300070001', 'Pistachio Nuts Raw -  - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(695, 'MF059A0168', 'RMPK00100030009', 'Wrapper for Pies w/ Logo - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(696, 'TR058A0100', '41041031', 'CASH ADVANCE FORM (100 PAGES/ PAD)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 100, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(697, 'MF059A0169', 'RMFD01300070002', 'Pistachio Paste - Kranfil - 3 KG / Tub', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 22, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(698, 'TR058A0101', '41041026', 'CASHIERS TALLY SHEET (2 PLY/ 50 SET/ PAD)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 2, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(699, 'MF059A0171', 'RMPK00100070004', 'Wax Paper Round Mini  9.5 IN (1000pcs/ream) - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 1, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(700, 'MF059A0172', 'RMPK00100070005', 'Wax Paper Round Reg 12.5 IN (1000pcs/ream) - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(701, 'TR058A0102', '41041040', 'CCP - DRIVE THRU', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(702, 'MF059A0171', 'RMFD01300080003', 'Rice Glutenous / Malagkit -  - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(703, 'TR058A0103', '41041041', 'CCP AREA - BAR', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(704, 'MF059A0173', 'RMPK00100110001', 'Cap Seal Perforated 98 MM x 26 MM -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(705, 'MF059A0174', 'RMFD01300090001', 'Sesame Seeds Whole -  - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(706, 'TR058A0104', '41041042', 'CCP AREA - RETAIL & DINING', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(707, 'MF059A0175', 'RMPK00100110011', 'Cap Seal Transparent Plain for Round Canister 190 x 40 - Generic - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(708, 'MF059A0177', 'RMPK00100110013', 'Cap Seal Clear Perforated 288 MM x 45 MM x 50 MM - Generic - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(709, 'MF059A0176', 'RMFD01400050003', 'Sweetener Low Calorie - Splenda - 100 Sachet / Box ', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(710, 'TR058A0105', '41041039', 'CCP MANAGER - FACTORY', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(711, 'MF059A0178', 'RMPK00100110017', 'Cap Seal Perforated 280 x 40 mm -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(712, 'TR058A0106', '41041037', 'CCP PRODUCTION - FACTORY', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(713, 'MF059A0180', 'RMPK00100110018', 'Cap Seal 415mm x 45 mm - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(714, 'TR058A0107', '41041038', 'CCP PRODUCTION - TUNEL OVEN', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(715, 'MF059A0180', 'RMFD01700010022', 'Flavoring Chocolate Powder - PCP 990177 - 5 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(716, 'MF059A0181', 'RMPK00200010001', 'Aluminum Tray Rectangular 10x13x2 IN -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(717, 'MF059A0183', 'RMPK00200010002', 'Aluminum Tray Rectangular 10x6x2 IN -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(718, 'TR058A0108', '10431017', 'CHANTYPAK, NON - DAIRY TOPPINGS ( 12 X 1 LITER/PACK )', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(719, 'MF059A0183', 'RMFD01800040007', 'Mayonnaise - Kewpie - 1KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(720, 'MF059A0184', 'RMPK00200010012', 'Aluminum Tray Rectangular 10x7.5x2.5 IN (1890/55 - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(721, 'TR058A0109', '10906238', 'CHARCOAL POWDER (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(722, 'MF059A0186', 'RMPK00200010013', 'Aluminum Tray Rectangular 10x7.4x1.7 IN (1450/33 - -by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(723, 'MF059A0186', 'RMFD01800060002', 'Peanut Butter  - Lady`s Choice - 340 G / Tub', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 22, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(724, 'MF059A0187', 'RMPK00400050005', 'Box Match Type Body and Cover with Window 10x4x1.5IN - - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(725, 'MF059A0188', 'RMFD01800060003', 'Peanut Butter  - Lady`s Choice - 1 KG / Tub', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 22, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(726, 'TR058A0110', '41021056', 'CHARITY BOX (50 PCS / PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 50, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(727, 'TR058A0111', '10816004', 'CHARLIES QUENCHERS - ASSTD (12BOT/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 12, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(728, 'MF059A0190', 'RMFD01900010003', 'Bread Sliced - Olsen - 620 g / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(729, 'MF059A0191', 'RMFD01900030001', 'Buttercookies  - M.Y. San - 800 G / Tub', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 22, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(730, 'TR058A0112', '10421025', 'CHEESE - PARMESAN NZMP BLOCK (20KG/ BAR)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 15, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(731, 'MF059A0192', 'RMFD01900040001', 'Chicharon Bilog - R. Lapids - 200 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(732, 'TR058A0113', '10421019', 'CHEESE EMMENTAL ARLA 150G/PACK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(733, 'MF059A0193', 'RMFD01900050007', 'Chips Potato Plain - Oishi - 60 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(734, 'TR058A0114', '10421050', 'CHEESE EMMENTHAL (200G/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(735, 'TR058A0115', '10906234', 'CHEESE FILLING (5KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 5, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(736, 'TR058A0116', '12031199', 'CHEESECAKE SNOW POWDER (1.5KG/8BAGS/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1.5, 8, 25, 5, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(737, 'MF059A0194', 'RMFD01900060005', 'Chocolate Cookies  - Kraft Oreo - 266 G / Box', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(738, 'MF059A0195', 'RMPK00100040002', 'Contis Logo Sticker 1.5x1.125 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(739, 'TR058A0117', '10421032', 'CHEESE-MOZZARELLA BLOCK (4KGS/4BARS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 4, 4, 25, 15, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(740, 'TR058A0118', '10514029', 'CHERRIES RED PLAIN 16OZ/12BOT/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 12, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(741, 'MF059A0196', 'RMFD02100100004', 'Phosphate Mix - Multiphos - 1000g/ Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(742, 'TR058A0119', '12031127', 'CHERRY W/ STEM (16OZ/12BTLS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 12, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(743, 'MF059A0197', 'RMFD02100100008', 'Strawberry Jam - D Arbo - - 14 G / Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(744, 'TR058A0120', '12031128', 'CHERRY W/ STEM (26OZ/12BTLS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 12, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(745, 'MF059A0198', 'RMBV00200060003', 'Tea Camomile 25 G - Twinnings - 25 Bag / Box', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(746, 'TR058A0121', '10221005', 'CHICKEN EGG FRESH MEDIUM 56 - 60GMS/PC 30 PCS/TRAY', 50, '1', '4', '15', '25', 1, 1, 1, 1, 30, 25, 18, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(747, 'MF059A0199', 'RMBV00200060009', 'Tea Jasmine 50 G - Twinnings - 25 Bag / Box ', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(748, 'TR058A0122', '10711014', 'CHIFFON OIL (17KG/ CAN)', 50, '1', '4', '15', '25', 1, 1, 1, 17, 1, 25, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(749, 'MF059A0200', 'RMBV00200070004', 'Frapped Mocha Mix - Monin - - - 1Kg/pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(750, 'TR058A0123', '61031003', 'CHILDS SURPRISE MUG  (36 PCS / CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 36, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(751, 'MF059A0201', 'RMBV00300030015', 'Juice Mix Iced Tea Houseblend - Nestea -200G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(752, 'MF059A0202', 'RMPK00400110002', '2017RB Box Base 9x9x7 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(753, 'MF059A0202', 'RMBV00300030016', 'Juice Mix Lemonade - Nestle - 200 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(754, 'TR058A0124', '31011115', 'CHLORINE TEST STRIPS  (200 STRIPS/2VIALS/BOX)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 2, 25, 19, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(755, 'MF059A0203', 'RMPK00400110003', '2017RB Box Base 9x9x5 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(756, 'TR058A0125', '10857012', 'CHOCOLANTE DARK CHOCOLATE (1KG/8PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 8, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(757, 'MF059A0204', 'RMBV00300030017', 'Juice Mix Cucumber Lemonade - Nestle - 200 G / pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(758, 'MF059A0205', 'RMPK00400110004', '2017RB Box Base 11x11x7.5 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(759, 'TR058A0126', '10906125', 'CHOCOLATE CONCENTRATE (20LB/SACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 20, 25, 9, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(760, 'MF059A0207', 'RMFD00200270001', 'Anatto Powder  -  - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(761, 'MF059A0207', 'RMPK00400110005', '2017RB Box Base 11x11x5 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(762, 'TR058A0127', '12031134', 'CHOCOLATE CURLS-WHITE  (4KGS/4PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 4, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(763, 'MF059A0209', 'RMPK00400110006', '2017RB Box Base 11x11x4 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(765, 'MF059A0209', 'RMFD00500200003', 'Gabi Leaves  Dried for Laing -  - 100 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(766, 'MF059A0211', 'RMPK00400110007', '2017RB Box Base 11x11x3 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(767, 'TR058A0128', '10721008', 'CHOCOLATE ICING BASE - LT (35LB/PAIL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 35, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(768, 'MF059A0213', 'RMPK00400110008', '2017RB Box Base 9x9x3 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(770, 'MF059A0215', 'RMPK00400110010', '2017RB Box Cover w/ Small Window 9x9x1.5 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(771, 'TR058A0129', '12031135', 'CHOCOLATE SHAVINGS CURL-DARK (2.5KGS/2PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 2.5, 2, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(772, 'MF059A0215', 'RMFD00500200005', 'Gabi Leaves  Dried for Laing -  - 300 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(773, 'MF059A0216', 'RMPK00400110011', '2017RB Box w/ Window 9x9x2 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(774, 'MF059A0218', 'RMPK00400110012', '2017RB Box w/ Window 5x9x2 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(775, 'TR058A0130', '10851002', 'CHOCOLATE SYRUP  (NEW PKG) (2.5KG/9PCH/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 2.5, 9, 25, 21, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(776, 'MF059A0218', 'RMFD00500300005', 'Mushroom Shiitake - Klass A - 3 KG / Bag', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 5, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(777, 'MF059A0219', 'RMPK00400110014', '2017RB Box w/ Small Window 11x11x2.5 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(778, 'MF059A0221', 'RMPK00400110015', '2017RB Box w/ Small Window 11x11x1.5 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(779, 'TR058A0131', '41021088', 'CHRISTMAS STENCILS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(780, 'MF059A0221', 'RMFD00500350002', 'Parsley Dried Flakes - Mc Cormick - 150 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(781, 'MF059A0222', 'RMPK00400110019', '2018RB Xmas Box Base 9x9x3 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(782, 'TR058A0132', '12031001', 'CINNAMON POWDER (1 KG / PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(783, 'MF059A0224', 'RMPK00400110020', '2018RB Xmas Box Base 9x9x5 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(784, 'MF059A0225', 'RMPK00400110021', '2018RB Xmas Box Base 9x9x7 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(785, 'MF059A0224', 'RMFD00500990005', 'Chili Powder - - KG', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 12, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(786, 'TR058A0133', '21061123', 'CLEAR CUP 12OZ LOCAL (50PC/20PK/ CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 20, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(787, 'MF059A0227', 'RMPK00400110022', '2018RB Xmas Box Base 11x11x3 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(788, 'MF059A0227', 'RMFD00501050001', 'Wasabi Paste - S&B - 43 G / Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(789, 'MF059A0228', 'RMPK00400110023', '2018RB Xmas Box Base 11x11x4 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(790, 'MF059A0230', 'RMPK00400110024', '2018RB Xmas Box Base 11x11x5 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(791, 'MF059A0230', 'RMFD00600020002', 'Baking Soda  - Queen - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(792, 'TR058A0134', '21061124', 'CLEAR CUP 16OZ LOCAL (50/PC/ 20PK/ CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 20, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(793, 'MF059A0231', 'RMPK00400110025', '2018RB Xmas Box Base 11x11x7.5 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(794, 'MF059A0233', 'RMFD00600020004', 'CMC Food Grade -- by KG', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 12, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(795, 'TR058A0135', '21061126', 'CLEAR LID 12/24 DOMED (50PC/ 20PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 20, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(796, 'MF059A0234', 'RMFD00600070002', 'Gelatin Powder Plain Unflavored - Shamrock - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(797, 'TR058A0136', '21061141', 'CLEAR LID 12OZ DOMED - FOR PAPER COLD CUPS (50PC/ 20PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 20, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(798, 'TR058A0137', '21061146', 'CLEAR LID 12OZ SLOTTED - FOR PAPER COLD CUPS (100PC/ 10PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 10, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(799, 'MF059A0235', 'RMFD00600070005', 'Gelatin Powder Green Unflavored - Carte D Or - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(800, 'TR058A0138', '21061125', 'CLEAR LID 12OZ SLOTTED (50PC/10PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 10, 1, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(801, 'TR058A0139', '21061144', 'CLEAR LID 16OZ DOME - FOR PAPER COLD CUPS (100PC/ 10PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 10, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(802, 'TR058A0140', '21061143', 'CLEAR LID 16OZ SLOTTED - FOR PAPER COLD CUPS (100PC/ 10PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 10, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(803, 'TR058A0141', '21061127', 'CLEAR LID DOMED 12/16OZ LOCAL (50PC/ PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 50, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(804, 'TR058A0142', '21061129', 'CLEAR LID DOMED 16OZ - FOR PAPER COLD CUPS (50PCS/20PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 20, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(805, 'MF059A0236', 'RMPK00400120001', '2018RB Bread Box Base 11x14x3 - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(807, 'TR058A0143', '21061290', 'CLEAR LID SLOTTED 12/16OZ- FOR PAPER COLD CUPS (100PC/ 10PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 10, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(808, 'TR058A0144', '21061134', 'CLEAR LID SLOTTED 12/16OZ LOCAL (100PCS/ PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 100, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(809, 'TR058A0145', '21061128', 'CLEAR LID SLOTTED 16OZ - FOR PAPER COLD CUPS (50PCS/20PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 20, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(810, 'TR058A0146', '41021089', 'CLEAR PLASTIC SPOON', 50, '1', '4', '15', '20', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(811, 'TR058A0147', '51011103', 'COCKTAIL STEMGLASS 44CL', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(812, 'TR058A0148', '10906218', 'COCOA POWDER BENSDORP (25KGS/BAG)', 50, '1', '4', '15', '25', 1, 1, 1, 25, 1, 25, 5, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(813, 'TR058A0149', '41021076', 'COFEE FILTER (KLGU318X7.5) (250PCS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 250, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(814, 'TR058A0150', '21051144', 'COFFEE CARRIER X2 (100 PCS/ PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 100, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(815, 'TR058A0151', '41021063', 'COFFEE FILTER (15X5.5) 71159 (250 PCS / 2 PACKS /', 50, '1', '4', '15', '25', 1, 1, 1, 1, 250, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(816, 'TR058A0152', '41021083', 'COFFEE FILTER FOR CART 90MM (1000PCS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1000, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(817, 'TR058A0153', '10841000', 'COFFEE JELLY (3.3 KG/ 4 JUG/ CS)', 50, '1', '4', '15', '25', 1, 1, 1, 3.6, 4, 25, 13, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(818, 'MF059A0238', 'RMFD00600110007', 'Oatmeal Quick-cooking - Australia Harvest - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(819, 'MF059A0239', 'RMPK00400120002', '2018RB Bread Box Cover 11x14x2 - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(820, 'MF059A0240', 'RMFD00600170003', 'Yeast Instant Dry - SAF Gold - 500 G - - by Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(821, 'MF059A0240', 'RMPK00400120003', '2018RB Xmas Box w/ Window 9x9x2 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(822, 'MF059A0242', 'RMFD00600210002', 'Bread Improver - Magimix Yellow - 500 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(823, 'MF059A0242', 'RMPK00400120004', '2018RB Xmas Box w/ Window 5x9x2 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 1, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(824, 'MF059A0244', 'RMFD00600230001', 'Rice Crispies  -  - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(825, 'MF059A0244', 'RMPK00400120005', '2018RB Xmas Box w/ Small Window 11x11x2.5 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(826, 'MF059A0245', 'RMFD00800020001', 'Basil Leaves Whole - Mc Cormick - 300 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(827, 'MF059A0246', 'RMPK00400120006', '2018RB Xmas Box w/ Small Window 11x11x1.5 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(828, 'MF059A0248', 'RMPK00400120007', '2018RB Xmas Box Cover w/ Small Window 9x9x1.5 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 1, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(829, 'MF059A0248', 'RMFD00800040016', 'Broth Powder Beef - Knorr - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(830, 'MF059A0250', 'RMFD00800040018', 'Broth Cubes Beef - Knorr - 60 G / 6pc / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(831, 'MF059A0250', 'RMPK00400120008', '2018 Xmas Bread Box Base 11x14x3 - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(832, 'MF059A0252', 'RMPK00400120009', '2018 Xmas Bread Box Cover 11x14x2 - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(833, 'MF059A0252', 'RMFD00800050001', 'Cinnamon Ground - Mc Cormick - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(834, 'MF059A0254', 'RMPK00400120010', '2020XMASDBL Box Base 9x9x7 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(835, 'MF059A0254', 'RMFD00800070001', 'Garlic Powder - Mc Cormick - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(836, 'MF059A0256', 'RMFD00800090001', 'Laurel Leaves  - LJ - 100 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(837, 'MF059A0256', 'RMPK00400120011', '2020XMASDBL Box Base 11x11x7.5 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(838, 'MF059A0258', 'RMFD00800100001', 'Nutmeg Ground - Mc Cormick - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(839, 'MF059A0258', 'RMPK00400120012', '2020XMASDBL Box Cover w/ Small Window 9x9x1.5 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(840, 'MF059A0260', 'RMFD00800110003', 'Onion Powder  - Mc Cormick - 1000 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(841, 'MF059A0260', 'RMPK00400120013', '2020XMASDBL Box Cover w/ Small Window 11x11x2.5 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(842, 'MF059A0262', 'RMPK00500020003', 'Bottle Lid For 8oz Gold -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(843, 'MF059A0262', 'RMFD00800120001', 'Oregano Leaves Ground - Mc Cormick - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(844, 'MF059A0264', 'RMPK00700010003', 'Plastic Bag PE 5x8 IN -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(845, 'MF059A0264', 'RMFD00800130001', 'Paprika Spanish - Mc Cormick - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(846, 'MF059A0266', 'RMPK00700010004', 'Plastic Bag PE 9x14 IN -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(847, 'MF059A0266', 'RMFD00800140001', 'Pepper Black Ground - Mc Cormick - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(848, 'MF059A0267', 'RMPK00700010008', 'Plastic Bag PP 11x13 IN -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(849, 'MF059A0269', 'RMFD00800140002', 'Pepper Red Cayenne - Mc Cormick - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(850, 'MF059A0269', 'RMPK00700010013', 'Plastic Bag PE Laminated Nylon 150mm x 150mm -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(851, 'MF059A0271', 'RMFD00800140004', 'Pepper Red Crushed - Mc Cormick - 500 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(852, 'MF059A0271', 'RMPK00700010014', 'Plastic Bag PE Laminated Nylon 250mm x 360mm -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(853, 'TR058A0154', '21041006', 'COFFEE SLEEVES - NON WOVEN 12OZ (500PC/ PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 500, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(854, 'MF059A0272', 'RMFD00800140007', 'Pepper Black Whole - McCormick - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(855, 'MF059A0274', 'RMFD00800140011', 'Pepper Black Ground - UFC - 500 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(856, 'MF059A0273', 'RMPK00700010015', 'Plastic Bag PE Laminated Nylon 150mm x 180mm -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(857, 'TR058A0155', '21041005', 'COFFEE SLEEVES - NON WOVEN 8OZ (500PC/ PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 500, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(858, 'MF059A0276', 'RMPK00700010017', 'Plastic Bag PE Laminated Nylon 190mm x330mm -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(859, 'TR058A0156', '21041007', 'COFFEE SLEEVES - NON WOWEN 16OZ (500PC/ PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 500, 1, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(860, 'MF059A0276', 'RMFD00800140012', 'Chinese Five Spice - McCormick - 30 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(861, 'MF059A0277', 'RMPK00700010018', 'Plastic Bag PE Laminated Nylon 190mm x 270mm -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(862, 'TR058A0157', '21051491', 'COFFEE SLEEVES-NON WOVEN 12OZ [80 YRS] (500PC/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 500, 1, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(863, 'MF059A0279', 'RMPK00700010019', 'Plastic Bag HD 5x10 IN -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(864, 'MF059A0279', 'RMFD01100100001', 'Steak Sauce  - A1 - 10 OZ / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(865, 'TR058A0158', '21051496', 'COFFEE SLEEVES-NON WOVEN 16OZ [80 YRS] (500PC/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 500, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(866, 'MF059A0281', 'RMFD01100140013', 'Vinegar Apple Cider - Heinz - 946 ML / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(867, 'MF059A0281', 'RMPK00700010025', 'Plastic Bag HDPE/ LLDPE 26x38x0.0008 IN -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(868, 'TR058A0159', '21051490', 'COFFEE SLEEVES-NON WOVEN 8OZ [80 YRS] (500PC/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 500, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(869, 'TR058A0160', '10906205', 'COLATTA BLUEBERRY VIOLET CHOCOART  (50GMS/BTL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(870, 'MF059A0283', 'RMFD01100150001', 'Worcestershire Sauce  - Lea & Perrins - 1 Gal / Container', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 28, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(871, 'MF059A0283', 'RMPK00700010029', 'Plastic Bag PE  9x15x0.002 IN -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(872, 'MF059A0285', 'RMPK00700010033', 'Plastic Bag PE 9x11x0.001 IN -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(873, 'MF059A0285', 'RMFD01100150002', 'Worcestershire Sauce  - Lea & Perrins - 150 ML / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(874, 'MF059A0287', 'RMFD01400010005', 'Glucose Pure - Peotraco - 750 G / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(875, 'MF059A0287', 'RMPK00700010034', 'Plastic Bag PE Transparent Plain 37x40x0.0008 IN -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(876, 'MF059A0289', 'RMFD01400020002', 'Honey  - Shamrock - 750 ML / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(877, 'MF059A0289', 'RMPK00700010035', 'Plastic Bag PE 5x5 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(878, 'MF059A0291', 'RMFD01700010001', 'Flavoring Banana - Twin Sisters - 20 ML / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(879, 'MF059A0292', 'RMFD01700010002', 'Flavoring Lemon - Neco - 946 ML / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(880, 'MF059A0293', 'RMFD01700010011', 'Flavoring Smoke -  - 1 KG / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(881, 'MF059A0292', 'RMPK00700010036', 'Plastic Bag PE 11x15 with bottom gusset - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(882, 'MF059A0294', 'RMFD01700010018', 'Flavoring Pandan - Handyware - 1KG / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(883, 'MF059A0296', 'RMPK00700010039', 'Plastic Bag PE Laminated Nylon 130mm x 400mm - -by piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(884, 'MF059A0296', 'RMFD01700010020', 'Flavoring Pistachio - NFH - 1 KG / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(885, 'TR058A0161', '10906244', 'COLATTA CHOCO CRUNCH GLAZE (5KGS/PAIL)', 50, '1', '4', '15', '25', 1, 1, 1, 5, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(886, 'MF059A0298', 'RMPK00700010040', 'Plastic Bag PE Laminated Nylon 130mm x 400mm x 115 mic- -by piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(887, 'TR058A0162', '10902213', 'COLLATA CHOCO ART - BRIGHT BLUE (50GMS/BOT)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(888, 'MF059A0298', 'RMFD01700010021', 'Flavoring Almond - Mc Cormick - 20 ML / Bottle ', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(889, 'TR058A0163', '10902214', 'COLLATA CHOCO ART- EGG YELLOW (50G/BTL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(890, 'MF059A0300', 'RMPK00700010043', 'Plastic Bag PE 11x15x0.002 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(891, 'MF059A0300', 'RMFD01700010024', 'Flavor Milk Condensed Paste - KH 5966 - 5 KG / Container', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 28, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(892, 'TR058A0164', '10902226', 'COLLATA CHOCO ART- HALLOWEEN BLACK (50G/BTL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 1, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(893, 'MF059A0302', 'RMPK00700020004', 'Sando Bag With Logo XXLarge -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(894, 'MF059A0302', 'RMFD01700020003', 'Food Color Red - Ferna Liquid - 30 ML / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(895, 'MF059A0304', 'RMFD01700020007', 'Food Color Green - Ferna Liquid - 30 ML / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(896, 'TR058A0165', '10902225', 'COLLATA CHOCO ART- LEMON YELLOW (50G/BTL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(897, 'TR058A0166', '12031137', 'COLLATA CHOCO ART-CHERRY RED  (50G/BTL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(898, 'MF059A0305', 'RMFD01700020009', 'Flavorade Ube  - Bakersfield - 500g / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(899, 'TR058A0167', '12031139', 'COLLATA CHOCO ART-LIME GREEN (50G/BTL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(900, 'MF059A0306', 'RMFD01700040001', 'Syrup Chocolate - Hershey`s - 650 G / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(901, 'MF059A0307', 'RMPK00700020005', 'Sando Bag With Logo Large -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(902, 'MF059A0307', 'RMFD01700040015', 'Syrup Maple - Home Brand - 709 ML / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(903, 'TR058A0168', '10906220', 'COLLATA GLAZE TIRAMISU (5KGS/PAIL)', 50, '1', '4', '15', '25', 1, 1, 1, 5, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(904, 'MF059A0308', 'RMPK00700020006', 'Sando Bag With Logo Medium -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(905, 'MF059A0310', 'RMPK00700020007', 'Sando Bag With Logo Tiny -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(906, 'TR058A0169', '10906191', 'COLLATA STRAWBERRY COMPOUND GLAZE  (5KG/4PAIL/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 5, 4, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(907, 'MF059A0309', 'RMFD01700040016', 'Strawberry Fraise Fruit Mix - Monin - 1L / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(908, 'TR058A0170', '10906190', 'COLLATA WHITE COMPOUND GLAZE (5KG/4PAIL/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 5, 4, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(909, 'MF059A0311', 'RMPK00700020008', 'Sando Bag With Logo 11+9 -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(910, 'MF059A0312', 'RMFD01700040017', 'Raspberry Fruit Mix - Monin - 1L / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(911, 'MF059A0313', 'RMPK00700020009', 'Sando Bag Clear Tiny -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 1, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(912, 'TR058A0171', '41041016', 'COMMENT CARDS (1000 PCS / PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1000, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(913, 'MF059A0314', 'RMFD01700040018', 'Syrup Blueberry Myrtille - Monin - 700 ML / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(914, 'MF059A0315', 'RMPK00700020010', 'Sando Bag Clear Medium -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 11, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(915, 'TR058A0172', '12031080', 'COOKIE BISCOTTI AMRTA CREAMY (9LBS/PACK/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(916, 'MF059A0317', 'RMPK00700020011', 'Sando Bag Clear Large -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(917, 'MF059A0318', 'RMPK00800010001', 'Cup White 12 OZ -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(918, 'MF059A0318', 'RMFD01800030004', 'Liver Spread  - CDO - 85 G / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(919, 'MF059A0320', 'RMPK00800010008', 'Disposable  Cup  Paper Coated 16 oz -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(920, 'MF059A0320', 'RMFD01800030007', 'Liver Spread  - Argentina - 85 G / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(921, 'TR058A0173', '41021198', 'COOPER 24-HOUR ELECTRONIC TIMER/CLOCK/STOPWATCH', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(922, 'MF059A0321', 'RMPK00800010009', 'Disposable  Cup  Paper Coated 8 oz -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(923, 'MF059A0323', 'RMFD02000050005', 'Brandy Cherry - Cherie - 700 ML / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(924, 'MF059A0323', 'RMPK00800010014', 'Disposable Paper Cup 16 oz - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(925, 'MF059A0325', 'RMFD02000090004', 'Wine Rice Wine - La Esperanza - 750 ML / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(926, 'MF059A0325', 'RMPK00800010017', 'Disposable Cup Plastic PP 16 oz -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(927, 'TR058A0174', '41021197', 'COOPER INFRARED W/ PROBE THERMOMETER,  -27/48  F/C', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(928, 'MF059A0327', 'RMPK00800020004', 'Cup Lid For 12oz with Hole -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(929, 'MF059A0327', 'RMFD02000090008', 'Liqueur Kahlua - Licor Delicioso - 700 ML / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(930, 'MF059A0328', 'RMPK00800020005', 'Disposable Cup Lid Clear Dome -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(931, 'TR058A0175', '41021196', 'COOPER POCKET TEST  THERMOMETER  0-220 F', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(932, 'MF059A0330', 'RMFD02000090016', 'Whisky 69 Proof - White Castle - 700 mL / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(933, 'MF059A0330', 'RMPK00800020006', 'Disposable Cup Lid Clear Flat -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(934, 'TR058A0176', '10411007', 'CORMAN BUTTER (2KG/5BAR/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 2, 1, 25, 15, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(935, 'MF059A0332', 'RMFD02000090017', 'Wine Rice Wine - Shao Xing - 750ml / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(936, 'MF059A0332', 'RMPK00800020012', 'Disposable Cup Lid Clear Flat for Paper Cup 16 oz -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(937, 'MF059A0334', 'RMFD03000000007', 'Passion Fruit Filling 50% - DLA Lafruta - 610 G / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(938, 'MF059A0334', 'RMPK00800080020', 'Plastic Container Clamshell 9x3IN - - by Piece ', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(939, 'TR058A0177', '11021015', 'CORN STARCH (1KG/25PK/SACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 25, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(940, 'MF059A0336', 'RMBV00400010004', 'Beans White - Kayumanggi - 340 G / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(941, 'TR058A0178', '10721014', 'CORN SYRUP (1000ML/12BOTTLE/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 12, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(942, 'MF059A0337', 'RMBV00400030003', 'Kaong Green - Kayumanggi - 340 G / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(943, 'MF059A0338', 'RMBV00400050001', 'Macapuno String - Kayumanggi - 907 G / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(944, 'MF059A0339', 'RMBV00400070004', 'Nata de Coco Green - Kayumanggi - 340 G / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(945, 'TR058A0179', '21051628', 'CORRUGATED COFFEE SLEEVES  12/16OZ  (100PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 100, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(946, 'TR058A0180', '21051627', 'CORRUGATED COFFEE SLEEVES 8OZ (100PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 100, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(947, 'MF059A0339', 'RMPK00900010162', 'Product Label Regular 2014 Contis Logo -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(949, 'TR058A0182', '41021069', 'COUPLER - SMALL TIP', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(950, 'TR058A0183', '21051148', 'COURTESY PLAIN CUPS 6OZ (50 PCS/ 20 PK/ CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 20, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(951, 'MF059A0341', 'RMPK00900010201', 'Product Label for FRZ Buco Pandan Salad - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(952, 'MF059A0341', 'RMFD00500990003', 'Chili Paste Korean - Gochuchang - 1 KG / canister', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 36, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(953, 'MF059A0343', 'RMPK00900010202', '2017RB Product Label for Siomai- - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(955, 'MF059A0343', 'RMFD00700020036', 'Cheese Cheddar Spread - Magnolia Cheezee - 480 g / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(956, 'MF059A0346', 'RMFD00800010001', 'Bagoong Ginisa - Barrio Fiesta - 500 G / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(957, 'MF059A0347', 'RMFD00800100002', 'Cumin Seed Ground - Mc Cormick - 30 G / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(958, 'TR058A0184', '41021064', 'CREAM CHARGER (10 PCS / 60PACK/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 60, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(959, 'MF059A0348', 'RMFD00800140015', 'Pepper White Ground - Mc Cormick - 31 G / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(960, 'TR058A0185', '10421033', 'CREAM CHEESE - ANCHOR (1KG X 12BAR/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 12, 25, 15, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(961, 'MF059A0349', 'RMFD00800190002', 'Seasoning Liquid  - Knorr - 130 ML / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(962, 'TR058A0186', '10421028', 'CREAM CHEESE - ELLE&VIRE (1.36KG/10 BAR/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1.36, 10, 25, 15, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(963, 'MF059A0350', 'RMPK00900010203', '2017RB Product Label for Pork Tocino- - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(964, 'TR058A0187', '10906136', 'CREAM CHEESE ICING (45LB/PAIL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(965, 'MF059A0351', 'RMPK00900010205', '2017RB Product Label for Pineapple Macaroni Salad - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(966, 'MF059A0351', 'RMFD00800360001', 'Horseradish Sauce  - Frenchs - 340 G / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(967, 'TR058A0188', '10431002', 'CREAM WHIPPING ANCHOR 1L 12PACKS/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 12, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(968, 'MF059A0353', 'RMPK00900010206', '2017RB Product Label for Apple Potato Salad- - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(969, 'MF059A0353', 'RMFD00800360002', 'Horseradish Sauce  - Grey Poupon - 283 G / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(970, 'MF059A0355', 'RMPK00900010207', '2017RB Product Label for Bangus Belly Adobo 51x112mm- - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(971, 'MF059A0355', 'RMFD00900020004', 'Capers In Vinegar - Capri - 935 G / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(972, 'TR058A0189', '10906129', 'CREMFIL CLASSIC VANILLA FILLING (5KG/TUB)', 50, '1', '4', '15', '25', 1, 1, 1, 5, 1, 25, 22, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(973, 'MF059A0357', 'RMFD00900060001', 'Garbanzos  - Ram - 450 G / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(974, 'MF059A0358', 'RMFD00900070002', 'Grass Jelly  - Heaven & Earth - 540 G / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(975, 'TR058A0190', '10906225', 'CREMFIL DULCE DE LECHE (5KGS/PAIL)', 50, '1', '4', '15', '25', 1, 1, 1, 5, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(976, 'MF059A0359', 'RMFD00900100003', 'Olives Green with Pimiento - Capri - 935 G / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(977, 'MF059A0359', 'RMPK00900010208', '2017RB Product Label for Beef Caldereta- - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(978, 'MF059A0361', 'RMFD00900110004', 'Peach Fruit Mix - Monin - 1L / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(979, 'TR058A0191', '10906148', 'CREMFIL ULTIM CHOCOLATE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(980, 'MF059A0361', 'RMPK00900010212', '2017RB Product Label for Chicken Potato Salad- - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(981, 'MF059A0362', 'RMFD00900120004', 'Pickle Chips  - Ram - 270 G / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(982, 'TR058A0192', '10908137', 'CREMYVIT CUSTARD POWDER (1KG/10PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(983, 'MF059A0364', 'RMPK00900010213', '2017RB Product Label for Roast Beef- - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(984, 'MF059A0365', 'RMPK00900010214', '2017RB Product Label for Rellenong Bangus- - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(985, 'MF059A0365', 'RMFD01100010003', 'Catsup Tomato - Heinz - 300 G / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(986, 'TR058A0193', '12031177', 'CRUSHED ALMOND ROCA (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(987, 'TR058A0194', '12031109', 'CRYSTALLINE CLEAR MIRROR GLAZE (4KGS/PAIL)', 50, '1', '4', '15', '25', 1, 1, 1, 4, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(988, 'MF059A0367', 'RMFD01100010007', 'Catsup Tomato - Del Monte - 320 G / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(989, 'MF059A0368', 'RMFD01100030001', 'Hoisin Sauce  - Lee Kum Kee - 2.268 KG / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(990, 'TR058A0195', '10906121', 'CUSTARD FLAVORED FILLING - LT (8LB/6PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(991, 'MF059A0369', 'RMFD01100040007', 'Honmirin Sauce  - Kinmikan - 1.8 L / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(992, 'TR058A0196', '41041091', 'DAILY TRIP REPORT FORM (3 PLY/ 50 SET / PAD)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(993, 'MF059A0370', 'RMFD01100050001', 'Hot Sauce  - Tabasco - 60 ML / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(994, 'TR058A0197', '10813001', 'DARK CHOCO SAUCE (1.89L/ BT)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(995, 'MF059A0371', 'RMFD01100050002', 'Hot Sauce  - UFC - 100 G / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(996, 'MF059A0372', 'RMFD01100060012', 'Olives Black Sliced - Sansur - 920 G / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(997, 'MF059A0373', 'RMFD01100060015', 'Olive Oil Extra Virgin Ybarra 5L / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(998, 'MF059A0374', 'RMFD01100060016', 'Olive Oil Extra Virgin - Molinera - 5 L / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(999, 'MF059A0375', 'RMFD01100080001', 'Sesame Oil  - Yuen Yick - 750 ML / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1000, 'MF059A0376', 'RMPK00900010215', '2017RB Product Label for Russian Potato Salad - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1001, 'MF059A0376', 'RMFD01100090001', 'Soy Sauce  - Kikkoman - 1 L / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1002, 'TR058A0198', '10901163', 'DARK CHOCOLATE COMPOUND ELMER (1KG/12BLKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 1, 7, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1003, 'MF059A0378', 'RMPK00900010217', '2017RB Product Label for Raisin Crisps - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1004, 'MF059A0379', 'RMPK00900010219', '2017RB Product Label for FRZ Baked Mac- by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1005, 'TR058A0199', '10813006', 'DAVINCI GOURMET FLAVOUR MAXX  (1L/4JUGS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 1, 13, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1006, 'MF059A0380', 'RMPK00900010221', '2017RB Product Label for Dinner Roll- by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1007, 'TR058A0200', '10813004', 'DAVINCI GOURMET SHORTBREAD SYRUP (750ML/12BTLS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 12, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1008, 'MF059A0381', 'RMPK00900010222', '2017RB Product Label for Crab Salad- by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1009, 'MF059A0382', 'RMPK00900010225', '2017RB Product Label for Choco Oatmeal Cookies- by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1010, 'TR058A0201', '10813005', 'DAVINCI GOURMET WHITE CHOCOLATE SAUCE (2L/3JUGS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 13, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1011, 'TR058A0202', '21011039', 'DECORATING TIP #1 (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1012, 'MF059A0383', 'RMPK00900010226', '2017RB Product Label for Choco Chips Cookies- by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1013, 'MF059A0383', 'RMFD00600130009', 'Pudding Chocolate - Jell-O - 110 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1014, 'MF059A0385', 'RMPK00900010228', '2017RB Product Label for Chicken Salad Spread 44x70mm- by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1015, 'MF059A0385', 'RMFD00600130008', 'Pudding Chocolate - Jell-O - 167 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1016, 'MF059A0386', 'RMPK00900010229', '2017RB Product Label for Salmone Speziato- by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1017, 'MF059A0387', 'RMFD00600130004', 'Pudding Vanilla - Jell-O - 793 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1018, 'TR058A0203', '21011046', 'DECORATING TIP #10 (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1019, 'MF059A0389', 'RMFD00600130006', 'Pudding Vanilla - Jell-O - 96 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1020, 'MF059A0390', 'RMPK00900010230', '2017RB Product Label for Salmone Pomodoro- by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1021, 'TR058A0204', '21011043', 'DECORATING TIP #19 (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1022, 'MF059A0391', 'RMFD01600010025', 'Pudding Vanilla - EK BX228 - 2 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1023, 'MF059A0391', 'RMPK00900010231', '2017RB Product Label for Oatmeal Cookies- by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1024, 'TR058A0205', '21011040', 'DECORATING TIP #2 (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1025, 'MF059A0392', 'RMFD00600130007', 'Pudding Vanilla - Jell-O - 144  G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1026, 'MF059A0394', 'RMPK00900010233', '2017RB Product Label for Mango Royale Dressing- by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1027, 'MF059A0394', 'RMFD00600130002', 'Pudding Chocolate - Jell-O - 793 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1028, 'MF059A0396', 'RMFD01000010043', 'Noodle Canneloni - Barilla - 250 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1029, 'MF059A0397', 'RMFD01000010031', 'Noodles Lasagna - Catelli - 500 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1030, 'MF059A0398', 'RMFD01000010006', 'Noodles Efuven - Rainbow Brand - 250 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1031, 'TR058A0206', '21011044', 'DECORATING TIP #22 (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1032, 'MF059A0399', 'RMFD01000010042', 'Noodle Canneloni - Divella - 250 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1033, 'TR058A0207', '21011041', 'DECORATING TIP #3 (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1034, 'MF059A0400', 'RMFD01000010039', 'Noodles Bihon Rice - Good Life - 200 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1035, 'MF059A0400', 'RMPK00900010235', '2017RB Product Label for Lengua Estofado- by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1036, 'TR058A0208', '21011045', 'DECORATING TIP #44 (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1037, 'TR058A0209', '21011042', 'DECORATING TIP #8 (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1038, 'MF059A0402', 'RMPK00900010236', '2017RB Product Label for Lengua de Gato- by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1039, 'MF059A0402', 'RMFD00500510005', 'Tomato Whole Peeled - Dolce Vita - 2500 G / can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1040, 'MF059A0404', 'RMPK00900010237', '2017RB Product Label for Lasagna- by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1041, 'TR058A0210', '21011047', 'DECORATING TIP #849 (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1042, 'MF059A0404', 'RMFD01700030005', 'Coldgeli Glazed Neutral - Coldgeli - 7 KG / Tub', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 22, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1043, 'MF059A0406', NULL, 'Tropical Fruit Cocktail - Dole - 822 G / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1044, 'TR058A0211', '21011038', 'DECORATING TIP (1 PCS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1045, 'MF059A0407', 'RMFD01800070001', 'Pie Filling Blueberry - Comstock - 595 G / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1046, 'MF059A0407', 'RMPK00900010238', '2017RB Product Label for Hamonado Longganisa -by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1047, 'TR058A0212', '12031116', 'DECORATION MISC LIGHTNING BLT SYN (300PCS/10BOX/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1048, 'MF059A0409', 'RMFD01800070002', 'Pie Filling Strawberry - Comstock - 595 G / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1049, 'MF059A0410', 'RMPK00900010240', '2017RB Product Label for FRZ Shanghai Rolls -by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1050, 'MF059A0410', 'RMFD03000000006', 'Pie Filling Blueberry - Pacifica - 3.3 KG / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1051, 'MF059A0412', 'RMPK00900010241', '2017RB Product Label for FRZ Seafood Chowder -by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1052, 'TR058A0213', '31011114', 'DELIMER (2 OZ/48 PACKETS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1053, 'MF059A0412', 'RMFD00600080001', 'Graham Crackers Crushed - M.Y. San - 200 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1054, 'TR058A0214', '41041035', 'DELIVERY RECEIPT FORMS ( 3PLY/500SET/CASE )', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1055, 'MF059A0414', 'RMPK00900010242', '2017RB Product Label for FRZ Salmon Head -by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1056, 'MF059A0414', 'RMFD00600060005', 'Cream of Tartar - Puratos - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1057, 'TR058A0215', '41041025', 'DELIVERY RETURN RECEIPT (3 PLY/ 50 SET/ PAD)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1058, 'MF059A0415', 'RMPK00900010244', '2017RB Product Label for FRZ BBQ Spareribs -by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1059, 'MF059A0416', 'RMFD00600080004', 'Graham Crackers Crushed - M.Y. San - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1060, 'TR058A0216', '10906206', 'DEZAAN COCOA POWDER 350DP-11', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 12, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1061, 'TR058A0217', '10906207', 'DEZAAN COCOA POWDER 500DP-11', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 12, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1062, 'MF059A0418', 'RMFD00600240001', 'Biscoff Cookie - Lotus - 250 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1063, 'TR058A0218', '12031153', 'DGF CHOCOLATE MICRO SHAVINGS (2KGS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1064, 'MF059A0419', 'RMFD01400020003', 'Granola Honey - Nestle Fitness - 300 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1065, 'MF059A0419', 'RMPK00900010245', '2017RB Product Label for FRZ Beef Tapa -by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1066, 'MF059A0421', 'RMFD00600080005', 'Graham Crackers Honey - M.Y. San - 700 G / Tub', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 22, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1067, 'MF059A0421', 'RMPK00900010247', '2017RB Product Label for FRZ Callos -by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1068, 'TR058A0219', '12031016', 'DIAMOND GLAZE SILVER  (5 KGS/PAIL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1069, 'MF059A0423', 'RMPK00900010249', '2017RB Product Label for FRZ Chicken Tocino -by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1070, 'MF059A0423', 'RMFD01100120001', 'Tomato Sauce  - Del Monte - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1071, 'MF059A0424', 'RMPK00900010250', '2017RB Product Label for FRZ Embotido -by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1072, 'TR058A0220', '12031026', 'DIAMOND GLAZE WHITE  (5 KGS/PAIL)', 50, '1', '4', '15', '25', 1, 1, 1, 5, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1073, 'MF059A0426', 'RMPK00900010251', '2017RB Product Label for FRZ Laing -by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1074, 'MF059A0427', 'RMPK00900010252', '2017RB Product Label for FRZ Molo Soup -by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1075, 'MF059A0428', 'RMFD00700030003', 'Coconut Cream  - Kara - 1 L / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1076, 'MF059A0428', 'RMPK00900010253', '2017RB Product Label for FRZ Moms Garlic Longganisa -by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1077, 'MF059A0430', 'RMFD00800380001', 'Coconut Cream Powder  - Kara - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1078, 'MF059A0430', 'RMPK00900010254', '2017RB Product Label for Tuna Salad Spread 44x70mm -by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1079, 'MF059A0432', 'RMFD00700090002', 'Milk Condensed  - Nestle Carnation - 300 ML / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1080, 'MF059A0433', 'RMFD00700050021', 'Milk Condensed - Milkmaid - 388 G / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1081, 'MF059A0433', 'RMPK00900010256', '2017RB Product Label for  Salmon Belly in Olive Oil -by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1082, 'MF059A0435', 'RMPK00900010258', '2017RB Product Label for  Pesto Sauce 200g  44x70mm-by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1083, 'MF059A0434', 'RMFD00700050016', 'Milk Skimmed - Harvey Fresh  - 1 L (900 G) / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1084, 'MF059A0437', 'RMPK00900010260', '2017RB Product Label for Almondine Cookies-by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1085, 'MF059A0438', 'RMPK00900010263', 'Product Label for FRZ Ham Roll - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1086, 'MF059A0439', 'RMPK00900010264', '2018 RB Xmas Product Label for Dinner Rolls 44x70mm - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1087, 'MF059A0440', 'RMPK00900010265', '2018 RB Xmas Product Label for  Almondine Cookies 44x70mm -  - by Piece  ', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1088, 'MF059A0441', 'RMPK00900010266', '2018RB Xmas Product Label For Choco Chips Cookies 44x70mm - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1089, 'MF059A0442', 'RMPK00900010267', '2018RB Xmas Product Label for Choco Oatmeal Cookies 44x70mm - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1091, 'TR058A0221', '21011084', 'DISPENSER FOR ESTAPE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1092, 'TR058A0222', '41021050', 'DISPOSABLE FACE MASK (100 PCS / PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1093, 'MF059A0444', 'RMPK00900010268', '2018RB Xmas Product Label for Oatmeal Cookies 44x70mm - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1094, 'MF059A0445', 'RMPK00900010269', '2018RB Xmas Product Label for Lengua de Gato 44x70mm  - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1095, 'TR058A0223', '41021051', 'DISPOSABLE HEAD CAP (100 PCS / PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1096, 'MF059A0446', 'RMPK00900010271', 'Product Label - Cashew Snowballs - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1097, 'MF059A0447', 'RMPK00900010272', 'Product Label - Cranberry Cookies - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1098, 'MF059A0448', 'RMPK00900010273', '2019 Xmas Product Label - Cashew Snowballs - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1099, 'MF059A0449', 'RMPK00900010274', '2019 Xmas Product Label - Cranberry Cookies - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1100, 'TR058A0224', '21061157', 'DOME LID FOR KK DOUGHNUT HOLES CUP (50PCS/20PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 20, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1101, 'TR058A0225', '10813000', 'DOUBLE CHCOLTE CHLER SYRP (64OZ/4BT/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 4, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1102, 'TR058A0226', '12031000', 'DOUGHNUT COATING - LOCAL (1KG/ PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1103, 'TR058A0227', '10832018', 'DR.PEPPER REGULAR  7.5 OZ (24CAN/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 7.5, 1, 25, 8, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1104, 'TR058A0228', '12031171', 'DRAGEES, 3MM - GOLD (500G/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1105, 'TR058A0229', '12031027', 'EDIBLE BUTTON, BLACK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1106, 'MF059A0450', 'RMPK00900010275', 'Product Label for FRZ Beef Tapa 72mmx105mm - -by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1107, 'TR058A0230', '12031105', 'EDIBLE GLITTER DUST-GOLD (5GRAMS/BTL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1108, 'MF059A0451', 'RMPK00900010276', 'Product Label for FRZ Chicken Terriyaki 72mmx105mm - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1109, 'TR058A0231', '12031168', 'EDIBLE GLITTER, DISCO DUST (5G/BTL) - RED', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1110, 'TR058A0232', '12031195', 'EDIBLE GOLD DUST 3G/BOT', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1111, 'TR058A0233', '12031126', 'EGG WHITE POWDER  (500GRAMS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1112, 'MF059A0452', 'RMFD00700050025', 'Milk Full Cream UHT - Anchor - 1 L / Tetra', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1113, 'TR058AE0234', '12031173', 'EGGNOG COOKIES (130G/20PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1114, 'TR058A0235', '10906249', 'ELMER DIP DONUT BANANA (3KGS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 3, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1115, 'TR058A0236', '10906251', 'ELMER DIP DONUT MELON (3KGS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 3, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1116, 'TR058A0237', '10906250', 'ELMER DIP DONUT ORANGE (3KGS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 3, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1117, 'TR058A0238', '10906232', 'ELMER GREEN TEA COMPOUND (1KG/12BLOCKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 12, 25, 7, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1118, 'TR058A0239', '12031056', 'EMOTICON-DOUGHNUT SPRINKLES   (250PCS/BOX)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 250, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1119, 'TR058A0240', '12031050', 'EMOTICON-KISSES  (250PCS/BOX)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 250, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1120, 'TR058A0241', '12031051', 'EMOTICON-LOVE AT FIRST SIGHT  (250PCS/BOX)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 250, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1121, 'MF059A0453', 'RMFD00700050022', 'Milk Powdered Full Cream - Birch Tree - 700 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1122, 'TR058A0242', '12031052', 'EMOTICON-SMILEY  (250PCS/BOX)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 250, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1123, 'MF059A0454', 'RMFD01100140012', 'Vinegar Red Cane - Del Monte -490 ML  / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1124, 'TR058A0243', '41031022', 'EPSON ERC-38 RIBBON FULL MARK (1PIECE)', 50, '1', '4', '`15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1125, 'MF059A0455', 'RMPK00900010277', 'Product Label for FRZ Grilled Chicken Terriyaki 72mmx105mm - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1126, 'MF059A0455', 'RMFD01800040003', 'Mayonnaise  - Lady`s Choice - 5.5L - 2 Gal / Case', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1127, 'TR058A0244', '10852008', 'ESPRESSO ROAST (NEW PKG) (500GM/20PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1128, 'MF059A0457', 'RMPK00900010278', 'Product Label for FRZ Chicken BBQ 72mmx105mm - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1129, 'TR058A0245', '21061311', 'ESTAPE MEDIUM APPROXIMATE 800PCS/ROLL', 50, '1', '4', '15', '25', 1, 1, 1, 1, 800, 25, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1130, 'MF059A0457', 'RMFD00900170002', 'Tuna Chunks In Water - Century Tuna - 1.705 KG / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1131, 'TR058A0246', '10818005', 'EVIAN WATER (500ML/24BOT/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1132, 'MF059A0459', 'RMPK00900010279', 'Product Label for FRZ Pork Binagoongan 72mmx105mm - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1133, 'TR058A0247', '41031018', 'FILE CORRUGATED BOX', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1134, 'MF059A0459', 'RMFD00900170001', 'Tuna Chunks In Oil - Century Tuna - 1.705 KG / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1135, 'MF059A0461', 'RMPK00900010280', 'Product Label for FRZ Pork Steak 72mmx105mm - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1136, 'TR058A0248', '10906223', 'FILLING - WILD BLUEBERRY TOPFIL (2.7KG/CAN)', 50, '1', '4', '15', '25', 1, 1, 1, 2.7, 1, 25, 14, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1137, 'MF059A0462', 'RMFD01100140009', 'Vinegar Red Cane - Del Monte - 95 cL / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1138, 'MF059A0462', 'RMPK00900010281', 'Product Label for FRZ Breaded Fish Fillet 72mmx105mm - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1139, 'TR058A0249', '41041033', 'FIXED ASSET TRANSFER SLIP (3 PLY/ 50 SET/ PAD)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1140, 'TR058A0250', '10906188', 'FLAVOR TIRAMISU CREME DI CMPND (10LBS/PACK/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1141, 'MF059A0464', 'RMPK00900010284', 'Product Label for FRZ Chicken Pie - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1142, 'MF059A0465', 'RMFD01800050003', 'Mustard Prepared - Mc Cormick - 3.4 KG / Tub', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 22, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1143, 'MF059A0465', 'RMPK00900010285', 'Product Label for FRZ Cheese Puff - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1144, 'MF059A0467', 'RMPK00900010287', 'Product Label for FM Leche Flan 8 x1.5 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1145, 'TR058A0251', '10902227', 'FLAVORADE UBE BAKERS FIELD 500G/12BOT/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 12, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1146, 'MF059A0468', 'RMPK00900010288', 'Product Label for Frozen Lengua Estofado LFO - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1147, 'MF059A0467', 'RMFD01400060001', 'Sugar Bianca DÃƒÆ’Ã‚Â©cor  - Bianca Powder - 10 KG / Carton', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 37, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1148, 'TR058A0252', '10906138', 'FLEURDE SEL SALT (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1149, 'MF059A0469', 'RMPK00900010289', 'Product Label for Frozen Callos LFO - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1150, 'TR058A0253', '41031019', 'FLYERS-GENERIC (500PC/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 500, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1151, 'MF059A0471', 'RMFD00800080003', 'Xanthan Gum - Generic - 25 KG / Bag', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 5, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1152, 'TR058A0254', '10902139', 'FOOD COLOR - BAKERS ROSE (1OZ/BOT)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1153, 'MF059A0471', 'RMPK00900010290', 'Product Label for Frozen Beef Caldereta LFO - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1154, 'TR058A0255', '10902141', 'FOOD COLOR - CHRISTMAS RED (1OZ/BOT)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1155, 'MF059A0473', 'RMFD00800080004', 'Xanthan Gum - Ziboxan F80 - 25 KG / Bag', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 5, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1156, 'MF059A0474', 'RMBV00200040004', 'Coffee Creamer - Coffeemate - 30 KG / Bag', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 5, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1157, 'MF059A0474', 'RMPK00900010291', 'Product Label for Frozen Roast Beef LFO - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1158, 'TR058A0256', '10902172', 'FOOD COLOR - CHRISTMAS RED (20OZ/BOTTLE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1159, 'MF059A0476', 'RMPK00900010292', 'Product Label for Frozen Siomai LFO - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1160, 'MF059A0476', 'RMFD00800300002', 'MSG Fine - Generic - 25 KG / Bag', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 5, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1161, 'TR058A0257', '10902138', 'FOOD COLOR - COAL BLACK (1OZ /BTL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1162, 'TR058A0258', '10902151', 'FOOD COLOR - COAL BLACK (20OZ/BOT)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1163, 'MF059A0478', 'RMPK00900010293', 'Product Label for Frozen Baked Macaroni LFO - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1164, 'TR058A0259', '10902155', 'FOOD COLOR - FOREST GREEN (1OZ / BOT )', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1165, 'MF059A0479', 'RMFD00600010004', 'Baking Powder  - Calumet - 14 KG / Bag', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 5, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1166, 'TR058A0260', '10902146', 'FOOD COLOR - GOLDEN YELLOW (1OZ/ BTL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1167, 'MF059A0480', 'RMFD01700020012', 'Flavorade Ube - Bakersfield - 4 KG / Gal', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 27, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1168, 'MF059A0480', 'RMPK00900010294', 'Product Label for Frozen Lasagna LFO - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1169, 'TR058A0261', '10902143', 'FOOD COLOR - LEAF GREEN (1OZ / BOT )', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1170, 'MF059A0482', 'RMFD01700010005', 'Flavoring Vanilla - Neco - 1 Gal / Container', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 28, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1171, 'TR058A0262', '10902152', 'FOOD COLOR - LEAF GREEN (20OZ/BOT)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1172, 'MF059A0483', 'RMFD00600070006', 'Gelatin Powder Plain Unflavored ÃƒÂ¢Ã¢â€šÂ¬Ã¢â‚¬Å“ Geltech ÃƒÂ¢Ã¢â€šÂ¬Ã¢â‚¬Å“ 20 KG / Bag', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 5, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1173, 'TR058A0263', '10902144', 'FOOD COLOR - LEMON YELLOW (1OZ/BOT)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1174, 'TR058A0264', '10902150', 'FOOD COLOR - RED RED (20OZ/BOT)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1175, 'MF059A0484', 'RMFD00500370002', 'Potato Flakes - IMCD 003 - 25 KG / Bag                  ', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 5, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1176, 'MF059A0484', 'RMPK00900010295', 'Product Label for LFO Beef Entrees - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1177, 'TR058A0265', '10902137', 'FOOD COLOR - RED RED {1OZ/BOT}', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1178, 'MF059A0486', 'RMFD01700040004', 'Syrup Light Corn - Shamrock - 4.8 KG / Container', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 28, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1179, 'TR058A0266', '10902154', 'FOOD COLOR - ROYAL BLUE (1OZ/BOT)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1180, 'MF059A0486', 'RMPK00900010296', 'Product Label for LFO Chicken & Pork Entrees - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1181, 'TR058A0267', '10902140', 'FOOD COLOR - SKY BLUE (1OZ/BOT)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1182, 'MF059A0487', 'RMFD01300030004', 'Cashew Nuts Split -  - 22.68 KG / Box ', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1183, 'MF059A0488', 'RMPK00900010297', 'Product Label for LFO Rice & Noodles  - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1184, 'TR058A0268', '10902142', 'FOOD COLOR - SUNSET ORANGE (1OZ / BOT )', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1185, 'TR058A0269', '10902148', 'FOOD COLOR - SUPER RED (1OZ/BOT)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1186, 'MF059A0490', 'RMFD01300030010', 'Cashew Nuts Chopped Half Toast - - 15 KG / Box', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1187, 'TR058A0270', '10902205', 'FOOD COLOR CHOCOART CARROT ORANGE, COLLATA 50GMS/BOTT', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1188, 'MF059A0491', 'RMFD00600050012', 'Cocoa Powder - JB 100 - 25 KG / Bag', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 5, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1189, 'TR058A0271', '10902168', 'FOOD COLOR YELLOW (2OZ/BOTTLE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1190, 'MF059A0491', 'RMPK00900010298', 'Product Label for LFO Great Appetizers - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1191, 'MF059A0492', 'RMFD00600050005', 'Cocoa Powder  - Bensdorp - 25 KG / Bag', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 5, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1192, 'TR058A0272', '12031102', 'FOOD COLOR, POWDER - STRAWBERRY RED (500GRAMS/TUMBLER)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 24, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1193, 'MF059A0494', 'RMFD00600050003', 'Cocoa Powder  - Hershey`s - 50 LBS / Sack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 9, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1194, 'MF059A0493', 'RMPK00900010299', 'Product Label for LFO Seafood Entrrees - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1195, 'TR058A0273', '10902162', 'FOOD COLOR-VIOLET (1OZ/BOT)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1196, 'TR058A0274', '51011035', 'FOOD TRAY - BROWN ( PIECE )', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1197, 'MF059A0496', 'RMFD00600050015', 'Cocoa Powder Alkalized - Indcresa PV5R S40 - 25 KG / Bag', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 5, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1198, 'MF059A0496', 'RMPK00900010300', 'Product Label for LFO Signature Pasta - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1199, 'MF059A0498', 'RMFD00600050013', 'Cocoa Powder Alkalized - Indcresa PV5RD - 25 KG / Bag', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 5, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1200, 'MF059A0498', 'RMPK00900010301', 'Product Label for LFO Salad & Vegetables - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1201, 'MF059A0500', 'RMFD01600010019', 'Cake Emulsifier - S-Mix II - 4 KG / Pail', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1202, 'MF059A0501', 'RMFD00600090001', 'Lard  -  - 6.8 KG / Container', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 28, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1203, 'MF059A0502', 'RMFD01600010013', 'Flour Cake Flour - Snowsilk - 25 KG / Sack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 9, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1204, 'MF059A0501', 'RMPK01000060005', 'Paper Box With Logo for HB 5.25x5.25x2.8 IN  -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1205, 'MF059A0503', 'RMFD01600010012', 'Flour Hard Wheat - Washington - 25 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1206, 'MF059A0505', 'RMPK01000060006', 'Paper Box With Logo for NB 6.75x5.75x2.5 IN -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1207, 'MF059A0505', 'RMFD01600010020', 'Flour Hard Wheat - Zeus - 25 KG / Bag', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 5, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1208, 'MF059A0507', 'RMPK01000060007', 'Paper Box With Logo for Lunch 5x9x3 IN -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1209, 'MF059A0507', 'RMFD01100130007', 'Palm Olein - Frymax - 17 KG / TIN', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 17, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1210, 'TR058A0275', '41021048', 'FOOD WRAP (15/ 15MIC/ 500M/ ROLL', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 1, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1211, 'MF059A0509', 'RMFD00600060002', 'Cream of Tartar  -  - 25 KG / Sack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 9, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1212, 'MF059A0509', 'RMPK01000060008', 'Paper Box Plain 4.5x9x2.5 IN w/ window - - by piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1213, 'MF059A0510', 'RMFD00600140002', 'Starch Modified - Frigex - 25 KG / Bag', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 5, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1214, 'TR058A0276', '41021081', 'FRESH EGG-SANITIZER PURAC FCC88(25KGS/GALLON)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 12, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1215, 'MF059A0511', 'RMPK01200040009', 'Wrapper Greaseproof 36 GSM 30x25 CM -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1216, 'MF059A0512', 'RMBV00100030002', 'Water Purified - Wilkins Pure - - 500ML / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1217, 'TR058A0277', '10441021', 'FRESH MILK 1000ML 12PACKS/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1218, 'MF059A0514', 'RMBV00100030003', 'Water Distilled - BAI - 500 mL / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1219, 'MF059A0514', 'RMPK01500040005', 'Paper Bag Brown w/o Handle 10.625x5.75x3.5 IN -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1220, 'MF059A0516', 'RMBV00100030005', 'Water Purified - Nature Spring - 500 ML / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1221, 'TR058A0278', '31021044', 'GARBAGE BAG CLEAR (100 PCS / PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 1, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1222, 'MF059A0516', 'RMPK01500050002', '2017RB Paperbag Brown Small with Logo 8x6x8 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1223, 'MF059A0517', 'RMFD00600210003', 'Bread Improver - Magimix Softness - 10 KG / Box', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1224, 'MF059A0519', 'RMFD00600030023', 'Chocolate Chips Dark Compound -  Callebaut - 10 KG / Box', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1225, 'MF059A0520', 'RMFD01400040002', 'Sugar Powdered - Peotraco - 5 LBS / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1226, 'TR058A0279', '31021045', 'GARBAGE BAG CLEAR SMALL (100 PCS/ PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 1, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1227, 'MF059A0521', 'RMFD01400040023', 'Sugar Powdered -SugarBoy - 5 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1228, 'TR058A0280', '41041027', 'GATE PASS (2 PLY/ 50 SET/ PAD)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1229, 'MF059A0522', 'RMFD00600160001', 'Whipped Topping Powder  - Bakels Whip-Brite - 750 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1230, 'TR058A0281', '10815000', 'GATORADE -  BBOLT  (500ML/24BT/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1231, 'MF059A0523', 'RMFD01600010021', 'Flour All Purpose - Hercules - 25 KG / Bag', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 5, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1232, 'TR058A0282', '10815001', 'GATORADE - ASSTD (24BOT/ CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1233, 'MF059A0523', 'RMPK01500050003', '2017RB Paperbag Brown Medium with Logo 10X6x9 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1234, 'MF059A0524', 'RMFD01600010011', 'Flour All Purpose - Family - 25 KG / Sack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 9, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1235, 'TR058A0283', '12031063', 'GEL SOLDIFIER CORN (5LB/TUB)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1236, 'TR058A0284', '12031122', 'GHIRARDELLI CHOCOLATE FRAPPE  (1.42KG/6CAN/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1.42, 1, 25, 14, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1237, 'MF059A0526', 'RMFD00600120017', 'Pre-mix Choco Fudge - Brownie - 18 KG / Box', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1238, 'TR058A0285', '12031066', 'GHIRARDELLI DARK MINI CHIPS (10LBS/BOX)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1239, 'MF059A0526', 'RMPK01500050004', '2018RB Xmas Paper Bag with Handle - White 10x6x9 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1240, 'MF059A0527', 'RMFD00600120018', 'Pre-mix Butter Scotch Brownie -  - 18 KG / Box', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1241, 'MF059A0529', 'RMPK01500050005', '2018RB Xmas Paper Bag with Handle - White 8x6x8 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1242, 'MF059A0529', 'RMFD00600180005', 'Shortening Emulsified - Rotitex - 20 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1243, 'TR058A0286', '41031021', 'GIFT CERTIFICATE ENVELOPE (10PCS/BUNDLE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1244, 'MF059A0531', 'RMFD01300040002', 'Peanut Skinless -  - 25 KG / Sack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 9, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1245, 'MF059A0532', 'RMFD01400040020', 'Sugar Refined White -  - 50 KG / Sack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 9, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1246, 'TR058A0287', '61041011', 'GILDAN - ORIGINAL ARMY GREEN SHIRTS - MALE L', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1247, 'MF059A0533', 'RMFD00600160002', 'Whipped Topping Powder  - Bakels Whip-Brite - 12 KG / Pail', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1248, 'TR058A0288', '61041010', 'GILDAN - ORIGINAL ARMY GREEN SHIRTS - MALE M', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1249, 'MF059A0534', 'RMFD01300080019', 'Rice For Staff - Ann Yellow - 25 KG / Sack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 9, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1250, 'MF059A0535', 'RMDC00500010008', 'Cake Topper - HBD Balloon - - 10 Piece / Box', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1251, 'TR058A0289', '61041009', 'GILDAN - ORIGINAL ARMY GREEN SHIRTS - MALE S', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1252, 'MF059A0536', 'RMPK01500050006', '2018RB Xmas Paper Bag w/o  Handle - White 5.87x3.5x10.75 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1253, 'TR058A0290', '61041012', 'GILDAN - ORIGINAL ARMY GREEN SHIRTS - MALE XL', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1254, 'MF059A0537', 'RMPK01600010001', 'Paper Sleeves For FS 6.6x5.25x2.25 IN -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1255, 'TR058A0291', '61041017', 'GILDAN - ORIGINAL ARMY GREEN SHIRTS - MALE XS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1256, 'TR058A0292', '65001036', 'GILDAN - SO FREAKIN GRAY SHIRTS - FEMALE L', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 1, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1257, 'TR058A0293', '65001032', 'GILDAN - SO FREAKIN GRAY SHIRTS - MALE L', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1258, 'TR058A0294', '65001031', 'GILDAN - SO FREAKIN GRAY SHIRTS - MALE M', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1260, 'TR058A0295', '65001030', 'GILDAN - SO FREAKIN GRAY SHIRTS - MALE S', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1261, 'TR058A0297', '65001033', 'GILDAN - SO FREAKIN GRAY SHIRTS - MALE XL', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1262, 'TR058A0298', '65001038', 'GILDAN - SO FREAKIN GRAY SHIRTS - MALE XS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1263, 'TR058A0298', '41021049', 'HOSE - STEEL SPRING FOR GLAZER (7 FEET/PC)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1264, 'TR058A0299', '10909141', 'GINGER GROUND (1KG/PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 12, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1265, 'TR058A0301', '10832017', 'GINGERALE, CANADA DRY  (12CANS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1266, 'TR058A0301', '21051629', 'HOT CUP  8OZ - WHITE (50PC/20PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1267, 'TR058A0303', '51021442', 'GLASSWARE DRYING RACK, HALF BASE RACK - GRAY', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1268, 'MF059A0538', 'RMPK01600010002', 'Paper Sleeves For PS 10.8x8.25x2.25 IN -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1269, 'TR058A0304', '10906119', 'GLAZED BASE STABILIZER (50LB/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1270, 'TR058A0305', '12031130', 'GLITTERGELLI, DIAMOND  (7KGS/PAIL)', 50, '1', '4', '15', '25', 1, 1, 1, 7, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1271, 'TR058A0306', '12031158', 'GLITTERGELLI, GOLD  (7KGS/PAIL)', 50, '1', '4', '15', '25', 1, 1, 1, 7, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1272, 'MF059A0539', 'RMPK01600010003', 'Paper Cup Sleeves with Logo -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1273, 'TR058A0307', '12031148', 'GLITTERGELLI, RUBY  (7KGS/PAIL)', 50, '1', '4', '15', '25', 1, 1, 1, 7, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1274, 'TR058A0308', '12031207', 'GOLD DRAGEES STAR 500G/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1275, 'MF059A0540', 'RMPK01600010008', 'Paper Sleeves for Pastry w/ handle 7.9x4.0 IN --by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1276, 'TR058A0309', '10906219', 'GREAT TASTE PREMIUM COFFEE POWDER (100G/24PACK/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1277, 'TR058A0310', '10902156', 'GREEN APPLE FLAVOR (500G / BOT)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1278, 'MF059A0541', 'RMPK01700010020', 'Paper meal Box (3CN) - by piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 1, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1279, 'TR058A0310', '21051199', 'HOT CUP  8OZ LOCAL-GREEN (50PC/20PACKS/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1280, 'MF059A0542', 'RMPK01700010021', 'Paper meal Box (4CN) - by piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1281, 'TR058A0312', '21051630', 'HOT CUP 12OZ - WHITE (50PCS/20PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1282, 'TR058A0312', '10902159', 'GREEN APPLE FLAVOR 30ML', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1283, 'MF059A0543', 'RMPK01700010022', '2018RB paper Sleeves for Meal Box - by piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1284, 'TR058A0314', '21051201', 'HOT CUP 12OZ LOCAL-GREEN (50PC/20PACK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1285, 'TR058A0314', '10902159', ' GREEN APPLE FLAVOR 30ML', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1286, 'TR058A0315', '21061267', 'HOT CUP 12OZ-DOUBLE WALL (20PCS/25PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1287, 'MF059A0544', 'RMPK01700010025', 'Paper Box Plain 5x9x3 (CB#12) - - by piece ', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1288, 'TR058A0317', '21051631', 'HOT CUP 16OZ - WHITE (50PCS/20PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1290, 'TR058A0317', '10821005', 'GREEN TEA (25 PCS / BOX)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1291, 'TR058A0318', '21051202', 'HOT CUP 16OZ LOCAL-GREEN (50PC/20PACK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1292, 'TR058A0321', '21061268', 'HOT CUP 16OZ-DOUBLE WALL (15PCS/20PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1293, 'TR058A0322', '21061266', 'HOT CUP 8OZ-DOUBLE WALL (25PCS/20PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1294, 'TR058A0323', '10906124', 'GRHAM CRCKER CRUNCH - LT (6.5LB/2PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1295, 'TR058A0324', '12031006', 'GUMMY TAPE - APPLE (1.5KG/TUB)', 50, '1', '4', '15', '25', 1, 1, 1, 1.5, 1, 25, 22, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1296, 'TR058A0325', '12031100', 'GUMMY TAPE - MULTI COLORED (1.5KGS/TUB)', 50, '1', '4', '15', '25', 1, 1, 1, 1.5, 1, 25, 22, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1297, 'TR058A0326', '12031007', 'GUMMY TAPE - STRAWBERRY (1.5KG/ TUB)', 50, '1', '4', '15', '25', 1, 1, 1, 1.5, 1, 25, 22, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1298, 'TR058A0327', '41021073', 'HAND GLOVES, PLASTIC (100PC/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1299, 'TR058A0323', '21061269', 'HOT LID - 8/12/16OZ (100PCS/10PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1300, 'TR058A0328', '41021053', 'HAND GLOVES, VINYL  MEDIUM (100 PCS / PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1303, 'TR058A0330', '21061136', 'HOT LID 12/16 LOCAL (50PCS/20PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1304, 'TR058A0333', '21061320', 'HOT LID 12/16OZ (100PCS/10PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1305, 'TR058A0334', '21061319', 'HOT LID 8OZ (100PCS/10PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1306, 'TR058A0335', '21061135', 'HOT LID 8OZ LOCAL (50PCS/20PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1307, 'TR058A0335', '310300326', 'HAND SOAP DISPENSER', 50, '1', '4', '1', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1308, 'TR058A0337', '31011112', 'HYGIENIC HAND RUB (800ML/6PACK/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1310, 'TR058A0339', '12031035', 'INSTANT WHIP CREME (1KG/TUB)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 22, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1311, 'MF059A0545', 'RMPK01200030004', 'Cellosheet Clear 15x25 IN - Generic - by 100 Pc/ Ream', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 1, 26, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1312, 'MF059A0546', 'RMPK01200030005', 'Cellosheet Clear 15x16 IN - Generic - by 100 Pc/ Ream', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 26, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1313, 'MF059A0547', 'RMPK01200030006', 'Cellosheet Clear 9x7.5 IN -  - 100 Piece / Ream', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 26, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1314, 'MF059A0548', 'RMPK01200030010', 'Cellosheet Clear 9x15 IN - - 100 Piece /  Ream', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 26, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1315, 'TR058DH0340', '21051203', 'HANDLE STRIP DOUBLE FOR BOX 6S-CHRISTMAS(100PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1316, 'TR058A0340', '10431011', 'INSTANT WHIPPED CREME (4.5KG/TUB)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 22, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1317, 'MF059A0549', 'RMPK01200030011', 'Cellosheet Clear 6.5cm x 9.5cm - - 1000 Pieces / Ream', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 26, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1318, 'TR058A0342', '10906145', 'INSTANT YEAST - BRUGGEMANN (500G/20PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1319, 'TR058A0343', '11061002', 'INSTANT YEAST (LOCAL) (22LB/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1320, 'MF059A0550', 'RMPK01200030012', 'Cellosheet Clear 9.5cm x 64cm - - 1000 Pieces / Ream', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 26, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1321, 'MF059A0551', 'RMPK01200030013', 'Cellosheet Clear 9.5cm x 90cm - - 1000 Pieces / Ream', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 26, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1322, 'TR058A0344', '41021055', 'INTERFOLDED HAND TISSUE (175PC/30 PACK/ CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1323, 'MF059A0552', 'RMPK01200040012', 'Wrapper Greaseproof 40 GSM  24x18 IN -  - 480 Sheet / Ream', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 26, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1324, 'TR058A0345', '10852006', 'INTL DARK BLEND COFFEE BEAN (4LB/4PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1325, 'MF059A0553', 'RMOF00600040005', 'Conti`s Brand Tape - 100 M / Roll', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1326, 'TR058A0345', '10852007', 'INTL HOUSE BLEND COFFEE BEAN (4LB/4PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1327, 'MF059A0554', 'RMOF01000150002', 'Stretch Film Pallet 20MC 20x300mm by 6 - - by roll', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1328, 'TR058A0346', '12031182', 'JELLY BELLY - BLUEBERRY (10PCS/24PYRAMIDS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1329, 'TR058A0347', '12031184', 'JELLY BELLY - PINEAPPLE (10PCS/24PYRAMIDS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1330, 'TR058A0348', '12031183', 'JELLY BELLY - STRAWBERRY (10PCS/24PYRAMIDS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1331, 'TR058A0349', '21071010', 'JELLY HARD STRAW (500 PCS/ PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1332, 'TR058A0350', '10854016', 'JUICE GRAPE POWDER DRINK TANG 25G/144PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1333, 'TR058A0351', '10854014', 'JUICE ORANGE POWDER DRINK TANG 250G/12PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1334, 'TR058A0352', '10854017', 'JUICE STRAWBERRY POWDER DRINK TANG 25G/144PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1335, 'TR058A0353', '41021072', 'JUMBO TISSUE ROLL (12ROLL/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1336, 'TR058A0354', '31011062', 'KAY ALL PURPOSE CLEANER (44ML/ 168PCS/ CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1337, 'TR058A0355', '31011064', 'KAY QSR HEAT ACTIVATED GRILL & TOASTER CLEANER (4BOTS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1338, 'TR058A0356', '31011119', 'KAY QSR LIQUID CLEANSER - FOR REST ROOM  (946ML/BTL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1339, 'TR058A0357', '41051006', 'KHAKI APRON (1PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1340, 'TR058A0358', '41051005', 'KHAKI CAP (1PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1341, 'TR058A0359', '12031010', 'KITKAT (35GMS/24BAR/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 15, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1342, 'TR058A0360', '12031204', 'KITKAT GOLD CHOCOLATE 45G/48PCS/6INNERBOX/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1343, 'TR058A0361', '12031110', 'KITKAT GREEN TEA 4F  (35G/24BARS/12INNER BOX/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1344, 'TR058A0362', '10906239', 'KIWI FRUIT FILLING (6KGS/PAIL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1345, 'TR058A0363', '21051339', 'KK BOX 12S - VALENTINE (50PC/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1346, 'TR058A0364', '21051525', 'KK BOX 12S  W/ WINDOW (50PC/PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1347, 'TR058A0365', '21051137', 'KK BOX 12S (50PC/PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1348, 'TR058A0366', '21051208', 'KK BOX 12S CHRISTMAS (100PC/PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1349, 'TR058A0367', '21051588', 'KK BOX 12S ORIGINAL (50PC/PCK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1350, 'TR058A0368', '21051455', 'KK BOX 6S - CHRISTMAS (100 PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1351, 'TR058A0369', '21051534', 'KK BOX 6S  W/ WINDOW (100PC/PK)', 50, '1', '4', '15', '25', 11, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1352, 'TR058A0370', '21051541', 'KK BOX 6S  W/ WINDOW (100PC/PK)-VERSION 3', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1353, 'TR058A0371', '21051135', 'KK BOX 6S (100PC/PK)', 50, '1', '4', '15', '25', 1, 11, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1354, 'TR058A0372', '21051587', 'KK BOX 6S ORIGINAL (100PC/PCK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1355, 'TR058A0373', '21051338', 'KK BOX 6S -VALENTINE  (100PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1356, 'TR058A0374', '21051184', 'KK BOX 6S-BAKED (100PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1357, 'TR058A0375', '21041013', 'KK BUCKET BAG 70OZ 25PC/20PCK/BG', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1358, 'TR058A0376', '41031017', 'KK CATALOG ENVELOP', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1359, 'TR058A0377', '21051200', 'KK COLLECTIBLE TAG (50PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1360, 'TR058A0378', '21051699', 'KK DOUGHNUT BITES BOX 9 25PCS/4BUNDLES/PACK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 25, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1361, 'TR058A0379', '21051693', 'KK DOUGHNUT BITES CUP OG (50PC/PACK)', 50, '1', '4', '15', '25', 1, 1, 11, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1362, 'TR058A0380', '21051695', 'KK DOUGHNUT BITES PAPER BUCKET 25PC/4PCK/BOX', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1363, 'TR058A0381', '21051698', 'KK DOUGHNUT BITES PAPER BUCKET LID 50PCS/4BUNDLES/PACK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 25, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1364, 'TR058A0382', '21051279', 'KK DOUGHNUT HOLES BOX (100PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1365, 'MF059A0555', 'RMPD00100010002', 'Cling Wrap  30 CM Width - Generic - by Roll', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1366, 'MF059A0556', 'RMPD00100040017', 'Sticker PP Top White  1.20 IN x 0.80 IN - Gun Tag - 12,900 Piece / Roll', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1367, 'TR058A0383', '21051276', 'KK DOUGHNUT HOLES CUP (50PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1368, 'TR058A0384', '21051324', 'KK DOUGHNUT HOLES PVC PRINTED TAPE (12MM X 50M)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1369, 'MF059A0557', 'RMPD00100040020', 'Sticker PP Top White  1 1/3 x 2 IN -  - 5490 Piece / Roll', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1370, 'MF059A0558', 'RMPD00100040023', 'Sticker Tamper Proof (50m/roll) - - by Roll', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1371, 'TR058A0385', '21051365', 'KK DOUGHNUT HOLES STICKER-ASSORTED (500PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1372, 'MF059A0559', 'RMPD00100070001', 'Crochet Thread Natural B10 - - 175 M / Roll', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1373, 'TR058A0386', '21051355', 'KK DOUGHNUT HOLES STICKER-CHOCOLATE CAKE (500PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1374, 'MF059A0560', 'RMPD00100100004', 'Tag 4"x2.6" for Disposal - - 1000 Piece / Roll', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1375, 'TR058A0387', '21051351', 'KK DOUGHNUT HOLES STICKER-CHURROS (500PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1376, 'TR058A0388', '21051353', 'KK DOUGHNUT HOLES STICKER-MATCHA GREEN TEA (500PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1377, 'MF059A0561', 'RMPD00100100005', 'Tag 4"x2.6" Hold (for Feedback) - - 1000 Piece / Roll', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1378, 'TR058A0389', '21051354', 'KK DOUGHNUT HOLES STICKER-RED VELVET (500PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1379, 'TR058A0390', '21051364', 'KK DOUGHNUT HOLES STICKER-VANILLA CAKE (500PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1380, 'TR058A0391', '41031016', 'KK FOLDER - SHORT (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1381, 'TR058A0392', '41021240', 'KK GIFT CARD-GREEN BORDER  (50PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1382, 'TR058A0393', '41021241', 'KK GIFT CARD-RED BORDER  (50PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1383, 'MF059A0562', 'RMPD00100100006', 'Tag 4"x2.6" Outright Reject - - 1000 Piece / Roll', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1384, 'TR058A0394', '41021242', 'KK GIFT CARD-WHITE BORDER  (50PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1385, 'TR058A0395', '41051211', 'KK NAMEPLATE, MAGNETIC, BLACK/WHITE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1386, 'MF059A0563', 'RMPD00100100007', 'Tag 4"x2.6 for Recall - - 1000 Piece / Roll', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1387, 'TR058A0396', '21051636', 'KK PAPER BAG - 12S (50PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1388, 'TR058A0397', '21051637', 'KK PAPER BAG - 6S (100PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1389, 'MF059A0564', 'RMPD00100100008', 'Tag 4"x2.6" for Reject - - 1000 Piece / Roll', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1390, 'MF059A0565', 'RMPD00100100009', 'Tag 4"x2.6" for Expired - - 1000 Piece / Roll', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1391, 'TR058A0398', '21051185', 'KK TAKE OUT BAG#8-BAKED CREATION (4X500PCS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1392, 'TR058A0399', '61011003', 'KK TIN CAN - VALENTINE (18PCS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1393, 'TR058A0400', '61011008', 'KK TIN CAN GREEN W/BOY (18PCS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1394, 'TR058A0401', '61011009', 'KK TIN CAN RED W/MARCHING LOGO (18PCS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1395, 'TR058A0402', '61011010', 'KK TIN CAN WHITE W/ BOY & GIRL (18PCS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1396, 'MF059A0566', 'RMPD00100100010', 'Tag 4"x2.6" Complimentary Item - - 1000 Piece / Roll', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1397, 'TR058A0403', '61031007', 'KLEAN KANTEEN 20 OZ INSULATED CLASSIC WITH LOOP CAP', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1398, 'TR058A0404', '61031009', 'KLEAN KANTEEN INSULATED  TUMBLER WITH STRAW 16OZ', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1399, 'MF059A0567', 'RMPD00100100011', 'Tag 1 1/3"x2" Transferred Item - - 1000 Piece / Roll', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1400, 'TR058A0405', '10421024', 'KRAFT CHEDDAR CHEESE (440GMS/ 24PK/ CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 15, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1401, 'TR058A0406', '61011000', 'KRISPY KREME TIN CAN (18 PIECE / CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1402, 'MF059A0568', 'RMPD00100100012', 'Tag 1 1/3"x2" Back - Up Item - - 1000 Piece / Roll', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1403, 'TR058A0407', '61011007', 'KRISPY KREME TIN CAN-HOLIDAY (18PCS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1404, 'TR058A0408', '21051134', 'KRUFFIN LINER (100PC/12REAMS/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 26, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1405, 'MF059A0569', 'RMPK00100060012', 'Ribbon Hi-Gloss Yellow 809 - 16mm - - 50M / Roll', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1406, 'MF059A0570', 'RMPK00100070002', 'Wax Paper  30 CM Width - Reynold`s Kitchen Magic - 150 M / Roll', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1407, 'TR058A0409', '21051680', 'KRUFFIN LINER LOCAL 90X40 600PC/4PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1408, 'TR058A0410', '21051661', 'LABEL STICKER 6.5CMX2CM (1000PC/RL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1409, 'TR058A0411', '41021080', 'LABEL-DATE (10ROLLS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1410, 'TR058A0412', '61041000', 'LADIES T SHIRT WHITE (10 PCS / PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1411, 'TR058A0413', '61041002', 'LADIES T SHIRT WHITE EAT KK (PCS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1412, 'TR058A0414', '61041004', 'LADIES T-SHIRT BLACK EAT KK (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1413, 'TR058A0415', '10906243', 'LAFRUTA BLUEBERRY 50% (6KGS/PAIL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1414, 'TR058A0416', '12021001', 'LAFRUTA DARK CHERRY 50%  (2.7KGS/6CANS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1415, 'MF059A0571', 'RMPK01200010002', 'Aluminum Foil  30 CM Width - Reynold`s Kitchen Magic - 300 M / Roll', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1416, 'TR058A0417', '10906267', 'LAFRUTA KIWI FILLING W/ SEED 50% (2.7KGS/CAN)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1417, 'TR058A0418', '10906260', 'LAFRUTA PASSION FRUIT (6KGS/PL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1418, 'TR058A0419', '10906265', 'LAFRUTA PASSION FRUIT W/ SEED 50% (2.7KGS/CAN)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1419, 'TR058A0420', '12031023', 'LAFRUTA RASPBERRY (6KG/PAIL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1420, 'TR058A0421', '10906266', 'LAFRUTA RASPBERRY 50% (2.7KGS/CAN)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1421, 'TR058A0422', '10906233', 'LAFRUTA STRAWBERRY (6KGS/PAIL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1422, 'TR058A0423', '10902171', 'LEMON FLAVOR  (500G / BOTTLE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1423, 'TR058A0424', '10902176', 'LEMON FLAVOR (30ML/BTL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1424, 'TR058A0425', '10902222', 'LIME FLAVOR (30ML/BTL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1425, 'TR058A0426', '31011113', 'LOTION HAND SOAP (4GAL/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 27, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1426, 'TR058A0427', '41021092', 'LUBRICANT-TAYLOR 4OZ/PIECE  PN 047518', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1427, 'TR058A0428', '12031172', 'M&M MILK CHOCOLATE  (200G/24PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1428, 'TR058A0429', '12031174', 'MACADAMIA NUTS, CHOPPED (1KG/10PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1429, 'TR058A0430', '10906197', 'MALTODEXTRINE  (25KGS/BAG)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 5, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1430, 'TR058A0431', '12021000', 'MANGO CUBE(500G/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1431, 'TR058A0432', '10902163', 'MANGO FLAVOR (1KL/BOTTLE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1432, 'TR058A0433', '10854004', 'MANGO PUREE (1KILO/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 12, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1433, 'TR058A0434', '12031159', 'MARSHMALLOW - WHITE (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1434, 'TR058A0435', '10857013', 'MARTIN BRAUN CANDY CRUNCH (1KG/5PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1435, 'TR058A0436', '12031167', 'MARTIN BRAUN GOLD DÃƒÆ’Ã¢â‚¬Â°COR (1.5KG/TUB)', 50, '1', '4', '15', '25', 1, 1, 1, 1.5, 1, 25, 22, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1436, 'TR058A0437', '10906169', 'MATCHA GREEN TEA (100GRAMS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1437, 'TR058A0438', '10902173', 'McCORMICK FOOD COLOR 20ML - VIOLET', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1438, 'TR058A0439', '61041001', 'MENS T SHIRT WHITE EAT KK (PCS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1439, 'TR058A0440', '61041006', 'MENS T-SHIRT BLACK ROAD TRIP (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1440, 'TR058A0441', '61041007', 'MENS T-SHIRT GRAY CROWN KK (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1441, 'TR058A0442', '61041003', 'MENS T-SHIRT GREEN EAT KK (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1442, 'TR058A0443', '61041005', 'MENS T-SHIRT NAVY BLUE I LOVE KK (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1443, 'TR058A0444', '41021247', 'MICROFIBER- BROWN CLEANING CLOTH (40CM X 40CM)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1444, 'TR058A0445', '41021244', 'MICROFIBER- GREEN CLEANING CLOTH (40CM X 40CM)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1445, 'TR058A0446', '41021112', 'MICROFIBER- ORANGE CLEANING CLOTH (40CM X 40CM)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1446, 'TR058A0447', '41021243', 'MICROFIBER- RED CLEANING CLOTH (40CM X 40CM)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1447, 'TR058A0448', '41021246', 'MICROFIBER- WHITE CLEANING CLOTH (40CM X 40CM)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1448, 'TR058A0449', '41021245', 'MICROFIBER- YELLOW CLEANING CLOTH (40CM X 40CM)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1450, 'TR058A0451', '10832035', 'MILKIS MILK 250ML/24CANS/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1451, 'TR058A0452', '10832036', 'MILKIS STRAWBERRY 250ML/24CANS/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1452, 'TR058A0453', '41021059', 'MINERAL OIL FOOD GRADE (4 L / GALLON)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 27, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1453, 'TR058A0454', '41021066', 'MINERAL OIL FOR GLAZE TANK HEATER (20 L / CNTR)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 28, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1454, 'TR058A0455', '41021195', 'MINI MEASURE SHOT GLASS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1455, 'TR058A0456', '10902136', 'MIS SALT PACKETS LOCAL (1KG/PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 12, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1456, 'MF059A0572', 'RMPK01200040003', 'Wrapper Paperlene 30 CM Width -  - by Roll', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1457, 'TR058A0457', '10851015', 'MOCAFE FRAPPE MIX-WHITE CHOCOLATE (1,360grams/4packs/case)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1458, 'MF059A0573', 'RMPK01200040007', 'Wrapper Greaseproof With Logo Without Oval Half -  - 100 Sheet / Roll', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1459, 'TR058A0458', '10821014', 'MOCAFE GREEN TEA BEVERAGE POWDER MIX  (1360GRAMS/4PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1460, 'MF059A0574', 'RMPK01200040008', 'Wrapper Greaseproof With Logo Without Oval Whole -  - 100 Sheet / Roll', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1461, 'TR058A0459', '10910162', 'MOLASSES 1KG/25BOT/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1462, 'TR058A0460', '10906257', 'MONIN CHEESECAKE SYRUP (700ML/BTL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1463, 'MF059A0575', 'RMPK01400010001', 'Packaging Tape w/ Print  - Crocodile - by Roll', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1464, 'TR058A0461', '10819003', 'MONIN CREME BRULEE SYRUP  (1LTR/BTL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1465, 'TR058A0462', '10816019', 'MONIN GREEN APPLE SYRUP 1LTR/BTL', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1466, 'TR058A0463', '10816021', 'MONIN LYCHEE SYRUP 700ML/6BOT/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1467, 'TR058A0464', '12031106', 'MONIN PRALINE SYRUP (700ML/BTL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1468, 'TR058A0465', '12031034', 'MONIN SALTED CARAMEL SYRUP 700ML', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1469, 'TR058A0466', '10816020', 'MONIN WATERMELON SYRUP 1LTR/BTL', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1470, 'MF059A0576', 'RMPK00800010012', 'Disposable Cup 8 oz Rippled w/ White Lid - - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1471, 'TR058A0467', '10910157', 'MONIN WATERMELON SYRUP 700ML/BOT', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1472, 'TR058A0468', '11021013', 'MONTANA HARD WHEAT FLOUR (25KG/ SACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 9, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1473, 'MF059A0577', 'RMPK00800030010', 'Plastic Canister Round with Lid (J-1100) 7 1/8 IN D x 2 IN H -  - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1474, 'TR058A0469', '31021052', 'MOP HANDLE (1 PCS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1475, 'MF059A0578', 'RMPK00800030012', 'Plastic Canister Round Clear w/ lid (RO75)1/2Gal - - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1476, 'TR058A0470', '31021053', 'MOP HEAD WHITE (1PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1477, 'TR058A0471', '51021292', 'MOP HEAD, GREEN', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1478, 'MF059A0579', 'RMPK00800040014', 'Plastic Canister with Lid Rectangular (RE-2500) 2500ML  - - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1479, 'TR058A0472', '51021293', 'MOP HEAD, RED', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1480, 'TR058A0473', '31021049', 'MOPHEAD  RED/GREEN (1 PCS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1481, 'MF059A0580', 'RMPK00800060006', 'Syrup Cup Plastic w/ Lid 1.5 OZ - Calypso - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 1, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1482, 'MF059A0581', 'RMPK00800080001', 'Plastic Canister with Lid Round (P-250) 250 ML -  - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1483, 'TR058A0474', '10832015', 'MUG ROOTBEER (12OZ/24CAN/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1484, 'TR058A0475', '61031000', 'MUGS LOCAL (12 OZ) (24 PCS / CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1485, 'TR058A0476', '61031001', 'MUGS LOCAL (16 OZ) (24 PCS / CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1486, 'TR058A0477', '61031004', 'MUGS LOCAL (8OZ)(24PCS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1487, 'TR058A0478', '31011108', 'MULTIPURPOSE SINK DETERGENT (2.5 GAL/CONTAINER)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 28, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1488, 'TR058A0479', '41051014', 'NAME PLATE-MANAGER (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1489, 'TR058A0480', '41051012', 'NAME PLATE-POINT PERSON TRAINER (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1491, 'TR058A0482', '41051007', 'NAME PLATES (1PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1492, 'TR058A0483', '41051008', 'NAME PLATE-TEAM LEADER (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1493, 'MF059A0582', 'RMPK00800080005', 'Plastic Canister with Lid Rectangular (P-500) 500 ML -  - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1494, 'TR058A0484', '12031198', 'NESTLE CRUNCH 1.55OZ/36PCK/10INNERBOX/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1495, 'MF059A0583', 'RMPK00800080010', 'Plastic Tray w/ Lid rectangular (KD-24) - -by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1496, 'TR058A0485', '10431014', 'NESTLE ICE CREAM PREMIUM SOFTSERVE (10KG/BOX)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1497, 'MF059A0584', 'RMPK00800080011', 'Plastic Canister w/ Lid Bento (BTB-4C) - - Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1498, 'TR058A0486', '10855002', 'NEUTRAL BLENDER BASE (2KG/8PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1499, 'TR058A0487', '10906135', 'NEW FLAVOR GLAZE (4OZ/25BT/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1500, 'MF059A0585', 'RMPK00800080012', 'Plastic Canister w/ Lid Rectangular (P1000) - - 1000ML', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1501, 'TR058A0488', '10906227', 'NEW FLAVOR GLAZE 1GAL', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 27, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1502, 'MF059A0586', 'RMPK00800080013', 'Plastic Canister w/ Lid Bento (BTB-3CN) - - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1503, 'MF059A0587', 'RMPK00800080014', 'Plastic Canister w/ Lid Rectangular (PN-2) Black - - By Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1504, 'MF059A0588', 'RMPK00800080016', 'Plastic Canister w/ Lid Round (RO-30) 750 ML / - - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 11, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1505, 'TR058A0489', '10441034', 'NON FAT MILK (12 PACK/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1506, 'MF059A0589', 'RMPK00800080017', 'Plastic Canister with Lid Round (S-16) 500 ML - - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1507, 'TR058A0490', '12031205', 'NON-PAREILS GOLD 500G/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1508, 'MF059A0590', 'RMPK00800080019', 'Plastic Canister w/ Lid Bento (3 Compartment) Red/Black - - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1509, 'MF059A0591', 'RMPK00800090001', 'Freezer Canister with Lid Rectangular 750 ML -  - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1510, 'TR058A0491', '12031146', 'NON-PAREILS, MIXED-RED,PINK,WHITE  (100G/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1511, 'TR058A0492', '12031044', 'NON-PAREILS, PINK (250G/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 12, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1512, 'MF059A0592', 'RMPK00800090002', 'Freezer Canister with Lid Rectangular 500 ML -  - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1513, 'MF059A0593', 'RMPK00800090003', 'Freezer Canister with Lid Round 750 ML -  - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1514, 'TR058A0493', '12031045', 'NON-PAREILS, RAINBOW (250G/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1515, 'MF059A0594', 'RMPK00800090006', 'Freezer Canister with Lid Rectangular 160x95x80 mm - - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1516, 'TR058A0494', '12031031', 'NON-PAREILS, RED', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 12, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1517, 'MF059A0595', 'RMPK00800120001', 'Syrup Cup with Lid 3.5 oz -  - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1518, 'TR058A0495', '12031033', 'NON-PAREILS, WHITE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1519, 'TR058A0496', '21041001', 'NON-WOVEN BAG - BREW BOX (10PCS/ PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1520, 'MF059A0596', 'RMPK00800120002', 'Syrup Cup with Lid 30 mL - - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1521, 'TR058A0497', '21041008', 'NON-WOVEN BAG - TAKE OUT 12S - CHRISTMAS (10PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1522, 'TR058A0498', '21041003', 'NON-WOVEN BAG - TAKE OUT 12S (10PCS/ PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1523, 'MF059A0597', 'RMPK01700010001', 'Thermal Chill Wrap - - - per sheet', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 31, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1524, 'TR058A0499', '21041002', 'NON-WOVEN BAG - TAKE OUT 6S (10PCS/ PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1525, 'TR058A0500', '21051368', 'NON-WOVEN BAG CEBU -TAKE OUT 12S (10PCS/ PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1526, 'TR058A0501', '21051371', 'NON-WOVEN BAG CEBU -TAKE OUT 6S (10PCS/ PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1527, 'TR058A0502', '21051366', 'NON-WOVEN BAG ILOILO -TAKE OUT 12S (10PCS/ PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1528, 'TR058A0503', '21051367', 'NON-WOVEN BAG ILOILO -TAKE OUT 6S (10PCS/ PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1529, 'TR058A0504', '21051453', 'NON-WOVEN BAG-TAKE OUT 6S - CHRISTMAS (10PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1530, 'TR058A0505', '21051214', 'NON-WOVEN TAKE OUT BAG 12S - EMOJIS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1531, 'TR058A0506', '21051215', 'NON-WOVEN TAKE OUT BAG 6S - EMOJIS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1532, 'TR058A0507', '21051344', 'NON-WOVENBAG-TAKEOUT 12S-VALENTINE  (10PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1533, 'TR058A0508', '21051345', 'NON-WOVENBAG-TAKEOUT 6S VALENTINE -  (10PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1534, 'TR058A0509', '12011001', 'NUTELLA (750GMS/9BOT/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1535, 'TR058A0510', '12031086', 'NUTELLA (900G/6BTLS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1536, 'TR058A0511', '10906235', 'NUTELLA 3KG (3KG/2TUB/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 22, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1537, 'TR058A0512', '10906122', 'NY CHEESECAKE FILLING - LT (38LB/PAIL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1538, 'TR058A0513', '65041052', 'OG CARD PVC CARD', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1539, 'TR058A0514', '41031048', 'OG CARD THERMAL PAPER 57X40MM 320RL/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1540, 'TR058A0515', '12031138', 'OIL BASED FOOD COLOR-GREEN (2OZ/BTL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1541, 'TR058A0516', '41021079', 'OIL FILTER (42799)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1542, 'TR058A0517', '41041020', 'ON US SLIP (3 PLY/ 50 SET/ PAD)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1543, 'TR058A0518', '10902221', 'ORANGE FLAVOR (30ML/BTL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1544, 'TR058A0519', '12031160', 'ORANGE MARMALADE, CLARA OLE (4.5KGS/GAL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 27, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1545, 'TR058A0520', '12031015', 'OREO COOKIE BISCUIT-CRUMBS (454GRAMS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1546, 'TR058A0521', '11081041', 'OREO COOKIE GROCERY (274GRAMS/12PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1547, 'TR058A0522', '12031200', 'OREO COOKIE GROCERY 266G/12PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1548, 'AA015A0115', '2087', 'MIOS (2087)', 18, '2', '4', '21', '25', 1, 1, 1, 1, 1, 23, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1549, 'TR058A0523', '10819004', 'ORIGINAL GLAZED DOUGHNUT SYRUP (1L/4BTLS/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1550, 'TR058A0524', '10817000', 'ORIGINAL KREME SYRUP (1L/ 4BOT/ CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1551, 'TR058A0525', '11021011', 'O-TENTIC DOLCE (1KG/10PCK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 12, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1552, 'AA015A0116', '2089', 'MIOR (2089)', 18, '2', '4', '21', '25', 1, 1, 1, 1, 1, 23, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1553, 'TR058A0526', '11021014', 'O-TENTIC DURUM (1KG/10PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1554, 'TR058A0527', '31011111', 'OVEN CLEANER  (56GRAMS/48BTL/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1555, 'TR058A0528', '31011118', 'OVEN CLEANER (1QRT/4BTLS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1556, 'TR058A0529', '10721009', 'PALM FLAKES (15KG/ CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1557, 'TR058A0530', '21051196', 'PAPER BAG BAKED SMALL (25PC/4BUNDLE/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1558, 'TR058A0531', '21051195', 'PAPER BAG KK (SMALL) (25PCS/4BUNDLES/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1559, 'TR058A0532', '21051191', 'PAPER BOWL 521CC (50PCS/20PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1560, 'TR058A0533', '21051140', 'PAPER COLD CUPS 12OZ (50PCS/20PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1561, 'TR058A0534', '21051141', 'PAPER COLD CUPS 16OZ (50PCS/20PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 1, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1562, 'TR058A0535', '41031037', 'PAPER CUP, 4OZ  (100PCS/10PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1563, 'TR058A0536', '41051004', 'PAPER HAT BIG (400PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1564, 'TR058A0537', '41011017', 'PAPER HAT SMALL (400PCS/PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1565, 'TR058A0538', '21051656', 'PAPER HOT CUP 12OZ KK BDAY82 50PC/20PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1566, 'TR058A0539', '21051657', 'PAPER HOT CUP 16OZ KK BDAY82 50PC/20PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1567, 'TR058A0540', '21051655', 'PAPER HOT CUP 8OZ KK BDAY82 50PC/20PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1568, 'TR058A0541', '21051668', 'PAPER STRAW 12MM WHITE W/ WRAP (100PCS/24PACK/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1569, 'TR058A0542', '21051606', 'PAPER STRAW WHITE COATED 100PCS/BOX', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1570, 'TR058A0543', '21051607', 'PAPER STRAW, SWIRL - RED (50PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1571, 'TR058A0544', '21051382', 'PARCHMENT PAPER 10" X 33" (960PCS/REAM)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 26, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1572, 'TR058A0545', '41021067', 'PARCHMENT PAPER 24"X36"(480PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1573, 'TR058A0546', '10906204', 'PASSIONATA GRAPE CHOCOLATE (1KG/BLOCK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 7, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1574, 'TR058A0547', '10855004', 'PASTEURIZED FRESH MILK  (1L/12PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1575, 'TR058A0548', '10855005', 'PASTEURIZED HIGH CALCIUM LOW FAT MILK  (1L/12PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1576, 'TR058A0549', '10821013', 'PEACH BLACK TEA (100GRAMS/POUCH)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 21, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1577, 'TR058A0550', '11041023', 'PEANUT CHOPPED ROASTED/UNSALTED 3-5MM 1KG/10BAG/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1578, 'TR058A0551', '11041022', 'PEANUT CHOPPED ROASTED/UNSALTED 3-5MM 500G/20BAG/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1579, 'TR058A0552', '12031067', 'PEANUT ROASTED, UNSALTED (SIEVED)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1580, 'TR058A0553', '12031150', 'PEPERO ALMOND-CHOCOLATE STICK (32G/40PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1581, 'TR058A0554', '12031037', 'PEPPERMINT CANDY-GREEN', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 12, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1582, 'TR058A0555', '12031036', 'PEPPERMINT CANDY-RED', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 12, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1583, 'TR058A0556', '10902174', 'PEPPERMINT FLAVOR (30ML/BOT)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 1, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1584, 'TR058A0557', '10818004', 'PERRIER SPARKLING WATER 330 ML (24BOT/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1585, 'TR058A0558', '21061147', 'PET PLASTIC SAUCE CUP WITH LID, 2OZ (100PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1586, 'TR058A0559', '41041028', 'PETTY CASH VOUCHER (50 PAGES/ PAD)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1587, 'TR058A0560', '10854013', 'PINEAPPLE JUICE SWEETENED DEL MONTE 1LTR/12TETRA/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1588, 'TR058A0561', '41021065', 'PIPING BAG 16IN (100PCS/10PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1589, 'TR058A0562', '12031022', 'PISTACHIO KERNEL ROASTED (500GRMS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1590, 'TR058A0563', '12031175', 'PISTACHIO NUTS, CHOPPED (1KG/10PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1591, 'TR058A0564', '51011036', 'PITCHER - CLEAR (CAMBRO) (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1592, 'TR058A0565', '21061121', 'PLASTIC - WRAP BAKED (100PC/ PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1593, 'TR058A0566', '21061122', 'PLASTIC P.E (100PC/ PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1594, 'TR058A0567', '51011033', 'PLATES - SQUARE (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1595, 'TR058A0568', '12031046', 'POLISHED DRAGEES 3MM,PINK (250G/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 12, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1596, 'TR058A0569', '81012050', 'POPCORN - KRISPY KREME CHOCO GLAZE (120G/48TUBS/BOX)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1597, 'TR058A0570', '81012051', 'POPCORN - KRISPY KREME ORIGINAL GLAZED 120G/48TUB/BOX', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1598, 'TR058A0571', '12031197', 'POPPING BOBA ORANGE 1KG/20PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1599, 'TR058A0572', '12031196', 'POPPING BOBA STRAWBERRY 3.2KG/4BKT/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 29, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1600, 'TR058A0573', '41031013', 'POS JOURNAL TAPE (50ROLL/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1601, 'TR058A0574', '41031015', 'POS THERMAL PAPER ROLL (50 ROLL/ CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1602, 'TR058A0575', '10851014', 'POWDERED CHOCOLATE DRINK(1KG/10PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1603, 'TR058A0576', '12031149', 'PREGEL PASTE,  PEACH  FLAVOR (3KGS/2TINS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 17, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1604, 'TR058A0577', '10902220', 'PREGEL PASTE, STRAWBERRY C (3KG/BUCKET)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 29, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1605, 'TR058A0578', '10906228', 'PREGEL TRADITIONAL PASTE, CHOCO-HAZELNUT 6KG/BUCKET', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 29, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1606, 'TR058A0579', '41041036', 'PULL-OUT FORM (3PLY/50SET/PAD)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1607, 'TR058A0580', '12031202', 'PURATOS COVERLIQ BLUEBERRY', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1608, 'TR058A0581', '10906262', 'PURATOS DELI UBE 5KG/BKT', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 29, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1609, 'TR058A0582', '41031014', 'PURCHASE ORDER FORM -GENERIC (3PLY/500SET/BOX)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1610, 'TR058A0583', '41041030', 'PURCHASE REQUISITION (2 PLY/ 50 SET/ PAD)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1611, 'TR058A0584', '31011110', 'QUARRY TILE FLOOR CLEANER  (2 OZ/ 120PCS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1612, 'TR058A0585', '51021279', 'RACK COVER', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1613, 'TR058A0586', '41021068', 'RACK COVER SMALL (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1614, 'TR058A0587', '41021256', 'RACK COVER W/ BROWN ZIPPER-BIG', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1615, 'TR058A0588', '41021258', 'RACK COVER W/ BROWN ZIPPER-SMALL', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1616, 'TR058A0589', '41021253', 'RACK COVER W/ GREEN ZIPPER-BIG', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1617, 'TR058A0590', '41021255', 'RACK COVER W/ GREEN ZIPPER-SMALL', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1618, 'TR058A0591', '41021250', 'RACK COVER W/ RED ZIPPER-BIG', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1619, 'TR058A0592', '41021252', 'RACK COVER W/ RED ZIPPER-SMALL', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1620, 'TR058A0593', '41021084', 'RACK COVER, MEDIUM', 50, '1', '3', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1621, 'TR058A0594', '41021086', 'RACK, STAINLESS MEDIUM', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 30, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1622, 'TR058A0595', '41041090', 'RACKS & TRAYS MONITORING FORM (4 PLY / 50 SET/ PAD)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1623, 'TR058A0596', '10902157', 'RASPBERRY FLAVOR 30ML', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1624, 'TR058A0597', '10842001', 'RASPBERRY PUREE (1L/ 4JUG/ CS0)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 13, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1625, 'TR058A0598', '10842000', 'RASPBERRY SYRUP (1L/BOT)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1626, 'TR058A0599', '41021194', 'RCP RUBBER SPATULA 9.5", WHITE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1627, 'TR058A0600', '41041022', 'RECEIVING REPORT (2 PLY/ 50 SET/ PAD)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1628, 'TR058A0601', '10851009', 'RED VELVET POWDER (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1629, 'TR058A0602', '12031019', 'REESES PEANUT BUTTER CHIPS (10OZ/12PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1630, 'TR058A0603', '12031156', 'REESES PEANUT BUTTER CUP (42G/36PACKS/12INNERBOX)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1631, 'TR058A0604', '12031120', 'REESES PEANUT BUTTER SPREAD (510GRAMS/BOTTLE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1632, 'TR058A0605', '21061140', 'RIBBON-RED W/ LOGO (50YARDS/ROLL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1633, 'TR058A0606', '12031039', 'ROUND COATED CHOCOLATE - GREEN (250PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1634, 'TR058A0607', '12031162', 'ROUND COATED CHOCOLATE - ORANGE (240PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1635, 'TR058A0608', '12031131', 'ROUND COATED CHOCOLATE - RED  (240PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1636, 'TR058A0609', '51011104', 'ROUND GLASS PLATE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1637, 'TR058A0610', '12031123', 'RTU CHOCOLATE DIPPING ICING  (43 LBS/PAIL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1638, 'TR058A0611', '12031028', 'RTU WHITE ICING, GLOSSY (43LBS/PAIL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1639, 'TR058A0612', '41021201', 'RUBBER TAMPING MAT  (SINGLE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1640, 'TR058A0613', '10906130', 'S-500 ACTI PLUS (1KG/10PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1641, 'TR058A0614', '10857001', 'SACHET, BROWN SUGAR (5GMS/100PC/10PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1642, 'TR058A0615', '10857003', 'SACHET, CREAMER (100PC/10PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1643, 'TR058A0616', '10857008', 'SACHET, SPLENDA  (1,200 PACKETS/BOX)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1644, 'TR058A0617', '10852010', 'SACHET, SPLENDA (1000 PCS / PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1645, 'TR058A0618', '10857002', 'SACHET, WHITE SUGAR (5GMS/100PC/10PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1646, 'TR058A0619', '41041024', 'SALES SUMMARY REPORT (2 PLY/ 50 SET/ PAD)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1647, 'TR058A0620', '12031132', 'SALTLETTS BREZEL  (150G/12PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1648, 'TR058A0621', '12031181', 'SANDING SUGAR - BLACK (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1649, 'TR058A0622', '12031164', 'SANDING SUGAR - ORANGE (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1650, 'TR058A0623', '12031047', 'SANDING SUGAR, PINK (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1651, 'TR058A0624', '12031098', 'SANDING SUGAR-RED (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1652, 'TR058A0625', '31011063', 'SANIGEL HAND SANITIZER (4GALLON/ CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 27, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1653, 'TR058A0626', '31011058', 'SANISOFT LIQUID HAND SOAP', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 27, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1654, 'TR058A0627', '21051145', 'SATCHEL BAG (500PC/4PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1655, 'TR058A0628', '21051581', 'SATCHEL BAG 126MM X 215MM (500PC/4PCK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1656, 'TR058A0629', '21051560', 'SATCHEL BAG, PLAIN - 212 X 125 X 80MM (500PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 2, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1657, 'TR058A0630', '21061137', 'SAUCE CUP W/ LID 1OZ (100 PC/ PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1658, 'TR058A0631', '10122042', 'SCHUBLING SAUSAGE 5" (30PC/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1659, 'TR058A0632', '31021089', 'SCOURING PAD WHITE TR6602', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1660, 'TR058A0633', '61011005', 'SCRAP BOOK (1 PCS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1661, 'TR058A0634', '41041029', 'SERVICE ORDER REPORT (2 PLY/ 50 SET/ PAD)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1662, 'TR058A0635', '10721006', 'SHC-LT CAKE AND ICING SHTG. BASE (50LB/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1663, 'TR058A0636', '65001027', 'SHIRT - GILDAN "ORIGINAL" (S, M, L, XL; MALE AND FEMALE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1664, 'TR058A0637', '41021022', 'SHOE COVER 100PCS/PACK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1665, 'TR058A0638', '10721011', 'SHORT MIX 202 SHORTENING (KG)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 12, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1666, 'TR058A0639', '10721010', 'SHRTNING CUBE-ALL VEG FRY(LOCAL) (55LB/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1667, 'TR058A0640', '10857004', 'SILK SOY MILK CHOCO (236ML/18PK/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1668, 'TR058A0641', '10857005', 'SILK SOY MILK VANILLA (236ML/18/PK/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1669, 'TR058A0642', '12031208', 'SILVER DRAGEES 500G/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1670, 'TR058A0643', '31011109', 'SINK SANITIZER  (1 OZ/ 200PCS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1671, 'TR058A0644', '31011059', 'SIZZLE GRILL & BUN/TOASTER CLEANER (6 BTLS / CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1672, 'TR058A0645', '12031193', 'SKITTLES 45G/20PCK/6INNERBOX/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1673, 'TR058A0646', '61041021', 'SKOOP TSHIRT SAME COLOR COLLAR LARGE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1674, 'TR058A0647', '61041020', 'SKOOP TSHIRT SAME COLOR COLLAR MEDIUM', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1675, 'TR058A0648', '61041019', 'SKOOP TSHIRT SAME COLOR COLLAR SMALL', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1676, 'TR058A0649', '61041022', 'SKOOP TSHIRT SAME COLOR COLLAR XL', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1677, 'TR058A0650', '61041025', 'SKOOP TSHIRT VERSION 2 (OG,LOWER HALF GREEN) LARGE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1678, 'TR058A0651', '61041024', 'SKOOP TSHIRT VERSION 2 (OG,LOWER HALF GREEN) MEDIUM', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1679, 'TR058A0652', '61041023', 'SKOOP TSHIRT VERSION 2 (OG,LOWER HALF GREEN) SMALL', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1680, 'TR058A0653', '61041026', 'SKOOP TSHIRT VERSION 2 (OG,LOWER HALF GREEN) XL', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1681, 'TR058A0654', '51011102', 'SLIM SPOON, LONG - GREEN (100PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1682, 'TR058A0655', '12031014', 'SNICKERS CLASSIC SINGLES (51G/24BAR/8PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 15, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1683, 'TR058A0656', '41021087', 'SNOW FLAKES STENCILS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1684, 'TR058A0657', '10832002', 'SOFTDRINKS 7-UP REGULAR 330ML 24CANS/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1685, 'TR058A0658', '10832032', 'SOFTDRINKS 7-UP REGULAR SLEEK 330ML 24CANS/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1686, 'TR058A0659', '10832003', 'SOFTDRINKS MIRINDA ORANGE 330ML 24CAN/SCASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1687, 'TR058A0660', '10832031', 'SOFTDRINKS MIRINDA ORANGE SLEEK 330ML 24CAN/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1688, 'TR058A0661', '10832004', 'SOFTDRINKS MOUNTAIN DEW 330ML 24CANS/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1689, 'TR058A0662', '10832030', 'SOFTDRINKS MOUNTAIN DEW SLEEK 330ML 24CANS/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1690, 'TR058A0663', '10812008', 'SOFTDRINKS MUG ROOTBEER 1.75L/12BOT/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1691, 'TR058A0664', '10832033', 'SOFTDRINKS MUG ROOTBEER SLEEK 330ML 24CANS/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1692, 'TR058A0665', '21051213', 'HANDLE STRIP DOUBLE FOR BOX 6S-EMOJIS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1693, 'TR058A0666', '21051574', 'HANDLE STRIP DOUBLE FOR BOX 6S-EOIAO (100PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1694, 'TR058A0667', '21051328', 'HANDLE STRIP DOUBLE FOR BOX 6S-VALENTINE (100PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1695, 'TR058A0668', '21051188', 'HANDLE STRIP DOUBLE FOR BOX6S-GENERIC', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1696, 'TR058A0669', '21051189', 'HANDLE STRIP SINGLE BOX6S-BAKED (100PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1697, 'TR058A0670', '21051204', 'HANDLE STRIP SINGLE FOR BOX 12S-CHRISTMAS(50PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1698, 'TR058A0671', '21051212', 'HANDLE STRIP SINGLE FOR BOX 12S-EMOJIS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1699, 'TR058A0672', '21051330', 'HANDLE STRIP SINGLE FOR BOX 12S-VALENTINE (50PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1700, 'TR058A0673', '21051660', 'HANDLE STRIP SINGLE FOR BOX 6S - CC (100pcs/pack)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1701, 'TR058A0674', '21051454', 'HANDLE STRIP SINGLE FOR BOX 6S - CHRISTMAS (100PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1702, 'TR058A0675', '21051224', 'HANDLE STRIP SINGLE FOR BOX 6S-EMOJI  (100PCS/BOX)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1703, 'TR058A0676', '21051186', 'HANDLE STRIP SINGLE FOR BOX 6S-GENERIC', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1704, 'TR058A0677', '21051329', 'HANDLE STRIP SINGLE FOR BOX 6S-VALENTINE (100PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1705, 'TR058A0678', '21051198', 'HANDLE STRIP SINGLE FOR BOX OF 12S - ONLINE (50PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1706, 'TR058A0679', '21051187', 'HANDLE STRIP SINGLE FOR BOX12S-GENERIC', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1707, 'TR058A0680', '12031103', 'HAZELNUT CHOPPED-TOASTED (500GRAMS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1708, 'TR058A0681', '10904129', 'HAZELNUT PASTE PURE 5.5KG/PL', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1709, 'TR058A0682', '10819000', 'HAZELNUT SYRUP (1L/ 6BOT/ CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1710, 'TR058A0683', '51021277', 'HEATING ELEMENT (40091) 4500 WATTS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1711, 'TR058A0684', '51021278', 'HEATING ELEMENT 65 LINE (5500 WATTS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1712, 'TR058A0685', '10813002', 'HERSHEYS CHOCO SYRUP (240Z/24BT/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1713, 'TR058A0686', '12031054', 'HERSHEYS CKS N CRM 4 (12 INNER BOX/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1714, 'TR058A0687', '12031203', 'HERSHEYS GOLD PEANUTS AND PRETZELS (39G/24PACKS/12IB/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1715, 'TR058A0688', '12031124', 'HERSHEYS MILK CHOCOLATE  (43G/36PACK/12INNERBOX/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1716, 'TR058A0689', '12031192', 'HERSHEYS MILK CHOCOLATE WITH ALMOND 41.1G/36PCK/12INNERBOX/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1717, 'TR058A0690', '12031013', 'HERSHEYS SPECIAL DARK CHOCOLATES (12INNERBOX/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1718, 'TR058A0691', '10906142', 'HERSHEYS UNSWEETENED COCOA POWDER  (8OZ/12 CANS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1719, 'TR058A0692', '12031133', 'HOLIDAY BLEND SPRINKLES (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1720, 'TR058A0693', '61041038', 'HOLIDAY T-SHIRT GLAZED L', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1721, 'TR058A0694', '61041037', 'HOLIDAY T-SHIRT GLAZED M', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1722, 'TR058A0695', '61041036', 'HOLIDAY T-SHIRT GLAZED S', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1723, 'TR058A0696', '61041039', 'HOLIDAY T-SHIRT GLAZED XL', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1724, 'TR058A0697', '61041032', 'HOLIDAY T-SHIRT ORIGINAL L', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1725, 'TR058A0698', '61041031', 'HOLIDAY T-SHIRT ORIGINAL M', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1726, 'TR058A0699', '61041030', 'HOLIDAY T-SHIRT ORIGINAL S', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1727, 'TR058A0700', '61041033', 'HOLIDAY T-SHIRT ORIGINAL XL', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1728, 'TR058A0701', '10910125', 'HONEY - RAW WILD (350ML/24BOT/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1729, 'TR058A0702', '10818006', 'HOPE WATER (500ML/24BOTTLE/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1730, 'TR058A0703', '10832005', 'SOFTDRINKS PEPSI MAX 330ML 24CANS/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1731, 'TR058A0704', '10812009', 'SOFTDRINKS PEPSI REGULAR 1.75L (12BTLS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1732, 'TR058A0705', '10832006', 'SOFTDRINKS PEPSI REGULAR 330ML 24CANS/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1733, 'TR058A0706', '10832028', 'SOFTDRINKS PEPSI REGULAR SLEEK 330ML 24CANS/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1734, 'TR058A0707', '10814003', 'SOLA ASSORTED (24 BOT/ CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1735, 'TR058A0708', '10906126', 'SOUR CREAM CONCNTRATE (NEW) (20LB/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 28, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1736, 'TR058A0709', '12031107', 'SPARKLE GLAZE GOLD (1KG/TUB)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 22, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1737, 'TR058A0710', '31011057', 'SPIRIT RR  DISINFECTANT CLEANER (9 BTLS / CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1738, 'TR058A0711', '21061138', 'SPORK (12PCS/ PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1739, 'TR058A0712', '12041003', 'SPRINKLE - GREEN (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1740, 'TR058A0713', '12031002', 'SPRINKLE - RAINBOW (6.25LBS/ 4 TETRA/ CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1741, 'TR058A0714', '12041002', 'SPRINKLE - RED (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1742, 'TR058A0715', '12031190', 'SPRINKLE - VERMECELLI, MIXED (DARK & WHITE CHOCOLATE) 1KG/5PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1743, 'TR058A0716', '12031155', 'SPRINKLE - WHITE (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1744, 'TR058A0717', '12031097', 'SPRINKLE-HALLOWEEN', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1745, 'TR058A0718', '12031165', 'SPRINKLES - MINI HEART (250GRAMS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1746, 'TR058A0719', '12031209', 'SPRINKLES VERMICELLI PEARLIZED GOLD 1KG/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1747, 'TR058A0720', '12031206', 'SPRINKLES VERMICELLI PEARLIZED WHITE 1KG/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1748, 'TR058A0721', '12031140', 'SPRINKLE-VERMICELLI, DARK CHOCOLATE  (1KG/5PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1749, 'TR058A0722', '51021274', 'STAINLESS FORK (12PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1750, 'TR058A0723', '51021275', 'STAINLESS KNIFE (12PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1751, 'TR058A0724', '41021061', 'STAINLESS RACK REGULAR (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1752, 'TR058A0725', '41021062', 'STAINLESS RACK SMALL (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1753, 'TR058A0726', '41021199', 'STEAMING PITCHER (ROSSETTI)  B31142 MILK POT 0.6L  (20.28 OZ)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1754, 'TR058A0727', '41041021', 'STOCK TRANSFER RECEIPT (3 PLY/ 50 SET/ PAD)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1755, 'TR058A0728', '21071021', 'STRAW PAPER (SAGO) WHITE 50PC/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1756, 'TR058A0729', '10906120', 'STRAWBERRY FILLING (8LB/6PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1757, 'TR058A0730', '10902158', 'STRAWBERRY FLAVOR  30ML', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1758, 'TR058A0731', '10842002', 'STRAWBERRY PUREE (1L/ 4JUG/ CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 13, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1759, 'TR058A0732', '41021047', 'STRETCH FILM 15MICS (ROLL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1760, 'TR058A0733', '10910126', 'SUGAR 6X - 100MESH (25KG/SACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 9, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1761, 'TR058A0734', '10910159', 'SUGAR BROWN 1KG/50PCK/SCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1762, 'TR058A0735', '10910155', 'SUGAR BROWN 50KGS/SACK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 9, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1763, 'TR058A0736', '11061005', 'SUGAR, GRANULATED (50KG/SACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 9, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1764, 'TR058A0737', '41041017', 'SURVEY FORM - DRIVE THRU (50SHEETS/PAD)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1765, 'TR058A0738', '41041019', 'SURVEY FORM - IN LINE (50SHEETS/PAD)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1766, 'TR058A0739', '41041018', 'SURVEY FORM - MALL/ARCADE (50SHEETS/PAD)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 11, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1767, 'TR058A0740', '41021249', 'TABLE NAPKIN-BROWN (200 SHTS/50 PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1768, 'TR058A0741', '41021054', 'TABLE NAPKINS (200 PCS / 50 PACKS / CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1769, 'TR058A0742', '21091002', 'TAKE OUT COFFEE STIRRER (20PC/PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1770, 'TR058A0743', '11021010', 'TALENTO KRISPY KREME CHOCO CAKE (10KG/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 12, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1771, 'TR058A0744', '11021009', 'TALENTO KRISPY KREME CREAM CAKE (10KG/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 12, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1772, 'TR058A0745', '41021203', 'TECHNI-ICE HEAVY DUTY REUSABLE - 4PLY (24 CUBE/SHEET)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 31, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1773, 'TR058A0746', '10908186', 'TEGRAL SATIN RED VELVET CAKE MIX (1KG/10PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1774, 'TR058A0747', '41011016', 'TENT CARD - ACRYLIC 5"X8" (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1775, 'TR058A0748', '41021057', 'TF6 INTERFOLDED TISSUE (67090) (1000 PCS / 10 PACKS / CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1776, 'TR058A0749', '21051681', 'TIN CAN LINER (100 PCS / PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1777, 'TR058A0750', '41021058', 'TIN CAN LINER (500 PCS / PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1778, 'TR058A0751', '31011056', 'TITAN DEGREASER (1GAL/4PC/ CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 27, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1779, 'TR058A0752', '10906147', 'TOPFIL SELECT CHERRY (2.7KG/CAN)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1780, 'TR058A0753', '12031115', 'TOPPING CANDY SLV GLTR MTLC SA (3LBS/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1781, 'TR058A0754', '12031064', 'TOPPING CINNAMON FLAKES (50LB/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1782, 'TR058A0755', '12031062', 'TOPPING COOKIE SNICKER DOODLE (10LB/BOX)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1783, 'TR058A0756', '12031081', 'TOPPING CREME BRULE FLK (30LBS/PACK/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1784, 'TR058A0757', '12031076', 'TOPPING PIE CHOPPED CHIPS  (10LB/PACK/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1785, 'TR058A0758', '10819005', 'TORANI CARAMEL SAUCE (64OZ/JAR)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 32, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1786, 'TR058A0759', '51021462', 'TORANI SAUCE PUMP 1/2 OZ 1PC', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1787, 'TR058A0760', '65001029', 'TOTE CANVAS BAG - ORIGINAL GLAZED', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1788, 'TR058A0761', '31021046', 'TOWEL, HAND - ASSTD COLOR (1 PCS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1789, 'TR058A0762', '31021047', 'TOWEL, HAND - BROWN (1 PCS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1790, 'TR058A0763', '10906211', 'TRADITIONAL CAKE FLAVOR NEW (20LB/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1791, 'TR058A0764', '65001042', 'TRANSPARENT ACRYLIC TUMBLER WITH KRISPY KREME LOGO 1 SIDE PRINT, WRAP AROUND KK DOTS AND GREEN LID', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1792, 'TR058A0765', '65001041', 'TRANSPARENT ACRYLIC TUMBLER WITH KRISPY KREME LOGO 1 SIDE PRINT, WRAP AROUND KK DOTS AND RED LID', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1793, 'TR058A0766', '41021078', 'TRAY LINER-BAKED KREATION BIG (500PC/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1794, 'TR058A0767', '41021075', 'TRAY LINER-GENERIC FOR VIZMIN (500PCS/PACK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1795, 'TR058A0768', '51011034', 'TRAY-9X26 WHITE W/KKLOGO (12PCS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1796, 'TR058A0769', '41021085', 'TRAYLINER - GENERIC (500PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1797, 'TR058A0770', '10856000', 'TROPICANA COCO QUENCH 330ML (24PK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1798, 'TR058A0771', '10816003', 'TROPICANA ORANGE (24BOT/CSTROPICANA ORANGE WITH PULP(24BOT/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1799, 'TR058A0772', '31021082', 'TUBE BRUSH, NYLON BRISTLES, S/S HANDLE - 20MM X 80MM X 120MM (10PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1800, 'TR058A0773', '31021083', 'TUBE BRUSH, NYLON BRISTLES, S/S HANDLE - 4MM X 40MM X 160MM (20PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1801, 'TR058A0774', '41021091', 'TUNE UP-KIT A  PN X25802', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1802, 'TR058A0775', '61011001', 'UMBRELLA - GREEN (PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1803, 'TR058A0776', '61011002', 'UMBRELLA - WHITE SMALL ( PIECE )', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1804, 'TR058A0777', '41051206', 'UNIFORM,  W/ KK EMBRO, FEMALE-RED', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1805, 'TR058A0778', '41051207', 'UNIFORM,  W/ KK EMBRO, FEMALE-WHITE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1806, 'TR058A0779', '41051208', 'UNIFORM,  W/ KK EMBRO, MALE-RED', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1807, 'TR058A0780', '41051209', 'UNIFORM,  W/ KK EMBRO, MALE-WHITE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1808, 'TR058A0781', '41051009', 'UNIFORM, FEMALE, WHITE (1PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1809, 'TR058A0782', '41051010', 'UNIFORM, FEMALE, YELLOW (1PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1810, 'TR058A0783', '41051013', 'UNIFORM, MALE, RED (1PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1811, 'TR058A0784', '41051011', 'UNIFORM, MALE, WHITE (1PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1812, 'TR058A0785', '41051216', 'UNIFORM, NEW KK BOWTIE, FEMALE-WHITE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1813, 'TR058A0786', '41051217', 'UNIFORM, NEW KK BOWTIE, MALE-WHITE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1814, 'TR058A0787', '10721013', 'UNSALTED BUTTER-ANCHOR (227GRAMS/40BAR/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 15, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1815, 'TR058A0788', '10721012', 'UNSALTED BUTTER-ANCHOR (454G/20BARS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 15, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1816, 'TR058A0789', '10901154', 'UNSWEETENED CHOCOLATE, PREMIUM MALAGOS 1KG x 15', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1817, 'TR058A0790', '41021090', 'URNEX TABZ COFFEE EQUIPMENT CLEANING TABLET', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1818, 'TR058A0791', '10902164', 'VANILLA FLAVOR (1LITER/BOTTLE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1819, 'TR058A0792', '10906247', 'VIVAFIL MANGO (5KGS/PAIL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1820, 'TR058A0793', '10906246', 'VIVAFIL PINEAPPLE (5KGS/PAIL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1821, 'TR058A0794', '12031012', 'WALNUT-RAW (11.34KG/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 12, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1822, 'TR058A0795', '310300418', 'WASTE NOT DISPENSER', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1823, 'TR058A0796', '10856001', 'WATER PURIFIED HOPE 330ML/12PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1824, 'TR058A0797', '41051214', 'WATERPROOF APRON W/ KK LOGO-BLACK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1825, 'TR058A0798', '41051213', 'WATERPROOF APRON W/ KK LOGO-GREEN', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1826, 'TR058A0799', '41051215', 'WATERPROOF APRON W/ KK LOGO-WHITE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1827, 'TR058A0800', '10816005', 'WELCH GRAPE JUICE (10OZ/ 24 BOT/ CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1828, 'TR058A0801', '41021260', 'WHIP CREAM CHARGER HOLDER', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1829, 'TR058A0802', '41021077', 'WHIP CREAM DISPENSER (.5L/PIECE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1830, 'TR058A0803', '10431029', 'WHIPPING CREAM SPLENDID (1L/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1831, 'TR058A0804', '10431030', 'WHIPPIT NON-DAIRY CREAM PASTE (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1832, 'TR058A0805', '65001039', 'WHITE CERAMIC MUG WITH KRISPY KREME LOGO 2 SIDES PRINT AND WRAP AROUND KK DOTS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1833, 'TR058A0806', '10902219', 'WHITE CHOCOLATE FLAVOR WC-015347 (1L/BTL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1834, 'TR058A0807', '10906128', 'WHITE CUSTARD FILLING (5KG/TUB)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 22, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1835, 'TR058A0808', '10721007', 'WHITE ICING BASE - LOW TRANS (30LB/PAIL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1836, 'TR058A0809', '10902228', 'WINTERMELON FLAVOR (300ML/36BOT/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1837, 'TR058A0810', '21091000', 'WOODEN COFFEE STIRRER - LOCAL(500PC/PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1838, 'TR058A0811', '21091001', 'WOODEN STIRRER - ONLINE (500PCS/PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1839, 'TR058A0812', '21101016', 'WOODEN STIRRER 5.5" 1000PCS/PACK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1840, 'TR058A0813', '21101017', 'WOODEN STRIRRER 7" WITH WRAP 100PC/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1841, 'TR058A0814', '10906198', 'XANTHAN GUM  (5KGS/BAG)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 5, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1842, 'TR058A0815', '11061003', 'YEAST DOUGHNUT MIX (50LB/ SACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 9, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1843, 'TR058A0816', '11061001', 'YF1 SWEET DOUGH BASE (50LB/SACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 9, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1844, 'TR058A0817', '65001064', 'ORIGINAL T-SHIRT S', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'In-Active', 'Fast Moving', 'High Value', 1, 1),
	(1845, 'TR058A0818', '65001065', 'ORIGINAL T-SHIRT M', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1846, 'TR058A0819', '65001066', 'ORIGINAL T-SHIRT L', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1847, 'TR058A0820', '65001067', 'ORIGINAL T-SHIRT XL', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1848, 'TR058A0821', '10442003', 'SOY MILK - VITASOY 1L/12PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1849, 'TR058A0822', '21051683', 'CORRUGATED COFFEE SLEEVES 12/16/20oz  (50PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 20, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1850, 'TR058A0823', '10906283', 'CARAT SUPERCREM 8KG/PL', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1851, 'TR058A0824', '11041024', 'ROASTED PEANUT FINES 500G/30PCK/BOX', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1852, 'TR058A0825', '10906284', 'CREME CUSTARD (2KG/9PACKS/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1853, 'TR058A0826', '21051701', 'OG BITES TRAYLINER 100PC/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1854, 'TR058A0827', '65001073', 'DOUGHNUT TOWER ECO BAG', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1857, 'TR058A0830', '81016057', 'BLUEBERRY KRUFFINS (BATTER PREMIX) 1 PIECE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1858, 'TR058A0831', '12041005', 'SPRINKLE - YELLOW (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1859, 'TR058A0832', '65001062', 'DOUGHNUT TOWER BOX 500 X 50 X 380MM B-FLUTE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1860, 'TR058A0833', '65001052', 'ACRYLIC 3MM DOUGHNUT TOWER 3DOZEN', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1861, 'TR058A0834', '65001050', 'ACRYLIC 3-MM DOUGHNUT TOWER 3-TIER 14', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1862, 'TR058A0835', '10852047', 'HINELEBAN COFFEE - 100% ARABICA 1KG/10PCK/BOX', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1863, 'TR058A0836', '10904131', 'COLLATTA DARK CHOCOLATE GLAZE 5KG/PL', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1864, 'TR058A0837', '41021257', 'RACK COVER W/ BROWN ZIPPER-MEDIUM', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1865, 'TR058A0838', '41021251', 'RACK COVER W/ RED ZIPPER-MEDIUM', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1866, 'TR058A0839', '10442005', 'FRESH MILK HANNA 1L/12PCKS/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1867, 'TR058A0840', '10832037', 'SOFTDRINKS PEPSI REGULAR 250ML 24CAN/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1868, 'TR058A0841', '65061002', 'DOUGHTNUT TOWER NOTECARD', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1869, 'TR058A0842', '65001053', 'SOB 5MM DOUGHNUT TOWER 3-TIER 12 (3 Dozen)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1870, 'TR058A0843', '65001051', 'SOB 5MM DOUGHNUT TOWER 3-TIER 14 (5 Dozen)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1871, 'TR058A0844', '41051259', 'FACESHIELD WITH HAT', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1872, 'TR058A0845', '41061009', 'FOLDABLE BED', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1873, 'TR058A0846', '31021096', '70% ISOPROPYL ALCOHOL, SAFECARE BACTOFREE THIN 4X3.5L/BOX', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1874, 'TR058A0847', '41051260', 'SAFETY LONG SLEEVES WHITE SHIRT', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1875, 'TR058A0848', '41021266', 'SURGICAL MASK 3 PLY 50PC X 1PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1876, 'TR058A0849', '41021268', 'MANUAL KNAPSACK SPRAYER 16L - JB KAWASAKI', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 30, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1877, 'TR058A0850', '41021043', 'GLOVES VINYL, LARGE(50PAIR/BOX)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1878, 'TR058A0851', '41071419', 'SPRAY BOTTLE 500ML - BLACK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1879, 'TR058A0852', '41021267', 'INFRARED BODY THERMOMETER', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 30, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1880, 'TR058A0853', 'TEMPO06', 'STOMP MAT, 2x2FT (MAT & TRAY)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 30, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1881, 'TR058A0854', '10906286', 'COLLATA CAPPUCINO GLAZE 5KG/PL', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1882, 'TR058A0855', '10901173', 'CHOCO MOOD POWDER 1KG/15PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1883, 'TR058A0856', '12011007', 'SALTED CARAMEL FUDGE TOPPING 1.25KG/12CK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1884, 'TR058A0857', '12031214', 'CRUSHED ROCA ALMOND TOFFEE 1KG/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1885, 'TR058A0858', '10611014', 'NERDS RAINBOW 1KG/12PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1886, 'TR058A0859', '31021099', 'ALCOHOL ETHYL 70% 6GAL/BOX', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1887, 'TR058A0860', '10852049', 'COFFEE BEAN ESPRESSO (82) 500G/20PACK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1888, 'TR058A0861', '21071023', 'CPLA STRAW 12MM 100PCS/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1889, 'TR058A0862', '21071024', 'CPLA STRAW 8MM 500PCS/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1891, 'TR058A0864', '65001061', 'ROYALTY X KRISPY KREME NYLON POLY FANNY PACK 1PC/1PC', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1892, 'TR058A0865', '65001059', 'ROYALTY X KRISPY KREME VARSITY JACKET 1PC/1PC', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1893, 'TR058A0866', '65001071', 'ROYALTY X KRISPY KREME MEDIUM ENAMEL WHITE MUG 1PC/1PC', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1894, 'TR058A0867', '21051669', 'HANDLE STRIP SINGLE FOR BOX 12S - CC (100PC/PCK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1895, 'TR058A0868', '21061369', 'KK DOUGHNUT BITES SAUCE LID TRANSPARENT (100PC/PCK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1896, 'TR058A0869', '21061370', 'KK DOUGHNUT BITES SAUCE CUP TRANSPARENT (100PC/PCK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1897, 'TR058A0870', '10901123', 'CHOCO SUPER COMPOUND ELMER 1KILO 12PCKS/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1898, 'TR058A0871', '10901148', 'CHOCOLATE COMPOUND PREMIUM TROPICAL YELLOW BANAA FLAVOURED, ELEMER 1KG/PCK 12PCKS/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1899, 'TR058A0872', '10901157', 'CHOCOLATE COMPOUND PREMIUM TROPICAL GREEN MELON FLAVOURED, ELMER 1KG/PCK 12PCKS/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1900, 'TR058A0873', '10832045', 'MILKIS STRAWBERRY (250 ML/CAN)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1901, 'TR058A0874', '10832046', 'MILKIS MILK (250ML/CAN)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1902, 'TR058A0875', '21061374', 'THERMAL BAG (BIG), L 19 Ãƒâ€šÃ‚Â½" X W 8 Ãƒâ€šÃ‚Â¼" X H 9 Ãƒâ€šÃ‚Â¾" PC/PC', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1903, 'TR058A0876', '21061373', 'THERMAL BAG (SMALL), L 8 Ãƒâ€šÃ‚Â¾" X W 8 Ãƒâ€šÃ‚Â¼" X H 9 Ãƒâ€šÃ‚Â¾" PC/PC', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1904, 'TR058A0877', '65001054', 'WHITE CERAMIC MUG KK LOGO 16OZ 1PIECE/PIECE UOM PC', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1905, 'TR058A0878', '10852050', 'RTB - ROASTED COFFEE SMOOTH (250G X 40 PACKS / CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1906, 'TR058A0879', '10871002', 'RTB - ROASTED COFFEE RICH (250G X 40 PACKS / CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1907, 'TR058A0880', '21061379', 'READY TO BREW BEAN LABEL STICKER (1 PIECE) ', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1908, 'TR058A0881', '31031058', 'CHEMICAL SPRAYER 16L', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 30, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1909, 'TR058A0882', '10906279', 'ACTIVATED CHARCOAL', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1911, 'TR058A0884', '10901174', 'KESSLERS ALKALIZED COCOA POWDER 3KG/12PCKS/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1912, 'TR058A0885', '12031216', '4D GUMMIE BLOCK 20G/500PCS/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1913, 'TR058A0886', '41021010', 'PIPING BAG ULTRA-CLEAR 21" KEE-SEAL 72 PCS/ROLL', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1914, 'TR058A0887', '81012040', 'ROUND EYE CANDY TOPPERS 70 PCS/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1915, 'TR058A0888', '81012041', 'RIP CANDY TOPPERS 12 PCS/PACK UMO PACK                                                                            ', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1916, 'TR058A0889', '21051119', 'PAPER BAG 12 (100PC/BUNX20) NEW', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 25, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1917, 'TR058A0890', '10902153', 'FOOD COLOR - LEMON YELLOW (20OZ/BOT)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1918, 'TR058A0891', '10902231', 'FOOD COLOR - SUNSET ORANGE (20OZ/BOT)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1919, 'TR058A0892', '10818017', 'WATER PURIFIED AQUAFINA 350ML/24BOTTLES', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1920, 'TR058A0893', '10512036', 'DRIED SWEETENED CRANBERRIES, 1KG/PACK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1921, 'TR058A0894', '10512039', 'PUMPKIN SEEDS, 1KG/PACK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1922, 'TR058A0895', '12031217', 'ROASTED PISTACHIO NUTS, CHOPPED & UNSALTED (1KG/15PCK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1923, 'TR058A0896', '12031218', 'ROASTED CASHEW NUTS, CHOPPED & UNSALTED(1KG/15PCK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1924, 'TR058A0897', '12031219', 'ROASTED CASHEW MEALS,(1KG/15PACK/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1925, 'TR058A0898', '10442010', 'OATLY OAT MILK (1LITER/6PACK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1927, 'TR058A0900', '41051267', 'WASHABLE FACE MASK, KRISPY KREME, CREAM (15PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1928, 'TR058A0901', '12031221', 'ROASTED ALMOND NUTS, CHOPPED & UNSALTED, 1KG/15PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1929, 'TR058A0902', '21071025', 'CPLA STRAW 8MM (250PC/20PCK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1930, 'TR058A0903', '12031223', 'FLEUR DE SEL SALT 200G/PACK ', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1931, 'TR058A0904', '12031222', 'GRAHAM CRACKER CRUNCH 500G/PACK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1932, 'TR058A0905', '12031089', 'CINNAMON POWDER (200 G/PCK,5PCKS/BAG)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1933, 'TR058A0906', '10901178', 'CHOCOLATE WHITE COMPOUND COKLAT 2KG/ 10 PACKS/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1934, 'TR058A0907', 'TEMPO 08', 'OREO SNACK PACK 28.5GC', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1935, 'TR058A0908', '10901176', 'TWIX CARAMEL 10.83OZ/20PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1936, 'TR058A0909', '10901175', 'MALTESERS 150G/20PCKS/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1937, 'TR058A0910', '81012042', 'RED CANDY TOPPERS PCS/PACK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1938, 'TR058A0911', '41061010', 'COFFEE FILTER FOR CART 4 1/2 X 2 3/5 (2X250PCS/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1939, 'TR058A0912', '21071026CPLA STRAW 12MM (100PCS/25PCK/CS)', 'CPLA STRAW 12MM (100PCS/25PCK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1940, 'TR058A0913', '21051722', 'CUP CARRIER X2 UNPRINTED 100PC/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1941, 'TR058A0914', '21051710', 'HOT CUP 80z WHITE PLAIN (50 pcs/20 packs/case)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1942, 'TR058A0915', '10901180', 'CALLEBAUT WHITE CHOCOLATE CRISPEARLS, 800GRAMS/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1943, 'TR058A0916', '10901179', 'CALLEBAUT RUBY CHOCOLATE, 2.5KG/4PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1944, 'TR058A0917', '10902233', 'PISTACHIO POWDER 20-PA-0501, 100G/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1945, 'TR058A0918', '10902234', 'PISTACHIO PASTE, 1KG/PACK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1946, 'TR058A0919', '11071040', 'RICE CRISPIES, 300G/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1947, 'TR058A0920', '10441069', 'CREAM WHIPPED 1L/ 12 PACKS/ CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1948, 'TR058A0921', '10901184', 'CALLEBAUT RUBY CHOCOLATE, 1KG/1PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1949, 'TR058A0922', '12031212', 'EDIBLE FLOWER ROSE PETALS 50G/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1950, 'TR058A0923', '12031225', 'SPRINKLES - MINI HEART, 125GRAMS/PACK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1951, 'TR058A0924', '10907247', 'SALTED CARAMEL SAUCE - VENEZIA (2L/4BTL/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1952, 'TR058A0925', '10814008', 'RICH BLEND BEANS, 500GRAMS/PCk', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1953, 'TR058A0926', '10902236', 'NATURAL SEA SALT (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1954, 'TR058A0927', '11061007', 'VANILLA POWDER (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1955, 'TR058A0928', '10902237', 'SPRINKLE-RAINBOW (LOCAL) 1KG/10PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1956, 'TR058A0929', '21071020', 'STRAW - PLASTIC ORANGE 8" (LOCAL) (500 PCS X 12 SLEEVES / CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1957, 'TR058A0930', '11071041', 'RICE CRISPIES, 250GRAMS/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1958, 'TR058A0931', '65001056', 'PARKLAND X KK KINGSTON BACK PACK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1959, 'TR058A0932', '65001057', 'PARKLAND X KK KINGSTON LOOKOUT SMALL DUFFLE BAG', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1960, 'TR058A0933', '65001058', 'PARKLAND X FERGIE BELT BAG', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1961, 'TR058A0934', '10611018', 'JELLY BEANS-JELLY BELLY (STRAWBERRY), 240PCS/PCk', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1962, 'TR058A0935', '10611016', 'FINI LICORICE FANTASY BELTS BULK, 1.6KG/TUB', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 22, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1963, 'TR058A0936', '10611017', 'ALBANESE SOUR LARGE NEON GUMMI WORMS BULK, 100PCS/1KG/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1964, 'TR058A0937', '10611021', 'JELLY BEANS - JELLY BELLY CRUSHED (PINEAPPLE) 240PCS/PACK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1965, 'TR058A0938', '10819006', 'CARAMEL SYRUP VENEZIA (750LM/6BOT/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1966, 'TR058A0939', '10910165', 'MONIN PEACH FRUIT MIX, 1LITER/4BOTTLES/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1967, 'TR058A0940', '10611019', 'POPPING CANDY STRAWBERRY (5G), 20PCS/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1968, 'TR058A0941', '10611020', 'POPPING CANDY ORANGE (5G), 20PCS/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1969, 'TR058A0942', '11041000', 'PEANUT BUTTER (1KG/BOT)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1970, 'TR058A0943', '10514031', 'NESTLE CUCUMBER LEMONADE, 200GRAM/12PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1971, 'TR058A0944', '10514032', 'NESTLE PINK LYCHEE LEMONADE, 200GRAM/12PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1972, 'TR058A0945', '41061020', 'TPE GLOVES MEDIUM, 100PCS/20PCK/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1973, 'TR058A0946', '41061021', 'TPE GLOVES LARGE, 100PCS/20PCK/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1974, 'TR058A0947', '10512045', 'MARSHMALLOW - WHITE, 680GRAMS/4PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1975, 'TR058A0948', '11041027', 'ROASTED PEANUT FINES 1KG/15PCK/BOX', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1976, 'TR058A0949', '10851018', 'KK CHOCOLATE SYRUP - HJ388 (2KG/9PCK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1977, 'TR058A0950', '10906290', 'INSTANT YEAST SAF GOLD 500G/20 PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1978, 'TR058A0951', '10902238', 'SPICE APPLE FILLING, 5KG/4BAGS/BOX', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 5, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1979, 'TR058A0952', '10515035', 'PEACH FRUIT FILLING (6KG/PAIL)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1980, 'TR058A0953', '10901177', 'REESES PEANUT BUTTER SAUCE, 2.04KG/6BOTTLES/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1981, 'TR058A0954', '12031227', 'PEACH FILLING (1KG/10PCK/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1982, 'TR058A0955', '10611022', 'CHOCOLATE SPRINKLES 500g/10PCKS/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1983, 'TR058A0956', '10819007', 'CARAMEL SYRUP MONIN 700ML', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1984, 'TR058A0957', '10611023', 'SPRINKLE - RAINBOW (500G)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1985, 'TR058A0958', '10901186', 'Chocolate Shavings (500g)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1986, 'TR058A0959', '12011008', 'REESES MINI PIECES PEANUT BUTTER CRUNCHY SHELL BULK, 300G/PACK                                                                                 ', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1987, 'TR058A0960', '10901182', 'REESES CHOPPED ICE CREAM TOPPING, 300G', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1988, 'TR058A0961', '10902239', 'SALTED CARAMEL FUDGE, 2KG/10PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1989, 'TR058A0962', '12041006', 'SPRINKLES - PINK (1 KG/ PK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1990, 'TR058A0963', '11071043', 'COFFEE POWDER, 1KG/10PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1991, 'TR058A0964', '10902243', 'BLUE SANDING SUGAR, 1KG/PACK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1992, 'TR058A0965', '10902240', 'NFH COTTON CANDY FLAVOR (L-1028)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1993, 'TR058A0966', '10902242', 'NFH FRENCH VANILLA FLAVOR (FHI-#20-L-M-0127) - 3mol/btl', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1994, 'TR058A0967', '10902241', 'SONLIE VANILLA BEAN SEED PASTE - 1kg /pack', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1995, 'TR058A0968', '11041028', 'ROASTED WALNUT CHOPPED, 1KG/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 12, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1996, 'TR058A0969', '10812019', 'SOFTDRINKS PEPSI REGULAR 600ML (24BOT/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1997, 'TR058A0970', '10901188', 'DLA BAKESTABLE DARK COMPOUND CHOCOLATE, 7000PCS/2KG/PACK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(1999, 'TR058A0972', '10522048', 'BANANA TOPPING AND FILLING - 6kgs/pail', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 20, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2000, 'TR058A0973', '51021511', 'VOLLRATH DISHER 3/4OZ', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2001, 'TR058A0974', '10611025', 'AALST DARK CHOCOLATE COATING - SND4315, (5KG/2PACKS/BOX)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2002, 'TR058A0975', '10611024', 'MARSHMALLOW-MINI,  PINK (750G/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2003, 'TR058A0976', '10817002', 'BLUE DIAMOND ALMOND BREEZE MILK - ORIGINAL, 946ML/12PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2004, 'TR058A0977', '10910166', 'MONIN VANILLA SYRUP (1LITER/BOT)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2005, 'TR058A0978', '10907255', 'DAVINCI GOURMET SALTED CARAMEL SAUCE (2L/3JUGS/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 13, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2006, 'TR058A0979', '12031083', 'CHIPS AHOY ORIGINAL CHOCO CHIP COOKIE (266G/12PACK/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2007, 'TR058A0980', '10515037', 'LA FRUTA BANANA TOPPING & FILLING, 610ML/CAN', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2008, 'TR058A0981', '81113155', 'KK - CHOCOLATE CHIP COOKIE DOUGH, CUBED (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2009, 'TR058A0982', '81113154', 'KK - BROWNIES, CUBED (1KG/PACK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2010, 'TR058A0983', '310367019', 'KAY DISPENSER RACK WITH BASKET', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2011, 'TR058A0984', '21061439', 'HANDLE STRIP DOUBLE FOR BOX6S -BIRTHDAY 100pcs/pack)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2013, 'TR058A0986', '21061441', 'HANDLE STRIP SINGLE FOR BOX 6S-BIRTHDAY (100pcs/pack)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2014, 'TR058A0987', '21061440', 'HANDLE STRIP FOR BOX 12S-BIRTHDAY (50PC/PCK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2015, 'TR058A0988', '10611026', 'CHOCOLATE WHITE IVANA 2KG/10 PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2016, 'TR058A0989', 'TEMPO 09', 'SNACK PACK CHIPS AHOY', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2017, 'TR058A0990', '10901192', 'MORECOA DARK COMPOUND BLOCKS, 1KG/10PACKS/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2018, 'TR058A0991', '10512047', 'DULCE DE LECHE FILLING, 5KG/PAIL', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2019, 'TR058A0992', 'TEMPO 10', 'MIXING PITCHER WHITE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2020, 'TR058A0993', '21051706', 'HOT LID 12/16/20OZ RED 100PC/10PCK/CSÃƒâ€šÃ‚Â ', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2021, 'TR058A0994', '21051705', 'HOT CUP 20OZ WHITE 50PC/20PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2022, 'TR058A0995', '11071047', 'CEREAL - KOKO KRUNCH, 170GRAMS/10PACKS/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2023, 'TR058A0996', '11071048', 'CEREAL - HONEY STARS, 150GRAMS/10PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2024, 'TR058A0997', '10661001', 'KELLOGS FROOT LOOPS, 400GRAMS/10PCK/CS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2025, 'TR058A0998', '10902246', 'PUMPKIN SPICE BLEND, 500G/5PACKS/BOX', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2026, 'TR058A0999', '10902248', 'FOOD COLOR - ORANGE POWDER, 500G/TUMBLER', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 22, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2027, 'TR058A1000', '10905121', 'COFFEE JELLY (1.9KG/6BOTTLES/CASE)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2028, 'TR058A1001', '10813007', 'HERSHEYS CHOCOLATE SYRUP (650G/24BT/CS)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2029, 'TR058A1002', '10431036', 'MAGNOLIA CREAM CHEESE SPREAD, 220GRAMS/24BOTTLES/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2030, 'TR058A1003', 'TEMPO 11', 'PEPSI REGULAR 850 ML', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2031, 'TR058A1004', '10661004', 'CHOCOLATE TOPPER - LIPS, 360PCS/BOX', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2032, 'TR058A1005', '10651003', 'CHOCOLATE TOPPER - PUMPKIN MOUTH (YELLOW), 180PCS/BOX', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2033, 'TR058A1006', '10611030', 'CHOCOLATE TOPPER - NEON GREEN EYES W/ LASHES, 360PCS/BOX', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2034, 'TR058A1007', '10651004', 'CHOCOLATE TOPPER - VNECK FOR JACKS BODY/ SPIDER, 90PCS/BOX', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2035, 'TR058A1008', 'TEMPO 12', 'CHOCOLATE TOPPER - PUMPKIN EYES & NOSE PCS/BOX', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2036, 'TR058A1009', '51021515', 'DECORATING TIP #233', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2037, 'TR058A1010', '41021269', 'TRIANGLE COOKIE CUTTER', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 38, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2038, 'TR058A1011', 'TEMPO 13', 'PILLOW NECK - VIOLET', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2039, 'TR058A1012', 'TEMPO 14', 'PILLOW NECK - YELLOW', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2040, 'TR058A1013', 'TEMPO 15', 'OREO  PILLOW', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2041, 'TR058A1014', 'TEMPO 16', 'OREO C.P HOLDER', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2042, 'TR058A1015', 'TEMPO 17', 'THERMAL BAG - YELLOW', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2043, 'TR058A1016', 'TEMPO 18', 'THERMAL BAG - VIOLET', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2044, 'TR058A1017', 'TEMPO 19', 'KK CARE KITS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2045, 'TR058A1018', '11021039', 'ALL PURPOSE OLD FASHIONED-LT (LOCAL) 25KG/BAG', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 5, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2046, 'TR058A1019', 'TEMPO 20', 'BEAR BRAND STERILIZED', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2047, 'TR058A1020', '41021271', ' CREAM CHARGER (24PCS /PCK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2048, 'TR058A1021', 'TEMPO 21', 'KELLOGS STRAWBERRY CORN FLAKES', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 39, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2049, 'TR058A1022', 'TEMPO 22', 'KELLOGS BANANA CORN FLAKES', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 39, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2050, 'TR058A1023', '41021270', 'WATERPROOF APRON, BROWN', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2051, 'TR058A1024', '10661002', 'SPRINKLES - GOLD STAR, 500G/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2052, 'TR058A1025', '10661003', 'SPRINKLES - GOLD UNICORN, 1KG/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2053, 'TR058A1026', 'TEMPO 23', 'ASSORTED SAFETY KITS', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 25, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2054, 'TR058A1027', 'TEMPO 24', 'KK RED CAP NEW ERA', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2055, 'TR058A1028', '21051724', 'KK KRAFT PAPER BAG - 6S 100PCS/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2056, 'TR058A1029', '10651005', 'CHOCOLATE TOPPER - ELEPHANTS TRUNK 3D, 180PCS/BOX', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2057, 'TR058A1030', '10651006', 'CHOCOLATE TOPPER - CHRISTMAS HAT TALL VERSION, 180PCS/BOX', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2058, 'TR058A1031', '10651007', 'CHOCOLATE TOPPER - LIONS SNOUT, 180PCS/BOX', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2059, 'TR058A1032', '10611032', 'TEABERRY SHAPED SPRINKLES - STAR GOLD', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2060, 'TR058A1033', '10611033', 'TEABERRY SHAPED SPRINKLES - UNICORN GOLD', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2061, 'TR058A1034', '10661005', 'GUMPASTE TOPPER - CONFETTI BLACK, (APPROX. 6,000PCS), 500GRAMS/BOX', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2062, 'TR058A1035', 'TEMPO 25', 'SHORTENING FLAKES', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 8, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2063, 'TR058A1036', '10651010', 'RED MINI LENTILS BULK, 1KG/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2064, 'TR058A1037', '21021009', 'GLAZZINE BAG, SMALL PLAIN  (100pcs/pack)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2065, 'TR058A1038', '21051725', 'KK KRAFT PAPER BAG - 12S 50PCS/PCK', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2066, 'TR058A1039', 'TEMPO 26', 'ASSORTED CHRISTMAS DECOR', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2067, 'TR058A1040', '21051731', 'KK BOX 6S ORIGINAL-DFD (100PC/PCK)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2068, 'TR058A1041', '10641003', 'MY SAN HONEY CRACKERS 25g, (10pcs/30packs/case)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2070, 'TR058A1043', '10641002', 'MY SAN GRAHAM-CRUSHED (200G/24packs/case)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2071, 'TR058A1044', '10651012', 'HERSHEYS BAKING PCS. DARK 12 OZ. (12packs/case)', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2072, 'TR058A1045', '13081001', 'DOUBLE CHOCOLATE CHILLER SYRUP, 88.18OZ/6GALLONS/CASE', 50, '1', '4', '15', '25', 1, 1, 1, 1, 1, 25, 27, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2073, 'GP014A0040', '40', 'BERYLS 24 PERCENT WHITE CHOCOLATE COMPOUND 1KG X 1', 17, '1', '4', '21', '25', 1, 1, 1, 10, 1, 72, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2074, 'GP014A0041', '41', 'BERYLS SEMISWEET CHOCOLATE COMPOUND 1KG X 10', 17, '1', '4', '21', '25', 1, 1, 1, 10, 1, 72, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2075, 'GP014A0042', '43', 'BERYLS DARK CHOCOLATE CHIPS 8800CTS 1KGX10 ', 17, '1', '4', '21', '25', 1, 1, 1, 10, 1, 40, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2076, 'GP014A0043', '42', 'BERYLS WHITE CHOCOLATE CHIPS 4400CTS 1KGX10', 17, '1', '4', '21', '25', 1, 1, 1, 10, 1, 40, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2077, 'GP014A0044', '44', 'BERYLS DARK COMPOUND CHIPS 4400CTS 1KGX10', 17, '1', '4', '21', '25', 1, 1, 1, 10, 1, 40, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2078, 'AA015A0117', '822BB', 'FRESH FROZEN DEBONED UNSEASONED S (FFD - LOCAL S(200-300))', 18, '2', '1', '-18', '-25', 1, 1, 1, 1, 1, 15, 4, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2079, 'MT023A0124', 'TEMPO11', 'CHICKEN LEG MEAT BLSO - SEARA', 26, '1', '1', '-25', '-18', 1, 1, 1, 12, 1, 61, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2080, 'MT023A0125', 'TEMPO12', 'PORK FEMUR BONES - CAMPOFRIO', 26, '1', '1', '-25', '-18', 1, 1, 1, 12, 1, 56, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2083, 'PN179A0001', '1', 'F. Chicken Whole Leg "CASE FARM"', 118, '1', '1', '-25', '-18', 1, 1, 1, 15, 1, 56, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2084, 'PN179A0002', '2', 'F. Chicken Whole Leg "SIMMONS"', 118, '1', '1', '-25', '-18', 1, 1, 1, 15, 1, 56, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2085, 'MM178A0001', '3', 'FROZEN CHICKEN WINGS - AURORA', 117, '1', '1', '-25', '-18', 1, 1, 1, 15, 1, 50, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2086, 'MM178A0002', '5', 'OLYMEL PORK SHOULDER BONE IN', 117, '1', '1', '-25', '-18', 1, 1, 1, 0, 1, 28, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2087, 'MM178A0003', '6', 'P. BELLY BISO FLANK OFF-BEULAIGNE', 117, '1', '1', '-25', '-18', 1, 1, 1, 0, 1, 30, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2088, 'SA008A0001', 'SFC0008', 'SHRIMP VANNAMEI HLSO 21/25', 12, '1', '1', '-22', '-18', 1, 1, 1, 10.8, 1, 40, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2089, 'SA008A0002', 'SFC0009', 'CRABLETS', 12, '1', '1', '-22', '-18', 1, 1, 1, 10, 1, 40, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2090, 'SA008A0003', 'SFC0010', 'SHRIMP NOBASHI EBI 11GMS', 12, '1', '1', '-22', '-18', 1, 1, 1, 9.9, 1, 36, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2091, 'SA008A0004', 'SFC0012', 'FROZEN HALF SHELL SCALLOP', 12, '1', '1', '-22', '-18', 1, 1, 1, 10, 1, 42, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2092, 'CD119A0001', '1', 'SHOESTRING 12KG', 77, '1', '1', '-25', '-18', 39, 25, 33, 12, 1, 40, 3, 1, '', 5, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2093, 'CD119A0002', '2', 'CRINKLE 12KG', 77, '1', '1', '-25', '-18', 1, 1, 1, 12, 1, 40, 3, 1, '', 5, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2094, 'EN181A0001', '5', 'PORK CUTTING FAT- ROSDERRA', 120, '1', '1', '-25', '-18', 1, 1, 1, 25, 1, 35, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2095, 'DB180A0001', 'TEMPO01', 'PRONIVEL 4000 IU', 119, '1', '3', '0', '5', 1, 1, 1, 1, 1, 6, 3, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2096, 'AM182A0001', NULL, 'CHICKEN SKIN FAT - S', 121, '1', '1', '-25', '-18', 1, 1, 1, 10, 1, 66, 7, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2097, 'AM182A0002', NULL, 'PORK MASK - S', 121, '1', '1', '-25', '-18', 1, 1, 1, 12, 1, 54, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2098, 'HT093A0001', NULL, 'FLOUR CAKE', 68, '1', '1', '-25', '-18', 1, 1, 1, 1, 1, 72, 3, 1, '', 15, 1, 1, 'Hold', 'Fast Moving', 'High Value', 1, 1),
	(2099, 'HT093A0002', NULL, 'ANCHOVIE', 68, '1', '1', '-25', '-18', 1, 1, 1, 1, 1, 72, 3, 1, '', 15, 1, 1, 'Hold', 'Fast Moving', 'High Value', 1, 1),
	(2100, 'HT093A0003', NULL, 'KODARI', 68, '1', '1', '-25', '-18', 1, 1, 1, 1, 1, 72, 20, 1, '', 15, 1, 1, 'Hold', 'Fast Moving', 'High Value', 1, 1),
	(2101, 'HT093A0004', NULL, 'CHEESE RICE CAKE', 68, '1', '1', '-25', '-18', 1, 1, 1, 1, 1, 72, 3, 1, '', 15, 1, 1, 'Hold', 'Fast Moving', 'High Value', 1, 1),
	(2102, 'HT093A0005', NULL, 'WASABI', 68, '1', '1', '-25', '-18', 1, 1, 1, 1, 1, 72, 3, 1, '', 15, 1, 1, 'Hold', 'Fast Moving', 'High Value', 1, 1),
	(2103, 'HT093A0006', NULL, 'SWEET POTATO', 68, '1', '1', '-25', '-18', 1, 1, 1, 1, 1, 72, 3, 1, '', 15, 1, 1, 'Hold', 'Fast Moving', 'High Value', 1, 1),
	(2104, 'HT093A0007', NULL, 'ASSORTED KOREAN ITEMS', 68, '1', '1', '-25', '-18', 1, 1, 1, 1, 1, 72, 3, 1, '', 15, 1, 1, 'Hold', 'Fast Moving', 'High Value', 1, 1),
	(2105, 'HT093A0008', NULL, 'DRIED FISH', 68, '1', '1', '-25', '-18', 1, 1, 1, 1, 1, 72, 3, 1, '', 15, 1, 1, 'Hold', 'Fast Moving', 'High Value', 1, 1),
	(2106, 'HT093A0009', NULL, 'COLD NOODLES', 68, '1', '1', '-25', '-18', 1, 1, 1, 1, 1, 72, 3, 1, '', 15, 1, 1, 'Hold', 'Fast Moving', 'High Value', 1, 1),
	(2107, 'HT093A0010', NULL, 'GLASS NOODLE', 68, '1', '1', '-25', '-18', 1, 1, 1, 1, 1, 72, 3, 1, '', 15, 1, 1, 'Hold', 'Fast Moving', 'High Value', 1, 1),
	(2108, 'HT093A0011', NULL, 'F.CUT SWIMMING CRAB', 68, '1', '1', '-25', '-18', 1, 1, 1, 1, 1, 72, 3, 1, '', 15, 1, 1, 'Hold', 'Fast Moving', 'High Value', 1, 1),
	(2109, 'HT093A0012', NULL, 'F. WHOLE ROUND CRAB', 68, '1', '1', '-25', '-18', 1, 1, 1, 1, 1, 72, 3, 1, '', 15, 1, 1, 'Hold', 'Fast Moving', 'High Value', 1, 1),
	(2110, '1N143A0001', '1N143CS0002', 'SAMPLE RELEASE REAGENT', 90, '1', '3', '0', '5', 1, 1, 1, 1, 1, 1254, 4, 1, '', 13, 1, 1, 'In-Active', 'Fast Moving', 'High Value', 1, 1),
	(2111, '1N143A0002', '1N143CS0004', 'SAMPLE STORAGE REAGENT', 90, '1', '3', '0', '5', 1, 1, 1, 1, 1, 1275, 4, 1, '', 13, 1, 1, 'In-Active', 'Fast Moving', 'High Value', 1, 1),
	(2112, '1N143A0003', '1N143C00003', '0.2 ML PCR TUBE', 90, '1', '3', '0', '5', 1, 1, 1, 1, 1, 1354, 4, 1, '', 13, 1, 1, 'In-Active', 'Fast Moving', 'High Value', 1, 1),
	(2113, '1N143A0004', 'TEMPO03', 'MOLACCU COVID-19 DETECTION KIT', 90, '1', '1', '0', '5', 1, 1, 1, 1, 1, 100, 4, 1, '', 14, 1, 1, 'In-Active', 'Fast Moving', 'High Value', 1, 1),
	(2114, '1N143A0005', 'TEMPO05', 'NUCLEIC ACID DIAGNOSTIC KIT x 48 test kits', 90, '1', '1', '0', '5', 1, 1, 1, 1, 1, 1260, 4, 1, '', 14, 1, 1, 'In-Active', 'Fast Moving', 'High Value', 1, 1),
	(2115, 'BE184A0001', '1', 'SPINACH BALL X10KG', 123, '1', '1', '-25', '-18', 1, 1, 1, 10, 1, 48, 3, 1, '', 5, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2116, 'BE184A0002', '2', 'IQF BLUEBERRY X10KG', 123, '1', '1', '-25', '-18', 1, 1, 1, 10, 1, 50, 3, 1, '', 5, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2120, 'BE184A0003', '3', 'IQF STRAWBERRY X10KG', 123, '1', '1', '-25', '-18', 1, 1, 1, 10, 1, 50, 3, 1, '', 5, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2121, 'MP013A0022', 'Test', 'test', 16, '1', '1', '-25', '-30', 1, 1, 1, 0, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2159, 'AA015A0118', '2805BB', '(2805BB) SARANGANI BAY RAW, PEELED AND DEVEINED (SBRPD 21/25 21/25)', 18, '2', '1', '-18', '-25', 1, 1, 1, 1, 1, 10, 4, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2160, 'MF059A0598', 'RMDC00100010046', '2021RB Candle #0 - Blue - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2161, 'MF059A0599', 'RMDC00100010056', '2021RB Candle #0 - Lavander - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2162, 'MF059A0600', 'RMDC00100010047', '2021RB Candle #1 - Blue - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2163, 'MF059A0601', 'RMDC00100010057', '2021RB Candle #1 - Lavander - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2164, 'MF059A0602', 'RMDC00100010048', '2021RB Candle #2 - Blue - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2165, 'MF059A0603', 'RMDC00100010058', '2021RB Candle #2 - Lavander - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2166, 'MF059A0604', 'RMDC00100010049', '2021RB Candle #3 - Blue - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2167, 'MF059A0605', 'RMDC00100010059', '2021RB Candle #3 - Lavander - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2168, 'MF059A0606', 'RMDC00100010050', '2021RB Candle #4 - Blue - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2169, 'MF059A0607', 'RMDC00100010060', '2021RB Candle #4 - Lavander - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2170, 'MF059A0608', 'RMDC00100010051', '2021RB Candle #5 - Blue - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2171, 'MF059A0609', 'RMDC00100010061', '2021RB Candle #5 - Lavander - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2172, 'MF059A0610', 'RMDC00100010052', '2021RB Candle #6 - Blue - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2173, 'MF059A0611', 'RMDC00100010062', '2021RB Candle #6 - Lavander - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2174, 'MF059A0612', 'RMDC00100010053', '2021RB Candle #7 - Blue - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2175, 'MF059A0613', 'RMDC00100010063', '2021RB Candle #7 - Lavander - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2176, 'MF059A0614', 'RMDC00100010054', '2021RB Candle #8 - Blue - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2177, 'MF059A0615', 'RMDC00100010064', '2021RB Candle #8 - Lavander - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2178, 'MF059A0616', 'RMDC00100010055', '2021RB Candle #9 - Blue - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 0, 1, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2179, 'MF059A0617', 'RMDC00100010065', '2021RB Candle #9 - Lavander - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2180, 'MF059A0618', 'RMPK01600010010', '2021RB Paper Meal Box (3CN) - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2181, 'MF059A0619', 'RMPK01600010014', '2021RB Paper Meal Box (4CN) - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2182, 'MF059A0620', 'RMPK01600010009', '2021RB Paper Sleeves for Meal Box - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2183, 'MF059A0621', 'RMPK00900010302', '2021RB Product Label for LFO Beef Entrees - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2184, 'MP013A0023', '4273356-1', 'CDM', 16, '1', '1', '21', '25', 1, 1, 1, 1, 12, 25, 1, 1, 'MP013A0001', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2185, 'MF059A0622', 'RMPK00900010303', '2021RB Product Label for LFO Chicken & Pork Entrees - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2186, 'MF059A0623', 'RMPK00900010304', '2021RB Product Label for LFO Great Appetizers - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2187, 'MF059A0624', 'RMPK00900010309', '2021RB Product Label for LFO New Favorite - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2188, 'MF059A0625', 'RMPK00900010305', '2021RB Product Label for LFO Rice & Noodles - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2189, 'MF059A0626', 'RMPK00900010306', '2021RB Product Label for LFO Salad & Vegetables - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2190, 'MF059A0627', 'RMPK00900010307', '2021RB Product Label for LFO Seafood Entrees - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2191, 'MF059A0628', 'RMPK00900010308', '2021RB Product Label for LFO Signature Pasta - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 1, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2192, 'MF059A0629', 'RMPK00900010310', '2021RB Product Label for LFO Soups - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2193, 'MF059A0630', 'RMPK01600010013', '2021RB Xmas Paper bag w/o Handle - White 5.87x3.5x10.75 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2194, 'MF059A0631', 'RMPK01600010012', '2021RB Xmas Paper Bag with Handle - White 8X6X8 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2195, 'MF059A0632', 'RMPK01600010011', '2021RB Xmas Paper Bag with Handle - White10X6x9 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2196, 'MF059A0633', 'RMPK00900010311', '2021RB Xmas Product Label for Almondine Cookies 44x70mm', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2197, 'MF059A0634', 'RMPK00900010314', '2021RB Xmas Product Label for Choco Chip Cookies 44x70mm', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2198, 'MF059A0635', 'RMPK00900010316', '2021RB Xmas Product Label for Choco Oatmeal Cookies', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 1, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2199, 'MF059A0636', 'RMPK00900010312', '2021RB Xmas Product Label for Dinner Rolls 44x70mm - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2200, 'MF059A0637', 'RMPK00900010315', '2021RB Xmas Product Label for Lengua de Gato 44x70mm - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2201, 'MF059A0638', 'RMPK00900010313', '2021RB Xmas Product Label for Oatmeal Cookies 44x70mm - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2202, 'MF059A0639', 'RMPK00400120017', '2021XMASRB Box w/ Window 5x9x2 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2203, 'MF059A0640', 'RMPK00400120018', '2021XMASRB Box w/ Window 9x9x2 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2204, 'MF059A0641', 'RMPK00400100035', '2021XMASRBDL Box Base 11x11x4 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2205, 'MF059A0642', 'RMPK00400100036', '2021XMASRBDL Box Base 11x11x5 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2206, 'MF059A0643', 'RMPK00400100037', '2021XMASRBDL Box Base 11x11x7.5 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2207, 'MF059A0644', 'RMPK00400100038', '2021XMASRBDL Box Base 9x9x3 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2208, 'MF059A0645', 'RMPK00400100039', '2021XMASRBDL Box Base 9x9x5 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2209, 'MF059A0646', 'RMPK00400100040', '2021XMASRBDL Box Base 9x9x7 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2210, 'MF059A0647', 'RMPK00400120014', '2021XMASRBDL Box Cover w/ Window 11x11x1.5 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2211, 'MF059A0648', 'RMPK00400120015', '2021XMASRBDL Box Cover w/ Window 11x11x2.5 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2212, 'MF059A0649', 'RMPK00400120016', '2021XMASRBDL Box Cover w/ Window 9x9x1.5 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2213, 'MF059A0650', 'RMFD00800140019', 'Pepper Black Cracked - Unbranded - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2214, 'MF059A0651', 'RMFD00800140014', 'Pepper White Ground - Mc Cormick - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2215, 'MF059A0652', 'RMFD00900050005', 'Puree Mango Sweetened - 7D - per Gal', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 27, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2216, 'MF059A0653', 'RMFD00800150004', 'Rosemary Leaves - Unbranded - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2217, 'MF059A0654', 'RMFD00800170008', 'Salt Iodized - Unbranded - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2218, 'MF059A0654', 'RMGN00300590011', 'Bag Insulated for Ham Roll (Canvass) 4.5 x 11 x 7.5 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2219, 'MF059A0656', 'RMPK00500010002', 'Bottle  8 OZ -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2220, 'MF059A0657', 'RMPK00500040003', 'Bottle Clear PET 1500 ML -  Generic - - By Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2221, 'MF059A0658', 'RMPK00500040002', 'Bottle Clear PET 500 mL - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2222, 'MF059A0659', 'RMPK00400100042', 'Box Base 7.5x14.5x4.5cm - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2223, 'MF059A0656', 'RMFD01500070007', 'Sausage Chorizo - Benson Green - 400 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2224, 'MF059A0661', 'RMFD00800130007', 'Spanish Paprika - Unbranded - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2225, 'MF059A0662', 'RMFD00600140007', 'Starch Modified - Purity 77HV - 25 KG / Bag', 51, '1', '4', '18', '25', 1, 1, 1, 25, 1, 0, 5, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2226, 'MF059A0663', 'RMFD00600140006', 'Starch Potato - Superior - 25 KG / Bag', 51, '1', '4', '18', '25', 1, 1, 1, 25, 1, 0, 5, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2227, 'MF059A0664', 'RMFD01800020003', 'Strawberry Jam - Smuckers - - 12 OZ / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2228, 'MF059A0665', 'RMFD00800080005', 'Texturized Vegetable Protein - - 1KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2229, 'MF059A0666', 'RMFD01100120004', 'Tomato Sauce Coulis - Buitoni - 3 KG / Can', 51, '1', '4', '18', '25', 1, 1, 1, 3, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2230, 'MF059A0667', 'RMFD01100150006', 'Worcestershire Sauce - Lea & Perrins - 290 ML / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2231, 'MF059A0668', 'RMFD00600030034', 'Chocolate Dark - Tigre Y Oliva 70% - 1 KG / Block', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 7, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2232, 'MF059A0660', 'RMPK00400100041', 'Box Cover w/Window 8.3x15x8 cm - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2233, 'MF059A0670', 'RMDC00700150004', 'Card Greeting Generic - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2234, 'MF059A0671', 'RMDC00700150006', 'Card Greeting HBD - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2235, 'MF059A0672', 'RMPK01200030014', 'Cellosheet 9x13 IN - - 100 Piece/Ream', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 26, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2236, 'MF059A0671', 'RMFD00600030035', 'Chocolate White - Tigre Y Oliva 1 KG / Block', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 7, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2237, 'MF059A0674', 'RMFD01900200003', 'Cereal Chocolate Pops - Kellogs - 400 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2238, 'MF059A0675', 'RMFD01900030003', 'Cookie Butter Crunchy Spread - Biscoff - 700 G / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2239, 'MF059A0676', 'RMPK00400060006', 'Corrugated Box  20x20x15 IN -  - 10 pcs / Bundle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 25, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2240, 'MF059A0677', 'RMPK00400060014', 'Corrugated Box C-Flute (175lbs) 17x12x8 IN - - 20 pcs / Bundle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 25, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2241, 'MF059A0678', 'RMPK00400060011', 'Corrugated Box C-Flute Non-test 10.25x7.5x4.25 IN -  - 20 pcs / Bundle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 25, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2242, 'MF059A0679', 'RMPK00400060010', 'Corrugated Box C-Flute Non-test 17x12x6 IN -  - 20 pcs / Bundle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 25, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2243, 'MF059A0680', 'RMFD00600060006', 'Cream Black Truffle - Mazza - 500 G / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2244, 'MF059A0681', 'RMGN00300350004', 'Cutlery Pouch Bag White Craft 9.5x3.5IN (50pcs/pack) -- by', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2245, 'MF059A0682', 'RMPK00800010018', 'Disposable Cup Lid Clear w/ Hole 95mm -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2246, 'MF059A0683', 'RMPK00400040020', 'Filler Paper White for Colored Boxes - - 50 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2247, 'MF059A0684', 'RMFD01600010026', 'Flour Cake - White Cloud - 25 KG / Bag', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 9, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2248, 'MF059A0685', 'RMPK00800090007', 'Freezer Canister with Lid Rectangular 1000 ML -  - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2249, 'MF059A0686', 'RMGN00300590017', 'Ham Roll Bag w/ Handle 2021 - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2250, 'MF059A0687', 'RMFD01100050004', 'Hot Sriracha Sauce - Cholimex - 455 ML / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2251, 'MF059A0688', 'RMGN00300590014', 'Insulated Bag for Cake Slice 18.5x8.4x35.3cm / Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2252, 'MF059A0689', 'RMFD00700050031', 'Milk Condensed - Alaska Professional - 300 ML / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2253, 'MF059A0690', 'RMFD00700050030', 'Milk Condensed - Nestle - Milkmaid - 388 G / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2254, 'MF059A0691', 'RMFD00800070003', 'Garlic Ground - Unbranded - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2255, 'MF059A0691', 'RMFD01000010049', 'Noodles Angel Hair - Ideal - 500 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2256, 'MF059A0692', 'RMFD01900100005', 'Marshmallow White Large - Markenburg - 283 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2257, 'MF059A0693', 'RMFD01000010045', 'Noodles Linguine - Ideal - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2258, 'MF059A0694', 'RMFD00700050034', 'Milk Condensed - Nestle Carnation - 388 G / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 14, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2259, 'MF059A0695', 'RMFD01100060017', 'Olive Oil Extra Virgin - Dolce Vita - 5 L / Botlle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2260, 'MF059A0697', 'RMFD00900100016', 'Olives Black Sliced - Molinera - 935 G / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2261, 'MF059A0697', 'RMFD01000010044', 'Noodles Lasagna - Ideal - 454 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2262, 'MF059A0699', 'RMPK01000060015', 'Paper Box Clamshell Medium 5x6x3 IN - by pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2263, 'MF059A0699', 'RMFD01100130011', 'Oil White Truffle - Poddi - 250 ML / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2264, 'MF059A0700', 'RMPK01000060017', 'Paper Hot Bowl 390 cc - 50pcs per pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2265, 'MF059A0702', 'RMFD00800110004', 'Onion Powder - Unbranded - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2266, 'MF059A0702', 'RMPK01000060016', 'Paper Hot Bowl Lid 390 cc - 100pcs per pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2267, 'MF059A0703', 'RMFD00800140010', 'Pepper Balck Ground - Unbranded - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2268, 'MF059A0704', 'RMGN00300060003', 'Paper Towel 4x4IN - 100pulls (96packs/case) - - by case', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 8, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2269, 'MF059A0706', 'RMFD00900050004', 'Pure Fruit Mix Mango - Monin - 1 L / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 6, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2270, 'MF059A0707', 'RMFD00600230002', 'Rice Crispies  - Shamrock  - 500 G / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2271, 'MF059A0708', 'RMFD00700070007', 'Whipped Cream All Purpose - Magnolia - 250 ML / Tetra', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2272, 'GP014A0045', '47', 'BERYLS DARK COMPOUND CHIPS DR-LD88-NV 8800CTS 1KGX10', 17, '1', '4', '21', '25', 1, 1, 1, 10, 1, 40, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2273, 'GP014A0046', '48', 'BERYLS BITTERSWEET COMPOUND BLOCK L-BS327 1KGX10', 17, '1', '4', '21', '25', 1, 1, 1, 10, 1, 72, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2274, 'CD119A0003', NULL, 'EUROP 10KG', 77, '1', '1', '18', '21', 1, 1, 1, 10, 1, 50, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2275, 'CD119A0004', NULL, 'SIMPLOT PRIDE 12KG FRIES', 77, '1', '1', '18', '21', 1, 1, 1, 12, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2276, 'CD119A0005', NULL, 'LIQUIDATION 10KG', 77, '1', '1', '18', '21', 1, 1, 1, 10, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2277, 'CD119A0006', NULL, 'SM BONUS 1KG', 77, '1', '1', '18', '21', 1, 1, 1, 10, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2278, 'CD119A0007', NULL, 'SM BONUS 2KG', 77, '1', '1', '18', '21', 1, 1, 1, 10, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2279, 'CD119A0008', NULL, 'MYDIBEL SHOESTRING', 77, '1', '1', '18', '21', 1, 1, 1, 10, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2280, 'CD119A0009', NULL, 'SUPREME SHOESTRING', 77, '1', '1', '18', '21', 1, 1, 1, 10, 1, 40, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2281, 'CD119A0010', NULL, 'LIQUIDATION 12KG', 77, '1', '1', '18', '21', 1, 1, 1, 12, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2282, 'CD119A0011', NULL, 'MCCAIN SHOESTRING 12KG', 77, '1', '1', '18', '21', 1, 1, 1, 12, 1, 39, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2283, 'MF059A0709', 'RMPK01700010027', 'PE Paper Pre-Cut 29.125 x 2.75 IN - 1000 pcs / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2284, 'MF059A0710', 'RMPK01700010026', 'PE Paper Pre-Cut 5.5 x 3.125 IN - 1000 pcs / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2285, 'MF059A0711', 'RMPK00700010044', 'Plastic Bag HD 5x10 IN -  - 1000 Pieces/Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2286, 'MF059A0712', 'RMPK00800080018', 'Plastic Canister Easy Open SP019 - A - - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2287, 'MF059A0713', 'RMPK00800040015', 'Plastic Canister Round with Lid (P-1100) 7 1/8 IN D x 2 IN H -  - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2288, 'MF059A0714', 'RMPK00800080022', 'Plastic Canister with Lid Rectangular (RE-1600) 1600ML - - by SET', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2289, 'MF059A0715', 'RMOF00700090003', 'Sticker Label Matte 3IN - GMF - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2290, 'MF059A0716', 'RMPD00100040026', 'Sticker Reheating Instructions 2.5X1.5IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2291, 'MF059A0717', 'RMPD00100040027', 'Sticker Tamper Proof (Satin) 1x2.25 IN - - by 1000 Piece/Roll', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2292, 'MF059A0718', 'RMPK00800120004', 'Syrup Cup w/ Lid 2oz (HSC60) - - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2293, 'MF059A0719', 'RMPK00800120003', 'Syrup Cup with Lid 3oz (RO3) - - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 33, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2294, 'MF059A0720', 'RMOF00600040006', 'Tape Ordinary (40mic) 3/4 IN - - by Roll', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 23, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2295, 'MF059A0721', 'RMFD00800220007', 'Thyme Leaves Powder - Unbranded - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2296, 'MF059A0722', 'RMPK00100030010', 'Wrapper Glassine White 22GSM 9x13 w/ Logo - - - 1000 pc / Ream', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 26, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2297, 'MF059A0723', 'RMPD00100050004', 'Wrapper Greaseproof 40 GSM  5x9IN - 500pcs/Ream ', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 26, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2298, 'MF059A0724', 'RMPD00100050005', 'Wrapper Greaseproof 40 GSM  9x9IN - 500pcs/Ream ', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 26, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2299, 'MF059A0725', 'RMPK01700010029', 'Wrapper PE Paper 40GSM 9x15 IN (Brown) - - 1000 pcs / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2300, 'MF059A0726', 'RMPK01700010028', 'Wrapper PE Paper 40GSM 9x15 IN (Purple) - - 1000 pcs / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 12, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2301, 'MF059A0727', 'RMDC00200170003', 'Abalone Plate w/ ears 7 x8in  600507 - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2302, 'MF059A0728', 'RMDC00200170002', 'Abalone Plate w/ ears 9x8in 600509 - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2303, 'MF059A0729', 'RMDC00200310004', 'Beer Glass - M8-14AF - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2304, 'MF059A0730', 'RMDC00200020014', 'Bowl Stainless 1.75 Quarts by Piece - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2305, 'MF059A0731', 'RMDC00200020015', 'Bowl Stainless 2 Cups CR MB4 - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2306, 'MF059A0732', 'RMDC00200020013', 'Bowl Stainless 2.75 Quarts by Piece - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2307, 'MF059A0733', 'RMDC00200170003', 'Abalone Plate w/ ears 7 x8in  600507 - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2308, 'MF059A0734', 'RMPD00200060012', 'Pastry tip #27 for basic cream - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2309, 'MF059A0734', 'RMGN00200170046', 'Bussing Tray - 1010525 - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2310, 'MF059A0736', 'RMPD00200060005', 'Pastry tip #3 for incription2 - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2311, 'MF059A0736', 'RMDC00700130001', 'Cake marker 10 & 12 slices (11 IN) - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2312, 'MF059A0738', 'RMPD00700060001', 'Peeler Stainless 6-8 IN Touchstone - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2313, 'MF059A0739', 'RMDC00700060001', 'Pepper Mill Touchstone 12in - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2314, 'MF059A0739', 'RMPD00800260001', 'Cake marker 6 & 8 slices (11 IN) - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2315, 'MF059A0741', 'RMDC00700070001', 'Pitcher Clear w/ handle 64 oz 45774 - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2316, 'MF059A0741', 'RMPD00700110001', 'Can Opener Portable grip swing away 407 - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2317, 'MF059A0743', 'RMDC00200110001', 'Rectangular Plate 12x 7.5in  296512M - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2318, 'MF059A0744', 'RMDC00700190001', 'Casserole S/s  w/ cover 12 Qts Sunnex 28DF - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2319, 'MF059A0744', 'RMPD00200080001', 'Rolling pin, Stainless 10/15" C01032K - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2320, 'MF059A0746', 'RMDC00700190003', 'Casserole Stainless 4 Quarts with Cover - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2321, 'MF059A0746', 'RMDC00200180003', 'Round Plate 11in LN3101027 - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2322, 'MF059A0747', 'RMDC00700020005', 'Ceramic Pepper Shaker 18x4.5cm 605207 - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2323, 'MF059A0749', 'RMDC00700020004', 'Ceramic Salt Shaker 18x4.5cm 605206 - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2324, 'MF059A0750', 'RMDC00600040002', 'Ceramic Seasoning Dispenser 10cm 605603 - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2325, 'MF059A0751', 'RMDC00700110001', 'Ceramic Toothpick Holder 4.5x3cm - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2326, 'MF059A0752', 'RMDC00200300002', 'Champange Capri Glass 11945 - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2327, 'MF059A0751', 'RMDC00200180001', 'Round Plate 7in  LN3101018 - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2328, 'MF059A0753', 'RMPD00700050003', 'Chefs Knife Brown 1002634 - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2329, 'MF059A0754', 'RMDC00200180002', 'Round Plate 9in LN3101024 - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2330, 'MF059A0756', 'RMPD00700050005', 'Chefs Knife White 65610 / 65604 - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2331, 'MF059A0757', 'RMPD00700050004', 'Chefs Knife Yellow 1002635 - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2332, 'MF059A0758', 'RMDC00400120002', 'Coffee Tea Spoon 13.25cm - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2333, 'MF059A0757', 'RMDC00200020010', 'Salad Bowl 8in WW02508 - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2334, 'MF059A0760', 'RMDC00200020016', 'Salad Bowl 9 IN - WW02509 - - by PC ', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2335, 'MF059A0761', 'RMDC00200070004', 'Saucer 6oz 14mm 614361 - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2336, 'MF059A0762', 'RMOF00500110002', 'Scissor Heavy Duty 1011741 - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2337, 'MF059A0763', 'RMGN00200020004', 'Servette Cloth - White 2PC / Pack - - by Pack ', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 4, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2338, 'MF059A0763', 'RMDC00700010003', 'Condiment Holder 6 div plastic B6B - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2339, 'MF059A0765', 'RMDC00700060002', 'Cork screw - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2340, 'MF059A0765', 'RMDC00700080006', 'Serving Tray Rect. Large 15x20in 48516 - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2341, 'MF059A0767', 'RMPD00300030004', 'Crepe Pan 9 IN ECMT22 - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2342, 'MF059A0768', 'RMDC00300020006', 'Cup White Ceramic 6oz  8x6.5in  614360 - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2343, 'MF059A0769', 'RMGN00200170043', 'Cutlery Bin w/Compartment 4Div 21x12x4in   - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2344, 'MF059A0770', 'RMPD00700020010', 'Cutting Board Blue 12x18 IN 1007882 - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2345, 'MF059A0771', 'RMPD00700020007', 'Cutting Board Brown 12x18in 1016573 - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2346, 'MF059A0772', 'RMDC00400130001', 'Dessert Fork 16cm length - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2347, 'MF059A0773', 'RMDC00400020001', 'Dinner Fork 18cm, Stainles - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2348, 'MF059A0774', 'RMDC00400030001', 'Dinner Knife 22cm Length - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2349, 'MF059A0775', 'RMDC00400040001', 'Dinner Spoon 18cm, Stainles - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2350, 'MF059A0776', 'RMPD00700120004', 'Disher 2.0 oz - 55374 - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2351, 'MF059A0777', 'RMDC00400110001', 'Egg Tureen  - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2352, 'MF059A0778', 'RMPD01000060006', 'Electric Griller - Hanabishi - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2353, 'MF059A0779', 'RMPD00900010012', 'Food Container Microwavabe 10x8In CLTF N41 - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2354, 'MF059A0780', 'RMPD00900010010', 'Food Container Microwavabe 6x4in CLTF N21 - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2355, 'MF059A0781', 'RMPD00900010011', 'Food Container Microwavabe 8x56in CL TFN31 - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2356, 'MF059A0782', 'RMPD00300110016', 'Food Pan 1/9 x 2 IN Stainless 55259 - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2357, 'MF059A0783', 'RMPD00900050013', 'Food Storage Container Rect.14x10x4 3863 - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2358, 'MF059A0784', 'RMPD00900050014', 'Food Storage Container Square 10x10x4 3873 - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2359, 'MF059A0785', 'RMDC00500070002', 'Fork Medium by Piece - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2360, 'SK101A0001', NULL, 'RED PEPPER POWDER ', 70, '1', '3', '18', '21', 1, 1, 1, 10, 1, 0, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2361, 'MF059A0786', 'RMPD00300010013', 'Frying Pan Nonstick 12 IN 54196 - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2362, 'SK101A0002', NULL, 'RED PEPPER POWDER - WHITE TAPE', 70, '1', '3', '18', '21', 1, 1, 1, 10, 1, 0, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2363, 'MF059A0787', 'RMDC00200200003', 'Glass saucer / dipping cup 1 oz - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2364, 'MF059A0788', 'RMDC00200200002', 'Glass saucer / dipping cup 2 oz - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2365, 'SK101A0003', NULL, 'RED PEPPER POWDER - YELLOW TAPE', 70, '1', '3', '18', '21', 1, 1, 1, 10, 1, 0, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2366, 'MF059A0789', 'RMDC00600040004', 'Glass Shaker Slotted 6oz 1006582 - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2367, 'MF059A0790', 'RMDC00200300001', 'Glass Tumbler 12oz 8x15cm G3655 - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2368, 'SK101A0004', NULL, 'Rice Cake (Whole Sliced) 1kgx10 White Tape', 70, '1', '3', '18', '21', 1, 1, 1, 10, 1, 0, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2369, 'MF059A0791', 'RMPD00700080002', 'Grater Stainless with Handle - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2370, 'MF059A0792', 'RMPD00300030003', 'Grill Pan Nonstick SQUARE 12 IN by Piece - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2371, 'SK101A0005', NULL, 'Rice Cake (Whole) 1kgx10 Yellow Tape', 70, '1', '3', '18', '21', 1, 1, 1, 10, 1, 0, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2372, 'MF059A0793', 'RMDC00700030002', 'Ice Bucket with Tong 7x5.5in ES4003 - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2373, 'MF059A0794', 'RMDC00700040001', 'Ice Pick Metal 4-5in - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2374, 'SK101A0006', NULL, 'KIMCHI 10KGX1', 70, '1', '3', '18', '21', 1, 1, 1, 10, 1, 0, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2375, 'MF059A0795', 'RMDC00700050003', 'Ice Shovel S/S Touchstone 12oz 3x6in - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2376, 'SK101A0007', NULL, 'KIMCHI 1KGX12', 70, '1', '3', '18', '21', 1, 1, 1, 12, 1, 0, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2377, 'MF059A0796', 'RMPD00700040019', 'Knife Paring 3.5 IN to 5 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2378, 'MF059A0797', 'RMPD01000050001', 'Knife Sharpener Stone Carborandum - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2379, 'MF059A0798', 'RMPD00400030016', 'Ladle Pasta - 55308 - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2380, 'MF059A0799', 'RMPD00400030013', 'Ladle Stainless 0.5 oz by Piece - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2381, 'MF059A0800', 'RMPD00400030014', 'Ladle Stainless 1 oz by Piece - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2382, 'MF059A0801', 'RMPD00400030010', 'Ladle Stainless 12 oz by Piece - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2383, 'MF059A0802', 'RMPD00400030009', 'Ladle Stainless 16 oz by Piece - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2384, 'SK101A0008', NULL, 'Seafoods, Octo Cooked Whole 10Kg', 70, '1', '2', '-18', '-25', 1, 1, 1, 10, 1, 0, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2385, 'MF059A0803', 'RMPD00400030012', 'Ladle Stainless 6 oz 55308 - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2386, 'SK101A0009', NULL, 'Seafood, Fish Cake ROD 800gx10', 70, '1', '2', '-18', '-25', 1, 1, 1, 10, 1, 0, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2387, 'MF059A0804', 'RMDC00400050001', 'Long Spoon 19cm length - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2388, 'MF059A0805', 'RMGN00100110037', 'Magnesol - - by Box', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2389, 'SK101A0010', NULL, 'Seafood, Fish Cake - COMBI 800gx10', 70, '1', '2', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2390, 'MF059A0806', 'RMPD00800220001', 'Masher 50683 Prestige - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2391, 'MF059A0807', 'RMDC00200310003', 'Mason Jar  - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2392, 'MF059A0808', 'RMPD00600030008', 'Measuring Round Storage Cont. 8Qts 1003040 - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2393, 'MF059A0809', 'RMPD00800090002', 'Moulder for Rice KLIO - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2394, 'MF059A0810', 'RMDC00900010020', 'New Salad bowl 9"  -  WW00209', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2395, 'MF059A0811', 'RMDC00300050001', 'OJ Glass 8 oz 5.5x13cm - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2396, 'MF059A0812', 'RMPD00200040004', 'Pastry Bag 10 IN 3110 Ateco - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2397, 'SK101A0011', NULL, 'Seafood, Octo Cooked (Legs) 12kgs', 70, '1', '2', '-18', '-25', 1, 1, 1, 12, 1, 0, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2398, 'MF059A0813', 'RMDC00300010002', 'Shot Glass 11131026 - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2399, 'MF059A0814', 'RMDC00200080001', 'Skillet Plate w/ Handle 8.5x12in 607512 - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2400, 'MF059A0815', 'RMDC00200190001', 'Soup Bowl  4in LN3102128B - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2401, 'MF059A0816', 'RMDC00400120001', 'Soup Spoon 16.5cm, Length - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2402, 'MF059A0817', 'RMPD00400090015', 'Spatula Angled Metal 7 IN by Piece - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2403, 'SK101A0012', NULL, 'Seafood, Nobashi Shrimp 7.2kgs', 70, '1', '2', '-18', '-25', 1, 1, 1, 6, 1, 0, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2404, 'MF059A0818', 'RMPD00400090018', 'Spatula for Cake - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2405, 'MF059A0819', 'RMPD00400090016', 'Spatula Metal 4 IN 1304 Ateco - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2406, 'MF059A0820', 'RMPD00400010008', 'Spoon Basting Aluminum 1819 IN by Piece - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2407, 'MF059A0821', 'RMPD00400010009', 'Spoon Basting Nonstick Black 11.5 IN Metro - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2408, 'SK101A0013', NULL, 'Assorted Korean Ice Cream', 70, '1', '2', '-18', '-25', 1, 1, 1, 10, 1, 0, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2409, 'MF059A0822', 'RMPD00400010001', 'Spoon Basting Plastic _WITH DEPTH - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2410, 'MF059A0823', 'RMPD00400010002', 'Spoon Basting Solid Stainless 15in - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2411, 'MF059A0824', 'RMPD00400010010', 'Spoon Basting Wooden 1516 IN by Piece - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2412, 'MF059A0825', 'RMPD00800070002', 'Squeeze Bottle  12 OZ - Slant Tip - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2413, 'MF059A0826', 'RMPD00800070007', 'Squeeze bottle 16 oz by Piece - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2414, 'MF059A0827', 'RMPD00800070008', 'Squeeze bottle 8-10 oz by Piece (slant tip) - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2415, 'MF059A0828', 'RMPD00700040016', 'Steak Knife 21.5cm x 10.5cm - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2416, 'SK101A0014', NULL, 'Seafood, Fish Cake - Square 1kgx10', 70, '1', '2', '-18', '-25', 1, 1, 1, 12, 1, 0, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2417, 'MF059A0829', 'RMPD00300090002', 'Stock Pot Alum Quarts with Cover 24-25Qts - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2418, 'MF059A0830', 'RMPD00500020003', 'Strainer Noodle S/s 4.5in Dia Web Like - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2419, 'SK101A0015', NULL, 'Seafood, Fish Cake - Square 400gx20', 70, '1', '2', '-18', '-25', 1, 1, 1, 20, 1, 0, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2420, 'SK101A0016', NULL, 'Korean Dumpling (360x360) x 8s', 70, '1', '2', '-18', '-25', 1, 1, 1, 10, 1, 0, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2421, 'MF059A0831', 'RMPD00500020011', 'Strainer Single Mesh Noodle S/s 4.5in Dia - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2422, 'MF059A0832', 'RMPD00500020005', 'Strainer Single Mesh Wooden Handle 7 3/4in - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2423, 'SK101A0017', NULL, 'Korean Dumpling (385x385) x 8s', 70, '1', '2', '-18', '-25', 1, 1, 1, 10, 1, 0, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2424, 'MF059A0833', 'RMDC00700120002', 'Straw Dispenser holder 5x5x11in PSAQS14 - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2425, 'MF059A0834', 'RMDC00700110004', 'Sugar and Creamer Packet Holder - 601131 - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2426, 'MF059A0835', 'RMDC00200300007', 'Sundae Glass 12oz 8x18cm - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2427, 'MF059A0836', 'RMDC00900010016', 'Teapot White Ceramic - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2428, 'MF059A0837', 'RMPD00100030007', 'Thermal Gloves Cloth Black 13in - by pair', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2429, 'MF059A0838', 'RMPD00800100003', 'Thermometer Stick  Red 1006029 - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2430, 'MF059A0839', 'RMDC00700080012', 'Tip Tray - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2431, 'MF059A0840', 'RMPD00400100004', 'Tong Pom 12 IN AT12YE - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2432, 'MF059A0841', 'RMPD00400100006', 'Tong Pom 12in (nonstick edge) 1005885 - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2433, 'MF059A0842', 'RMPD00400100003', 'Tong Pom 15 IN AT16BK - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2434, 'CI133A0001', NULL, 'NOBASHI 11g (YELLOW STRAP) x 9.9KG', 85, '2', '1', '-18', '-21', 1, 1, 1, 9.9, 1, 0, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2435, 'MF059A0843', 'RMDC00900010018', 'Tong Pom 15" - - 1000847', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2436, 'CI133A0002', NULL, 'NOBASHI 14g (VIOLET STRAP) x 10.5KG', 85, '2', '1', '-18', '-21', 1, 1, 1, 10.5, 1, 0, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2437, 'MF059A0844', 'RMPD00400100007', 'Tong Pom 7 IN Touchstone (2pcs per pack) - by pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2438, 'CI133A0003', NULL, 'FROZEN SALMON BELLY', 85, '2', '1', '-18', '-21', 1, 1, 1, 20, 1, 0, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2439, 'MF059A0845', 'RMDC00700080011', 'Tray Stand 37in AMRWTS - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2440, 'MF059A0846', 'RMDC00200300005', 'Tumbler Halo Halo Jr. 9oz 8.5x18cm G3653 - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2441, 'MF059A0847', 'RMPD00400110006', 'Turner Slotted Rubber Black by Piece - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2442, 'MF059A0848', 'RMPD00400110001', 'Turner Steak Rect.  S/s w/o Border 9x7in - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2443, 'MF059A0849', 'RMPD00400110004', 'Turner Steak Rect. S/s w/ Border 9x7in - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2444, 'MF059A0850', 'RMPD00400110002', 'Turner Wooden 15 IN Perissos - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2445, 'CI133A0004', NULL, 'FROZEN GIANT SQUID 20KG', 85, '2', '1', '-18', '-21', 1, 1, 1, 20, 1, 0, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2446, 'MF059A0851', 'RMPD00800200001', 'Water Decanter Borgonovo Indro Carafe 1L - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2447, 'MF059A0852', 'RMDC00200300010', 'Water glass  P15-8BNF Garcon OTR8 - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2448, 'MF059A0853', 'RMDC00200300006', 'Water Goblet Code#440063 - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2449, 'MF059A0854', 'RMPD00700060002', 'Whip French Hard Rubber Grip 14 IN 55422 - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2450, 'CI133A0005', NULL, 'CREAMDORY TRIMMED-YELLOW STRAP', 85, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 0, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2451, 'MF059A0855', 'RMDC00700090001', 'Wine Bucket  -  - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2452, 'CI133A0006', NULL, 'CREAMDORY UNTRIMMED-RED STRAP', 85, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 0, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2453, 'MF059A0856', 'RMDC00700090002', 'Wine Glass - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2454, 'MF059A0857', 'RMPD00300150002', 'Wok Alloy 16 IN (14 Quarts) by Piece - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2455, 'CI133A0007', NULL, 'TUNA BELLY CO 3/5-BLUE STRAP', 85, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 0, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2456, 'CI133A0008', NULL, 'TUNA BELLY NA 5UP-WHITE STRAP', 85, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 0, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2457, 'MF059A0858', 'RMPD00300150001', 'Wok Alloy 19 IN (16 Quarts) by Piece - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2458, 'CI133A0009', NULL, 'TUNA BELLY NA 3/5-RED STRAP', 85, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 0, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2459, 'CI133A0010', NULL, 'TUNA BELLY CO 5UP-YELLOW STRAP', 85, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 0, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2460, 'CI133A0011', NULL, 'TUNA KAMA CO 5UP-YELLOW STRAP', 85, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 0, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2461, 'CI133A0012', NULL, 'TUNA KAMA CO 3/5-BLUE STRAP', 85, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 0, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2462, 'CI133A0013', NULL, 'TUNA KAMA NA 3/5-RED STRAP', 85, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 0, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2463, 'CI133A0014', NULL, 'TUNA MEAT CRCU-VIOLET STRAP', 85, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 0, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2464, 'CI133A0015', NULL, 'PORK LOIN BLSL-PAMPLONA', 85, '2', '1', '-18', '-21', 1, 1, 1, 20, 1, 0, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2465, 'CI133A0016', NULL, 'FROZEN CLQ -SIMMONS', 85, '2', '1', '-18', '-21', 1, 1, 1, 15, 1, 0, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2466, 'CI133A0017', NULL, 'Pork Belly BISO- Artigas', 85, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 0, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2467, 'CI133A0018', NULL, 'BEEF SHORT PLATE - IOWA PREMIUM', 85, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 0, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2468, 'CI133A0019', NULL, 'Beef Boneless Chuck- Mondelli', 85, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 0, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2469, 'CI133A0020', NULL, 'Beef Boneless Shoulder- Mondelli', 85, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 0, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2470, 'CI133A0021', NULL, 'Beef Boneless Brisket- Mondelli', 85, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 0, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2471, 'CI133A0022', NULL, 'Pork Belly BISO-Land Shoot', 85, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 0, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2472, 'CI133A0023', NULL, 'Beef Short Plate- EC Medina', 85, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 0, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2473, 'CI133A0024', NULL, 'BEEF RIB FINGER-NEBRASKA', 85, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 0, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2474, 'CI133A0025', NULL, 'BONELESS BEEF CHUCK EYE ROLL-SWIFT', 85, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 0, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2475, 'CI133A0026', NULL, 'CHOICE BEEF CHUCK EYE ROLL-SWIFT', 85, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 0, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2476, 'CI133A0027', NULL, 'BONE IN BEEF SHORT RIBS-SWIFT', 85, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 0, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2477, 'CI133A0028', NULL, 'CHOICE CHUCK EYE ROLL BL-EXCEL', 85, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 0, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2478, 'CI133A0029', NULL, 'Salmon Whole 5-6 - LEROY', 85, '2', '1', '-18', '-25', 1, 1, 1, 0, 1, 0, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2479, 'MP013A0024', '123', 'Toblerone', 16, '1', '4', '18', '25', 1, 1, 1, 10, 1, 1, 4, 1, 'MP013A0012', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2566, 'JS005A0001', NULL, 'Tuna Belly 300-500 @20', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2567, 'JS005A0002', NULL, 'Tuna Belly 500 Up X20', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2568, 'JS005A0003', NULL, 'Frozen Whole Pomfret 200-300 X10', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2569, 'JS005A0004', NULL, 'Salmon Sinigang Mix', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2570, 'JS005A0005', NULL, 'Hipon Medium', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2571, 'JS005A0006', NULL, 'Lapu-Lapu Marble', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2572, 'JS005A0007', NULL, 'Tanigue', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2573, 'JS005A0008', NULL, 'Tilapia Medium', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2574, 'JS005A0009', NULL, 'Deboned Bangus Small', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2575, 'JS005A0010', NULL, 'Salmon Head Sinigang Packs', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2576, 'JS005A0011', NULL, 'Lapu Lapu Red', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2577, 'JS005A0012', NULL, 'Lapu Lapu Red/ Lapu Lapu Marble', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2579, 'JS005A0014', NULL, 'Assorted Fish', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2581, 'JS005A0016', NULL, 'Deboned Bangus Large', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2582, 'JS005A0017', NULL, 'Deboned Bangus Extra Large', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2583, 'JS005A0018', NULL, 'Deboned Bangus Medium', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2586, 'JS005A0021', NULL, 'Salmon Head Salar X 25', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2587, 'JS005A0022', NULL, 'Salmon Belly Flaps - Frozen Atlantic X 20', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2588, 'JS005A0023', NULL, 'Brown Grouper', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2591, 'JS005A0026', NULL, 'Whole Sagisi X50', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2592, 'JS005A0027', NULL, 'Whole Sagisi X47', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2593, 'JS005A0028', NULL, 'Fish, Salmon Whole 5-6 Marine Harvest', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2596, 'JS005A0031', NULL, 'Fish, Whole Golden Pompret 500-600g 10kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2597, 'JS005A0032', NULL, 'Sugpo Large', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2598, 'JS005A0033', NULL, 'Sugpo Jumbo', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2599, 'JS005A0034', NULL, 'Hipon Extra Large', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2600, 'JS005A0035', NULL, 'Assorted Fish Products X 10kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2601, 'JS005A0036', NULL, 'Frozen Mackerel X 10kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2602, 'JS005A0037', NULL, 'Salmon Head Straight Cut 20kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2603, 'JS005A0038', NULL, 'Salmon Heads V-Cut 10kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2604, 'JS005A0039', NULL, 'Salmon Belly Flaps 10kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2605, 'JS005A0040', NULL, 'Pusit Kalawang 10kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2606, 'JS005A0041', NULL, 'Fish, Frozen Yellow Fin Kama Size Co White Box 10kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2607, 'JS005A0042', NULL, 'Fish, Frozen Tuna Tail Brown Box 10kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2608, 'JS005A0043', NULL, 'Salmon Whole 6-7 Kg Blumar', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2609, 'JS005A0044', NULL, 'Salmon Whole 4-5 Blumar', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2610, 'JS005A0045', NULL, 'Fish, Frozen Pangasius Fillet - Creamdory 10kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2611, 'JS005A0046', NULL, 'Fish, Whole Golden Pompret 400-500g 10kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2618, 'JS005A0053', NULL, 'Fish, Frozen Salmon Whole 6-7 Marine Harvest', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2619, 'JS005A0054', NULL, 'Fish, Frozen Salmon Whole 7-8 Marine Harvest', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2623, 'JS005A0058', NULL, 'Fish, Whole Golden Pompret 300.400g 10kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2628, 'JS005A0063', NULL, 'Salmon Whole Blumar 5-6 Kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2631, 'JS005A0066', NULL, 'Tuna Belly X 8kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2632, 'JS005A0067', NULL, 'Fish, Tuna Loin 300 Up', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2633, 'JS005A0068', NULL, 'Fish, Frozen Tuna Belly Yellow Fin 300 Up', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2634, 'JS005A0069', NULL, 'Fish, Tuna Belly 200-300', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2635, 'JS005A0070', NULL, 'Fish, Tuna Belly 100-200', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2636, 'JS005A0071', NULL, 'Fish, Tuna Belly 300-500', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2637, 'JS005A0072', NULL, 'Belly Mix', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2638, 'JS005A0073', NULL, 'Tuna Loin Co A-B', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2639, 'JS005A0074', NULL, 'Salmon Heads Sttraight Cut 11kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2640, 'JS005A0075', NULL, 'Salmon Head Sttraight Cut 20kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2644, 'JS005A0079', NULL, 'Fresh,Frozen Yellow Fin Tuna Cubes 11.35 Kg.', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2645, 'JS005A0080', NULL, 'Tuna Ground Meat 11.35 Kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2646, 'JS005A0081', NULL, 'Frozen Yellow Fin Tuna Kama ( Co Treated ) 400g X 10kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2647, 'JS005A0082', NULL, 'Frozen Yellow Fin Tuna Belly ( Co Treated ) 400g X 10kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2648, 'JS005A0083', NULL, 'Salmon Heads 600grms- 10kg/Box', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2649, 'JS005A0084', NULL, 'Salmon Heads 500grms- 10kg/Box', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2653, 'JS005A0088', NULL, 'Salmon Whole Atlantic 5-6kg (White Box)', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2655, 'JS005A0090', NULL, 'Fresh Frozen Yellow Fin Tuna Cubes 11.35 Kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2659, 'JS005A0094', NULL, 'Tuna Kama 500 Up ( Violet Strap )', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2660, 'JS005A0095', NULL, 'Tuna Kama 300-499g ( Pink Strap )', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2661, 'JS005A0096', NULL, 'Tuna Tail - (Orange Strap) 300-499g', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2662, 'JS005A0097', NULL, 'Tuna Tail - (Green Strap ) 500g Up', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2663, 'JS005A0098', NULL, 'Tuna Belly - (Blue Strap ) 300-499g', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2664, 'JS005A0099', NULL, 'Tuna Belly - (White Strap ) 500g Up', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2668, 'JS005A0103', NULL, 'Salmon Whole 4-5 (Atlantic Iqf)', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2669, 'JS005A0104', NULL, 'Frozen Mackerel', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2670, 'JS005A0105', NULL, 'Barramundi Fillet 200/300', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2671, 'JS005A0106', NULL, 'Barramundi Fillet 100/200', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2672, 'JS005A0107', NULL, 'Barramundi Whole 800/1200', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2673, 'JS005A0108', NULL, 'Barramundi Gutted & Scale 550/750', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2674, 'JS005A0109', NULL, 'Barramundi Whole 600/800', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2675, 'JS005A0110', NULL, 'Barramundi Whole 1200up', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2676, 'JS005A0111', NULL, 'Frozen Tuna Kama 400g&Up', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2677, 'JS005A0112', NULL, 'Frozen Co Tuna Belly 400g', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2678, 'JS005A0113', NULL, 'Frozen Tuna Tail 300g&Up', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2679, 'JS005A0114', NULL, 'Frozen Pangasius Fillet 170/220', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2680, 'JS005A0115', NULL, 'Tuna Loins For Steak', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2683, 'JS005A0118', NULL, 'Tuna Cubes', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2684, 'JS005A0119', NULL, 'Sugpo Xl', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2692, 'JS005A0127', NULL, 'Fish, Frozen Salmon Whole 7-8kg Blumar', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2694, 'JS005A0129', NULL, 'Salmon Whole Blumar 7-8kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2695, 'JS005A0130', NULL, 'Hipon Large', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'In-Active', 'Fast Moving', 'High Value', 1, 1),
	(2697, 'JS005A0132', NULL, 'Salmon Heads 10kg/Box - Brad', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2698, 'JS005A0133', NULL, 'Hipon Small', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'In-Active', 'Fast Moving', 'High Value', 1, 1),
	(2700, 'JS005A0135', NULL, 'Hasa-Hasa 10kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2701, 'JS005A0136', NULL, 'Bangus Medium 10kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2702, 'JS005A0137', NULL, 'Tilapia Small 10kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2703, 'JS005A0138', NULL, 'Hipon Small 10kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2704, 'JS005A0139', NULL, 'Hipon Large 10kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2705, 'JS005A0140', NULL, 'Hipon Medium 10kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2706, 'JS005A0141', NULL, 'Loin For Steak', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2707, 'JS005A0142', NULL, 'Tuna Chunks', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2708, 'JS005A0143', NULL, 'Cuttle Fish', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2709, 'JS005A0144', NULL, 'Tuna Poke Cubes', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2710, 'JS005A0145', NULL, 'Hipon @1.0kl', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2711, 'JS005A0146', NULL, 'Bangus Xl', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2712, 'JS005A0147', NULL, 'Tuna Crazy Cut', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2713, 'JS005A0148', NULL, 'Sugpo Small', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2714, 'JS005A0149', NULL, 'Sinigang Cut', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2715, 'JS005A0150', NULL, 'Tuna Steak', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2716, 'JS005A0151', NULL, 'Salmon Heads', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2717, 'JS005A0152', NULL, 'Lapu-Lapu', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2719, 'JS005A0154', NULL, 'Sugpo Medium', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2726, 'JS005A0161', NULL, 'Fish, Whole Golden Pompret 400-500g 10kg - Brad', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2727, 'JS005A0162', NULL, 'Fish, Whole Golden Pompret 500-600g 10kg - Brad', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2730, 'JS005A0165', NULL, 'Tuna Belly 10kg (White Box)', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2731, 'JS005A0166', NULL, 'Tuna Belly 8kg (Brown Box)', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2732, 'JS005A0167', NULL, 'Tuna Kama Co 7kg (Brown Box)', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2733, 'JS005A0168', NULL, 'Tuna Kama Co 7kg (White Box)', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2743, 'JS005A0178', NULL, 'Tuna Collar 500-1000', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2744, 'JS005A0179', NULL, 'Tuna Collar 1000-1500', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2745, 'JS005A0180', NULL, 'Tuna Belly 500-1000', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2746, 'JS005A0181', NULL, 'Tuna Belly 1000-1500', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2747, 'JS005A0182', NULL, 'Tuna Collar 1500 Up', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2748, 'JS005A0183', NULL, 'Tuna Collar 200-500', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2749, 'JS005A0184', NULL, 'Tuna Tail 200-500', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2750, 'JS005A0185', NULL, 'Tuna Tail 500-1000', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2751, 'JS005A0186', NULL, 'Tuna Belly 200-500', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2752, 'JS005A0187', NULL, 'Tuna Panga (Kama) 700g Up (White Box)', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2753, 'JS005A0188', NULL, 'Tuna Kama 700g Up (Brown Box)', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2754, 'JS005A0189', NULL, 'Tuna Kama 700g Up (White Box) 10kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2755, 'JS005A0190', NULL, 'Tuna Kama 700g Up (Brown Box) 10kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2756, 'JS005A0191', NULL, 'Tuna Kama 700g Up (Brown Box) 30kg', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2757, 'JS005A0192', NULL, 'Tuna Belly 700g Up 10kg (White Box)', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2758, 'JS005A0193', NULL, 'Tuna Belly 700g Up 10kg (Brown Box)', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2759, 'JS005A0194', NULL, 'Tuna Belly 700g Up 15kg (Brown Box)', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2760, 'JS005A0195', NULL, 'Tuna Belly 700g Up 40kg (Brown Box)', 9, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2761, 'JS005A0196', 'JM0003', 'Pork Tenderloin - Pine Ridge', 9, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2762, 'JS005A0197', 'JM0001', 'Pork Belly Slbi - Olymel', 9, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2763, 'JS005A0198', 'JM0002', 'Frozen Pork Jowls Trimmings - Brad', 9, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2764, 'JS005A0199', 'JM0004', 'Beef Samgy Shortplate', 9, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2765, 'JS005A0200', 'JM0005', 'Beef Forequarter Minerva', 9, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2766, 'SA171A0005', '134528', 'Grimms Country Classic Sausage 375g', 111, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2767, 'SA171A0005', '125772', 'OB B&B Milk Choc Cookie', 111, '2', '4', '-18', '-21', 29, 25, 24, 7.68, 1, 0, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2768, 'SA171A0006', '134668', 'Grimms Festive Ham 2.5kg ', 111, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2769, 'SA171A0008', '132547', 'OB Bonici Italian Chunks 5lbsX2', 111, '2', '1', '-18', '-21', 23, 32, 39, 17.7, 2, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2770, 'SA171A0009', '123879', 'OB Cal Lemon Creme 38lbs', 111, '2', '4', '-18', '-21', 30, 30, 30, 17.3, 1, 1, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2771, 'SA171A0010', '137361', 'OB CP Breaded Chicken Patty 1.62lbX8', 111, '2', '1', '-18', '-21', 23, 32, 39, 17.7, 8, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2772, 'SA171A0011', '134531', 'Grimms Honey & Maple Flavor Ham 1/2 800g', 111, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2773, 'SA171A0011', '114037', 'B&B Chocolate Chunk Cookie XL', 111, '2', '4', '-18', '-21', 1, 1, 1, 10, 1, 0, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2774, 'SA171A0013', '114041', 'B&B Moelleux Chocolate Brownie', 111, '2', '4', '-18', '-21', 1, 1, 1, 10, 1, 1, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2775, 'SA171A0012', '134534', 'Grimms Honey Ham 175g', 111, '2', '1', '-18', '-25', 25, 11, 29, 1.75, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2776, 'SA171A0015', '139368', 'B&B Supreme Dark Chocolate Cookie 90CT', 111, '2', '4', '-18', '-21', 16, 24, 29, 4.5, 1, 0, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2777, 'SA171A0015', '134530', 'Grimms Kolbassa Sausage 375g', 111, '2', '1', '-18', '-25', 22, 25, 21, 3, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2778, 'SA171A0016', '131141', 'B&B Supreme Oat & Raisin Cookie', 111, '2', '1', '-18', '-21', 29, 24, 16, 4.5, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2779, 'SA171A0018', '114038', 'B&B Triple Choco Cookie XL', 111, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2780, 'SA171A0017', '134540', 'Grimms Old Fashioned Ham 175g', 111, '2', '1', '-18', '-25', 21.5, 25, 21, 3, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2781, 'SA171A0019', '125773', 'B&B White Chocolate Cookie Puck', 111, '2', '4', '-18', '-21', 1, 1, 1, 4.5, 1, 0, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2782, 'SA171A0021', '139496', 'Bar S Corn Dogs Beef 24oz', 111, '2', '1', '-18', '-21', 43, 30, 17, 8.16, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2783, 'SA171A0021', '134533', 'Grimms Old Fashioned Ham 800g', 111, '2', '1', '-18', '-25', 31, 17, 36, 6.4, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2784, 'SA171A0022', 'TEMPO 3', 'Beef MeatBalls', 111, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2785, 'SA171A0024', '139497', 'Belgian Boys Lava Cake Dark Choco6.35oz', 111, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2786, 'SA171A0024', '134529', 'Grimms Polish Sausage 375g', 111, '2', '1', '-18', '-25', 22, 25, 21, 3, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2787, 'SA171A0022', '123883', 'OB Crystal White Sugar 25lbs', 111, '2', '4', '-18', '-21', 34, 25, 18, 11.34, 1, 0, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2788, 'SA171A0026', '139498', 'Belgian Boys Lava Cake Salted Caramel 6.35oz', 111, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2789, 'SA171A0027', '134537', 'Grimms Sizzlin Jalapeno Mozza Smks 450g', 111, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2790, 'SA171A0028', '139499', 'Belgian Boys Pancakes Mini 10.6oz', 111, '2', '1', '-18', '-21', 43, 30, 17, 8.16, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2791, 'SA171A0028', '123884', 'OB Sparkle Neutral Glaze 22lbs', 111, '2', '4', '-18', '-21', 24, 24, 24, 10, 1, 0, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2792, 'SA171A0030', '139500', 'Ben&Jerry Bites Cookie Dough Choc 8oz', 111, '2', '1', '-18', '-21', 43, 30, 17, 8.16, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2793, 'SA171A0031', '134536', 'Grimms Sizzlin Original Smokies 450g', 111, '2', '1', '-18', '-25', 11, 25, 29, 1.5, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2794, 'SA171A0033', '139501', 'Ben&Jerry Bites Cookie Dough Pnt Btr 8oz', 111, '2', '1', '-18', '-21', 43, 30, 17, 8.16, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2795, 'SA171A0033', '134545', 'Grimms Smoked Turkey Breast 150g', 111, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2796, 'SA171A0033', '122419', 'OB WC Bavarian Creme 36lbs', 111, '2', '4', '-18', '-21', 1, 1, 1, 10, 1, 0, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2797, 'SA171A0035', '139502', 'Ben&Jerry Bites Frozen Yougurt CherryGarcia16oz', 111, '2', '1', '-18', '-21', 43, 30, 17, 8.16, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2798, 'SA171A0037', '128691', 'OB Westco RTU Cream Cheese Filling 20lbs', 111, '2', '4', '18', '25', 24, 24, 24, 9.1, 1, 1, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2799, 'SA171A0037', '134558', 'Harvest Sliced Hickory Bacon 500g', 111, '2', '1', '-18', '-25', 17, 24, 36, 6, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2800, 'SA171A0037', '128889', 'Ben&Jerry Ny Super Fudge Chunk 16oz', 111, '2', '1', '-18', '-21', 43, 30, 17, 8.16, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2801, 'SA171A0040', '138355', 'Brown Sugar Pearl Milk Ice Bar 4x320g', 111, '2', '1', '-18', '-21', 23, 32, 39, 17.7, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2802, 'SA171A0040', '101932', 'OB WM Smoked Mozzarella Provolone', 111, '2', '1', '-18', '-21', 23, 32, 39, 17.7, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2803, 'SA171A0039', '134554', 'Harvest Wieners c.o.v. 450g', 111, '2', '1', '-18', '-25', 24, 16, 36, 5.4, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2804, 'SA171A0042', '138357', 'Brown Sugar Pearl Milk Ice Cone 4x320g', 111, '2', '1', '-18', '-21', 23, 32, 39, 17.7, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2805, 'SA171A0044', '130441', 'Cardinal Rh BBQ Maple Pork Back Ribs 605g', 111, '2', '1', '-18', '-21', 19, 17, 39, 4.87, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2806, 'SA171A0043', '127591', 'Hot Pockets 4 Cheese Pizza 9oz', 111, '2', '1', '-18', '-25', 43, 30, 17, 8.16, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2807, 'SA171A0046', '130441BB', 'Cardinal Rh BBQ Maple Pork Back Ribs 605g', 111, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2808, 'SA171A0044', '108357', 'OB CSM Chunky Apple Filling 38lb', 111, '2', '4', '-18', '-21', 30, 30, 30, 17.3, 1, 1, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2809, 'SA171A0046', '134551', 'Keg BBQ Pork Back Ribs 700g', 111, '2', '1', '-18', '-25', 26, 29, 40, 7, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2810, 'SA171A0047', '130440', 'Cardinal Rh BBQ Pork Back Ribs 605g', 111, '2', '1', '-18', '-21', 27, 22, 32, 4, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2811, 'SA171A0050', '100086', 'Chocolate Creme Cake Mix 50lbs', 111, '2', '4', '-18', '-21', 1, 1, 1, 10, 1, 0, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2812, 'SA171A0049', '134550', 'Keg Prime Rib Burger 6oz 1.02kg', 111, '2', '1', '-18', '-25', 28, 24, 42, 12.2, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2813, 'SA171A0051', '100088', 'Complete Carrot Cake Mix w/o Nuts', 111, '2', '4', '-18', '-21', 1, 1, 1, 10, 1, 0, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2814, 'SA171A0053', 'TEMPO 1', 'Cooked Italian Pork Topping', 111, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2815, 'SA171A0052', '139510', 'LamaiThai Green Curry w/ Jasmine Rice 350g', 111, '2', '1', '-18', '-25', 30, 22, 25, 5.21, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2816, 'SA171A0054', '139507', 'Coolmix Assorted 26g', 111, '2', '1', '-18', '-21', 39, 27, 19, 4.41, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2817, 'SA171A0056', '139505', 'Coolmix Chocolate 26g', 111, '2', '4', '-18', '-21', 39, 27, 19, 4.41, 1, 0, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2818, 'SA171A0055', '139511', 'LamaiThai Mini Jackfruit Cakes 250g', 111, '2', '1', '-18', '-25', 38.5, 18, 18, 3.55, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2819, 'SA171A0050', '124702', 'Onion Bagel 4.5Oz.', 111, '2', '1', '-18', '-21', 129, 16, 39, 6.8, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2820, 'SA171A0059', '139509', 'LamaiThai Mini Pad See Ew 300g', 111, '2', '1', '-18', '-25', 24, 29, 22, 4.46, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2821, 'SA171A0059', '139506', 'Coolmix Greentea 26g', 111, '2', '1', '-18', '-21', 39, 27, 19, 4.41, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2822, 'SA171A0059', '138356', 'Pearl Milk Tea Ice Bar 4x350g', 111, '2', '1', '-18', '-21', 23, 32, 39, 17.7, 4, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2823, 'SA171A0062', '139504', 'Coolmix Strawberry 26g', 111, '2', '1', '-18', '-21', 39, 27, 19, 4.41, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2824, 'SA171A0063', '111849', 'Creekstone Premium Beef Puck', 111, '2', '1', '-18', '-21', 43, 30, 17, 8.16, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2825, 'SA171A0060', '139508', 'LamaiThai Pad Thai 300g', 111, '2', '1', '-18', '-21', 24, 29, 22, 4.46, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2826, 'SA171A0064', '107671', 'Dulce de Leche Repostero 24lb-Pail', 111, '2', '4', '21', '25', 1, 1, 1, 10, 1, 0, 20, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2827, 'SA171A0066', '139492', 'Magnum IC Bar ND Seasalt Caramel 3s', 111, '2', '1', '-18', '-21', 43, 30, 17, 8.16, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2828, 'SA171A0067', '139493', 'Mars M&M Cookie Sandwich Vanilla 4s', 111, '2', '1', '-18', '-21', 43, 30, 17, 8.16, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2829, 'SA171A0068', '139503', 'Mars M&M IC Cookie Sandwich Choc4s', 111, '2', '1', '-18', '-21', 43, 30, 17, 8.16, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2830, 'SA171A0067', '100066', 'Pizza Dough', 111, '2', '1', '-18', '-21', 23, 32, 39, 17.7, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2831, 'SA171A0070', '134552', 'Northern Grill Back Ribs w/BBQ 680g', 111, '2', '1', '-18', '-21', 24, 29, 40, 8.16, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2832, 'SA171A0070', '122850', 'Pud N Crème Cake Mix 50lbs', 111, '2', '4', '21', '25', 1, 1, 1, 10, 1, 0, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2833, 'SA171A0071', '134553', 'Northern Grill Ribs w/Honey Garlic 380g', 111, '2', '1', '-18', '-21', 24, 29, 40, 8.16, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2834, 'SA171A0073', '139494', 'Sea Best Printed Bag COD Fillets 1lb', 111, '2', '1', '-18', '-21', 43, 30, 17, 8.16, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2835, 'SA171A0074', '139495', 'Sea Best Printed Bag Snapper Fillets 1lb', 111, '2', '1', '-18', '-21', 43, 30, 17, 8.16, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2836, 'SA171AS0075', '124711', 'Sugar Apple Turnover 4Oz.', 111, '2', '1', '-18', '-21', 129, 16, 39, 6.8, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2837, 'SA171A0076', '124710', 'Sugar Cherry Turnover 4Oz.', 111, '2', '1', '-18', '-21', 129, 16, 39, 6.8, 11, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2838, 'SA171A0077', '100830', 'Tgif Buffalo Wings 9oz', 111, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2839, 'SA171A0078', '125708', 'Valpizza 4 Stagioni 9.8 14.1 Oz', 111, '2', '1', '-18', '-21', 23, 32, 39, 17.7, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2840, 'SA171A0079', '125705', 'Valpizza Margherita 9.8In 11.6Oz', 111, '2', '1', '-18', '-21', 23, 32, 39, 17.7, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2841, 'SA171A0080', '125706', 'Valpizza Mozzarella 9.8 In 12 Oz', 111, '2', '1', '-18', '-21', 23, 32, 39, 17.7, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2842, 'SA171A0081', '125707', 'Valpizza Prosciutto 9.8In 14.1 Oz', 111, '2', '1', '-18', '-21', 23, 32, 39, 17.7, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2843, 'SA171A0082', '125709', 'Valpizza Salami & Pepperoni 9.8In 14.1 Oz', 111, '2', '1', '-18', '-21', 23, 32, 39, 17.7, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2844, 'SA171A0083', '115715', 'White Castle Orig Slider Cheeseburger 6s', 111, '2', '1', '-18', '-21', 43, 30, 17, 8.16, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2845, 'SA171A0084', '115714', 'White Castle Orig Slider Hamburger 6s', 111, '2', '1', '-18', '-21', 43, 30, 17, 8.16, 1, 0, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2846, 'SA171A0085', '107674', 'Whole Strawberry Filling 38lb', 111, '2', '4', '-18', '-21', 30, 30, 30, 17.2, 1, 0, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2847, 'AA015A0119', 'TEMPO 16', 'CHOPPING BOARD (BIG)', 18, '1', '1', '0', '10', 1, 1, 1, 15, 1, 1, 3, 5, 'AA015A0119', 12, 0, 0, 'Active', 'Slow Moving', 'Low Value', 5, 5),
	(2848, 'AA015A0120', 'TEMPO 17', 'CHOPPING BOARD (SMALL)', 18, '1', '1', '0', '10', 1, 1, 1, 10, 1, 1, 3, 5, 'AA015A0120', 12, 0, 0, 'Active', 'Slow Moving', 'Low Value', 5, 5),
	(2849, 'AA015A0121', '2088', 'MIOR (2088)', 18, '1', '4', '21', '25', 1, 1, 1, 5, 12, 30, 3, 30, 'AA015A0121', 3, 0, 0, 'Active', 'Fast Moving', 'High Value', 30, 30),
	(2850, 'AA015A0122', '2086', 'MIOS (2086)', 18, '1', '4', '21', '25', 1, 1, 1, 5, 12, 30, 3, 30, 'AA015A0122', 3, 0, 0, 'Active', 'Fast Moving', 'High Value', 30, 30),
	(2860, 'EA173A0001', NULL, 'Pork Backbone - Hylife', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2861, 'EA173A0002', NULL, 'Pork Shoulder Picnic Blsl - Rivasam', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2862, 'EA173A0003', NULL, 'Chicken Drumstick X 20kg - Sofina', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2863, 'EA173A0004', NULL, 'Pork Cutting Fat Rindless,Hairless - Westfort', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2864, 'EA173A0005', NULL, 'Beef Tripe - Fpl', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2865, 'EA173A0006', NULL, 'Beef Tripe - Swift', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2866, 'EA173A0007', NULL, 'Chicken Breast Blsl - Copacol', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2867, 'EA173A0008', NULL, 'Chicken Feet - Casefarm', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2868, 'EA173A0009', NULL, 'Chicken Leg Quarter - Ajc', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2869, 'EA173A0010', NULL, 'Chicken Leg Quarter - Casefarm', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2870, 'EA173AP0011', NULL, 'Chicken Leg Quarter - Hallmark', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2871, 'EA173A0012', NULL, 'Chicken Leg Quarter - Koch', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2872, 'EA173A0013', NULL, 'Chicken Mdm - Koch', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2873, 'EA173A0014', NULL, 'Chicken Wings Drumettes - Copacol', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2874, 'EA173A0015', NULL, 'Four Star Beef Tripe Scalded', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2875, 'EA173A0016', NULL, 'Frozen Beef Body Fat - Kavanagh', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2876, 'EA173A0017', NULL, 'Frozen Pork Boneless Loins -  Premium Iowa', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2877, 'EA173A0018', NULL, 'Frozen Pork Ear Base With Pate - Smithfield', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2878, 'EA173A0019', NULL, 'Frozen Pork Fat/ Cutting Fat Rindless - Frescos', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2879, 'EA173A0020', NULL, 'Frozen Pork Jowls - Dubreton', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2880, 'EA173A0021', NULL, 'Frozen Pork Jowls - Tican', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2881, 'EA173A0022', NULL, 'Frozen Pork Leg Bone In - Olymel', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2882, 'EA173A0023', NULL, 'Frozen U.K Middle - Tulips', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2883, 'EA173A0024', NULL, 'Frozen U.K Primal Forend - Pilgrims', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2884, 'EA173A0025', NULL, 'Frozen U.K Primal Leg - Pilgrims', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2885, 'EA173A0026', NULL, 'Frozen U.K Primal Middle - Pilgrims', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2886, 'EA173A0027', NULL, 'Gold Creek Frozen Chicken Mdm', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2887, 'EA173A0028', NULL, 'Mechanically Seperated Chicken - Koch', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2888, 'EA173A0029', NULL, 'P.3 Piece  Carcass Shoulder - Prestage Foods', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2889, 'EA173A0030', NULL, 'P.Cutting Fat "Abbey"""', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2890, 'EA173A0031', NULL, 'Pork 3 Piece Carcass Middle - Prestage', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2891, 'EA173A0032', NULL, 'Pork Back Rind - Mc Carrens', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2892, 'EA173A0033', NULL, 'Pork Belly Biso - Cbco', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2893, 'EA173A0034', NULL, 'Pork Boneless Ham - Orviande', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2894, 'EA173A0035', NULL, 'Pork Carcass 6 Way Ham Leg - Cbco', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2895, 'EA173A0036', NULL, 'Pork Carcass 6 Way Ham Leg - Pilgrims', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2896, 'EA173A0037', NULL, 'Pork Carcass Biso - Middle', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2897, 'EA173A0038', NULL, 'Pork Carcass Fore End - Van Rooi', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2898, 'EA173A0039', NULL, 'Pork Carcass Ham Leg - Prestage', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2899, 'EA173A0040', NULL, 'Pork Cutting Fat - Pcb', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2900, 'EA173A0041', NULL, 'Pork Eardrum With Pate - Hormel', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2902, 'SK101A0018', NULL, 'Assorted Korean Products', 70, '1', '3', '0', '5', 1, 1, 1, 1, 1, 1, 3, 1, '', 11, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2907, 'SA171A0086', NULL, 'Creekstone Premium Black Angus', 111, '2', '1', '-18', '-21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2908, 'SA171A0087', NULL, 'OB Bonici Round Cut Pepperoni 2/12.5lbs', 111, '2', '1', '-18', '-21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2909, 'SA171A0088', '125773', 'OB B&B White Chocolate Cookie', 111, '2', '4', '-18', '-21', 1, 1, 1, 1, 1, 1, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2910, 'SA171A0089', NULL, 'OB Bonici Round Cut Pepperoni 2/12.5lbs', 111, '2', '1', '-18', '-21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2911, 'SA171A0090', 'TEMPO 2', 'Slice pepperoni', 111, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2912, 'SA171A0091', 'TEMPO 4', 'Jalapeno & Cheese Beef Hotdog', 111, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2913, 'SA171A0092', NULL, 'OB Flavorful Pineapple 38lbs', 111, '2', '4', '21', '25', 1, 1, 1, 1, 1, 1, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2914, 'CI133A0030', NULL, 'CHICKEN LEG BISO-AURORA', 85, '2', '1', '-18', '-21', 1, 1, 1, 12, 1, 0, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2915, 'CI133A0031', NULL, 'BEEF KNUCKLE-FRIBOI', 85, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 0, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2916, 'SA171A0093', NULL, 'Bonici Cooked Italian Pork Sausage Chunk toppings', 111, '2', '1', '-18', '-21', 1, 1, 1, 1, 1, 1, 3, 1, NULL, 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2917, 'SA171A0094', NULL, 'DR Ultra Chocolate 2.5', 111, '2', '4', '-18', '-21', 1, 1, 1, 1, 1, 1, 22, 1, NULL, 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2918, 'CI133A0032', NULL, 'FROZEN SQUID TUBE 1KG/10BAGS', 85, '1', '1', '-18', '-21', 1, 1, 1, 10, 10, 50, 3, 50, 'CI133A0032', 3, 450, 0, 'Active', 'Average Moving', 'Average Value', 50, 50),
	(2919, 'CI133A0033', NULL, 'FROZEN SQUID RING 1KG/10BAG', 85, '1', '1', '-18', '-21', 1, 1, 1, 10, 10, 50, 3, 50, 'CI133A0033', 3, 450, 0, 'Active', 'Average Moving', 'Average Value', 50, 50),
	(2920, 'CI133A0034', NULL, 'FROZEN SQUID RING 500G/20BAG', 85, '1', '1', '-18', '-21', 1, 1, 1, 10, 50, 50, 3, 50, 'CI133A0034', 3, 450, 0, 'Active', 'Average Moving', 'Average Value', 50, 50),
	(2921, 'CI133A0035', NULL, 'FROZEN SQUID RING 1KG BB', 85, '1', '1', '-18', '-21', 1, 1, 1, 1, 10, 30, 5, 30, 'CI133A0033', 3, 450, 0, 'Active', 'Average Moving', 'Average Value', 30, 30),
	(2938, 'CI133A0036', NULL, 'FROZEN VANNAMEI PDTO 51-60', 85, '2', '1', '-18', '-21', 1, 1, 1, 6, 6, 45, 3, 6, 'CI133A0036', 3, 0, 0, 'Active', 'Average Moving', 'Average Value', 45, 45),
	(2939, 'CI133A0037', NULL, 'VANNAMEI PD 31-40', 85, '2', '1', '-18', '-24', 1, 1, 1, 10, 10, 45, 3, 45, 'CI133A0037', 3, 0, 0, 'Active', 'Average Moving', 'Average Value', 45, 45),
	(2940, 'CI133A0038', NULL, 'VANNAMEI PD71-90', 85, '2', '1', '-18', '-24', 1, 1, 1, 10, 10, 45, 3, 45, 'CI133A0038', 3, 0, 0, 'Active', 'Average Moving', 'Average Value', 45, 45),
	(2941, 'SA171A0095', '130442', 'Cardinal Rh Pulled pork', 111, '1', '1', '-18', '-24', 1, 1, 1, 2.7, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2942, 'SA171A0096', '134538', 'Grimms Sizzlin Cheddar Bacon Smokes 450g', 111, '2', '1', '-18', '-24', 1, 1, 1, 4, 6, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2943, 'SA171A0097', '140306', 'Angus  Beef Burger 1.02kg', 111, '1', '1', '-18', '-24', 1, 1, 1, 1.02, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2944, 'SA171A0098', '140306', 'Angus beef burger', 111, '1', '1', '-18', '-24', 1, 1, 1, 7.2, 1, 1, 3, 1, '', 2, 1, 1, 'In-Active', 'Fast Moving', 'High Value', 1, 1),
	(2945, 'SA171A0099', '131649', 'Aqua star salt and pepper calamari 500g ', 111, '1', '1', '-18', '-24', 1, 1, 1, 4, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2946, 'SA171A0100', '140307', 'FRZ ASC SHRIMP GYOZA IQF', 111, '1', '1', '-18', '-24', 1, 1, 1, 5.44, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2947, 'SA171A0101', '138928', 'FRZ SALMON GYOZA IQF400G', 111, '1', '1', '-18', '-24', 1, 1, 1, 4.8, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2948, 'SA171A0102', '138929', 'FRZ SPICY VEGETABLE GYOZA IQF 400G', 111, '1', '1', '-18', '-24', 1, 1, 1, 4.8, 1, 1, 3, 1, '', 5, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2949, 'SA171A0103', '138930', 'FRZ BUTTERFISH IQF ', 111, '1', '1', '-18', '-24', 1, 1, 1, 9.7, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2950, 'SA171A0104', '138931', 'FRZ MOONFISH 150G IQF', 111, '1', '1', '-18', '-24', 1, 1, 1, 3, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2951, 'SA171A0105', '138932', 'FRZ COOKED CRAWFISH MEAT 200G', 111, '1', '1', '-18', '-24', 1, 1, 1, 4.8, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2952, 'SA171A0106', '134555', 'HARVEST ALL BEEF WIENERS C.O.V 450G', 111, '1', '1', '-18', '-24', 1, 1, 1, 5.4, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2953, 'SA171A0107', NULL, 'MOONFISH 20x500g', 111, '1', '1', '-18', '-24', 1, 1, 1, 1, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2954, 'AA015A0123', '2727', 'FROZEN PEELED & DEVEINED 71/90', 18, '1', '1', '-22', '-18', 1, 1, 1, 10, 10, 45, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2955, 'CI133A0039', NULL, 'PORK BELLY BLSL - PATEL', 85, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 0, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2956, 'CI133A0040', 'CI133A0040', 'FROZEN BONELESS BEEF KNUCKLE', 85, '2', '1', '-18', '-21', 0, 0, 0, 0, 50, 17, 3, 1, 'CI133A0040', 2, 1, 1, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(2957, 'CI133A0041', 'CI133A0041', 'FROZEN BEEF BONELESS TENDERLOINS', 85, '2', '1', '-18', '-21', 0, 0, 0, 0, 50, 7, 3, 1, '0', 2, 1, 0, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(2958, 'CI133A0042', 'CI133A0042', 'Frozen Cream Dory Untrimmed White Strap 10KGS', 85, '2', '1', '-18', '-21', 1, 1, 1, 10, 50, 50, 3, 1, '', 3, 1, 1, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(2959, 'CI133A0043', 'CI133A0043', 'Frozen Cream Dory Premium Green Strap 10KGS', 85, '2', '1', '-18', '-21', 1, 1, 1, 10, 50, 50, 3, 1, '', 3, 1, 1, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(2960, 'GP014A0047', NULL, 'ARLA PRO BURGER / SANDWICH SLICES RED SOS 12x1KG', 17, '1', '3', '0', '5', 3.46689882, 3.46689882, 3.46689882, 12, 1, 60, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2961, 'SA171A0108', '140061', 'Mars Dovebar Choc IC w/ Dark Choc 3CT', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2962, 'SA171A0109', '140062', 'Wymans Mixed Berries 15oz', 111, '2', '1', '18', '24', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2963, 'SA171A0110', '140063', 'Wymans Strawberries 15oz', 111, '1', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2964, 'SA171A0111', '140064', 'Wymans Wild Blueberries 15oz', 111, '1', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2965, 'SA171A0112', '140065', 'Super Pretzels Soft 6ct', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2966, 'SA171A0113', '140066', 'Super Pretzel Soft Bites 12oz', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2967, 'SA171A0114', '140067', 'Sea Best Printed Bag Pollock Fillet 500g', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2968, 'SA171A0115', '140068', 'Sea Best Printed Bag Swai Fillet 500g', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2969, 'SA171A0116', '113145', 'Hot Pocket Bacon Egg Cheese 9oz', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2970, 'SA171A0117', '113144', 'Hot Pocket Meatball w/ Mozzarella', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2971, 'SA171A0118', '113142', 'Hot Pocket Pepperoni Pizza 9oz', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2972, 'SA171A0119', '128895', 'Magnum IC Bar Double Chocolate 3PK', 111, '1', '4', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2973, 'SA171A0120', '128896', 'Magnum IC Bar Mini Double Caramel 6PK', 111, '1', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2974, 'SA171A0121', '133923', 'Hot Pockets Steak & Cheddar 9oz', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2975, 'SA171A0122', '128901', 'Tgif Chicken Wings Bbq Honey 9oz', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2976, 'LL020A0001', 'JS005A0001	', 'FROZEN BONELESS BEEF ROBBED FOREQUARTER', 23, '2', '1', '-18', '-21', 1, 1, 1, 0, 50, 50, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(2977, 'SA171A0123', NULL, 'Hot pockets ham and cheese 9oz', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2978, 'SA171A0124', '140503', 'Brauhaus Bava Pretzel-5oz/32CT', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2979, 'SA171A0125', '140504', 'OB Carrot Mini Bundt Cake 24ct', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2980, 'SA171A0126', '140505', 'OB Chocolate Bundt Cake 24ct', 111, '2', '4', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2981, 'SA171A0127', '140506', 'OB Confetti Mini Bundt Cake 24ct', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2982, 'SA171A0128', '140507', 'OB Lemon mini bundt cake 24ct', 111, '2', '4', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2983, 'SA171A0129', '140508', 'OB Red velvet mini bundt cake 24ct', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2984, 'SA171A0130', '140509', 'OB SD Peanut butter chunk cookie 1.5oz/240', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2985, 'SA171A0131', '140510', 'OB SD Oat crnbry nut 1.5oz/240', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2986, 'SA171A0132', '140511', 'OB SD Honey Raisin nut cookie 1.5oz/240', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2987, 'SA171A0133', '140512', 'OB SD Choco chunk salted caramel 1.5/240', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2988, 'SA171A0134', '140513', 'OB Supreme Monster 1.5oz/216', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2989, 'SA171A0135', '140514', 'OB Lab bulk soft pretzel bites 400ct', 111, '2', '1', '18', '21', 1, 1, 1, 0, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2990, 'SA171A0136', '140515', 'OB Auntie Annes classic soft pretzel 5ct', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2991, 'SA171A0137', '140514', 'OB Lab bulk soft pretzel bites 400ct', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2992, 'II174A0003', 'PRKLVR-COMPAXO-608', 'PORK LIVER COMPAXO', 114, '2', '1', '-18', '-25', 1, 1, 1, 10, 1, 80, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2993, 'II174A0004', 'FBEEFTRIM70-KLDR8661', 'FROZEN BEEF TRIMMING KILDARE', 114, '2', '1', '-18', '-25', 1, 1, 1, 0, 1, 30, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(2994, 'II174A0005', 'PRKLVR-COMPAXO-6080', 'PORK LIVER COMPAXO 10KG', 114, '2', '1', '18', '21', 1, 1, 1, 10, 1, 1, 3, 1, '', 2, 1, 1, 'Obsolete', 'Fast Moving', 'High Value', 1, 1),
	(2995, 'JS005A0135', NULL, 'Fish, Whole Golden Pompret 400/500G', 9, '1', '1', '-25', '-18', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'In-Active', 'Fast Moving', 'High Value', 1, 1),
	(2996, 'JS005A0136', NULL, 'Tuna Kama  1500up', 9, '1', '1', '-25', '-18', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Hold', 'Fast Moving', 'High Value', 1, 1),
	(2997, 'JS005A0137', NULL, 'Tuna Tail 500/1000', 9, '1', '1', '1', '1', 1, 1, 1, 10, 1, 1, 1, 1, '', 2, 1, 1, 'Hold', 'Fast Moving', 'High Value', 1, 1),
	(2998, 'AI083A0163', NULL, 'PORK TWA RIND ON JOWL - KARRO', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 30, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(2999, 'AI083A0164', NULL, 'PORK BELLY  BISO - YOSEMITE FOODS', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 25, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3000, 'CD119A0012', NULL, 'FIESTA FRIES 10KG', 77, '1', '1', '-25', '-18', 1, 1, 1, 10, 1, 1, 3, 1, '', 5, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3001, 'CD119A0013', NULL, 'SHOESTRING 7MM 5x2kg', 77, '1', '1', '-25', '-18', 1, 1, 1, 10, 1, 1, 3, 1, '', 5, 1, 1, 'Hold', 'Fast Moving', 'High Value', 1, 1),
	(3002, 'AI083A0001', NULL, 'Brisket ECT', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3003, 'AI083A0002', NULL, 'Brisket Hellaby', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3004, 'AI083A0003', NULL, 'Pork Jowls Skin On Pork N Bacon', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3005, 'AI083A0004', NULL, 'Beef Tripe Bovine Prime Range', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3006, 'AI083A0005', NULL, 'Trimmings Mondelli', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3007, 'AI083A0006', NULL, 'Robbed Forequarter Mondelli', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3008, 'AI083A0007', NULL, 'Shortloin - Wmpg Wmpg', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3009, 'AI083A0008', NULL, 'Pork Lacone Britco Pork', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3010, 'AI083A0009', NULL, 'Beef B/In Back Ribs St Helen', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3011, 'AI083A0010', NULL, 'Beef Bl Striploin (Select) St Helen', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3012, 'AI083A0011', NULL, 'Beef Bl Point End Brisket St Helen', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3013, 'AI083A0012', NULL, 'Beef B/In Striploin St Helen', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3014, 'AI083A0013', NULL, 'Beef BL Chuck Eye Roll St Helen', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3015, 'AI083A0014', NULL, 'Beef BL Striploin (Choice) Double Ranch', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3016, 'AI083A0015', NULL, 'Beef BL Top Striploin St Helen', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3017, 'AI083A0016', NULL, 'Pork Neckbone Frigo Royal', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3018, 'AI083A0017', NULL, 'Pork Belly Biso Cranswick', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3019, 'AI083A0018', NULL, 'Pork Belly BLSL Seara', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3020, 'AI083A0019', NULL, 'Beef Ribeyeroll 2-3kg Alliance', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3021, 'AI083A0020', NULL, 'Beef Ribeyeroll 3kg Alliance', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3022, 'AI083A0021', NULL, 'Pork Shoulder Blsl Gelada', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3023, 'AI083A0022', NULL, 'Beef Bl Rib Shortplate St Helen', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3024, 'AI083A0023', NULL, 'Beef Rib Eye Roll Bip On (Select) St Helen', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3025, 'AI083A0024', NULL, 'Lamb Fore Shank Wagstaff', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3026, 'AI083A0025', NULL, 'Beef Tripe Bindaree', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3027, 'AI083A0026', NULL, 'Pork Carcass Shoulder Orchard Farm', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3028, 'AI083A0027', NULL, 'Pork Carcass Vanrooi', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3029, 'AI083A0028', NULL, 'Pork Leg Vanrooi', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3030, 'AI083A0029', '0', 'Lamb Leg BL Wagstaff', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3031, 'AI083A0030', NULL, 'Beef Striploin Over 3 Taylor', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3032, 'AI083A0031', NULL, 'Beef Tongue Midfield', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3033, 'AI083A0032', NULL, 'Beef Shortloin Vp-Taylor Preston', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3034, 'AI083A0033', NULL, 'Pork Middle Rivalea', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3035, 'AI083A0034', NULL, 'Boneless ECT', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3036, 'AI083A0035', NULL, 'Bone Less Hilltop', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3037, 'AI083A0036', NULL, 'Da Tican', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3038, 'AI083A0037', NULL, 'Beef Rump Midfield Midfield', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3039, 'AI083A0038', NULL, 'Pork Jowls Skin On Midfield', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3040, 'AI083A0039', NULL, 'Pork Belly Flanks Vanrooi', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3041, 'AI083A0040', NULL, 'Lamb Shoulder Wagstaff', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3042, 'AI083A0041', NULL, 'Beef Cuberoll 1.1-1.55 Midfield', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3043, 'AI083A0042', NULL, 'Beef Cuberoll Over 1.55 Midfield', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3044, 'AI083A0043', NULL, 'Beef Ribeyeroll 2.2-3.1 Midfield', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3045, 'AI083A0044', NULL, 'Neck Bone Ect', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3046, 'AI083A0045', NULL, 'Neck Bone Hilltop', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3047, 'AI083A0046', NULL, 'Pork Belly Biso Famadesa', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3048, 'AI083A0047', NULL, 'Beef Shortrib Bone In Bx Food', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3049, 'AI083A0048', NULL, 'Beef Striploin Boneless Bx Food', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3050, 'AI083A0049', NULL, 'Beef Tenderloin Bx Food', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3051, 'AI083A0050', NULL, 'Pork Carcass Leg Ham Ausa', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3052, 'AI083A0051', NULL, 'Pork Carcass Fore End Ausa', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3053, 'AI083A0052', NULL, 'Pork Carcass Middle Ausa', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3054, 'AI083A0053', NULL, 'Pork Belly Ro Bi/Cut Karro', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3055, 'AI083A0054', NULL, 'Chicken  Drumstick Sofina Foods', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3056, 'AI083A0055', NULL, 'Beef Tenderloin Midfield', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3057, 'AI083A0056', NULL, 'Pork Jowls Skin On Cranswick', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3058, 'AI083A0057', NULL, 'Pork Shoulder Olymel', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3059, 'AI083A0058', NULL, 'Beef Cuberoll Ect', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3060, 'AI083A0059', NULL, 'Beef Shortribs  Rioplatense', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3061, 'AI083A0060', NULL, 'Pork Belly Biso Gps', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3062, 'AI083A0061', NULL, 'Headmeat Abp', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3063, 'AI083A0062', NULL, 'Green Lea Green Lea', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3064, 'AI083A0063', NULL, 'Beef Brisket Hellaby', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3065, 'AI083A0064', NULL, 'Shortribs Greenlea', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3066, 'AI083A0065', NULL, 'Pork Ham No Brand', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3067, 'AI083A0066', NULL, 'Trimmings Karro', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3068, 'AI083A0067', NULL, 'Pork Belly Gps', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3069, 'AI083A0068', NULL, 'Lamb Rack Wagstaff', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3070, 'AI083A0069', NULL, 'Beef Shank Ec Medina', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3071, 'AI083A0070', NULL, 'Pork Skin Gps', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3072, 'AI083A0071', NULL, 'Beef Short Ribs Kepak', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3073, 'AI083A0072', NULL, 'Beef Head Meat Abp', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3074, 'AI083A0073', NULL, 'Chicken Wings Tegel', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3075, 'AI083A0074', NULL, 'Pork Riblet Shoulder Dubreton', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3076, 'AI083A0075', NULL, 'Pork Skin Karro', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3077, 'AI083A0076', NULL, 'Pork Belly Biso Ausa', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3078, 'AI083A0077', NULL, 'Fish Bite Classic Crumbs', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3079, 'AI083A0078', NULL, 'Dory Oreo', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3080, 'AI083A0079', NULL, 'Fish Finger Fish Finger', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3081, 'AI083A0080', NULL, 'Whole Orange Whole Orange', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3082, 'AI083A0081', NULL, 'Cream Dory Cream Dory', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3083, 'AI083A0082', NULL, 'Sird Alfonsino Sird Alfonsino', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3084, 'AI083A0083', NULL, 'Hoki Pepper Crumb Hoki Pepper Crumb', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3085, 'AI083A0084', NULL, 'Gluten Free Crumb Gluten Free Crumb', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3086, 'AI083A0085', NULL, 'Hoki Potato Hoki Potato', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3087, 'AI083A0086', NULL, 'Hoki Batter Hoki Batter', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3088, 'AI083A0087', NULL, 'Hoki S/Off Hoki S/Off', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3089, 'AI083A0088', NULL, 'Hoki Tempura Hoki Tempura', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3090, 'AI083A0089', NULL, 'Pork Belly Karro', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3091, 'AI083A0090', NULL, 'Pork Trimming Karro', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3092, 'AI083A0091', NULL, 'Chicken Wings Supreme', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3093, 'AI083A0092', NULL, 'Salpicao Trimming Greenlea', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3094, 'AI083A0093', NULL, 'Pork Trimming Ausa', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3095, 'AI083A0094', NULL, 'Beef Brisket Ect', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3096, 'AI083A0095', NULL, 'Beef Shortrib Green Lea', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3097, 'AI083A0096', NULL, 'Kneecap Ec Medina', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3098, 'AI083A0097', NULL, 'Beef Trimmings No Brand', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3099, 'AI083A0098', NULL, 'Pork Belly Cranswick', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3100, 'AI083A0099', NULL, 'Beef Shortribs Green Lea', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3101, 'AI083A0100', NULL, 'Beef Ribeye Midfield', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3102, 'AI083A0101', NULL, 'Pork Shoulder No Brand', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3103, 'AI083A0102', NULL, 'Rib Finger Helen', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3104, 'AI083A0103', NULL, 'Chicken Drumstick Sofina Foods', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3105, 'AI083A0104', NULL, 'Chicken Leg Quarter Ajc', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3106, 'AI083A0105', NULL, 'Pork Trimmings Karro', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3107, 'AI083A0106', NULL, 'Pork Hamleg Bone In Olymel', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3108, 'AI083A0107', NULL, 'Pork Belly Skin On Bone In Rosderra', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3109, 'AI083A0108', NULL, 'Pork Jowls Karro', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3110, 'AI083A0109', NULL, 'Pork Leg Blsl Aurora', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3111, 'AI083A0110', NULL, 'Pork Belly Biso Seara', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3112, 'AI083A0111', NULL, 'Pork Leg Boneless Carniques', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3113, 'AI083A0112', NULL, 'Chicken Feet Turosi', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'In-Active', 'Average Moving', 'High Value', 1, 1),
	(3114, 'AI083A0113', NULL, 'Pork Back Bones Coles', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3115, 'AI083A0114', NULL, 'Chicken Drumstick Perdue', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3116, 'AI083A0115', NULL, 'Pork Belly Biso Karro', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3117, 'AI083A0116', NULL, 'Beef Bone In Shank Medina', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3118, 'AI083A0117', NULL, 'Beef Bone In Shin Medina', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3119, 'AI083A0118', NULL, 'Pork Leg Moes Gaard', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3120, 'AI083A0119', NULL, 'Pork Cheeks Moes Gaard', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3121, 'AI083A0120', NULL, 'Pork Belly Rindless Moes Gaard', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3122, 'AI083A0121', NULL, 'Pork Trum Moes Gaard', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3123, 'AI083A0122', NULL, 'Pork Shoulder Moes Gaard', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3124, 'AI083A0123', NULL, 'Pork 6 Way Cut Middle Bone In Wood Head', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3125, 'AI083A0124', NULL, 'Pork 6 Way Cut Leg Bone In Wood Head', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3126, 'AI083A0125', NULL, 'Pork 6 Way Cut Fore-End Wood Head', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3127, 'AI083A0126', NULL, 'Beef Shin Boneless Friboi', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3128, 'AI083A0127', NULL, 'Beef Shoulder Boneless Friboi', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3129, 'AI083A0128', NULL, 'Beef Brisket Boneless Friboi', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3130, 'AI083A0129', NULL, 'Beef Chuck Boneless Friboi', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3131, 'AI083A0130', NULL, 'Beef Industrial Meat Kepak Kepak', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3132, 'AI083A0131', NULL, 'Pork Belly Blsl Patel Patel', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3133, 'AI083A0132', NULL, 'Frozen Layer Hen Wings Supreme Poultry', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3134, 'AI083A0133', NULL, 'Pork Skin No Brand', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3135, 'AI083A0134', NULL, 'Pork Riblets Baucells', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3136, 'AI083A0135', NULL, 'Pork Riblets Shoulder Dubreton', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3137, 'AI083A0136', NULL, 'Pork Riblets Shoulder Frigo Royal', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3138, 'AI083A0137', NULL, 'Pork Back Fat La Comarca', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3139, 'AI083A0138', NULL, 'Beef Fat Trimmings Ubp', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3140, 'AI083A0139', NULL, 'Beef Tripe Prime Range', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3141, 'AI083A0140', NULL, 'Beef Ribeye Hellaby', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3142, 'AI083A0141', NULL, 'Beef Striploin Hellaby', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3143, 'AI083A0142', NULL, 'Beef Tenderloin Hellaby', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3144, 'AI083A0143', NULL, 'Beef Tail Diericks', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3145, 'AI083A0144', NULL, 'Beef Tongue Diericks', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3146, 'AI083A0145', NULL, 'Beef Brisket Boneless Ect', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3147, 'AI083A0146', NULL, 'Beef Brisket Boneless Hilltop', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3148, 'AI083A0147', NULL, 'Beef Fores Hind First Ught', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3149, 'AI083A0148', NULL, 'Beef Body Fat Amg', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3150, 'AI083A0149', NULL, 'Lamb Breast Mifield', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3151, 'AI083A0150', NULL, 'Pork Hind Quarter Trotters', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3152, 'AI083A0151', NULL, 'Beef Neck Bones Ect', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3153, 'AI083A0152', NULL, 'Beef Robbed Forequarter Agro Industrial', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3154, 'AI083A0153', NULL, 'Chicken Drumstick Tegel', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3155, 'AI083A0154', NULL, 'Beef Hind Shank Ec Medina', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3156, 'AI083A0155', NULL, 'Beef Fore Shin Ec Medina', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3157, 'AI083A0156', NULL, 'Pork Leg Boneless Aurora', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3158, 'AI083A0157', NULL, 'Cuberoll Boneless Midfield', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3159, 'AI083A0158', NULL, 'Chicken Drumstick Sofina', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3160, 'AI083A0159', NULL, 'Pork Shoulder Gelada', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3161, 'AI083A0160', NULL, 'Fore Shank Wagstaff', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3162, 'AI083A0161', NULL, 'Pork Belly Seara', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3163, 'AI083A0162', NULL, 'Pork Shoulder Coles', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3164, 'SA171A0138', '140578', 'Menorquina kuaky choc 70ml', 111, '1', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3165, 'SA171A0139', '140579', 'Menerquina friky strawberry 70ml', 111, '1', '2', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3166, 'SA171A0140', '140580', 'Menorquina dino egg vanilla 70ml', 111, '1', '2', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3167, 'SA171A0141', '140585', 'Pink albatros double choco chip 480ml', 111, '1', '2', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3168, 'SA171A0142', '140586', 'Pink albatros toasted hazelnut 480ml', 111, '1', '2', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3169, 'SA171A0143', '140587', 'Pink albatros chic choc coconut 480ml', 111, '1', '2', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3170, 'SA171A0144', '140588', 'Pink albatros arab coffee and choc 480ml', 111, '1', '2', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3171, 'SA171A0145', '131196', 'OB Panamar classic baguette', 111, '1', '1', '18', '21', 1, 1, 1, 1, 1, 1, 10, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3172, 'SA171A0146', '140581', 'Menorquina Lemon ice cream 6’s 180ml', 111, '1', '2', '18', '21', 1, 1, 1, 1, 1, 1, 10, 11, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3173, 'SA171A0147', '140582', 'Menorquina Lm vanilla choc 6’s 120ml', 111, '1', '1', '18', '21', 1, 1, 1, 1, 1, 1, 10, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3174, 'SA171A0148', '140583', 'Menorquina lm choc 4’s 130ml', 111, '1', '2', '18', '21', 1, 1, 1, 1, 1, 1, 10, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3175, 'SA171A0149', '140584', 'Menorquina haribo mini bombon 6’s 60ml', 111, '1', '2', '18', '21', 1, 1, 1, 1, 1, 1, 10, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3176, 'JS005AS0138', NULL, 'Salmon Heads 400  Snap Cut Salmo Salar Brand Youngs', 9, '1', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 37, 1, '', 3, 1, 1, 'Active', 'Slow Moving', 'High Value', 1, 1),
	(3177, 'JS005As0139', NULL, 'salmon Belly Boneless Frozen Salmo Salar Brand Youngs', 9, '2', '1', '-18', '-25', 1, 1, 1, 12.5, 1, 1, 37, 1, '', 3, 1, 1, 'Active', 'Slow Moving', 'High Value', 1, 1),
	(3180, 'GP014DB0048', '49', 'BERYLS 62 PERCENT DARK COURVERTURE COINS 1.5KG X 8', 17, '1', '4', '15', '25', 1, 1, 1, 1.5, 15, 15, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3181, 'GP014DB0049', '50', 'BERYLS 75 PERCENT DARK COUVERTURE COINS 1.5KG X 8', 17, '1', '4', '15', '25', 1, 1, 1, 1.5, 10, 10, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3182, 'GP014DB0050', '51', 'BERYLS 41 PERCENT MILK COUVERTURE CHOCOLATE 2KGX10', 17, '1', '4', '15', '25', 1, 1, 1, 2, 100, 100, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3183, 'GP014DB0051', '52', 'BERYLS DARK CHOCOLATE CHIPS 8,800CTS 1KGX10', 17, '1', '4', '15', '25', 1, 1, 1, 1, 70, 70, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3184, 'GP014DB0052', '53', 'BERYLS WHITE COMPOUND CHIPS IW-DR256 8,800CR KG 1KGX10', 17, '1', '4', '15', '25', 1, 1, 1, 1, 130, 130, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3185, 'GP014DB0053', '54', 'BERYLS SEMI SWEET CHIPS CHSS-CHP-52-350 350GMX8X4', 17, '1', '4', '15', '25', 1, 1, 1, 0.35, 70, 70, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3186, 'GP014DB0054', '55', 'BERYLS DARK CHOCOLATE CHUNK CHD-CK-1310-350 350GMX8X4', 17, '1', '4', '15', '25', 1, 1, 1, 0.35, 50, 50, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3187, 'GP014DB0055', '56', 'BERYLS BITTERSWEET COINS CHBS-CN-62-350 350GMX8X4', 17, '1', '4', '15', '25', 1, 1, 1, 0.35, 20, 20, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3188, 'GP014DB0056', '57', 'BERYLS 100 PERCENT PURE COCOA POWDER PCP-MR-11 1KGX12', 17, '1', '4', '15', '25', 1, 1, 1, 1, 15, 15, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3189, 'GP014DB0057', '58', 'BERYLS 100 PERCENT PURE COCOA POWDER PCP-MR-11 250GX40', 17, '1', '4', '15', '25', 1, 1, 1, 0.25, 15, 15, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3190, 'GP014DB0058', '59', 'BERYLS BLACK COCOA POWDER 1KGX12', 17, '1', '4', '15', '25', 1, 1, 1, 1, 10, 10, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3191, 'GP014DB0059', '60', 'BERYLS NAKED DARK CHOCOLATE COMPOUND 1KG X 10', 17, '1', '4', '15', '25', 1, 1, 1, 1, 617, 617, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3192, 'GP014DB0060', '61', 'BERYLS DARK COMPOUND BAR L-D19-NV 200G X 24', 17, '1', '4', '15', '25', 1, 1, 1, 0.2, 85, 85, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3193, 'GP014DB0061', '62', 'BERYLS WHITE COMPOUND BAR L-W24-NV 200G X 24', 17, '1', '4', '15', '25', 1, 1, 1, 0.2, 50, 50, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3194, 'GP014DB0062', '63', 'BERYLS SEMI SWEET COINS CHSS-CN-52-350 350 GM X 8 X 4', 17, '1', '4', '15', '25', 1, 1, 1, 0.35, 35, 35, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3195, 'GP014DB0063', '64', 'BERYLS 100 PERCENT PURE COCOA POWDER PCP-MR-11 500G X 20', 17, '1', '4', '15', '25', 1, 1, 1, 0.5, 5, 5, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3196, 'GP014DB0064', '65', 'BERYLS CHOCOLATE CHIP COOKIES MIX 2KG X 3', 17, '1', '4', '15', '25', 1, 1, 1, 2, 5, 5, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3197, 'GP014DB0065', '66', 'BERYLS TRIPLE CHOCOLATE COOKIE MIX WIH CHOCOLATE CHUNKS & CHIP 2KG X 3', 17, '1', '4', '15', '25', 1, 1, 1, 2, 10, 10, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3198, 'GP014DB0066', '67', 'BERYLS 8 PERCENT MILK CHOCOLATE COMPOUND 1KGX10', 17, '1', '4', '15', '25', 1, 1, 1, 1, 1200, 1200, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3199, 'GP014DB0067', '68', 'BERYLS DARK CHOCOLATE CHIPS  DR-CHD88-NV 8800CT/KG', 17, '1', '4', '15', '25', 1, 1, 1, 1.5, 20, 20, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3200, 'GP014DB0068', '68', 'BERYLS DARK CHOCOLATE CHIPS COUVERTURE 1.5KG X 8', 17, '1', '4', '15', '25', 1, 1, 1, 1.5, 20, 20, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3201, 'AI083AP0165', NULL, 'PORK NECKBONE IMACSA', 61, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3202, 'AI083AP0166', NULL, 'PORK NECKBONE IMACSA', 61, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 1, 3, 1, '', 2, 1, 1, 'Hold', 'Average Moving', 'High Value', 1, 1),
	(3203, 'AI083AP0167', NULL, 'PORK SIDE SPARE RIBS OLYMEL', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3204, 'SA171AN0150', '124069', 'NO WATER NEEDED YOKOZUNA RAMEN 465G', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 63, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3205, 'SA171AN0151', '124070', 'NO WATER NEEDED SHIKAIROU NAGAZAKI 518G', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3206, 'SA171AJ0152', '133487', 'JAPANESE RICE KOSHIHIKARITSURU MESHI400G', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3207, 'SA171AG0153', '133488', 'GOTSU UMAI OKONOMIYAKI 300G', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3208, 'SA171AG0154', '133489', 'GOTSU OMAI BIG GRAIN TAKOYAKI 197G 6PCS', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3209, 'SA171AG0155', '133490', 'GOTSU UMAI TAKOYAKI 190G', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3210, 'SA171AD0156', '133491', 'DOMESTIC CHICKEN SALTY FRIED CHICKEN 280G', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3211, 'SA171AN0157', '133496', 'NO PLATE NEEDED NO SOUP TANTAN NOODLE 292G', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3212, 'SA171AS0158', '138209', 'SOBAN WATER NEEDED YOKOHAMA KAKEI RAMEN 456G', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3213, 'SA171AY0159', '138211', 'YOKUBARI PLA YNG CHICKEN GARLICE TMT SAUNPPE TAMA 340G', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3214, 'SA171AY0160', '138212', 'YOKUBARI PLASHP NVEGETABLE METBLGNS340G', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3215, 'SA171AN0161', '138213', 'NOPLATE NEEDE BUKKAE BEEF UDON 263G', 111, '2', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3216, 'EA173A0042', NULL, 'Pork Flower Fat - Frigorificos', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3217, 'EA173A0043', NULL, 'Pork Fore End Biso - Pilgrims', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3218, 'EA173A0044', NULL, 'Pork Ham Bone In - Cbco', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3219, 'EA173A0045', NULL, 'Pork Ham Boneless - Smithfield', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3220, 'EA173A0046', NULL, 'Pork Ham Leg - Olymel', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3221, 'EA173A0047', NULL, 'Pork Ham Leg - Orviande', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3222, 'EA173A0048', NULL, 'Pork Ham Leg - Van Rooi', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3223, 'EA173A0049', NULL, 'Pork Jowls - Olymel', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3224, 'EA173A0050', NULL, 'Pork Jowls - Patel', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3225, 'EA173A0051', NULL, 'Pork Jowls Rind On - Aliments Asta', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3226, 'EA173A0052', NULL, 'Pork Jowls Rind On - Compaxo', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3227, 'EA173A0053', NULL, 'Pork Jowls Rind On - Exportslachthuis', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3228, 'EA173A0054', NULL, 'Pork Jowls Skin On Grade C - Americold', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3229, 'EA173A0055', NULL, 'Pork Jowls Skin On - Dubreton', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3230, 'EA173A0056', NULL, 'Pork Jowls Skin On - Litera', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3231, 'EA173A0057', NULL, 'Pork Jowls Skin On - Lucypork', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3232, 'EA173A0058', NULL, 'Pork Jowls So Grade B - Asta', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3233, 'EA173A0059', NULL, 'Pork Lacone - Cranswick', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3234, 'EA173A0060', NULL, 'Pork Lacone - Dubreton', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3235, 'EA173A0061', NULL, 'Pork Liver - Compaxo', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3236, 'EA173A0062', NULL, 'Pork Liver - Danish Crown', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3237, 'EA173A0063', NULL, 'Pork Liver - Koal', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3238, 'EA173A0064', NULL, 'Pork Loin Boneless - Smithfield', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3239, 'EA173A0065', NULL, 'Pork Loin Sirloin End - Smithfield', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3240, 'EA173A0066', NULL, 'Pork Mask - Renaud Viandes', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3241, 'EA173A0067', NULL, 'Pork Middle - Van Rooi', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3242, 'EA173A0068', NULL, 'Pork Picnic Shoulder - Olymel', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3243, 'EA173A0069', NULL, 'Pork Picnic Shoulder Blsl - Belgian', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3244, 'EA173A0070', NULL, 'Pork Picnic Shoulder Blsl - Carniques', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3245, 'EA173A0071', NULL, 'Pork Shoulder - Belgian', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3246, 'EA173A0072', NULL, 'Pork Shoulder - Olymel', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3247, 'EA173A0073', NULL, 'Pork Shoulder Blsl - Hylife', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3248, 'EA173A0074', NULL, 'Pork Shoulder Bone In - Cbco', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3249, 'EA173A0075', NULL, 'Pork Shoulder Bone In - Olymel', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3250, 'EA173A0076', NULL, 'Pork Shoulder Boneless - Van Rooi', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3251, 'EA173A0077', NULL, 'Pork Shoulder Picnic - Indiana Kitchen', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3252, 'EA173A0078', NULL, 'Pork Shoulder Picnic - Indiana Kitchen -', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3253, 'EA173A0079', NULL, 'Pork Shoulder Picnic Boneless - Smithfield', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3254, 'EA173A0080', NULL, 'Pork Side In 3 Cuts Forequarter Bone-In', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3255, 'EA173A0081', NULL, 'Pork Side In 3 Cuts Hindquarter Bone-In', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3256, 'EA173A0082', NULL, 'Pork Side In 3 Cuts Middle Bone-In', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3257, 'EA173A0083', NULL, 'Pork Side Spareribs - Olymel', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3258, 'EA173A0084', NULL, 'Pork Sirloin - Olymel', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3259, 'EA173A0085', NULL, 'Shoestring Fries - Golden Phoenix', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3260, 'VD092AB0001', '1000041', 'Beef Chuck Eyeroll Boneless-Swift', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3261, 'VD092AB0002', 'SLB 1000041', 'Beef Chuck Eyeroll Boneless-Swift', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 40, 1, 'VD092AB0001', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3262, 'VD092AB0003', '1000046', 'Beef Ribeye Lipon Boneless Angus-St. Helens', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3263, 'VD092AB0004', 'SLB 1000046', 'Beef Ribeye Lipon Boneless Angus-St. Helens', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 40, 1, 'VD092AB0003', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3264, 'VD092AB0005', '1000091', 'Cream Dory Fish Fillet 10kg 80%', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3265, 'VD092AB0006', 'PCK 1000091', 'Cream Dory Fish Fillet 10kg 80%', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, 'VD092AB0005', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3266, 'VD092AB0007', '1000105', 'Beef Top Blade -Five Star', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3267, 'VD092AB0008', 'SLB 1000105', 'Beef Top Blade -Five Star', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 40, 1, 'VD092AB0007', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3268, 'VD092AB0009', '1000120', 'Beef Tenderloin Utility 3/4-Palo Duro', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3269, 'VD092AB0010', 'SLB 1000120', 'Beef Tenderloin Utility 3/4-Palo Duro', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 40, 1, 'VD092AB0009', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3270, 'VD092AB0011', '1000126', 'Beef Shortplate Boneless-Cargill Excel', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3271, 'VD092AB0012', '1000131', 'Beef Shortplate Boneless -St. Helens', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3272, 'VD092AB0013', 'SLB 1000131', 'Beef Shortplate Boneless -St. Helens', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 40, 1, 'VD092AB0012', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3273, 'VD092AB0014', '1000160', 'Beef Shortplate Bl-Harris Ranch', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3274, 'VD092AB0015', '1000176', 'Beef Ribeye B/L Lipon Choice -St. Helens', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3275, 'VD092AB0016', 'SLB 1000176', 'Beef Ribeye B/L Lipon Choice -St. Helens', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 40, 1, 'VD092AB0015', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3276, 'VD092AB0017', '1000206', 'Beef Top Blade-Swift', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3277, 'VD092AB0018', '1000207', 'Chicken Leg Quarter 15kg -Perdue', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3278, 'VD092AB0019', '1000212', 'Lamb Bone In Foreshank-Midfield', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3279, 'VD092AB0020', 'PCS 1000212', 'Lamb Bone In Foreshank-Midfield', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 10, 1, 'VD092AB0019', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3280, 'VD092AB0021', '1000213', 'Lamb Rack Bone In-Midfield', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3281, 'VD092AB0022', 'BAG 1000213', 'Lamb Rack Bone In-Midfield', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 25, 1, 'VD092AB0021', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3282, 'VD092AB0023', 'PCS 1000213', 'Lamb Rack Bone In-Midfield', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 10, 1, 'VD092AB0021', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3283, 'VD092AB0024', 'SLB 1000213', 'Lamb Rack Bone In-Midfield', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 40, 1, 'VD092AB0021', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3284, 'VD092AB0025', '1000284', 'Beef Shortplate Boneless -Ibp Tyson', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3285, 'VD092AB0026', '1000308', '032168 Conquest Sidewinders Orig Cut 6 X 1.82kg....', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3286, 'VD092AB0027', 'PCK 1000308', '032168 Conquest Sidewinders Orig Cut 6 X 1.82kg....', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, 'VD092AB0026', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3287, 'VD092AB0028', '1000337', 'Chicken Leg Quarter 15kg - Ajc', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3288, 'VD092AB0029', '1000349', 'Beef Shortplate Boneless-Iowa', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3289, 'VD092AB0030', 'SLB 1000349', 'Beef Shortplate Boneless-Iowa', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 40, 1, 'VD092AB0029', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3290, 'VD092AB0031', '1000360', 'Beef Shortplate Nebraska (Quarter Cut', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3291, 'VD092AB0032', '1000378', 'Beef Shortplate Boneless-Four Star..', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 3, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3292, 'VD092AB0033', 'SLB 1000378', 'Beef Shortplate Boneless-Four Star..', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 40, 1, 'VD092AB0032', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3293, 'VD092AB0034', '1000398', 'Pork Belly Biso - Danish Crown..', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3294, 'VD092AB0035', '1000404', 'Beef Hanging Tender Utility - Palo Duro', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3295, 'VD092AB0036', 'SLB 1000404', 'Beef Hanging Tender Utility - Palo Duro', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 40, 1, 'VD092AB0035', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3296, 'VD092AB0037', '1000415', 'Beef Rib Finger-Four Star', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3297, 'VD092AB0038', '1000430', 'Pork Belly Bl/Sl-Incarlopsa', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3298, 'VD092AB0039', '1000431', 'Beef Robbed Forequarter - Friboi..', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3299, 'VD092AB0040', '1000440', 'Beef Striploin No Roll-Nebraska', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3300, 'VD092AB0041', 'SLB 1000440', 'Beef Striploin No Roll-Nebraska', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 40, 1, 'VD092AB0040', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3301, 'VD092AB0042', '1000441', 'Beef Ribeye No Roll Angus-Nebraska', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3302, 'VD092AB0043', 'SLB 1000441', 'Beef Ribeye No Roll Angus-Nebraska', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 40, 1, 'VD092AB0042', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3303, 'VD092AB0044', '1000452', 'Beef Bnls Short Ribs Ch Angus-Creekstone', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3304, 'VD092AB0045', 'PRK 1000455', 'Pork Meats Sawdust', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3305, 'VD092AB0046', 'BEEF 1000455', 'Beef Meats Sawdust', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3306, 'VD092AB0047', '1000459', 'Ground Pork Shouder-Rosderra)', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3307, 'VD092AB0048', 'PCK 1000459', 'Ground Pork Shouder-Rosderra)', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, 'VD092AB0047', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3308, 'VD092AB0049', '1000461', 'Cream Dory Fish Fillet 10kg 100%', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3309, 'VD092AB0050', 'PCK 1000461', 'Cream Dory Fish Fillet 10kg 100%', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, 'VD092AB0049', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3310, 'VD092AB0051', '1000464', 'Ground Beef 2kg', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3311, 'VD092AB0052', 'PCK 1000464', 'Ground Beef 2kg', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, 'VD092AB0051', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3312, 'VD092AB0053', '1000494', 'Beef Chuck Short Ribs B/In No Roll-Nebraska', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3313, 'VD092AB0054', '1000495', 'Rib Eye Choice Steak Cut- St. Helen', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3314, 'VD092AB0055', 'PCS 1000495', 'Beef Ribeye Choice 3/4 Cut-St.Helens', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 10, 1, 'VD092AB0054', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3315, 'VD092AB0056', '1000503', 'Pork Belly Chop Forend - Debra Meat', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3316, 'VD092AB0057', '1000504', 'Pork Belly Liempo Cut', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3317, 'VD092AB0058', '1000507', 'Chicken Leg Quarter 15kg - Koch Foods..', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3318, 'VD092AB0059', '1000519', 'Pork Scraps', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3319, 'VD092AB0060', '1000520', 'Us Beef Shortplate Thinly Sliced 2mm-Nebraska)', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3320, 'VD092AB0061', '1000538', 'Pork Fats ..', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3321, 'VD092AB0062', '1000540', 'Beef Trimmings - Friboi', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3322, 'VD092AB0063', '1000542', 'Beef Shortloin Bone In Angus Us-St. Helens', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3323, 'VD092AB0064', '1000549', 'Beef Shortplate Boneless-Foyle', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3324, 'VD092AB0065', 'SLB 1000549', 'Beef Shortplate Boneless-Foyle', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 40, 1, 'VD092AB0064', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3325, 'VD092AB0066', '1000553', 'Pork Bnls Picnic Shoulder - Smithfield', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3326, 'VD092AB0067', '1000554', 'Beef Chuck Tender Br-Mondelli', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3327, 'VD092AB0068', 'SLB 1000554', 'Beef Chuck Tender Br-Mondelli', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 40, 1, 'VD092AB0067', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3328, 'VD092AB0069', '1000555', 'Pork Belly Bl/Sl-Provision', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3329, 'VD092AB0070', '1000562', 'Beef Flanks-Danish Crown', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3330, 'VD092AB0071', '1000563', 'Pork Spareribs-Seaboard', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3331, 'VD092AB0072', '1000564', 'Pork Loin B/In Shoulder End-Seaboard', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3332, 'VD092AB0073', '1000565', 'Pork Loin Bnls Center Cut-Seaboard', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3333, 'VD092AB0074', 'SLB 1000565', 'Pork Loin Bnls Center Cut-Seaboard', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 40, 1, 'VD092AB0073', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3334, 'VD092AB0075', '1000567', 'Beef Brisket - Fourstar', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3335, 'VD092AB0076', '1000570', 'Beef Plate Pastrami Ends- Excell', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3336, 'VD092AB0077', '1000573', 'Beef Navel End Brisket (Shortplate) - Kepak', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3337, 'VD092AB0078', 'SLB 1000573', 'Beef Navel End Brisket (Shortplate) - Kepak', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 40, 1, 'VD092AB0077', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3338, 'VD092AB0079', '1000574', 'Chicken Leg Meat Bnls Skin On - Copacol', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3339, 'VD092AB0080', '1000575', 'Pork Picnic Shoulder Bnls - Asta', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3340, 'VD092AB0081', '1000576', 'Beef Shortplate - Greater Omaha', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3341, 'VD092AB0082', 'SLB 1000576', 'Beef Shortplate - Greater Omaha', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 40, 1, 'VD092AB0081', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3342, 'VD092AB0083', '1000577', 'Beef Chuck Tender - Quality', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3343, 'VD092AB0084', '1000579', 'Beef Robbed Forequarter - Estrela', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3344, 'VD092AB0085', '1000581', 'Beef  Sukiyaki Cut -  Strella', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3345, 'VD092AB0086', '1000582', 'Beef Trimmings - Strella', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3346, 'VD092AB0087', 'TEMPO 109', 'B. SHORTPLATE THINLY SLICE - PASTRAMI EXCEL 5KG/PCK', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3347, 'VD092AB0088', 'TEMPO 110', 'B. SHORTPLATE THINLY SLICE - PASTRAMI EXCEL 1KG/PCK', 67, '2', '1', '-25', '-18', 1, 1, 1, 1, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3348, 'VD092AB0089', '1000584', 'Beef Trimmings - Pastrami Excel', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3349, 'VD092AB0090', '1000585', 'Pork Shoulder B/In Skin On (Whole) - Olymel', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3350, 'VD092AB0091', '1000589', 'Beef Shortplate - El Encinar', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3351, 'VD092AB0092', '1000590', 'Us Beef Shortplate Thinly Slice-Harris Ranch)', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3352, 'VD092AB0093', '1000591', 'Pork Collar Smithfield-Usa ', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3353, 'VD092AB0094', '1000592', 'Pork Picnic Shoulder Blsl - Olymel', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3354, 'VD092AB0095', '1000594', 'Pork, Middle Bone In - Debra Meat', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3355, 'VD092AB0096', '1000595', 'Pork, Leg Bone In W/O Foot - Debra Meat', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3356, 'VD092AB0097', '1000596', 'Beef Thin Slice - El Encinar', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3357, 'VD092AB0098', '1000599', 'Pork Chop Middle-Debra Meat', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3358, 'VD092AB0099', '1000600', 'Pork Liempo Cut Middle - Debra Meat', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3359, 'VD092AB0100', '1000601', 'Frozen Pork Belly Bone In - Van Rooi', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3360, 'VD092AB0101', '1000602', 'Pork, Fore-End Bone In- Debra Meat', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3361, 'VD092AB0102', '1000603', 'Pork Chop Forend - Debra Meat', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3362, 'VD092AB0103', '1000604', 'Pork Cubes Forend - Debra Meat', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3363, 'VD092AB0104', '1000606', 'Frozen Chicken Mdm - Trinity', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3364, 'VD092AB0105', 'TEMPO 1', 'Chicken, Mdm - Coopavel', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3365, 'VD092AB0106', 'TEMPO 10', 'Fries, Potato Savory Wedge S-On', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3366, 'VD092AB0107', 'TEMPO 100', 'Beef Thinly Sliced - Fourstar', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3367, 'VD092AB0108', 'TEMPO 101', 'Pork Thinly Sliced - Provision', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3368, 'VD092AB0109', 'PCK TEMPO 102', 'Beef Cubes - Estrella', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3369, 'VD092AB0110', 'PCK TEMPO 103', 'Pork Fats - Provision', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3370, 'VD092AB0111', 'TEMPO 11', 'Beef, Tapa Cut - Fourstar', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3371, 'VD092AB0112', 'TEMPO 12', 'Beef, Rib Finger - Swift', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3372, 'VD092AB0113', 'TEMPO 13', 'Pork, Collar', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3373, 'VD092AB0114', 'TEMPO 14', 'Chicken, Breast', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'In-Active', 'Fast Moving', 'High Value', 1, 1),
	(3374, 'VD092AB0115', 'PCK TEMPO 14', 'Chicken, Breast', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, 'VD092AB0114', 2, 1, 1, 'In-Active', 'Fast Moving', 'High Value', 1, 1),
	(3375, 'VD092AB0116', 'TEMPO 15', 'Chicken, Leg Quarter - Seara', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3376, 'VD092AB0117', 'PCK TEMPO 15', 'Chicken, Leg Quarter - Seara', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, 'VD092AB0116', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3377, 'VD092AB0118', 'TEMPO 16', 'Beef, Shortplate - Swift', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3378, 'VD092AB0119', 'SLB TEMPO 16', 'Beef, Shortplate - Swift', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 40, 1, 'VD092AB0118', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3379, 'VD092AB0120', 'TEMPO 17', 'Beef, Shortloin - Swift', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3380, 'VD092AB0121', 'SLB TEMPO 17', 'Beef, Shortloin - Swift', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 40, 1, 'VD092AB0120', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3381, 'VD092AB0122', 'TEMPO 18 ', 'Pork, Spareribs - Smithfield', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3382, 'VD092AB0123', 'TEMPO 19', 'Pork, Belly Blsl', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3383, 'VD092AB0124', 'TEMPO 2', 'Beef, Trimmings', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3384, 'VD092AB0125', 'PCK TEMPO 2', 'Beef, Trimmings', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, 'VD092AB0124', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3385, 'VD092AB0126', 'TEMPO 21', 'Beef, Rib Finger - Creekstone', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3386, 'VD092AB0127', 'TEMPO 22', 'Beef, Shortplate - Quarter Cut', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3387, 'VD092AB0128', 'TEMPO 23', 'Pork, Belly Skin', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3388, 'VD092AB0129', 'TEMPO 24', 'Lamb, Leg Chump Off - Midfield', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3389, 'VD092AB0130', 'SLB TEMPO 24', 'Lamb, Leg Chump Off - Midfield', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 40, 1, 'VD092AB0129', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3390, 'VD092AB0131', 'TEMPO 25', 'Lamb, Shoulder Bnls', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3391, 'VD092AB0132', 'TEMPO 26', 'Lamb, Shoulder - Midfield', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3392, 'VD092AB0133', 'PCS TEMPO 26', 'Lamb, Shoulder - Midfield', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 10, 1, 'VD092AB0132', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3393, 'VD092AB0134', 'TEMPO 27', 'Beef, Thin Slice - Pastrami Excel', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3394, 'VD092AB0135', 'TEMPO 28', 'Beef, Thin Slice - Harris Ranch', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3395, 'VD092AB0136', 'TEMPO 29', 'Beef, Sukiyaki -  Pastrami Excel', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3396, 'VD092AB0137', 'PCK TEMPO 30', 'Beef, Shortplate Cut Into 4', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3397, 'VD092AB0138', 'SLB TEMPO 31', 'Beef, Chuck Eyeroll - Excel', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 40, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3398, 'VD092AB0139', 'SLB TEMPO 32', 'Beef, Chuck Eyeroll - Mondelli', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 40, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3399, 'VD092AB0140', 'SLB TEMPO 33', 'Beef, Shortplate Angus', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 40, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3400, 'VD092AB0141', 'SLB TEMPO 34', 'Beef, Shortrib - Excel', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 40, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3401, 'VD092AB0142', 'TEMPO 47', 'Beef Sukiyaki Cut', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3402, 'VD092AB0143', 'TEMPO 48', 'Beef Cubes Friboi', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3403, 'VD092AB0144', 'TEMPO 49', 'Pork Belly Biso - Westfort', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3404, 'VD092AB0145', 'PCK TEMPO 50', 'Chicken Leg Meat Blso - Seara', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3405, 'VD092AB0146', 'PCK TEMPO 51', 'Beef Shortplate - Fourstar Jbs', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3406, 'VD092AB0147', 'PCK TEMPO 52', 'Carton Box', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 25, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3407, 'VD092AB0148', 'PCK TEMPO 53', 'Pork Belly Blsl Flanks Off - Cooperl', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3408, 'VD092AB0149', 'PCK TEMPO 54', 'Pork Loin Tongkatsu Cut - Seaboard', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3409, 'VD092AB0150', 'PCK TEMPO 55', 'Premium Steak - Smithfield', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3410, 'VD092AB0151', 'PCK TEMPO 56', 'Beef Cubes X 25kg', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3411, 'VD092AB0152', 'PCK TEMPO 57', 'Beef Cubes X 15kg', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3412, 'VD092AB0153', 'PCK TEMPO 58', 'Beef Ribeye Steak Cut', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3413, 'VD092AB0154', 'PCK TEMPO 59', 'P.Premium Steak Cut X 25kg', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3414, 'VD092AB0155', 'TEMPO 6', 'Beef, Tenderloin Utility 4/5 - Palo Duro', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3415, 'VD092AB0156', 'PCK TEMPO 60', 'P.Premium Steak Cut X 1kg', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3416, 'VD092AB0157', 'PCK TEMPO 61', 'Pork Chop Loin X 25kg', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3417, 'VD092AB0158', 'PCK TEMPO 62', 'Pork Chop Loin X 23kg', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3418, 'VD092AB0159', 'PCK TEMPO 63', 'Pork Liempo Cut X 25kg', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3419, 'VD092AB0160', 'PCK TEMPO 64', 'Pork Liempo Cut X 1kg', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3420, 'VD092AB0161', 'PCK TEMPO 65', 'Pork Fore End Chop Kasim X 1kg', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3421, 'VD092AB0162', 'PCK TEMPO 66', 'Pork Fore End Cubes X 1kg', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3422, 'VD092AB0163', 'PCK TEMPO 67', 'Beef Thinly Sliced - Kepak X 1kg', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3423, 'VD092AB0164', 'PCK TEMPO 68', 'Assorted Meat', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3424, 'VD092AB0165', 'PCK TEMPO 69', 'Beef Rib Eye Bnls - Four Star', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3425, 'VD092AB0166', 'TEMPO 7', 'Beef, Thinly Sliced', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3426, 'VD092AB0167', 'PCK TEMPO 70', 'Beef Cubes X 1kg', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3427, 'VD092AB0168', 'PCK TEMPO 71', 'Pork Chop X 1kg', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3428, 'VD092AB0169', 'PCK TEMPO 72', 'Pork Cubes X 1kg', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3429, 'VD092AB0170', 'PCK TEMPO 73', 'Beef Thinly Sliced - Kepak X 30kg', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3430, 'VD092AB0171', 'PCK TEMPO 74', 'Beef Thinly Sliced - Kepak X 20kg', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3431, 'VD092AB0172', 'PCK TEMPO 75', 'Beef Thinly Sliced - Kepak X 25kg', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3432, 'VD092AB0173', 'PCK TEMPO 76', 'Pork Chops Loin - Middle - Debra X 24kg', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3433, 'VD092AB0174', 'PCK TEMPO 77', 'Pork Chops Loin - Middle - Debra X 1kg', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3434, 'VD092AB0175', 'PCK TEMPO 78', 'Pork Liempo Middle - Debra X 24kg', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3435, 'VD092AB0176', 'PCK TEMPO 79', 'Pork Liempo Middle - Debra X 1kg', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3436, 'VD092AB0177', 'TEMPO 8', 'Fries, Shoestring (Old Stock)', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3437, 'VD092AB0178', 'PCK TEMPO 80', 'Pork Chop B/In - Debra', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3438, 'VD092AB0179', 'PCK TEMPO 81', 'Pork Liempo B/In - Debra', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3439, 'VD092AB0180', 'PCK TEMPO 82', 'Beef Thinly Sliced - No Brand', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3440, 'VD092AB0181', 'PCK TEMPO 83', 'Pork Trimmings', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3441, 'VD092AB0182', 'PCK TEMPO 84', 'Beef Thinly Sliced - Kepak X 10kg', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3442, 'VD092AB0183', 'TEMPO 85', 'Pork Pata', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3443, 'VD092AB0184', 'PCK TEMPO 86', 'Pork Loin Tonkatsu - Seaboard', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3444, 'VD092AB0185', 'PCK TEMPO 87', 'Pork Cubes Kasim - Debra Meat', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3445, 'VD092AB0186', 'PCK TEMPO 88', 'Pork Pata - Debra Meat', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3446, 'VD092AB0187', 'PCK TEMPO 89', 'Pork Chop Kasim', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3447, 'VD092AB0188', 'TEMPO 9', 'Fries, Potato Savory Wedge 8-Cut', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3448, 'VD092AB0189', 'PCK TEMPO 90', 'Pork Cubes Ham Leg - Debra Meat', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3449, 'VD092AB0190', 'PCK TEMPO 91', 'Pork Premium Steak - Smithfield', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3450, 'VD092AB0191', 'PCK TEMPO 92', 'Beef Thinly Sliced - Kepak', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3451, 'VD092AB0192', 'PCK TEMPO 93', 'Beef Thinly Sliced - St Helen', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3452, 'VD092AB0193', 'PCK TEMPO 94', 'Pork Belly Bone In Skin On - Famadesa', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3453, 'VD092AB0194', 'PCK TEMPO 95', 'Pork Pata Slice - Debra Meat', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3454, 'VD092AB0195', 'PCK TEMPO 96', 'Beef Rib Eye Steak - Fourstar', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3455, 'VD092AB0196', 'PCK TEMPO 97', 'Beef Angus Premium Thinly Sliced - Iowa', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3456, 'VD092AB0197', 'PCK TEMPO 98', 'Quarterly Cut Thinly Sliced - Nebraska', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3457, 'VD092AB0198', 'PCK TEMPO 99', 'Quarterly Cut Thinly Sliced - Foyle', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3458, 'VD092AB0199', 'PCK TEMPO 104', 'B. Rib Eye End Cut - Fourstar', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3459, 'VD092AB0200', 'PCK TEMPO 105', 'B. Trimmings - Fourstar', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3460, 'VD092AB0201', 'PCK TEMPO 106', 'B. Cubes - Danish Crown', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3461, 'VD092AB0202', 'PCK TEMPO 107', 'Beef Thinly Sliced - Incarlopsa', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3462, 'VD092AB0203', 'PCK TEMPO 108', 'B. Sukiyaki Cut - Friboi', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3463, 'AA015AM0123', 'TEMPO01', 'SAMPLE FOR ALSON (FROZEN)', 18, '1', '1', '-18', '-25', 1, 1, 1, 10, 20, 45, 3, 7, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3464, 'CI133AF0044', '007138', 'FROZEN BONELESS BEEF FOREQUARTER (RB)(HALAL)', 85, '2', '1', '18', '21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3465, 'AI083AB0168', NULL, 'BEEF BONELESS PS NAVELEND HELLABY', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3466, 'AI083AP0169', NULL, 'PORK COLLAR BONELESS SEARA', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3467, 'AA015DS0124', 'TEMPO02', 'SAMPLE FOR ALSONS (DRY)', 18, '1', '4', '20', '30', 1, 1, 1, 10, 1, 45, 3, 1, '', 15, 365, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3471, 'AI083AC0170', NULL, 'CHICKEN FEET TUROSI', 61, '2', '1', '-18', '-21', 1, 1, 1, 20, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3472, 'SA171DV0162', '---', 'VALRHONA 4653 GUANAJA', 111, '2', '4', '21', '25', 1, 1, 1, 3, 1, 1, 4, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3473, 'SA171DV0163', '--', 'VALRHONA 4661 GUANAJA', 111, '2', '4', '21', '25', 1, 1, 1, 15, 1, 1, 4, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3474, 'SA171DA0164', '--', 'ARIAGA VALRHONA 66% 4654', 111, '2', '4', '21', '25', 1, 1, 1, 10, 1, 1, 4, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3475, 'SA171DA0165', '--', 'ARTISAN DARK CHOCOLATE 70%', 111, '2', '4', '21', '25', 1, 1, 1, 5, 1, 1, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3476, 'SA171DA0166', '--', 'ARTISAN MILK 40% COUVERTURE', 111, '2', '4', '21', '25', 1, 1, 1, 5, 1, 1, 4, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3477, 'SA171DA0167', '--', 'ARTISAN MILK 34.6% COUVERTURE', 111, '2', '4', '21', '25', 1, 1, 1, 2.5, 1, 1, 4, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3478, 'SA171DA0168', '--', 'ARTISAN COCOA POWDER 100%', 111, '2', '4', '21', '25', 1, 1, 1, 1, 1, 1, 4, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3479, 'SA171DA0169', '--', 'ARTISAN DARK 61% COCOA COUVERTURE', 111, '2', '4', '21', '25', 1, 1, 1, 2.5, 1, 1, 4, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3480, 'SA171DA0170', '--', 'ARTISAN DARK CHOCOLATE 58% COCOA', 111, '2', '4', '21', '25', 1, 1, 1, 2.5, 1, 1, 4, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3481, 'SA171DB0171', '--', 'BAKING PAPER I SILICONED', 111, '2', '4', '21', '25', 1, 1, 1, 2.3, 1, 1, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3482, 'SA171DA0172', '--', 'AGAR GELLING 700G', 111, '2', '4', '21', '25', 1, 1, 1, 0.7, 1, 1, 22, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3483, 'SA171DY0173', '--', 'YELLOW COCOA BUTTER', 111, '2', '4', '21', '25', 1, 1, 1, 0.7, 1, 1, 22, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3484, 'SA171DS0174', '--', 'SHINY SILVER FOODCOLORING', 111, '2', '4', '21', '25', 1, 1, 1, 0.7, 1, 1, 22, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3485, 'SA171DS0175', '--', 'SHINY COLORANT POWDER GOLD', 111, '2', '4', '21', '25', 1, 1, 1, 0.7, 1, 1, 22, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3486, 'SA171DG0176', '--', 'GREEN COCOA SOLUBLE C', 111, '2', '4', '21', '25', 1, 1, 1, 0.7, 1, 1, 22, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3487, 'SA171DC0177', '--', 'COLORANT SOLUBLE YELLOW', 111, '2', '4', '21', '25', 1, 1, 1, 0.7, 1, 1, 22, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3488, 'SA171AL0178', '1407602', 'LR ITALIANICEVAR LMN&STRWBERRY 6/6 FLOZ', 111, '1', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3489, 'SA171AL0179', '1407619', 'LR ITALIAN ICE VARIETY PACK 6/6 FL OZ', 111, '1', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3490, 'SA171AM0180', '1407626', 'MMSOFT FROZEN LEMONADE CUP LEMON 12FLOZ', 111, '1', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3491, 'SA171AM0181', '1407633', 'MMSOFT FROZEN LEMONADE CUPSTRWBEY12FLOZ', 111, '1', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3492, 'SA171AM0182', '1407633', 'MMSOFT FROZEN LEMONADE CUPSTRWBEY12FLOZ', 111, '1', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Hold', 'Fast Moving', 'High Value', 1, 1),
	(3493, 'SA171AM0183', '1407640', 'MMSOFT FROZEN ORANGEDE12FLOZ', 111, '1', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3494, 'SA171AM0184', '1407640', 'MMSOFT FROZEN ORANGEDE12FLOZ', 111, '1', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Hold', 'Fast Moving', 'High Value', 1, 1),
	(3495, 'SA171AW0185', '1407657', 'WF STRAWBERRY 4/2.75FLOZ', 111, '1', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3496, 'SA171AW0186', '1407660', 'WF BLK CHERRY 4/2.75FL', 111, '1', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3497, 'SA171AI0187', '1407677', 'ICEE-CHERRY CUO 12OZ', 111, '1', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3498, 'SA171AI0188', '1407683', 'ICEE-BLURASP CUP-12OZ', 111, '1', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3499, 'SA171AI0189', '1407691', 'ICEE-FROSTED LEMADE-12OZ', 111, '1', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3500, 'SA171AB0190', '1407707', 'BARQS ROOTBEER FLOAT30OZ', 111, '1', '1', '18', '21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3501, 'VD092AP0204', NULL, 'Pork, Middle Bone In - Debra Meat', 67, '2', '1', '-25', '-18', 1, 1, 1, 1, 1, 1, 4, 1, 'VD092AB0095', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3502, 'VD092AP0205', NULL, 'Pork Chop Middle-Debra Meat', 67, '2', '1', '-25', '-18', 1, 1, 1, 1, 1, 1, 4, 1, 'VD092AB0098', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3503, 'MT023A0128', 'TEMPO07', 'SMALL MUSCLE BACKGROUND - KARRO', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(3504, 'MT023A0133', 'TEMPO13', 'CHILI & LIME CHICKEN SAUSAGES & TARRAGON SAUSAGES - BOSTOCK', 26, '2', '1', '-25', '-18', NULL, NULL, NULL, 0, NULL, NULL, 3, NULL, NULL, 2, NULL, NULL, 'Active', NULL, NULL, 0, 0),
	(3505, 'EA173AP0086', NULL, 'Pork 3pc Carcass Ham', 113, '1', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3506, 'EA173AP0087', NULL, 'Pork Loin Bone in Skin On - CBCO Alliance', 113, '1', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3507, 'EA173AP0088', NULL, 'Pork Brlly Skin 15Kgs', 113, '1', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3508, 'AI083AB0171', NULL, 'BEEF BONELESS KNUCKLE IWP FRIBOI', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3509, 'BU194AT0001', 'TEMPO 01', 'TJ Hotdog JBO WM 1KG X 12', 124, '1', '1', '-18', '-24', 1, 1, 1, 12, 1, 60, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3510, 'BU194AT0002', 'TEMPO 02', 'TJ Hotdog REG WM 1KG X 12', 124, '1', '1', '-18', '-24', 1, 1, 1, 12, 1, 60, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3511, 'AN201AT0001', NULL, 'Tuna Panga 500g-1kg', 128, '2', '1', '-18', '21', 1, 1, 1, 0, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3512, 'AN201AT0002', NULL, 'Tuna Belly 20kg', 128, '2', '1', '-18', '21', 1, 1, 1, 0, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3513, 'AN201AT0003', NULL, 'Tuna Panga 200-500kg', 128, '2', '1', '-18', '21', 1, 1, 1, 0, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3514, 'BN200AM0001', NULL, 'MARINATED CHICKEN WHOLE OS', 127, '1', '1', '-18', '-24', 1, 1, 1, 25, 1, 20, 9, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3515, 'AN201AT0004', NULL, 'Tuna Panga Premium 500-1000kg', 128, '2', '1', '-18', '21', 1, 1, 1, 0, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3516, 'BN200AM0002', NULL, 'MARINATED CHICKEN WHOLE RS', 127, '1', '1', '-18', '-24', 1, 1, 1, 25, 1, 20, 9, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3517, 'BN200AM0003', NULL, 'MARINATED CHICKEN WHOLE SJ', 127, '1', '1', '-18', '-24', 1, 1, 1, 25, 1, 20, 9, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3518, 'AN201AT0005', NULL, 'Tuna Panga Premium 1000-1500kg', 128, '2', '1', '-18', '21', 1, 1, 1, 0, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3519, 'BN200AM0004', NULL, 'MARINATED CHICKEN WHOLE SS', 127, '1', '1', '-18', '-24', 1, 1, 1, 25, 1, 20, 9, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3520, 'BN200AP0005', NULL, 'PORK BELLY BISO SEARA', 127, '1', '1', '-18', '-24', 1, 1, 1, 15, 1, 40, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3521, 'BN200AP0006', NULL, 'PORK LIEMPO BLUE', 127, '1', '1', '-18', '-24', 1, 1, 1, 20, 1, 20, 9, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3522, 'BN200AP0007', NULL, 'PORK LIEMPO YELLOW', 127, '1', '1', '-18', '-24', 1, 1, 1, 20, 1, 20, 9, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3523, 'JN197AA0001', NULL, 'ASSORTED ', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3524, 'JN197AA0002', NULL, 'Pork Backbone Hylife', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3525, 'JN197AA0003', NULL, 'ASSORTED BEEF', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3526, 'JN197AA0004', NULL, 'ASSORTED CHICKEN', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3527, 'JN197AA0005', NULL, 'B BRISKET', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3528, 'JN197AA0006', NULL, 'B CUBES', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3529, 'JN197AA0007', NULL, 'B RIBS', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3530, 'JN197AA0008', NULL, 'B SHANK', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3531, 'JN197AA0009', NULL, 'B SHANK / N BONES', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3532, 'JN197AA0010', NULL, 'BRISKET', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3533, 'JN197AA0011', NULL, 'CHICKEN BREAST', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3534, 'JN197AA0012', NULL, 'CHICKEN THIGH', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3535, 'JN197AA0013', NULL, 'CHICKEN WHOLE', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3536, 'JN197AA0014', NULL, 'CHICKEN WINGS', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3537, 'JN197AA0015', NULL, 'CHUCK EYE', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3538, 'JN197AA0016', NULL, 'E RIBS', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3539, 'JN197AA0017', NULL, 'G BEEF', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3540, 'JN197AA0018', NULL, 'LIVER', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3541, 'JN197AA0019', NULL, 'MCK TENDER', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3542, 'JN197AA0020', NULL, 'N BONES', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3543, 'JN197AA0021', NULL, 'N MEAT', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3544, 'JN197AA0022', NULL, 'R RIBS', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3545, 'JN197AA0023', NULL, 'RIB EYE', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3546, 'JN197AA0024', NULL, 'RIBS', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3547, 'JN197AA0025', NULL, 'S BONES', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3548, 'JN197AA0026', NULL, 'S RIBS', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3549, 'JN197AA0027', NULL, 'SHANK', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3550, 'JN197AA0028', NULL, 'SHLDR', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3551, 'JN197AA0029', NULL, 'SPECIAL RIB', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3552, 'JN197AA0030', NULL, 'THIGH', 126, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 2, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3554, '6N196AR0001', NULL, 'ROUND SCAD 14-16 ', 125, '2', '1', '-18', '-24', 1, 1, 1, 10, 1, 56, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3555, 'GP014DB0069', '69', 'BERYLS WHITE CHOCOLATE CHIPS 4,400CTS 10KG X 1', 17, '1', '4', '15', '25', 1, 1, 1, 10, 626, 626, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3556, 'AI083AB0172', NULL, 'BEEF BONELESS SHORTPLATE EC MEDINA', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3557, 'CI133AB0045', NULL, 'BEEF SHORT PLATE-HARRIS RANCH', 85, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(3558, 'GP014DB0070', '70', 'BERYLS DARK CHOCOLATE CHIPS BG124-8,800CTS 10KG X 1', 17, '1', '4', '21', '25', 1, 1, 1, 10, 1, 50, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3559, 'KJ206CK0001', 'KL156CK0001', 'KIMCHI 400G X 24 BOTTLES', 129, '2', '3', '5', '0', 1, 1, 1, 1, 1, 1, 3, 1, '', 11, 365, 1, 'Active', 'Slow Moving', 'High Value', 1, 1),
	(3560, 'KJ206AK0002', 'KL156CK0002', 'KIMCHI 1KG X 8 BOTTLES', 129, '1', '1', '5', '0', 1, 1, 1, 1, 1, 1, 3, 1, '', 2, 365, 1, 'Active', 'Slow Moving', 'High Value', 1, 1),
	(3561, 'KJ206CK0003', 'KL156CK0003', 'KIMCHI 10KG', 129, '2', '3', '5', '0', 1, 1, 1, 1, 1, 1, 3, 1, '', 11, 365, 1, 'Active', 'Slow Moving', 'High Value', 1, 1),
	(3562, 'KJ206CK0004', NULL, 'KIMCHI 400G', 129, '2', '3', '5', '0', 1, 1, 1, 1, 1, 1, 3, 1, '', 11, 365, 1, 'Active', 'Slow Moving', 'High Value', 1, 1),
	(3563, 'KJ206CR0005', NULL, 'RADISH 1KG GREEN TAPE', 129, '2', '3', '5', '0', 1, 1, 1, 1, 1, 1, 3, 1, '', 11, 365, 1, 'Active', 'Slow Moving', 'High Value', 1, 1),
	(3564, 'FM211AF0001', NULL, 'FROZEN CHICKEN MDM - POLSKAMP', 132, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 75, 3, 1, '', 2, 1, 1, 'Active', 'Slow Moving', 'High Value', 1, 1),
	(3565, 'RK207AH0001', 'TEMPO01', 'HARVEST GOURMET VEG SCHNITZEL 2X2KG ', 130, '1', '1', '-25', '-18', 1, 1, 1, 1, 2, 20, 3, 1, '', 5, 365, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3566, 'RK207AH0002', 'TEMPO02', 'HARVEST GOURMET VEG SENSATIONAL BRGR 2X2KG', 130, '1', '1', '-25', '-18', 1, 1, 1, 1, 2, 20, 3, 1, '', 5, 365, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3567, 'RK207AH0003', 'TEMPO03', 'HARVEST GOURMET VEG CHRG PIECE 2X2KG', 130, '1', '1', '-25', '-18', 1, 1, 1, 1, 2, 20, 3, 1, '', 5, 365, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3568, 'RK207AH0004', 'TEMPO04', 'HARVEST GOURMET VEG STIR FRY MNC 6X1KG', 130, '1', '1', '-25', '-18', 1, 1, 1, 1, 1, 20, 3, 1, '', 5, 365, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3569, 'RK207AH0005', 'TEMPO05', 'HARVEST GOURMET VEG GRND MNC 6X1KG', 130, '1', '1', '-25', '-18', 1, 1, 1, 1, 1, 20, 3, 1, '', 5, 365, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3570, 'AM208AP0001', NULL, 'PANCAKE FISHCAKE', 131, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 7, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3571, 'AM208AF0002', NULL, 'FRIED CHILI PEPPER FISH PASTE', 131, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3572, 'AM208AC0003', NULL, 'CORN CHEESE AMOOK BAR FISHCAKE', 131, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3573, 'JS005AS0140', 'JS005FS0002', 'SEAFOOD, FROZEN SQUID 10KG/BOX', 9, '1', '1', '1', '1', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3574, 'JS005AF0141', 'JS005FF0003', 'FISH, DORY FILLET 10KG/BOX', 9, '1', '1', '1', '1', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3575, 'GP014DB0071', '71', 'BERYLS 19 PERCENT DARK CHOCOLATE COMPOUND 1KGX10', 17, '1', '4', '21', '25', 1, 1, 1, 1, 600, 600, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3576, 'GP014DB0072', '72', 'BERYLS STRAWBERRY CHOCOLATE COMPOUND 1KG X 10', 17, '1', '4', '15', '20', 1, 1, 1, 1, 10, 10, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3577, 'GP014DB0073', '73', 'BERYLS DARK CHOCOLATE COMPOUND STICK BG128 1.5KG X 8', 17, '1', '4', '15', '20', 1, 1, 1, 1.5, 50, 50, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3578, 'GP014DB0074', '74', 'BERYLS DARK CHOCOLATE 62 PERCENT COCOA BLOCK CH-D62-NV 2KG X 10', 17, '1', '4', '15', '20', 1, 1, 1, 2, 25, 25, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3579, 'GP014DB0075', '75', 'BERYLS DARK CHOCOLATE CHIPS 4,400CTS 10KG X 1', 17, '1', '4', '15', '20', 1, 1, 1, 10, 1200, 1200, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3580, 'GP014DB0076', '76', 'BERYLS CHOCOLATE BLEND 1KG X 12', 17, '1', '4', '15', '20', 1, 1, 1, 1, 50, 50, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3581, 'GP014DB0077', '77', 'BERYLS CHOCOLATE BLEND 5KG X 2', 17, '1', '4', '15', '20', 1, 1, 1, 5, 5, 5, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3582, 'BN200AU0008', NULL, 'UNMARINATED WHOLE CHICKEN', 127, '1', '1', '-18', '-21', 1, 1, 1, 25, 20, 1, 9, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3583, 'VD092AB0206', 'TEMPO 112', 'B. BRISKET - QUALITY', 67, '2', '1', '-18', '-25', 1, 1, 1, 0, 1, 1, 40, 1, '', 2, 1, 1, 'In-Active', 'Fast Moving', 'High Value', 0, 1),
	(3584, 'VD092AB0207', 'TEMPO 113', 'B. CHUCK - QUALITY', 67, '2', '1', '-18', '-22', 1, 1, 1, 0, 1, 1, 40, 1, '', 2, 1, 1, 'In-Active', 'Fast Moving', 'High Value', 1, 1),
	(3585, 'VD092AB0208', 'TEMPO 114', 'B. SHOULDER BNLS - QUALITY', 67, '2', '1', '-18', '-22', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3586, 'VD092AU0209', 'TEMPO 115', 'US Beef Shortplate Thinly Sliced - Nebraska', 67, '1', '1', '-18', '-22', 1, 1, 1, 1, 1, 1, 4, 1, 'VD092AB0060', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3587, 'EA173AP0090', NULL, 'FROZEN PORK EAR\'S DRUMS - SEFICLO', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3588, 'EA173AP0091', NULL, 'FROZEN PORK SHOULDER PICNIC BONELESS SKINLESS - OLYMEL', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3589, 'EA173AP0092', NULL, 'FROZEN PORK BACK SKIN - ALGO', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3590, 'EA173AP0093', NULL, 'PORK LOIN BONELESS - CLEMENS', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3591, 'EA173AP0094', NULL, 'PORK LOIN BONELESS - OLYMEL', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3592, 'EA173AP0095', NULL, 'PORK HOCKS - CONESTOGA', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3593, 'EA173AP0096', NULL, 'PORK BACK SKIN - ALGO', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3594, 'EA173AP0097', NULL, 'FROZEN CHICKEN TAIL BONE IN SKIN ON ', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3595, 'EA173AP0098', NULL, 'CHICKEN MDM - SOPINA', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3596, 'EA173AP0099', NULL, 'FROZEN PORK TONGUE ROOT MEAT - DANISH CROWN', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3597, 'EA173AP0100', NULL, 'FROZEN PORK FEET - DANISH CROWN', 113, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, NULL, 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3598, 'MT023AB0128', 'BF-032-HAR', 'BEEF BONELESS RIB EYE CAB - HARRIS RANCH', 26, '2', '1', '-18', '-21', 1, 1, 1, 0, 38, 38, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3599, 'MT023AB0129', 'BF-013-HAR', 'BEEF SHORTPLATE - HARRIS RANCH', 26, '2', '1', '-18', '-21', 1, 1, 1, 0, 555, 555, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3600, 'AI083AP0173', NULL, 'PORK STERNUM - ARTIGAS', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3601, 'AI083AB0174', NULL, 'BEEF SHORTPLATE BONELESS - FOURSTAR', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3602, 'AI083AF0175', NULL, 'FROZEN PORK BACK BONES', 61, '1', '1', '-18', '-25', 1, 1, 1, 10, 1, 56, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3603, 'IC123AM0001', 'TEMPO65', 'MEDICAL REAGENTS R873676', 79, '1', '3', '1', '5', 1, 1, 1, 0, 1, 1, 3, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3604, 'IC123AM0002', 'TEMPO73', 'MEDICAL REAGENTS S288048', 79, '1', '1', '1', '5', 1, 1, 1, 0, 1, 1, 3, 1, '', 14, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3605, 'IC123AM0003', 'TEMPO76', 'MEDICAL REAGENTS S476553', 79, '1', '1', '1', '5', 1, 1, 1, 0, 1, 1, 3, 1, '', 14, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3606, 'IC123AM0004', 'TEMPO81', 'MEDICAL REAGENTS S21001', 79, '1', '3', '1', '5', 1, 1, 1, 0, 1, 1, 3, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3607, 'IC123AM0005', 'TEMPO83', 'MEDICAL REAGENTS S768510', 79, '1', '1', '1', '5', 1, 1, 1, 0, 1, 1, 3, 1, '', 14, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3608, 'IC123AM0006', 'TEMPO87', 'MEDICAL REAGENTS U021507', 79, '1', '3', '1', '5', 1, 1, 1, 0, 1, 1, 3, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3609, 'IC123AM0007', 'TEMPO01', 'MEDICAL REAGENT PKI STOCK', 79, '1', '3', '1', '5', 1, 1, 1, 0, 1, 1, 3, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3610, 'IC123AM0008', 'TEMPO91', 'MEDICAL REAGENTS U092458', 79, '1', '3', '1', '5', 1, 1, 1, 0, 1, 1, 3, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3611, 'IC123AM0009', 'TEMPO93', 'MEDICAL REAGENTS U163328', 79, '1', '3', '1', '5', 1, 1, 1, 0, 1, 1, 3, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3612, 'IC123AM0010', 'TEMPO94', 'MEDICAL REAGENTS U170894', 79, '1', '3', '1', '5', 1, 1, 1, 0, 1, 1, 3, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3615, 'IC123AM0013', 'TEMPO95', 'MEDICAL REAGENTS U204114', 79, '1', '1', '1', '5', 1, 1, 1, 0, 1, 1, 3, 1, '', 14, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3616, 'IC123AM0014', 'TEMPO96', 'MEDICAL REAGENTS U128679', 79, '1', '3', '1', '5', 1, 1, 1, 0, 1, 1, 3, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3617, 'IC123AM0015', 'TEMPO97', 'MEDICAL REAGENTS U308069', 79, '1', '1', '1', '5', 1, 1, 1, 0, 1, 1, 3, 1, '', 14, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3618, 'IC123AM0016', 'TEMPO98', 'MEDICAL REAGENTS U282266', 79, '1', '3', '1', '5', 1, 1, 1, 0, 1, 1, 3, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3619, 'IC123AM0017', 'TEMPO99', 'MEDICAL REAGENTS U405936', 79, '1', '3', '1', '5', 1, 1, 1, 0, 1, 1, 3, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3620, 'IC123AM0018', 'TEMPO100', 'MEDICAL REAGENTS U504263', 79, '1', '3', '1', '5', 1, 1, 1, 0, 1, 1, 3, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3621, 'IC123AM0019', 'TEMPO101', 'MEDICAL REAGENTS U560405', 79, '1', '3', '1', '5', 1, 1, 1, 0, 1, 1, 3, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3622, 'IC123AM0020', 'TEMPO102', 'MEDICAL REAGENTS U617981', 79, '1', '3', '1', '5', 1, 1, 1, 0, 1, 1, 3, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3623, 'IC123AM0021', 'TEMPO103', 'MEDICAL REAGENTS U594563', 79, '1', '3', '1', '5', 1, 1, 1, 0, 1, 1, 3, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3624, 'IC123CQ0020', 'TEMPO15', 'Q902762', 79, '1', '3', '2', '5', 1, 1, 1, 0, 1, 1, 3, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3625, 'IC123CR0021', 'TEMPO14', 'R058413', 79, '1', '3', '2', '5', 1, 1, 1, 0, 1, 1, 3, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3626, 'IC123AM0022', 'TEMPO71-', 'MEDICAL REAGENTS S186376-', 79, '1', '1', '-18', '-22', 1, 1, 1, 0, 1, 1, 3, 1, '', 14, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3627, 'CI133AF0046', NULL, 'FROZEN BEEF TRIPE', 85, '1', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(3628, 'MT023AP0130', 'SPK-001-THC', 'PORK BACKBONES - THUNDER CREEK', 26, '2', '1', '-18', '-21', 1, 1, 1, 20, 25, 25, 3, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3629, 'MR224AF0001', NULL, 'FISH CAKE', 133, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 43, 3, 1, '', 4, 1, 1, 'Active', 'Slow Moving', 'High Value', 1, 1),
	(3630, 'MR224AR0002', NULL, 'RICE CAKE', 133, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 24, 3, 1, '', 4, 1, 1, 'Active', 'Slow Moving', 'High Value', 1, 1),
	(3631, 'BM225AC0001', NULL, 'CHICKEN WINGS MITY FRESH', 134, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 50, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3632, 'JN227BP0001', NULL, 'PASTILLAS ICE CREAM - 450ml x 6pcs', 135, '1', '2', '-18', '-21', 1, 1, 1, 0, 1, 39, 4, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3633, 'JN227BP0002', NULL, 'PASTILLAS ICE CREAM - 450ml x 2pcs', 135, '1', '2', '-18', '-21', 1, 1, 1, 0, 1, 39, 41, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3634, '1N143CD0006', 'TEMPO01', 'DEEP WELL PLATE', 90, '1', '3', '2', '5', 1, 1, 1, 1, 1, 1, 3, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3635, '1N143CS0007', '1N143CS0002', 'SAMPLE RELEASE REAGENT', 90, '1', '3', '2', '5', 1, 1, 1, 1, 1, 1, 4, 1, '', 13, 196, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3636, '1N143CS0008', '1N143CS0004', 'SAMPLE STORAGE REAGENT', 90, '1', '3', '2', '5', 1, 1, 1, 1, 1, 1, 4, 1, '', 13, -242, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3637, '1N143C00009', '1N143C00003', '0.2 ML PCR TUBE', 90, '1', '3', '-25', '-18', 1, 1, 1, 1, 1, 1, 4, 1, '', 13, 423, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3638, '1N143CS0010', 'TEMPO02', 'SERODETECT DENGUE FEVER VERIFICATION', 90, '1', '3', '2', '5', 1, 1, 1, 1, 1, 1, 3, 1, '', 13, 22, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3639, '1N143AM0011', 'TEMPO03								', 'MOLACCU COVID-19 DETECTION KIT', 90, '1', '1', '-18', '-22', 1, 1, 1, 1, 1, 1, 4, 1, '', 14, 31, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3640, '1N143AN0012', '1N143FN0001', 'NUCLEIC ACID DIAGNOSTIC KIT', 90, '1', '1', '-18', '-22', 1, 1, 1, 1, 1, 1, 4, 1, '', 14, -163, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3641, '1N143AN0013', 'TEMPO04', 'NUCLEIC ACID DIAGNOSTIC KIT x 24 test kits', 90, '1', '1', '-18', '-22', 1, 1, 1, 1, 1, 1, 4, 1, '', 14, 136, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3642, '1N143AN0014', 'TEMPO05', 'NUCLEIC ACID DIAGNOSTIC KIT x 48 test kits', 90, '1', '1', '-18', '-22', 1, 1, 1, 1, 1, 1, 4, 1, '', 14, 151, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3643, '1N143AC0015', 'TEMPO07', 'CRP TEST KIT', 90, '1', '3', '0', '5', 1, 1, 1, 1, 1, 1, 3, 1, '', 13, 187, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3644, '1N143AH0016', 'TEMPO10', 'HAND BAG', 90, '1', '3', '0', '5', 1, 1, 1, 1, 1, 1, 10, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3645, '1N143AH0017', 'TEMPO09', 'HB TEST KIT', 90, '1', '3', '0', '5', 1, 1, 1, 1, 1, 1, 3, 1, '', 13, 338, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3646, '1N143AH0018', 'TEMPO08', 'HBAIC TEST KIT', 90, '1', '3', '0', '5', 1, 1, 1, 1, 1, 1, 3, 1, '', 13, 294, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3647, '1N143AU0019', 'TEMPO06', 'U-ALBUMIN TEST KIT', 90, '1', '3', '0', '5', 1, 1, 1, 1, 1, 1, 3, 1, '', 13, 293, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3648, 'AM182AP0003', NULL, 'PORK JOWLS, S/O - CMC', 121, '1', '1', '-25', '-18', 1, 1, 1, 1, 1, 1, 3, 1, '', 2, 2, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3649, 'AM182AB0004', NULL, 'BEEF HEAD MEAT B/L, CND - EX', 121, '1', '1', '-25', '-18', 1, 1, 1, 1, 1, 1, 3, 1, '', 2, 2, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3650, 'AM182AP0005', NULL, 'PORK BELLY SKINLESS B/L - S', 121, '1', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 2, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3651, 'AM182AP0006', NULL, 'PORK BACK FAT - WV', 121, '1', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 2, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3652, 'AM182AP0007', NULL, 'PORK SPARERIBS - WV', 121, '1', '1', '-25', '-18', 1, 1, 1, 1, 1, 1, 3, 1, '', 2, 2, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3653, 'AM182AB0008', NULL, 'BEEF SHORTPLATE - EX', 121, '1', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 2, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3654, 'RR007CO0001', 'RR007CO0001', 'OXYTOCIN GYNE TOCIN 10ML IU', 11, '1', '3', '8', '2', 1, 1, 1, 0, 1, 1, 8, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3655, 'TM230AA0001', NULL, 'Assorted Cigars', 137, '1', '1', '-18', '-24', 1, 1, 1, 10, 0, 18, 3, 1, '', 14, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3656, 'SM231AW0001', 'SGS01', 'WS 4/6', 138, '2', '1', '-18', '-24', 1, 1, 1, 10, 0, 42, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3657, 'SM231AW0002', 'SGS02', 'WS 3/5', 138, '2', '1', '-18', '-24', 1, 1, 1, 10, 0, 42, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3658, 'VD092AB0210', NULL, 'BEEF HIND SHANK NV DIERICKS', 67, '1', '1', '-18', '-21', 1, 1, 1, 0, 1, 21, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3659, 'SM231AS0003', 'SGS03', 'STI', 138, '2', '1', '-18', '-24', 1, 1, 1, 10, 0, 42, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3660, 'SM231AE0004', 'SGS04', 'E22', 138, '2', '1', '-18', '-24', 1, 1, 1, 10, 0, 42, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3661, 'VD092AB0211', NULL, 'BEEF HEADMEAT ESRO', 67, '1', '1', '-18', '-21', 1, 1, 1, 0, 29, 29, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3662, 'SM231AW0005', 'SGS05', 'WS 5/7', 138, '2', '1', '-18', '-24', 1, 1, 1, 10, 0, 42, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3663, 'SM231AE0006', 'SGS06', 'E8', 138, '2', '1', '-18', '-24', 1, 1, 1, 10, 0, 42, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3664, 'SM231AU0007', 'SGS07', 'UL 3/5', 138, '2', '1', '-18', '-24', 1, 1, 1, 10, 0, 42, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3665, 'SM231AU0008', 'SGS08', 'UL 4/6', 138, '2', '1', '-18', '-24', 1, 1, 1, 10, 0, 42, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3666, 'SM231AE0009', 'SGS09', 'E13', 138, '2', '1', '-18', '-24', 1, 1, 1, 10, 0, 42, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3667, 'SM231AE0010', 'SGS10', 'E11', 138, '2', '1', '-18', '-24', 1, 1, 1, 10, 0, 42, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3668, 'SM231AE0011', 'SGS11', 'E12', 138, '2', '1', '-18', '-24', 1, 1, 1, 10, 0, 42, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3669, 'SM231AU0012', 'SGS12', 'UL 5/7', 138, '2', '1', '-18', '-24', 1, 1, 1, 10, 0, 42, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3670, 'SM231AE0013', 'SGS13', 'E21', 138, '2', '1', '-18', '-24', 1, 1, 1, 10, 0, 42, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3671, 'SM231AS0014', 'SGS14', 'ST 2', 138, '2', '1', '-18', '-24', 1, 1, 1, 10, 0, 42, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3672, 'SM231AS0015', 'SGS15', 'ST 3', 138, '2', '1', '-18', '-24', 1, 1, 1, 10, 0, 42, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3673, 'DM232AB0001', 'DD0010', 'BEEF, STRIPLOIN 2CUT (NORMAL CUT)', 139, '2', '1', '-18', '-24', 1, 1, 1, 10, 1, 40, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3674, 'DM232AB0002', 'DD0012', 'BEEF, BRISKET 2CUT (NORMAL CUT)', 139, '2', '1', '-18', '-24', 1, 1, 1, 10, 1, 40, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3675, 'DM232AB0003', 'DD0005', 'BEEF, BONELESS STRIPLOIN - KOBE BEEF', 139, '2', '1', '-18', '-24', 1, 1, 1, 10, 1, 40, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3676, 'DM232AB0004', 'DD0013', 'BEEF, RIB-EYE 2CUT(CAP-OFF) - MIYAZAKI', 139, '2', '1', '-18', '-24', 1, 1, 1, 10, 1, 40, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3677, 'DM232AB0005', 'DD0014', 'BEEF, STRIPLOIN 2CUT (NORMAL CUT) - MIYAZAKI', 139, '2', '1', '-18', '-24', 1, 1, 1, 10, 1, 40, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3678, 'DM232AB0006', 'DD0015', 'BEEF, TENDERLOIN (NORMAL CUT) - MIYAZAKI', 139, '2', '1', '-18', '-24', 1, 1, 1, 10, 1, 40, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3679, 'DM232AK0007', NULL, 'KOBE STRIPLOIN', 139, '2', '1', '-18', '-21', 1, 1, 1, 13.525, 1, 40, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3680, 'DM232AK0008', NULL, 'KOBE RIBEYE(CAP-OFF)', 139, '2', '1', '-18', '-21', 1, 1, 1, 11.85, 1, 40, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3681, 'DM233AA0001', NULL, 'Assorted Korean Items', 40, '1', '1', '-18', '-21', 1, 1, 1, 0, 1, 51, 3, 1, '', 18, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3682, 'AI083AC0176', NULL, 'CHICKEN WINGS - GOLDEN COAST', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3683, 'IC123AM0023', 'TEMPO105', 'MEDICAL REAGENTS U778111', 79, '1', '3', '1', '5', 1, 1, 1, 0, 10, 1, 3, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3684, 'IC123AM0024', 'TEMPO104', 'MEDICAL REAGENTS U778111', 79, '1', '1', '1', '5', 1, 1, 1, 0, 1, 1, 43, 1, '', 14, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3685, 'IC123CM0025', 'TEMPO106', 'MEDICAL REAGENTS U721437', 79, '1', '3', '1', '5', 1, 1, 1, 0, 1, 1, 3, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3686, 'SA171AO0191', '132683', 'OREO CHEESECAKE 350G', 111, '2', '1', '-18', '-21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3687, 'SA171AM0192', '132684', 'Milka Cake 350G', 111, '2', '1', '-18', '-21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3688, 'SA171AP0193', '137447', 'Palacios ChorizoQuezoDeCabra Pizza 350G', 111, '2', '1', '-18', '-21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3689, 'SA171AP0194', '137448', 'Palacios Barbacoa BBQ Creme Pizza 400G', 111, '2', '1', '-18', '-21', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3690, 'SA171AP0195', '137449', 'Palacios Special Pizza 380G', 111, '2', '1', '1', '1', 1, 1, 1, 1, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3691, 'BM234AP0001', 'BD0001', 'PORK MEAT 2MM FROM OFFALS (JOCI PORK)', 141, '1', '1', '-18', '-21', 1, 1, 1, 0, 1, 80, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3692, 'EE235AW0001', 'EGI0002', 'Whole Pig Size 15', 142, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 11, 44, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3693, 'EE235AW0002', 'EGI0001', 'Whole Pig Size 10', 142, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 13, 44, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3694, 'MM237AD0001', 'M0001', 'DR SICAT BLUE', 143, '1', '1', '-18', '-21', 1, 1, 1, 0, 1, 10, 9, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3695, 'MM237AD0002', 'M0002', 'DR SICAT RED', 143, '1', '1', '-18', '-21', 1, 1, 1, 0, 1, 3, 9, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3709, 'QN238CY0001', 'QF0001', 'YAKULT REG. KUWAIT', 144, '1', '3', '-18', '-21', 1, 1, 1, 0, 1, 1, 34, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3710, 'QN238CY0002', 'QF0002', 'YAKULT BAHRAIN', 144, '1', '3', '-18', '-21', 1, 1, 1, 0, 1, 1, 34, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3711, 'QN238CP0003', 'QF0001', 'PORK LONGANISA HAMONADO 250G', 144, '1', '3', '-18', '-21', 1, 1, 1, 0, 1, 126, 3, 1, '', 6, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3712, 'QN238CC0004', 'QF0002', 'CLASSIC PORK TOCINO 220G', 144, '1', '3', '-18', '-21', 1, 1, 1, 0, 1, 126, 3, 1, '', 6, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3713, 'QN238CB0005', 'QF0003', 'BACON HONEY CURED 200G', 144, '1', '3', '-18', '-21', 1, 1, 1, 0, 1, 76, 3, 1, '', 6, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3714, 'QN238CM0006', 'QF0004', 'MONTEREY SISIG 500G', 144, '1', '3', '-18', '-21', 1, 1, 1, 0, 1, 60, 3, 1, '', 6, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3753, 'AI083AB0177', NULL, 'BEEF TRIPE ECT', 61, '2', '1', '-18', '-21', 1, 1, 1, 22.5, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3754, 'VD092AP0212', 'TEMPO 118', 'P. JOWLS - ROSDERA', 67, '2', '1', '-18', '-22', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3755, 'VD092AC0213', 'TEMPO 119', 'CHICKEN LEG BNLS - SEARA 1X12KG', 67, '1', '1', '-18', '-22', 1, 1, 1, 12, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3756, 'MP013At0025', '1', 'test1', 16, '1', '1', '1', '1', 1, 1, 1, 1, 1, 1, 1, 1, '', 2, 1, 1, 'Hold', 'Fast Moving', 'High Value', 1, 1),
	(3757, 'VD092AB0214', 'TEMPO 120', 'BEEF SHORTPLATE BONELESS-FOUR STAR/SLAB', 67, '2', '1', '-18', '-22', 1, 1, 1, 1, 1, 1, 1, 1, '1000378', 2, 1, 1, 'In-Active', 'Fast Moving', 'High Value', 1, 1),
	(3758, 'VD092AB0215', 'TEMPO 120', 'BEEF SHORTPLATE BONELESS-FOUR STAR/SLAB', 67, '1', '1', '-18', '-22', 1, 1, 1, 0, 1, 1, 40, 1, '1000378', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3759, 'AI083AP0178', NULL, 'PORK LOIN - DAWNMEAT', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 35, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3760, 'HS240AF0001', '1', 'FLOUR CAKE', 146, '2', '1', '-18', '-25', 1, 1, 1, 0, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3761, 'HS240AA0002', '2', 'ANCHOVIE', 146, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 5, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3762, 'HS240AK0003', '3', 'KODARI', 146, '2', '1', '-18', '-25', 1, 1, 1, 0, 1, 1, 20, 1, '', 5, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3763, 'HS240AW0004', '5', 'WASABI', 146, '2', '1', '-18', '-25', 1, 1, 1, 0, 1, 1, 3, 1, '', 5, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3764, 'HS240AS0005', '6', 'SWEET POTATO', 146, '2', '1', '-18', '-25', 1, 1, 1, 0, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3765, 'HS240AC0006', '4', 'CHEESE RICE CAKE', 146, '2', '1', '-18', '-25', 1, 1, 1, 0, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3766, 'HS240AA0007', '7', 'ASSORTED KOREAN ITEMS', 146, '2', '1', '-18', '-25', 1, 1, 1, 0, 1, 1, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3767, 'HS240AD0008', '8', 'DRIED FISH', 146, '2', '1', '-18', '-25', 1, 1, 1, 0, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3768, 'HS240AC0009', '9', 'COLD NOODLES', 146, '2', '1', '-18', '-25', 1, 1, 1, 0, 1, 1, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3769, 'HS240AG0010', '10', 'GLASS NOODLE', 146, '2', '1', '-18', '-25', 1, 1, 1, 0, 1, 1, 3, 1, '', 15, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3770, 'HS240AF0011', '11', 'F.CUT SWIMMING CRAB', 146, '2', '1', '-18', '-25', 1, 1, 1, 0, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3771, 'HS240AF0012', '12', 'F. WHOLE ROUND CRAB', 146, '2', '1', '-18', '-25', 1, 1, 1, 0, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3772, 'HS240AB0013', '13', 'BREAD CRUMBS', 146, '2', '1', '-18', '-25', 1, 1, 1, 0, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3773, 'HS240AW0014', '14', 'WHITE CRAB', 146, '2', '1', '-18', '-25', 1, 1, 1, 0, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3774, 'HS240AB0015', '15', 'BLUE CRAB', 146, '2', '1', '-18', '-25', 1, 1, 1, 0, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3775, 'EA173AF0100', '--', 'FROZEN PORK BACK RIB ENDS BUTTON BONES - OLYMEL', 113, '2', '1', '-18', '-20', 1, 1, 1, 18, 1, 40, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3776, 'EA173AP0101', NULL, 'PORK BACK RIB ENDS BUTTON BONES - OLYMEL', 113, '2', '1', '-18', '-20', 1, 1, 1, 18, 1500, 1500, 3, 1, '', 2, 1, 1, 'Hold', 'Fast Moving', 'High Value', 1, 1),
	(3796, 'AI083AC0179', NULL, 'CHICKEN LEG QUARTER PILGRIMS', 61, '2', '1', '18', '21', 1, 1, 1, 15, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3797, 'JN241CM0001', '1', 'MEDICAL SUPPLY', 147, '1', '3', '2', '5', 1, 1, 1, 0, 1, 1, 43, 1, '', 19, 1, 1, 'Active', 'Slow Moving', 'High Value', 1, 1),
	(3798, 'MK052AC0001', '4', 'CLQ MARJAC', 45, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 8, 1, '', 2, 1, 1, 'Active', 'Slow Moving', 'High Value', 1, 1),
	(3799, 'AI083AP0180', NULL, 'PORK LEG - OLYMEL', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3800, 'AI083AB0181', NULL, 'BEEF FOREQUARTER BONELESS - FRIBOI', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3801, 'VD092AB0216', 'TEMPO 121', 'BEEF BRISKET SLAB - QUALITY', 67, '2', '1', '-18', '-22', 1, 1, 1, 0, 1, 1, 40, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3802, 'GP014CB0078', '9', 'BUNGE NON-DAIRY WHIP TOPPING 1LX12', 17, '1', '3', '0', '5', 1, 1, 1, 1, 1734, 1734, 3, 1, '', 7, 1, 1, 'In-Active', 'Fast Moving', 'High Value', 1, 1),
	(3803, 'IF039AB0001', NULL, 'Beef Fore Shank - Vitelco', 39, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 45, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3804, 'IF039AB0002', NULL, 'Beef HeadMeat - Vitelco', 39, '1', '1', '-18', '-21', 1, 1, 1, 0, 1, 40, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3805, 'IF039AB0003', NULL, 'Beef Headmeat Dawnmeat', 39, '1', '1', '-18', '-21', 1, 1, 1, 10, 1, 18, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3806, 'IF039AB0004', NULL, 'Beef Liver - DawnMeat', 39, '1', '1', '-18', '-21', 1, 1, 1, 10, 1, 59, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3807, 'IF039AB0005', NULL, 'Beef Mixed Headmeat Dawnmeat', 39, '1', '1', '-18', '-21', 1, 1, 1, 10, 1, 64, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3808, 'IF039AB0006', NULL, 'Beef Shank - Vitelco', 39, '1', '1', '-18', '-21', 1, 1, 1, 10, 1, 40, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3809, 'IF039AP0007', NULL, 'Pork Back Fat - Agricola', 39, '1', '1', '-18', '-21', 1, 1, 1, 10, 1, 35, 45, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3810, 'IF039AP0008', NULL, 'Pork Back Fat, Rindless - Agricola', 39, '1', '1', '-18', '-21', 1, 1, 1, 10, 1, 35, 7, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3811, 'GP014DM0079', '78', 'MASTER GIOIA SPECIAL (20KG)', 17, '1', '4', '20', '25', 1, 1, 1, 20, 90, 90, 3, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3812, 'VD092AB0217', 'TEMPO 90', 'PORK CUBES HAM LEG - DEBRA MEAT', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3813, 'VD092AB0218', 'TEMPO 108', 'B. SUKIYAKI CUT - FRIBOI', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3814, 'VD092AB0219', 'TEMPO 106', 'B. CUBES - DANISH CROWN', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3815, 'VD092AB0220', 'TEMPO 97', 'BEEF ANGUS PREMIUM THINLY SLICED - IOWA', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3816, 'VD092AB0221', 'TEMPO 86', 'PORK LOIN TONKATSU - SEABOARD', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3817, 'VD092AB0222', 'TEMPO 117', 'BEEF HEADMEAT - ESRO', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3818, 'VD092AB0223', 'TEMPO 116', 'BEEF HIND SHANK - NV DIERICKX', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3819, 'VD092AB0224', 'TEMPO 111', 'P.LEG B/IN - DEBRA', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3820, 'VD092AB0225', '1000455', 'MEATS SAWDUST.. (PORK)', 67, '2', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3821, 'MM242AF0001', '0', 'FROZEN PORK FRONT LACONES', 148, '2', '1', '-18', '-21', 1, 1, 1, 22, 1, 35, 7, 1, '', 2, 730, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3822, 'AA015AS0125', 'AA015AM0123', 'SAMPLE FOR ALSON (FROZEN) (PACK) ', 18, '1', '1', '-18', '-25', 1, 1, 1, 0.1, 20, 45, 4, 1, 'TEMPO01', 3, 1, 1, 'In-Active', 'Fast Moving', 'High Value', 1, 1),
	(3823, 'AA015AS0126', NULL, 'SAMPLE FOR ALSON (FROZEN) (PACK)', 18, '1', '1', '-18', '-25', 1, 1, 1, 0.1, 1, 45, 4, 1, 'AA015AM0123', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3824, 'CI133AF0047', NULL, 'FROZEN ATLANTIC SALMON HON-5-6KG/PACK (SALMO SALAR)', 85, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3825, 'CI133AF0048', NULL, 'FROZEN ATLANTIC SALMON HON 4-5KG/PC (SALMO SALAR)', 85, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3826, 'AI083AP0182', NULL, 'PORK FOREQUARTER LACONES - WOOL WORTHS', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 35, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3827, 'AI083AP0183', NULL, 'PORK MIDDLE BONE IN - SB PORK', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3828, 'AI083AP0184', NULL, 'PORK HINDQUARTER BONE IN - SB PORK', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3829, 'AI083AP0185', NULL, 'PORK FOREQUARTER BONE IN - SB PORK', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3830, 'VD092AB0226', 'TEMPO 124', 'BEFF CHUCK - QUALITY SLB', 67, '2', '1', '-18', '-22', 1, 1, 1, 0, 1, 1, 40, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3831, 'AI083AP0186', NULL, 'PORK  SIDES IN 3 CUTS - BONE IN HINDQUARTER (TICAN)', 61, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3832, 'AI083AP0187', NULL, 'PORK SIDES IN 3 CUTS - BONE IN MIDDLE CUT (TICAN)', 61, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3833, 'AI083AP0188', NULL, 'PORK SIDES IN 3 CUTS - BONE IN FOREQUARTER (TICAN)', 61, '2', '1', '-18', '-24', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3834, 'AI083A 0189', NULL, ' BONELESS BEEF PS NAVEL END VP', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3835, 'AI083A 0190', NULL, ' BONELESS BEEF B RIB EYE ROLL - 3.5KG+', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3836, 'AI083AB0191', '0', 'BEEF TRIPE PIECES IW - AMP', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3837, 'AI083A 0192', NULL, ' BONELESS BEEF C RIB EYE ROLL - 2-3KGS', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3838, 'AI083AB0193', NULL, 'BONELESS BEEF C RIB EYE ROLL - 3KG+', 61, '1', '1', '-18', '-25', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3839, 'CI133AG0049', NULL, 'GIANT SQUID FILLET', 85, '1', '1', '-18', '-21', 1, 1, 1, 10, 1, 1, 3, 1, '1', 3, 1, 1, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(3840, 'BN200AM0009', NULL, 'MARINATED CHICKEN WHOLE 3S', 127, '1', '1', '-18', '-21', 1, 1, 1, 20, 1, 1, 9, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3841, 'AI083AB0194', NULL, 'BEEF ROBBED FOREQUARTER 80VL - NIGUATEMI', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3842, 'AI083AB0195', NULL, 'BEEF ROBBED FOREQUARTER 90VL - NIGUATEMI', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3843, 'CI133AF0050', NULL, 'Frozen Beef Boneless Short Plate-St. Helen', 85, '1', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(3844, 'CI133AF0051', NULL, 'Frozen Beef Boneless Short Plate-Creekstone', 85, '1', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(3845, 'VD092AB0227', NULL, 'BEEF BRISKET - QUALITY', 67, '2', '1', '-18', '-22', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3846, 'VD092AB0228', NULL, 'BEEF CHUCK - QUALITY', 67, '2', '1', '-18', '-22', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3847, 'CI133AF0052', NULL, 'Frozen Beef Top Blade Muscle- Four Star', 85, '1', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(3848, 'CI133AF0053', NULL, 'Frozen Beef Utility Grained Chuck Roll- Palo Duro', 85, '1', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(3849, 'CI133AF0054', NULL, 'Frozen Beef Rib Finger- Nebraska', 85, '1', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(3850, 'CI133AF0055', NULL, 'Frozen Beef Grained-Fed Utility Hanging Tender- Palo Duro', 85, '1', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(3851, 'CI133AC0056', NULL, 'Choice Boneless Short Ribs- Creekstone', 85, '1', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(3852, 'NN239AD0001', '0', 'DIMSUM BEEF SIOMAI', 145, '1', '1', '-18', '-21', 1, 1, 1, 10, 1, 15, 3, 1, '', 2, 1, 1, 'Active', 'Slow Moving', 'High Value', 1, 1),
	(3853, 'NN239AD0002', '0', 'DIMSUM CHICKEN SIOMAI', 145, '1', '1', '-18', '-21', 1, 1, 1, 10, 1, 15, 3, 1, '', 2, 1, 1, 'Active', 'Slow Moving', 'High Value', 1, 1),
	(3854, 'NN239AF0003', '0', 'FISH BALL', 145, '1', '1', '-18', '-21', 1, 1, 1, 10, 1, 25, 9, 1, '', 2, 1, 1, 'Active', 'Slow Moving', 'High Value', 1, 1),
	(3855, 'NN239AO0004', '0', 'ONE SIOMAI CHICKEN', 145, '1', '1', '-18', '-21', 1, 1, 1, 10, 1, 20, 3, 1, '', 2, 1, 1, 'Active', 'Slow Moving', 'High Value', 1, 1),
	(3856, 'CI133AF0057', '0', 'Frozen Boneless Beef Chuck', 85, '1', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(3857, 'CI133AF0058', '0', 'Frozen Boneless Beef Chuck Tender', 85, '1', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(3858, 'CI133AF0059', '0', 'Frozen Boneless Beef Shoulder', 85, '1', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(3859, 'CI133AF0060', '0', 'Frozen Boneless Beef Brisket', 85, '1', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(3860, 'CI133AP0061', '0', 'Pork Belly BLSO-Seara', 85, '1', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(3861, 'NN239AD0005', '0', 'DIMSUM DFP SIOMAI', 145, '2', '1', '-18', '-22', 1, 1, 1, 40, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3862, 'NN239AO0006', '0', 'ONE SIOMAI BEEF', 145, '1', '1', '-18', '-22', 1, 1, 1, 40, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3863, 'CD119AM0014', '0', 'MYDIBEL CRINKLE CUT 10KG', 77, '1', '1', '-18', '-21', 1, 1, 1, 10, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(3864, 'MT023AC0131', '0', 'CHICKEN LEG MEAT BLSO - SEARA (PACK)', 26, '1', '1', '-25', '-18', 1, 1, 1, 2, 6, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3865, 'TN244CR0001', 'SLS1', 'RED ONION (S/M)', 149, '2', '3', '0', '2', 1, 1, 1, 1, 1, 30, 9, 1, '', 11, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3866, 'TN244CR0002', 'SLS2', 'RED ONION (BIG)', 149, '2', '3', '0', '2', 1, 1, 1, 1, 1, 30, 9, 1, '', 11, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3867, 'JN246CR0001', '0', 'RED ONIONS MEDIUM', 150, '2', '3', '0', '2', 1, 1, 1, 15, 1, 30, 9, 1, '', 11, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3868, 'JN246CR0002', '0', 'RED ONIONS BIG', 150, '2', '3', '0', '2', 1, 1, 1, 15, 1, 30, 9, 1, '', 11, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3869, 'SN247CG0001', '0', 'GARLIC', 151, '2', '3', '0', '2', 1, 1, 1, 15, 1, 30, 9, 1, '', 11, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3870, 'CI133AB0062', '0', 'Beef Trimmings-Minerva', 85, '1', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(3871, 'IC123CM0026', 'TEMPO107', 'MEDICAL REAGENTS U901436', 79, '2', '3', '-2', '5', 1, 1, 1, 0, 1, 1, 3, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3872, 'IC123CM0027', 'TEMPO108', 'MEDICAL REAGENTS U889279', 79, '2', '3', '-2', '5', 1, 1, 1, 0, 1, 1, 3, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3873, 'MF059A0859', 'RMPD00400140003', 'Basting Brush Nylon 57202 - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3874, 'MF059A0860', 'RMPD00200140002', 'Bun Pan Regular 18x13 IN 54920 - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3875, 'MF059A0861', 'RMPK00300010011', 'Cake Board Round w/ Handle & Logo 11 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3876, 'MF059A0862', 'RMPK00300010010', 'Cake Board Round w/ Handle & Logo 9 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3877, 'MF059A0863', 'RMDC00700190004', 'Casserole Nonstick Blk  w/ Grip 5Qts 24cm - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3878, 'MF059A0864', 'RMPD00700050006', 'Chef\'s Knife Blue 1006845 - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3879, 'MF059A0865', 'RMDC00200310002', 'Clear Mug 9 IN  - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3880, 'MF059A0866', 'RMPD00700020006', 'Cutting Board Red 12x18in 1007879/CB1812R1 - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3881, 'MF059A0867', 'RMPD00700020011', 'Cutting Board White 12x18in 1007884 - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3882, 'MF059A0868', 'RMPD00700020009', 'Cutting Board Yellow 12x18IN 1007880 - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3883, 'MF059A0869', 'RMPD00700120003', 'Disher .05 oz 618.16 - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3884, 'MF059A0870', 'RMPD00700120001', 'Disher Thumb Press 2.5 oz (5 tbsp) 1003542 - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3885, 'MF059A0871', 'RMPD00900050005', 'Food Storage Cont. 4Qts  - 1002950 - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3886, 'MF059A0872', 'RMPD00900050006', 'Food Storage Container 2Qts 1003033 - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3887, 'MF059A0873', 'RMDC00500070001', 'Fork Serving S/S 910 in - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3888, 'MF059A0874', 'RMPD00300010014', 'Frying Pan Nonstick 10 IN 54194 - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3889, 'MF059A0875', 'RMDC00600040003', 'Glass Shaker Perfo. Dispenser 6oz 48100 - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3890, 'MF059A0876', 'RMPD00600030007', 'Measuring Cup Plastic 4 PC by set 1005604 - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3891, 'MF059A0877', 'RMPD00600030004', 'Measuring Spoon S/s 4  1002112 / MS4 - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3892, 'MF059A0878', 'RMPD00200040006', 'Pastry Bag 16 IN 3016 Ateco - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3893, 'MF059A0879', 'RMPD00400060010', 'Scraper High heat 14 IN 40235 - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3894, 'MF059A0880', 'RMDC00700080003', 'Serving Tray Round 16in  48506 - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3895, 'MF059A0881', 'RMDC00200300009', 'Shake Glass - 10165473 - - by Piece ', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3896, 'MF059A0882', 'RMPD00500020010', 'Strainer Wire Mesh Di Plastic Handle 3in - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3897, 'MF059A0883', 'RMPD00800100001', 'Thermometer Oven 57635 - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3898, 'MF059A0884', 'RMPD00300010012', 'Frying Pan Nonstick 8 IN 54192 - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3899, 'MF059A0885', 'RMPD00700060003', 'Whip French Hard Rubber Grip 10 IN 55418 - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3900, 'MF059A0886', 'RMDC00700080005', 'Tray stainless 14 X 10', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3901, 'MF059A0887', 'RMPD00400010012', 'Spoon Twisted Bar 14 IN 47120 - - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3902, 'MF059A0888', 'RMPD00900050007', 'Food Storage Container cover 2Qrts/4Qrts  1002955 - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3903, 'MF059A0889', 'RMDC00600040005', 'Glass Candle Holder  - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3904, 'MF059A0890', 'RMDC00700080010', 'Serving Tray Oval 22x27in 48528 - - by PC', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3905, 'MF059A0891', 'RMFD01100130009', 'Oil White Truffle - Gran Cusina - 100 ML / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3906, 'MF059A0892', 'RMPK00400100034', '2021XMASRBDL Box Base 11x11x3 IN - - by Piece', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3907, 'MF059A0893', 'RMGN00300360006', 'Microfiber Cloth Yellow 24.9x30.3 cm 50pcs/box - - by Box', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3908, 'MF059A0894', 'RMFD00700050032', 'Milk Condensed - Doreen - 1KG / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3909, 'MF059A0895', 'RMFD01300080016', 'Rice for Staff - Primavera - 25 KG / Sack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3910, 'MF059A0896', 'RMFD01300080032', 'Rice Adlai - Jordan Farms - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3911, 'MF059A0897', 'RMFD00800250002', 'Truffle Zest - Mazza - 50 G / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3912, 'MF059A0898', 'RMPK01000060018', 'Paper Hot Bowl 520cc - 50pcs/pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3913, 'MF059A0899', 'RMPK01000060019', 'Paper Hot Bowl Lid 520cc - 50pcs/pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3914, 'MF059A0900', 'RMFD01400020006', 'Sauce Rock Sugar Honey - Knorr - 3 KG / Gal', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3915, 'MF059A0901', 'RMFD01100140016', 'Vinegar Balsamic - Capri - 1 L / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3916, 'MF059A0902', 'RMFD01100140017', 'Vinegar Red Wine - Capri - 1 L / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3917, 'MF059A0903', 'RMFD02000090018', 'Vinegar White Wine - Capri - 1 L / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3918, 'MF059A0904', 'RMPK00800100006', 'Bagasse Bowl w/ Lid 350ml - - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3919, 'MF059A0905', 'RMFD00800390001', 'Fruit Chunky Kiwi - Andros - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3920, 'MF059A0906', 'RMFD00800390002', 'Fruit Chunky Lychee Rose - Andros - 1 kg / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3921, 'MF059A0907', 'RMBV00100030006', 'Water Sparkling - Nature\'s Spring - 330 ML / Can', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3922, 'MF059A0908', 'RMFD00800390003', 'Popping Bobba Lychee - Pro Possmei - 1 KG / Pack', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3923, 'MF059A0909', 'RMPD00300110008', 'Food Pan 1/3 x 4 IN Stainless 55244 GA24 - by pc', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3924, 'MF059A0910', 'RMFD01800050006', 'Mustard Prepared - Mc Cormick - 200 G / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3925, 'MF059A0911', 'RMBV00400040005', 'Syrups Kiwi - Monin - 1 L / Bottle', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3926, 'MF059A0912', 'RMPK00800100010', 'Bagasse Bowl w/ Lid 500ML (50pcs/Pack) - - by Set', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3927, 'MF059A0913', 'RMFD01900060006', 'Chocolate Cookies  - Kraft Oreo - 266 G / Box', 51, '1', '4', '18', '25', 1, 1, 1, 1, 1, 0, 10, 1, '', 16, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3928, 'DD249AC0001', '0', 'CHICKEN FATS', 152, '1', '1', '-18', '-24', 1, 1, 1, 10, 1, 30, 9, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3929, 'DD249AC0002', '0', 'CHICKEN THIGH', 152, '1', '1', '-18', '-24', 1, 1, 1, 10, 1, 30, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3930, 'DD249AC0003', '0', 'CHICKEN BREAST', 152, '2', '1', '-18', '-24', 1, 1, 1, 10, 1, 30, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3931, 'PJ251CD0001', '0', 'DE-IONIZED APPLE JUICE CONCENTRATED 275KG', 153, '2', '3', '0', '2', 1, 1, 1, 295, 1, 4, 46, 1, '', 15, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3932, 'CI133AT0063', '0', 'TUNA KAMA NA 5UP-WHITE STRAP', 85, '1', '1', '-18', '-21', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(3933, 'CI133AS0064', '0', 'SWORDFISH CO-BLUE STRAP', 85, '1', '1', '-18', '-21', 1, 1, 1, 10, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(3934, 'CI133AT0065', '0', 'TUNA SAKO-RED STRAP', 85, '1', '1', '-18', '-21', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(3935, 'AI083AP0196', '0', 'PORK TROTTERS WOOL WORTHS', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(3936, 'HM252DD0001', '1', 'DAWN VANILLA FLAVOUR 10KG', 154, '1', '4', '25', '30', 1, 1, 1, 10, 1, 1, 9, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3937, 'HM252DD0002', '2', 'DAWN PREMIUM VANILLA CREME CAKE BASE', 154, '1', '4', '25', '30', 1, 1, 1, 20, 1, 1, 9, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3938, 'HM252DD0003', '3', 'DAWN CREME CAKE CHOCOLATE BASE 20KG', 154, '1', '4', '25', '30', 1, 1, 1, 20, 1, 1, 9, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3939, 'DD249AC0004', '0', 'CHICKEN NECK', 152, '2', '1', '-18', '-24', 1, 1, 1, 10, 1, 25, 9, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3940, 'DD249AC0005', '0', 'CHICKEN  FEET', 152, '2', '1', '-18', '-24', 1, 1, 1, 10, 1, 25, 9, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3941, 'HM252DD0004', '4', 'DAWN FONDANT SUBLINE PLAIN 7KG', 154, '1', '4', '25', '30', 1, 1, 1, 7, 1, 1, 20, 1, '', 10, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3942, 'NN239AB0007', '0', 'Burger Patties', 145, '1', '1', '1', '1', 1, 1, 1, 10, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3943, 'GN253AM0001', '0', 'MANGO PICARD 12X450G', 155, '1', '1', '-18', '-21', 1, 1, 1, 5.4, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3944, 'GN253AC0002', '0', 'CROSSANT', 155, '1', '1', '-18', '-21', 1, 1, 1, 4.2, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3945, 'MT023AB0132', '0', 'BEEF TRIPE - FOUR STAR', 26, '2', '1', '-18', '-21', 1, 1, 1, 27.22, 1, 24, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3946, 'AR254AF0001', '0', 'FROZEN LAPU LAPU', 156, '1', '1', '-18', '-21', 1, 1, 1, 1, 1, 1, 43, 1, '', 3, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3947, 'FM255AB0001', '0', 'BEEF SHORT PLATE-ST. HELEN', 157, '1', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3948, 'FM255AP0002', '0', 'PORK SHOULDER-CONESTOGA', 157, '1', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3949, 'VD092AB0229', '0', 'BEEF BRISKET - QUALITY SLB', 67, '2', '1', '-18', '-25', 1, 1, 1, 0, 1, 1, 40, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3950, 'VM256AS0001', '0', 'SWORD FISH COLLAR VQ-1507 X10KG', 158, '1', '1', '-18', '-21', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3951, 'VM256AF0002', '0', 'FROZEN TUNA BELLY 500 UP', 158, '1', '1', '-18', '-21', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3952, 'MM257AF0001', 'CODE 2', 'FISH, BURI KAMA YELLOW TAIL BIG', 159, '2', '1', '-18', '-24', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3953, 'MM257AF0002', 'CODE 4', 'FISH, BURI SKINLESS YELLOW TAIL-APPROX 10KG/CS', 159, '2', '1', '-18', '-24', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3954, 'MM257AF0003', 'CODE 3', 'FISH, BURI FILLET W/ KAMA YELLOW TAIL', 159, '2', '1', '-18', '-24', 1, 1, 1, 10, 1, 1, 3, 1, '', 3, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3955, 'MM257AF0004', 'CODE 8', 'FISH, BURI SEMI DRESS YELLOW TAIL', 159, '2', '1', '-18', '-24', 1, 1, 1, 10, 1, 1, 43, 1, '', 3, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3956, 'MM257AC0005', 'CODE 10', 'CHICKEN KARAAGE', 159, '2', '1', '-18', '-24', 1, 1, 1, 10, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3957, 'MM257AS0006', 'CODE 9', 'SAIKORO STAKE', 159, '2', '1', '-18', '-24', 1, 1, 1, 10, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3958, 'JN246AR0003', '0', 'RED ONIONS EXTRA BIG', 150, '2', '1', '-18', '-24', 1, 1, 1, 15, 1, 30, 9, 1, '', 11, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3959, 'IC123CM0028', 'TEMPO109', 'MEDICAL REAGENTS U952054', 79, '1', '3', '1', '5', 1, 1, 1, 0, 4, 4, 1, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3960, 'AC0001', '0', 'CK NOODLES', 160, '2', '1', '-18', '-24', 1, 1, 1, 1, 1, 1, 4, 1, '', 9, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3961, 'AI083AF0197', '0', 'FROZEN MUTTON LAMB LEG BONE IN (WAGSTAFF)', 61, '2', '1', '-18', '-24', 1, 1, 1, 1, 1, 30, 3, 1, '', 2, 1, 1, 'Obsolete', 'Fast Moving', 'High Value', 1, 1),
	(3962, 'AI083AF0198', '0', 'FROZEN MUTTON LAMB LEG BONE IN (WAGSTAFF)', 61, '1', '1', '-18', '-24', 1, 1, 1, 0, 1, 30, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3963, 'AI083AF0199', '0', 'FROZEN MUTTON LAMB LEG BONE IN (WAGSTAFF)', 61, '1', '1', '-18', '-24', 1, 1, 1, 0, 1, 30, 3, 1, '', 2, 1, 1, 'Obsolete', 'Fast Moving', 'High Value', 1, 1),
	(3964, 'EA173AP0121', NULL, 'CHICKEN TAIL BISO - COPACOL', 113, '2', '1', '-18', '-20', 1, 1, 1, 18, 1500, 1500, 3, 1, NULL, 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3965, 'EA173AP0122', NULL, 'FROZEN PORK BELLIE\'S BONE IN SKIN ON - FAMADESA', 113, '2', '1', '-18', '-20', 1, 1, 1, 18, 1500, 1500, 3, 1, NULL, 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3966, 'AM0001', '2000165', 'MONDELLE  - IQF FRIES A+ GRADE 7MM SHOESTRING 10X1KG', 161, '1', '1', '-18', '-25', 1, 1, 1, 10, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3967, 'VD092AC0230', 'TEMPO 122', 'CHICKEN LEG BNLS - SEARA PACK', 67, '1', '1', '-18', '-25', 1, 1, 1, 2, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3968, 'VD092AB0231', 'TEMPO 125', 'BEEF BRISKET - QUALITY SLB', 67, '1', '1', '-25', '-18', 1, 1, 1, 0, 1, 1, 40, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3969, 'NN239AC0008', '0', 'Chicken Ham 1/4', 145, '1', '1', '-18', '-21', 1, 1, 1, 10, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3970, 'NN239AC0009', '0', 'Chicken Longanisa 1/4', 145, '1', '1', '-18', '-21', 1, 1, 1, 10, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3971, 'DD249AC0006', '0', 'CHICKEN THIGH SKINLESS', 152, '1', '1', '-18', '-24', 1, 1, 1, 1, 1, 30, 9, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3972, 'DD249AC0007', '0', 'CHICKEN THIGH SKIN-ON', 152, '1', '1', '-18', '-24', 1, 1, 1, 1, 1, 30, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3973, 'DD249AC0008', '0', 'CHICKEN BREAST ', 152, '2', '1', '-18', '-24', 1, 1, 1, 1, 1, 30, 9, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3974, 'VD092AP0232', '0', 'PORK CUBES - SMITHFIELDS', 67, '1', '1', '1', '1', 1, 1, 1, 1, 1, 1, 4, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3975, 'AB0001', '0', 'BONDUELLE SPINACH LEAF PORTIONS 2.5', 162, '1', '1', '-18', '-24', 1, 1, 1, 10, 1, 30, 4, 1, '', 5, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3976, 'AM0002', '0', 'METRO CHEF CAULIFLOWER FLORETS 20/40MM', 162, '1', '1', '-18', '-24', 1, 1, 1, 10, 1, 30, 4, 1, '', 5, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3977, 'AB0003', '0', 'BONDUELLE EXTRA FINE BABY CARROTS 2.5KG', 162, '1', '1', '-18', '-24', 1, 1, 1, 10, 1, 30, 4, 1, '', 5, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3978, 'EA173AP0104', '0', 'PORK CUTTING FAT FROZEN - STAUNTON FOODS', 113, '2', '1', '-18', '-22', 1, 1, 1, 25, 1, 30, 3, 1, '', 2, 1, 0, 'Active', 'Fast Moving', 'High Value', 0, 0),
	(3979, 'MM242AC0002', '0', 'CHICKEN MDM (COPACOL)', 148, '2', '1', '-18', '-24', 1, 1, 1, 15, 1, 70, 7, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3980, 'IC123AM0029', 'TEMPO110', 'MEDICAL REAGENTS U977752', 79, '1', '3', '1', '5', 1, 1, 1, 0, 1, 49, 3, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3981, '1N143CD0020', 'TEMPO11', 'DNA - RNA EXTRACTION KIT', 90, '1', '3', '0', '5', 1, 1, 1, 0, 1, 8, 4, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3982, '1N143CT0021', 'TEMPO12', 'TRIPLEX RT - Q PCR DETECTION KIT', 90, '1', '3', '0', '5', 1, 1, 1, 0, 1, 8, 4, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3983, '1N143CP0022', 'TEMPO13', 'PROTEASE K SEPARATE COMPONENT OF DNA - RNA EXTRACTION KIT', 90, '1', '3', '0', '5', 1, 1, 1, 0, 1, 8, 4, 1, '', 13, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3984, 'DD249AC0009', '0', 'CHICKEN LIVER', 152, '2', '1', '-18', '-24', 1, 1, 1, 10, 1, 1, 9, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3985, 'DD249AC0010', '0', 'CHICKEN SKIN', 152, '1', '1', '-18', '-24', 1, 1, 1, 10, 1, 1, 9, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3986, 'DD249AC0011', '0', 'CHICKEN WINGS', 152, '1', '1', '-18', '-24', 1, 1, 1, 10, 1, 1, 9, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3987, 'CI133AF0066', '0', 'Frozen Pork Loin BLSL-Seaboard', 85, '1', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'Average Value', 1, 1),
	(3988, 'AI083AB0200', '0', 'BEEF BONELESS EYEROUND - FRIBOI', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 11, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3989, 'AI083AB0201', '0', 'BEEF BONELESS KNUCKLE 4KG UP - FRIBOI', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3990, 'AI083AB0202', '0', 'BEEF BONELESS TENDERLOIN CHAIN ON - FRIBOI', 61, '2', '1', '-18', '-21', 1, 1, 1, 0, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(3991, 'HM259CS0001', '0', 'SOUP 750GX30', 163, '1', '3', '-25', '-18', 1, 1, 1, 1, 51, 51, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3992, 'HM259CS0002', '0', 'SOUP 1KGX20', 163, '1', '3', '-25', '-18', 1, 1, 1, 1, 51, 51, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3993, 'HM259CS0003', '0', 'SOUP 250GX60', 163, '1', '3', '-25', '-18', 1, 1, 1, 1, 51, 51, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3994, 'HM259CS0004', '0', 'SESAME OIL', 163, '1', '3', '-25', '-18', 1, 1, 1, 1, 24, 24, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3995, 'HM259CC0005', '0', 'CHICKEN ESSENCE', 163, '1', '3', '-25', '-18', 1, 1, 1, 1, 40, 40, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3996, 'HM259CA0006', '0', 'ASSORTED CHINESE INGREDIENTS', 163, '1', '3', '-25', '-18', 1, 1, 1, 1, 56, 56, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3997, 'HM259CB0007', '0', 'BROWN BARREL', 163, '1', '3', '-25', '-18', 1, 1, 1, 1, 24, 24, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3998, 'HM259CB0008', '0', 'TOMATO PASTE', 163, '1', '3', '-25', '-18', 1, 1, 1, 1, 56, 56, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(3999, 'HM259CC0009', '0', 'CHILI SOUP 750X30G', 163, '1', '3', '-25', '-18', 1, 1, 1, 1, 30, 30, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(4000, 'HM259CC0010', '0', 'CHILI OIL LIQUID', 163, '1', '3', '-25', '-18', 1, 1, 1, 1, 56, 56, 3, 1, '', 7, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(4001, 'TG002AM0001', '0', 'MACKEREL', 7, '1', '1', '-18', '-24', 1, 1, 1, 10, 1, 1, 3, 1, '', 4, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(4002, 'TG002AA0002', '0', 'ASSORTED KOREAN PRODUCTS', 7, '1', '1', '-18', '-24', 1, 1, 1, 10, 1, 1, 43, 1, '', 18, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(4003, 'HN260AF0001', '0', 'FROZEN PORK HAM BONE IN SKIN ON (MAPLE LEAF)', 164, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 50, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(4004, 'NN239AC0010', '0', 'CHICKEN BALONY 230G', 145, '1', '1', '-18', '-22', 1, 1, 1, 1, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(4005, 'NN239AC0011', NULL, 'CHICKEN BALONY 230G', 145, '1', '1', '-18', '-22', 1, 1, 1, 1, 1, 1, 3, 1, '', 2, 1, 1, 'Hold', 'Fast Moving', 'High Value', 1, 1),
	(4006, 'NN239AC0012', NULL, 'CHICKEN BALONY 230G', 145, '1', '1', '-18', '-22', 1, 1, 1, 1, 1, 1, 3, 1, '', 2, 1, 1, 'Hold', 'Fast Moving', 'High Value', 1, 1),
	(4007, 'NN239AC0013', NULL, 'CHICKEN BALONY 230G', 145, '1', '1', '-18', '-22', 1, 1, 1, 1, 1, 1, 3, 1, '', 2, 1, 1, 'Hold', 'Fast Moving', 'High Value', 1, 1),
	(4008, 'NN239AC0014', NULL, 'CHICKEN BALONY 230G', 145, '1', '1', '-18', '-22', 1, 1, 1, 1, 1, 1, 3, 1, '', 2, 1, 1, 'Hold', 'Fast Moving', 'High Value', 1, 1),
	(4009, 'NN239AC0015', NULL, 'CHICKEN BALONY 230G', 145, '1', '1', '-18', '-22', 1, 1, 1, 1, 1, 1, 3, 1, '', 2, 1, 1, 'Hold', 'Fast Moving', 'High Value', 1, 1),
	(4010, 'NN239AC0016', NULL, 'CHICKEN BALONY 230G', 145, '1', '1', '-18', '-22', 1, 1, 1, 1, 1, 1, 3, 1, '', 2, 1, 1, 'Hold', 'Fast Moving', 'High Value', 1, 1),
	(4011, 'NN239AC0017', '0', 'CHICKEN BALONY 1KG', 145, '1', '1', '-18', '-22', 1, 1, 1, 1, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(4012, 'SM231AL0016', '0', 'LU', 138, '2', '1', '-18', '-24', 1, 1, 1, 1, 1, 1, 3, 1, 'SGS 16', 3, 365, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(4013, 'SM231AG0017', '0', 'GS', 138, '2', '1', '-18', '-24', 1, 1, 1, 1, 1, 1, 3, 1, 'SGS 17', 3, 365, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(4014, 'SM231AF0018', '0', 'FISH', 138, '2', '1', '-18', '-24', 1, 1, 1, 1, 1, 1, 3, 1, 'SGS 18', 3, 365, 1, 'Active', 'Fast Moving', 'High Value', 1, 1),
	(4015, 'TG002AA0003', '0', 'ASSORTED KOREAN PRODUCTS', 7, '1', '1', '-18', '-24', 1, 1, 1, 10, 1, 1, 3, 1, '', 18, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(4016, 'AI083AP0203', '0', 'PORK SPARE RIBS - FAMADESA', 61, '2', '1', '-18', '-21', 1, 1, 1, 10, 1, 1, 3, 1, '', 2, 1, 1, 'Active', 'Average Moving', 'High Value', 1, 1),
	(4017, 'VD092AB0233', '0', 'BEEF CHUCK FRIBOI', 67, '1', '1', '-25', '-18', 1, 1, 1, 0, 1, 35, 3, 1, '', 2, 2, 1, 'Active', 'Average Moving', 'High Value', 1, 1);
/*!40000 ALTER TABLE `tbl_items` ENABLE KEYS */;

-- Dumping structure for table wms_cloud.tbl_itemstatus
CREATE TABLE IF NOT EXISTS `tbl_itemstatus` (
  `ItemStatusID` int NOT NULL AUTO_INCREMENT,
  `ItemStatus` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ItemStatusID`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_cloud.tbl_itemstatus: ~24 rows (approximately)
/*!40000 ALTER TABLE `tbl_itemstatus` DISABLE KEYS */;
INSERT INTO `tbl_itemstatus` (`ItemStatusID`, `ItemStatus`) VALUES
	(2, 'GOOD'),
	(3, 'DENTED'),
	(4, 'TORN'),
	(5, 'LOOSE'),
	(6, 'THAWED'),
	(7, 'EXPIRED'),
	(8, 'FOUL ODOR/SPOILED'),
	(9, 'PEST INFESTATION'),
	(10, 'MICROBIAL GROWTH'),
	(11, 'CROSS CONTAMINATION'),
	(12, 'DEFORMED'),
	(13, 'WILTED'),
	(14, 'CUSTOM SAMPLE'),
	(15, 'LEAK'),
	(16, 'DAMAGED'),
	(17, 'LACKING QUANTITY'),
	(18, 'MOLDED'),
	(19, 'CONTAMINATED'),
	(20, 'NO STICKER'),
	(21, 'WET BOX'),
	(22, 'NMIS SAMPLE'),
	(23, 'BFAR SAMPLE'),
	(24, 'OPEN BOX'),
	(25, 'DIFFERENT TAPE');
/*!40000 ALTER TABLE `tbl_itemstatus` ENABLE KEYS */;

-- Dumping structure for table wms_cloud.tbl_itemsubcategories
CREATE TABLE IF NOT EXISTS `tbl_itemsubcategories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_cloud.tbl_itemsubcategories: ~18 rows (approximately)
/*!40000 ALTER TABLE `tbl_itemsubcategories` DISABLE KEYS */;
INSERT INTO `tbl_itemsubcategories` (`id`, `name`) VALUES
	(2, 'Frozen Meat Products'),
	(3, 'Frozen Marine Products'),
	(4, 'Frozen Dairy Products'),
	(5, 'Frozen Vegetable Products'),
	(6, 'Chilled Meat Products'),
	(7, 'Chilled Dairy Products'),
	(8, 'Loose Frozen Meat Products'),
	(9, 'Blast Freezed Products'),
	(10, 'Dry Dairy Products'),
	(11, 'Chilled Vegetables Products'),
	(12, 'Non-Food'),
	(13, 'Chilled Non-Food'),
	(14, 'Freezer Non-Food'),
	(15, 'Food'),
	(16, 'Dining/Kitchen Unit'),
	(17, 'No Idea'),
	(18, 'Freezer Food'),
	(19, 'Chilled Pharma Products');
/*!40000 ALTER TABLE `tbl_itemsubcategories` ENABLE KEYS */;

-- Dumping structure for table wms_cloud.tbl_loadstatus
CREATE TABLE IF NOT EXISTS `tbl_loadstatus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_cloud.tbl_loadstatus: ~3 rows (approximately)
/*!40000 ALTER TABLE `tbl_loadstatus` DISABLE KEYS */;
INSERT INTO `tbl_loadstatus` (`id`, `status`) VALUES
	(1, 'Empty'),
	(2, 'Reserved'),
	(3, 'Loaded');
/*!40000 ALTER TABLE `tbl_loadstatus` ENABLE KEYS */;

-- Dumping structure for table wms_cloud.tbl_locationstatus
CREATE TABLE IF NOT EXISTS `tbl_locationstatus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_cloud.tbl_locationstatus: ~6 rows (approximately)
/*!40000 ALTER TABLE `tbl_locationstatus` DISABLE KEYS */;
INSERT INTO `tbl_locationstatus` (`id`, `status`) VALUES
	(1, 'Available'),
	(2, 'Not Available'),
	(3, 'Guaranteed'),
	(4, 'Aisle'),
	(5, 'Pickface'),
	(6, 'Non-Guaranteed Reserve');
/*!40000 ALTER TABLE `tbl_locationstatus` ENABLE KEYS */;

-- Dumping structure for table wms_cloud.tbl_materials
CREATE TABLE IF NOT EXISTS `tbl_materials` (
  `MaterialID` int unsigned NOT NULL AUTO_INCREMENT,
  `MaterialType` varchar(191) DEFAULT 'Null',
  `MaterialType_Abv` varchar(45) DEFAULT 'Null',
  PRIMARY KEY (`MaterialID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_cloud.tbl_materials: ~3 rows (approximately)
/*!40000 ALTER TABLE `tbl_materials` DISABLE KEYS */;
INSERT INTO `tbl_materials` (`MaterialID`, `MaterialType`, `MaterialType_Abv`) VALUES
	(1, 'Finished Good', 'FG'),
	(2, 'Raw Materials', 'RM'),
	(3, 'Work In Progress', 'WIP');
/*!40000 ALTER TABLE `tbl_materials` ENABLE KEYS */;

-- Dumping structure for table wms_cloud.tbl_pallettype
CREATE TABLE IF NOT EXISTS `tbl_pallettype` (
  `PalletTypeID` int NOT NULL AUTO_INCREMENT,
  `PalletType` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`PalletTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_cloud.tbl_pallettype: ~3 rows (approximately)
/*!40000 ALTER TABLE `tbl_pallettype` DISABLE KEYS */;
INSERT INTO `tbl_pallettype` (`PalletTypeID`, `PalletType`) VALUES
	(1, 'Standard'),
	(2, 'Guaranteed'),
	(3, 'Zero Pallet');
/*!40000 ALTER TABLE `tbl_pallettype` ENABLE KEYS */;

-- Dumping structure for table wms_cloud.tbl_roomstatus
CREATE TABLE IF NOT EXISTS `tbl_roomstatus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_cloud.tbl_roomstatus: ~0 rows (approximately)
/*!40000 ALTER TABLE `tbl_roomstatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_roomstatus` ENABLE KEYS */;

-- Dumping structure for table wms_cloud.tbl_roomtypes
CREATE TABLE IF NOT EXISTS `tbl_roomtypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(45) DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_cloud.tbl_roomtypes: ~4 rows (approximately)
/*!40000 ALTER TABLE `tbl_roomtypes` DISABLE KEYS */;
INSERT INTO `tbl_roomtypes` (`id`, `type`, `capacity`) VALUES
	(1, 'Controlled Room', 7156),
	(2, 'Anteroom', NULL),
	(3, 'Chiller', 950),
	(4, 'Freezer', 6753);
/*!40000 ALTER TABLE `tbl_roomtypes` ENABLE KEYS */;

-- Dumping structure for table wms_cloud.tbl_storage
CREATE TABLE IF NOT EXISTS `tbl_storage` (
  `id` int NOT NULL AUTO_INCREMENT,
  `CustomerID` int DEFAULT NULL,
  `Storage` varchar(45) DEFAULT NULL,
  `Slots` varchar(45) DEFAULT NULL,
  `EnrollmentFrom` datetime DEFAULT NULL,
  `EnrollmentTo` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_cloud.tbl_storage: ~6 rows (approximately)
/*!40000 ALTER TABLE `tbl_storage` DISABLE KEYS */;
INSERT INTO `tbl_storage` (`id`, `CustomerID`, `Storage`, `Slots`, `EnrollmentFrom`, `EnrollmentTo`) VALUES
	(4, 84, 'Chiller', '5', '2021-09-01 00:00:00', '2021-09-30 00:00:00'),
	(5, 109, 'Freezer', '2500', '2021-08-24 00:00:00', '2022-08-24 00:00:00'),
	(6, 110, 'Dry', '900', '2021-08-16 00:00:00', '2021-10-15 00:00:00'),
	(7, 110, 'Dry', '900', '2021-10-16 00:00:00', '2022-10-15 00:00:00'),
	(9, 7, 'Freezer', '100', '2021-11-01 00:00:00', '2021-12-01 00:00:00'),
	(10, 84, 'Chiller', '10', '2021-11-16 00:00:00', '2021-11-25 00:00:00');
/*!40000 ALTER TABLE `tbl_storage` ENABLE KEYS */;

-- Dumping structure for table wms_cloud.tbl_store
CREATE TABLE IF NOT EXISTS `tbl_store` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_common` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `contactno` varchar(50) DEFAULT NULL,
  `store_address` varchar(255) DEFAULT NULL,
  `Registeredby` int DEFAULT NULL,
  `store_status` varchar(50) DEFAULT NULL,
  `date_created` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table wms_cloud.tbl_store: ~3 rows (approximately)
/*!40000 ALTER TABLE `tbl_store` DISABLE KEYS */;
INSERT INTO `tbl_store` (`id`, `customer_common`, `name`, `email`, `username`, `password`, `contactno`, `store_address`, `Registeredby`, `store_status`, `date_created`) VALUES
	(1, 'AAC0015', 'Test1', 'apborbon@saranganibay.com.ph', 'test', '123123', NULL, NULL, NULL, NULL, '2021-11-26 05:24:45'),
	(2, '$commoncode', '$store_fullname', '$store_email', '$store_username', '$hashedPassword', '$store_contactno', '$store_storeaddress', 0, '0', '2021-11-26 05:24:45'),
	(3, 'AAC0015', 'test2', 'test2', 'test2', '$2y$10$jTXJyVH4AR5poLiKvGtiWOQF0C7.l8r27Vqj1Nv7a/51ibn5MksRq', 'test2', 'test2', 3, '0', '2021-11-26 06:05:35');
/*!40000 ALTER TABLE `tbl_store` ENABLE KEYS */;

-- Dumping structure for table wms_cloud.tbl_temp
CREATE TABLE IF NOT EXISTS `tbl_temp` (
  `id` int NOT NULL,
  `TempPID` int DEFAULT NULL,
  `TempIBN` int DEFAULT NULL,
  `TempOBD` int DEFAULT NULL,
  `TempCusCode` int DEFAULT NULL,
  `TempRoomCode` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_cloud.tbl_temp: ~0 rows (approximately)
/*!40000 ALTER TABLE `tbl_temp` DISABLE KEYS */;
INSERT INTO `tbl_temp` (`id`, `TempPID`, `TempIBN`, `TempOBD`, `TempCusCode`, `TempRoomCode`) VALUES
	(1, 2, 0, 0, 3, 13);
/*!40000 ALTER TABLE `tbl_temp` ENABLE KEYS */;

-- Dumping structure for table wms_cloud.tbl_trucktypes
CREATE TABLE IF NOT EXISTS `tbl_trucktypes` (
  `TruckTypeID` int NOT NULL AUTO_INCREMENT,
  `TruckType` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`TruckTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_cloud.tbl_trucktypes: ~9 rows (approximately)
/*!40000 ALTER TABLE `tbl_trucktypes` DISABLE KEYS */;
INSERT INTO `tbl_trucktypes` (`TruckTypeID`, `TruckType`) VALUES
	(1, 'Transfer'),
	(3, '4W'),
	(4, '40 ft Reefer Truck'),
	(5, '20 ft Reefer Truck'),
	(6, '6 Wheeler'),
	(7, '10 Wheeler'),
	(8, 'Motorcycle'),
	(9, 'Hand Carry'),
	(10, 'L300');
/*!40000 ALTER TABLE `tbl_trucktypes` ENABLE KEYS */;

-- Dumping structure for table wms_cloud.tbl_warehouses
CREATE TABLE IF NOT EXISTS `tbl_warehouses` (
  `WarehouseID` int NOT NULL,
  `Warehouse` varchar(255) NOT NULL,
  `WarehouseCode` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_cloud.tbl_warehouses: ~8 rows (approximately)
/*!40000 ALTER TABLE `tbl_warehouses` DISABLE KEYS */;
INSERT INTO `tbl_warehouses` (`WarehouseID`, `Warehouse`, `WarehouseCode`) VALUES
	(1, 'Glacier - FTI', '01'),
	(2, 'Glacier - North', '02'),
	(3, 'Glacier - Panay', '03'),
	(4, 'Glacier - Liberty', '04'),
	(5, 'Glacier - South', '05'),
	(6, 'Glacier - Samar', '06'),
	(7, 'Glacier - Pulilan', '07'),
	(8, 'Glacier - Batangas', '08');
/*!40000 ALTER TABLE `tbl_warehouses` ENABLE KEYS */;

-- Dumping structure for table wms_cloud.tbl_weightuom
CREATE TABLE IF NOT EXISTS `tbl_weightuom` (
  `UOMID` int unsigned NOT NULL AUTO_INCREMENT,
  `UOM` varchar(191) NOT NULL,
  `UOM_Abv` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`UOMID`),
  KEY `tbl_weightuom_idx_uomid` (`UOMID`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table wms_cloud.tbl_weightuom: ~45 rows (approximately)
/*!40000 ALTER TABLE `tbl_weightuom` DISABLE KEYS */;
INSERT INTO `tbl_weightuom` (`UOMID`, `UOM`, `UOM_Abv`) VALUES
	(1, 'Test UOM', 'TUOM'),
	(2, 'Pieces', 'PCS'),
	(3, 'BOX', 'BOX'),
	(4, 'PACK', 'PCK'),
	(5, 'BAG', 'BAG'),
	(6, 'BOTTLE', 'BTL'),
	(7, 'BLOCK', 'BLK'),
	(8, 'CASE', 'CS'),
	(9, 'SACK', 'SK'),
	(10, 'PIECE', 'PCS'),
	(11, 'PAD', 'PAD'),
	(12, 'Kilogram', 'KG'),
	(13, 'JUG', 'JUG'),
	(14, 'CAN', 'CAN'),
	(15, 'BAR', 'BAR'),
	(16, 'Pair', 'PR'),
	(17, 'TIN', 'TIN'),
	(18, 'TRAY', 'TRAY'),
	(19, 'VIAL', 'V'),
	(20, 'PAIL', 'PAIL'),
	(21, 'Pouch', 'NIH'),
	(22, 'Tub', 'TUB'),
	(23, 'Roll', 'ROLL'),
	(24, 'Tumbler', 'TBLR'),
	(25, 'Bundle', 'BDL'),
	(26, 'Ream', 'RM'),
	(27, 'Gallon', 'GAL'),
	(28, 'Container', 'CTR'),
	(29, 'Bucket', 'BKT'),
	(30, 'Unit', 'U'),
	(31, 'Sheet', 'SHT'),
	(32, 'Jar', 'JAR'),
	(33, 'Set', 'SET'),
	(34, 'Pallet', 'PLT'),
	(35, 'PAD', 'PAD'),
	(36, 'CANISTER', 'CSTR'),
	(37, 'CARTON', 'CTN'),
	(38, 'EACH', 'EA'),
	(39, 'CUP', 'C'),
	(40, 'Slab', 'SLB'),
	(41, 'Pints', 'PT'),
	(43, 'STYRO', 'STYRO'),
	(44, 'HEADS', 'HEADS'),
	(45, 'POLY', 'PLY'),
	(46, 'DRUM', 'DRUM');
/*!40000 ALTER TABLE `tbl_weightuom` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
