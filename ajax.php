<?php
	session_start();
    ini_set('max_execution_time', '300');
    set_time_limit(300);
    date_default_timezone_set('Asia/Manila');
	$function = $_POST['function'];
    // $CustomerID = $_SESSION['CustomerId'];


// DashboardModule

    if($function == 'pieChartLoadData')
    {
        $dataBarGraph = $_POST['dataBarGraph'];
        $to = $_POST['to'];
        $from = $_POST['from'];
        $filter = $_POST['filter'];
        $searchkey = $_POST['searchkey'];
        $label = $_POST['label'];
        $reend = $_POST['reend'];
        $restart = $_POST['restart'];
        $CustomerID = $_POST['CustomerID'];

        pieChartLoadData($dataBarGraph, $CustomerID, $to, $from, $filter, $searchkey, $label, $restart, $reend);
    }

    else if($function == 'barChartLoadData')
    {   
        $label = $_POST['label'];
        $barGraph = $_POST['barGraph'];
        $reend = $_POST['reend'];
        $restart = $_POST['restart'];
        barChartLoadData($label, $barGraph, $restart, $reend, $CustomerID);
    }

    else if($function == 'loadSKUNo')
    {
        loadSKUNo($CustomerID);
    }

    else if($function == 'loadSKUDesc')
    {
        loadSKUDesc($CustomerID);
    }

    else if($function == 'loadSKUandDesc')
    {
        $filter = $_POST['filter'];
        $CustomerID = $_POST['CustomerID'];
        loadSKUandDesc($filter, $CustomerID);
    }

// DashboardModule


//login

    else if($function == 'login')
    {
        $username = $_POST['username'];
        $userpword = $_POST['password'];
        login($username, $userpword);
    }

//login
    

// Reports
    else if($function == 'soh_report')
    {
        $WarehouseID = $_POST['WarehouseID'];
        $CustomerID = $_POST['CustomerID'];
        soh_report($CustomerID, $WarehouseID);
    }

    else if($function == 'filteredSOH')
    {   
        $filtered = $_POST['filtered'];
        $WarehouseID = $_POST['WarehouseID'];
        $CustomerID = $_POST['CustomerID'];
        filteredSOH($filtered, $CustomerID, $WarehouseID);
    }

    else if($function == 'searchSOH')
    {   
        $filtered = $_POST['filtered'];
        $key = $_POST['key'];
        $WarehouseID = $_POST['WarehouseID'];
        $CustomerID = $_POST['CustomerID'];
        searchSOH($filtered, $key, $CustomerID, $WarehouseID);
    }

    else if($function == 'Report_GenerateITR')
    {
        $WarehouseID = $_POST['WarehouseID'];
        $datefrom = $_POST['datefrom'];
        $dateto = $_POST['dateto'];
        $filtered = $_POST['filter'];
        $key = $_POST['searchkey'];
        $CustomerID = $_POST['CustomerID'];
        Report_GenerateITR($WarehouseID, $datefrom, $dateto, $CustomerID, $filtered, $key);

    }

    else if($function == 'Report_GenerateITRDetails')
    {

        $IBN = $_POST['IBN'];
        $CustomerID = $_POST['CustomerID'];
        Report_GenerateITRDetails($IBN, $CustomerID);

    }

    else if($function == 'Report_GenerateDOR')
    {
        $WarehouseID = $_POST['WarehouseID'];
        $datefrom = $_POST['datefrom'];
        $dateto = $_POST['dateto'];
        $filtered = $_POST['filter'];
        $key = $_POST['search'];
        Report_GenerateDOR($WarehouseID, $datefrom, $dateto, $CustomerID, $filtered, $key);

    }

    else if($function == 'Report_GenerateDOR2')
    {
        $WarehouseID = $_POST['WarehouseID'];
        $datefrom = $_POST['datefrom'];
        $dateto = $_POST['dateto'];
        $filtered = $_POST['filter'];
        $key = $_POST['search'];
        $CustomerID = $_POST['CustomerID'];
        Report_GenerateDOR2($WarehouseID, $datefrom, $dateto, $CustomerID, $filtered, $key);

    }

    else if($function == 'filteredDOR')
    {
        $WarehouseID = $_POST['WarehouseID'];
        $datefrom = $_POST['datefrom'];
        $dateto = $_POST['dateto'];
        $filtered = $_POST['filtered'];

    }

    else if($function == 'searchDOR')
    {
        $WarehouseID = $_POST['WarehouseID'];
        $datefrom = $_POST['datefrom'];
        $dateto = $_POST['dateto'];
        $filtered = $_POST['filtered'];
        $key = $_POST['key'];

    }

    else if($function == 'ageing_report')
    {   
        $WarehouseID = $_POST['WarehouseID'];
        $CustomerID = $_POST['CustomerID'];
        ageing_report($CustomerID, $WarehouseID);
    }

    else if($function == 'filteredAgeing')
    {   
        $filtered = $_POST['filtered'];
        $WarehouseID = $_POST['WarehouseID'];
        $CustomerID = $_POST['CustomerID'];
        filteredAgeing($filtered, $CustomerID, $WarehouseID);
    }

    else if($function == 'searchAgeing')
    {   
        $filtered = $_POST['filtered'];
        $key = $_POST['key'];
        $WarehouseID = $_POST['WarehouseID'];
        $CustomerID = $_POST['CustomerID'];
        searchAgeing($filtered, $key, $CustomerID, $WarehouseID);
    }

    else if ($function == 'Report_GenerateDTR')
    {
        $datefrom = $_POST['datefrom'];
        $dateto = $_POST['dateto'];
        $CustomerID = $_POST['CustomerID'];
        Report_GenerateDTR($datefrom, $dateto, $CustomerID);
    }

    else if ($function == 'loadItem')
    {
    $customer = $_POST['customer'];
    loadItem($customer);
    }

    else if ($function == 'Report_GenerateGM')
    {
        $ItemID = $_POST['ItemID'];
        $SubFilter = $_POST['SubFilter'];
        $Co_SubFilter = $_POST['Co_SubFilter'];
        $datefrom = $_POST['datefrom'];
        $dateto = $_POST['dateto'];
        $CustomerID = $_POST['CustomerID'];
        Report_GenerateGM($CustomerID, $ItemID, $SubFilter, $Co_SubFilter, $datefrom, $dateto);
    }

    else if($function == 'loadSubfilter')
    {
        loadSubfilter();
    }

    else if($function == 'loadSubFilter_GM')
    {
        $subfilter = $_POST['subfilter'];
        $loadItem = $_POST['loadItem'];
        loadSubFilter_GM($subfilter, $loadItem);
    }

    else if($function == 'loadWarehouse')
    {
        loadWarehouse();
    }

    else if($function == 'GetWarehouseExport')
    {
        $WarehouseID = $_POST['WarehouseID'];
        GetWarehouseExport($WarehouseID);
    }

    else if($function == 'GetCustomerExport')
    {
        $CustomerID1 = $_POST['CustomerID1'];
        GetCustomerExport($CustomerID1);
    }

    else if($function == 'GetSubFilterExport')
    {
        $SubFilter1 = $_POST['SubFilter1'];
        GetSubFilterExport($SubFilter1);
    }
// Reports

// ReceivingModule

    else if($function == 'CPGenerateIBN')
    {
        $warehouse = $_POST['warehouse'];
        CPGenerateIBN($warehouse);
    }

    else if ($function == 'Warehouses')
    {
        Warehouses();
    }

    else if($function == 'TruckType')
    {
        TruckType();
    }

    else if($function == 'ReturnToPending')
    {
        $cpi_no = $_POST['cpi_no'];
        $selected_warehouse = $_POST['selected_warehouse'];
        $supplier_name = $_POST['supplier_name'];
        $container_no = $_POST['container_no'];
        $vehicle_plateno = $_POST['vehicle_plateno'];
        $seal_no = $_POST['seal_no'];
        $client_rep = $_POST['client_rep'];
        $date_arrival = $_POST['date_arrival'];
        $remarks = $_POST['remarks'];
        $selected_truck = $_POST['selected_truck'];
        ReturnToPending($cpi_no, $selected_warehouse, $supplier_name ,$container_no, $vehicle_plateno, $seal_no, $client_rep, $date_arrival, $remarks, $selected_truck);
    }

    else if($function == 'GetPendingList')
    {
        GetPendingList();
    }

    else if($function == 'GetForApprovallist')
    {
        GetForApprovallist();
    }

    else if($function == 'GetOnprocesslist')
    {
        GetOnprocesslist();
    }

    else if($function == 'GetPendingCount')
    {
        GetPendingCount();
    }

    else if($function == 'GetForApprovalCount')
    {
        GetForApprovalCount();
    }

    else if($function == 'GetOnProcessCount')
    {
        GetOnProcessCount();
    }

    else if($function == 'GetASNDetails')
    {
        $CPI = $_POST['CPI'];
        GetASNDetails($CPI);
    }

    else if($function == 'AvailableItems')
    {
        AvailableItems();
    }

    else if($function == 'GetUOM')
    {
        $ItemID = $_POST['ItemID'];
        GetUOM($ItemID);
    }

    else if($function == 'GetWeight')
    {
        $ItemID = $_POST['selected_item'];
        GetWeight($ItemID);
    }

    else if($function == 'AddReceivingItems')
    {
        $r_item = $_POST['r_item'];
        $r_itemqty = $_POST['r_itemqty'];
        $r_itemexpirydate = $_POST['r_itemexpirydate'];
        $r_itemuom = $_POST['r_itemuom'];
        $r_weight = $_POST['r_weight'];
        $r_CPI = $_POST['r_CPI'];
        AddReceivingItems($r_item, $r_itemqty, $r_itemexpirydate, $r_itemuom, $r_weight, $r_CPI);
    }

    else if($function == 'AddedItemsSummary')
    {
        $r_CPI = $_POST['r_CPI'];
        AddedItemsSummary($r_CPI);
    }

    else if($function == 'GetItemDetailsCanEdit')
    {
        $id = $_POST['id'];
        GetItemDetailsCanEdit($id);
    }

    else if($function == 'EditItemDetails')
    {
        $ris_itemid = $_POST['id'];
        $qty = $_POST['editQty'];
        $wgt = $_POST['editWgt'];
        $expiry = $_POST['expiry'];
        EditItemDetails($ris_itemid, $qty, $wgt, $expiry);
    }

    else if($function == 'removeItem')
    {
        $itemid = $_POST['itemid'];
        removeItem($itemid);
    }

    else if($function == 'forApprove')
    {
        $warehouse = $_POST['warehouse'];
        $trucktype = $_POST['trucktype'];
        $dateofarrival = $_POST['dateofarrival'];
        $containerno = $_POST['containerno'];
        $plateno = $_POST['plateno'];
        $suppliername = $_POST['suppliername'];
        $sealnumber = $_POST['sealnumber'];
        $client_rep = $_POST['client_rep'];
        $remarks = $_POST['remarks'];
        $r_CPI = $_POST['r_CPI'];
        forApprove($r_CPI, $warehouse, $trucktype, $dateofarrival, $containerno, $plateno, $suppliername, $sealnumber, $client_rep, $remarks);
    }

    else if($function == 'forApproveBtn')
    {
        forApproveBtn();
    }

    else if($function == 'SubmitReceivingTransaction')
    {
        $receiving_selectedWH = $_POST['receiving_selectedWH'];
        $receiving_selectedTruck = $_POST['receiving_selectedTruck'];
        $receiving_datearrive = $_POST['receiving_datearrive'];
        $receiving_containerno = $_POST['receiving_containerno'];
        $receiving_vehicleplateno = $_POST['receiving_vehicleplateno'];
        $receiving_suppliername = $_POST['receiving_suppliername'];
        $receiving_sealno = $_POST['receiving_sealno'];
        $receiving_clientrepresentative = $_POST['receiving_clientrepresentative'];
        $receiving_remarks = $_POST['receiving_remarks'];
        $r_CPI = $_POST['r_CPI'];
        SubmitReceivingTransaction($r_CPI, $receiving_selectedWH, $receiving_selectedTruck, $receiving_datearrive, $receiving_containerno, $receiving_vehicleplateno, $receiving_suppliername, $receiving_sealno, $receiving_clientrepresentative, $receiving_remarks);
    } 

    else if($function == 'CheckIfHasReceivingItems')
    {
        $CPI = $_POST['r_CPI'];
        CheckIfHasReceivingItems($CPI);
    }

    else if($function == 'item_checker')
    {
        $CPI = $_POST['r_CPI'];
        item_checker($CPI);
    }

    else if($function == 'ImportedReceivingItems')
    {
        $receivingitems = $_POST['receivingitems'];
        $cpi = $_POST['cpi'];
        ImportedReceivingItems($receivingitems, $cpi);
    }

// ReceivingModule


//OrderModule
    else if ($function == 'Order_GetAllItems')
    {
        Order_GetAllItems();
    }

    else if ($function == 'OrderFWorCW')
    {
        $selected_item = $_POST['selected_item'];
        OrderFWorCW($selected_item);
    }

    else if($function == 'AddOrderItem')
    {
        $Ordered_Item = $_POST['Ordered_Item'];
        $Ordered_Qty = $_POST['Ordered_Qty'];
        $Ordered_Wtg = $_POST['Ordered_Wtg'];
        $SOnumber = $_POST['SOnumber'];
        $CPO = $_POST['GeneratedCPO'];
        AddOrderItem($Ordered_Item, $Ordered_Qty, $Ordered_Wtg, $SOnumber, $CPO);
    }

    else if($function == 'GetAllOrderedItems')
    {
        $CPO = $_POST['generatedCPO'];
        GetAllOrderedItems($CPO);
    }

    else if($function == 'OrderingGetItem')
    {
        $itemid = $_POST['itemid'];
        OrderingGetItem($itemid);
    }

    else if($function == 'SetNewItemQty')
    {
        $id = $_POST['id'];
        $newGivenQty = $_POST['newGivenQty'];
        $newGivenWgt = $_POST['newGivenWgt'];
        SetNewItemQty($id, $newGivenQty, $newGivenWgt);
    }

    else if($function == 'SubmitForApproval')
    {
        $warehouse = $_POST['warehouse'];
        $SOnumber = $_POST['SOnumber'];
        $storeid = $_POST['storeid'];
        $order_remarks = $_POST['order_remarks'];
        $order_pickupdate = $_POST['order_pickupdate'];
        $itemid = $_POST['Ordered_Item'];
        $o_qty = $_POST['Ordered_Qty'];
        $o_wgt = $_POST['Ordered_Wtg'];
        $generatedCPO = $_POST['generatedCPO'];
        SubmitForApproval($warehouse, $SOnumber, $storeid, $order_remarks, $itemid, $o_qty, $o_wgt, $generatedCPO, $order_pickupdate);
    }

    else if($function == 'OrderRemoveItem')
    {
        $itemid = $_POST['itemid'];
        OrderRemoveItem($itemid);
    }

    else if($function == 'GetORDList')
    {
        GetORDList();
    }

    else if($function == 'GetSumOfListOrder')
    {
        $itemid = $_POST['item_id'];
        GetSumOfListOrder($itemid);
    }

    else if($function == 'GetOrderDetail')
    {
        $itemid = $_POST['item_id'];
        GetOrderDetail($itemid);
    }

    else if($function == 'GetListofOrder')
    {
        $itemid = $_POST['item_id'];
        GetListofOrder($itemid);
    }

    else if($function == 'RemoveCPOTrans')
    {
        $item_id = $_POST['item_id'];
        RemoveCPOTrans($item_id);
    }

    else if($function == 'ApprovedORD')
    {
        $itemid = $_POST['itemid'];
        ApprovedORD($itemid);
    }

    else if($function == 'ORDdetailsApprovebtn')
    {
        $item_id = $_POST['item_id'];
        ORDdetailsApprovebtn($item_id);
    }

    else if($function == 'CountOpenCPO')
    {
        CountOpenCPO();
    }

    else if($function == 'openOpenCPOModal')
    {
        openOpenCPOModal();
    }

    else if($function == 'PutOrderToOpen')
    {
        $itemid = $_POST['itemid'];
        PutOrderToOpen($itemid);
    }

    else if($function == 'GetCPODetails')
    {
        $CPO = $_POST['CPO'];
        GetCPODetails($CPO);
    }

    else if($function == 'ImportedOrderItems')
    {
        $orderitems = $_POST['orderitems'];
        ImportedOrderItems($orderitems);
    }

//OrderModule


//SettingsModule
    else if($function == 'GetMyInfo')
    {
        GetMyInfo();
    }

    else if($function == 'UpdateMyinfo')
    {
        $fullname = $_POST['fullname'];
        $username = $_POST['username'];
        $email = $_POST['email'];
        $contactno = $_POST['contactno'];
        $currpass = $_POST['currpass'];
        $newpass1 = $_POST['newpass1'];
        UpdateMyinfo($fullname, $username, $email, $contactno, $currpass, $newpass1);
    }

    else if($function == 'AddNewUsers')
    {
        $new_fullname = $_POST['new_fullname'];
        $new_username = $_POST['new_username'];
        $new_email = $_POST['new_email'];
        $new_contactno = $_POST['new_contactno'];
        $new_userrole = $_POST['new_userrole'];
        $new_password1 = $_POST['new_password1'];

        AddNewUsers($new_fullname, $new_username, $new_email, $new_contactno, $new_userrole, $new_password1);
    }

    else if($function == 'GetAllUsers')
    {
        GetAllUsers();
    }

    else if($function == 'DeleteUser')
    {
        $userid = $_POST['userid'];
        DeleteUser($userid);
    }

    else if($function == 'AddNewStores')
    {
        $store_fullname = $_POST['store_fullname'];
        $store_username = $_POST['store_username'];
        $store_email = $_POST['store_email'];
        $store_password1 = $_POST['store_password1'];
        $store_password2 = $_POST['store_password2'];
        $store_contactno = $_POST['store_contactno'];
        $store_storeaddress = $_POST['store_storeaddress'];

        AddNewStores($store_fullname, $store_username, $store_email, $store_password1, $store_password2, $store_contactno, $store_storeaddress);
    }

    else if($function == 'GetAllStores')
    {
        GetAllStores();
    }

    else if($function == 'DeleteStore')
    {
        $storeid = $_POST['storeid'];
        DeleteStore($storeid);
    }

    else if($function == 'ResetPassword')
    {
        $user_id = $_POST['user_id'];
        ResetPassword($user_id);
    }

    else if($function == 'MasterUserList')
    {
        MasterUserList();
    }

    else if($function == 'MasterUserActivation')
    {
        $userid = $_POST['userid'];
        MasterUserActivation($userid);
    }

    else if($function == 'MasterDeactivate_Users')
    {
        $userid = $_POST['userid'];
        MasterDeactivate_Users($userid);
    }

    else if($function == 'MasterUserRejection')
    {
        $userid = $_POST['userid'];
        MasterUserRejection($userid);
    }

    else if($function == 'GetMaterialType')
    {
        GetMaterialType();
    }

    else if($function == 'GetStorageType')
    {
        GetStorageType();
    }

    else if($function == 'GetSubCategory')
    {
        GetSubCategory();
    }

    else if($function == 'GetUOMList')
    {
        GetUOMList();
    }

    else if($function == 'MasterItemList')
    {
        MasterItemList();
    }

    else if($function == 'MasterStoreList')
    {
        MasterStoreList();
    }
 
    else if($function == 'getregisterall')
    {
        getregisterall();
    }

//SettingsModule


    // ----------------------------------------------------------------------------- //


// DashboardModule

    function pieChartLoadData($dataBarGraph, $CustomerID, $to, $from, $filter, $searchkey, $label, $restart, $reend)
    {
        include 'dbcon.php';
        $lessThree = date('Y-m-d', strtotime('+3 months'));
        $lessSix = date('Y-m-d', strtotime('+6 months'));
        
        if(empty($searchkey))
        {
            if($label == 'Less Than 3 Months')
            {   
                
                $to = $lessThree;
                $query = "CALL wms_reports.SP_ageing_dashboard_onclick_lessThree($CustomerID, '$to', '$to', NULL)";
            }
            else if($label == 'Less Than 6 Months')
            {
                
                $from = $lessThree;
                $to = $lessSix;
                $query = "CALL wms_reports.SP_ageing_dashboard_onclick_lessSix($CustomerID, '$from', '$to', NULL)";
            }
            else if($label == 'More Than 6 Months')
            {
                $from = $lessSix;
                $query = "CALL wms_reports.SP_ageing_dashboard_onclick_moreSix($CustomerID, '$from', '2050-01-01', NULL)";
            }
            else if($label == 'No Expiry')
            {
                $query = "CALL wms_reports.SP_ageing_dashboard_onclick_noExpiry($CustomerID, NULL)";
            }
            else
            {
                $query = "CALL wms_reports.SP_ageing_dashboard_onclick_expired($CustomerID, NULL)";
            }

            $res = mysqli_query($conn, $query);

            if(mysqli_num_rows($res) > 0)
            {
                
                while($rows = mysqli_fetch_array($res))
                { 
                    if(empty($rows[0]))
                    {
                        $itemcode = $rows[7];
                        $itemcode = '<span style="color:red">*(' .$itemcode. ')*</span>';
                    }
                    else
                    {
                        $itemcode = $rows[0];
                    }

                    if(!empty($rows[5]))
                    {
                        $expireddate = strtotime($rows[5]);
                        $expireddate = date('d-M-Y',$expireddate);
                    }
                    else
                    {
                        $expireddate = 'No Expiry';
                    }

                $wgt = number_format((float)$rows[4], 2);
                $data[] = array(
                    'sku' => $itemcode,
                    'desc' => $rows[1],
                    'noOfSKU' => number_format($rows[2]),
                    'quantity' => number_format($rows[3]),
                    'wgt' => $wgt,
                    'expiry' => $expireddate,
                    'expiringInDays' => $rows[6]
                );
                
                }
                echo json_encode($data);
            }
        }
        else
        {
            if($label == 'Less Than 3 Months')
            {   
                
                $to = $lessThree;
                $query = "CALL wms_reports.SP_ageing_dashboard_onclick_lessThree($CustomerID, '$to', '$to', $searchkey)";
            }
            else if($label == 'Less Than 6 Months')
            {
                
                $from = $lessThree;
                $to = $lessSix;
                $query = "CALL wms_reports.SP_ageing_dashboard_onclick_lessSix($CustomerID, '$from', '$to', $searchkey)";
            }
            else if($label == 'More Than 6 Months')
            {
                $from = $lessSix;
                $query = "CALL wms_reports.SP_ageing_dashboard_onclick_moreSix($CustomerID, '$from', '2050-01-01', $searchkey)";
            }
            else if($label == 'No Expiry')
            {
                $query = "CALL wms_reports.SP_ageing_dashboard_onclick_noExpiry($CustomerID, $searchkey)";
            }
            else
            {
                $query = "CALL wms_reports.SP_ageing_dashboard_onclick_expired($CustomerID, $searchkey)";
            }

            $res = mysqli_query($conn, $query);

            if(mysqli_num_rows($res) > 0)
            {
                
                while($rows = mysqli_fetch_array($res))
                { 
                    if(empty($rows[0]))
                    {
                        $itemcode = $rows[7];
                        $itemcode = '<span style="color:red">*(' .$itemcode. ')*</span>';
                    }
                    else
                    {
                        $itemcode = $rows[0];
                    }

                    if(!empty($rows[5]))
                    {
                        $expireddate = strtotime($rows[5]);
                        $expireddate = date('d-M-Y',$expireddate);
                    }
                    else
                    {
                        $expireddate = 'No Expiry';
                    }

                $wgt = number_format((float)$rows[4], 2);
                $data[] = array(
                    'sku' => $itemcode,
                    'desc' => $rows[1],
                    'noOfSKU' => number_format($rows[2]),
                    'quantity' => number_format($rows[3]),
                    'wgt' => $wgt,
                    'expiry' => $expireddate,
                    'expiringInDays' => $rows[6]
                );
                
                }
                echo json_encode($data);
            }
        }
        


        
    }

    function barChartLoadData($label, $barGraph, $restart, $reend, $CustomerID)
    {   
        include 'dbcon.php';

        if($barGraph != '')
        {
            // if($reend == 0)
            // {
            //     $query = "CALL wms_inbound.sp_default_received_sum($label, $CustomerID)";
            //     $result = mysqli_query($conn, $query);

            //     if(mysqli_num_rows($result) < 1)
            //     {
            //         $data[] = array(
            //               'sku' => 'No Data Found',
            //               'desc' => '',
            //               'noOfSKU' => '',
            //               'quantity' => '',
            //               'wgt' => '',
            //               'recDate' => '',
            //             );
            //         echo json_encode($data);
            //     }
            //     else
            //     {
            //         while($rows = mysqli_fetch_array($result))
            //         {
            //              $data[] = array(
            //               'sku' => $rows[0],
            //               'desc' => $rows['ItemDesc'],
            //               'noOfSKU' => $label,
            //               'quantity' => $rows['Quantity'],
            //               'wgt' => $rows['Weight'],
            //               'recDate' => $rows['ReceivingDate']

            //             );
            //         }

            //          echo json_encode($data);
            //     }
            // }
            // else
            // {
            //     $query = "CALL wms_inbound.sp_default_received_sum($label, $CustomerID)";
            //     $result = mysqli_query($conn, $query);

            //     if(mysqli_num_rows($result) < 1)
            //     {
            //         $data[] = array(
            //               'sku' => 'No Data Found',
            //               'desc' => '',
            //               'noOfSKU' => '',
            //               'quantity' => '',
            //               'wgt' => '',
            //               'recDate' => '',
            //             );
            //         echo json_encode($data);
            //     }
            //     else
            //     {   
            //         $rend = date('Y-m-d', strtotime( $reend . " +1 days"));
            //         while($rows = mysqli_fetch_array($result))
            //         {   
            //              if($rows['ReceivingDate'] >= $restart && $rows['ReceivingDate'] <= $rend)
            //              {
            //                 $data[] = array(
            //                   'sku' => $rows[0],
            //                   'desc' => $rows['ItemDesc'],
            //                   'noOfSKU' => $label,
            //                   'quantity' => $rows['Quantity'],
            //                   'wgt' => $rows['Weight'],
            //                   'recDate' => $rows['ReceivingDate']

            //                 );
            //              }
            //         }

            //         echo json_encode($data);
            //     }
            // } 
        }
        
    }

    function login($username, $userpword)
    {
        include 'dbcon.php';

        //prevent SQL injections
        $username = stripslashes($username);
        $userpword = stripslashes($userpword);

        $query = "SELECT users.CusUsername, users.CusPassword, customers.CustomerID, customers.CompanyName, users.CommonCode, users.id, users.CusUserStatus, users.CusName 
        FROM wms_cloud.tbl_customers_users users
        LEFT JOIN wms_cloud.tbl_customers customers ON users.CommonCode = customers.CustomerCommonCode
        WHERE users.CusUsername = '$username'";
        $result = mysqli_query($conn, $query);
        if(mysqli_num_rows($result) == 1)
        {
            while($row = mysqli_fetch_array($result))
            {
                $hashedpass = $row[1];
                $_SESSION['CustomerId'] = $row[2];
                $_SESSION['CompanyName'] = $row[3];
                $_SESSION['CommonCode'] = $row[4];
                $_SESSION['UserID'] = $row[5];
                $userstatus = $row[6];
                $_SESSION['Username'] = $row[7];
            }
            
            if(password_verify($userpword, $hashedpass))
            {
                if($userstatus == 0)
                {
                    echo 'Your account is not Activated';
                }
                else
                {
                    $userid = $_SESSION['UserID'];
                    $query = "INSERT INTO wms_clientportal.tbl_users_session (`user_id`, `session_start`, `session_status`) VALUES ('$userid', NOW(), 'active')";
                    if(mysqli_query($conn, $query))
                    {
                       echo " Success!";
                    }                
		}
            }
            else
            {
                echo 'Please check Username/Email and Password if correct.';
            }
        }
        else
        {
            echo "No Record Found";
        }

        // $query = "SELECT users.CusUsername, users.CusPassword, customers.CustomerID, customers.CompanyName, users.CommonCode, users.id 
        // FROM wms_cloud.tbl_customers_users users
        // LEFT JOIN wms_cloud.tbl_customers customers ON users.CommonCode = customers.CustomerCommonCode
        // WHERE users.CusUsername = '$username' AND users.CusPassword = '$userpword'";
        // $result = mysqli_query($conn, $query);
        // if(mysqli_num_rows($result) == 1)
        // {
        //     while($row = mysqli_fetch_array($result))
        //     {
        //         $_SESSION['CustomerId'] = $row[2];
        //         $_SESSION['CompanyName'] = $row[3];
        //         $_SESSION['CommonCode'] = $row[4];
        //         $_SESSION['UserID'] = $row[5];

        //         echo 'Login Success!';
        //     }
        // }
        // else
        // {
        //     echo "Please check Username/Email and Password if correct.";
        // }
    }

    function loadSKUNo($CustomerID)
    {
        include ('dbcon.php');

        $query = "SELECT ItemID, Client_SKU FROM wms_cloud.tbl_items WHERE ItemCustomerID = $CustomerID";

        $result = mysqli_query($conn, $query);

        while($rows = mysqli_fetch_array($result))
        {
            echo '<option value="'.$rows[0].'">'.$rows[1].'</option>';
        }
    }

    function loadSKUDesc($CustomerID)
    {
        include ('dbcon.php');

        $query = "SELECT ItemID, ItemDesc FROM wms_cloud.tbl_items WHERE ItemCustomerID = $CustomerID";

        $result = mysqli_query($conn, $query);

        while($rows = mysqli_fetch_array($result))
        {
            echo '<option value="'.$rows[0].'">'.$rows[1].'</option>';
        }
    }

    function loadSKUandDesc($filter, $CustomerID)
    {
        include ('dbcon.php');

        $query = "SELECT ItemID, ItemDesc, Client_SKU, ItemCode FROM wms_cloud.tbl_items WHERE ItemCustomerID = $CustomerID";

        $result = mysqli_query($conn, $query);

        while($rows = mysqli_fetch_array($result))
        {
            if($filter == 'SKUDesc')
            {
                echo '<option value="'.$rows[0].'">'.$rows[1].'</option>';
            }
            else if($filter == 'SKUNo')   
            {   
                if(empty($rows[2]))
                {
                    echo '<option style="color:red" value="'.$rows[0].'">*('.$rows[3].')*</option>';
                }
                else
                {
                    echo '<option value="'.$rows[0].'">'.$rows[2].'</option>';
                }
                
            }
        }
    }

// DashboardModule


// Reports
    function soh_report($CustomerID, $WarehouseID)
    {
        include ('dbcon.php');
        $query = "SELECT
                    wms_inbound.tbl_receivingitems.ItemID,
                    Client_SKU,
                    wms_cloud.tbl_items.ItemDesc,
                    SUM(wms_inbound.tbl_receivingitems.Quantity),
                    SUM(wms_inbound.tbl_receivingitems.Weight),
                    UOM_Abv,
                    wms_cloud.tbl_itemstatus.ItemStatus,
                    CASE
                        WHEN LEFT(ExpiryDate, 10) = '0000-00-00' THEN 'No Expiry'
                        WHEN ExpiryDate IS NULL THEN 'No Expiry'
                        ELSE LEFT(ExpiryDate, 10)
                    END,
                    Batch,
                    CASE
                        WHEN LEFT(ProdDate, 10) = '0000-00-00' THEN 'No Production Date'
                        WHEN ProdDate IS NULL THEN 'No Production Date'
                        ELSE LEFT(ProdDate, 10)
                    END,
                    Container,
                    IF(OtherReference IS NULL OR OtherReference = '', 'No Other Reference', OtherReference) AS OtherReference,
                    ItemCode,
                    wms_inbound.tbl_receiving.IBN
                FROM wms_inbound.tbl_receivingitems
                LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN AND wms_inbound.tbl_receivingitems.isout = 0
                LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                LEFT JOIN wms_inbound.tbl_pallets on wms_inbound.tbl_receivingitems.PalletID = wms_inbound.tbl_pallets.PalletID
                LEFT JOIN wms_cloud.tbl_weightuom on wms_cloud.tbl_items.UOMID = wms_cloud.tbl_weightuom.UOMID
                LEFT JOIN wms_inbound.tbl_locations on wms_inbound.tbl_pallets.LocationID = wms_inbound.tbl_locations.LocationID
                LEFT JOIN wms_inbound.tbl_room on wms_inbound.tbl_locations.RoomCode = wms_inbound.tbl_room.RoomCode
                LEFT JOIN wms_cloud.tbl_itemstatus on wms_inbound.tbl_receivingitems.ItemStatusID = wms_cloud.tbl_itemstatus.ItemStatusID
                LEFT JOIN wms_cloud.tbl_customers on wms_inbound.tbl_receivingitems.CustomerID = wms_cloud.tbl_customers.CustomerID
                ";

            if(empty($WarehouseID))
            {
                $query .= "WHERE wms_inbound.tbl_receivingitems.CustomerID = $CustomerID
                AND wms_inbound.tbl_receivingitems.Quantity > 0 AND wms_inbound.tbl_receiving.StatusID != 5
                AND Checked = 'True' AND (ForPutaway = 0 OR ForPutaway >= 2)
                GROUP BY wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ExpiryDate, wms_inbound.tbl_receivingitems.ItemStatusID
                ORDER BY wms_inbound.tbl_receivingitems.ItemID";
            }
            else
            {
                $query .= "WHERE wms_inbound.tbl_receivingitems.CustomerID = $CustomerID AND wms_cloud.tbl_customers.WarehouseID = $WarehouseID
                AND wms_inbound.tbl_receivingitems.Quantity > 0 AND wms_inbound.tbl_receiving.StatusID != 5
                AND Checked = 'True' AND (ForPutaway = 0 OR ForPutaway >= 2)
                GROUP BY wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ExpiryDate, wms_inbound.tbl_receivingitems.ItemStatusID
                ORDER BY wms_inbound.tbl_receivingitems.ItemID";
            }

            $result = mysqli_query($conn, $query);

            if(mysqli_num_rows($result) < 1)
            {
                $data[] = array(
                    'itemid'   => 'No data Found.',
                    'sku'   => 'No data Found.',
                    'item'   => '',
                    'qty'   => '',
                    'wgt'   => '',
                    'oum'   => '',
                    'itemstatus'   => '',
                    'expirydate'   => '',
                    'batch'   => '',
                    'prod'   => '',
                    'cvnumber'   => '',
                    'otherref'   => '',
                    'controlno'   => ''
                    );

                echo json_encode($data);
            }
            else
            {   

                while ($rows = mysqli_fetch_row($result))
                {   
                    $expiry = "";
                    $prod = "";

                    $expiry = $rows[7];
                    $expiry = strtotime($rows[7]);
                    $expiry = date('d-M-Y', $expiry);

                    $prod = $rows[9];
                    $prod = strtotime($rows[9]);
                    $prod = date('d-M-Y', $prod);

                    if($rows[7] == 'No Expiry' || empty($rows[7]))
                    {
                        $expiry = '';
                    }

                    if($rows[9] == 'No Production Date' || empty($rows[9]))
                    {
                        $prod = '';
                    }

                    if(empty($rows[1]))
                    {
                        $itemcode = $rows[12];
                        $itemcode = '<span style="color:red">*(' .$itemcode. ')*</span>';
                    }
                    else
                    {
                        $itemcode = $rows[1];
                    }

                    $wgt = number_format((float)$rows[4], 2);

                    $qty = number_format((float)$rows[3], 0);
                    
                    $data[] = array(
                        'itemid'   => $rows[0],
                        'sku'   => $itemcode,
                        'item'   => $rows[2],
                        'qty'   => $qty,
                        'wgt'   => $wgt,
                        'oum'   => $rows[5],
                        'itemstatus'   => $rows[6],
                        'expirydate'   => $expiry,
                        'batch'   => $rows[8],
                        'prod'   => $prod,
                        'cvnumber'   => $rows[10],
                        'otherref'   => $rows[11],
                        'controlno'   => $rows[13]
                    );
                }

                echo json_encode($data);
            }
            
    }

    function filteredSOH($filtered, $CustomerID, $WarehouseID)
    {
        include ('dbcon.php');
        $query = "SELECT
                    wms_inbound.tbl_receivingitems.ItemID,
                    Client_SKU,
                    wms_cloud.tbl_items.ItemDesc,
                    SUM(wms_inbound.tbl_receivingitems.Quantity),
                    SUM(wms_inbound.tbl_receivingitems.Weight),
                    UOM_Abv,
                    wms_cloud.tbl_itemstatus.ItemStatus,
                    CASE
                        WHEN LEFT(ExpiryDate, 10) = '0000-00-00' THEN 'No Expiry'
                        WHEN ExpiryDate IS NULL THEN 'No Expiry'
                        ELSE LEFT(ExpiryDate, 10)
                    END,
                    Batch,
                    CASE
                        WHEN LEFT(ProdDate, 10) = '0000-00-00' THEN 'No Production Date'
                        WHEN ProdDate IS NULL THEN 'No Production Date'
                        ELSE LEFT(ProdDate, 10)
                    END,
                    Container,
                    IF(OtherReference IS NULL OR OtherReference = '', 'No Other Reference', OtherReference) AS OtherReference,
                    ItemCode,
                    wms_inbound.tbl_receiving.IBN
                FROM wms_inbound.tbl_receivingitems
                LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN AND wms_inbound.tbl_receivingitems.isout = 0
                LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                LEFT JOIN wms_inbound.tbl_pallets on wms_inbound.tbl_receivingitems.PalletID = wms_inbound.tbl_pallets.PalletID
                LEFT JOIN wms_cloud.tbl_weightuom on wms_cloud.tbl_items.UOMID = wms_cloud.tbl_weightuom.UOMID
                LEFT JOIN wms_inbound.tbl_locations on wms_inbound.tbl_pallets.LocationID = wms_inbound.tbl_locations.LocationID
                LEFT JOIN wms_inbound.tbl_room on wms_inbound.tbl_locations.RoomCode = wms_inbound.tbl_room.RoomCode
                LEFT JOIN wms_cloud.tbl_itemstatus on wms_inbound.tbl_receivingitems.ItemStatusID = wms_cloud.tbl_itemstatus.ItemStatusID
                LEFT JOIN wms_cloud.tbl_customers on wms_inbound.tbl_receivingitems.CustomerID = wms_cloud.tbl_customers.CustomerID
                WHERE wms_inbound.tbl_receivingitems.CustomerID = $CustomerID 
                AND wms_inbound.tbl_receivingitems.Quantity > 0 AND (ForPutaway = 0 OR ForPutaway >= 2)
                AND Checked = 'True' AND wms_inbound.tbl_receiving.StatusID != 5
                ";

            if(empty($WarehouseID))
            {
                $query .= "GROUP BY wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ExpiryDate, wms_inbound.tbl_receivingitems.ItemStatusID
                ";

                if($filtered == 'container')
                {
                    $query .= "ORDER BY wms_inbound.tbl_receiving.Container";
                }
                else if($filtered == 'item')
                {
                    $query .= "ORDER BY wms_inbound.tbl_receivingitems.ItemID";
                }
                else if($filtered == 'batch')
                {
                    $query .= "ORDER BY wms_inbound.tbl_receivingitems.Batch";
                }
                else if($filtered == 'status')
                {
                    $query .= "ORDER BY wms_cloud.tbl_itemstatus.ItemStatus";
                }
                else if($filtered == 'ref')
                {
                    $query .= "ORDER BY wms_inbound.tbl_receiving.OtherReference";
                }

            }
            else
            {
                $query .= "AND wms_cloud.tbl_customers.WarehouseID = $WarehouseID
                GROUP BY wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ExpiryDate, wms_inbound.tbl_receivingitems.ItemStatusID
                ";

                if($filtered == 'container')
                {
                    $query .= "ORDER BY wms_inbound.tbl_receiving.Container";
                }
                else if($filtered == 'item')
                {
                    $query .= "ORDER BY wms_inbound.tbl_receivingitems.ItemID";
                }
                else if($filtered == 'batch')
                {
                    $query .= "ORDER BY wms_inbound.tbl_receivingitems.Batch";
                }
                else if($filtered == 'status')
                {
                    $query .= "ORDER BY wms_cloud.tbl_itemstatus.ItemStatus";
                }
                else if($filtered == 'ref')
                {
                    $query .= "ORDER BY wms_inbound.tbl_receiving.OtherReference";
                }
            }

            $result = mysqli_query($conn, $query);

            if(mysqli_num_rows($result) < 1)
            {
                $data[] = array(
                    'itemid'   => 'No data Found.',
                    'sku'   => 'No data Found.',
                    'item'   => '',
                    'qty'   => '',
                    'wgt'   => '',
                    'oum'   => '',
                    'itemstatus'   => '',
                    'expirydate'   => '',
                    'batch'   => '',
                    'prod'   => '',
                    'cvnumber'   => '',
                    'otherref'   => '',
                    'controlno'   => ''
                    );
                echo json_encode($data);
            }
            else
            {   

                while ($rows = mysqli_fetch_row($result))
                {   
                    $expiry = "";
                    $prod = "";

                    $expiry = $rows[7];
                    $expiry = strtotime($rows[7]);
                    $expiry = date('d-M-Y', $expiry);

                    $prod = $rows[8];
                    $prod = strtotime($rows[8]);
                    $prod = date('d-M-Y', $prod);

                    if($rows[7] == 'No Expiry' || empty($rows[7]))
                    {
                        $expiry = '';
                    }

                    if($rows[9] == 'No Production Date' || empty($rows[9]))
                    {
                        $prod = '';
                    }

                    if(empty($rows[1]))
                    {
                        $itemcode = $rows[12];
                        $itemcode = '<span style="color:red">*(' .$itemcode. ')*</span>';
                    }
                    else
                    {
                        $itemcode = $rows[1];
                    }

                    $wgt = number_format((float)$rows[4], 2);
                    $qty = number_format((float)$rows[3], 0);
                    
                    $data[] = array(
                    'itemid'   => $rows[0],
                    'sku'   => $itemcode,
                    'item'   => $rows[2],
                    'qty'   => $qty,
                    'wgt'   => $wgt,
                    'oum'   => $rows[5],
                    'itemstatus'   => $rows[6],
                    'expirydate'   => $expiry,
                    'batch'   => $rows[8],
                    'prod'   => $prod,
                    'cvnumber'   => $rows[10],
                    'otherref'   => $rows[11],
                    'controlno'   => $rows[13]
                    );
                }

                echo json_encode($data);
            }
            
    }

    function searchSOH($filtered, $key, $CustomerID, $WarehouseID)
    {
        include ('dbcon.php');
        $query = "SELECT
                    wms_inbound.tbl_receivingitems.ItemID,
                    Client_SKU,
                    wms_cloud.tbl_items.ItemDesc,
                    SUM(wms_inbound.tbl_receivingitems.Quantity),
                    SUM(wms_inbound.tbl_receivingitems.Weight),
                    UOM_Abv,
                    wms_cloud.tbl_itemstatus.ItemStatus,
                    CASE
                        WHEN LEFT(ExpiryDate, 10) = '0000-00-00' THEN 'No Expiry'
                        WHEN ExpiryDate IS NULL THEN 'No Expiry'
                        ELSE LEFT(ExpiryDate, 10)
                    END,
                    Batch,
                    CASE
                        WHEN LEFT(ProdDate, 10) = '0000-00-00' THEN 'No Production Date'
                        WHEN ProdDate IS NULL THEN 'No Production Date'
                        ELSE LEFT(ProdDate, 10)
                    END,
                    Container,
                    IF(OtherReference IS NULL OR OtherReference = '', 'No Other Reference', OtherReference) AS OtherReference,
                    ItemCode,
                    wms_inbound.tbl_receiving.IBN
                FROM wms_inbound.tbl_receivingitems
                LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN AND wms_inbound.tbl_receivingitems.isout = 0
                LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                LEFT JOIN wms_inbound.tbl_pallets on wms_inbound.tbl_receivingitems.PalletID = wms_inbound.tbl_pallets.PalletID
                LEFT JOIN wms_cloud.tbl_weightuom on wms_cloud.tbl_items.UOMID = wms_cloud.tbl_weightuom.UOMID
                LEFT JOIN wms_inbound.tbl_locations on wms_inbound.tbl_pallets.LocationID = wms_inbound.tbl_locations.LocationID
                LEFT JOIN wms_inbound.tbl_room on wms_inbound.tbl_locations.RoomCode = wms_inbound.tbl_room.RoomCode
                LEFT JOIN wms_cloud.tbl_itemstatus on wms_inbound.tbl_receivingitems.ItemStatusID = wms_cloud.tbl_itemstatus.ItemStatusID
                LEFT JOIN wms_cloud.tbl_customers on wms_inbound.tbl_receivingitems.CustomerID = wms_cloud.tbl_customers.CustomerID
                WHERE wms_inbound.tbl_receivingitems.CustomerID = $CustomerID
                AND wms_inbound.tbl_receivingitems.Quantity > 0 
                AND Checked = 'True' AND (ForPutaway = 0 OR ForPutaway >= 2) AND wms_inbound.tbl_receiving.StatusID != 5
                ";


            if(empty($WarehouseID))
            {
                if($filtered == 'container')
                {
                    if(empty($key))
                    {
                        $query .= "GROUP BY wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ExpiryDate, wms_inbound.tbl_receivingitems.ItemStatusID
                        ORDER BY wms_inbound.tbl_receiving.Container";
                    }
                    else
                    {
                        $query .= "AND wms_inbound.tbl_receiving.Container LIKE '%$key%'
                        GROUP BY wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ExpiryDate, wms_inbound.tbl_receivingitems.ItemStatusID
                        ORDER BY wms_inbound.tbl_receiving.Container";
                    }
                }

                else if($filtered == 'item')
                {
                    if(empty($key))
                    {
                        $query .= "GROUP BY wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ExpiryDate, wms_inbound.tbl_receivingitems.ItemStatusID
                        ORDER BY wms_inbound.tbl_receivingitems.ItemID";
                    }
                    else
                    {
                        $query .= "AND wms_cloud.tbl_items.ItemDesc LIKE '%$key%'
                        GROUP BY wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ExpiryDate, wms_inbound.tbl_receivingitems.ItemStatusID
                        ORDER BY wms_inbound.tbl_receivingitems.ItemID";
                    }
                }

                else if($filtered == 'batch')
                {
                    if(empty($key))
                    {
                        $query .= "GROUP BY wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ExpiryDate, wms_inbound.tbl_receivingitems.ItemStatusID
                        ORDER BY wms_inbound.tbl_receivingitems.Batch";
                    }
                    else
                    {
                        $query .= "AND wms_inbound.tbl_receivingitems.Batch LIKE '%$key%'
                        GROUP BY wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ExpiryDate, wms_inbound.tbl_receivingitems.ItemStatusID
                        ORDER BY wms_inbound.tbl_receivingitems.Batch";
                    }
                }

                else if($filtered == 'status')
                {
                    if(empty($key))
                    {
                        $query .= "GROUP BY wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ExpiryDate, wms_inbound.tbl_receivingitems.ItemStatusID
                        ORDER BY wms_cloud.tbl_itemstatus.ItemStatus";
                    }
                    else
                    {
                        $query .= "AND wms_cloud.tbl_itemstatus.ItemStatus LIKE '%$key%'
                        GROUP BY wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ExpiryDate, wms_inbound.tbl_receivingitems.ItemStatusID
                        ORDER BY wms_cloud.tbl_itemstatus.ItemStatus";
                    }
                }

                else if($filtered == 'ref')
                {
                    if(empty($key))
                    {
                        $query .= "GROUP BY wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ExpiryDate, wms_inbound.tbl_receivingitems.ItemStatusID
                        ORDER BY wms_inbound.tbl_receiving.OtherReference";
                    }
                    else
                    {
                        $query .= "AND wms_inbound.tbl_receiving.OtherReference LIKE '%$key%'
                        GROUP BY wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ExpiryDate, wms_inbound.tbl_receivingitems.ItemStatusID
                        ORDER BY wms_inbound.tbl_receiving.OtherReference";
                    }
                }
            }
            else
            {   
                $query .= "AND wms_cloud.tbl_customers.WarehouseID = $WarehouseID
                ";
                if($filtered == 'container')
                {
                    if(empty($key))
                    {
                        $query .= "GROUP BY wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ExpiryDate, wms_inbound.tbl_receivingitems.ItemStatusID
                        ORDER BY wms_inbound.tbl_receiving.Container";
                    }
                    else
                    {
                        $query .= "AND wms_inbound.tbl_receiving.Container LIKE '%$key%'
                        GROUP BY wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ExpiryDate, wms_inbound.tbl_receivingitems.ItemStatusID
                        ORDER BY wms_inbound.tbl_receiving.Container";
                    }
                }

                else if($filtered == 'item')
                {
                    if(empty($key))
                    {
                        $query .= "GROUP BY wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ExpiryDate, wms_inbound.tbl_receivingitems.ItemStatusID
                        ORDER BY wms_inbound.tbl_receivingitems.ItemID";
                    }
                    else
                    {
                        $query .= "AND wms_cloud.tbl_items.ItemDesc LIKE '%$key%'
                        GROUP BY wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ExpiryDate, wms_inbound.tbl_receivingitems.ItemStatusID
                        ORDER BY wms_inbound.tbl_receivingitems.ItemID";
                    }
                }

                else if($filtered == 'batch')
                {
                    if(empty($key))
                    {
                        $query .= "GROUP BY wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ExpiryDate, wms_inbound.tbl_receivingitems.ItemStatusID
                        ORDER BY wms_inbound.tbl_receivingitems.Batch";
                    }
                    else
                    {
                        $query .= "AND wms_inbound.tbl_receivingitems.Batch LIKE '%$key%'
                        GROUP BY wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ExpiryDate, wms_inbound.tbl_receivingitems.ItemStatusID
                        ORDER BY wms_inbound.tbl_receivingitems.Batch";
                    }
                }

                else if($filtered == 'status')
                {
                    if(empty($key))
                    {
                        $query .= "GROUP BY wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ExpiryDate, wms_inbound.tbl_receivingitems.ItemStatusID
                        ORDER BY wms_cloud.tbl_itemstatus.ItemStatus";
                    }
                    else
                    {
                        $query .= "AND wms_cloud.tbl_itemstatus.ItemStatus LIKE '%$key%'
                        GROUP BY wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ExpiryDate, wms_inbound.tbl_receivingitems.ItemStatusID
                        ORDER BY wms_cloud.tbl_itemstatus.ItemStatus";
                    }
                }

                else if($filtered == 'ref')
                {
                    if(empty($key))
                    {
                        $query .= "GROUP BY wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ExpiryDate, wms_inbound.tbl_receivingitems.ItemStatusID
                        ORDER BY wms_inbound.tbl_receiving.OtherReference";
                    }
                    else
                    {
                        $query .= "AND wms_inbound.tbl_receiving.OtherReference LIKE '%$key%'
                        GROUP BY wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ExpiryDate, wms_inbound.tbl_receivingitems.ItemStatusID
                        ORDER BY wms_inbound.tbl_receiving.OtherReference";
                    }
                }
            }

            
            $result = mysqli_query($conn, $query);

            if(mysqli_num_rows($result) < 1)
            {
                $data[] = array(
                    'itemid'   => 'No data Found.',
                    'sku'   => 'No data Found.',
                    'item'   => '',
                    'qty'   => '',
                    'wgt'   => '',
                    'oum'   => '',
                    'itemstatus'   => '',
                    'expirydate'   => '',
                    'batch'   => '',
                    'prod'   => '',
                    'cvnumber'   => '',
                    'otherref'   => '',
                    'controlno'   => ''
                    );
                echo json_encode($data);
            }
            else
            {   
                
                while ($rows = mysqli_fetch_row($result))
                {   
                    $expiry = "";
                    $prod = "";

                    $expiry = $rows[7];
                    $expiry = strtotime($rows[7]);
                    $expiry = date('d-M-Y', $expiry);

                    $prod = $rows[8];
                    $prod = strtotime($rows[8]);
                    $prod = date('d-M-Y', $prod);

                    if($rows[7] == 'No Expiry' || empty($rows[7]))
                    {
                        $expiry = '';
                    }

                    if($rows[9] == 'No Production Date' || empty($rows[9]))
                    {
                        $prod = '';
                    }

                    if(empty($rows[1]))
                    {
                        $itemcode = $rows[12];
                        $itemcode = '<span style="color:red">*(' .$itemcode. ')*</span>';
                    }
                    else
                    {
                        $itemcode = $rows[1];
                    }

                    $wgt = number_format((float)$rows[4], 2);
                    $qty = number_format((float)$rows[3], 0);
                    
                    $data[] = array(
                    'itemid'   => $rows[0],
                    'sku'   => $itemcode,
                    'item'   => $rows[2],
                    'qty'   => $qty,
                    'wgt'   => $wgt,
                    'oum'   => $rows[5],
                    'itemstatus'   => $rows[6],
                    'expirydate'   => $expiry,
                    'batch'   => $rows[8],
                    'prod'   => $prod,
                    'cvnumber'   => $rows[10],
                    'otherref'   => $rows[11],
                    'controlno'   => $rows[13]
                    );
                }

                echo json_encode($data);
            }
            
    }

    function Report_GenerateITR($WarehouseID, $datefrom, $dateto, $CustomerID, $filtered, $key)
    {
        include ('dbcon.php');
        // echo $WarehouseID;
        $status = '';
        $totalwgt = 0;
        $query = "SELECT 
                    ReceivingDate,
                    IBN,
                    IFNULL(SUM(GOODQTY), 0),
                    IFNULL(SUM(HOLDQTY), 0),
                    SUM(QTY),
                    SUM(WGT),
                    Container,
                    StatusID,
                    ItemStatus,
                    ASN,
                    CPStatus_id,
                    CP_QTY,
                    CP_WGT
                FROM
                    wms_reports.tbl_itr_reportcp
                WHERE
                    CusID = $CustomerID
            ";
            
            if(empty($filtered))
            {
                $filtered = 'ReceivingDate';
            }

            if(!empty($key))
            {   
                $query .= "AND $filtered LIKE '%$key%'
                ";
                if(empty($WarehouseID))
                {   
                    $date1=date_create($datefrom);
                    $date2=date_create($dateto);
                    $diff=date_diff($date1,$date2);
                    $datetotal = $diff->format("%a");
                    if($datetotal <= 2)
                    {   
                        $datefrom = '2001-01-01T09:10';
                        $dateto = '2031-01-01T09:10';
                        $query .= " AND ReceivingDate BETWEEN '$datefrom' AND '$dateto'
                        GROUP BY IBN
                        ORDER BY $filtered";
                    }
                    else
                    {
                        $query .= " AND ReceivingDate BETWEEN '$datefrom' AND '$dateto'
                        GROUP BY IBN
                        ORDER BY $filtered
                        ";
                    }
                }
                else
                {   
                    $date1=date_create($datefrom);
                    $date2=date_create($dateto);
                    $diff=date_diff($date1,$date2);
                    $datetotal = $diff->format("%a");

                    if($datetotal  <= 2)
                    {   
                        $datefrom = '2001-01-01T09:10';
                        $dateto = '2031-01-01T09:10';

                        $query .= " AND ReceivingDate BETWEEN '$datefrom' AND '$dateto'
                        AND WarehouseID = $WarehouseID
                        GROUP BY IBN
                        ORDER BY $filtered";
                    }
                    else
                    {
                        $query .= " AND ReceivingDate BETWEEN '$datefrom' AND '$dateto'
                        AND WarehouseID = $WarehouseID
                        GROUP BY IBN
                        ORDER BY $filtered";
                    }
                }
            }
            else
            {
                if(empty($WarehouseID))
                {   
                    $date1=date_create($datefrom);
                    $date2=date_create($dateto);
                    $diff=date_diff($date1,$date2);
                    $datetotal = $diff->format("%a");
                    if($datetotal  <= 2)
                    {   
                        $datefrom = '2001-01-01T09:10';
                        $dateto = '2031-01-01T09:10';
                        $query .= " AND ReceivingDate BETWEEN '$datefrom' AND '$dateto'
                        GROUP BY IBN
                        ORDER BY $filtered";
                    }
                    else
                    {
                        $query .= " AND ReceivingDate BETWEEN '$datefrom' AND '$dateto'
                        GROUP BY IBN
                        ORDER BY $filtered
                        ";
                    }
                }
                else
                {   
                    $date1=date_create($datefrom);
                    $date2=date_create($dateto);
                    $diff=date_diff($date1,$date2);
                    $datetotal = $diff->format("%a");

                    if($datetotal  <= 2)
                    {   
                        $datefrom = '2001-01-01T09:10';
                        $dateto = '2031-01-01T09:10';

                        $query .= " AND ReceivingDate BETWEEN '$datefrom' AND '$dateto'
                        AND WarehouseID = $WarehouseID
                        GROUP BY IBN
                        ORDER BY $filtered";
                    }
                    else
                    {
                        $query .= " AND ReceivingDate BETWEEN '$datefrom' AND '$dateto'
                        AND WarehouseID = $WarehouseID
                        GROUP BY IBN
                        ORDER BY $filtered";
                    }
                }
            }


        $result = mysqli_query($conn, $query);
        if(mysqli_num_rows($result) < 1)
        {
            $data[] = array(
                'recDate' => 'No data Found',
                'controlno' => '',
                'cpi' => '',
                'goodqty' => '',
                'holdqty' => '',
                'blockqty' => '-',
                'qty' => '',
                'wgt' => '',
                'container' => '',
                'status' => '',
                'remarks' => '',
                'action' => ''

            ); 

            echo json_encode($data);
            // echo $query;
        }
        else
        {
            while($rows = mysqli_fetch_array($result))
            {

                if($rows[10] == 4)
                {
                    $qty = $rows[11];
                    $wgt = $rows[12];
                }
                else
                {
                    $qty = $rows[4];
                    $wgt = $rows[5];
                }
                
                // $wgt = number_format((float)$wgt, 2);
                // $wgt = floatval(preg_replace('/[^\d.]/', '', $wgt));

                if(empty($rows[9]))
                {
                    $cpi = '-';
                }
                else
                {
                    $cpi = $rows[9];
                }
                $data[] = array(
                    'recDate' => $rows[0],
                    'controlno' => $rows[1],
                    'cpi' => $cpi,
                    'goodqty' => $rows[2],
                    'holdqty' => $rows[3],
                    'blockqty' => '-',
                    'qty' => $qty,
                    'wgt' => $wgt,
                    'container' => $rows[6],
                    'status' => $rows[7],
                    'remarks' => '',
                    'action' => '<button class="btn btn-primary" onclick="view_details_itr(\''.$rows[1].'\')">View Details</button>'

                ); 

                
            }

            echo json_encode($data);
        }
        // echo $query;
        
    }

    function Report_GenerateITRDetails($IBN, $CustomerID)
    {
        include 'dbcon.php';
        
        $query = "SELECT 
                    ReceivingDate,
                    rec.IBN,
                    Client_SKU,
                    ItemDesc,
                    SUM(ri.Beg_Quantity),
                    SUM(ri.Beg_Weight),
                    QAReason,
                    Container,
                    CASE
                        WHEN `rec`.`StatusID` = 3 THEN 'Done Receiving'
                        WHEN `rec`.`StatusID` = 2 THEN 'Received In Progress'
                        WHEN `rec`.`StatusID` = 1 THEN 'For Receiving'
                    END AS `StatusID`,
                    itemstat.ItemStatus
                    
                FROM
                    wms_inbound.tbl_receivingitems ri
                        LEFT JOIN
                    wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
                        LEFT JOIN
                    wms_cloud.tbl_items item ON ri.ItemID = item.ItemID
                        LEFT JOIN 
                    wms_cloud.tbl_materials mat ON item.MaterialType = mat.MaterialID
                        LEFT JOIN
                    wms_cloud.tbl_itemstatus itemstat ON ri.ItemStatusID = itemstat.ItemStatusID
                        LEFT JOIN
                    wms_cloud.tbl_customers cus ON ri.CustomerID = cus.CustomerID
                WHERE
                    rec.CusID = $CustomerID
                    AND rec.IBN = '$IBN'
                GROUP BY ri.ItemID , ri.ItemStatusID, itemstat.ItemStatus, rec.Container";

                $result = mysqli_query($conn, $query);
                if(mysqli_num_rows($result) < 1)
                {
                    $data[] = array(
                        'recDate' => '',
                        'controlno' => 'No data Found!',
                        'itemcode' => '',
                        'mtype' => '',
                        'qty' => '',
                        'wgt' => '',
                        'itemstat' => '',
                        'container' => '',
                        'status' =>'',
                        'remarks' =>''

                    ); 

                    echo json_encode($data);
                }
                else
                {
                    while($rows = mysqli_fetch_array($result))
                    {

                        $wgt = number_format((float)$rows[5], 2);
                        $wgt = floatval(preg_replace('/[^\d.]/', '', $wgt));

                        $data[] = array(
                            'recDate' => $rows[0],
                            'controlno' => $rows[1],
                            'itemcode' => $rows[2],
                            'mtype' => $rows[3],
                            'qty' => $rows[4],
                            'wgt' => $wgt,
                            'itemstat' => $rows[6],
                            'container' => $rows[7],
                            'status' => $rows[8],
                            'remarks' => $rows[9]

                        ); 
                        
                    }

                    echo json_encode($data);
                }
                // echo $query;
    }

    function Report_GenerateDOR($WarehouseID, $datefrom, $dateto, $CustomerID, $filtered, $key)
    {
        include ('dbcon.php');
        $data = array();
        $data_ord = array();
        $data_pck = array();
        $data_obd = array();
        $query = "SELECT 
                    OrderDate,
                    ORD,
                    CustomerReference,
                    IFNULL(SUM(Quantity),0),
                    LastUpdatedBy,
                    CASE
                        WHEN `StatusID` != '' OR `StatusID` != NULL THEN 'Order in Process'
                    END AS `StatusID`,
                    Remarks,
                    Weight
                FROM
                wms_outbound.otreport_ord
                WHERE
                    CustomerID = $CustomerID
                ";
        $date1=date_create($datefrom);
        $date2=date_create($dateto);
        $diff=date_diff($date1,$date2);
        $datetotal = $diff->format("%a");

        if($datetotal <= 2)
        {
            $datefrom = '2000-01-01';
            $dateto = '2030-01-01';
        }

        if(empty($WarehouseID))
        {   
            if(empty($key))
            {   
                $query .=" AND OrderDate BETWEEN '$datefrom' AND '$dateto' GROUP BY ORD
                ORDER BY OrderDate";
            }
            else
            {   
                if(empty($filtered))
                {   
                    $query .=" AND OrderDate BETWEEN '$datefrom' AND '$dateto' GROUP BY ORD
                    ORDER BY OrderDate";
                }
                else if($filtered == 'Container')
                {   
                    $query .=" AND OrderDate BETWEEN '$datefrom' AND '$dateto' GROUP BY ORD
                    ORDER BY OrderDate";
                }
                else if($filtered == 'controlno')
                {   
                    $query .=" AND ORD LIKE '%$key%' AND OrderDate BETWEEN '$datefrom' AND '$dateto' GROUP BY ORD
                    ORDER BY OrderDate";
                }
                else if($filtered == 'StatusID')
                {   
                    $query .=" AND StatusID LIKE '%$key%' AND OrderDate BETWEEN '$datefrom' AND '$dateto' GROUP BY ORD
                    ORDER BY OrderDate";
                }
            }
            
        }
        else
        {   
            $query .=" AND WarehouseID = $WarehouseID";

            if(empty($key))
            {   
                $query .=" AND OrderDate BETWEEN '$datefrom' AND '$dateto' GROUP BY ORD
                ORDER BY OrderDate";
            }
            else
            {   
                if(empty($filtered))
                {   
                    $query .=" AND OrderDate BETWEEN '$datefrom' AND '$dateto' GROUP BY ORD
                    ORDER BY OrderDate";
                }
                else if($filtered == 'Container')
                {   
                    $query .=" AND OrderDate BETWEEN '$datefrom' AND '$dateto' GROUP BY ORD
                    ORDER BY OrderDate";
                }
                else if($filtered == 'controlno')
                {   
                    $query .=" AND ORD LIKE '%$key%' AND OrderDate BETWEEN '$datefrom' AND '$dateto' GROUP BY ORD
                    ORDER BY OrderDate";
                }
                else if($filtered == 'StatusID')
                {   
                    $query .=" AND StatusID LIKE '%$key%' AND OrderDate BETWEEN '$datefrom' AND '$dateto' GROUP BY ORD
                    ORDER BY OrderDate";
                }
            }
        }
        // echo $datetotal;
        $result = mysqli_query($conn, $query);
        
        while ($rows = mysqli_fetch_row($result)) {

            $wgt = $rows[3] * $rows[7];
            $wgt = number_format((float)$wgt, 2);
            $wgt = floatval(preg_replace('/[^\d.]/', '', $wgt));

            $data[] = array(
                'recDate' => $rows[0],
                'controlno' => $rows[1],
                'ref' => $rows[2],
                'qty' => $rows[3],
                'wgt' => $wgt,
                'container' => '',
                'checker' => $rows[4],
                'status' => '<span style="color:red">'.$rows[5].'</span>',
                'remarks' => $rows[6]
            ); 
        }          

        $query = "SELECT 
                        PickingDate,
                        PCK,
                        SUM(Quantity),
                        SUM(Weight),
                        Container,
                        LastUpdatedBy,
                        StatusID,
                        PickingRemarks
                    FROM
                        wms_outbound.otreport_pck
                    WHERE
                        CustomerID = $CustomerID
                            ";
            if(empty($WarehouseID))
            {   
                if(empty($key))
                {   
                    $query .=" AND PickingDate BETWEEN '$datefrom' AND '$dateto' GROUP BY PCK
                    ORDER BY PickingDate";
                }
                else
                {   
                    if(empty($filtered))
                    {   
                        $query .=" AND PickingDate BETWEEN '$datefrom' AND '$dateto' GROUP BY PCK
                        ORDER BY PickingDate";
                    }
                    else if($filtered == 'Container')
                    {   
                        $query .=" AND Container LIKE '%$key%' AND PickingDate BETWEEN '$datefrom' AND '$dateto' GROUP BY PCK
                        ORDER BY PickingDate";
                    }
                    else if($filtered == 'controlno')
                    {   
                        $query .=" AND PCK LIKE '%$key%' AND PickingDate BETWEEN '$datefrom' AND '$dateto' GROUP BY PCK
                        ORDER BY PickingDate";
                    }
                    else if($filtered == 'StatusID')
                    {   
                        $query .=" AND StatusID LIKE '%$key%' AND PickingDate BETWEEN '$datefrom' AND '$dateto' GROUP BY PCK
                        ORDER BY PickingDate";
                    }
                }
                
            }
            else
            {   
                $query .=" AND WarehouseID = $WarehouseID";

                if(empty($key))
                {   
                    $query .=" AND PickingDate BETWEEN '$datefrom' AND '$dateto' GROUP BY PCK
                    ORDER BY PickingDate";
                }
                else
                {   
                    if(empty($filtered))
                    {   
                        $query .=" AND PickingDate BETWEEN '$datefrom' AND '$dateto' GROUP BY PCK
                        ORDER BY PickingDate";
                    }
                    else if($filtered == 'Container')
                    {   
                        $query .=" AND Container LIKE '%$key%' AND PickingDate BETWEEN '$datefrom' AND '$dateto' GROUP BY PCK
                        ORDER BY PickingDate";
                    }
                    else if($filtered == 'controlno')
                    {   
                        $query .=" AND PCK LIKE '%$key%' AND PickingDate BETWEEN '$datefrom' AND '$dateto' GROUP BY PCK
                        ORDER BY PickingDate";
                    }
                    else if($filtered == 'StatusID')
                    {   
                        $query .=" AND StatusID LIKE '%$key%' AND PickingDate BETWEEN '$datefrom' AND '$dateto' GROUP BY PCK
                        ORDER BY PickingDate";
                    }
                }
            }

            // echo $query;

            $result = mysqli_query($conn, $query);
            while ($rows = mysqli_fetch_row($result)) {
                    
            $wgt = number_format((float)$rows[3], 2);
            $wgt = floatval(preg_replace('/[^\d.]/', '', $wgt));

            $data[] = array(
                'recDate' => $rows[0],
                'controlno' => $rows[1],
                'ref' => '',
                'qty' => $rows[2],
                'wgt' => $wgt,
                'container' => $rows[4],
                'checker' => $rows[5],
                'status' =>'<span style="color:red">'.$rows[6].'</span>',
                'remarks' => $rows[7]
            ); 
        }          


        $query = "SELECT 
                        IssuanceDate,
                        OBD,
                        OtherRef,
                        IFNULL(Quantity, 0),
                        Weight,
                        Container,
                        Checker,
                        StatusID,
                        Remarks
                        FROM
                        wms_outbound.otreport_obd
                        WHERE
                            CustomerID = $CustomerID
                                ";
            if(empty($WarehouseID))
            {   
                if(empty($key))
                {   
                    $query .=" AND IssuanceDate BETWEEN '$datefrom' AND '$dateto' GROUP BY OBD
                    ORDER BY IssuanceDate";
                }
                else
                {   
                    if(empty($filtered))
                    {   
                        $query .=" AND IssuanceDate BETWEEN '$datefrom' AND '$dateto' GROUP BY OBD
                        ORDER BY IssuanceDate";
                    }
                    else if($filtered == 'Container')
                    {   
                        $query .=" AND Container LIKE '%$key%' AND IssuanceDate BETWEEN '$datefrom' AND '$dateto' GROUP BY OBD
                        ORDER BY IssuanceDate";
                    }
                    else if($filtered == 'controlno')
                    {   
                        $query .=" AND OBD LIKE '%$key%' AND IssuanceDate BETWEEN '$datefrom' AND '$dateto' GROUP BY OBD
                        ORDER BY IssuanceDate";
                    }
                    else if($filtered == 'StatusID')
                    {   
                        $query .=" AND StatusID LIKE '%$key%' AND IssuanceDate BETWEEN '$datefrom' AND '$dateto' GROUP BY OBD
                        ORDER BY IssuanceDate";
                    }
                }
                
            }
            else
            {   
                $query .=" AND WarehouseID = $WarehouseID";

                if(empty($key))
                {   
                    $query .=" AND IssuanceDate BETWEEN '$datefrom' AND '$dateto' GROUP BY OBD
                    ORDER BY IssuanceDate";
                }
                else
                {   
                    if(empty($filtered))
                    {   
                        $query .=" AND IssuanceDate BETWEEN '$datefrom' AND '$dateto' GROUP BY OBD
                        ORDER BY IssuanceDate";
                    }
                    else if($filtered == 'Container')
                    {   
                        $query .=" AND Container LIKE '%$key%' AND IssuanceDate BETWEEN '$datefrom' AND '$dateto' GROUP BY OBD
                        ORDER BY IssuanceDate";
                    }
                    else if($filtered == 'controlno')
                    {   
                        $query .=" AND OBD LIKE '%$key%' AND IssuanceDate BETWEEN '$datefrom' AND '$dateto' GROUP BY OBD
                        ORDER BY IssuanceDate";
                    }
                    else if($filtered == 'StatusID')
                    {   
                        $query .=" AND StatusID LIKE '%$key%' AND IssuanceDate BETWEEN '$datefrom' AND '$dateto' GROUP BY OBD
                        ORDER BY IssuanceDate";
                    }
                }
            }

            $result = mysqli_query($conn, $query);
            while ($rows = mysqli_fetch_row($result)) {
                    
            $wgt = number_format((float)$rows[4], 2);
            $wgt = floatval(preg_replace('/[^\d.]/', '', $wgt));

            $data[] = array(
                'recDate' => $rows[0],
                'controlno' => $rows[1],
                'ref' => $rows[2],
                'qty' => $rows[3],
                'wgt' => $wgt,
                'container' => $rows[5],
                'checker' => $rows[6],
                'status' => $rows[7],
                'remarks' => $rows[8]
            ); 
        }          

        // echo $query;
        echo json_encode($data);
        
    }

    function Report_GenerateDOR22($WarehouseID, $datefrom, $dateto, $CustomerID, $filtered, $key)
    {
            include ('dbcon.php');
            $date1=date_create($datefrom);
            $date2=date_create($dateto);
            $diff=date_diff($date1,$date2);
            $datetotal = $diff->format("%a");

            if($datetotal <= 2)
            {
                $datefrom = '2001-01-01T09:10';
                $dateto = '2031-01-01T09:10';
            }

            $query = "SELECT 
                        OrderDate,
                        ord.ORD,
                        pck.PCK,
                        iss.OBD,
                        iss.CustomerReference,
                        IFNULL(ordi.Quantity, 0) AS Quantity,
                        pl.Container,
                        iss.Checker,
                        ord.Remarks,
                        ord.StatusID AS ordStat,
                        pck.StatusID AS pckStat,
                        iss.StatusID AS obdStat,
                        item.Weight
                    FROM
                        wms_outbound.tbl_ordering ord
                            LEFT JOIN
                        wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
                            LEFT JOIN
                        wms_outbound.tbl_picking pck ON ord.ORD = pck.ORD
                            LEFT JOIN
                        wms_outbound.tbl_picklist pl ON pck.PCK = pl.PCK
                            LEFT JOIN
                        wms_outbound.tbl_issuancelist il ON pl.id = il.PicklistID
                            LEFT JOIN
                        wms_outbound.tbl_issuances iss ON il.OBD = iss.OBD
                            LEFT JOIN
                        wms_cloud.tbl_items item ON ordi.ItemID = item.ItemID
                            LEFT JOIN
                        wms_cloud.tbl_customers cus ON ord.CustomerID = cus.CustomerID
                    WHERE
                    ord.CustomerID = $CustomerID
                        AND OrderDate BETWEEN '$datefrom' AND '$dateto'
                    ";

            if(empty($WarehouseID))
            {
                if($filtered == 'controlno')
                {
                    $query .= "AND ord.ORD LIKE '%$key%' GROUP BY ord.ORD, pck.PCK, iss.OBD";
                }
                else if($filtered == 'Container')
                {
                    $query .= "AND pl.Container LIKE '%$key%' GROUP BY ord.ORD, pck.PCK, iss.OBD";
                }
                else if($filtered == 3)
                {
                    
                }
                else if(empty($filtered))
                {
                    $query .= "GROUP BY ord.ORD, pck.PCK, iss.OBD";
                }
            }
            else
            {
                $query .= "AND WarehouseID = $WarehouseID
                ";
                if($filtered == 'controlno')
                {
                    $query .= "AND (iss.OBD LIKE '%$key%' OR ord.ORD LIKE '%$key%' OR pck.PCK LIKE '%$key%') GROUP BY ord.ORD, pck.PCK, iss.OBD";
                }
                else if($filtered == 'Container')
                {
                    $query .= "AND pl.Container LIKE '%$key%' GROUP BY ord.ORD, pck.PCK, iss.OBD";
                }
                else if($filtered == 3)
                {
                    $query .= "GROUP BY ord.ORD, pck.PCK, iss.OBD";
                }
                else if(empty($filtered))
                {
                    $query .= "GROUP BY ord.ORD, pck.PCK, iss.OBD";
                }
            
            }

                $result = mysqli_query($conn, $query);
                $status = '';
                while ($rows = mysqli_fetch_row($result))
                {   
                    if(empty($rows[2]) && empty($rows[3]) && $rows[9] == 2 && empty($rows[10]) && empty($rows[11]))
                    {
                        $status = 'Order in Process';
                    }
                    else if((empty($rows[2]) || !empty($rows[2])) && empty($rows[3]) && $rows[9] == 3 && (empty($rows[10]) || $rows[10] == 2) && empty($rows[11]))
                    {
                        $status = 'For Picking';
                    }
                    else if(!empty($rows[2]) && empty($rows[3]) && $rows[9] == 3 && $rows[10] == 3 && empty($rows[11]))
                    {
                        $status = 'Picked';
                    }
                    else if(!empty($rows[2]) && !empty($rows[3]) && $rows[9] == 3 && $rows[10] == 3 && $rows[11] == 2)
                    {
                        $status = 'For Dispatch';
                    }
                    else if(!empty($rows[2]) && !empty($rows[3]) && $rows[9] == 3 && $rows[10] == 3 && $rows[11] == 3)
                    {
                        $status = 'In Transit';
                    }
                    else if(!empty($rows[2]) && empty($rows[3]) && $rows[9] == 3 && $rows[10] == 4 && empty($rows[11]))
                    {
                        $status = 'Cancel PCK';
                    }

                    $wgt = $rows[12] * $rows[5];
                    $wgt = number_format((float)$wgt, 2);

                    $data[] = array(
                        'recDate' => $rows[0],
                        'controlord' => $rows[1],
                        'controlpck' => $rows[2],
                        'controlobd' => $rows[3],
                        'ref' => $rows[4],
                        'qty' => $rows[5],
                        'wgt' => $wgt,
                        'container' => $rows[6],
                        'checker' => $rows[7],
                        'status' => $status ,
                        'remarks' => $rows[8]

                    ); 
                    
                }

                echo json_encode($data);
                // echo $query; 
    }

    function Report_GenerateDOR2($WarehouseID, $datefrom, $dateto, $CustomerID, $filtered, $key)
    {
            include ('dbcon.php');
            
            $query = "SELECT
                        LEFT(A.OrderDate, 10) AS ORDDate,
                        A.ORD,
                        D.PCK,
                        F.OBD,
                        F.CustomerReference,
                        (SELECT SUM(Quantity) FROM wms_outbound.tbl_orderingitems WHERE ORD = A.ORD) AS ORDQTY,
                        F.Container,
                        F.Checker,
                        F.Remarks,
                        A.StatusID AS ORDStatusID,
                        D.StatusID AS PCKStatusID,
                        F.StatusID AS OBDStatusID,
                        Z.Weight,
                        SUM(Z.Length * Z.Width *Z. Height)/1000000,
                        B.CompanyName,
                        (SELECT COUNT(Receivingitemid) FROM wms_outbound.tbl_issuancelist WHERE OBD = F.OBD) AS ActualQuantity,
                        (SELECT IFNULL(SUM(Beg_Weight) , 0)
                            FROM wms_outbound.tbl_issuancelist A
                            LEFT JOIN wms_inbound.tbl_receivingitems B ON A.ReceivingItemID = B.ReceivingItemID
                            WHERE OBD = F.OBD) AS ActualQuantity,
                        CPO
                        FROM wms_outbound.tbl_ordering A
                        LEFT JOIN wms_cloud.tbl_customers B ON A.CustomerID = B.CustomerID
                        LEFT JOIN wms_outbound.tbl_orderingitems C ON A.ORD = C.ORD
                        LEFT JOIN wms_outbound.tbl_picking D ON A.ORD = D.ORD
                        LEFT JOIN wms_outbound.tbl_issuancelist E ON D.PCK = E.PCK
                        LEFT JOIN wms_outbound.tbl_issuances F ON E.OBD = F.OBD
                        LEFT JOIN wms_cloud.tbl_items Z ON C.ItemID = Z.ItemID
                    WHERE A.StatusID != 4 AND
                ";

            if(!empty($CustomerID))
            {
                $query .= "A.CustomerID = $CustomerID
                           AND LEFT(A.OrderDate, 10) BETWEEN '$datefrom' AND '$dateto'
                          ";
            }
            else
            {
                $query .= "LEFT(A.OrderDate, 10) BETWEEN '$datefrom' AND '$dateto'
                ";
            }

            

            $query .= "GROUP BY A.ORD, D.PCK, E.OBD
                ORDER BY A.ORD DESC";

                $result = mysqli_query($conn, $query);
                $status = '';
                
                if(mysqli_num_rows($result) > 0)
                {
                    while ($rows = mysqli_fetch_row($result))
                    {   


                        if(empty($rows[2]) && empty($rows[3]) && ($rows[9] == 2 ||$rows[9] == 1) && empty($rows[10]) && empty($rows[11]))
                        {
                            $status = 'Order in Process';
                        }
                        else if((empty($rows[2]) || !empty($rows[2])) && empty($rows[3]) && $rows[9] == 3 && (empty($rows[10]) || $rows[10] == 2 || $rows[10] == 1) && empty($rows[11]))
                        {
                            $status = 'For Picking';
                        }
                        else if(!empty($rows[2]) && empty($rows[3]) && $rows[9] == 3 && ($rows[10] == 3 || $rows[10] == 5) && empty($rows[11]))
                        {
                            $status = 'Picked';
                        }
                        else if(!empty($rows[2]) && !empty($rows[3]) && $rows[9] == 3 && ($rows[10] == 3 || $rows[10] == 5) && $rows[11] == 2)
                        {
                            $status = 'For Dispatch';
                        }
                        else if(!empty($rows[2]) && !empty($rows[3]) && $rows[9] == 3 && $rows[10] == 3 && $rows[11] == 3)
                        {
                            $status = 'In Transit';
                        }
                        else
                        {
                            $status = 'In Transit';
                        }


                        if($rows[10] == 4 || $rows[10] == 6)
                        {
                            $status = 'Cancel PCK';
                        }

                        if($rows[11] == 6)
                        {
                            $status = 'Delivered';
                        }
                        
                        if(empty($rows[11]) || $rows[11] < 3)
                        {
                            $disabled = 'disabled';
                            $btn = 'btn btn-warning';
                            $btnprint = 'btn btn-warning';
                        }
                        else
                        {
                            $disabled = '';
                            $btn = 'btn btn-primary';
                            $btnprint = 'btn btn-primary';
                        }

                       
                        
                        $IssuanceDate = strtotime($rows[0]);
                        $IssuanceDate = date('d-M-Y',$IssuanceDate);

                        if($rows[11] >= 2)
                        {
                            

                            if($rows[15] != $rows[5])
                            {
                                $wgt = $rows[12] * $rows[5];
                                $wgt = number_format((float)$wgt, 3);
                            }
                            else
                            {
                                $wgt = $rows[16];
                                $wgt = number_format((float)$wgt, 3);
                            }
                        }
                        else
                        {
                            $wgt = $rows[12] * $rows[5];
                            $wgt = number_format((float)$wgt, 3);
                        }

                        if(empty($rows[17]))
                        {
                            $cpo = '-';
                        }
                        else
                        {
                            $cpo = $rows[17];
                        }
                        $data[] = array(
                            'recDate' => $IssuanceDate,
                            'cpo' => $cpo,
                            'ref' => '',
                            'qty' => $rows[5],
                            'wgt' => $wgt,
                            'container' => $rows[6],
                            'status' => $status,
                            'remarks' => $rows[8]

                        );
                        
                    }
                }
                else
                {
                    $data[] = array(
                        'recDate' => 'No Data Found!',
                        // 'controlord' => $rows[1],
                        'cpo' => '',
                        'ref' => '',
                        'qty' => '',
                        'wgt' => '',
                        'container' => '',
                        'status' => '',
                        'remarks' => ''

                    );
                }

                echo json_encode($data);
                // echo $query; 
    }

    function ageing_report($CustomerID, $WarehouseID)
    {
        include ('dbcon.php');
        $query = "SELECT
                    ItemCode,
                    Client_SKU,
                    ItemDesc,
                    UOM_abv,
                    SUM(ri.Quantity),
                    SUM(ri.Weight),
                    CASE
                        WHEN LEFT(ExpiryDate, 10) = '0000-00-00' THEN 'No Expiry'
                        WHEN ExpiryDate IS NULL THEN 'No Expiry'
                        ELSE LEFT(ExpiryDate, 10)
                    END ExpiryDatee,
                    Container,
                    Batch,
                    IF(OtherReference IS NULL OR OtherReference = '', 'NONE', OtherReference) AS OtherReference,
                    CASE
                        WHEN DATEDIFF(ExpiryDate,CURDATE()) < 1 THEN 'Expired'
                        WHEN DATEDIFF(ExpiryDate,CURDATE()) > 1 THEN DATEDIFF(ExpiryDate,CURDATE())
                        WHEN LEFT(ExpiryDate, 10) IS NULL THEN 'No Expiry'
                    END
                FROM wms_inbound.tbl_receivingitems ri
                LEFT JOIN wms_cloud.tbl_items item ON ri.ItemId = item.ItemID
                LEFT JOIN wms_cloud.tbl_weightuom uom ON item.UOMID = uom.UOMID
                LEFT JOIN wms_inbound.tbl_receiving r ON ri.IBN = r.IBN AND ri.isout = 0
                LEFT JOIN wms_cloud.tbl_customers cus on ri.CustomerID = cus.CustomerID
                WHERE Quantity > 0 AND Checked = 'True'
                AND ri.CustomerID = $CustomerID AND (ForPutaway = 0 OR ForPutaway >= 2) AND r.StatusID != 5
                ";

        if(empty($WarehouseID))
        {
            $query .= "GROUP BY ri.ItemID, ExpiryDate, Container, Batch
                        ORDER BY ExpiryDatee ASC";
        }
        else
        {
            $query .= "AND cus.WarehouseID = $WarehouseID
            GROUP BY ri.ItemID, ExpiryDate, Container, Batch
            ORDER BY ExpiryDatee ASC";
        }

        $res = mysqli_query($conn, $query);
        
        if(mysqli_num_rows($res) < 1)
        {
            $data[] = array(
                'sku'   => 'No Data Found',
                'item'   => '',
                'oum'   => '',
                'qty'   => '',
                'wgt'   => '',
                'cvnumber'   => '',
                'otherref'   => '',
                'batch'   => '',
                'expirydate'   => '',
                'expiring'   => '',
                );

            echo json_encode($data);
        }
        else
        {
            while($rows = mysqli_fetch_array($res))
            {

                if(empty($rows[1]))
                {
                    $itemcode = $rows[0];
                    $itemcode = '<span style="color:red">*(' .$itemcode. ')*</span>';
                }
                else
                {
                    $itemcode = $rows[1];
                }

                $expiry = $rows[6];
                $expiry = strtotime($rows[6]);
                $expiry = date('d-M-Y', $expiry);

                $wgt = number_format((float)$rows[5], 2);
                $wgt = floatval(preg_replace('/[^\d.]/', '', $wgt));

                $qty = number_format((float)$rows[4], 0);
                
                if($rows[6] == 'No Expiry')
                {
                    $expiry = '';
                }

                $data[] = array(
                'sku'   => $itemcode,
                'item'   => $rows[2],
                'oum'   => $rows[3],
                'qty'   => $qty,
                'wgt'   => $wgt,
                'cvnumber'   => $rows[7],
                'otherref'   => $rows[9],
                'batch'   => $rows[8],
                'expirydate'   => $expiry,
                'expiring'   => $rows[10]
                );

            }

            echo json_encode($data);
        }
    }

    function filteredAgeing($filtered, $CustomerID, $WarehouseID)
    {
        include ('dbcon.php');
        $query = "SELECT
                    ItemCode,
                    Client_SKU,
                    ItemDesc,
                    UOM_abv,
                    SUM(ri.Quantity),
                    SUM(ri.Weight),
                    CASE
                        WHEN LEFT(ExpiryDate, 10) = '0000-00-00' THEN 'No Expiry'
                        WHEN ExpiryDate IS NULL THEN 'No Expiry'
                        ELSE LEFT(ExpiryDate, 10)
                    END ExpiryDatee,
                    Container,
                    Batch,
                    IF(OtherReference IS NULL OR OtherReference = '', 'NONE', OtherReference) AS OtherReference,
                    CASE
                        WHEN DATEDIFF(ExpiryDate,CURDATE()) < 1 THEN 'Expired'
                        WHEN DATEDIFF(ExpiryDate,CURDATE()) > 1 THEN DATEDIFF(ExpiryDate,CURDATE())
                        WHEN LEFT(ExpiryDate, 10) IS NULL THEN 'No Expiry'
                    END
                FROM wms_inbound.tbl_receivingitems ri
                LEFT JOIN wms_cloud.tbl_items item ON ri.ItemId = item.ItemID
                LEFT JOIN wms_cloud.tbl_weightuom uom ON item.UOMID = uom.UOMID
                LEFT JOIN wms_inbound.tbl_receiving r ON ri.IBN = r.IBN AND ri.isout = 0
                LEFT JOIN wms_cloud.tbl_customers cus on ri.CustomerID = cus.CustomerID
                WHERE Quantity > 0 AND Checked = 'True'
                AND ri.CustomerID = $CustomerID AND (ForPutaway = 0 OR ForPutaway >= 2)
                ";

        if(empty($WarehouseID))
        {

            if($filtered == 'container')
            {
                $query .= "GROUP BY ri.ItemID, ExpiryDate, Container, Batch
                ORDER BY Container";
            }
            else if($filtered == 'batch')
            {
                $query .= "GROUP BY ri.ItemID, ExpiryDate, Container, Batch
                ORDER BY Batch";
            }
            else if($filtered == 'ref')
            {
                $query .= "GROUP BY ri.ItemID, ExpiryDate, Container, Batch
                ORDER BY OtherReference";
            }

        }

        else if(!empty($WarehouseID))
        {
            $query .= "AND cus.WarehouseID = $WarehouseID
            ";

            if($filtered == 'container')
            {
                $query .= "GROUP BY ri.ItemID, ExpiryDate, Container, Batch
                ORDER BY Container";
            }
            else if($filtered == 'batch')
            {
                $query .= "GROUP BY ri.ItemID, ExpiryDate, Container, Batch
                ORDER BY Batch";
            }
            else if($filtered == 'ref')
            {
                $query .= "GROUP BY ri.ItemID, ExpiryDate, Container, Batch
                ORDER BY OtherReference";
            }

        }

        $res = mysqli_query($conn, $query);
        
        if(mysqli_num_rows($res) < 1)
        {
            $data[] = array(
                'sku'   => 'No Data Found',
                'item'   => '',
                'oum'   => '',
                'qty'   => '',
                'wgt'   => '',
                'cvnumber'   => '',
                'otherref'   => '',
                'batch'   => '',
                'expirydate'   => '',
                'expiring'   => '',
                );

            echo json_encode($data);
        }
        else
        {
            while($rows = mysqli_fetch_array($res))
            {

                if(empty($rows[1]))
                {
                    $itemcode = $rows[0];
                    $itemcode = '<span style="color:red">*(' .$itemcode. ')*</span>';
                }
                else
                {
                    $itemcode = $rows[1];
                }

                $expiry = $rows[6];
                $expiry = strtotime($rows[6]);
                $expiry = date('d-M-Y', $expiry);

                $wgt = number_format((float)$rows[5], 2);
                $wgt = floatval(preg_replace('/[^\d.]/', '', $wgt));

                $qty = number_format((float)$rows[4], 0);
                
                if($rows[6] == 'No Expiry')
                {
                    $expiry = '';
                }

                $data[] = array(
                'sku'   => $itemcode,
                'item'   => $rows[2],
                'oum'   => $rows[3],
                'qty'   => $qty,
                'wgt'   => $wgt,
                'cvnumber'   => $rows[7],
                'otherref'   => $rows[9],
                'batch'   => $rows[8],
                'expirydate'   => $expiry,
                'expiring'   => $rows[10]
                );

            }

            echo json_encode($data);
        }
    }

    function searchAgeing($filtered, $key, $CustomerID, $WarehouseID)
    {
        include ('dbcon.php');
        $query = "SELECT
                    ItemCode,
                    Client_SKU,
                    ItemDesc,
                    UOM_abv,
                    SUM(ri.Quantity),
                    SUM(ri.Weight),
                    CASE
                        WHEN LEFT(ExpiryDate, 10) = '0000-00-00' THEN 'No Expiry'
                        WHEN ExpiryDate IS NULL THEN 'No Expiry'
                        ELSE LEFT(ExpiryDate, 10)
                    END ExpiryDatee,
                    Container,
                    Batch,
                    IF(OtherReference IS NULL OR OtherReference = '', 'NONE', OtherReference) AS OtherReference,
                    CASE
                        WHEN DATEDIFF(ExpiryDate,CURDATE()) < 1 THEN 'Expired'
                        WHEN DATEDIFF(ExpiryDate,CURDATE()) > 1 THEN DATEDIFF(ExpiryDate,CURDATE())
                        WHEN LEFT(ExpiryDate, 10) IS NULL THEN 'No Expiry'
                    END
                FROM wms_inbound.tbl_receivingitems ri
                LEFT JOIN wms_cloud.tbl_items item ON ri.ItemId = item.ItemID
                LEFT JOIN wms_cloud.tbl_weightuom uom ON item.UOMID = uom.UOMID
                LEFT JOIN wms_inbound.tbl_receiving r ON ri.IBN = r.IBN AND ri.isout = 0
                LEFT JOIN wms_cloud.tbl_customers cus on ri.CustomerID = cus.CustomerID
                WHERE Quantity > 0 AND Checked = 'True'
                AND ri.CustomerID = $CustomerID AND (ForPutaway = 0 OR ForPutaway >= 2)
                ";

        if(empty($WarehouseID))
        {

            if($filtered == 'container')
            {   
                if(empty($key))
                {
                    $query .= "GROUP BY ri.ItemID, ExpiryDate, Container, Batch
                            ORDER BY Container";
                }
                else
                {
                    $query .= " AND Container LIKE '%$key%'
                                GROUP BY ri.ItemID, ExpiryDate, Container, Batch
                                ORDER BY Container";
                }
                
            }
            else if($filtered == 'batch')
            {
                if(empty($key))
                {
                    $query .= "GROUP BY ri.ItemID, ExpiryDate, Container, Batch
                            ORDER BY Batch";
                }
                else
                {
                    $query .= " AND Batch LIKE '%$key%'
                                GROUP BY ri.ItemID, ExpiryDate, Container, Batch
                                ORDER BY Batch";
                }
            }
            else if($filtered == 'ref')
            {
                if(empty($key))
                {
                    $query .= "GROUP BY ri.ItemID, ExpiryDate, Container, Batch
                            ORDER BY OtherReference";
                }
                else
                {
                    $query .= " AND OtherReference LIKE '%$key%'
                                GROUP BY ri.ItemID, ExpiryDate, Container, Batch
                                ORDER BY OtherReference";
                }
            }

        }

        else if(!empty($WarehouseID))
        {
            $query .= "AND cus.WarehouseID = $WarehouseID
            ";

            if($filtered == 'container')
            {   
                if(empty($key))
                {
                    $query .= "GROUP BY ri.ItemID, ExpiryDate, Container, Batch
                            ORDER BY Container";
                }
                else
                {
                    $query .= " AND Container LIKE '%$key%'
                                GROUP BY ri.ItemID, ExpiryDate, Container, Batch
                                ORDER BY Container";
                }
                
            }
            else if($filtered == 'batch')
            {
                if(empty($key))
                {
                    $query .= "GROUP BY ri.ItemID, ExpiryDate, Container, Batch
                            ORDER BY Batch";
                }
                else
                {
                    $query .= " AND Batch LIKE '%$key%'
                                GROUP BY ri.ItemID, ExpiryDate, Container, Batch
                                ORDER BY Batch";
                }
            }
            else if($filtered == 'ref')
            {
                if(empty($key))
                {
                    $query .= "GROUP BY ri.ItemID, ExpiryDate, Container, Batch
                            ORDER BY OtherReference";
                }
                else
                {
                    $query .= " AND OtherReference LIKE '%$key%'
                                GROUP BY ri.ItemID, ExpiryDate, Container, Batch
                                ORDER BY OtherReference";
                }
            }

        }

        $res = mysqli_query($conn, $query);
        
        if(mysqli_num_rows($res) < 1)
        {
            $data[] = array(
                'sku'   => 'No Data Found',
                'item'   => '',
                'oum'   => '',
                'qty'   => '',
                'wgt'   => '',
                'cvnumber'   => '',
                'otherref'   => '',
                'batch'   => '',
                'expirydate'   => '',
                'expiring'   => '',
                );

            echo json_encode($data);
        }
        else
        {
            while($rows = mysqli_fetch_array($res))
            {

                if(empty($rows[1]))
                {
                    $itemcode = $rows[0];
                    $itemcode = '<span style="color:red">*(' .$itemcode. ')*</span>';
                }
                else
                {
                    $itemcode = $rows[1];
                }

                $expiry = $rows[6];
                $expiry = strtotime($rows[6]);
                $expiry = date('d-M-Y', $expiry);

                $wgt = number_format((float)$rows[5], 2);
                $wgt = floatval(preg_replace('/[^\d.]/', '', $wgt));

                $qty = number_format((float)$rows[4], 0);
                
                if($rows[6] == 'No Expiry')
                {
                    $expiry = '';
                }

                $data[] = array(
                'sku'   => $itemcode,
                'item'   => $rows[2],
                'oum'   => $rows[3],
                'qty'   => $qty,
                'wgt'   => $wgt,
                'cvnumber'   => $rows[7],
                'otherref'   => $rows[9],
                'batch'   => $rows[8],
                'expirydate'   => $expiry,
                'expiring'   => $rows[10]
                );

            }

            echo json_encode($data);
        }
    }

    function Report_GenerateDTR($datefrom, $dateto, $CustomerID)
    {
        include ('dbcon.php');
        $data = "";
        $starttime = 'T00:00:01';
        $endtime = 'T23:59:59';


        $query_in = "SELECT 
                        B.Date_created,
                        A.CPI,
                        Client_SKU,
                        ItemCode,
                        ItemDesc,
                        IFNULL(A.Beg_Quantity,0),
                        IFNULL(A.Beg_Weight, 0),
                        C.Container,
                        C.Remarks
                    FROM wms_clientportal.tbl_inbounditems A
                    LEFT JOIN wms_clientportal.tbl_inbound B ON A.CPI = B.CPI
                    LEFT JOIN wms_inbound.tbl_receiving C ON A.CPI = C.ASN
                    LEFT JOIN wms_cloud.tbl_items D ON A.ItemID = D.ItemID
                    ";
        $start = date('Y-m-d');           
        $start1 = date('Y-m-d', strtotime($start. ' + 0 days'));
        if(empty($datefrom) && empty($dateto))
        {
            $query_in .= "WHERE LEFT(Date_created, 10) = '$start1' AND B.CusID = $CustomerID";
        }
        else
        {
            $query_in .= "WHERE Date_created BETWEEN '$datefrom$starttime' AND '$dateto$endtime' AND B.CusID = $CustomerID";
        }
        // echo $query_in;
        $data = array(); 
        $data_in = array();
        $data_out = array();
        $result = mysqli_query($conn, $query_in);
        $qty = 0;
        if(mysqli_num_rows($result) < 1)
        {
            $data_in[] = array(
                'recDate' => 'No Data Found!',
                'controlno' => '',
                'ref' =>  '',
                'sku' => '',
                'desc' => '',
                'qty' => $qty,
                'wgt' => '',
                'container' => '',
                'remarks' => '',

            ); 
        }
        else
        {
            while($rows = mysqli_fetch_array($result))
            {   
                if(empty($rows[2]))
                {
                    $itemcode = $rows[3];
                    $itemcode = '<span style="color:red">*(' .$itemcode. ')*</span>';
                }
                else
                {
                    $itemcode = $rows[2];
                }

                $data_in[] = array(
                    'recDate' => $rows[0],
                    'controlno' => $rows[1],
                    'ref' =>  $rows[1],
                    'sku' => $itemcode,
                    'desc' => $rows[4],
                    'qty' => $rows[5],
                    'wgt' => $rows[6],
                    'container' => $rows[7],
                    'remarks' => $rows[8]

                ); 
            }
        }
        

            

        $start = date('Y-m-d');           
        $start1 = date('Y-m-d', strtotime($start. ' + 0 days'));

        if(empty($datefrom) && empty($dateto))
        {
            $query = "
                SELECT
                                LEFT(A.OrderDate, 10) AS ORDDate,
                                CPO,
                                Z.ItemCode,
                                Z.ItemDesc,
                                (SELECT SUM(Quantity) FROM wms_outbound.tbl_orderingitems WHERE ORD = A.ORD),
                                Z.Weight,
                                F.Container,
                                F.Remarks
                                FROM wms_outbound.tbl_ordering A
                                LEFT JOIN wms_cloud.tbl_customers B ON A.CustomerID = B.CustomerID
                                LEFT JOIN wms_outbound.tbl_orderingitems C ON A.ORD = C.ORD
                                LEFT JOIN wms_outbound.tbl_picking D ON A.ORD = D.ORD
                                LEFT JOIN wms_outbound.tbl_issuancelist E ON D.PCK = E.PCK
                                LEFT JOIN wms_outbound.tbl_issuances F ON E.OBD = F.OBD
                                LEFT JOIN wms_cloud.tbl_items Z ON C.ItemID = Z.ItemID
                            WHERE
                    A.CustomerID = $CustomerID
                    AND LEFT(A.OrderDate, 10) = '$start1' AND CPO IS NOT NULL
                ";
        }
        else
        {
            $query = "
                SELECT
                                LEFT(A.OrderDate, 10) AS ORDDate,
                                CPO,
                                Z.ItemCode,
                                Z.ItemDesc,
                                (SELECT SUM(Quantity) FROM wms_outbound.tbl_orderingitems WHERE ORD = A.ORD),
                                Z.Weight,
                                F.Container,
                                F.Remarks
                                FROM wms_outbound.tbl_ordering A
                                LEFT JOIN wms_cloud.tbl_customers B ON A.CustomerID = B.CustomerID
                                LEFT JOIN wms_outbound.tbl_orderingitems C ON A.ORD = C.ORD
                                LEFT JOIN wms_outbound.tbl_picking D ON A.ORD = D.ORD
                                LEFT JOIN wms_outbound.tbl_issuancelist E ON D.PCK = E.PCK
                                LEFT JOIN wms_outbound.tbl_issuances F ON E.OBD = F.OBD
                                LEFT JOIN wms_cloud.tbl_items Z ON C.ItemID = Z.ItemID
                            WHERE
                    A.CustomerID = $CustomerID
                    AND LEFT(A.OrderDate, 10) BETWEEN '$datefrom$starttime' AND '$dateto$endtime' AND CPO IS NOT NULL
                ";
        }
        $result = mysqli_query($conn, $query);
        while ($rows = mysqli_fetch_row($result))
        {
            $IssuanceDate = strtotime($rows[0]);
            $IssuanceDate = date('d-M-Y H:m:s',$IssuanceDate);
            $wgt_out = number_format((float)$rows[5], 2);
            $wgt_out = floatval(preg_replace('/[^\d.]/', '', $wgt_out));
        
        $data_out[] = array(
                'recDate' => $IssuanceDate,
                'controlno' => $rows[1],
                'ref' => '',
                'sku' => $rows[2],
                'desc' => $rows[3],
                'qty' => $rows[4],
                'wgt' => $wgt_out,
                'container' => $rows[6],
                'remarks' => $rows[7]
        );
        }

        $data = array_merge($data_out, $data_in);

        echo json_encode($data);
    }

    
    function Report_GenerateGM($CustomerID, $ItemID, $SubFilter, $Co_SubFilter, $datefrom, $dateto)
        {
            include ('dbcon.php');
            $timein = 'T00:00:01';
            $timeout = 'T23:59:59';

            $total_qty_begining = 0;
            $total_qty_outbound  = 0;
            $total_weight_begining = 0;
            $total_weight_outbound  = 0;
            $total_qty_inbound = 0; 
            $total_weight_inbound = 0;
            $query_item = "
                        SELECT  
                        Client_SKU,
                        ItemCode,
                        wms_cloud.tbl_items.ItemDesc
                        FROM wms_cloud.tbl_items
                        WHERE wms_cloud.tbl_items.ItemID = $ItemID
                        GROUP BY wms_cloud.tbl_items.ItemID";
            $result = mysqli_query($conn, $query_item);

            while($rows = mysqli_fetch_array($result))
            {   
                if(empty($rows[0]))
                {
                    $itemname = '<span style="color:red"> *'.  $rows[1] .'</span> - '.  $rows[2] ;
                }
                else
                {
                    $itemname = $rows[0] .' - '.  $rows[2];
                }
                echo '
                    <tr class="thead">
                       <td style="border:1px solid black;" colspan="10"><h3 style="text-align:center;">'.$itemname.'</h3></td>
                    </tr>
                ';
            }

            echo '
                <tr class="thead1">
                    <td class="text-uppercase" style="border:1px solid black;"></td>
                    <td class="text-uppercase" style="border:1px solid black;" colspan="2" style="text-align:center">Inbound</td>
                    <td class="text-uppercase" style="border:1px solid black;" colspan="2" style="text-align:center">Outbound</td>
                    <td class="text-uppercase" style="border:1px solid black;"></td>
                    <td class="text-uppercase" style="border:1px solid black;"></td>
                    <td class="text-uppercase" style="border:1px solid black;"></td>
                    <td class="text-uppercase" style="border:1px solid black;"></td>
                    <td class="text-uppercase" style="border:1px solid black;"></td>
                </tr>
                <tr>
                    <td class="text-uppercase" style="border:1px solid black;" width="5%"></td>
                    <td class="text-uppercase" style="border:1px solid black;" width="5%" style="widtd: 15%">Quantity</td>
                    <td class="text-uppercase" style="border:1px solid black;" width="5%" style="widtd: 15%">Weight</td>
                    <td class="text-uppercase" style="border:1px solid black;" width="5%">Quantity</td>
                    <td class="text-uppercase" style="border:1px solid black;" width="5%">Weight</td>
                    <td class="text-uppercase" style="border:1px solid black;" width="10%">Control Number</td>
                    <td class="text-uppercase" style="border:1px solid black;" width="10%">CV Number</td>
                    <td class="text-uppercase" style="border:1px solid black;" width="10%">Batch</td>
                    <td class="text-uppercase" style="border:1px solid black;" width="10%">Other Reference</td>
                    <td class="text-uppercase" style="border:1px solid black;" width="10%">Date</td>
                </tr>
            ';
            $gm_date = date('Y-m-d',(strtotime ( '-1 day' , strtotime ( $datefrom) ) ));

            $query_beginning = "SELECT
                            ri.CustomerID,
                            ri.ReceivingItemID,
                            ri.ItemID,
                            SUM(ri.Beg_Quantity),
                            SUM(ri.Beg_Weight),
                            ri.IBN,
                            item.ItemDesc,
                            r.ReceivingDate,
                            r.Container,
                            ri.Batch,
                            r.OtherReference,
                            wgt.UOM_Abv
                            FROM wms_inbound.tbl_receivingitems ri
                            LEFT JOIN wms_inbound.tbl_receiving r ON ri.IBN = r.IBN
                            LEFT JOIN wms_cloud.tbl_items item ON ri.ItemID = item.ItemID
                            LEFT JOIN wms_cloud.tbl_weightuom wgt ON item.UOMID = wgt.UOMID
                            WHERE ri.CustomerID = $CustomerID AND ri.ItemID = $ItemID
                            AND LEFT(r.ReceivingDate, 10) BETWEEN '2000-01-01' AND '$gm_date' AND Checked = 'True' AND (ForPutaway = 0 OR ForPutaway >= 2) AND r.StatusID != 5
                            ";

                if($SubFilter == null || $SubFilter == '')
                {
                    $query_beginning .= "GROUP BY r.Container
                    ORDER BY r.ReceivingDate ASC";
                }
                else if($SubFilter == 1)
                {
                    if($Co_SubFilter == 'all')
                    {
                        $query_beginning .= "GROUP BY r.Container
                        ORDER BY r.ReceivingDate ASC";
                    }
                    else
                    {
                        $query_beginning .= "AND Container = '$Co_SubFilter'
                        r.Container
                        ORDER BY r.ReceivingDate ASC";
                    }
                }


                else if($SubFilter == 2)
                {
                    if($Co_SubFilter == 'all')
                    {
                        $query_beginning .= "GROUP BY r.Container
                        ORDER BY r.ReceivingDate ASC";
                    }
                    else
                    {
                         $query_beginning .= "AND Batch = '$Co_SubFilter'
                                            GROUP BY r.Container
                                            ORDER BY r.ReceivingDate ASC";
                    }
                }

                else if($SubFilter == 3)
                {
                      if($Co_SubFilter == 'all')
                    {
                        $query_beginning .= "GROUP BY r.Container
                        ORDER BY r.ReceivingDate ASC";
                    }
                    else
                    {
                        $query_beginning .= "AND ExpiryDate = '$Co_SubFilter'
                        GROUP BY r.Container
                        ORDER BY r.ReceivingDate ASC";
                    }
                }
                else if($SubFilter == 4)
                {
                    if($Co_SubFilter == 'all')
                    {
                        $query_beginning .= "GROUP BY r.Container";
                    }
                    else if($Co_SubFilter == 'no_or')
                    {
                        $query_beginning .= "AND (OtherReference IS NULL OR OtherReference = '')
                        GROUP BY ri.ItemID";
                    }
                    else
                    {
                        $query_beginning .= "AND ReceivingID = '$Co_SubFilter'
                        GROUP BY r.Container";
                    }
                }

                $result = mysqli_query($conn, $query_beginning);

                

                while($rows = mysqli_fetch_array($result))
                {   

                    
                     $total_qty_begining = $total_qty_begining + $rows[3];
                     $total_weight_begining = $total_weight_begining + $rows[4];

                     $gm_date = date('d-M-Y',(strtotime ( '-1 day' , strtotime ( $datefrom) ) ));

                     $oum = $rows[11];
                    echo '
                            <tr>
                                <td style="border:1px solid black;"></td>
                                <td style="border:1px solid black;">'.number_format($rows[3]).'</td>
                                <td style="border:1px solid black;">'.number_format((float)$rows[4], 2).'</td>
                                <td style="border:1px solid black;"></td>
                                <td style="border:1px solid black;"></td>
                                <td style="border:1px solid black;">Begining</td>
                                <td style="border:1px solid black;">'.$rows[8].'</td>
                                <td style="border:1px solid black;">'.$rows[9].'</td>
                                <td style="border:1px solid black;">'.$rows[10].'</td>
                                <td style="border:1px solid black;">'.$gm_date.'</td>
                            </tr>
                    ';
                } 

                $query_inbound = "SELECT
                            ri.CustomerID,
                            ri.ReceivingItemID,
                            ri.ItemID,
                            SUM(ri.Beg_Quantity),
                            SUM(ri.Beg_Weight),
                            ri.IBN,
                            item.ItemDesc,
                            r.ReceivingDate,
                            r.Container,
                            ri.Batch,
                            r.OtherReference,
                            wgt.UOM_Abv
                            FROM wms_inbound.tbl_receivingitems ri
                            LEFT JOIN wms_inbound.tbl_receiving r ON ri.IBN = r.IBN
                            LEFT JOIN wms_cloud.tbl_items item ON ri.ItemID = item.ItemID
                            LEFT JOIN wms_cloud.tbl_weightuom wgt ON item.UOMID = wgt.UOMID
                            WHERE ri.CustomerID = $CustomerID AND ri.ItemID = $ItemID
                            AND LEFT(r.ReceivingDate, 10) BETWEEN '$datefrom' AND '$dateto' AND Checked = 'True' AND (ForPutaway = 0 OR ForPutaway >= 2)
                            AND r.StatusID != 5
                            
                            ";
                if($SubFilter == null || $SubFilter == '')
                {
                    $query_inbound .= "GROUP BY ri.IBN, ri.ItemID
                    ORDER BY r.ReceivingDate ASC";
                }
                else if($SubFilter == 1)
                {
                    if($Co_SubFilter == 'all')
                    {
                        $query_inbound .= "GROUP BY ri.IBN, r.Container
                        ORDER BY r.ReceivingDate ASC";
                    }
                    else
                    {
                        $query_inbound .= "AND Container = '$Co_SubFilter'
                        GROUP BY ri.IBN, r.Container
                        ORDER BY r.ReceivingDate ASC";
                    }
                }

                else if($SubFilter == 2)
                {
                    if($Co_SubFilter == 'all')
                    {
                        $query_inbound .= "GROUP BY ri.IBN, r.Container
                        ORDER BY r.ReceivingDate ASC";
                    }
                    else
                    {
                         $query_inbound .= "AND Batch = '$Co_SubFilter'
                                            GROUP BY ri.IBN, r.Container
                                            ORDER BY r.ReceivingDate ASC";
                    }
                }

                else if($SubFilter == 3)
                {
                      if($Co_SubFilter == 'all')
                    {
                        $query_inbound .= "GROUP BY ri.IBN, r.Container
                        ORDER BY r.ReceivingDate ASC";
                    }
                    else
                    {
                        $query_inbound .= "AND ExpiryDate = '$Co_SubFilter'
                        GROUP BY ri.IBN, r.Container
                        ORDER BY r.ReceivingDate ASC";
                    }
                }

                else if($SubFilter == 4)
                {
                    if($Co_SubFilter == 'all')
                    {
                        $query_inbound .= "GROUP BY ri.IBN, r.Container
                        ORDER BY r.ReceivingDate ASC";
                    }
                    else if($Co_SubFilter == 'no_or')
                    {
                        $query_inbound .= "AND (OtherReference IS NULL OR OtherReference = '')
                        GROUP BY ri.IBN, r.Container
                        ORDER BY r.ReceivingDate ASC";
                    }
                    else
                    {
                        $query_inbound .= "AND ReceivingID = '$Co_SubFilter'
                        GROUP BY ri.IBN, r.Container
                        ORDER BY r.ReceivingDate ASC";
                    }
                }

                $result = mysqli_query($conn, $query_inbound);

                

                while($rows = mysqli_fetch_array($result))
                {   
                     $total_qty_inbound = $total_qty_inbound + $rows[3];
                     $total_weight_inbound =  $total_weight_inbound + $rows[4];
                     $gm_date = $datefrom;
                     $gm_date = strtotime($rows[7]);
                     $gm_date = date('d-M-Y', $gm_date);
                    

                     if($gm_date == '01-Jan-1970')
                     {
                        $gm_date = '';
                     }
                     $oum = $rows[11];

                    echo '
                            <tr>
                                <td style="border:1px solid black;"></td>
                                <td style="border:1px solid black;">'.number_format($rows[3]).'</td>
                                <td style="border:1px solid black;">'.number_format((float)$rows[4], 2).'</td>
                                <td style="border:1px solid black;"></td>
                                <td style="border:1px solid black;"></td>
                                <td style="border:1px solid black;">'.$rows[5].'</td>
                                <td style="border:1px solid black;">'.$rows[8].'</td>
                                <td style="border:1px solid black;">'.$rows[9].'</td>
                                <td style="border:1px solid black;">'.$rows[10].'</td>
                                <td style="border:1px solid black;">'.$gm_date.'</td>
                            </tr>
                    ';
                }



                $query_outbound = "SELECT
                                    COUNT(B.OBD), 
                                    SUM(Beg_Weight),
                                    A.OBD,
                                    A.Container,
                                    C.Batch,
                                    A.OtherRef,
                                    LEFT(A.IssuanceDate, 10)
                                    FROM wms_outbound.tbl_issuances A
                                    LEFT JOIN wms_outbound.tbl_issuancelist B ON A.OBD = B.OBD
                                    LEFT JOIN wms_inbound.tbl_receivingitems C ON B.ReceivingItemID = C.ReceivingItemID 
                                    WHERE B.itemid = $ItemID
                                    AND LEFT(A.IssuanceDate, 10) BETWEEN '$datefrom' AND '$dateto' AND (A.StatusID = 3 || A.StatusID = 6)
                                    ";
                if($SubFilter == null || $SubFilter == '')
                {
                    $query_outbound .= "
                    GROUP BY A.OBD, LEFT(A.IssuanceDate, 10)";
                }
                else if($SubFilter == 1)
                {
                    if($Co_SubFilter == 'all')
                    {
                        $query_outbound .= "GROUP BY A.OBD, LEFT(A.IssuanceDate, 10), A.Container";
                    }
                    else
                    {
                        $query_outbound .= "AND pl.Container = '$Co_SubFilter'
                        GROUP BY A.OBD, LEFT(A.IssuanceDate, 10), A.Container";
                    }
                }

                else if($SubFilter == 2)
                {
                    if($Co_SubFilter == 'all')
                    {
                        $query_outbound .= "GROUP BY A.OBD, LEFT(A.IssuanceDate, 10), A.Container";
                    }
                    else
                    {
                        $query_outbound .= "AND ri.Batch = '$Co_SubFilter'
                        GROUP BY A.OBD, LEFT(A.IssuanceDate, 10), A.Container";
                    }
                }

                else if($SubFilter == 3)
                {
                    if($Co_SubFilter == 'all')
                    {
                        $query_outbound .= "GROUP BY A.OBD, LEFT(A.IssuanceDate, 10), A.Container";
                    }
                    else
                    {
                        $query_outbound .= "AND AllocatedExpiry = '$Co_SubFilter'
                        GROUP BY A.OBD, LEFT(A.IssuanceDate, 10), A.Container";
                    }
                }
                else if($SubFilter == 4)
                {
                    if($Co_SubFilter == 'all')
                    {
                        $query_outbound .= "GROUP BY A.OBD, LEFT(A.IssuanceDate, 10), A.Container";
                    }
                    else if($Co_SubFilter == 'no_or'){
                        $query_outbound .= "AND (OtherReference IS NULL OR OtherReference = '')
                        GROUP BY A.OBD, LEFT(A.IssuanceDate, 10), A.Container";
                    }
                    else
                    {
                        $query_outbound .= "
                        GROUP BY A.OBD, LEFT(A.IssuanceDate, 10), A.Container";
                    }
                }
                $result = mysqli_query($conn, $query_outbound);
                while($rows = mysqli_fetch_array($result))
                {   
                     
                     $total_qty_outbound = $total_qty_outbound + $rows[0];
                     $total_weight_outbound = $total_weight_outbound + $rows[1];
                    $gm_date = strtotime($rows[6]);
                    $gm_date = date('d-M-Y', $gm_date);

                     if ( $gm_date == '01-Jan-1970')
                     {
                        $gm_date = '';
                     }

                    echo '
                            <tr>
                                <td style="border:1px solid black;"></td>
                                <td style="border:1px solid black;"></td>
                                <td style="border:1px solid black;"></td>
                                <td style="border:1px solid black;">'.number_format($rows[0]).'</td>
                                <td style="border:1px solid black;">'.number_format((float)$rows[1], 2).'</td>
                                <td style="border:1px solid black;">'.$rows[2].'</td>
                                <td style="border:1px solid black;">'.$rows[3].'</td>
                                <td style="border:1px solid black;">'.$rows[4].'</td>
                                <td style="border:1px solid black;">'.$rows[5].'</td>
                                <td style="border:1px solid black;">'.$gm_date.'</td>
                            </tr>
                    ';
                }

                

            $total_qty = ($total_qty_begining + $total_qty_inbound);
            $total_wgt = ($total_weight_begining + $total_weight_inbound);

            $total_remain_qty = 0;
            $total_remain_qty = ($total_qty_begining + $total_qty_inbound) - $total_qty_outbound;
            $total_remain_wgt = 0;
            $total_remain_wgt = ($total_weight_begining + $total_weight_inbound) - $total_weight_outbound;
            $total_remaining_qty = $total_qty - $total_qty_outbound;
            $total_remaining_wgt = $total_wgt - $total_weight_outbound;

            echo '

                <tr>
                    <td style="border:1px solid black; font-weight:bold;">Total</td>
                    <td style="border:1px solid black; font-weight:bold;">'.number_format($total_qty).'</td>
                    <td style="border:1px solid black; font-weight:bold;">'.number_format($total_wgt, 2).'</td>
                    <td style="border:1px solid black; font-weight:bold;">'.number_format($total_qty_outbound).'</td>
                    <td style="border:1px solid black; font-weight:bold;">'.number_format($total_weight_outbound, 2).'</td>
                    <td style="border:1px solid black;"></td>
                    <td style="border:1px solid black;"></td>
                    <td style="border:1px solid black;"></td>
                    <td style="border:1px solid black;"></td>
                    <td style="border:1px solid black;"></td>
                </tr>



            ';

            echo '

                <tr>
                    
                    <td style="border:1px solid black;"></td>
                    <td style="border:1px solid black; font-weight:bold;text-align:center;color:red;" colspan="2">'.number_format($total_remaining_qty).'</td>
                    <td style="border:1px solid black; font-weight:bold;text-align:center;color:red;" colspan="2">'.number_format((float)$total_remaining_wgt, 2).'</td>
                    <td style="border:1px solid black; font-weight:bold;text-align:center;color:red;" colspan="2">Remaining</td>
                    <td style="border:1px solid black;"></td>
                    <td style="border:1px solid black;"></td>
                    <td style="border:1px solid black;"></td>

                </tr>



            ';


            echo '  
                <tr>
                     <td class="text-uppercase" style="border:1px solid black;" colspan="10"></td>
                </tr>

                <tr>
                     <td class="text-uppercase" style="border:1px solid black;" colspan="10"><h3 style="text-align:center;">'.$itemname.'</h3></td>
                </tr>
                 
                
                <tr>
                     <td class="text-uppercase" style="border:1px solid black;"></td>
                     <td class="text-uppercase" style="border:1px solid black;"></td>
                     <td class="text-uppercase" style="border:1px solid black;"></td>
                     <td class="text-uppercase" style="border:1px solid black;">Quantity</td>
                     <td class="text-uppercase" style="border:1px solid black;">Weight</td>
                     
                     <td class="text-uppercase" style="border:1px solid black;">CV Number</td>
                     <td class="text-uppercase" style="border:1px solid black;">Batch</td>
                     <td class="text-uppercase" style="border:1px solid black;">OtherReference</td>
                     <td class="text-uppercase" style="border:1px solid black;"></td>
                     <td class="text-uppercase" style="border:1px solid black;"></td>
                </tr>
            ';

            $qty = 0;
            $wgt = 0;
            $total_qty = 0;
            $total_wgt = 0;
            $dateback = date('Y-m-d', strtotime('-1 day', strtotime($datefrom)));
            $query_breakdown = "SELECT
                            SUM( case when LEFT(r.ReceivingDate, 10) BETWEEN '2000-01-09' AND '$dateback' then ri.Beg_Quantity end),
                            SUM( case when LEFT(r.ReceivingDate, 10) BETWEEN '2000-01-09' AND '$dateback' then ri.Beg_Weight end),
                            SUM( case when LEFT(r.ReceivingDate, 10) BETWEEN '$datefrom' AND '$dateto' then ri.Beg_Quantity end),
                            SUM( case when LEFT(r.ReceivingDate, 10) BETWEEN '$datefrom' AND '$dateto' then ri.Beg_Weight end),
                            (SELECT
                                    COUNT(B.OBD)
                                    FROM wms_outbound.tbl_issuances A
                                    LEFT JOIN wms_outbound.tbl_issuancelist B ON A.OBD = B.OBD
                                    LEFT JOIN wms_inbound.tbl_receivingitems C ON B.ReceivingItemID = C.ReceivingItemID 
                                    LEFT JOIN wms_inbound.tbl_receiving D ON C.IBN = D.IBN 
                                    WHERE B.itemid = $ItemID AND 
                                    D.Container = r.Container AND
                                    LEFT(A.IssuanceDate, 10) BETWEEN '$datefrom' AND '$dateto'
                                    AND A.StatusID >= 3),
                            (SELECT
                                    SUM(C.Beg_Weight)
                                    FROM wms_outbound.tbl_issuances A
                                    LEFT JOIN wms_outbound.tbl_issuancelist B ON A.OBD = B.OBD
                                    LEFT JOIN wms_inbound.tbl_receivingitems C ON B.ReceivingItemID = C.ReceivingItemID 
                                    LEFT JOIN wms_inbound.tbl_receiving D ON C.IBN = D.IBN 
                                    WHERE B.itemid = $ItemID AND
                                    D.Container = r.Container AND
                                    LEFT(A.IssuanceDate, 10) BETWEEN '$datefrom' AND '$dateto'
                                    AND A.StatusID >= 3),
                            r.Container,
                            ri.Batch,
                            r.OtherReference
                            FROM wms_inbound.tbl_receivingitems ri
                            LEFT JOIN wms_inbound.tbl_receiving r ON ri.IBN = r.IBN
                            LEFT JOIN wms_cloud.tbl_items item ON ri.ItemID = item.ItemID
                            LEFT JOIN wms_cloud.tbl_weightuom wgt ON item.UOMID = wgt.UOMID
                            WHERE ri.ItemID = $ItemID
                            AND Checked = 'True' AND (ForPutaway = 0 OR ForPutaway >= 2) AND r.StatusID != 5
                            GROUP BY r.Container";

            $result = mysqli_query($conn, $query_breakdown);

            while($rows = mysqli_fetch_array($result))
            {
                
                $qty = ($rows[0] + $rows[2]) - $rows[4];
                $wgt = ($rows[1] + $rows[3]) - $rows[5];

                $total_qty += $qty;
                $total_wgt += $wgt;
                    
                

                if($qty == 0 || $qty == null){
                    echo '';
                }
                else
                {
                    echo '

                    <tr>
                         <td style="border:1px solid black;"></td>
                         <td style="border:1px solid black;"></td>
                         <td style="border:1px solid black; font-weight:bold"></td>
                         <td style="border:1px solid black; font-weight:bold">'.number_format($qty).'</td>
                         <td style="border:1px solid black; font-weight:bold">'.number_format((float)$wgt, 2).'</td>
                         <td style="border:1px solid black;">'.$rows[6].'</td>
                         <td style="border:1px solid black;">'.$rows[7].'</td>
                         <td style="border:1px solid black;">'.$rows[7].'</td>
                         <td style="border:1px solid black;"></td>
                         <td style="border:1px solid black;"></td>
                    </tr>

                ';
                }
            }

            echo '

                <tr>
                <td style="border:1px solid black;"></td>
                <td style="border:1px solid black;"></td>
                <td style="border:1px solid black; font-weight:bold">Total</td>
                <td style="border:1px solid black; font-weight:bold;color:red;">'.number_format($total_qty).'</td>
                <td style="border:1px solid black; font-weight:bold;color:red;">'.number_format((float)$total_wgt, 2).'</td>
                <td style="border:1px solid black;"></td>
                <td style="border:1px solid black;"></td>
                <td style="border:1px solid black;"></td>
                <td style="border:1px solid black;"></td>
                <td style="border:1px solid black;"></td>
                </tr>

            ';
        }
        
    function loadItem($customer)
    {
        include ('dbcon.php');

        $query = "SELECT ItemID, ItemDesc FROM wms_cloud.tbl_items WHERE ItemCustomerID = $customer";
        $res = mysqli_query($conn, $query);

        while($row = mysqli_fetch_array($res)){
            echo '<option value="'.$row[0].'">'.$row[1].'</option>';
        }
    }

    function loadSubfilter()
    {
        echo '
            <option value="">None</option>
            <option value="1">CV Number</option>
            <option value="2">Batch</option>
            <option value="3">Expiry</option>
            <option value="4">Other References</option>
        ';
    }

    function loadSubFilter_GM($subfilter, $loadItem)
    {
        include ('dbcon.php');

        if($subfilter == 1)
        {
            echo '
                <option value="all">All Container</option>
            ';
            $query = "SELECT
                    r.Container
                    FROM wms_inbound.tbl_receivingitems ri
                    LEFT JOIN wms_inbound.tbl_receiving r ON ri.IBN = r.IBN
                    WHERE ItemID = '$loadItem'
                    GROUP BY Container";
            $res = mysqli_query($conn, $query);

            while($row = mysqli_fetch_array($res)){
                echo '<option value="'.$row[0].'">'.$row[0].'</option>';
            }
        }
        else if($subfilter == 2)
        {
            echo '
                <option value="all">All Batch</option>
            ';
            $query = "SELECT
                    DISTINCT(Batch)
                    FROM wms_inbound.tbl_receivingitems ri
                    LEFT JOIN wms_inbound.tbl_receiving r ON ri.IBN = r.IBN
                    WHERE ItemID = '$loadItem'
                    GROUP BY Batch";
            $res = mysqli_query($conn, $query);

            while($row = mysqli_fetch_array($res)){
                echo '<option value="'.$row[0].'">'.$row[0].'</option>';
            }
        }

        else if($subfilter == 3)
        {
            echo '
                <option value="all">All Expiry</option>
            ';
            $query = "SELECT
                        ExpiryDate
                        FROM wms_inbound.tbl_receivingitems ri
                        LEFT JOIN wms_inbound.tbl_receiving r ON ri.IBN = r.IBN
                        WHERE ItemID = '$loadItem'
                        GROUP BY ExpiryDate
                        ORDER BY ExpiryDate ASC";
            $res = mysqli_query($conn, $query);

            while($row = mysqli_fetch_array($res)){
                $expiry = $row[0];
                $expiry = strtotime($row[0]);
                $expiry = date('d-M-Y',$expiry);
                echo '<option value="'.$row[0].'">'.$expiry.'</option>';
            }
        }

        else if($subfilter == 4)
        {
            echo '
                <option value="all">All Other References</option>
                <option value="no_or">No Other References</option>
            ';
            $query = "SELECT
                        ReceivingID,
                        OtherReference
                    FROM wms_inbound.tbl_receivingitems ri
                    LEFT JOIN wms_inbound.tbl_receiving rec on ri.IBN = rec.IBN
                    WHERE OtherReference IS NOT NULL AND OtherReference <> ''
                    AND ItemID = '$loadItem'
                    GROUP BY OtherReference";
            $res = mysqli_query($conn, $query);

            while($row = mysqli_fetch_array($res)){
            echo '<option value="'.$row[0].'">'.$row[1].'</option>';
            }
        }

        else if($subfilter == '')
        {
            echo '
                <option value="">Select From List</option>
            ';
            
        }
    }

    function loadWarehouse()
    {
        include ('dbcon.php');

        $query = "SELECT * FROM wms_cloud.tbl_warehouses";
        $res = mysqli_query($conn, $query);
        echo '<option value="0">All Warehouse</option>';

        while($row = mysqli_fetch_array($res)){
            echo '<option value="'.$row[0].'">'.$row[1].'</option>';
        }
    }

    function GetWarehouseExport($WarehouseID)
    {
        include ('dbcon.php');

        $query = "SELECT Warehouse FROM wms_cloud.tbl_warehouses ";
        if(!empty($WarehouseID))
        {
            $query .= "WHERE WarehouseID = $WarehouseID";
        }
        else
        {
            $query .= "";
        }
        $res = mysqli_query($conn, $query);
        
        $warehousename = '';

        if(mysqli_num_rows($res) > 1)
        {
            $warehousename = 'All Warehouse';
        }
        else
        {
            while($row = mysqli_fetch_array($res))
            {
                $warehousename = $row[0];
            }
        }
        
        echo $warehousename;
    }
    function GetCustomerExport($CustomerID1)
    {
        include ('dbcon.php');

        $query = "SELECT CompanyName FROM wms_cloud.tbl_customers WHERE CustomerID = $CustomerID1";
        
        $res = mysqli_query($conn, $query);
        
        while($row = mysqli_fetch_array($res))
        {
            $warehousename = $row[0];
        }
        
        echo $warehousename;
    }

    function GetSubFilterExport($SubFilter1)
    {
        if(empty($SubFilter1))
        {
            echo 'None';
        }
        else if($SubFilter1 == 1)
        {
            echo 'CV Number';
        }
        else if($SubFilter1 == 2)
        {
            echo 'Batch';
        }
        else if($SubFilter1 == 3)
        {
            echo 'Expiry';
        }
        else if($SubFilter1 == 4)
        {
            echo 'Other References';
        }
        else
        {
            echo $SubFilter1;
        }
    }
// Reports


// ReceivingModule

    function CPGenerateIBN($warehouse)  
    {
        include 'dbcon.php';

        $usersID = $_SESSION['UserID'];

        $date = new DateTime('UTC');
        $date->setTimezone(new DateTimeZone('Asia/Manila'));
        $datenow = $date->format('Y-m-d H:i:s a');
        
        $TempCPI = 0;
        $NewTempCPI = 0;
        $userid = $_SESSION['CustomerId'];

        $query = "SELECT TempCPI FROM wms_clientportal.tbl_temp";
        
        $result = mysqli_query($conn, $query);
        if(mysqli_num_rows($result) == 0)
        {
            $TempCPI = 1;
            
            $query = "INSERT INTO wms_clientportal.tbl_temp (TempCPI) VALUES ('$TempCPI')";
            if(mysqli_query($conn, $query))
            {

                $CPI = "CPI".sprintf('%09d', $TempCPI);
                // 0 false 1 true
                $query = "SELECT CusEmail FROM wms_cloud.tbl_customers_users WHERE id = '$usersID'";
                $result = mysqli_query($conn, $query);
                if(mysqli_num_rows($result) == 1)
                {
                    while($row = mysqli_fetch_assoc($result))
                    {
                        $createdby = $row['CusEmail'];
                    }

                    $query = "CALL wms_clientportal.SP_Generate_CPI('$CPI', '$userid', '$datenow', '$usersID', '$createdby', '$warehouse')";
                    if(mysqli_query($conn, $query))
                    {
                        echo $CPI;
                    }

                }
            }
        }
        else
        {
            while($row = mysqli_fetch_array($result))
            {
                $TempCPI = $row[0];

                $NewTempCPI = $TempCPI + 1;

                $userid = $_SESSION['CustomerId'];
                $usersID = $_SESSION['UserID'];

                $query = "UPDATE wms_clientportal.tbl_temp SET TempCPI = '$NewTempCPI'";
                if(mysqli_query($conn, $query))
                {
                    $CPI = "CPI".sprintf('%09d', $NewTempCPI);
                    
                    // get user email 
                    $query = "SELECT CusEmail FROM wms_cloud.tbl_customers_users WHERE id = '$usersID'";
                    $result = mysqli_query($conn, $query);
                    if(mysqli_num_rows($result) == 1)
                    {
                        while($row = mysqli_fetch_assoc($result))
                        {
                            $createdby = $row['CusEmail'];
                        }

                        $query = "CALL wms_clientportal.SP_Generate_CPI('$CPI', '$userid', '$datenow', '$usersID', '$createdby', '$warehouse')";
                        if(mysqli_query($conn, $query))
                        {
                            echo $CPI;
                        }
                    } 
                }
                else
                {
                    echo "Erro: " . $query . "<br>" . mysqli_error($conn);
                }  
            }
        }
    }

    function Warehouses()
    {
        include 'dbcon.php';
        $usercommoncode = $_SESSION['CommonCode'];

        // $query = "CALL wms_clientportal.SP_getwarehouses('$usercommoncode')";
        $query = "SELECT DISTINCT(cus.WarehouseID), wh.Warehouse
        FROM wms_cloud.tbl_customers AS cus
        LEFT JOIN wms_cloud.tbl_warehouses AS wh ON cus.WarehouseID = wh.WarehouseID
        LEFT JOIN wms_cloud.tbl_customers_users cu ON cu.CommonCode = cus.CustomerCommonCode
        WHERE cu.CommonCode = '$usercommoncode'";
        $result = mysqli_query($conn, $query);
        if(mysqli_num_rows($result) > 0)
        {
            while($rows = mysqli_fetch_array($result))
            {
                echo '<option value="'.$rows[0].'">'.$rows[1].'</option>';
            }
        }
        else
        {
            echo 'No Warehouse' . $usercommoncode;
        }
    }

    function TruckType()
    {
        include 'dbcon.php';

        $query = "CALL wms_clientportal.SP_gettrucks";
        $result = mysqli_query($conn, $query);
        while($rows = mysqli_fetch_array($result))
        {
            echo '<option value="'.$rows[0].'">'.$rows[1].'</option>';
        }
    }

    function ReturnToPending($cpi_no, $selected_warehouse, $supplier_name ,$container_no, $vehicle_plateno, $seal_no, $client_rep, $date_arrival, $remarks, $selected_truck)
    {
        include 'dbcon.php';
        $userid = $_SESSION['CustomerId'];
        $usersID = $_SESSION['UserID'];

        $query = "SELECT CusEmail FROM wms_cloud.tbl_customers_users WHERE id = '$usersID'";
        $result = mysqli_query($conn, $query);
        if(mysqli_num_rows($result) == 1)
        {
            while($row = mysqli_fetch_assoc($result))
            {
                $createdby = $row['CusEmail'];
            }

            $query = "SELECT role_id, CusName FROM wms_cloud.tbl_customers_users WHERE id = $usersID LIMIT 1";
            $result = mysqli_query($conn, $query);
            while($row = mysqli_fetch_array($result))
            {
                $user_role = $row[0];
                $cusname = $row[1];
            }

            if($user_role == 1)
            {
                if(empty($cpi_no))
                {
                    $query = "SELECT * FROM wms_clientportal.tbl_inbounditems WHERE StatusID = 0 AND UserID = $usersID";
                    $result = mysqli_query($conn, $query);
                    if(mysqli_num_rows($result) >= 1)
                    {
                        $CPI = generateCPI();

                        $query = "INSERT INTO wms_clientportal.tbl_inbound(`CPI`, `CusID`, `Date_created`, `Status`, `UsersID`, `CreatedBy`, `LastUpdatedBy`) VALUES ('$CPI', '$userid', NOW(), 1, '$usersID', '$cusname', '$cusname')";
                        if(mysqli_query($conn, $query))
                        {
                            $query = "UPDATE wms_clientportal.tbl_inbounditems SET CPI = '$CPI', StatusID = '1' WHERE StatusID = '0' AND UserID = $usersID";
                            if(mysqli_query($conn, $query))
                            {
                                $query = "INSERT INTO wms_inbound.tbl_receiving (`CusID`, `ReceivingDate`, `ASN`, `Container`, `VehiclePlate`, `RequestedBy`, `Seal`, `Remarks`, `FromCP`, `CPStatus_id`, `Warehouse_id`, `TruckType`, `Supplier`, `CreatedBy`, `LastUpdatedBy`) VALUES ('$userid', '$date_arrival', '$CPI', '$container_no', '$vehicle_plateno', '$client_rep', '$seal_no', '$remarks', 'True', 2, $selected_warehouse, '$selected_truck', '$supplier_name', '$cusname', '$cusname')";
                                if(mysqli_query($conn, $query))
                                {
                                    echo $CPI;
                                }
                            }
                            else
                            {
                                echo "Error: " . $query . "<br>" . mysqli_error($conn);
                            }
                        }
                    }
                    else
                    {
                        echo 0;
                    }
                }
                else
                {
                    $query = "CALL wms_clientportal.SP_ReturntoPending('$cpi_no', '$selected_warehouse', '$supplier_name', '$container_no', '$vehicle_plateno', '$seal_no', '$client_rep', '$date_arrival', '$remarks', '$selected_truck', '$createdby')";
                    if(mysqli_query($conn, $query))
                    {
                        echo 1;
                    }
                    else
                    {
                        echo "Error: " . $query . "<br>" . mysqli_error($conn);
                    }
                }
                
            }
            else
            {
                $query = "CALL wms_clientportal.SP_ReturntoPending('$cpi_no', '$selected_warehouse', '$supplier_name', '$container_no', '$vehicle_plateno', '$seal_no', '$client_rep', '$date_arrival', '$remarks', '$selected_truck', '$createdby')";
                if(mysqli_query($conn, $query))
                {
                    echo 1;
                }
                else
                {
                    echo "Error: " . $query . "<br>" . mysqli_error($conn);
                }
            }
        }
        else
        {
            echo "Error: " . $query . "<br>" . mysqli_error($conn);
        }
    }

    function GetPendingList()
    {
        include 'dbcon.php';

        $userID = $_SESSION['UserID'];
        $cusID = $_SESSION['CustomerId'];

        $query = "SELECT role_id FROM wms_cloud.tbl_customers_users WHERE id = '$userID'";
        $result = mysqli_query($conn, $query);
        $row = mysqli_fetch_array($result);
        $role_id = $row[0];

        if($role_id === '1')
        {
            $query = "CALL wms_clientportal.SP_GetPendingList('$cusID')";
            $result = mysqli_query($conn, $query);
            while ($rows = mysqli_fetch_array($result))
            {
                echo '
                    <tr>
                        <td>'.$rows[0].'</td>
                        <td>'.date( "d-M-Y", strtotime($rows[1])).'</td>
                        <td>'.$rows[2].'</td>
                        <td>'.$rows[3].'</td>
                        <td><button class="btn btn-primary btn-sm" data-dismiss="modal" onclick="asndetails(\''.$rows[0].'\')">Open</button></td>
                    </tr>
                ';
            }
        }
        else
        {
            $query = "CALL wms_clientportal.SP_GetPendingList('$cusID')";
            $result = mysqli_query($conn, $query);
            while ($rows = mysqli_fetch_array($result))
            {
                echo '
                    <tr>
                        <td>'.$rows[0].'</td>
                        <td>'.date( "d-M-Y", strtotime($rows[1])).'</td>
                        <td>'.$rows[2].'</td>
                        <td>'.$rows[3].'</td>
                        <td><button class="btn btn-primary btn-sm" data-dismiss="modal" onclick="asndetails(\''.$rows[0].'\')">Open</button></td>
                    </tr>
                ';
            }
        }

        
    }

    function GetForApprovallist()
    {
        include 'dbcon.php';
        $userID = $_SESSION['UserID'];
        $cusID = $_SESSION['CustomerId'];

        $query = "SELECT role_id FROM wms_cloud.tbl_customers_users WHERE id = '$userID'";
        $result = mysqli_query($conn, $query);
        while($row = mysqli_fetch_array($result))
        {
            $role = $row[0];
        }

        if($role === '1')
        {
            $query ="CALL wms_clientportal.SP_GetForApprovallist_tm('$cusID')";
            $result = mysqli_query($conn, $query);
            while ($rows = mysqli_fetch_row($result))
            {
                echo '
                    <tr>
                        <td>'.$rows[0].'</td>
                        <td>'.date( "d-M-Y", strtotime($rows[1])).'</td>
                        <td>'.$rows[2].'</td>
                        <td>'.$rows[3].'</td>
                        <td><button class="btn btn-primary btn-sm" data-dismiss="modal" onclick="asndetails(\''.$rows[0].'\')">Open</button></td>
                    </tr>
                ';
            }
        }
        else
        {
            $query = "CALL wms_clientportal.SP_GetForApprovallist_p('$userID')";
            $result = mysqli_query($conn, $query);
            while ($rows = mysqli_fetch_row($result))
            {
                echo '
                    <tr>
                        <td>'.$rows[0].'</td>
                        <td>'.date("d-M-Y", strtotime($rows[1])).'</td>
                        <td>'.$rows[2].'</td>
                        <td>'.$rows[3].'</td>
                    </tr>
                ';
            }
        }
    }

    function GetOnprocesslist()
    {
        include 'dbcon.php';
        $userID = $_SESSION['UserID'];
        $cusID = $_SESSION['CustomerId'];

        $query = "SELECT i.CPI, DATE_FORMAT(i.Date_created, '%d-%m-%Y'), i.CreatedBy, i.LastUpdatedBy, i.UsersID FROM wms_clientportal.tbl_inbound i WHERE i.`Status` = 0 AND i.cusID = $cusID";
        $result = mysqli_query($conn, $query);
        while ($rows = mysqli_fetch_row($result))
        {
            if($userID == $rows[4])
            {
                echo '
                    <tr>
                        <td>'.$rows[0].'</td>
                        <td>'.date( "d-M-Y", strtotime($rows[1])).'</td>
                        <td>'.$rows[2].'</td>
                        <td>'.$rows[3].'</td>
                        <td><button class="btn btn-primary btn-sm" data-dismiss="modal" onclick="asndetails(\''.$rows[0].'\')">Open</button></td>
                    </tr>
                ';
            }
            else
            {
                echo '
                    <tr>
                        <td>'.$rows[0].'</td>
                        <td>'.date( "d-M-Y", strtotime($rows[1])).'</td>
                        <td>'.$rows[2].'</td>
                        <td>'.$rows[3].'</td>
                        <td><button class="btn btn-primary btn-sm" data-dismiss="modal" onclick="asndetails(\''.$rows[0].'\')" disabled>Open</button></td>
                    </tr>
                ';
            }
        }
    }

    function GetPendingCount()
    {
        include 'dbcon.php';

        $userID = $_SESSION['UserID'];

        $query = "SELECT cu.CommonCode FROM wms_cloud.tbl_customers_users cu WHERE cu.id = '$userID'";
        $result = mysqli_query($conn, $query);
        while($row = mysqli_fetch_array($result))
        {
            $CommonCode = $row[0];
        }

        $query = "CALL wms_clientportal.SP_GetPendingCount('$CommonCode')";

        $result = mysqli_query($conn, $query);
        if(mysqli_num_rows($result) == 1)
        {
            while ($rows = mysqli_fetch_array($result))
            {
                echo $rows[0];
            }
        }
    }

    function GetForApprovalCount()
    {   
        include 'dbcon.php';

        $userID = $_SESSION['UserID'];
        
        $cusID = $_SESSION['CustomerId'];
        
        $query = "SELECT role_id FROM wms_cloud.tbl_customers_users WHERE id = '$userID'";
        $result = mysqli_query($conn, $query);
        while($row = mysqli_fetch_array($result))
        {
            $role = $row[0];
        }

        if($role == 1)
        {
            $query = "SELECT * FROM wms_cloud.tbl_customers_users WHERE id = '$userID'";
            $result = mysqli_query($conn, $query);
            while($row = mysqli_fetch_assoc($result))
            {
                $commoncode = $row['CommonCode'];
            }

            $query = "CALL wms_clientportal.SP_GetForApprovalCount_tm('$commoncode')";

            $result = mysqli_query($conn, $query);
            if(mysqli_num_rows($result) == 1)
            {
                while ($rows = mysqli_fetch_array($result))
                {
                    echo $rows[0];
                }
            }
            
        }
        else
        {
            $query = "CALL wms_clientportal.SP_GetForApprovalCount_p('$userID')";

            $result = mysqli_query($conn, $query);
            if(mysqli_num_rows($result) == 1)
            {
                while ($rows = mysqli_fetch_array($result))
                {
                    echo $rows[0];
                }
            }
        }
    }
    
    function GetOnProcessCount()
    {
        include 'dbcon.php';

        $userID = $_SESSION['UserID'];
        
        $cusID = $_SESSION['CustomerId'];
        $query = "SELECT * FROM wms_cloud.tbl_customers_users WHERE id = '$userID'";
        $result = mysqli_query($conn, $query);
        while($row = mysqli_fetch_assoc($result))
        {
            $commoncode = $row['CommonCode'];
        }

        $query = "SELECT COUNT(*) FROM wms_clientportal.tbl_inbound i LEFT JOIN wms_cloud.tbl_customers_users cu ON i.UsersID = cu.id WHERE i.`Status` = 0 AND cu.CommonCode = '$commoncode'";
        $result = mysqli_query($conn, $query);
        if(mysqli_num_rows($result) == 1)
        {
            while ($rows = mysqli_fetch_array($result))
            {
                echo $rows[0];
            }
        }
    }

    function GetASNDetails($CPI)
    {
        include 'dbcon.php';

        $userID = $_SESSION['CustomerId'];
        $user_id = $_SESSION['UserID'];
        
        $query = "SELECT CusName FROM wms_cloud.tbl_customers_users WHERE id = '$user_id'";
        $result = mysqli_query($conn, $query);
        if(mysqli_num_rows($result) == 1)
        {
            while($row = mysqli_fetch_array($result))
            {
                $username = $row[0];
            }
            $query = "SELECT `Status` FROM wms_clientportal.tbl_inbound WHERE CPI = '$CPI'";
            $result = mysqli_query($conn, $query);
            if(mysqli_num_rows($result) == 1)
            {
                while($row = mysqli_fetch_array($result))
                {
                    $CPStatus = $row[0];
                }

                if($CPStatus == 0 || $CPStatus == 2)
                {
                    $query = "CALL wms_clientportal.SP_GetASNDetails('$CPI')";
                        $result = mysqli_query($conn, $query);
                        while($rows = mysqli_fetch_array($result))
                        {
                            $arr[] = array(
                                'CPI'=>$rows[0],
                                'Warehouse_id'=>$rows[1],
                                'Supplier'=>$rows[2],
                                'Container'=>$rows[3],
                                'VehiclePlace'=>$rows[4],
                                'Seal'=>$rows[5],
                                'RequestedBy'=>$rows[6],
                                'ReceivingDate'=>date('Y-m-d\TH:i', strtotime($rows[7])),
                                'CusID'=>$rows[8],
                                'TruckType'=>$rows[9],
                                'Remarks'=>$rows[10],
                                'CPStatus_id'=>$rows[11]
                            );
                        }
                        echo json_encode($arr);
                        exit();
                }
                else if($CPStatus == 1)
                {
                    $user_id = $_SESSION['UserID'];

                    $query = "UPDATE wms_clientportal.tbl_inbound SET Status = 0,  UsersID = '$user_id', LastUpdatedBy = '$username' WHERE CPI = '$CPI'";
                    if(mysqli_query($conn, $query))
                    {
                        $query = "UPDATE wms_clientportal.tbl_inbounditems SET UserID = '$user_id' WHERE CPI ='$CPI'";
                        $result = mysqli_query($conn, $query);

                        $query = "UPDATE wms_inbound.tbl_receiving SET CPStatus_id = 1, LastUpdatedBy = '$username' WHERE ASN = '$CPI'";
                        if(mysqli_query($conn, $query))
                        {
                            $query = "CALL wms_clientportal.SP_GetASNDetails('$CPI')";
                                $result = mysqli_query($conn, $query);
                                while($rows = mysqli_fetch_array($result))
                                {
                                    $arr[] = array(
                                        'CPI'=>$rows[0],
                                        'Warehouse_id'=>$rows[1],
                                        'Supplier'=>$rows[2],
                                        'Container'=>$rows[3],
                                        'VehiclePlace'=>$rows[4],
                                        'Seal'=>$rows[5],
                                        'RequestedBy'=>$rows[6],
                                        'ReceivingDate'=>date('Y-m-d\TH:i', strtotime($rows[7])),
                                        'CusID'=>$rows[8],
                                        'TruckType'=>$rows[9],
                                        'Remarks'=>$rows[10],
                                        'CPStatus_id'=>$rows[11]
                                    );
                                }
                                echo json_encode($arr);
                                exit();
                        }
                        else
                        {
                            echo "Error: " . $query . "<br>" . mysqli_error($conn);
                        }
                    }
                }
            }
            else
            {
                echo "Error: " . $query . "<br>" . mysqli_error($conn);
            }
        
        }
        else
        {
            echo "Error: " . $query . "<br>" . mysqli_error($conn);
        }
    }

    function AvailableItems()
    {
        include 'dbcon.php';

        $userid = $_SESSION['CustomerId'];

        $query = "SELECT ItemID, ItemDesc, ItemCode, Client_SKU 
        FROM wms_cloud.tbl_items 
        WHERE ItemCustomerID = $userid
        AND Status = 'Active'";
        $result = mysqli_query($conn, $query);
        while($rows = mysqli_fetch_array($result))
        {
            echo '<option value="'.$rows[0].'">'.$rows[1].' ('.$rows[3].')</option>';
        }
    }

    function GetUOM($ItemID)
    {
        include 'dbcon.php';

        $query = "CALL wms_clientportal.SP_GetUOM('$ItemID')";
        $result = mysqli_query($conn, $query);
        if(mysqli_num_rows($result) > 0)
        {
            while($rows = mysqli_fetch_array($result))
            {
                echo $rows[1];
            }
        }
        else
        {
            echo "Error: " . $query . "<br>" . mysqli_error($conn);
        }
    }

    function GetWeight($ItemID)
    {
        include 'dbcon.php';
        
        $query = "SELECT ItemID, Weight FROM wms_cloud.tbl_items WHERE Weight >= 1 AND ItemID = $ItemID";
        $result = mysqli_query($conn, $query);
        if(mysqli_num_rows($result) == 1)
        {
            while($row = mysqli_fetch_array($result))
            {   
                $wgt = number_format($row[1], 2);
                echo $wgt;
            }
        }
        else
        {
            
        }
    }

    function ifforapprovaladditem($r_item, $r_itemqty, $r_itemexpirydate, $r_itemuom, $r_weight, $r_CPI, $r_user_id)
    {
        include 'dbcon.php';

        // $userid = $_SESSION['UserID'];

        $getfworcfsql = "SELECT Weight FROM wms_cloud.tbl_items WHERE ItemID = '$r_item'";
        $result = mysqli_query($conn, $getfworcfsql);
        while($row = mysqli_fetch_array($result))
        {
            $wgt = $row[0];
        }

        if($wgt > 0)
        {
            $query = "SELECT * FROM wms_clientportal.tbl_inbounditems WHERE ItemID = '$r_item' AND ExpiryDate ='$r_itemexpirydate' AND StatusID = 1 AND UserID = $r_user_id";
            $result = mysqli_query($conn, $query);
            if(mysqli_num_rows($result) == 1)
            {
                while($row = mysqli_fetch_array($result))
                {
                    $r_id = $row[0];
                    $quantity = $row[5];
                    $weight = $row[6];
                }

                $totalqtyitem = $quantity + $r_itemqty;
                $totalbeg_weight = ($weight + ($r_itemqty * $r_weight));

                $query = "UPDATE wms_clientportal.tbl_inbounditems SET Quantity = '$totalqtyitem', Beg_Quantity = '$totalqtyitem', Weight = '$totalbeg_weight', Beg_Weight = '$totalbeg_weight' WHERE ReceivingItemID = '$r_id'";
                if(mysqli_query($conn, $query))
                {
                    echo "aSuccess!" . $totalbeg_weight . '-' . $weight;
                }
            }
            else
            {
                $totalwgt = ($r_weight * $r_itemqty);

                $query = "INSERT INTO wms_clientportal.tbl_inbounditems (`CPI`, `ItemID`, `Quantity`, `Beg_Quantity`, `Weight`, `Beg_Weight`, `ExpiryDate`, `StatusID`, `UserID`, `StorageType`) VALUES('$r_CPI', '$r_item', '$r_itemqty', '$r_itemqty', '$totalwgt', '$totalwgt', '$r_itemexpirydate', 1, '$r_user_id', 1)";
                if(mysqli_query($conn, $query))
                {
                    echo 'aSuccess';
                }
            }
        }
        else if($wgt == 0)
        {
            if(($r_itemqty != null || $r_itemqty != "") && ($r_weight != null || $r_weight != ""))
            {
                $query = "SELECT ReceivingItemID, ItemID, ExpiryDate, StorageType, Quantity, Weight FROM wms_clientportal.tbl_inbounditems WHERE ItemID = '$r_item' AND ExpiryDate ='$r_itemexpirydate' AND StorageType = 2 AND StatusID = 1 AND UserID = $r_user_id";
                $result = mysqli_query($conn, $query);
                if(mysqli_num_rows($result) == 1)
                {
                    while($row = mysqli_fetch_array($result))
                    {
                        $r_id = $row[0];
                        $quantity = $row[4];
                        $weight = $row[5];
                    }

                    $totalqtyitem = $r_itemqty + $quantity;
                    $totalwgtitem = $r_weight + $weight;
                
                    $query = "UPDATE wms_clientportal.tbl_inbounditems SET Weight = '$totalwgtitem', Beg_Weight = '$totalwgtitem', Quantity = '$totalqtyitem', Beg_Quantity = '$totalqtyitem' WHERE ReceivingItemID = '$r_id'";
                    if(mysqli_query($conn, $query))
                    {
                        echo 'aSuccess';
                    }
                }
                else
                {
                    $query = "INSERT INTO wms_clientportal.tbl_inbounditems (`CPI`, `ItemID`, `Quantity`, `Beg_Quantity`, `Weight`, `Beg_Weight`, `ExpiryDate`, `StatusID`, `UserID`, `StorageType`) VALUES('$r_CPI', '$r_item', '$r_itemqty', '$r_itemqty', '$r_weight', '$r_weight', '$r_itemexpirydate', 1, '$r_user_id', 2)";
                    if(mysqli_query($conn, $query))
                    {
                        echo 'aSuccess';
                    }
                }
            }
            else if(($r_weight != '') && ($r_weight != null) && ($r_itemqty == '') && ($r_itemqty == null))
            {
                $query = "SELECT ReceivingItemID, ItemID, ExpiryDate, StorageType, Quantity, Weight FROM wms_clientportal.tbl_inbounditems WHERE ItemID = '$r_item' AND ExpiryDate ='$r_itemexpirydate' AND StorageType = 2 AND StatusID = 1 AND UserID = $r_user_id AND Quantity = 0";
                $result = mysqli_query($conn, $query);
                if(mysqli_num_rows($result) == 1)
                {
                    while($row = mysqli_fetch_array($result))
                    {
                        $r_id = $row[0];
                        $weight = $row[5];
                    }
                
                    $totalwgtitem = $r_weight + $weight;
                
                    $query = "UPDATE wms_clientportal.tbl_inbounditems SET Weight = '$totalwgtitem', Beg_Weight = '$totalwgtitem' WHERE ReceivingItemID = '$r_id'";
                    if(mysqli_query($conn, $query))
                    {
                        echo 'aSuccess';
                    }
                }
                else
                {
                    $query = "INSERT INTO wms_clientportal.tbl_inbounditems (`CPI`, `ItemID`, `Quantity`, `Beg_Quantity`, `Weight`, `Beg_Weight`, `ExpiryDate`, `StatusID`, `UserID`, `StorageType`) VALUES('$r_CPI', '$r_item', 0, 0, '$r_weight', '$r_weight', '$r_itemexpirydate', 1, '$r_user_id', 2)";
                    if(mysqli_query($conn, $query))
                    {
                        echo 'aSuccess';
                    }
                }
            }
            else if(($r_weight == '') && ($r_weight == null) && ($r_itemqty != '') && ($r_itemqty != null))
            {
                $query = "SELECT ReceivingItemID, ItemID, ExpiryDate, StorageType, Quantity, Weight FROM wms_clientportal.tbl_inbounditems WHERE ItemID = '$r_item' AND ExpiryDate ='$r_itemexpirydate' AND StorageType = 2 AND StatusID = 1 AND UserID = $r_user_id AND Weight = 0";
                $result = mysqli_query($conn, $query);
                if(mysqli_num_rows($result) == 1)
                {
                    while($row = mysqli_fetch_array($result))
                    {
                        $r_id = $row[0];
                        $quantity = $row[4];
                        $weight = $row[5];
                    }
                    $totalqtyitem = $r_itemqty + $quantity;

                    $query = "UPDATE wms_clientportal.tbl_inbounditems SET Quantity = '$totalqtyitem', Beg_Quantity = '$totalqtyitem' WHERE ReceivingItemID = '$r_id'";
                    if(mysqli_query($conn, $query))
                    {
                        echo 'aSuccess';
                    }
                }
                else
                {
                    $query = "INSERT INTO wms_clientportal.tbl_inbounditems (`CPI`, `ItemID`, `Beg_Quantity`, `Beg_Weight`,`Quantity`, `Weight`, `ExpiryDate`, `StatusID`, `UserID`, `StorageType`) VALUES ('$r_CPI', '$r_item', '$r_itemqty', 0, '$r_itemqty', 0, '$r_itemexpirydate', 1, '$r_user_id', 2)";
                    if(mysqli_query($conn, $query))
                    {
                        echo 'aSuccess';
                    }
                    else
                    {
                        echo "Error: " . $query . "<br>" . mysqli_error($conn);
                    }
                }
            }
        }
    }

    function AddReceivingItems($r_item, $r_itemqty, $r_itemexpirydate, $r_itemuom, $r_weight, $r_CPI)
    {
        include 'dbcon.php';

        $userid = $_SESSION['UserID'];

        if(!empty($r_CPI))
        {
            $query = "SELECT `UsersID`, `Status` FROM wms_clientportal.tbl_inbound WHERE CPI = '$r_CPI'";
            $result = mysqli_query($conn, $query);
            while($rows = mysqli_fetch_assoc($result))
            {
                $r_user_id = $rows['UsersID'];
                $r_status = $rows['Status'];
            }

            if($r_status == 2)
            {
                ifforapprovaladditem($r_item, $r_itemqty, $r_itemexpirydate, $r_itemuom, $r_weight, $r_CPI, $r_user_id);
            }
            else
            {
                $getfworcfsql = "SELECT Weight FROM wms_cloud.tbl_items WHERE ItemID = '$r_item'";
                $result = mysqli_query($conn, $getfworcfsql);
                while($row = mysqli_fetch_array($result))
                {
                    $wgt = $row[0];
                }

                if($wgt > 0)
                {
                    $query = "SELECT * FROM wms_clientportal.tbl_inbounditems WHERE ItemID = '$r_item' AND ExpiryDate ='$r_itemexpirydate' AND StatusID = 1 AND UserID = $userid";
                    $result = mysqli_query($conn, $query);
                    if(mysqli_num_rows($result) == 1)
                    {
                        while($row = mysqli_fetch_array($result))
                        {
                            $r_id = $row[0];
                            $quantity = $row[5];
                            $weight = $row[6];
                        }

                        $totalqtyitem = $quantity + $r_itemqty;
                        $totalbeg_weight = ($weight + ($r_itemqty * $r_weight));

                        $query = "UPDATE wms_clientportal.tbl_inbounditems SET Quantity = '$totalqtyitem', Beg_Quantity = '$totalqtyitem', Weight = '$totalbeg_weight', Beg_Weight = '$totalbeg_weight' WHERE ReceivingItemID = '$r_id'";
                        if(mysqli_query($conn, $query))
                        {
                            echo "Success!" . $totalbeg_weight . '-' . $weight;
                        }
                    }
                    else
                    {
                        $totalwgt = ($r_weight * $r_itemqty);

                        $query = "INSERT INTO wms_clientportal.tbl_inbounditems (`CPI`, `ItemID`, `Quantity`, `Beg_Quantity`, `Weight`, `Beg_Weight`, `ExpiryDate`, `StatusID`, `UserID`, `StorageType`) VALUES('$r_CPI', '$r_item', '$r_itemqty', '$r_itemqty', '$totalwgt', '$totalwgt', '$r_itemexpirydate', 1, '$userid', 1)";
                        if(mysqli_query($conn, $query))
                        {
                            echo 'Success';
                        }
                    }
                }
                else if($wgt == 0)
                {
                    if(($r_itemqty != null || $r_itemqty != "") && ($r_weight != null || $r_weight != ""))
                    {
                        $query = "SELECT ReceivingItemID, ItemID, ExpiryDate, StorageType, Quantity, Weight FROM wms_clientportal.tbl_inbounditems WHERE ItemID = '$r_item' AND ExpiryDate ='$r_itemexpirydate' AND StorageType = 2 AND StatusID = 1 AND UserID = $userid";
                        $result = mysqli_query($conn, $query);
                        if(mysqli_num_rows($result) == 1)
                        {
                            while($row = mysqli_fetch_array($result))
                            {
                                $r_id = $row[0];
                                $quantity = $row[4];
                                $weight = $row[5];
                            }

                            $totalqtyitem = $r_itemqty + $quantity;
                            $totalwgtitem = $r_weight + $weight;
                        
                            $query = "UPDATE wms_clientportal.tbl_inbounditems SET Weight = '$totalwgtitem', Beg_Weight = '$totalwgtitem', Quantity = '$totalqtyitem', Beg_Quantity = '$totalqtyitem' WHERE ReceivingItemID = '$r_id'";
                            if(mysqli_query($conn, $query))
                            {
                                echo 'Success';
                            }
                        }
                        else
                        {
                            $query = "INSERT INTO wms_clientportal.tbl_inbounditems (`CPI`, `ItemID`, `Quantity`, `Beg_Quantity`, `Weight`, `Beg_Weight`, `ExpiryDate`, `StatusID`, `UserID`, `StorageType`) VALUES('$r_CPI', '$r_item', '$r_itemqty', '$r_itemqty', '$r_weight', '$r_weight', '$r_itemexpirydate', 1, '$userid', 2)";
                            if(mysqli_query($conn, $query))
                            {
                                echo 'Success';
                            }
                        }
                    }
                    else if(($r_weight != '') && ($r_weight != null) && ($r_itemqty == '') && ($r_itemqty == null))
                    {
                        $query = "SELECT ReceivingItemID, ItemID, ExpiryDate, StorageType, Quantity, Weight FROM wms_clientportal.tbl_inbounditems WHERE ItemID = '$r_item' AND ExpiryDate ='$r_itemexpirydate' AND StorageType = 2 AND StatusID = 1 AND UserID = $userid AND Quantity = 0";
                        $result = mysqli_query($conn, $query);
                        if(mysqli_num_rows($result) == 1)
                        {
                            while($row = mysqli_fetch_array($result))
                            {
                                $r_id = $row[0];
                                $weight = $row[5];
                            }
                        
                            $totalwgtitem = $r_weight + $weight;
                        
                            $query = "UPDATE wms_clientportal.tbl_inbounditems SET Weight = '$totalwgtitem', Beg_Weight = '$totalwgtitem' WHERE ReceivingItemID = '$r_id'";
                            if(mysqli_query($conn, $query))
                            {
                                echo 'Success';
                            }
                        }
                        else
                        {
                            $query = "INSERT INTO wms_clientportal.tbl_inbounditems (`CPI`, `ItemID`, `Quantity`, `Beg_Quantity`, `Weight`, `Beg_Weight`, `ExpiryDate`, `StatusID`, `UserID`, `StorageType`) VALUES('$r_CPI', '$r_item', 0, 0, '$r_weight', '$r_weight', '$r_itemexpirydate', 1, '$userid', 2)";
                            if(mysqli_query($conn, $query))
                            {
                                echo 'Success';
                            }
                        }
                    }
                    else if(($r_weight == '') && ($r_weight == null) && ($r_itemqty != '') && ($r_itemqty != null))
                    {
                        $query = "SELECT ReceivingItemID, ItemID, ExpiryDate, StorageType, Quantity, Weight FROM wms_clientportal.tbl_inbounditems WHERE ItemID = '$r_item' AND ExpiryDate ='$r_itemexpirydate' AND StorageType = 2 AND StatusID = 1 AND UserID = $userid AND Weight = 0";
                        $result = mysqli_query($conn, $query);
                        if(mysqli_num_rows($result) == 1)
                        {
                            while($row = mysqli_fetch_array($result))
                            {
                                $r_id = $row[0];
                                $quantity = $row[4];
                                $weight = $row[5];
                            }
                            $totalqtyitem = $r_itemqty + $quantity;

                            $query = "UPDATE wms_clientportal.tbl_inbounditems SET Quantity = '$totalqtyitem', Beg_Quantity = '$totalqtyitem' WHERE ReceivingItemID = '$r_id'";
                            if(mysqli_query($conn, $query))
                            {
                                echo 'Success';
                            }
                        }
                        else
                        {
                            $query = "INSERT INTO wms_clientportal.tbl_inbounditems (`CPI`, `ItemID`, `Beg_Quantity`, `Beg_Weight`,`Quantity`, `Weight`, `ExpiryDate`, `StatusID`, `UserID`, `StorageType`) VALUES ('$r_CPI', '$r_item', '$r_itemqty', 0, '$r_itemqty', 0, '$r_itemexpirydate', 1, '$userid', 2)";
                            if(mysqli_query($conn, $query))
                            {
                                echo 'Success';
                            }
                            else
                            {
                                echo "Error: " . $query . "<br>" . mysqli_error($conn);
                            }
                        }
                    }
                }
            }
        }
        else
        {
            $getfworcfsql = "SELECT Weight FROM wms_cloud.tbl_items WHERE ItemID = '$r_item'";
            $result = mysqli_query($conn, $getfworcfsql);
            while($row = mysqli_fetch_array($result))
            {
                $wgt = $row[0];
            }

            if($wgt > 0)
            {
                $query = "SELECT * FROM wms_clientportal.tbl_inbounditems WHERE ItemID = '$r_item' AND ExpiryDate ='$r_itemexpirydate' AND StatusID = 0 AND UserID = $userid";
                $result = mysqli_query($conn, $query);
                if(mysqli_num_rows($result) == 1)
                {
                    while($row = mysqli_fetch_array($result))
                    {
                        $r_id = $row[0];
                        $quantity = $row[5];
                        $weight = $row[6];
                    }

                    $totalqtyitem = $quantity + $r_itemqty;
                    $totalbeg_weight = ($weight + ($r_itemqty * $r_weight));

                    $query = "UPDATE wms_clientportal.tbl_inbounditems SET Quantity = '$totalqtyitem', Beg_Quantity = '$totalqtyitem', Weight = '$totalbeg_weight', Beg_Weight = '$totalbeg_weight' WHERE ReceivingItemID = '$r_id'";
                    if(mysqli_query($conn, $query))
                    {
                        echo "Success!" . $totalbeg_weight . '-' . $weight;
                    }
                }
                else
                {
                    $totalwgt = ($r_weight * $r_itemqty);

                    $query = "INSERT INTO wms_clientportal.tbl_inbounditems (`ItemID`, `Quantity`, `Beg_Quantity`, `Weight`, `Beg_Weight`, `ExpiryDate`, `StatusID`, `UserID`, `StorageType`) VALUES('$r_item', '$r_itemqty', '$r_itemqty', '$totalwgt', '$totalwgt', '$r_itemexpirydate', 0, '$userid', 1)";
                    if(mysqli_query($conn, $query))
                    {
                        echo 'Success';
                    }
                }
            }
            else if($wgt == 0)
            {
                if(($r_itemqty != null || $r_itemqty != "") && ($r_weight != null || $r_weight != ""))
                {
                    $query = "SELECT ReceivingItemID, ItemID, ExpiryDate, StorageType, Quantity, Weight FROM wms_clientportal.tbl_inbounditems WHERE ItemID = '$r_item' AND ExpiryDate ='$r_itemexpirydate' AND StorageType = 2 AND StatusID = 0 AND UserID = $userid";
                    $result = mysqli_query($conn, $query);
                    if(mysqli_num_rows($result) == 1)
                    {
                        while($row = mysqli_fetch_array($result))
                        {
                            $r_id = $row[0];
                            $quantity = $row[4];
                            $weight = $row[5];
                        }

                        $totalqtyitem = $r_itemqty + $quantity;
                        $totalwgtitem = $r_weight + $weight;
                    
                        $query = "UPDATE wms_clientportal.tbl_inbounditems SET Weight = '$totalwgtitem', Beg_Weight = '$totalwgtitem', Quantity = '$totalqtyitem', Beg_Quantity = '$totalqtyitem' WHERE ReceivingItemID = '$r_id'";
                        if(mysqli_query($conn, $query))
                        {
                            echo 'Success';
                        }
                    }
                    else
                    {
                        $query = "INSERT INTO wms_clientportal.tbl_inbounditems (`ItemID`, `Quantity`, `Beg_Quantity`, `Weight`, `Beg_Weight`, `ExpiryDate`, `StatusID`, `UserID`, `StorageType`) VALUES('$r_item', '$r_itemqty', '$r_itemqty', '$r_weight', '$r_weight', '$r_itemexpirydate', 0, '$userid', 2)";
                        if(mysqli_query($conn, $query))
                        {
                            echo 'Success';
                        }
                    }
                }
                else if(($r_weight != '') && ($r_weight != null) && ($r_itemqty == '') && ($r_itemqty == null))
                {
                    $query = "SELECT ReceivingItemID, ItemID, ExpiryDate, StorageType, Quantity, Weight FROM wms_clientportal.tbl_inbounditems WHERE ItemID = '$r_item' AND ExpiryDate ='$r_itemexpirydate' AND StorageType = 2 AND StatusID = 0 AND UserID = $userid AND Quantity = 0";
                    $result = mysqli_query($conn, $query);
                    if(mysqli_num_rows($result) == 1)
                    {
                        while($row = mysqli_fetch_array($result))
                        {
                            $r_id = $row[0];
                            $weight = $row[5];
                        }
                    
                        $totalwgtitem = $r_weight + $weight;
                    
                        $query = "UPDATE wms_clientportal.tbl_inbounditems SET Weight = '$totalwgtitem', Beg_Weight = '$totalwgtitem' WHERE ReceivingItemID = '$r_id'";
                        if(mysqli_query($conn, $query))
                        {
                            echo 'Success';
                        }
                    }
                    else
                    {
                        $query = "INSERT INTO wms_clientportal.tbl_inbounditems (`ItemID`, `Quantity`, `Beg_Quantity`, `Weight`, `Beg_Weight`, `ExpiryDate`, `StatusID`, `UserID`, `StorageType`) VALUES('$r_item', 0, 0, '$r_weight', '$r_weight', '$r_itemexpirydate', 0, '$userid', 2)";
                        if(mysqli_query($conn, $query))
                        {
                            echo 'Success';
                        }
                    }
                }
                else if(($r_weight == '') && ($r_weight == null) && ($r_itemqty != '') && ($r_itemqty != null))
                {
                    $query = "SELECT ReceivingItemID, ItemID, ExpiryDate, StorageType, Quantity, Weight FROM wms_clientportal.tbl_inbounditems WHERE ItemID = '$r_item' AND ExpiryDate ='$r_itemexpirydate' AND StorageType = 2 AND StatusID = 0 AND UserID = $userid AND Weight = 0";
                    $result = mysqli_query($conn, $query);
                    if(mysqli_num_rows($result) == 1)
                    {
                        while($row = mysqli_fetch_array($result))
                        {
                            $r_id = $row[0];
                            $quantity = $row[4];
                            $weight = $row[5];
                        }
                        $totalqtyitem = $r_itemqty + $quantity;

                        $query = "UPDATE wms_clientportal.tbl_inbounditems SET Quantity = '$totalqtyitem', Beg_Quantity = '$totalqtyitem' WHERE ReceivingItemID = '$r_id'";
                        if(mysqli_query($conn, $query))
                        {
                            echo 'Success';
                        }
                    }
                    else
                    {
                        $query = "INSERT INTO wms_clientportal.tbl_inbounditems (`ItemID`, `Beg_Quantity`, `Beg_Weight`,`Quantity`, `Weight`, `ExpiryDate`, `StatusID`, `UserID`, `StorageType`) VALUES ('$r_item', '$r_itemqty', 0, '$r_itemqty', 0, '$r_itemexpirydate', 0, '$userid', 2)";
                        if(mysqli_query($conn, $query))
                        {
                            echo 'Success';
                        }
                        else
                        {
                            echo "Error: " . $query . "<br>" . mysqli_error($conn);
                        }
                    }
                }
            }
        }
    }

    function AddedItemsSummary($r_CPI)
    {
        include 'dbcon.php';

        $userid = $_SESSION['UserID'];
        $Cusid = $_SESSION['CustomerId'];

        if(!empty($r_CPI))
        {
            $query = "SELECT CommonCode FROM wms_cloud.tbl_customers_users WHERE id = '$userid'";
            $result = mysqli_query($conn, $query);
            if(mysqli_num_rows($result) > 0)
            {
                $row = mysqli_fetch_array($result);
                $commoncode = $row[0];
        
                $query = "SELECT ii.ReceivingItemID, ii.CPI, i.ItemID, i.ItemDesc, i.ItemCode, i.Client_SKU, uom.UOM_Abv, SUM(ii.Quantity), ii.StorageType, ii.ExpiryDate, SUM(ii.beg_Weight)
                FROM wms_clientportal.tbl_inbounditems ii
                LEFT JOIN wms_cloud.tbl_items i ON ii.ItemID = i.ItemID
                LEFT JOIN wms_cloud.tbl_weightuom uom ON i.UOMID = uom.UOMID 
                LEFT JOIN wms_cloud.tbl_customers_users cu ON ii.UserID = cu.id
                LEFT JOIN wms_clientportal.tbl_inbound inbound ON ii.CPI = inbound.CPI
                WHERE ii.CPI = '$r_CPI' AND cu.CommonCode = '$commoncode' AND ii.StatusID != 2
                GROUP BY i.ItemID, ii.ExpiryDate, ii.ReceivingItemID";
                $result = mysqli_query($conn, $query);
                if(mysqli_num_rows($result) < 0)
                {
                   echo '<tr>
                            <td></td>
                            <td>No Data Found.</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>';
                }
                else
                {
                    while($rows = mysqli_fetch_array($result))
                    {
                        echo '<tr>
                                <td>'.$rows[3].'('.$rows[4].' - '.$rows[5].')</td>
                                <td>'.number_format($rows[7], 2).'</td>
                                <td>'.$rows[6].'</td>
                                <td>'.number_format($rows[10], 2).'</td>
                                <td>'.date("d M Y", strtotime($rows[9])).'</td>
                                <td><div class="btn-group d-flex justify-content-center">
                                <button class="border-0 shadow-0" style="background-color: transparent" onclick="modalremoveconfirmation('.$rows[0].')"><i class="far fa-trash-alt" data-toggle="tooltip" data-placement="left" title="Delete Item"></i></button>
                                <button class="border-0 shadow-0" style="background-color: transparent" onclick="getitemdetailscanedit('.$rows[0].')" data-toggle="tooltip" data-placement="left" title="Edit Item"><i class="far fa-edit"></i></button>
                                </div>
                                </td>
                            </tr>';
                    
                    }
                }
            }
        }
        else
        {
            $query = "SELECT ii.ReceivingItemID, ii.CPI, i.ItemID, i.ItemDesc, i.ItemCode, i.Client_SKU, uom.UOM_Abv, SUM(ii.Quantity), ii.StorageType, ii.ExpiryDate, SUM(ii.beg_Weight)
            FROM wms_clientportal.tbl_inbounditems ii
            LEFT JOIN wms_cloud.tbl_items i ON ii.ItemID = i.ItemID
            LEFT JOIN wms_cloud.tbl_weightuom uom ON i.UOMID = uom.UOMID 
            LEFT JOIN wms_cloud.tbl_customers_users cu ON ii.UserID = cu.id
            LEFT JOIN wms_clientportal.tbl_inbound inbound ON ii.CPI = inbound.CPI
            WHERE ii.StatusID = 0 AND ii.UserID = '$userid' AND ii.StatusID != 2
            GROUP BY i.ItemID, ii.ExpiryDate, ii.ReceivingItemID";
            $result = mysqli_query($conn, $query);
            if(mysqli_num_rows($result) < 0)
            {
                echo '<tr>
                        <td></td>
                        <td>No Data Found.</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>';
            }
            else
            {
                while($rows = mysqli_fetch_array($result))
                {
                    echo '<tr>
                            <td>'.$rows[3].'('.$rows[4].' - '.$rows[5].')</td>
                            <td>'.number_format($rows[7], 2).'</td>
                            <td>'.$rows[6].'</td>
                            <td>'.number_format($rows[10], 2).'</td>
                            <td>'.date("d M Y", strtotime($rows[9])).'</td>
                            <td><div class="btn-group d-flex justify-content-center">
                            <button class="border-0 shadow-0" style="background-color: transparent" onclick="modalremoveconfirmation('.$rows[0].')" data-toggle="tooltip" data-placement="left" title="Delete Item"><i class="far fa-trash-alt"></i></button>
                            <button class="border-0 shadow-0" style="background-color: transparent" onclick="getitemdetailscanedit('.$rows[0].')" data-toggle="tooltip" data-placement="left" title="Edit Item"><i class="far fa-edit"></i></button>
                            </div>
                            </td>
                        </tr>';
                }
            }
        }
    }

    function GetItemDetailsCanEdit($id)
    {
        include 'dbcon.php';

        $query = "CALL wms_clientportal.SP_GetItemDetailsCanEdit('$id')";
        $result = mysqli_query($conn, $query);

        while( $row = mysqli_fetch_array($result))
        {
            $arr[] = array(
                'quantity'=>$row[5],
                'weight'=>number_format($row[6], 2),
                'expirydate'=>date("Y-m-d", strtotime($row[8])),
                'storagetype'=>$row[7]
            );
        }

        echo json_encode($arr);
        exit();
    }

    function EditItemDetails($ris_itemid, $qty, $wgt, $expiry)
    {
        include 'dbcon.php';

        $query = "SELECT StorageType FROM wms_clientportal.tbl_inbounditems WHERE ReceivingItemID = '$ris_itemid'";
        $res = mysqli_query($conn, $query);

        if(mysqli_num_rows($res) == 1)
        {
            while($row = mysqli_fetch_array($res))
            {
                $type = $row[0];
            }
            if($type == '1')
            {
                $query = "SELECT ItemID FROM wms_clientportal.tbl_inbounditems WHERE ReceivingItemID = '$ris_itemid'";
                $result = mysqli_query($conn, $query);
                if(mysqli_num_rows($result) == 1)
                {
                    while($row = mysqli_fetch_array($result))
                    {
                        $r_itemid = $row[0];
                    }
                    $query = "SELECT Weight FROM wms_cloud.tbl_items WHERE ItemID = '$r_itemid'";
                    $result = mysqli_query($conn, $query);
                    if(mysqli_num_rows($result))
                    {
                        while($row = mysqli_fetch_array($result))
                        {
                            $wght = $row[0];
                        }
                        $beg_weight = $qty * $wght;
                        $query = "UPDATE wms_clientportal.tbl_inbounditems SET Beg_Quantity = '$qty', Beg_Weight = '$beg_weight', Quantity = '$qty', Weight = '$beg_weight', ExpiryDate = '$expiry' WHERE ReceivingItemID = '$ris_itemid'";

                        if(mysqli_query($conn, $query))
                        {
                            echo 'Edit Success!';
                        }
                        else
                        {
                            echo "Error: " . $query . "<br>" . mysqli_error($conn);
                        }
                    }
                }
                else
                {
                    echo "Error: " . $query . "<br>" . mysqli_error($conn);
                }
            }
            else
            {
                $query = "SELECT ItemID FROM wms_clientportal.tbl_inbounditems WHERE ReceivingItemID = '$ris_itemid'";
                $result = mysqli_query($conn, $query);
                if(mysqli_num_rows($result) == 1)
                {
                    while($row = mysqli_fetch_array($result))
                    {
                        $r_itemid = $row[0];
                    }

                    if(($qty != '' || $qty != null) || ($wgt != '' || $wgt != null))
                    {
                        $query = "UPDATE wms_clientportal.tbl_inbounditems SET Beg_Quantity = '$qty', Beg_Weight = '$wgt', Quantity = '$qty', Weight = '$wgt', ExpiryDate = '$expiry' WHERE ReceivingItemID = '$ris_itemid'";

                        if(mysqli_query($conn, $query))
                        {
                            echo 'Edit Success!';
                        }
                        else
                        {
                            echo "Error: " . $query . "<br>" . mysqli_error($conn);
                        }
                    }
                    else if(($qty == '' || $qty == null) && ($wgt != '' || $wgt != null))
                    {
                        $query = "UPDATE wms_clientportal.tbl_inbounditems SET Beg_Quantity = '$wgt', Beg_Weight = '$wgt', Quantity = '$wgt', Weight = '$wgt', ExpiryDate = '$expiry' WHERE ReceivingItemID = '$itemid'";

                        if(mysqli_query($conn, $query))
                        {
                            echo 'Edit Success!';
                        }
                        else
                        {
                            echo "Error: " . $query . "<br>" . mysqli_error($conn);
                        }
                    }
                    else if(($qty != '' || $qty != null) && ($wgt == '' || $wgt == null))
                    {
                        $query = "UPDATE wms_clientportal.tbl_inbounditems SET Beg_Quantity = '$qty', Beg_Weight = '$qty', Quantity = '$qty', Weight = '$qty', ExpiryDate = '$expiry' WHERE ReceivingItemID = '$ris_itemid'";

                        if(mysqli_query($conn, $query))
                        {
                            echo 'Edit Success!';
                        }
                        else
                        {
                            echo "Error: " . $query . "<br>" . mysqli_error($conn);
                        }
                    }
                }
                else
                {
                    echo "Error: " . $query . "<br>" . mysqli_error($conn);
                }
            }
        }
    }

    function removeItem($itemid)
    {
        include 'dbcon.php';
        // $query = "CALL wms_clientportal.SP_removeItem('$itemid')";
        $query = "UPDATE wms_clientportal.tbl_inbounditems SET StatusID = 2 WHERE ReceivingItemID = $itemid";
        if(mysqli_query($conn, $query))
        {
            echo 'Remove Success';
        }
        else
        {
            echo "Error: " . $query . "<br>" . mysqli_error($conn);
        }
    }

    function forApprove($r_CPI, $warehouse, $trucktype, $dateofarrival, $containerno, $plateno, $suppliername, $sealnumber, $client_rep, $remarks)
    {
        include 'dbcon.php';

        $userid = $_SESSION['UserID'];
        $CusID = $_SESSION['CustomerId'];

        $query = "SELECT * FROM wms_cloud.tbl_customers_users WHERE id = '$userid' LIMIT 1";
        $result = mysqli_query($conn, $query);
        $row = mysqli_fetch_assoc($result);
        $username = $row['CusName'];

        if(empty($r_CPI))
        {

            $query = "SELECT * FROM wms_clientportal.tbl_inbounditems WHERE UserID = '$userid' AND StatusID = 0 AND StatusID != 2";
            $result = mysqli_query($conn, $query);
            if(mysqli_num_rows($result) > 0)
            {

                $CPI = generateCPI();
                $query = "INSERT INTO wms_clientportal.tbl_inbound (`CPI`, `CusID`, `Date_created`, `Status`, `UsersID`, `CreatedBy`, `LastUpdatedBy`) VALUES ('$CPI', '$CusID', NOW(), 3, '$userid', '$username', '$username') ";
                if(mysqli_query($conn, $query))
                {
                            
                    $query = "SELECT * FROM wms_clientportal.tbl_inbounditems WHERE UserID = '$userid' AND StatusID = 0 AND StatusID != 2";
                    $result = mysqli_query($conn, $query);
                    if(mysqli_num_rows($result) > 0)
                    {

                        while($rows = mysqli_fetch_array($result))
                        {
                            $query = "UPDATE wms_clientportal.tbl_inbounditems ii SET ii.CPI = '$CPI', ii.StatusID = 1 WHERE UserID = $userid AND StatusID = 0 AND StatusID != 2";
                            if(mysqli_query($conn, $query))
                            {
                                        
                            }
                            else
                            {
                                echo 0;
                            }
                        }

                        $query = "INSERT INTO wms_inbound.tbl_receiving (`CusID`, `ReceivingDate`, `ASN`, `Container`, `VehiclePlate`, `RequestedBy`, `Seal`, `Remarks`, `FromCP`, `CPStatus_id`, `Warehouse_id`, `TruckType`, `Supplier`, `CreatedBy`, `LastUpdatedBy`) VALUES ('$CusID', '$dateofarrival', '$CPI', '$containerno', '$plateno', '$client_rep', '$sealnumber', '$remarks', 'True', 3, $warehouse, '$trucktype', '$suppliername', '$username', '$username')";
                        if(mysqli_query($conn, $query))
                        {

                            $query = "SELECT TempIBN FROM wms_inbound.tbl_temp LIMIT 1";
                            $result = mysqli_query($conn, $query);
                            if(mysqli_num_rows($result) == 1)
                            {

                                $row = mysqli_fetch_array($result);

                                $TempIBN = $row[0];

                                $NewTempIBN = $TempIBN + 1;

                                $query = "UPDATE wms_inbound.tbl_temp SET TempIBN = $NewTempIBN";
                                if(mysqli_query($conn, $query))
                                {

                                    $IBN = "IBN".sprintf('%09d', $NewTempIBN);
                                    $query = "UPDATE wms_inbound.tbl_receiving SET StatusID = 1, IBN = '$IBN' WHERE ASN = '$CPI'";
                                    if(mysqli_query($conn, $query))
                                    {
                                        echo $CPI;

                                        $query = "SELECT * FROM wms_clientportal.tbl_inbounditems WHERE CPI = '$CPI' AND StatusID != 2";
                                        $result = mysqli_query($conn, $query);
                                        if(mysqli_num_rows($result) > 0)
                                        {
                                            while($row = mysqli_fetch_array($result))
                                            {
                                                $itemid = $row[2];
                                                $quantity = $row[5];
                                                $beg_quantity = $row[3];
                                                $weight = $row[6];
                                                $beg_weight = $row[4];
                                                $storagetype = $row[7];
                                                $expirydate = $row[8];

                                                $query = "INSERT INTO wms_inbound.tbl_receivingitemsummary(`IBN`, `ItemID`, `Quantity`, `Beg_Quantity`, `Weight`, `Beg_Weight`, `StorageType`, `ExpiryDate`) VALUES ('$IBN', '$itemid', '$quantity', '$beg_quantity', '$weight', '$beg_weight', '$storagetype', '$expirydate')";
                                                if(mysqli_query($conn, $query))
                                                {
                                                    
                                                }
                                            }
                                            
                                        }
                                        else
                                        {
                                            echo 0;
                                        }
                                    }
                                    else
                                    {
                                        echo 0;
                                    }
                                }
                                else
                                {
                                    echo 0;
                                }

                            }
                            else
                            {
                                echo 0;
                            }
                        }
                    }
                    else
                    {
                        echo 0;
                    }
                }
                else
                {
                    echo 0;
                }
            }
            else
            {
                echo 0;
            }
        }
        else
        {
            $query = "UPDATE wms_clientportal.tbl_inbound SET Status = 3 WHERE CPI = '$r_CPI'";
            if(mysqli_query($conn, $query))
            {
                $query = "SELECT TempIBN FROM wms_inbound.tbl_temp LIMIT 1";
                $result = mysqli_query($conn, $query);
                if(mysqli_num_rows($result) == 1)
                {
                    echo '1';

                    $row = mysqli_fetch_array($result);

                    $TempIBN = $row[0];

                    $NewTempIBN = $TempIBN + 1;

                    $query = "UPDATE wms_inbound.tbl_temp SET TempIBN = $NewTempIBN";
                    if(mysqli_query($conn, $query))
                    {
                        echo '2';

                        $IBN = "IBN".sprintf('%09d', $NewTempIBN);
                        $query = "UPDATE wms_inbound.tbl_receiving SET CPStatus_id = '3', StatusID = '1', IBN = '$IBN' WHERE ASN = '$r_CPI'";
                        if(mysqli_query($conn, $query))
                        {
                            echo '3';
                        }

                        $query = "SELECT * FROM wms_clientportal.tbl_inbounditems WHERE CPI = '$r_CPI' AND StatusID != 2";
                        $result = mysqli_query($conn, $query);
                        if(mysqli_num_rows($result) > 0)
                        {
                            while($row = mysqli_fetch_array($result))
                            {
                                $itemid = $row[2];
                                $quantity = $row[5];
                                $beg_quantity = $row[3];
                                $weight = $row[6];
                                $beg_weight = $row[4];
                                $storagetype = $row[7];
                                $expirydate = $row[8];

                                $query = "INSERT INTO wms_inbound.tbl_receivingitemsummary(`IBN`, `ItemID`, `Quantity`, `Beg_Quantity`, `Weight`, `Beg_Weight`, `StorageType`, `ExpiryDate`) VALUES ('$IBN', '$itemid', '$quantity', '$beg_quantity', '$weight', '$beg_weight', '$storagetype', '$expirydate')";
                                if(mysqli_query($conn, $query))
                                {
                                    echo 'Success to pass data to inbound receivingitemsummary';
                                }
                            }
                        }
                        else
                        {
                            echo "Error: " . $query . "<br>" . mysqli_error($conn);
                        }
                    }
                    else
                    {
                        echo "Error: " . $query . "<br>" . mysqli_error($conn);
                    }
                }
                else
                {
                    echo "Error: " . $query . "<br>" . mysqli_error($conn);
                }
            }
            else
            {
                echo "Error: " . $query . "<br>" . mysqli_error($conn);
            }
        }
    }

    function generateCPI()
    {
        include 'dbcon.php';
        $query = "SELECT TempCPI FROM wms_clientportal.tbl_temp LIMIT 1";
        $result = mysqli_query($conn, $query);
        if(mysqli_num_rows($result) < 0)
        {
            $TempCPI = 1;
            $query = "UPDATE wms_clientportal.tbl_temp SET TempCPI = '$TempCPI'";
            if(mysqli_query($conn, $query))
            {
                // echo $TempCPI = 1;
                return "CPI".sprintf('%09d', $TempCPI);
            }
            else
            {
                echo "Error: " . $query . "<br>" . mysqli_error($conn);
            }
        }
        else
        {
            $row = mysqli_fetch_array($result);

            $TempCPI = $row[0];
            $NewTempCPI = $TempCPI + 1;

            $query = "UPDATE wms_clientportal.tbl_temp SET TempCPI = $NewTempCPI ";
            if(mysqli_query($conn, $query))
            {
                // echo $NewTempCPI;
                return "CPI".sprintf('%09d', $NewTempCPI);
            }
            else
            {
                echo "Error: " . $query . "<br>" . mysqli_error($conn);
            }
        }
    }

    function SubmitReceivingTransaction($r_CPI, $receiving_selectedWH, $receiving_selectedTruck, $receiving_datearrive, $receiving_containerno, $receiving_vehicleplateno, $receiving_suppliername, $receiving_sealno, $receiving_clientrepresentative, $receiving_remarks)
    {
        include 'dbcon.php';

        $userid = $_SESSION['UserID'];
        $CusID = $_SESSION['CustomerId'];

        $query = "SELECT * FROM wms_cloud.tbl_customers_users WHERE id = '$userid' LIMIT 1";
        $result = mysqli_query($conn, $query);
        $row = mysqli_fetch_assoc($result);
        $username = $row['CusName'];

        if(empty($r_CPI))
        {
            $CPI = generateCPI();
            // $CPI = "CPI".sprintf('%09d', $TempCPI);
            // echo $CPI;

            $query = "INSERT INTO wms_inbound.tbl_receiving (`CusID`, `ReceivingDate`, `ASN`, `Container`, `VehiclePlate`, `RequestedBy`, `Seal`, `Remarks`, `FromCP`, `CPStatus_id`, `Warehouse_id`, `TruckType`, `Supplier`, `CreatedBy`, `LastUpdatedBy`) VALUES ('$CusID', '$receiving_datearrive', '$CPI', '$receiving_containerno', '$receiving_vehicleplateno', '$receiving_clientrepresentative', '$receiving_sealno', '$receiving_remarks', 'True', 2, $receiving_selectedWH, '$receiving_selectedTruck', '$receiving_suppliername', '$username', '$username')";
            if(mysqli_query($conn, $query))
            {

                $query = "INSERT INTO wms_clientportal.tbl_inbound (`CPI`, `CusID`, `Date_created`, `Status`, `UsersID`, `CreatedBy`, `LastUpdatedBy`) VALUES ('$CPI', '$CusID', NOW(), 2, '$userid', '$username', '$username')";
                if(mysqli_query($conn, $query))
                {
                    
                    $query = "SELECT * FROM wms_clientportal.tbl_inbounditems WHERE UserID = '$userid' AND StatusID = 0";
                    $result = mysqli_query($conn, $query);
                    if(mysqli_num_rows($result) > 0)
                    {
                        echo $CPI;
                        
                        while($rows = mysqli_fetch_array($result))
                        {
                            $query = "UPDATE wms_clientportal.tbl_inbounditems ii SET ii.CPI = '$CPI', ii.StatusID = 1 WHERE UserID = '$userid' AND StatusID = 0";
                            if(mysqli_query($conn, $query))
                            {

                            }
                            else
                            {
                                echo "Error: " . $query . "<br>" . mysqli_error($conn);
                            }
                        }
                    }
                    else
                    {
                        echo 0;
                    }
                }
                else
                {
                    echo 0;
                }
            }
            else
            {
                echo 0;
            }
        }
        else
        {
            $query = "UPDATE wms_clientportal.tbl_inbound i SET i.Status = 2, i.LastUpdatedBy = '$username', i.UsersID = '$userid' WHERE i.CPI = '$r_CPI' LIMIT 1";
            if(mysqli_query($conn, $query))
            {
                $query = "UPDATE wms_inbound.tbl_receiving i SET i.CPStatus_id = 2 WHERE ASN = '$r_CPI' LIMIT 1";
                $result = mysqli_query($conn, $query);

                $query = "SELECT * FROM wms_clientportal.tbl_inbounditems WHERE CPI = '$r_CPI' AND StatusID = 1";
                $result = mysqli_query($conn, $query);
                if(mysqli_num_rows($result) > 0)
                {
                    echo 1;
                    while($rows = mysqli_fetch_array($result))
                    {
                        $query = "UPDATE wms_clientportal.tbl_inbounditems SET UserID = '$userid' WHERE CPI = '$r_CPI'";
                        if(mysqli_query($conn, $query))
                        {
                                    
                        }
                        else
                        {
                            echo "Error: " . $query . "<br>" . mysqli_error($conn);
                        }
                    }
                }
                else
                {
                    echo 0;
                }
            }
            else
            {
                echo "Error: " . $query . "<br>" . mysqli_error($conn);
            }
            

            $query = "UPDATE wms_inbound.tbl_receiving r SET r.ReceivingDate = '$receiving_datearrive', r.Container = '$receiving_containerno', r.VehiclePlate = '$receiving_vehicleplateno', r.RequestedBy = '$receiving_clientrepresentative', r.Seal = '$receiving_sealno', r.Remarks = '$receiving_remarks', r.Warehouse_id = '$receiving_selectedWH', r.TruckType = '$receiving_selectedTruck', r.Supplier = '$receiving_suppliername' WHERE r.ASN = '$r_CPI'";
            if(mysqli_query($conn, $query))
            {

            }
            else
            {
                echo "Error: " . $query . "<br>" . mysqli_error($conn);
            }
        }
    }

    function forApproveBtn()
    {
        $userID = $_SESSION['UserID'];

        include 'dbcon.php';

        $query = "CALL wms_clientportal.SP_forApproveBtn('$userID')";
        $result = mysqli_query($conn, $query);
        while($row = mysqli_fetch_array($result))
        {
            $role_id = $row[0];
        }

        if($role_id == 1)
        {
            echo '<button class="btn btn-primary my-2" onclick="approvalconfirmation()">Approve</button>
            <button class="btn btn-primary float-center" onclick="returntopending()">Return to Pending</button>';
        }
        else
        {
            echo '<button class="btn btn-primary my-2" onclick="submitconfirmation()" id="SubmitBtn" disabled>Submit</button>';
        }
    }

    function CheckIfHasReceivingItems($CPI)
    {
        include 'dbcon.php';
        $userID = $_SESSION['UserID'];

        if(empty($CPI))
        {
            $query = "SELECT * FROM wms_clientportal.tbl_inbounditems WHERE UserID ='$userID' AND StatusID = 0";
            $result = mysqli_query($conn, $query);
            if(mysqli_num_rows($result) > 0)
            {
                echo '1';
            }
            else
            {
                echo '0';
            }
        }
        else
        {
            $query = "SELECT * FROM wms_clientportal.tbl_inbounditems WHERE CPI = '$CPI'";
            $result = mysqli_query($conn, $query);
            if(mysqli_num_rows($result) > 0)
            {
                echo '1';
            }
            else
            {
                echo '0';
            }
        }
    }

    function item_checker($CPI)
    {
        include 'dbcon.php';
        $userID = $_SESSION['UserID'];

        if(empty($CPI))
        {
            $query = "SELECT * FROM wms_clientportal.tbl_inbounditems WHERE UserID ='$userID' AND StatusID != 2";
            $result = mysqli_query($conn, $query);
            if(mysqli_num_rows($result) > 0)
            {
                echo '1';
            }
            else
            {
                echo '0';
            }
        }
        else
        {
            $query = "SELECT * FROM wms_clientportal.tbl_inbounditems WHERE CPI = '$CPI' AND StatusID != 2";
            $result = mysqli_query($conn, $query);
            if(mysqli_num_rows($result) > 0)
            {
                echo '1';
            }
            else
            {
                echo '0';
            }
        }
    }

    function ImportedReceivingItems($receivingitems, $cpi)
    {
        include 'dbcon.php';

        $receivingitems = json_decode($receivingitems, true);
        $noofreceivingitems = count($receivingitems);
        $userid = $_SESSION['UserID'];

        $query = "SELECT CommonCode, CustomerID FROM wms_cloud.tbl_customers_users cu 
        LEFT JOIN wms_cloud.tbl_customers c ON c.CustomerCommonCode = cu.CommonCode
        WHERE cu.id = $userid";
        $result = mysqli_query($conn, $query);
        while ($row = mysqli_fetch_array($result)) 
        {
            $ClientID = $row[1];
        }

        $receivingtoDB = [];
        $faileditemreceiving = [];
        for ($x=0; $x < $noofreceivingitems; $x++) 
        { 
            $item = $receivingitems[$x]['ItemDesc'];

            $query = "SELECT 
            `ItemID`, 
            `Weight`, 
            CASE
                WHEN Weight = 0 THEN 2
                ELSE 1
            END AS StoringType,
            uom.UOM_Abv
            From wms_cloud.tbl_items i
            LEFT JOIN wms_cloud.tbl_weightuom uom ON uom.UOMID = i.UOMID
            WHERE ItemDesc = '$item' AND ItemCustomerID = $ClientID LIMIT 1";
            $result = mysqli_query($conn, $query); 
            if(mysqli_num_rows($result) >= 1)
            {
                while($rows = mysqli_fetch_array($result))
                {
                    $itemid = $rows[0];
                    $weight = $rows[1];
                    $storingtype = $rows[2];
                    $uom = $rows[3];
                }

                $isfloat = 0;
                $totalwgt = $receivingitems[$x]['Quantity'] * $weight;
                array_push($receivingtoDB, [
                    "itemid" => $itemid, 
                    "itemdesc" => $receivingitems[$x]['ItemDesc'], 
                    "quantity" => $receivingitems[$x]['Quantity'], 
                    "uom" => $uom, 
                    "weight" => $totalwgt, 
                    "expirydate" => $receivingitems[$x]['ExpiryDate'], 
                    "isfloat" => $isfloat, 
                    "UserID" => $userid, 
                    "StoringType" => $storingtype
                ]);

                $itemid = $receivingtoDB[$x]['itemid'];
                $quantity = $receivingtoDB[$x]['quantity'];
                $weight = $receivingtoDB[$x]['weight'];
                $expirydate = $receivingtoDB[$x]['expirydate'];
                $StatusID = $receivingtoDB[$x]['isfloat'];
                $UserID = $receivingtoDB[$x]['UserID'];
                $StoringType = $receivingtoDB[$x]['StoringType'];

                if(!empty($cpi))
                {
                    $query = "INSERT INTO wms_clientportal.tbl_inbounditems (`CPI`, `ItemID`, `Quantity`, `Weight`, `Beg_Quantity`, `Beg_Weight`, `StorageType`, `ExpiryDate`, `StatusID`, `UserID`) VALUES ('$cpi', '$itemid','$quantity','$weight','$quantity','$weight','$StoringType','$expirydate','$StatusID','$UserID')";
                    $result = mysqli_query($conn, $query);
                }
                else
                {
                    $query = "INSERT INTO wms_clientportal.tbl_inbounditems (`ItemID`, `Quantity`, `Weight`, `Beg_Quantity`, `Beg_Weight`, `StorageType`, `ExpiryDate`, `StatusID`, `UserID`) VALUES ('$itemid','$quantity','$weight','$quantity','$weight','$StoringType','$expirydate','$StatusID','$UserID')";
                    $result = mysqli_query($conn, $query);
                }

                

                unset($itemid, $quantity, $weight, $expirydate, $StatusID, $UserID, $StoringType, $uom, $storingtype, $totalwgt, $isfloat);
            }
            else
            {

                array_push($faileditemreceiving, [
                    "itemid" => "", 
                    "itemdesc" => $receivingitems[$x]['ItemDesc'], 
                    "quantity" => $receivingitems[$x]['Quantity'], 
                    "uom" => $receivingitems[$x]['UOM'], 
                    "weight" => $receivingitems[$x]['Weight'], 
                    "expirydate" => $receivingitems[$x]['ExpiryDate'], 
                    "isfloat" => "", 
                    "UserID" => $userid, 
                    "StoringType" => ""
                ]);
            }
        }

        if(!empty($faileditemreceiving))
        {
            $count = count($faileditemreceiving);

            for ($j=0; $j < $count; $j++) { 
                
                echo '<tr>
                        <td>'.$faileditemreceiving[$j]['itemdesc'].'</td>
                        <td>'.$faileditemreceiving[$j]['quantity'].'</td>
                        <td>'.$faileditemreceiving[$j]['uom'].'</td>
                        <td>'.$faileditemreceiving[$j]['weight'].'</td>
                        <td>'.$faileditemreceiving[$j]['expirydate'].'</td>
                    </tr>';
            }
        }
        else
        {
            echo 0;
        }

        print_r($receivingtoDB);
        print_r($faileditemreceiving);
        echo $query;
    }

// ReceivingModule


// OrderModule

    function generateCPO()
    {
        include 'dbcon.php';
        $query = "SELECT TempCPO FROM wms_clientportal.tbl_temp LIMIT 1";
        $result = mysqli_query($conn, $query);
        if(mysqli_num_rows($result) < 0)
        {
            $TempCPO = 1;
            $query = "UPDATE wms_clientportal.tbl_temp SET TempCPO = '$TempCPO'";
            if(mysqli_query($conn, $query))
            {
                // echo $TempCPI = 1;
                return "CPO".sprintf('%09d', $TempCPO);
            }
            else
            {
                echo "Error: " . $query . "<br>" . mysqli_error($conn);
            }
        }
        else
        {
            $row = mysqli_fetch_array($result);

            $TempCPO = $row[0];
            $NewTempCPO = $TempCPO + 1;

            $query = "UPDATE wms_clientportal.tbl_temp SET TempCPO = $NewTempCPO ";
            if(mysqli_query($conn, $query))
            {
                // echo $NewTempCPI;
                return "CPO".sprintf('%09d', $NewTempCPO);
            }
            else
            {
                echo "Error: " . $query . "<br>" . mysqli_error($conn);
            }
        }
    }

    function Order_GetAllItems()
    {
        include 'dbcon.php';

        $usersID = $_SESSION['UserID'];
        $userid = $_SESSION['CustomerId'];

        $query = "CALL wms_clientportal.SP_Order_GetAllItems('$userid')";
        $result = mysqli_query($conn, $query);
        while($rows = mysqli_fetch_assoc($result))
        {
            echo '<option value='.$rows['ItemID'].'>'.$rows['ItemDesc']. '('.$rows['Client_SKU'].')</option>';
        }
    }

    function AddOrderItemwithCPO()
    {
        include 'dbcon.php';

        $usersID = $_SESSION['UserID'];

        $Ordered_Item = $_SESSION['Ordered_Item'];
        $Ordered_Qty = $_SESSION['Ordered_Qty'];
        $Ordered_Wtg = $_SESSION['Ordered_Wtg'];
        $SOnumber = $_SESSION['SOnumber'];
        $CPO = $_SESSION['CPO'];

        $query = "SELECT i.ItemID, i.ItemDesc, i.Weight FROM wms_cloud.tbl_items i WHERE i.ItemID = '$Ordered_Item'";
            $result = mysqli_query($conn, $query);
            if(mysqli_num_rows($result) > 0)
            {
                $row = mysqli_fetch_array($result);
                $gotWgt = $row[2];

                if($gotWgt > 0)
                    {
                        $query = "SELECT id, ItemID, Quantity, Weight, GivenQty FROM wms_clientportal.tbl_storeorderitems WHERE ItemID = '$Ordered_Item' AND isFloat = 1 AND UserID = $usersID  AND CPO = '$CPO'";
                        $result = mysqli_query($conn, $query);
                        if(mysqli_num_rows($result) > 0)
                        {   
                            while($row = mysqli_fetch_array($result))
                            {
                                $id = $row[0];
                                $quantity = $row[2];
                                $weight = $row[3];
                            }
                            $new_qty = $Ordered_Qty + $quantity;
                            $new_wgt = ($new_qty * $gotWgt);
                            $query = "UPDATE wms_clientportal.tbl_storeorderitems SET Quantity = '$new_qty', Weight = '$new_wgt', GivenQty = '$new_qty' WHERE id = '$id'";
                            $result = mysqli_query($conn, $query);
                        }
                        else
                        {
                            $totalwgt = ($Ordered_Qty * $gotWgt);
                            $query = "INSERT INTO wms_clientportal.tbl_storeorderitems (`SO`, `ItemID`, `Quantity`, `Weight`, `GivenQty`, `isFloat`, `UserID`, `CPO`) VALUES ('$SOnumber', '$Ordered_Item', '$Ordered_Qty', '$totalwgt', '$Ordered_Qty', 1, '$usersID', '$CPO')";
                            if(mysqli_query($conn, $query))
                            {
                                echo '1s';
                            }
                        }
                    }
                    else
                    {
                        
                        if(($Ordered_Wtg == null && $Ordered_Wtg == "") && ($Ordered_Qty != null && $Ordered_Qty != ""))
                        {
                            $query = "SELECT id, ItemID, Quantity, Weight, GivenQty FROM wms_clientportal.tbl_storeorderitems WHERE ItemID = '$Ordered_Item' AND isFloat = 1 AND UserID = $usersID AND Weight = 0 AND CPO = '$CPO'";
                            $result = mysqli_query($conn, $query);
                            if(mysqli_num_rows($result) > 0)
                            {
                                while($row = mysqli_fetch_array($result))
                                {
                                    $id = $row[0];
                                    $quantity = $row[2];
                                }
                                $new_qty = $Ordered_Qty + $quantity;
                                $query = "UPDATE wms_clientportal.tbl_storeorderitems SET Quantity = '$new_qty', GivenQty = '$new_qty' WHERE id = '$id'";
                                $result = mysqli_query($conn, $query);
                            }
                            else
                            {
                                $query = "INSERT INTO wms_clientportal.tbl_storeorderitems (`SO`, `ItemID`, `Quantity`, `Weight`, `GivenQty`, `isFloat`, `UserID`, `CPO`) VALUES ('$SOnumber', '$Ordered_Item', '$Ordered_Qty', 0, '$Ordered_Qty', 1, '$usersID', '$CPO')";
                                if(mysqli_query($conn, $query))
                                {
                                    echo '1s';
                                }
                            }
                            
                        }
                        else if(($Ordered_Wtg != null && $Ordered_Wtg != "") && ($Ordered_Qty != null && $Ordered_Qty != ""))
                        {
                            $query = "SELECT id, ItemID, Quantity, Weight, GivenQty FROM wms_clientportal.tbl_storeorderitems WHERE ItemID = '$Ordered_Item' AND isFloat = 1 AND UserID = $usersID AND Quantity <> 0 AND Weight <> 0 AND CPO = '$CPO'";
                            $result = mysqli_query($conn, $query);
                            if(mysqli_num_rows($result) > 0)
                            {
                                while($row = mysqli_fetch_array($result))
                                {
                                    $id = $row[0];
                                    $quantity = $row[2];
                                    $weight = $row[3];
                                }
                                $new_qty = $Ordered_Qty + $quantity;
                                $new_wgt = $Ordered_Wtg + $weight;
                                $query = "UPDATE wms_clientportal.tbl_storeorderitems SET Quantity = '$new_qty', GivenQty = '$new_qty', Weight = '$new_wgt' WHERE id = '$id'";
                            }
                            else
                            {
                                $query = "INSERT INTO wms_clientportal.tbl_storeorderitems (`SO`, `ItemID`, `Quantity`, `Weight`, `GivenQty`, `isFloat`, `UserID`, `CPO`) VALUES ('$SOnumber', '$Ordered_Item', '$Ordered_Qty', '$Ordered_Wtg', '$Ordered_Qty', 1, '$usersID', '$CPO')";
                                if(mysqli_query($conn, $query))
                                {
                                    echo '1s';
                                }
                            }
                        }
                    }
            }
    }

    function AddOrderItem($Ordered_Item, $Ordered_Qty, $Ordered_Wtg, $SOnumber, $CPO)
    {
        include 'dbcon.php';

        $usersID = $_SESSION['UserID'];

        $_SESSION['Ordered_Item'] = $Ordered_Item;
        $_SESSION['Ordered_Qty'] = $Ordered_Qty;
        $_SESSION['Ordered_Wtg'] = $Ordered_Wtg;
        $_SESSION['SOnumber'] = $SOnumber;
        $_SESSION['CPO'] = $CPO;

        if(!empty($CPO))
        {
            AddOrderItemwithCPO();  
        }
        else if(empty($CPO))
        {
            $query = "SELECT i.ItemID, i.ItemDesc, i.Weight FROM wms_cloud.tbl_items i WHERE i.ItemID = '$Ordered_Item'";
            $result = mysqli_query($conn, $query);
            if(mysqli_num_rows($result) > 0)
            {
                $row = mysqli_fetch_array($result);
                $gotWgt = $row[2];
    
                if($gotWgt > 0)
                {
                    $query = "SELECT id, ItemID, Quantity, Weight, GivenQty FROM wms_clientportal.tbl_storeorderitems WHERE ItemID = '$Ordered_Item' AND isFloat = 0 AND UserID = $usersID";
                    $result = mysqli_query($conn, $query);
                    if(mysqli_num_rows($result) > 0)
                    {   
                        while($row = mysqli_fetch_array($result))
                        {
                            $id = $row[0];
                            $quantity = $row[2];
                            $weight = $row[3];
                        }
                        $new_qty = $Ordered_Qty + $quantity;
                        $new_wgt = ($new_qty * $gotWgt);
                        $query = "UPDATE wms_clientportal.tbl_storeorderitems SET Quantity = '$new_qty', Weight = '$new_wgt', GivenQty = '$new_qty' WHERE id = '$id'";
                        $result = mysqli_query($conn, $query);
    
                    }
                    else
                    {
                        $totalwgt = ($Ordered_Qty * $gotWgt);
                        $query = "INSERT INTO wms_clientportal.tbl_storeorderitems (`SO`, `ItemID`, `Quantity`, `Weight`, `GivenQty`, `isFloat`, `UserID`) VALUES ('$SOnumber', '$Ordered_Item', '$Ordered_Qty', '$totalwgt', '$Ordered_Qty', 0, '$usersID')";
                        if(mysqli_query($conn, $query))
                        {
                            echo '1';
                        }
                    }
                }
                else
                {
                    
                    if(($Ordered_Wtg == null && $Ordered_Wtg == "") && ($Ordered_Qty != null && $Ordered_Qty != ""))
                    {
                        $query = "SELECT id, ItemID, Quantity, Weight, GivenQty FROM wms_clientportal.tbl_storeorderitems WHERE ItemID = '$Ordered_Item' AND isFloat = 0 AND UserID = $usersID AND Weight = 0";
                        $result = mysqli_query($conn, $query);
                        if(mysqli_num_rows($result) > 0)
                        {
                            while($row = mysqli_fetch_array($result))
                            {
                                $id = $row[0];
                                $quantity = $row[2];
                            }
                            $new_qty = $Ordered_Qty + $quantity;
                            $query = "UPDATE wms_clientportal.tbl_storeorderitems SET Quantity = '$new_qty', GivenQty = '$new_qty' WHERE id = '$id'";
                            $result = mysqli_query($conn, $query);
                        }
                        else
                        {
                            $query = "INSERT INTO wms_clientportal.tbl_storeorderitems (`SO`, `ItemID`, `Quantity`, `Weight`, `GivenQty`, `isFloat`, `UserID`) VALUES ('$SOnumber', '$Ordered_Item', '$Ordered_Qty', 0, '$Ordered_Qty', 0, '$usersID')";
                            if(mysqli_query($conn, $query))
                            {
                                echo '1';
                            }
                        }
                        
                    }
                    else if(($Ordered_Wtg != null && $Ordered_Wtg != "") && ($Ordered_Qty != null && $Ordered_Qty != ""))
                    {
                        $query = "SELECT id, ItemID, Quantity, Weight, GivenQty FROM wms_clientportal.tbl_storeorderitems WHERE ItemID = '$Ordered_Item' AND isFloat = 0 AND UserID = $usersID AND Quantity <> 0 AND Weight <> 0";
                        $result = mysqli_query($conn, $query);
                        if(mysqli_num_rows($result) > 0)
                        {
                            while($row = mysqli_fetch_array($result))
                            {
                                $id = $row[0];
                                $quantity = $row[2];
                                $weight = $row[3];
                            }
                            $new_qty = $Ordered_Qty + $quantity;
                            $new_wgt = $Ordered_Wtg + $weight;
                            $query = "UPDATE wms_clientportal.tbl_storeorderitems SET Quantity = '$new_qty', GivenQty = '$new_qty', Weight = '$new_wgt' WHERE id = '$id'";
                            $result = mysqli_query($conn, $query);
                        }
                        else
                        {
                            $query = "INSERT INTO wms_clientportal.tbl_storeorderitems (`SO`, `ItemID`, `Quantity`, `Weight`, `GivenQty`, `isFloat`, `UserID`) VALUES ('$SOnumber', '$Ordered_Item', '$Ordered_Qty', '$Ordered_Wtg', '$Ordered_Qty', 0, '$usersID')";
                            if(mysqli_query($conn, $query))
                            {
                                echo '1';
                            }
                        }
                    }
                }
            }
        }

        
    }

    function GetAllOrderedItems($CPO)
    {
        include 'dbcon.php';

        $usersID = $_SESSION['UserID'];

        if(empty($CPO))
        {
            $query = "SELECT soi.ItemID, soi.SO, item.ItemDesc, item.ItemCode, item.Client_SKU, soi.Quantity, soi.Weight, soi.GivenQty, UOM.UOM_Abv, soi.id, SUM(ri.Quantity), SUM(ri.Weight)
            FROM wms_clientportal.tbl_storeorderitems soi
            LEFT JOIN wms_cloud.tbl_items item ON soi.ItemID = item.ItemID
            LEFT JOIN wms_cloud.tbl_weightuom UOM ON item.UOMID = UOM.UOMID
            LEFT JOIN wms_inbound.tbl_receivingitems ri ON item.ItemID = ri.ItemID
            WHERE soi.UserID = $usersID AND soi.isFloat = 0
            GROUP BY soi.ItemID, soi.Quantity, soi.Weight";
            $result = mysqli_query($conn, $query);
            if(mysqli_num_rows($result) == 0)
            {
                echo '<tr>
                        <td colspan="7">No Data Found.</td>
                    </tr>';
            }
            else
            {
                while($rows = mysqli_fetch_array($result))
                {
                    echo '<tr>
                            <td>'.$rows[1].'</td>
                            <td>'.$rows[2].'('.$rows[3].' - '.$rows[4].')</td>
                            <td>';
                            if($rows[5] > $rows[10])
                            {
                                echo '<p class="text-danger">'.number_format($rows[5], 2). '/' .number_format($rows[10], 2).'</p>';
                            }
                            else
                            {
                                echo number_format($rows[5], 2);
                            }
                            echo'</td>
                            <td>'.$rows[8].'</td>
                            <td>';
                            if($rows[6] > $rows[11])
                            {
                                echo '<p class="text-danger">'.number_format($rows[6], 2). '/' .number_format($rows[11], 2).'</p>';
                            }
                            else
                            {
                                echo number_format($rows[6], 2);
                            }
                            echo'</td>
                            <td>'.number_format($rows[7], 2).'</td>
                            <td class="text-nowrap"><div><button class="border-0 shadow-0" style="background-color: transparent" onclick="modal_order_removeitemconfirmation('.$rows[9].')" data-toggle="tooltip" data-placement="left" title="Remove Item"><i class="far fa-trash-alt"></i></button>
                            <button class="border-0 shadow-0" style="background-color: transparent" onclick="editgivenqty_modal('.$rows[9].')" data-toggle="tooltip" data-placement="left" title="Edit Item"><i class="far fa-edit"></i></button></div></td>
                        </tr>';
                }
            }
        }
        else
        {
            $query = "SELECT soi.ItemID, soi.SO, item.ItemDesc, item.ItemCode, item.Client_SKU, soi.Quantity, soi.Weight, soi.GivenQty, UOM.UOM_Abv, soi.id, SUM(ri.Quantity), SUM(ri.Weight)
            FROM wms_clientportal.tbl_storeorderitems soi
            LEFT JOIN wms_cloud.tbl_items item ON soi.ItemID = item.ItemID
            LEFT JOIN wms_cloud.tbl_weightuom UOM ON item.UOMID = UOM.UOMID
            LEFT JOIN wms_inbound.tbl_receivingitems ri ON item.ItemID = ri.ItemID
            WHERE soi.CPO = '$CPO' AND soi.isFloat = 1
            GROUP BY soi.ItemID, soi.Quantity, soi.Weight";
            $result = mysqli_query($conn, $query);
            if(mysqli_num_rows($result) == 0)
            {
                echo '<tr>
                        <td>'.$CPO.'</td>
                        <td></td>
                        <td>No Data Found.</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>';
            }
            else
            {
                while($rows = mysqli_fetch_array($result))
                {
                    echo '<tr>
                            <td>'.$rows[1].'</td>
                            <td>'.$rows[2].'('.$rows[3].' - '.$rows[4].')</td>
                            <td>';
                            if($rows[5] > $rows[10])
                            {
                                echo '<p class="text-danger">'.number_format($rows[5], 2). '/' .number_format($rows[10], 2).'</p>';
                            }
                            else
                            {
                                echo number_format($rows[5], 2);
                            }
                            echo'</td>
                            <td>'.$rows[8].'</td>
                            <td>';
                            if($rows[6] > $rows[11])
                            {
                                echo '<p class="text-danger">'.number_format($rows[6], 2). '/' .number_format($rows[11], 2).'</p>';
                            }
                            else
                            {
                                echo number_format($rows[6], 2);
                            }
                            echo'</td>
                            <td>'.$rows[7].'</td>
                            <td class="text-nowrap"><div><button class="border-0 shadow-0" style="background-color: transparent" onclick="modal_order_removeitemconfirmation('.$rows[9].')" data-toggle="tooltip" data-placement="left" title="Remove Item"><i class="far fa-trash-alt"></i></button>
                            <button class="border-0 shadow-0" style="background-color: transparent" onclick="editgivenqty_modal('.$rows[9].')" data-toggle="tooltip" data-placement="left" title="Edit Item"><i class="far fa-edit"></i></button></div></td>
                        </tr>';
                }
            }
        }
        
    }

    function OrderFWorCW($selected_item)
    {
        include 'dbcon.php';

        $query = "CALL wms_clientportal.SP_OrderFWorCW('$selected_item')";
        $result = mysqli_query($conn, $query);

        while($row = mysqli_fetch_array($result))
        {
            $weight = $row[0];
        }

        echo $weight;
    }

    function OrderingGetItem($itemid)
    {
        include 'dbcon.php';

        $query = "CALL wms_clientportal.SP_OrderingGetItem('$itemid')";
        $result = mysqli_query($conn, $query);
        while($rows = mysqli_fetch_array($result))
        {
            $arr[] = array(
                'givenQty'=>$rows[0],
                'weight'=>$rows[1],
            );
        }
        echo json_encode($arr);
        exit();
    }

    function CheckOrderItemQty()
    {
        include 'dbcon.php';
        $userid = $_SESSION['UserID'];
        $CPO = $_SESSION['generatedCPO'];

        if(empty($CPO))
        {
            $query = "SELECT CASE WHEN soi.Quantity > SUM(ri.Quantity) THEN 0
                                  WHEN soi.Weight > SUM(ri.Weight) THEN 0
                                  ELSE 1       
                                END
                    FROM wms_clientportal.tbl_storeorderitems soi
                    LEFT JOIN wms_inbound.tbl_receivingitems ri ON soi.ItemID = ri.ItemID
                    WHERE isFloat = 0 AND UserID = $userid
                    GROUP BY ri.ItemID";
            $result = mysqli_query($conn, $query);
            if(mysqli_num_rows($result) >= 1)
            {
                while($row = mysqli_fetch_array($result))
                {
                    if($row[0] == 0)
                    {
                        return 'yes';
                        break;
                    }
                }
            }
        }
        else
        {
            $query = "SELECT CASE WHEN soi.Quantity > SUM(ri.Quantity) THEN 0
                                  WHEN soi.Weight > SUM(ri.Weight) THEN 0
                                  ELSE 1       
                                END
                        FROM wms_clientportal.tbl_storeorderitems soi
                        LEFT JOIN wms_inbound.tbl_receivingitems ri ON soi.ItemID = ri.ItemID
                        WHERE isFloat = 1 AND UserID = '$userid' AND CPO = '$CPO'
                        GROUP BY ri.ItemID";
            $result = mysqli_query($conn, $query);
            if(mysqli_num_rows($result) >= 1)
            {
                while($row = mysqli_fetch_array($result))
                {
                    if($row[0] == 0)
                    {
                    return 'yes';
                    break;
                    }
                }
            }
        }
    }

    function SubmitForApproval($warehouse, $SOnumber, $storeid, $order_remarks, $itemid, $o_qty, $o_wgt, $generatedCPO, $order_pickupdate)
    {
        include 'dbcon.php';
        $userid = $_SESSION['UserID'];

        $_SESSION['generatedCPO'] = $generatedCPO;


        $query = "SELECT CommonCode FROM wms_cloud.tbl_customers_users WHERE id = '$userid'";
        $result = mysqli_query($conn, $query);
        $row = mysqli_fetch_assoc($result);
        $commoncode = $row['CommonCode'];
        
        $ifInsufficientStock = CheckOrderItemQty();

        if($ifInsufficientStock === 'yes')
        {
            echo 0;
        }
        else
        {
            if(!empty($generatedCPO))
            {
                $query = "UPDATE wms_clientportal.tbl_storeorder SET Order_Status = 1, Date_Created = NOW(), Pickup_date = '$order_pickupdate', Remarks = '$order_remarks', WarehouseID = '$warehouse' WHERE CPO = '$generatedCPO'";
                if(mysqli_query($conn, $query))
                {
                    echo 1;
                }
            }
            else
            {
                $CPO = generateCPO();

                $query = "INSERT INTO wms_clientportal.tbl_storeorder (`SO`, `CustomerCommon`, `StoreID`, `Remarks`, `WarehouseID`, `CPO`, `Date_Created`, `UserID`, `Order_Status`, `Pickup_date`) VALUES ('$SOnumber', '$commoncode', '$storeid', '$order_remarks', '$warehouse', '$CPO', NOW(), $userid, 1, '$order_pickupdate')";
                if(mysqli_query($conn, $query))
                {

                    $query = "SELECT * FROM wms_clientportal.tbl_storeorderitems WHERE UserID = $userid AND isFloat = 0 AND SO = '$SOnumber'";
                    $result = mysqli_query($conn, $query);
                    if(mysqli_num_rows($result) > 0)
                    {
                        echo 1;

                        while($row = mysqli_fetch_array($result))
                        {
                            $query = "UPDATE wms_clientportal.tbl_storeorderitems SET CPO = '$CPO', isFloat = 1 WHERE UserID = $userid AND isFloat = 0";
                            if(mysqli_query($conn, $query))
                            {
                                
                            }
                        }
                    }
                    else
                    {
                        echo 2;
                    }
            
                }
                else
                {
                    echo "Erro: " . $query . "<br>" . mysqli_error($conn);
                }
            }
        }
    }

    function SetNewItemQty($id, $newGivenQty, $newGivenWgt)
    {
        include 'dbcon.php';

        //suggest if the given qty changed it will change the weight
        $query = "SELECT soi.ItemID FROM wms_clientportal.tbl_storeorderitems soi WHERE soi.id = '$id'";
        $result = mysqli_query($conn, $query);

        while($row = mysqli_fetch_array($result))
        {
            $ItemID = $row[0];
        }

        $items = "SELECT Weight FROM wms_cloud.tbl_items WHERE ItemID = $ItemID";
        $result = mysqli_query($conn, $items);

        while($row = mysqli_fetch_assoc($result))
        {
            $ItemWeight = $row['Weight'];
        }

        if($ItemWeight == 0 )
        {
            if(($newGivenQty == null && $newGivenQty == "") && ($newGivenWgt != null && $newGivenWgt != ""))
            {
                $query = "UPDATE wms_clientportal.tbl_storeorderitems soi SET soi.GivenQty = '$newGivenWgt', soi.Weight = '$newGivenWgt' WHERE soi.id ='$id'";
                if(mysqli_query($conn, $query))
                {
                    echo 'Given Weight Changed';
                }
                else
                {
                    echo "Error: " . $query . "<br>" . mysqli_error($conn);
                }
            }
            else if(($newGivenQty != null && $newGivenQty != "") && ($newGivenWgt == null && $newGivenWgt == ""))
            {
                $query = "UPDATE wms_clientportal.tbl_storeorderitems soi SET soi.GivenQty = '$newGivenQty', soi.Quantity = '$newGivenQty' WHERE soi.id ='$id'";
                if(mysqli_query($conn, $query))
                {
                    echo 'Given Weight Changed';
                }
                else
                {
                    echo "Error: " . $query . "<br>" . mysqli_error($conn);
                }
            }
            else if(($newGivenQty != null && $newGivenQty != "") && ($newGivenWgt != null && $newGivenWgt != ""))
            {
                $query = "UPDATE wms_clientportal.tbl_storeorderitems soi SET soi.GivenQty = '$newGivenQty', soi.Quantity = '$newGivenQty', soi.Weight = '$newGivenWgt' WHERE soi.id ='$id'";
                if(mysqli_query($conn, $query))
                {
                    echo 'Given Weight Changed';
                }
                else
                {
                    echo "Error: " . $query . "<br>" . mysqli_error($conn);
                }
            }
            
        }
        else
        {
            $newWeight = (int)$newGivenQty * (float)$ItemWeight;
            
            $query = "UPDATE wms_clientportal.tbl_storeorderitems soi SET soi.Quantity = '$newGivenQty', soi.Weight = '$newWeight', soi.GivenQty = '$newGivenQty' WHERE soi.id = '$id'";
            if(mysqli_query($conn, $query))
            {
                echo 'Change Quantity';
            }
        }
    }

    function OrderRemoveItem($itemid)
    {
        include 'dbcon.php';

        $query = "UPDATE wms_clientportal.tbl_storeorderitems SET isFloat = 2 WHERE id = $itemid LIMIT 1";
        if(mysqli_query($conn, $query))
        {
            echo 'Remove Item Success';
        }
        else
        {
            echo "Error: " . $query . "<br>" . mysqli_error($conn);
        }
    }

    function GetORDList()
    {
        include 'dbcon.php';

        $userid = $_SESSION['UserID'];
        $commoncode = $_SESSION['CommonCode'];

        $query = "SELECT role_id FROM wms_cloud.tbl_customers_users WHERE id = $userid";
        $result = mysqli_query($conn, $query);
        while($row = mysqli_fetch_array($result))
        {
            $roleid = $row[0];
        }

        if($roleid == 1)
        {
            // $query = "CALL wms_clientportal.SP_GetORDList('$commoncode')";

            $query = "SELECT so.CPO, 
                    DATE_FORMAT(so.Date_Created, '%Y-%m-%d'), 
                    SUM(soi.Weight), 
                    wh.Warehouse,
                    so.id, 
                    CONCAT(SUM(i.Length) * SUM(i.Width) * SUM(i.Height)), 
                    so.CustomerCommon,
                    o.ORD, 
                    so.Order_Status AS tbl_cp_outbound_status, 
                    o.StatusID AS tbl_order_status,
                    p.StatusID AS tbl_picking_status,
                    iss.StatusID AS tbl_issuances_status
                    
                    FROM wms_clientportal.tbl_storeorder so
                    LEFT JOIN wms_cloud.tbl_warehouses wh ON so.WarehouseID = wh.WarehouseID
                    LEFT JOIN wms_clientportal.tbl_storeorderitems soi ON so.CPO = soi.CPO
                    LEFT JOIN wms_outbound.tbl_ordering o ON so.CPO = o.CPO
                    LEFT JOIN wms_cloud.tbl_items i ON soi.ItemID = i.ItemID
                    LEFT JOIN wms_outbound.tbl_picking p ON o.ORD = p.ORD
                    LEFT JOIN wms_outbound.tbl_issuancelist isl ON p.PCK = isl.PCK
                    LEFT JOIN wms_outbound.tbl_issuances iss ON isl.OBD = iss.OBD
                    WHERE so.CustomerCommon = '$commoncode'
                    GROUP BY soi.CPO
                    ORDER BY soi.CPO DESC";

            $result = mysqli_query($conn, $query);

            if(mysqli_num_rows($result) >= 1)
            {
                while($rows = mysqli_fetch_array($result))
                {
                    if(($rows[8] == 1) && (empty($rows[9])) && (empty($rows[10])) && (empty($rows[11])))
                    {
                        echo '<tr class="border bg-white shadow-sm rounded" >
                                <td>'.$rows[0].'</td>
                                <td>'.$rows[7].'</td>
                                <td>'.$rows[5].'</td>
                                <td>For Approval</td>
                                <td>'.$rows[3].'</td>
                                <td>'.date("d-M-Y", strtotime($rows[1])).'</td>
                                <td><div class="btn-group d-flex justify-content-center" role="group" aria-label="Basic example">
                                <a class="btn p-0 px-1" onclick="modal_order_details('.$rows[4].')" data-toggle="tooltip" data-placement="left" title="View Details"><i class="fas fa-external-link-alt"></i></a>
                                <a class="btn p-0 px-1" onclick="modal_order_removeconfirmation('.$rows[4].')" data-toggle="tooltip" data-placement="left" title="Remove"><i class="far fa-trash-alt"></i></a>
                                <a class="btn p-0 px-1" onclick="order_backtoOpenConfirmation('.$rows[4].')" data-toggle="tooltip" data-placement="left" title="Move to On Process"><i class="fas fa-undo-alt"></i></a></div></td>
                            </tr>
                            <tr>
                                <td class="py-1"></td>
                            </tr>
                            ';
                    }
                    else if(($rows[8] == 2) && (empty($rows[9])) && (empty($rows[10])) && (empty($rows[11])))
                    {
                        echo '<tr class="border bg-white shadow-sm rounded">
                            <td>'.$rows[0].'</td>
                            <td>'.$rows[7].'</td>
                            <td>'.$rows[5].'</td>
                            <td>Approved</td>
                            <td>'.$rows[3].'</td>
                            <td>'.date("Y-M-d", strtotime($rows[1])).'</td>
                            <td><div class="btn-group d-flex justify-content-center" role="group" aria-label="Basic example">
                            <a class="btn p-0 px-1" onclick="modal_order_details('.$rows[4].')" data-toggle="tooltip" data-placement="left" title="View Details"><i class="fas fa-external-link-alt"></i></a>
                            </div></td>
                        </tr>
                        <tr>
                            <td class="py-1"></td>
                        </tr>
                        ';
                    }
                    else if(($rows[8] == 2) && ($rows[9] == 1 || $rows[9] == 2) && (empty($rows[10])) && (empty($rows[11])))
                    {
                        echo '<tr class="border bg-white shadow-sm rounded">
                            <td>'.$rows[0].'</td>
                            <td>'.$rows[7].'</td>
                            <td>'.$rows[5].'</td>
                            <td>Order in Process</td>
                            <td>'.$rows[3].'</td>
                            <td>'.date("Y-M-d", strtotime($rows[1])).'</td>
                            <td><div class="btn-group d-flex justify-content-center" role="group" aria-label="Basic example">
                            <a class="btn p-0 px-1" onclick="modal_order_details('.$rows[4].')" data-toggle="tooltip" data-placement="left" title="View Details"><i class="fas fa-external-link-alt"></i></a>
                            </div></td>
                        </tr>
                        <tr>
                            <td class="py-1"></td>
                        </tr>
                        ';
                    }
                    else if(($rows[8] == 2) && ($rows[9] == 3) && ($rows[10] == 2 || $rows[10] == 1) && (empty($rows[11])))
                    {
                        echo '<tr class="border bg-white shadow-sm rounded">
                            <td>'.$rows[0].'</td>
                            <td>'.$rows[7].'</td>
                            <td>'.$rows[5].'</td>
                            <td>For Picking</td>
                            <td>'.$rows[3].'</td>
                            <td>'.date("Y-M-d", strtotime($rows[1])).'</td>
                            <td><div class="btn-group d-flex justify-content-center" role="group" aria-label="Basic example">
                            <a class="btn p-0 px-1" onclick="modal_order_details('.$rows[4].')" data-toggle="tooltip" data-placement="left" title="View Details"><i class="fas fa-external-link-alt"></i></a>
                            </div></td>
                        </tr>
                        <tr>
                            <td class="py-1"></td>
                        </tr>
                        ';
                    }
                    else if(($rows[8] == 2) && ($rows[9] == 3) && ($rows[10] == 3) && (empty($rows[11])))
                    {
                        echo '<tr class="border bg-white shadow-sm rounded">
                            <td>'.$rows[0].'</td>
                            <td>'.$rows[7].'</td>
                            <td>'.$rows[5].'</td>
                            <td>Picked</td>
                            <td>'.$rows[3].'</td>
                            <td>'.date("Y-M-d", strtotime($rows[1])).'</td>
                            <td><div class="btn-group d-flex justify-content-center" role="group" aria-label="Basic example">
                            <a class="btn p-0 px-1" onclick="modal_order_details('.$rows[4].')" data-toggle="tooltip" data-placement="left" title="View Details"><i class="fas fa-external-link-alt"></i></a>
                            </div></td>
                        </tr>
                        <tr>
                            <td class="py-1"></td>
                        </tr>
                        ';
                    }
                    else if(($rows[8] == 2) && ($rows[9] == 3) && ($rows[10] == 3 || $rows[10] == 5) && ($rows[11] == 2))
                    {
                        echo '<tr class="border bg-white shadow-sm rounded">
                            <td>'.$rows[0].'</td>
                            <td>'.$rows[7].'</td>
                            <td>'.$rows[5].'</td>
                            <td>For Dispatch</td>
                            <td>'.$rows[3].'</td>
                            <td>'.date("Y-M-d", strtotime($rows[1])).'</td>
                            <td><div class="btn-group d-flex justify-content-center" role="group" aria-label="Basic example">
                            <a class="btn p-0 px-1" onclick="modal_order_details('.$rows[4].')" data-toggle="tooltip" data-placement="left" title="View Details"><i class="fas fa-external-link-alt"></i></a>
                            </div></td>
                        </tr>
                        <tr>
                            <td class="py-1"></td>
                        </tr>
                        ';
                    }
                    else if(($rows[8] == 2) && ($rows[9] == 3) && ($rows[10] == 3 || $rows[10] == 5) && ($rows[11] == 3))
                    {
                        echo '<tr class="border bg-white shadow-sm rounded">
                            <td>'.$rows[0].'</td>
                            <td>'.$rows[7].'</td>
                            <td>'.$rows[5].'</td>
                            <td>In Transit</td>
                            <td>'.$rows[3].'</td>
                            <td>'.date("Y-M-d", strtotime($rows[1])).'</td>
                            <td><div class="btn-group d-flex justify-content-center" role="group" aria-label="Basic example">
                            <a class="btn p-0 px-1" onclick="modal_order_details('.$rows[4].')" data-toggle="tooltip" data-placement="left" title="View Details"><i class="fas fa-external-link-alt"></i></a>
                            </div></td>
                        </tr>
                        <tr>
                            <td class="py-1"></td>
                        </tr>
                        ';
                    }
                    else if(($rows[8] == 2) && ($rows[9] == 3) && ($rows[10] == 4) && empty($rows[11]))
                    {
                        echo '<tr class="border bg-white shadow-sm rounded">
                            <td>'.$rows[0].'</td>
                            <td>'.$rows[7].'</td>
                            <td>'.$rows[5].'</td>
                            <td>Cancel PCK</td>
                            <td>'.$rows[3].'</td>
                            <td>'.date("Y-M-d", strtotime($rows[1])).'</td>
                            <td><div class="btn-group d-flex justify-content-center" role="group" aria-label="Basic example">
                            <a class="btn p-0 px-1" onclick="modal_order_details('.$rows[4].')" data-toggle="tooltip" data-placement="left" title="View Details"><i class="fas fa-external-link-alt"></i></a>
                            </div></td>
                        </tr>
                        <tr>
                            <td class="py-1"></td>
                        </tr>
                        ';
                    }
                    else if(($rows[8] == 2) && ($rows[9] == 3) && ($rows[10] == 3 || $rows[10] == 5) && ($rows[11] == 6))
                    {
                        echo '<tr class="border bg-white shadow-sm rounded">
                            <td>'.$rows[0].'</td>
                            <td>'.$rows[7].'</td>
                            <td>'.$rows[5].'</td>
                            <td class="text-primary"><b>Delivered</b></td>
                            <td>'.$rows[3].'</td>
                            <td>'.date("Y-M-d", strtotime($rows[1])).'</td>
                            <td><div class="btn-group d-flex justify-content-center" role="group" aria-label="Basic example">
                            <a class="btn p-0 px-1" onclick="modal_order_details('.$rows[4].')" data-toggle="tooltip" data-placement="left" title="View Details"><i class="fas fa-external-link-alt"></i></a>
                            </div></td>
                        </tr>
                        <tr>
                            <td class="py-1"></td>
                        </tr>
                        ';
                    }
                }
            }
        }
        else
        {
            // $query = "CALL wms_clientportal.SP_GetORDList('$commoncode')";

            $query = "SELECT so.CPO, 
                    DATE_FORMAT(so.Date_Created, '%d-%m-%Y'), 
                    SUM(soi.Weight), 
                    wh.Warehouse,
                    so.id, 
                    CONCAT(SUM(i.Length) * SUM(i.Width) * SUM(i.Height)), 
                    so.CustomerCommon,
                    o.ORD, 
                    so.Order_Status AS tbl_cp_outbound_status, 
                    o.StatusID AS tbl_order_status,
                    p.StatusID AS tbl_picking_status,
                    iss.StatusID AS tbl_issuances_status
                    
                    FROM wms_clientportal.tbl_storeorder so
                    LEFT JOIN wms_cloud.tbl_warehouses wh ON so.WarehouseID = wh.WarehouseID
                    LEFT JOIN wms_clientportal.tbl_storeorderitems soi ON so.CPO = soi.CPO
                    LEFT JOIN wms_outbound.tbl_ordering o ON so.CPO = o.CPO
                    LEFT JOIN wms_cloud.tbl_items i ON soi.ItemID = i.ItemID
                    LEFT JOIN wms_outbound.tbl_picking p ON o.ORD = p.ORD
                    LEFT JOIN wms_outbound.tbl_issuancelist isl ON p.PCK = isl.PCK
                    LEFT JOIN wms_outbound.tbl_issuances iss ON isl.OBD = iss.OBD
                    WHERE so.UserID = '$userid'
                    GROUP BY soi.CPO
                    ORDER BY soi.CPO DESC";

            $result = mysqli_query($conn, $query);

            if(mysqli_num_rows($result) >= 1)
            {
                while($rows = mysqli_fetch_array($result))
                {
                    if(($rows[8] == 1) && (empty($rows[9])) && (empty($rows[10])) && (empty($rows[11])))
                    {
                        echo '<tr class="border bg-white shadow-sm rounded" >
                                <td>'.$rows[0].'</td>
                                <td>'.$rows[7].'</td>
                                <td>'.$rows[5].'</td>
                                <td>Order Sent</td>
                                <td>'.$rows[3].'</td>
                                <td>'.date("d-M-Y", strtotime($rows[1])).'</td>
                                <td><div class="btn-group d-flex justify-content-center" role="group" aria-label="Basic example">
                                <a class="btn p-0 px-1" onclick="modal_order_details('.$rows[4].')" data-toggle="tooltip" data-placement="left" title="View Details"><i class="fas fa-external-link-alt"></i></a>
                                <a class="btn p-0 px-1" onclick="modal_order_removeconfirmation('.$rows[4].')" data-toggle="tooltip" data-placement="left" title="Remove"><i class="far fa-trash-alt"></i></a>
                                <a class="btn p-0 px-1" onclick="order_backtoOpenConfirmation('.$rows[4].')" data-toggle="tooltip" data-placement="left" title="Move to On Process"><i class="fas fa-undo-alt"></i></a></div></td>
                            </tr>
                            <tr>
                                <td class="py-1"></td>
                            </tr>
                            ';
                    }
                    else if(($rows[8] == 2) && (empty($rows[9])) && (empty($rows[10])) && (empty($rows[11])))
                    {
                        echo '<tr class="border bg-white shadow-sm rounded">
                            <td>'.$rows[0].'</td>
                            <td>'.$rows[7].'</td>
                            <td>'.$rows[5].'</td>
                            <td>Order in Process</td>
                            <td>'.$rows[3].'</td>
                            <td>'.date("Y-M-d", strtotime($rows[1])).'</td>
                            <td><div class="btn-group d-flex justify-content-center" role="group" aria-label="Basic example">
                            <a class="btn p-0 px-1" onclick="modal_order_details('.$rows[4].')" data-toggle="tooltip" data-placement="left" title="View Details"><i class="fas fa-external-link-alt"></i></a>
                            </div></td>
                        </tr>
                        <tr>
                            <td class="py-1"></td>
                        </tr>
                        ';
                    }
                    else if(($rows[8] == 2) && ($rows[9] == 1 || $rows[9] == 2) && (empty($rows[10])) && (empty($rows[11])))
                    {
                        echo '<tr class="border bg-white shadow-sm rounded">
                            <td>'.$rows[0].'</td>
                            <td>'.$rows[7].'</td>
                            <td>'.$rows[5].'</td>
                            <td>Order in Process</td>
                            <td>'.$rows[3].'</td>
                            <td>'.date("Y-M-d", strtotime($rows[1])).'</td>
                            <td><div class="btn-group d-flex justify-content-center" role="group" aria-label="Basic example">
                            <a class="btn p-0 px-1" onclick="modal_order_details('.$rows[4].')" data-toggle="tooltip" data-placement="left" title="View Details"><i class="fas fa-external-link-alt"></i></a>
                            </div></td>
                        </tr>
                        <tr>
                            <td class="py-1"></td>
                        </tr>
                        ';
                    }
                    else if(($rows[8] == 2) && ($rows[9] == 3) && ($rows[10] == 2 || $rows[10] == 1) && (empty($rows[11])))
                    {
                        echo '<tr class="border bg-white shadow-sm rounded">
                            <td>'.$rows[0].'</td>
                            <td>'.$rows[7].'</td>
                            <td>'.$rows[5].'</td>
                            <td>For Picking</td>
                            <td>'.$rows[3].'</td>
                            <td>'.date("Y-M-d", strtotime($rows[1])).'</td>
                            <td><div class="btn-group d-flex justify-content-center" role="group" aria-label="Basic example">
                            <a class="btn p-0 px-1" onclick="modal_order_details('.$rows[4].')" data-toggle="tooltip" data-placement="left" title="View Details"><i class="fas fa-external-link-alt"></i></a>
                            </div></td>
                        </tr>
                        <tr>
                            <td class="py-1"></td>
                        </tr>
                        ';
                    }
                    else if(($rows[8] == 2) && ($rows[9] == 3) && ($rows[10] == 3) && (empty($rows[11])))
                    {
                        echo '<tr class="border bg-white shadow-sm rounded">
                            <td>'.$rows[0].'</td>
                            <td>'.$rows[7].'</td>
                            <td>'.$rows[5].'</td>
                            <td>Picked</td>
                            <td>'.$rows[3].'</td>
                            <td>'.date("Y-M-d", strtotime($rows[1])).'</td>
                            <td><div class="btn-group d-flex justify-content-center" role="group" aria-label="Basic example">
                            <a class="btn p-0 px-1" onclick="modal_order_details('.$rows[4].')" data-toggle="tooltip" data-placement="left" title="View Details"><i class="fas fa-external-link-alt"></i></a>
                            </div></td>
                        </tr>
                        <tr>
                            <td class="py-1"></td>
                        </tr>
                        ';
                    }
                    else if(($rows[8] == 2) && ($rows[9] == 3) && ($rows[10] == 3 || $rows[10] == 5) && ($rows[11] == 2))
                    {
                        echo '<tr class="border bg-white shadow-sm rounded">
                            <td>'.$rows[0].'</td>
                            <td>'.$rows[7].'</td>
                            <td>'.$rows[5].'</td>
                            <td>For Dispatch</td>
                            <td>'.$rows[3].'</td>
                            <td>'.date("Y-M-d", strtotime($rows[1])).'</td>
                            <td><div class="btn-group d-flex justify-content-center" role="group" aria-label="Basic example">
                            <a class="btn p-0 px-1" onclick="modal_order_details('.$rows[4].')" data-toggle="tooltip" data-placement="left" title="View Details"><i class="fas fa-external-link-alt"></i></a>
                            </div></td>
                        </tr>
                        <tr>
                            <td class="py-1"></td>
                        </tr>
                        ';
                    }
                    else if(($rows[8] == 2) && ($rows[9] == 3) && ($rows[10] == 3 || $rows[10] == 5) && ($rows[11] == 3))
                    {
                        echo '<tr class="border bg-white shadow-sm rounded">
                            <td>'.$rows[0].'</td>
                            <td>'.$rows[7].'</td>
                            <td>'.$rows[5].'</td>
                            <td>In Transit</td>
                            <td>'.$rows[3].'</td>
                            <td>'.date("Y-M-d", strtotime($rows[1])).'</td>
                            <td><div class="btn-group d-flex justify-content-center" role="group" aria-label="Basic example">
                            <a class="btn p-0 px-1" onclick="modal_order_details('.$rows[4].')" data-toggle="tooltip" data-placement="left" title="View Details"><i class="fas fa-external-link-alt"></i></a>
                            </div></td>
                        </tr>
                        <tr>
                            <td class="py-1"></td>
                        </tr>
                        ';
                    }
                    else if(($rows[8] == 2) && ($rows[9] == 3) && ($rows[10] == 4) && empty($rows[11]))
                    {
                        echo '<tr class="border bg-white shadow-sm rounded">
                            <td>'.$rows[0].'</td>
                            <td>'.$rows[7].'</td>
                            <td>'.$rows[5].'</td>
                            <td>Cancel PCK</td>
                            <td>'.$rows[3].'</td>
                            <td>'.date("Y-M-d", strtotime($rows[1])).'</td>
                            <td><div class="btn-group d-flex justify-content-center" role="group" aria-label="Basic example">
                            <a class="btn p-0 px-1" onclick="modal_order_details('.$rows[4].')" data-toggle="tooltip" data-placement="left" title="View Details"><i class="fas fa-external-link-alt"></i></a>
                            </div></td>
                        </tr>
                        <tr>
                            <td class="py-1"></td>
                        </tr>
                        ';
                    }
                    else if(($rows[8] == 2) && ($rows[9] == 3) && ($rows[10] == 3 || $rows[10] == 5) && ($rows[11] == 6))
                    {
                        echo '<tr class="border bg-white shadow-sm rounded">
                            <td>'.$rows[0].'</td>
                            <td>'.$rows[7].'</td>
                            <td>'.$rows[5].'</td>
                            <td class="text-primary"><b>Delivered</b></td>
                            <td>'.$rows[3].'</td>
                            <td>'.date("Y-M-d", strtotime($rows[1])).'</td>
                            <td><div class="btn-group d-flex justify-content-center" role="group" aria-label="Basic example">
                            <a class="btn p-0 px-1" onclick="modal_order_details('.$rows[4].')" data-toggle="tooltip" data-placement="left" title="View Details"><i class="fas fa-external-link-alt"></i></a>
                            </div></td>
                        </tr>
                        <tr>
                            <td class="py-1"></td>
                        </tr>
                        ';
                    }
                }
            }
        }
    }

    function GetSumOfListOrder($itemid)
    {
        include 'dbcon.php';
        
        $query = "SELECT CPO FROM wms_clientportal.tbl_storeorder WHERE id = '$itemid'";
        $result = mysqli_query($conn, $query);

        if(mysqli_num_rows($result) == 1)
        {
            while($row = mysqli_fetch_array($result))
            {
                $CPO = $row[0];
            }
            
            $query = "CALL wms_clientportal.SP_GetSumOfListOrder('$CPO')";
            $result = mysqli_query($conn, $query);
            while($row = mysqli_fetch_array($result))
            {
                $qty = number_format($row[0], 2);
                $wtg = number_format($row[1], 2);
                $given = number_format($row[2], 2);

                echo '
                <tr>
                    <td class="fw-bold">Total:</td>
                    <td class="fw-bold">'.$qty.'</td>
                    <td class="fw-bold"></td>
                    <td class="fw-bold">'.$wtg.'</td>
                    <td class="fw-bold">'.$given.'</td>
                </tr>';
            }
        }
    }

    function GetOrderDetail($item_id)
    {
        include 'dbcon.php';

        $query = "CALL wms_clientportal.SP_GetOrderDetail('$item_id')";
        $result = mysqli_query($conn, $query);

        while($row = mysqli_fetch_array($result))
        {
            $arr[] = array(
                'Store_name'=> $row[2],
                'Date_created'=>date("d-M-Y H:i", strtotime($row[1])),
                'CPO_no'=> $row[3],
                'warehouse'=> $row[4]
            );
        }
        echo json_encode($arr);
        exit();
    }

    function GetListofOrder($itemid)
    {
        include 'dbcon.php';

        $query = "SELECT CPO FROM wms_clientportal.tbl_storeorder WHERE id = '$itemid'";
        $result = mysqli_query($conn, $query);

        if(mysqli_num_rows($result) == 1)
        {
            while($row = mysqli_fetch_assoc($result))
            {
                $CPO = $row['CPO'];
            }

            $query = "CALL wms_clientportal.SP_GetListofOrder('$CPO')";
            $result = mysqli_query($conn, $query);
    
            if(mysqli_num_rows($result) > 0)
            {
                while($rows = mysqli_fetch_array($result))
                {
                    echo '<tr>
                            <td>'.$rows[1]. '('.$rows[7].')</td>
                            <td>'.number_format((float)$rows[3], 2, '.', '').'</td>
                            <td>'.$rows[2].'</td>
                            <td>'.number_format((float)$rows[4], 2, '.', '').'</td>
                            <td>'.number_format((float)$rows[5], 2, '.', '').'</td>
                        </tr>';
                }
            }
            else
            {
                echo '<tr>
                    <td>No Order Found</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>';
            }      
        }
    }

    function ORDdetailsApprovebtn($item_id)
    {
        include 'dbcon.php';

        $userid = $_SESSION['UserID'];
        
        $query = "SELECT cu.role_id FROM wms_cloud.tbl_customers_users cu WHERE cu.id = '$userid'";
        $result = mysqli_query($conn, $query);
        $row = mysqli_fetch_array($result);
        $user_role = $row[0];

        if($user_role === '1')
        {
            $query = "SELECT CPO FROM wms_clientportal.tbl_storeorder WHERE id = '$item_id' AND Order_Status = 1";
            $result = mysqli_query($conn, $query);
            if(mysqli_num_rows($result) > 0)
            {
                echo '<div>
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" onclick="modal_approve_orderconfirmation()">Approve</button>
                    </div>';
            }
            else
            {
                echo '<div>
                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Closed</button>
                </div>';
            }

        }
        else
        {
            echo '<div>
                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Closed</button>
                </div>';
        }

    }

    function RemoveCPOTrans($item_id)
    {
        include 'dbcon.php';

        $query = "SELECT so.CPO FROM wms_clientportal.tbl_storeorder so WHERE so.id = '$item_id' LIMIT 1";
        $result = mysqli_query($conn, $query);
        if(mysqli_num_rows($result) == 1)
        {
            while($row = mysqli_fetch_array($result))
            {
                $CPO = $row[0];
            }

            $query = "CALL wms_clientportal.SP_RemoveCPOTrans('$CPO', '$item_id')";
            if(mysqli_query($conn, $query))
            {
                echo 'Success';
            }
            else
            {
                echo "Error: " . $query . "<br>" . mysqli_error($conn);
            }
        }
        else
        {
            echo "Error: " . $query . "<br>" . mysqli_error($conn);
        }
    }

    function generateORD()
    {
        include 'dbcon.php';
        $query = "SELECT TempORD FROM wms_outbound.tbl_temp LIMIT 1";
        $result = mysqli_query($conn, $query);
        if(mysqli_num_rows($result) < 0)
        {
            $TempORD = 1;
            $query = "UPDATE wms_outbound.tbl_temp SET TempORD = '$TempORD'";
            if(mysqli_query($conn, $query))
            {
                // echo $TempCPI = 1;
                return "ORD".sprintf('%09d', $TempORD);
            }
            else
            {
                echo "Error: " . $query . "<br>" . mysqli_error($conn);
            }
        }
        else
        {
            $row = mysqli_fetch_array($result);

            $TempORD = $row[0];
            $NewTempORD = $TempORD + 1;

            $query = "UPDATE wms_outbound.tbl_temp SET TempORD = '$NewTempORD'";
            if(mysqli_query($conn, $query))
            {
                // echo $NewTempCPI;
                return "ORD".sprintf('%09d', $TempORD);
            }
            else
            {
                echo "Error: " . $query . "<br>" . mysqli_error($conn);
            }
        }
    }

    function ApprovedORD($itemid)
    {
        include 'dbcon.php';

        $userid = $_SESSION['CustomerId'];
        $usersID = $_SESSION['UserID'];

        $query = "SELECT * FROM wms_clientportal.tbl_storeorder WHERE id = '$itemid' AND Order_Status = 1 LIMIT 1";
        $result = mysqli_query($conn, $query);
        if(mysqli_num_rows($result) == 1)
        {
            $query = "UPDATE wms_clientportal.tbl_storeorder SET Order_Status = 2  WHERE id = '$itemid'";
            if(mysqli_query($conn, $query))
            {
                
                $query = "SELECT so.CPO, date_format(so.Date_Created, '%d-%m-%Y'), so.Remarks, so.CustomerCommon, c.CustomerID, cu.CusName, so.Pickup_date
                FROM wms_clientportal.tbl_storeorder so 
                LEFT JOIN wms_cloud.tbl_customers c ON so.CustomerCommon = c.CustomerCommonCode
                LEFT JOIN wms_cloud.tbl_customers_users cu ON so.UserID = cu.id
                WHERE so.id = '$itemid' LIMIT 1";
                $result = mysqli_query($conn, $query);
                if(mysqli_num_rows($result) == 1)
                {
                    while($rows = mysqli_fetch_array($result))
                    {
                        $CPO = $rows[0];
                        $Date_created = date("Y-m-d", strtotime($rows[1]));
                        $Remarks = $rows[2];
                        $Customercommon = $rows[3];
                        $CustomerID = $rows[4];
                        $CusName = $rows[5];
                        $PickupDate = $rows[6];
                    }

                    $ORD = generateORD();
                    $query = "INSERT INTO wms_outbound.tbl_ordering
                    (`ORD`, `StatusID`, `CustomerID`, `CreatedBy`, `LastUpdatedBy`, `OrderDate`, `Remarks`, `FromCP`, `CPStatus_id`, `CPO`, `PickupDate`) 
                    VALUES ('$ORD', 1, '$CustomerID', '$CusName', '$CusName', '$Date_created', '$Remarks', 'True', 2, '$CPO', '$PickupDate')";
                    if(mysqli_query($conn, $query))
                    {
                        echo 1;

                        $query = "SELECT soi.ItemID, soi.Quantity, soi.Weight 
                            FROM wms_clientportal.tbl_storeorderitems soi 
                            LEFT JOIN wms_clientportal.tbl_storeorder so ON soi.CPO = so.CPO
                            WHERE soi.CPO = '$CPO' AND so.Order_Status = '2'";
                        $result = mysqli_query($conn, $query);
                        while($row = mysqli_fetch_array($result))
                        {
                            $itemid = $row[0];
                            $qty = $row[1];
                            $wgt = $row[2];
                            $query = "INSERT INTO wms_outbound.tbl_orderingitems (`ORD`, `ItemID`, `Quantity`, `Weight`,`Status`) VALUES ('$ORD', '$itemid', '$qty', '$wgt','1')";
                            if(mysqli_query($conn, $query))
                            {

                            }
                        }
                    }
                    else
                    {
                        echo "Error: " . $query . "<br>" . mysqli_error($conn);
                    }
                }
                else
                {
                    echo 0;
                }
            }
        }
        else
        {
            echo 0;
        }
    }

    function CountOpenCPO()
    {
        include 'dbcon.php';

        $user_id = $_SESSION['UserID'];
        $query = "SELECT CustomerCommon FROM wms_clientportal.tbl_storeorder WHERE UserID = '$user_id'";
        $result = mysqli_query($conn, $query);
        $row = mysqli_fetch_array($result);
        $customercommon = $row[0];

        $query = "SELECT COUNT(*)
                    FROM wms_clientportal.tbl_storeorder so
                    WHERE so.Order_Status = 0 AND so.CustomerCommon = '$customercommon'";
        $result = mysqli_query($conn, $query);
        while($row = mysqli_fetch_array($result))
        {
            $order_opencount = $row[0];
        }

        echo $order_opencount;
    }

    function openOpenCPOModal()
    {
        include 'dbcon.php';

        $userID = $_SESSION['UserID'];

        $query = "SELECT CustomerCommon FROM wms_clientportal.tbl_storeorder WHERE UserID = '$userID'";
        $result = mysqli_query($conn, $query);
        $row = mysqli_fetch_array($result);
        $customercommon = $row[0];
        $query = "SELECT so.CPO, cu.CusEmail, date_format(so.Date_Created, '%d-%m-%Y')
                    FROM wms_clientportal.tbl_storeorder so
                    LEFT JOIN wms_cloud.tbl_customers_users cu ON so.UserID = cu.id
                    WHERE so.CustomerCommon = '$customercommon' AND so.Order_Status = 0";
        $result = mysqli_query($conn, $query);
        while ($rows = mysqli_fetch_row($result))
        {
            echo '
                <tr>
                    <td>'.$rows[0].'</td>
                    <td>'.$rows[1].'</td>
                    <td>'.date("d-M-Y", strtotime($rows[2])).'</td>
                    <td><button class="btn btn-primary btn-sm" data-dismiss="modal" onclick="cpodetails(\''.$rows[0].'\')">Open</button></td>
                </tr>
            ';
        }
    }

    function PutOrderToOpen($itemid)
    {
        include 'dbcon.php';

        $query = "CALL wms_clientportal.SP_PutOrderToOpen('$itemid')";
        if(mysqli_query($conn, $query))
        {
            echo 'Back to Open Success!';
        }
        else
        {
            echo "Error: " . $query . "<br>" . mysqli_error($conn);
        }
    }   

    function GetCPODetails($CPO)
    {
        include 'dbcon.php';
        $userID = $_SESSION['UserID'];
        
        $query = "UPDATE wms_clientportal.tbl_storeorder so SET so.UserID = $userID WHERE so.CPO = '$CPO'";
        if(mysqli_query($conn, $query))
        {
            $query = "UPDATE wms_clientportal.tbl_storeorderitems soi SET soi.UserID = $userID WHERE soi.CPO = '$CPO'";
            $result = mysqli_query($conn, $query);
            
            $query = "SELECT so.WarehouseID, so.CPO, so.StoreID, so.SO, so.Remarks
            FROM wms_clientportal.tbl_storeorder so
            WHERE so.CPO = '$CPO'";
            $result = mysqli_query($conn, $query);
            if(mysqli_num_rows($result) == 1)
            {
                while($rows = mysqli_fetch_array($result))
                {
                    $arr[] = array(
                        'warehouseid'=>$rows[0],
                        'cpo'=>$rows[1],
                        'storeid'=>$rows[2],
                        'so'=>$rows[3],
                        'remarks'=>$rows[4]
                    );
                }
                echo json_encode($arr);
            }
            else
            {
                echo "Error: " . $query . "<br>" . mysqli_error($conn);
            }
        }
        else
        {
            echo 'Try Again!';
        }
    }

    function ImportedOrderItems($orderitems)
    {
        include 'dbcon.php';

        $orders = json_decode($orderitems, true);
        $nooforders = count($orders);
        $userid = $_SESSION['UserID'];

        $query = "SELECT CommonCode, CustomerID FROM wms_cloud.tbl_customers_users cu 
        LEFT JOIN wms_cloud.tbl_customers c ON c.CustomerCommonCode = cu.CommonCode
        WHERE cu.id = $userid";
        $result = mysqli_query($conn, $query);
        while ($row = mysqli_fetch_array($result)) 
        {
            $ClientID = $row[1];
        }

        $orderstoDB = [];
        $faileditemsearch = [];
        for ($x=0; $x < $nooforders; $x++) 
        { 
            $item = $orders[$x]['ItemDesc'];
            $itemid = "SELECT `ItemID`, `Weight` From wms_cloud.tbl_items WHERE ItemDesc = '$item' AND ItemCustomerID = $ClientID LIMIT 1";
            $result = mysqli_query($conn, $itemid); 
            if(mysqli_num_rows($result) >= 1)
            {
                while($rows = mysqli_fetch_array($result))
                {
                    $itemid = $rows[0];
                    $weight = $rows[1];
                }

                $totalwgt = $orders[$x]['Quantity'] * $weight;
                array_push($orderstoDB, ["SO" => $orders[$x]['SO'], "itemid" => $itemid, "itemdesc" => $orders[$x]['ItemDesc'], "quantity" => $orders[$x]['Quantity'], "uom" => $orders[$x]['UOM'], "weight" => $totalwgt, "isFloat" => 0, "UserID" => $userid]);

                $SO = $orders[$x]['SO'];
                $ItemID = $itemid;
                $Qty = $orders[$x]['Quantity'];
                $Wgt = $totalwgt;
                $isfloat = 0;
                $UserID = $userid;

                $query = "INSERT INTO wms_clientportal.tbl_storeorderitems (`SO`, `ItemID`, `Quantity`, `Weight`, `GivenQty`, `isFloat`, `UserID`) VALUES ('$SO','$ItemID','$Qty','$Wgt', '$Qty', '$isfloat','$UserID')";
                $result = mysqli_query($conn, $query);
            }
            else
            {
                array_push($faileditemsearch, ["SO" => $orders[$x]['SO'], "itemid" => $itemid, "itemdesc" => $orders[$x]['ItemDesc'], "quantity" => $orders[$x]['Quantity'], "uom" => $orders[$x]['UOM'], "weight" => $orders[$x]['Weight'], "isFloat" => 0, "UserID" => $userid]);
            }
        }

        // for ($i=0; $i < $nooforders; $i++)
        // { 
        //     $SO = $orderstoDB[$i]['SO'];
        //     $ItemID = $orderstoDB[$i]['itemid'];
        //     $Qty = $orderstoDB[$i]['quantity'];
        //     $Wgt = $orderstoDB[$i]['weight'];
        //     $isfloat = $orderstoDB[$i]['isFloat'];
        //     $UserID = $orderstoDB[$i]['UserID'];

        //     $query = "INSERT INTO wms_clientportal.tbl_storeorderitems (`SO`, `ItemID`, `Quantity`, `Weight`, `GivenQty`, `isFloat`, `UserID`) VALUES ('$SO','$ItemID','$Qty','$Wgt', '$Qty', '$isfloat','$UserID')";
        //     if(mysqli_query($conn, $query))
        //     {
        //         echo 'Success';
        //     }
        //     else
        //     {
        //         echo "Error: " . $query . "<br>" . mysqli_error($conn);
        //     }
        // }
        // print_r($orderstoDB);

        if(!empty($faileditemsearch))
        {
            $count = count($faileditemsearch);

            for ($j=0; $j < $count; $j++) { 
                
                echo '<tr>
                        <td>'.$faileditemsearch[$j]['SO'].'</td>
                        <td>'.$faileditemsearch[$j]['itemdesc'].'</td>
                        <td>'.$faileditemsearch[$j]['quantity'].'</td>
                        <td>'.$faileditemsearch[$j]['uom'].'</td>
                        <td>'.$faileditemsearch[$j]['weight'].'</td>
                    </tr>';
            }
        }
        else
        {
            echo 0;
        }


        // print_r($faileditemsearch);

        
    }

// OrderModule


//SettingsModule

    function GetMyInfo()
    {
        include 'dbcon.php';

        $userid = $_SESSION['UserID'];

        $query = "SELECT * FROM tbl_customers_users WHERE id = '$userid'";
        $result = mysqli_query($conn, $query);
        if(mysqli_num_rows($result) == 1)
        {
            while($row = mysqli_fetch_array($result))
            {
                $arr[] = array(
                    'username'=>$row[2],
                    'fullname'=>$row[4],
                    'email'=>$row[5],
                    'contact_no'=>$row[6],
                );

                echo json_encode($arr);
                exit();
            }
        }
    }

    function UpdateMyinfo($fullname, $username, $email, $contactno, $currpass, $newpass1)
    {
        include 'dbcon.php';

        $userid = $_SESSION['UserID'];

        $query = "SELECT CusPassword FROM wms_cloud.tbl_customers_users WHERE id = $userid";
        $result = mysqli_query($conn, $query);
        while ($row = mysqli_fetch_array($result)) 
        {
            $retpass = $row[0];
        }

        if(password_verify($currpass, $retpass))
            {
                $hashedPassword = password_hash($newpass1, PASSWORD_DEFAULT);

                $query = "UPDATE tbl_customers_users SET CusUsername = '$username', CusName = '$fullname', CusEmail = '$email', Contactno = '$contactno', CusPassword = '$hashedPassword' WHERE id = '$userid'";
                if(mysqli_query($conn, $query))
                {
                    echo 'Update Success';
                }
                else
                {
                    echo "Error: " . $query . "<br>" . mysqli_error($conn);
                }
            }
            else
            {
                echo 'Please check Username/Email and Password if correct.';
            }

            
        
    }

    function AddNewUsers($new_fullname, $new_username, $new_email, $new_contactno, $new_userrole, $new_password1)
    {
        include 'dbcon.php';

        $userid = $_SESSION['UserID'];

        $hashedPassword = password_hash($new_password1, PASSWORD_DEFAULT);

        $query = "SELECT CommonCode FROM tbl_customers_users WHERE id = '$userid'";
        $result = mysqli_query($conn, $query);
        if(mysqli_num_rows($result) == 1)
        {
            while($row = mysqli_fetch_array($result))
            {
                $commoncode = $row[0];
            }

            $query = "INSERT INTO tbl_customers_users (`CommonCode`, `CusUsername`, `CusPassword`, `CusName`, `CusEmail`, `Contactno`, `CusUserStatus`, `role_id`, `Addedby`) VALUES ('$commoncode', '$new_username', '$hashedPassword', '$new_fullname', '$new_email', '$new_contactno', 0, '$new_userrole', '$userid');";
            if(mysqli_query($conn, $query))
            {
                echo 'Added Success';
            }
            else
            {
                echo "Error: " . $query . "<br>" . mysqli_error($conn);
            }
        }
        else
        {
            echo "Error: " . $query . "<br>" . mysqli_error($conn);
        }

    }

    function GetAllUsers()
    {
        include 'dbcon.php';

        $userid = $_SESSION['UserID'];

        $query = "SELECT CommonCode FROM tbl_customers_users WHERE id = '$userid'";
        $result = mysqli_query($conn, $query);
        if(mysqli_num_rows($result) == 1)
        {
            while($row = mysqli_fetch_array($result))
            {
                $commoncode = $row[0];
            }


            $query = "SELECT
            id, 
            CusName, 
            CusUsername, 
            CusEmail, 
            Contactno, 
            CusUserStatus,
            CASE
                WHEN CusUserStatus = 1 THEN 'Active'
                ELSE 'For Activation'
            END
            FROM tbl_customers_users WHERE CommonCode = '$commoncode' AND CusUserStatus != 3";
            $result = mysqli_query($conn, $query);
            if(mysqli_num_rows($result) >= 1)
            {
                $no = 1;
                while ($rows = mysqli_fetch_array($result)) 
                {
                    if($rows[5] == 1)
                    {
                        echo '<tr>
                                <td>'.$no.'</td>
                                <td>'.$rows[1].'</td>
                                <td>'.$rows[2].'</td>
                                <td>'.$rows[3].'</td>
                                <td>'.$rows[4].'</td>
                                <td>'.$rows[6].'</td>
                                <td><div><button class="btn btn-sm btn-warning" onclick="modal_reset_password_confirmation('.$rows[0].')">Reset Password</button></div></td>
                            </tr>';
                    }
                    else
                    {
                        echo '<tr>
                                <td>'.$no.'</td>
                                <td>'.$rows[1].'</td>
                                <td>'.$rows[2].'</td>
                                <td>'.$rows[3].'</td>
                                <td>'.$rows[4].'</td>
                                <td>'.$rows[6].'</td>
                                <td><div><button class="border-0 shadow-0" style="background-color: transparent" onclick="modal_removeuser_confirmation('.$rows[0].')" data-toggle="tooltip" data-placement="left" title="Remove User"><i class="fas fa-trash"></i></button></div></td>
                            </tr>';
                    }

                    $no++;
                }
                
            }
            else
            {
                echo '<tr>
                        <td colspan="7">No Record Found.</td>
                    </tr>';
            }
        }  
    }

    function DeleteUser($userid)
    {
        include 'dbcon.php';

        $query = "UPDATE wms_cloud.tbl_customers_users SET CusUserStatus = 3 WHERE id = '$userid'";
        if(mysqli_query($conn, $query))
        {
            echo 'delete success';
        }
        else
        {
            echo "Error: " . $query . "<br>" . mysqli_error($conn);
        }
    }

    function ResetPassword($user_id)
    {
        include 'dbcon.php';
        $password = substr(str_shuffle("0123456789abcdefghijklmnopqrstvwxyz"), 0, 6);

        $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

        $query = "UPDATE wms_cloud.tbl_customers_users SET CusPassword = '$hashedPassword' WHERE id = '$user_id'";
        $result = mysqli_query($conn, $query);
        if(mysqli_query($conn, $query))
        {
            $_SESSION['ResetPassword'] = $password;
            echo 1;
        }
        else
        {
            echo 0;
        }
    }

    function AddNewStores($store_fullname, $store_username, $store_email, $store_password1, $store_password2, $store_contactno, $store_storeaddress)
    {
        include 'dbcon.php';

        $userid = $_SESSION['UserID'];

        $date = new DateTime('UTC');
        $date->setTimezone(new DateTimeZone('Asia/Manila'));
        $datenow = $date->format('Y-m-d H:i:s');

        $hashedPassword = password_hash($store_password1, PASSWORD_DEFAULT);

        $query = "SELECT CommonCode FROM tbl_customers_users WHERE id = '$userid'";
        $result = mysqli_query($conn, $query);
        if(mysqli_num_rows($result) == 1)
        {
            while($row = mysqli_fetch_array($result))
            {
                $commoncode = $row[0];
            }

            $query = "INSERT INTO tbl_store (`customer_common`, `name`, `email`, `username`, `password`, `contactno`, `store_address`, `Registeredby`, `store_status`, `date_created`) VALUES ('$commoncode', '$store_fullname', '$store_email', '$store_username', '$hashedPassword', '$store_contactno', '$store_storeaddress', '$userid', 0, '$datenow');";
            if(mysqli_query($conn, $query))
            {
                echo 'Added Success';
            }
            else
            {
                echo "Error: " . $query . "<br>" . mysqli_error($conn);
            }
        }
        else
        {
            echo "Error: " . $query . "<br>" . mysqli_error($conn);
        }
    }

    function GetAllStores()
    {
        include 'dbcon.php';

        $userid = $_SESSION['UserID'];

        $query = "SELECT CommonCode FROM tbl_customers_users WHERE id = '$userid'";
        $result = mysqli_query($conn, $query);
        if(mysqli_num_rows($result) == 1)
        {
            while($row = mysqli_fetch_array($result))
            {
                $commoncode = $row[0];
            }

            $query = "SELECT id, `name`, `username`, `email`, `store_address`, `contactno`, `store_status`, CASE WHEN `store_status` = 1 THEN 'Active' ELSE 'For Activation' END FROM tbl_store WHERE customer_common = '$commoncode' AND store_status != 3";
            $result = mysqli_query($conn, $query);
            if(mysqli_num_rows($result) >= 1)
            {
                $no = 1;
                while ($rows = mysqli_fetch_array($result)) 
                {
                    if($rows[5] == 1)
                    {
                        echo '<tr>
                                <td>'.$no.'</td>
                                <td>'.$rows[1].'</td>
                                <td>'.$rows[2].'</td>
                                <td>'.$rows[3].'</td>
                                <td>'.$rows[4].'</td>
                                <td>'.$rows[5].'</td>
                                <td>'.$rows[7].'</td>
                                <td><div><button class="border-0 shadow-0" style="background-color: transparent" onclick="modal_removestore_confirmation('.$rows[0].')" data-toggle="tooltip" data-placement="left" title="Remove User"><i class="fas fa-trash"></i></button></div></td>
                            </tr>';
                    }
                    else
                    {
                        echo '<tr>
                                <td>'.$no.'</td>
                                <td>'.$rows[1].'</td>
                                <td>'.$rows[2].'</td>
                                <td>'.$rows[3].'</td>
                                <td>'.$rows[4].'</td>
                                <td>'.$rows[5].'</td>
                                <td>'.$rows[7].'</td>
                                <td></td>
                            </tr>';
                    }
                    $no++;
                }
            }
            else
            {
                echo '<tr>
                        <td colspan="8">No Record Found.</td>
                    </tr>';
            }
        }  
    }

    function DeleteStore($storeid)
    {
        include 'dbcon.php';

        $query = "UPDATE wms_cloud.tbl_store SET store_status = 3 WHERE id = '$storeid'";
        if(mysqli_query($conn, $query))
        {
            echo 'delete success';
        }
        else
        {
            echo "Error: " . $query . "<br>" . mysqli_error($conn);
        }
    }

    function GetMaterialType()
    {
        include 'dbcon.php';

        $query = "SELECT * FROM tbl_materials";
        $result = mysqli_query($conn, $query);
        if(mysqli_num_rows($result) > 0)
        {
            while($rows = mysqli_fetch_array($result))
            {
                echo '<option value="'.$rows[0].'">'.$rows[1].'</option>';
            }
        }
        else
        {
            echo 'No Material Type Found';
        }

    }

    function GetStorageType()
    {
        include 'dbcon.php';
        $query = "SELECT * FROM tbl_categories";

        $alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

        $x = 0;

        $result = mysqli_query($conn, $query);
        while ($rows = mysqli_fetch_row($result))
        {

            echo '<option value="'.$rows[0].'">'.$rows[1].' - '.$alpha[$x].'</option>';
            $x = $x + 1;
        }
    }

    function GetSubCategory()
    {
        include 'dbcon.php';

        $query = "SELECT * FROM tbl_itemsubcategories";
        $result = mysqli_query($conn, $query);
        if(mysqli_num_rows($result) > 0)
        {
            while($rows = mysqli_fetch_array($result))
            {
                echo '<option value="'.$rows[0].'">'.$rows[1].'</option>';
            }
        }
        else
        {
            echo 'No Sub-Category Type Found';
        }
    }

    function GetUOMList()
    {
        include 'dbcon.php';
        $query = "SELECT * FROM tbl_weightuom";

        $result = mysqli_query($conn, $query);
        while ($rows = mysqli_fetch_row($result))
        {
            echo '<option value="'.$rows[0].'">'.$rows[1].'</option>';
        }
    }

//Settings Module
    

//SuperAdminSide
    function MasterUserList()
    {
        include 'dbcon.php';

        $query = "SELECT users.id, cus.CompanyName, users.CusName, users.CusUsername, users.CusEmail, users.Contactno, users.CusUserStatus,
        CASE WHEN users.CusUserStatus = 1 THEN 'Active' WHEN users.CusUserStatus = 0 THEN 'For Activation' ELSE 'Deleted' END, cul.type
        FROM tbl_customers_users users
        LEFT JOIN tbl_customers cus ON users.CommonCode = cus.CustomerCommonCode
        LEFT JOIN tbl_customers_userlegends cul ON users.role_id = cul.id";
        $result = mysqli_query($conn, $query);

        if(mysqli_num_rows($result) >= 1)
        {   
            $n = 1;
            while ($rows = mysqli_fetch_array($result))
            {
                if($rows[6] == '1')
                {
                    echo '<tr>
                            <td>'.$n.'</td>
                            <td>'.$rows[1].'</td>
                            <td>'.$rows[2].'</td>
                            <td>'.$rows[3].'</td>
                            <td>'.$rows[4].'</td>
                            <td>'.$rows[5].'</td>
                            <td>'.$rows[8].'</td>
                            <td>'.$rows[7].'</td>
                            <td><button type="button" class="btn btn-danger btn-sm" onclick="modal_deactivate_confirmation('.$rows[0].')">Deactivate</button><button type="button" class="btn btn-warning btn-sm" onclick="modal_reset_password_confirmation('.$rows[0].')">Reset Password</button></td>
                        </tr>';
                }
                else
                {
                    echo '<tr>
                            <td>'.$n.'</td>
                            <td>'.$rows[1].'</td>
                            <td>'.$rows[2].'</td>
                            <td>'.$rows[3].'</td>
                            <td>'.$rows[4].'</td>
                            <td>'.$rows[5].'</td>
                            <td>'.$rows[8].'</td>
                            <td>'.$rows[7].'</td>
                            <td><button type="button" class="btn btn-danger btn-sm" onclick="modal_userrejection_message('.$rows[0].')"><i class="fas fa-times"></i></button>
                            <button type="button" class="btn btn-primary btn-sm" onclick="modal_useractivation_message('.$rows[0].')"><i class="fas fa-check"></i></button></td>
                        </tr>';
                }
                $n++;
            }
        }
        else
        {
            echo '<tr>
                    <td colspan="9">No Record Found.</td>
                </tr>';
        }
        
    }

    function MasterItemList()
    {
        include 'dbcon.php';

        // $query = "SELECT users.id, cus.CompanyName, users.CusName, users.CusUsername, users.CusEmail, users.Contactno, users.CusUserStatus, cul.type
        // FROM tbl_customers_users users
        // LEFT JOIN tbl_customers cus ON users.CommonCode = cus.CustomerCommonCode
        // LEFT JOIN tbl_customers_userlegends cul ON users.role_id = cul.id
        // WHERE users.role_id NOT IN (0)";
        // $result = mysqli_query($conn, $query);

        // if(mysqli_num_rows($result) < 1)
        // {
        //     $arr[] = array(
        //         'no'=>'',
        //         'companyname'=>'',
        //         'fullname' =>'No Data Found!',
        //         'username' =>'',
        //         'email'=>'',
        //         'contactno'=>'',
        //         'role'=>'',
        //         'status'=>'',
        //         'action'=>''
        //     );
        // }
        // else
        // {
        //     $n = 1;
        //     while($row = mysqli_fetch_array($result))
        //     {
        //         $arr[] = array(
        //             'no'=>$n,
        //             'companyname'=>$row[1],
        //             'fullname' =>$row[2],
        //             'username' =>$row[3],
        //             'email'=>$row[4],
        //             'contactno'=>$row[5],
        //             'role'=>$row[7],
        //             'status'=>($row[6] == 1)? '<p style="color: blue;">Active</p>':'<p style="color: red;">For Activation</p>',
        //             'action'=>($row[6] == 1)? '':'<div class="btn-group btn-group-sm" role="group" aria-label="Basic mixed styles example">
        //             <button type="button" class="btn btn-primary" onclick="modal_userrejection_message('.$row[0].')">Reject</button>
        //             <button type="button" class="btn btn-primary" onclick="modal_useractivation_message('.$row[0].')">Approve</button>
        //           </div>'
        //         );
        //         $n++;
        //     }
        // }

        // echo json_encode($arr);
        // exit();
    }

    function MasterStoreList()
    {
        include 'dbcon.php';

        $query = "SELECT store.id, c.CompanyName, store.name, store.username, store.email, store.contactno, store.store_address, store.store_status, CASE WHEN store.store_status = 1 THEN 'Active' WHEN store.store_status = 0 THEN 'For Activation' ELSE 'Deleted' END
        FROM tbl_store store LEFT JOIN tbl_customers c ON store.customer_common = c.CustomerCommonCode";
        $result = mysqli_query($conn, $query);

        if(mysqli_num_rows($result) >=1)
        {
            $no = 1;
            while($rows = mysqli_fetch_array($result)) 
            {
                if($rows[7] == 1)
                {
                    echo '<tr>
                            <td>'.$no.'</td>
                            <td>'.$rows[1].'</td>
                            <td>'.$rows[2].'</td>
                            <td>'.$rows[3].'</td>
                            <td>'.$rows[4].'</td>
                            <td>'.$rows[5].'</td>
                            <td>'.$rows[6].'</td>
                            <td>'.$rows[8].'</td>
                            <td><button type="button" class="btn btn-warning btn-sm" onclick="modal_reset_password_confirmation('.$rows[0].')">Reset Password</button></td>
                        </tr>';
                }
                else if($rows[7] == 3)
                {
                    echo '<tr>
                            <td>'.$no.'</td>
                            <td>'.$rows[1].'</td>
                            <td>'.$rows[2].'</td>
                            <td>'.$rows[3].'</td>
                            <td>'.$rows[4].'</td>
                            <td>'.$rows[5].'</td>
                            <td>'.$rows[6].'</td>
                            <td>'.$rows[8].'</td>
                            <td class="fst-italic">no action</td>
                        </tr>';
                }
                else
                {
                    echo '<tr>
                            <td>'.$no.'</td>
                            <td>'.$rows[1].'</td>
                            <td>'.$rows[2].'</td>
                            <td>'.$rows[3].'</td>
                            <td>'.$rows[4].'</td>
                            <td>'.$rows[5].'</td>
                            <td>'.$rows[6].'</td>
                            <td>'.$rows[8].'</td>
                            <td><div class="input-group"><button type="button" class="btn btn-danger btn-sm" onclick="modal_userrejection_message('.$row[0].')"><i class="fas fa-times"></i></button><button type="button" class="btn btn-primary btn-sm" onclick="modal_useractivation_message('.$row[0].')"><i class="fas fa-check"></i></button></div></td>
                        </tr>';
                }
                

                $no++;
            }
        }
        else
        {
            echo '<tr>
                    <td colspan="9">No Record Found.</td>
                </tr>';
        }
    }

    function MasterDeactivate_Users($userid)
    {
        include 'dbcon.php';
        $query = "UPDATE wms_cloud.tbl_customers_users SET CusUserStatus = 0 WHERE id = '$userid'";
        if(mysqli_query($conn, $query))
        {
            echo 'Deactivation Success';
        }
        else
        {
            echo "Error: " . $query . "<br>" . mysqli_error($conn);
        }
    }

    function MasterUserActivation($userid)
    {
        include 'dbcon.php';

        $query = "UPDATE wms_cloud.tbl_customers_users SET CusUserStatus = 1 WHERE id = '$userid'";
        if(mysqli_query($conn, $query))
        {
            echo 'Activation Success';
        }
        else
        {
            echo "Error: " . $query . "<br>" . mysqli_error($conn);
        }
    }

    function MasterUserRejection($userid)
    {
        include 'dbcon.php';

        $query = "DELETE FROM wms_cloud.tbl_customers_users WHERE id = '$userid'";
        if(mysqli_query($conn, $query))
        {
            echo 'Activation Success';
        }
        else
        {
            echo "Error: " . $query . "<br>" . mysqli_error($conn);
        }
    }

//SuperAdminSide

// special function

    function getregisterall()   
    {
        include ('dbcon.php');

        $query = "SELECT *
        FROM wms_cloud.tbl_customers cu
        WHERE cu.hold != 1
        AND CustomerName != ''";
        $result = mysqli_query($conn, $query);
        while($rows = mysqli_fetch_array($result))
        {
            $arr[] = array(
                'CusID' => $rows[0],
            );
        }
        $adj_arrayitems = json_decode(json_encode($arr),true);
        $adj_arraycount = count($adj_arrayitems);

        for($i = 0; $i < $adj_arraycount; $i++)
        {
            $CusID = $adj_arrayitems[$i]['CusID'];

            // echo nl2br("$CusID\n");
            $query = "SELECT cu.CustomerID, SUBSTRING_INDEX(SUBSTRING_INDEX(cu.CustomerName, ' ', 1), ' ', -1), cu.CustomerName, cu.CompanyName, cu.CustomerNumber, cu.CustomerEmail, cu.CustomerCommonCode
            FROM wms_cloud.tbl_customers cu
            WHERE cu.CustomerID = $CusID";
            $result = mysqli_query($conn, $query);
            while ($row = mysqli_fetch_array($result)) 
            {
                $FName = $row[1];
                $FLName = $row[2];
                $CompanyName = $row[3];
                $CustomerNumber = $row[4];
                $CustomerEmail = $row[5];
                $CommonCode = $row[6];
            }

            $password = 123456;

            $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

            $query = "INSERT INTO tbl_customers_users (`CommonCode`, `CusUsername`, `CusPassword`, `CusName`, `CusEmail`, `Contactno`, `CusUserStatus`, `role_id`, `Addedby`) VALUES ('$CommonCode', '$FName', '$hashedPassword', '$FLName', '$CustomerEmail', '$CustomerEmail', 0, 1, 0);";
            if(mysqli_query($conn, $query))
            {
                echo 'Added Success';
            }
            else
            {
                echo "Error: " . $query . "<br>" . mysqli_error($conn);
            }

        }
    }

// special function
