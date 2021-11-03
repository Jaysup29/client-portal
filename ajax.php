<?php
	session_start();
    ini_set('max_execution_time', '300');
    set_time_limit(300);
    date_default_timezone_set('Asia/Manila');
	$function = $_POST['function'];
    $CustomerID = $_SESSION['CustomerId'];
// Dashboard
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

        // if($to == $date && $from == $sub)
        // {
        //     $from = '1970-01-01';
        //     $to = '2040-01-01';
        // }

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
        loadSKUandDesc($filter, $CustomerID);
    }
    // Dashboard

    // Reports
    else if($function == 'soh_report')
    {
        $WarehouseID = $_POST['WarehouseID'];
        soh_report($CustomerID, $WarehouseID);
    }

    else if($function == 'filteredSOH')
    {   
        $filtered = $_POST['filtered'];
        $WarehouseID = $_POST['WarehouseID'];
        filteredSOH($filtered, $CustomerID, $WarehouseID);
    }

    else if($function == 'searchSOH')
    {   
        $filtered = $_POST['filtered'];
        $key = $_POST['key'];
        $WarehouseID = $_POST['WarehouseID'];
        searchSOH($filtered, $key, $CustomerID, $WarehouseID);
    }

    else if($function == 'Report_GenerateITR')
    {
        $WarehouseID = $_POST['WarehouseID'];
        $datefrom = $_POST['datefrom'];
        $dateto = $_POST['dateto'];
        $filtered = $_POST['filter'];
        $key = $_POST['searchkey'];
        Report_GenerateITR($WarehouseID, $datefrom, $dateto, $CustomerID, $filtered, $key);

    }

    else if($function == 'Report_GenerateITRDetails')
    {

        $IBN = $_POST['IBN'];
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
        ageing_report($CustomerID, $WarehouseID);
    }

    else if($function == 'filteredAgeing')
    {   
        $filtered = $_POST['filtered'];
        $WarehouseID = $_POST['WarehouseID'];
        filteredAgeing($filtered, $CustomerID, $WarehouseID);
    }

    else if($function == 'searchAgeing')
    {   
        $filtered = $_POST['filtered'];
        $key = $_POST['key'];
        $WarehouseID = $_POST['WarehouseID'];
        searchAgeing($filtered, $key, $CustomerID, $WarehouseID);
    }

    else if ($function == 'Report_GenerateDTR')
    {
        $datefrom = $_POST['datefrom'];
        $dateto = $_POST['dateto'];
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
// Reports


    //Receiving module
    else if($function == 'CPGenerateIBN')
    {
        CPGenerateIBN();
    }
    else if ($function == 'Warehouses')
    {
        Warehouses();
    }
    else if($function == 'TruckType')
    {
        TruckType();
    }
    else if($function == 'SubmitASN')
    {
        $ibn_no = $_POST['ibn_no'];
        $selected_warehouse = $_POST['selected_warehouse'];
        $selected_truck = $_POST['selected_truck'];
        $supplier_name = $_POST['supplier_name'];
        $container_no = $_POST['container_no'];
        $vehicle_plateno = $_POST['vehicle_plateno'];
        $seal_no = $_POST['seal_no'];
        $client_rep = $_POST['client_rep'];
        $date_arrival = $_POST['date_arrival'];
        SubmitASN($ibn_no, $selected_warehouse, $supplier_name ,$container_no, $vehicle_plateno, $seal_no, $client_rep, $date_arrival, $selected_truck);
    }
    else if($function == 'ReturnToPending')
    {
        $ibn_no = $_POST['ibn_no'];
        $selected_warehouse = $_POST['selected_warehouse'];
        $supplier_name = $_POST['supplier_name'];
        $container_no = $_POST['container_no'];
        $vehicle_plateno = $_POST['vehicle_plateno'];
        $seal_no = $_POST['seal_no'];
        $client_rep = $_POST['client_rep'];
        $date_arrival = $_POST['date_arrival'];
        ReturnToPending($ibn_no, $selected_warehouse, $supplier_name ,$container_no, $vehicle_plateno, $seal_no, $client_rep, $date_arrival);
    }
    else if($function == 'GetPendingList')
    {
        GetPendingList();
    }
    else if($function == 'GetOpenIBNList')
    {
        GetOpenIBNList();
    }
    else if($function == 'GetOnProcessList')
    {
        GetOnProcessList();
    }
    else if($function == 'GetOpenCount')
    {
        GetOpenCount();
    }
    else if($function == 'GetPendingCount')
    {
        GetPendingCount();
    }
    else if($function == 'GetOnProcessCount')
    {
        GetOnProcessCount();
    }
    else if($function == 'GetASNDetails')
    {
        $IBN = $_POST['IBN'];
        GetASNDetails($IBN);
    }
    else if($function == 'AvailableItems')
    {
        $storagetype = $_POST['storagetype'];
        AvailableItems($storagetype);
    }
    else if($function == 'GetUOM')
    {
        $ItemID = $_POST['ItemID'];
        GetUOM($ItemID);
    }
    else if($function == 'GetWeight')
    {
        $storagType = $_POST['storagType'];
        $selected_item = $_POST['selected_item'];
        GetWeight($storagType, $selected_item);
    }
    else if($function == 'AddReceivingItems')
    {
        $r_ibn = $_POST['r_ibn'];
        $r_item = $_POST['r_item'];
        $r_itemqty = $_POST['r_itemqty'];
        $storagType = $_POST['storagType'];
        $r_itemexpirydate = $_POST['r_itemexpirydate'];
        $r_itemuom = $_POST['r_itemuom'];
        $r_weight = $_POST['r_weight'];
        AddReceivingItems($r_ibn, $r_item, $r_itemqty, $storagType, $r_itemexpirydate, $r_itemuom, $r_weight);
    }
    else if($function == 'AddedItemsSummary')
    {
        $IBN = $_POST['IBN'];
        AddedItemsSummary($IBN);
    }
    else if($function == 'GetItemDetailsCanEdit')
    {
        $id = $_POST['id'];
        GetItemDetailsCanEdit($id);
    }
    else if($function == 'EditItemDetails')
    {
        $itemid = $_POST['id'];
        $qty = $_POST['editQty'];
        $expiry = $_POST['expiry'];
        EditItemDetails($itemid, $qty, $expiry);
    }
    else if($function == 'removeItem')
    {
        $id = $_POST['id'];
        removeItem($id);
    }
    else if($function == 'SubmitCompleteASN')
    {
        $IBN = $_POST['IBN'];
        SubmitCompleteASN($IBN);
    }
// Reports

    // ----------------------------------------------------------------------------- //

// Dashboard
function pieChartLoadData($dataBarGraph, $CustomerID, $to, $from, $filter, $searchkey, $label, $restart, $reend)
{
    include 'dbcon.php';
    $lessTwo = date('Y-m-d', strtotime('+2 months'));
    $lessFour = date('Y-m-d', strtotime('+4 months'));
    $lessSix = date('Y-m-d', strtotime('+6 months'));
    $query = "SELECT 
                Client_SKU,
                ItemDesc,
                COUNT(Client_SKU),
                SUM(Quantity),
                SUM(wms_inbound.tbl_receivingitems.Weight),
                ExpiryDate,
                IF(DATEDIFF(ExpiryDate, CURDATE()) < 1,
                    'Expired',
                    DATEDIFF(ExpiryDate, CURDATE()))
            FROM
                wms_inbound.tbl_receivingitems
                    LEFT JOIN
                wms_inbound.tbl_receiving ON wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
                    LEFT JOIN
                wms_cloud.tbl_items ON wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
            ";

    if($reend == 0 && $restart == 0)
    {   
        if(!empty($searchkey))
        {
            if($label == 'Less Than 2 Months')
            {
                $query .= "WHERE CusID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND ExpiryDate BETWEEN CURDATE() AND '$lessTwo'
                    GROUP BY ExpiryDate, Client_SKU";
            }
            else if($label == 'Less Than 4 Months')
            {
                $query .= "WHERE CusID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND ExpiryDate BETWEEN CURDATE() AND '$lessFour'
                    GROUP BY ExpiryDate, Client_SKU";
            }
            else if($label == 'Less Than 6 Months')
            {
                $query .= "WHERE CusID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND ExpiryDate BETWEEN CURDATE() AND '$lessSix'
                    GROUP BY ExpiryDate, Client_SKU";
            }
            else if($label == 'More Than 6 Months')
            {
                $query .= "WHERE CusID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND ExpiryDate BETWEEN '$lessSix' AND '2060-01-01'
                    GROUP BY ExpiryDate, Client_SKU";
            }
            else
            {
                $query .= "WHERE CusID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND ExpiryDate < CURDATE()
                    GROUP BY ExpiryDate, Client_SKU";
            }
        }
        else
        {
            if($label == 'Less Than 2 Months')
            {
                $query .= "WHERE CusID = $CustomerID AND ExpiryDate BETWEEN CURDATE() AND '$lessTwo'
                    GROUP BY ExpiryDate, Client_SKU";
            }
            else if($label == 'Less Than 4 Months')
            {
                $query .= "WHERE CusID = $CustomerID AND ExpiryDate BETWEEN CURDATE() AND '$lessFour'
                    GROUP BY ExpiryDate, Client_SKU";
            }
            else if($label == 'Less Than 6 Months')
            {
                $query .= "WHERE CusID = $CustomerID AND ExpiryDate BETWEEN CURDATE() AND '$lessSix'
                    GROUP BY ExpiryDate, Client_SKU";
            }
            else if($label == 'More Than 6 Months')
            {
                $query .= "WHERE CusID = $CustomerID AND ExpiryDate BETWEEN '$lessSix' AND '2060-01-01'
                    GROUP BY ExpiryDate, Client_SKU";
            }
            else
            {
                $query .= "WHERE CusID = $CustomerID AND ExpiryDate < CURDATE()
                    GROUP BY ExpiryDate, Client_SKU";
            }
        }

        $res = mysqli_query($conn, $query);

        if(mysqli_num_rows($res) > 0)
        {
            
            while($rows = mysqli_fetch_array($res))
            { 
              $wgt = number_format((float)$rows[4], 2);
              $data[] = array(
                  'sku' => $rows[0],
                  'desc' => $rows[1],
                  'noOfSKU' => $rows[2],
                  'quantity' => $rows[3],
                  'wgt' => $wgt,
                  'expiry' => $rows[5],
                  'expiringInDays' => $rows[6]
              );
            
            }
            echo json_encode($data);
            // echo $query;
        }
        else
        {
            echo $query;
        }

    }
    else
    {

            if(!empty($searchkey))
            {
                if($label == 'Less Than 2 Months')
                {
                    $query .= "WHERE CusID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND ExpiryDate BETWEEN '$from' AND '$to'
                        GROUP BY ExpiryDate, Client_SKU";
                }
                else if($label == 'Less Than 4 Months')
                {
                    $query .= "WHERE CusID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND ExpiryDate BETWEEN '$from' AND '$to'
                        GROUP BY ExpiryDate, Client_SKU";
                }
                else if($label == 'Less Than 6 Months')
                {
                    $query .= "WHERE CusID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND ExpiryDate BETWEEN '$from' AND '$to'
                        GROUP BY ExpiryDate, Client_SKU";
                }
                else if($label == 'More Than 6 Months')
                {
                    $query .= "WHERE CusID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND ExpiryDate BETWEEN '$from' AND '$to'
                        GROUP BY ExpiryDate, Client_SKU";
                }
                else
                {
                    $query .= "WHERE CusID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND ExpiryDate BETWEEN '$from' AND '$to'
                        GROUP BY ExpiryDate, Client_SKU";
                }
            }
            else
            {
                if($label == 'Less Than 2 Months')
                {
                    $query .= "WHERE CusID = $CustomerID AND ExpiryDate BETWEEN '$from' AND '$to'
                        GROUP BY ExpiryDate, Client_SKU";
                }
                else if($label == 'Less Than 4 Months')
                {
                    $query .= "WHERE CusID = $CustomerID AND ExpiryDate BETWEEN '$from' AND '$to'
                        GROUP BY ExpiryDate, Client_SKU";
                }
                else if($label == 'Less Than 6 Months')
                {
                    $query .= "WHERE CusID = $CustomerID AND ExpiryDate BETWEEN '$from' AND '$to'
                        GROUP BY ExpiryDate, Client_SKU";
                }
                else if($label == 'More Than 6 Months')
                {
                    $query .= "WHERE CusID = $CustomerID AND ExpiryDate BETWEEN '$from' AND '$to'
                        GROUP BY ExpiryDate, Client_SKU";
                }
                else
                {
                    $query .= "WHERE CusID = $CustomerID AND ExpiryDate BETWEEN '$from' AND '$to'
                        GROUP BY ExpiryDate, Client_SKU";
                }
            }

            $res = mysqli_query($conn, $query);
            $date = date('Y-m-d');
            if(mysqli_num_rows($res) > 0)
            {
                
                while($rows = mysqli_fetch_array($res))
                { 
                    if($rows[0] <= $date)
                   {
                      $sku = $rows[0];
                      $desc = $rows[1];
                      $noOfSKU = $rows[2];
                      $quantity = $rows[3];
                      $wgt = $rows[4];
                      $expiry = $rows[5];
                      $expiringInDays = $rows[6];
                   }
                   else if($rows[0] > $date && $rows[0] <= $lessTwo)
                   {
                      $sku = $rows[0];
                      $desc = $rows[1];
                      $noOfSKU = $rows[2];
                      $quantity = $rows[3];
                      $wgt = $rows[4];
                      $expiry = $rows[5];
                      $expiringInDays = $rows[6];
                   }
                   else if($rows[0] > $date && $rows[0] <= $lessFour)
                   {
                      $sku = $rows[0];
                      $desc = $rows[1];
                      $noOfSKU = $rows[2];
                      $quantity = $rows[3];
                      $wgt = $rows[4];
                      $expiry = $rows[5];
                      $expiringInDays = $rows[6];
                   }
                   else if($rows[0] > $date && $rows[0] <= $lessSix)
                   {
                      $sku = $rows[0];
                      $desc = $rows[1];
                      $noOfSKU = $rows[2];
                      $quantity = $rows[3];
                      $wgt = $rows[4];
                      $expiry = $rows[5];
                      $expiringInDays = $rows[6];
                   }
                   else if($rows[0] > $lessSix)
                   {
                      $sku = $rows[0];
                      $desc = $rows[1];
                      $noOfSKU = $rows[2];
                      $quantity = $rows[3];
                      $wgt = $rows[4];
                      $expiry = $rows[5];
                      $expiringInDays = $rows[6];
                   }
                  $wgt = number_format((float)$rows[4], 2);
                  $data[] = array(
                      'sku' => $sku,
                      'desc' => $desc,
                      'noOfSKU' => $noOfSKU,
                      'quantity' => $quantity,
                      'wgt' => $wgt,
                      'expiry' => $expiry,
                      'expiringInDays' => $expiringInDays
                  );
                
                }
                echo json_encode($data);
            }
            else
            {
                echo $query;
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

    $query = "SELECT ItemID, ItemDesc, Client_SKU FROM wms_cloud.tbl_items WHERE ItemCustomerID = $CustomerID";

    $result = mysqli_query($conn, $query);

    while($rows = mysqli_fetch_array($result))
    {
        if($filter == 'SKUDesc')
        {
            echo '<option value="'.$rows[0].'">'.$rows[1].'</option>';
        }
        else
        {
            echo '<option value="'.$rows[0].'">'.$rows[2].'</option>';
        }
    }
}

// Dashboard

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
                ExpiryDate,
                Batch,
                ProdDate,
                Container,
                IF(OtherReference IS NULL OR OtherReference = '', 'No Other Reference', OtherReference) AS OtherReference,
                ItemCode,
                wms_inbound.tbl_receiving.IBN
            FROM wms_inbound.tbl_receivingitems
            LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
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
            $query .= "WHERE wms_inbound.tbl_receiving.CusID = $CustomerID
            AND wms_inbound.tbl_receivingitems.Quantity > 0 
            AND Checked = 'True'
            GROUP BY wms_inbound.tbl_receivingitems.ItemID, wms_inbound.tbl_receivingitems.ExpiryDate, wms_inbound.tbl_receivingitems.ItemStatusID
            ORDER BY wms_inbound.tbl_receivingitems.ItemID";
        }
        else
        {
            $query .= "WHERE wms_inbound.tbl_receiving.CusID = $CustomerID AND wms_cloud.tbl_customers.WarehouseID = $WarehouseID
            AND wms_inbound.tbl_receivingitems.Quantity > 0 
            AND Checked = 'True'
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

                if ($rows[7] != "No Expiry")
                {
                    $expiry = strtotime($rows[7]);
                    $expiry = date('d-M-Y',$expiry);
                }
                else
                {
                    $expiry = "No Expiry";
                }

                if ($rows[9] != "No Production Date")
                {
                    $prod = strtotime($rows[9]);
                    $prod = date('d-M-Y',$prod);
                }
                else
                {
                    $prod = "No Production Date";
                }

                if($rows[1] == '')
                {
                    $itemcode = $rows[0];
                    $itemcode = '<span style="color:red">*(' .$itemcode. ')*</span>';
                }
                else
                {
                    $itemcode = $rows[1];
                }

                $wgt = number_format((float)$rows[4], 2);
                
                $data[] = array(
                  'itemid'   => $rows[0],
                  'sku'   => $itemcode,
                  'item'   => $rows[2],
                  'qty'   => $rows[3],
                  'wgt'   => $wgt,
                  'oum'   => $rows[5],
                  'itemstatus'   => $rows[6],
                  'expirydate'   => $rows[7],
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
                ExpiryDate,
                Batch,
                ProdDate,
                Container,
                IF(OtherReference IS NULL OR OtherReference = '', 'No Other Reference', OtherReference) AS OtherReference,
                ItemCode,
                wms_inbound.tbl_receiving.IBN
            FROM wms_inbound.tbl_receivingitems
            LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
            LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
            LEFT JOIN wms_inbound.tbl_pallets on wms_inbound.tbl_receivingitems.PalletID = wms_inbound.tbl_pallets.PalletID
            LEFT JOIN wms_cloud.tbl_weightuom on wms_cloud.tbl_items.UOMID = wms_cloud.tbl_weightuom.UOMID
            LEFT JOIN wms_inbound.tbl_locations on wms_inbound.tbl_pallets.LocationID = wms_inbound.tbl_locations.LocationID
            LEFT JOIN wms_inbound.tbl_room on wms_inbound.tbl_locations.RoomCode = wms_inbound.tbl_room.RoomCode
            LEFT JOIN wms_cloud.tbl_itemstatus on wms_inbound.tbl_receivingitems.ItemStatusID = wms_cloud.tbl_itemstatus.ItemStatusID
            LEFT JOIN wms_cloud.tbl_customers on wms_inbound.tbl_receivingitems.CustomerID = wms_cloud.tbl_customers.CustomerID
            WHERE wms_inbound.tbl_receiving.CusID = $CustomerID 
            AND wms_inbound.tbl_receivingitems.Quantity > 0 
            AND Checked = 'True'
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

                if ($rows[7] != "No Expiry")
                {
                    $expiry = strtotime($rows[7]);
                    $expiry = date('d-M-Y',$expiry);
                }
                else
                {
                    $expiry = "No Expiry";
                }

                if ($rows[9] != "No Production Date")
                {
                    $prod = strtotime($rows[9]);
                    $prod = date('d-M-Y',$prod);
                }
                else
                {
                    $prod = "No Production Date";
                }

                if($rows[1] == '')
                {
                    $itemcode = $rows[0];
                    $itemcode = '<span style="color:red">*(' .$itemcode. ')*</span>';
                }
                else
                {
                    $itemcode = $rows[1];
                }

                $wgt = number_format((float)$rows[4], 2);
                
                $data[] = array(
                  'itemid'   => $rows[0],
                  'sku'   => $itemcode,
                  'item'   => $rows[2],
                  'qty'   => $rows[3],
                  'wgt'   => $wgt,
                  'oum'   => $rows[5],
                  'itemstatus'   => $rows[6],
                  'expirydate'   => $rows[7],
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
                ExpiryDate,
                Batch,
                ProdDate,
                Container,
                IF(OtherReference IS NULL OR OtherReference = '', 'No Other Reference', OtherReference) AS OtherReference,
                ItemCode,
                wms_inbound.tbl_receiving.IBN
            FROM wms_inbound.tbl_receivingitems
            LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
            LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
            LEFT JOIN wms_inbound.tbl_pallets on wms_inbound.tbl_receivingitems.PalletID = wms_inbound.tbl_pallets.PalletID
            LEFT JOIN wms_cloud.tbl_weightuom on wms_cloud.tbl_items.UOMID = wms_cloud.tbl_weightuom.UOMID
            LEFT JOIN wms_inbound.tbl_locations on wms_inbound.tbl_pallets.LocationID = wms_inbound.tbl_locations.LocationID
            LEFT JOIN wms_inbound.tbl_room on wms_inbound.tbl_locations.RoomCode = wms_inbound.tbl_room.RoomCode
            LEFT JOIN wms_cloud.tbl_itemstatus on wms_inbound.tbl_receivingitems.ItemStatusID = wms_cloud.tbl_itemstatus.ItemStatusID
            LEFT JOIN wms_cloud.tbl_customers on wms_inbound.tbl_receivingitems.CustomerID = wms_cloud.tbl_customers.CustomerID
            WHERE wms_inbound.tbl_receiving.CusID = $CustomerID
            AND wms_inbound.tbl_receivingitems.Quantity > 0 
            AND Checked = 'True'
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

                if ($rows[7] != "No Expiry")
                {
                    $expiry = strtotime($rows[7]);
                    $expiry = date('d-M-Y',$expiry);
                }
                else
                {
                    $expiry = "No Expiry";
                }

                if ($rows[9] != "No Production Date")
                {
                    $prod = strtotime($rows[9]);
                    $prod = date('d-M-Y',$prod);
                }
                else
                {
                    $prod = "No Production Date";
                }

                if($rows[1] == '')
                {
                    $itemcode = $rows[0];
                    $itemcode = '<span style="color:red">*(' .$itemcode. ')*</span>';
                }
                else
                {
                    $itemcode = $rows[1];
                }

                $wgt = number_format((float)$rows[4], 2);
                
                $data[] = array(
                  'itemid'   => $rows[0],
                  'sku'   => $itemcode,
                  'item'   => $rows[2],
                  'qty'   => $rows[3],
                  'wgt'   => $wgt,
                  'oum'   => $rows[5],
                  'itemstatus'   => $rows[6],
                  'expirydate'   => $rows[7],
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
                ItemStatus
            FROM
                wms_inbound.tbl_itr_report
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
            'recDate' => '',
            'controlno' => 'No data Found!',
            'ref' => '',
            'qty' => '',
            'wgt' => '',
            'container' => '',
            'checker' => '',
            'status' =>'',
            'remarks' =>'',
            'action' =>''

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
                'goodqty' => $rows[2],
                'holdqty' => $rows[3],
                'blockqty' => '-',
                'qty' => $rows[4],
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
        $date1=date_create($datefrom);
        $date2=date_create($dateto);
        $diff=date_diff($date1,$date2);
        $datetotal = $diff->format("%a");

        if($datetotal <= 2)
        {
            $datefrom = '2001-01-01T09:10';
            $dateto = '2031-01-01T09:10';
        }

        $query = "SELECT * FROM wms_outbound.tbl_otrv2cp
                    WHERE
                  CustomerID = $CustomerID
                    AND OrderDate BETWEEN '$datefrom' AND '$dateto'
                ";

        if(empty($WarehouseID))
        {
            if($filtered == 'controlno')
            {
                $query .= "AND ORD LIKE '%$key%' GROUP BY ORD";
            }
            else if($filtered == 'Container')
            {
                $query .= "AND Container LIKE '%$key%' GROUP BY ORD";
            }
            else if($filtered == 'StatusID')
            {
                $query .= "AND StatusIDD LIKE '%$key%' GROUP BY ORD";
            }
            else if(empty($filtered))
            {
                $query .= "GROUP BY ORD";
            }
        }
        else
        {
            $query .= "AND WarehouseID = $WarehouseID
            ";
            if($filtered == 'controlno')
            {
                $query .= "AND ORD LIKE '%$key%' GROUP BY ORD";
            }
            else if($filtered == 'Container')
            {
                $query .= "AND Container LIKE '%$key%' GROUP BY ORD";
            }
            else if($filtered == 'StatusID')
            {
                $query .= "AND StatusIDD LIKE '%$key%' GROUP BY ORD";
            }
            else if(empty($filtered))
            {
                $query .= "GROUP BY ORD";
            }
        
        }

            $result = mysqli_query($conn, $query);
            $status = '';
            while ($rows = mysqli_fetch_row($result))
            {   
                

                $wgt = $rows[8] * $rows[3];
                $wgt = number_format((float)$wgt, 2);

                $data[] = array(
                    'recDate' => $rows[0],
                    'controlord' => $rows[1],
                    'ref' => $rows[2],
                    'qty' => $rows[3],
                    'wgt' => $wgt,
                    'container' => $rows[4],
                    'status' => $rows[7] ,
                    'remarks' => $rows[6]

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
                ExpiryDate,
                Container,
                Batch,
                IF(OtherReference IS NULL OR OtherReference = '', 'NONE', OtherReference) AS OtherReference,
                IF(DATEDIFF(ExpiryDate,CURDATE()) < 1, 'Expired', DATEDIFF(ExpiryDate,CURDATE())) AS ExpiryDate
            FROM wms_inbound.tbl_receivingitems ri
            LEFT JOIN wms_cloud.tbl_items item ON ri.ItemId = item.ItemID
            LEFT JOIN wms_cloud.tbl_weightuom uom ON item.UOMID = uom.UOMID
            LEFT JOIN wms_inbound.tbl_receiving r ON ri.IBN = r.IBN
            LEFT JOIN wms_cloud.tbl_customers cus on ri.CustomerID = cus.CustomerID
            WHERE Quantity > 0 AND ExpiryDate != 'No Expiry'
            AND ri.CustomerID = $CustomerID
            ";

    if(empty($WarehouseID))
    {
        $query .= "GROUP BY ri.ItemID, ExpiryDate, Container, Batch
            ORDER BY DATE(ExpiryDate) ASC";
    }
    else
    {
        $query .= "AND cus.WarehouseID = $WarehouseID
        GROUP BY ri.ItemID, ExpiryDate, Container, Batch
            ORDER BY DATE(ExpiryDate) ASC";
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

            if($rows[1] == '')
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

            $qty = number_format((float)$rows[4], 2);
            $qty = floatval(preg_replace('/[^\d.]/', '', $qty));

            $data[] = array(
              'sku'   => $itemcode,
              'item'   => $rows[2],
              'oum'   => $rows[3],
              'qty'   => $qty,
              'wgt'   => $wgt,
              'cvnumber'   => $rows[7],
              'otherref'   => $rows[9],
              'batch'   => $rows[8],
              'expirydate'   => $rows[6],
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
                ExpiryDate,
                Container,
                Batch,
                IF(OtherReference IS NULL OR OtherReference = '', 'NONE', OtherReference) AS OtherReference,
                IF(DATEDIFF(ExpiryDate,CURDATE()) < 1, 'Expired', DATEDIFF(ExpiryDate,CURDATE())) AS ExpiryDate
            FROM wms_inbound.tbl_receivingitems ri
            LEFT JOIN wms_cloud.tbl_items item ON ri.ItemId = item.ItemID
            LEFT JOIN wms_cloud.tbl_weightuom uom ON item.UOMID = uom.UOMID
            LEFT JOIN wms_inbound.tbl_receiving r ON ri.IBN = r.IBN
            LEFT JOIN wms_cloud.tbl_customers cus on ri.CustomerID = cus.CustomerID
            WHERE Quantity > 0 AND ExpiryDate != 'No Expiry'
            AND ri.CustomerID = $CustomerID
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

            if($rows[1] == '')
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

            $qty = number_format((float)$rows[4], 2);
            $qty = floatval(preg_replace('/[^\d.]/', '', $qty));

            // $qty = $rows[4];

            $data[] = array(
              'sku'   => $itemcode,
              'item'   => $rows[2],
              'oum'   => $rows[3],
              'qty'   => $qty,
              'wgt'   => $wgt,
              'cvnumber'   => $rows[7],
              'otherref'   => $rows[9],
              'batch'   => $rows[8],
              'expirydate'   => $rows[6],
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
                ExpiryDate,
                Container,
                Batch,
                IF(OtherReference IS NULL OR OtherReference = '', 'NONE', OtherReference) AS OtherReference,
                IF(DATEDIFF(ExpiryDate,CURDATE()) < 1, 'Expired', DATEDIFF(ExpiryDate,CURDATE())) AS ExpiryDate
            FROM wms_inbound.tbl_receivingitems ri
            LEFT JOIN wms_cloud.tbl_items item ON ri.ItemId = item.ItemID
            LEFT JOIN wms_cloud.tbl_weightuom uom ON item.UOMID = uom.UOMID
            LEFT JOIN wms_inbound.tbl_receiving r ON ri.IBN = r.IBN
            LEFT JOIN wms_cloud.tbl_customers cus on ri.CustomerID = cus.CustomerID
            WHERE Quantity > 0 AND ExpiryDate != 'No Expiry'
            AND ri.CustomerID = $CustomerID
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

            if($rows[1] == '')
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

            $qty = number_format((float)$rows[4], 2);
            $qty = floatval(preg_replace('/[^\d.]/', '', $qty));

            // $qty = $rows[4];

            $data[] = array(
              'sku'   => $itemcode,
              'item'   => $rows[2],
              'oum'   => $rows[3],
              'qty'   => $qty,
              'wgt'   => $wgt,
              'cvnumber'   => $rows[7],
              'otherref'   => $rows[9],
              'batch'   => $rows[8],
              'expirydate'   => $rows[6],
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

    $query_in = "SELECT 
                ReceivingDate, 
                wms_inbound.tbl_receiving.IBN,
                CustomerReference,
                CompanyName, 
                SUM(Beg_Quantity), 
                SUM(Beg_Weight), 
                COUNT(DISTINCT (CASE WHEN PalletType != 3 THEN PalletID END)),
                Container,
                Checker,
                Remarks,
                ItemDesc,
                Client_SKU
                FROM wms_inbound.tbl_receiving 
                LEFT JOIN wms_cloud.tbl_customers ON wms_inbound.tbl_receiving.CusID = wms_cloud.tbl_customers.CustomerID 
                LEFT JOIN wms_inbound.tbl_receivingitems ON wms_inbound.tbl_receiving.IBN = wms_inbound.tbl_receivingitems.IBN
                LEFT JOIN wms_cloud.tbl_items ON wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                WHERE CusID = $CustomerID AND ReceivingDate BETWEEN '$datefrom' AND '$dateto' GROUP BY wms_inbound.tbl_receiving.IBN, wms_inbound.tbl_receivingitems.ItemID ";
       
    $data = array();
    $data_in = array();
    $data_out = array();
    if($result = mysqli_query($conn, $query_in))
    {
        while ($rows = mysqli_fetch_row($result))
        {   

            $dor = strtotime($rows[0]);
            $dor = date('d-M-Y H:m:s',$dor);

            $wgt = number_format((float)$rows[5], 2);
            $wgt = floatval(preg_replace('/[^\d.]/', '', $wgt));
            
            $data_in[] = array(
                'recDate' => $rows[0],
                'controlno' => $rows[1],
                'ref' => $rows[2],
                'sku' => $rows[11],
                'desc' => $rows[10],
                'qty' => $rows[4],
                'wgt' => $wgt,
                'container' => $rows[7],
                'remarks' => $rows[9]

            ); 
        }

    }
    else
    {
        echo "Error!!!";
    }

    $query = "
            SELECT
                i.IssuanceDate,
                i.OBD,
                CustomerReference,
                c.CompanyName,
                (SELECT
                    SUM(Quantity)
                    FROM wms_outbound.tbl_issuances ic
                    LEFT JOIN wms_outbound.tbl_issuancelist il ON ic.OBD = il.OBD
                    LEFT JOIN wms_outbound.tbl_actualpick ap ON il.PicklistID = ap.PicklistID
                    WHERE i.OBD = il.OBD
                    order by ic.IssuanceDate ASC) Quantity,
                (SELECT
                    SUM(Weight)
                    FROM wms_outbound.tbl_issuances ic
                    LEFT JOIN wms_outbound.tbl_issuancelist il ON ic.OBD = il.OBD
                    LEFT JOIN wms_outbound.tbl_actualpick ap ON il.PicklistID = ap.PicklistID
                    WHERE i.OBD = il.OBD
                    order by ic.IssuanceDate ASC) Weight,
               
                SUM(PalletOut) PalletOut,
                i.Container,
                Checker,
                Remarks,
                ItemName,
                ClientSKU
            FROM wms_outbound.tbl_issuances i
            LEFT JOIN wms_cloud.tbl_customers c ON i.CustomerID = c.CustomerID
            LEFT JOIN wms_outbound.tbl_issuancelist il ON i.OBD = il.OBD
            LEFT JOIN wms_outbound.tbl_picklist pl ON il.PicklistID = pl.id
            WHERE IssuanceDate BETWEEN '$datefrom' AND '$dateto' AND i.CustomerID = $CustomerID
            GROUP BY i.OBD
            ORDER BY IssuanceDate ASC";
        


    $result = mysqli_query($conn, $query);
    while ($rows = mysqli_fetch_row($result))
    {
        $IssuanceDate = strtotime($rows[0]);
        $IssuanceDate = date('d-M-Y H:m:s',$IssuanceDate);
        $wgt_out = number_format((float)$rows[5], 2);
        $wgt_out = floatval(preg_replace('/[^\d.]/', '', $wgt_out));
       
       $data_out[] = array(
            'recDate' => $rows[0],
            'controlno' => $rows[1],
            'ref' => $rows[2],
            'sku' => $rows[11],
            'desc' => $rows[10],
            'qty' => $rows[4],
            'wgt' => $wgt_out,
            'container' => $rows[7],
            'remarks' => $rows[9]
       );
    }

    $data = array_merge($data_out, $data_in);

    echo json_encode($data);
}

function Report_GenerateGM($CustomerID, $ItemID, $SubFilter, $Co_SubFilter, $datefrom, $dateto)
{
    include ('dbcon.php');

    global $total_qty_begining;
    global $total_qty_inbound;
    global $total_qty_outbound;
    global $total_weight_begining;
    global $total_weight_inbound;
    global $total_weight_outbound;
    global $itemname;
    global $oum;


    $date1=date_create($datefrom);
    $date2=date_create($dateto);
    $diff=date_diff($date1,$date2);
    $datetotal = $diff->format("%a");

    if($datetotal <= 2)
    {
        
        $query_item = "
                    SELECT  
                    Client_SKU,
                    ItemCode,
                    wms_cloud.tbl_items.ItemDesc
                    FROM wms_inbound.tbl_receivingitems
                    LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                    WHERE wms_cloud.tbl_items.ItemID = $ItemID
                    GROUP BY wms_cloud.tbl_items.ItemID";
        $result = mysqli_query($conn, $query_item);

        while($rows = mysqli_fetch_array($result))
        {   
            if($rows[0] == null || $rows[0] == '')
            {
                $itemname = '<span style="color:red"> *'.  $rows[1] .'</span> - '.  $rows[2] ;
            }
            else
            {
                $itemname = $rows[0] .' - '.  $rows[2];
            }
            echo '
                <tr class="thead">
                   <td colspan="10" style="border:1px solid black;"><h3 style="text-align:center;">'.$itemname.'</h3></td>
                </tr>
            ';
        }

        echo '
            <tr class="thead1">
                <td style="border:1px solid black;"></td>
                <td style="border:1px solid black;" colspan="2" style="text-align:center">Inbound</td>
                <td style="border:1px solid black;" colspan="2" style="text-align:center">Outbound</td>
                <td style="border:1px solid black;"></td>
                <td style="border:1px solid black;"></td>
                <td style="border:1px solid black;"></td>
                <td style="border:1px solid black;"></td>
                <td style="border:1px solid black;"></td>
            </tr>
            <tr>
                <td style="border:1px solid black;" width="5%"></td>
                <td style="border:1px solid black;" width="5%">Quantity</td>
                <td style="border:1px solid black;" width="5%">Weight</td>
                <td style="border:1px solid black;" width="5%">Quantity</td>
                <td style="border:1px solid black;" width="5%">Weight</td>
                <td style="border:1px solid black;" width="10%">Control Number</td>
                <td style="border:1px solid black;" width="10%">CV Number</td>
                <td style="border:1px solid black;" width="10%">Batch</td>
                <td style="border:1px solid black;" width="10%">OtherReference</td>
                <td style="border:1px solid black;" width="10%">Date</td>
            </tr>
        ';

       
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
                    r.OtherReference
                    FROM wms_inbound.tbl_receivingitems ri
                    LEFT JOIN wms_inbound.tbl_receiving r ON ri.IBN = r.IBN
                    LEFT JOIN wms_cloud.tbl_items item ON ri.ItemID = item.ItemID
                    WHERE ri.CustomerID = $CustomerID AND ri.ItemID = $ItemID
                    AND r.ReceivingDate BETWEEN '2000-01-01T08:00' AND '2001-01-01T08:00'
                    ";

        if($SubFilter == null || $SubFilter == '')
        {
            $query_beginning .= "GROUP BY ri.ItemID
            ORDER BY r.ReceivingDate ASC";
        }
        else if($SubFilter == 1)
        {
            if($Co_SubFilter == 'all')
            {
                $query_beginning .= "GROUP BY ri.IBN
                ORDER BY r.ReceivingDate ASC";
            }
            else
            {
                $query_beginning .= "AND Container = '$Co_SubFilter'
                GROUP BY ri.IBN
                ORDER BY r.ReceivingDate ASC";
            }
        }


        else if($SubFilter == 2)
        {
            if($Co_SubFilter == 'all')
            {
                $query_beginning .= "GROUP BY ri.IBN
                ORDER BY r.ReceivingDate ASC";
            }
            else
            {
                 $query_beginning .= "AND Batch = '$Co_SubFilter'
                                    GROUP BY ri.IBN
                                    ORDER BY r.ReceivingDate ASC";
            }
        }

        else if($SubFilter == 3)
        {
              if($Co_SubFilter == 'all')
            {
                $query_beginning .= "GROUP BY ri.IBN
                ORDER BY r.ReceivingDate ASC";
            }
            else
            {
                $query_beginning .= "AND ExpiryDate = '$Co_SubFilter'
                GROUP BY ri.IBN
                ORDER BY r.ReceivingDate ASC";
            }
        }

        else if($SubFilter == 4)
        {
            if($Co_SubFilter == 'all')
            {
                $query_beginning .= "GROUP BY ri.IBN
                ORDER BY r.ReceivingDate ASC";
            }
            else if($Co_SubFilter == 'no_or')
            {
                $query_beginning .= "GROUP BY ri.IBN
                ORDER BY r.ReceivingDate ASC";
            }
            else
            {
                $query_beginning .= "AND ExpiryDate = '$Co_SubFilter'
                GROUP BY ri.IBN
                ORDER BY r.ReceivingDate ASC";
            }
        }

        else if($SubFilter == 5)
        {
             $query_beginning .= "GROUP BY ri.ItemID
            ORDER BY r.ReceivingDate ASC";
        }

        $result = mysqli_query($conn, $query_beginning);

        

        while($rows = mysqli_fetch_array($result))
        {   

            
             $total_qty_begining = $total_qty_begining + $rows[3];
             $total_weight_begining = $total_weight_begining + $rows[4];
             $gm_date = $datefrom;
             $gm_date = strtotime($datefrom);
             $gm_date = date('d-M-Y', $gm_date);

            echo '

                    <tr>
                        <td style="border:1px solid black;"></td>
                        <td style="border:1px solid black;">'.$rows[3].'</td>
                        <td style="border:1px solid black;">'.number_format((float)$rows[4], 2).'</td>
                        <td style="border:1px solid black;"></td>
                        <td style="border:1px solid black;"></td>
                        <td style="border:1px solid black;">Begining</td>
                        <td style="border:1px solid black;"></td>
                        <td style="border:1px solid black;"></td>
                        <td style="border:1px solid black;"></td>
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
                   -- AND r.ReceivingDate BETWEEN '$datefrom' AND '$dateto'
                    
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
                $query_inbound .= "GROUP BY ri.IBN, ri.ItemID
                ORDER BY r.ReceivingDate ASC";
            }
            else
            {
                $query_inbound .= "AND Container = '$Co_SubFilter'
                GROUP BY ri.IBN
                ORDER BY r.ReceivingDate ASC";
            }
        }

        else if($SubFilter == 2)
        {
            if($Co_SubFilter == 'all')
            {
                $query_inbound .= "GROUP BY ri.IBN
                ORDER BY r.ReceivingDate ASC";
            }
            else
            {
                 $query_inbound .= "AND Batch = '$Co_SubFilter'
                                    GROUP BY ri.IBN
                                    ORDER BY r.ReceivingDate ASC";
            }
        }

        else if($SubFilter == 3)
        {
              if($Co_SubFilter == 'all')
            {
                $query_inbound .= "GROUP BY ri.IBN
                ORDER BY r.ReceivingDate ASC";
            }
            else
            {
                $query_inbound .= "AND ExpiryDate = '$Co_SubFilter'
                GROUP BY ri.IBN
                ORDER BY r.ReceivingDate ASC";
            }
        }

        else if($SubFilter == 4)
        {
            if($Co_SubFilter == 'all')
            {
                $query_inbound .= "GROUP BY ri.IBN
                ORDER BY r.ReceivingDate ASC";
            }
            else if($Co_SubFilter == 'no_or')
            {
                $query_inbound .= "AND (OtherReference IS NULL OR OtherReference = '')
                GROUP BY ri.IBN
                ORDER BY r.ReceivingDate ASC";
            }
            else
            {
                $query_inbound .= "AND ReceivingID = '$Co_SubFilter'
                GROUP BY ri.IBN
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

             $oum = $rows[11];

            echo '

                    <tr>
                        <td style="border:1px solid black;"></td>
                        <td style="border:1px solid black;">'.$rows[3].'</td>
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
                            ItemID,
                            IFNULL(SUM(Quantity),0),
                            IFNULL(SUM(Weight),0),
                            IssuanceDate,
                            OBD,
                            CustomerID,
                            Container,
                            Batch,
                            OtherReference
                            FROM wms_outbound.tbl_view_gm_outbound_report
                            WHERE ItemID = $ItemID AND CustomerID = $CustomerID
                           -- AND IssuanceDate BETWEEN '$datefrom' AND '$dateto'
                            
                    ";
        

        if($SubFilter == null || $SubFilter == '')
        {
            $query_outbound .= "
            GROUP BY OBD, Container";
        }
        else if($SubFilter == 1)
        {
            if($Co_SubFilter == 'all')
            {
                $query_outbound .= "GROUP BY OBD, Container";
            }
            else
            {
                $query_outbound .= "AND Container = '$Co_SubFilter'
                GROUP BY OBD, Container";
            }
        }

        else if($SubFilter == 2)
        {
            if($Co_SubFilter == 'all')
            {
                $query_outbound .= "GROUP BY OBD, Container";
            }
            else
            {
                $query_outbound .= "AND Batch= '$Co_SubFilter'
                GROUP BY OBD, Container";
            }
        }

        else if($SubFilter == 3)
        {
            if($Co_SubFilter == 'all')
            {
                $query_outbound .= "GROUP BY OBD, Container";
            }
            else
            {
                $query_outbound .= "AND AllocatedExpiry = '$Co_SubFilter'
                GROUP BY OBD, Container";
            }
        }
        else if($SubFilter == 4)
        {
            if($Co_SubFilter == 'all')
            {
                $query_outbound .= "GROUP BY OBD, Container";
            }
            else if($Co_SubFilter == 'no_or')
            {
                $query_outbound .= "AND (OtherReference IS NULL OR OtherReference = '')
                GROUP BY OBD, Container";
            }
            else
            {
                $query_outbound .= "AND ReceivingID = '$Co_SubFilter'
                GROUP BY OBD, Container";
            }
        }
        

        $result = mysqli_query($conn, $query_outbound);
        while($rows = mysqli_fetch_array($result))
        {   
             $total_qty_outbound = $total_qty_outbound + $rows[1];
             $total_weight_outbound = $total_weight_outbound + $rows[2];
             $gm_date = $rows[3];
             $gm_date = strtotime($rows[3]);
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
                         <td style="border:1px solid black;">'.$rows[1].'</td>
                        <td style="border:1px solid black;">'.number_format((float)$rows[2], 2).'</td>
                        <td style="border:1px solid black;">'.$rows[4].'</td>
                        <td style="border:1px solid black;">'.$rows[6].'</td>
                        <td style="border:1px solid black;">'.$rows[7].'</td>
                        <td style="border:1px solid black;">'.$rows[8].'</td>
                        <td style="border:1px solid black;">'.$gm_date.'</td>
                    </tr>

            ';
        }
    }
    else
    {

        $query_item = "
                    SELECT  
                    Client_SKU,
                    ItemCode,
                    wms_cloud.tbl_items.ItemDesc
                    FROM wms_inbound.tbl_receivingitems
                    LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                    WHERE wms_cloud.tbl_items.ItemID = $ItemID
                    GROUP BY wms_cloud.tbl_items.ItemID";
        $result = mysqli_query($conn, $query_item);

        while($rows = mysqli_fetch_array($result))
        {   
            if($rows[0] == null || $rows[0] == '')
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
                <td style="border:1px solid black;"></td>
                <td style="border:1px solid black;" colspan="2" style="text-align:center">Inbound</td>
                <td style="border:1px solid black;" colspan="2" style="text-align:center">Outbound</td>
                <td style="border:1px solid black;"></td>
                <td style="border:1px solid black;"></td>
                <td style="border:1px solid black;"></td>
                <td style="border:1px solid black;"></td>
                <td style="border:1px solid black;"></td>
            </tr>
            <tr>
                <td style="border:1px solid black;" width="5%"></td>
                <td style="border:1px solid black;" width="5%" style="widtd: 15%">Quantity</td>
                <td style="border:1px solid black;" width="5%" style="widtd: 15%">Weight</td>
                <td style="border:1px solid black;" width="5%">Quantity</td>
                <td style="border:1px solid black;" width="5%">Weight</td>
                <td style="border:1px solid black;" width="10%">Control Number</td>
                <td style="border:1px solid black;" width="10%">CV Number</td>
                <td style="border:1px solid black;" width="10%">Batch</td>
                <td style="border:1px solid black;" width="10%">Other Reference</td>
                <td style="border:1px solid black;" width="10%">Date</td>
            </tr>
        ';

       
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
                    AND r.ReceivingDate BETWEEN '2000-01-01T08:00' AND '$datefrom'
                    ";

        if($SubFilter == null || $SubFilter == '')
        {
            $query_beginning .= "GROUP BY ri.ItemID
            ORDER BY r.ReceivingDate ASC";
        }
        else if($SubFilter == 1)
        {
            if($Co_SubFilter == 'all')
            {
                $query_beginning .= "GROUP BY ri.ItemID
                ORDER BY r.ReceivingDate ASC";
            }
            else
            {
                $query_beginning .= "AND Container = '$Co_SubFilter'
                GROUP BY ri.ItemID
                ORDER BY r.ReceivingDate ASC";
            }
        }


        else if($SubFilter == 2)
        {
            if($Co_SubFilter == 'all')
            {
                $query_beginning .= "GROUP BY ri.ItemID
                ORDER BY r.ReceivingDate ASC";
            }
            else
            {
                 $query_beginning .= "AND Batch = '$Co_SubFilter'
                                    GROUP BY ri.ItemID
                                    ORDER BY r.ReceivingDate ASC";
            }
        }

        else if($SubFilter == 3)
        {
              if($Co_SubFilter == 'all')
            {
                $query_beginning .= "GROUP BY ri.ItemID
                ORDER BY r.ReceivingDate ASC";
            }
            else
            {
                $query_beginning .= "AND ExpiryDate = '$Co_SubFilter'
                GROUP BY ri.ItemID
                ORDER BY r.ReceivingDate ASC";
            }
        }
        else if($SubFilter == 4)
        {
            if($Co_SubFilter == 'all')
            {
                $query_beginning .= "GROUP BY ri.ItemID";
            }
            else if($Co_SubFilter == 'no_or')
            {
                $query_beginning .= "AND (OtherReference IS NULL OR OtherReference = '')
                GROUP BY ri.ItemID";
            }
            else
            {
                $query_beginning .= "AND ReceivingID = '$Co_SubFilter'
                GROUP BY ri.ItemID";
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
                        <td style="border:1px solid black;">'.$rows[3].'</td>
                        <td style="border:1px solid black;">'.number_format((float)$rows[4], 2).'</td>
                        <td style="border:1px solid black;"></td>
                        <td style="border:1px solid black;"></td>
                        <td style="border:1px solid black;">Begining</td>
                        <td style="border:1px solid black;"></td>
                        <td style="border:1px solid black;"></td>
                        <td style="border:1px solid black;"></td>
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
                    AND r.ReceivingDate BETWEEN '$datefrom' AND '$dateto'
                    
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
                $query_inbound .= "GROUP BY ri.IBN, ri.ItemID
                ORDER BY r.ReceivingDate ASC";
            }
            else
            {
                $query_inbound .= "AND Container = '$Co_SubFilter'
                GROUP BY ri.IBN
                ORDER BY r.ReceivingDate ASC";
            }
        }

        else if($SubFilter == 2)
        {
            if($Co_SubFilter == 'all')
            {
                $query_inbound .= "GROUP BY ri.IBN
                ORDER BY r.ReceivingDate ASC";
            }
            else
            {
                 $query_inbound .= "AND Batch = '$Co_SubFilter'
                                    GROUP BY ri.IBN
                                    ORDER BY r.ReceivingDate ASC";
            }
        }

        else if($SubFilter == 3)
        {
              if($Co_SubFilter == 'all')
            {
                $query_inbound .= "GROUP BY ri.IBN
                ORDER BY r.ReceivingDate ASC";
            }
            else
            {
                $query_inbound .= "AND ExpiryDate = '$Co_SubFilter'
                GROUP BY ri.IBN
                ORDER BY r.ReceivingDate ASC";
            }
        }

        else if($SubFilter == 4)
        {
            if($Co_SubFilter == 'all')
            {
                $query_inbound .= "GROUP BY ri.IBN
                ORDER BY r.ReceivingDate ASC";
            }
            else if($Co_SubFilter == 'no_or')
            {
                $query_inbound .= "AND (OtherReference IS NULL OR OtherReference = '')
                GROUP BY ri.IBN
                ORDER BY r.ReceivingDate ASC";
            }
            else
            {
                $query_inbound .= "AND ReceivingID = '$Co_SubFilter'
                GROUP BY ri.IBN
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

             $oum = $rows[11];

            echo '

                    <tr>
                        <td style="border:1px solid black;"></td>
                        <td style="border:1px solid black;">'.$rows[3].'</td>
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
                            ItemID,
                            IFNULL(SUM(Quantity),0),
                            IFNULL(SUM(Weight),0),
                            IssuanceDate,
                            OBD,
                            CustomerID,
                            Container,
                            Batch,
                            OtherReference
                            FROM wms_outbound.tbl_view_gm_outbound_report
                            WHERE ItemID = $ItemID AND CustomerID = $CustomerID
                            AND IssuanceDate BETWEEN '$datefrom' AND '$dateto'
                            
                    ";
        

        if($SubFilter == null || $SubFilter == '')
        {
            $query_outbound .= "
            GROUP BY OBD, Container";
        }
        else if($SubFilter == 1)
        {
            if($Co_SubFilter == 'all')
            {
                $query_outbound .= "GROUP BY OBD, Container";
            }
            else
            {
                $query_outbound .= "AND Container = '$Co_SubFilter'
                GROUP BY OBD, Container";
            }
        }

        else if($SubFilter == 2)
        {
            if($Co_SubFilter == 'all')
            {
                $query_outbound .= "GROUP BY OBD, Container";
            }
            else
            {
                $query_outbound .= "AND Batch = '$Co_SubFilter'
                GROUP BY OBD, Container";
            }
        }

        else if($SubFilter == 3)
        {
            if($Co_SubFilter == 'all')
            {
                $query_outbound .= "GROUP BY OBD, Container";
            }
            else
            {
                $query_outbound .= "AND AllocatedExpiry = '$Co_SubFilter'
                GROUP BY OBD, Container";
            }
        }
        else if($SubFilter == 4)
        {
            if($Co_SubFilter == 'all')
            {
                $query_outbound .= "GROUP BY OBD, Container";
            }
            else if($Co_SubFilter == 'no_or'){
                $query_outbound .= "AND (OtherReference IS NULL OR OtherReference = '')
                GROUP BY OBD, Container";
            }
            else
            {
                $query_outbound .= "AND ReceivingID = '$Co_SubFilter'
                GROUP BY OBD, Container";
            }
        }

        $result = mysqli_query($conn, $query_outbound);
        while($rows = mysqli_fetch_array($result))
        {   
             $total_qty_outbound = $total_qty_outbound + $rows[1];
             $total_weight_outbound = $total_weight_outbound + $rows[2];
             $gm_date = $rows[3];
             $gm_date = strtotime($rows[3]);
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
                     <td style="border:1px solid black;">'.$rows[1].'</td>
                    <td style="border:1px solid black;">'.number_format((float)$rows[2], 2).'</td>
                    <td style="border:1px solid black;">'.$rows[4].'</td>
                    <td style="border:1px solid black;">'.$rows[6].'</td>
                    <td style="border:1px solid black;">'.$rows[7].'</td>
                    <td style="border:1px solid black;">'.$rows[8].'</td>
                    <td style="border:1px solid black;">'.$gm_date.'</td>
                </tr>

            ';
        }
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
            <td style="border:1px solid black; font-weight:bold;">'.$total_qty.'</td>
            <td style="border:1px solid black; font-weight:bold;">'.$total_wgt.'</td>
            <td style="border:1px solid black; font-weight:bold;">'.$total_qty_outbound.'</td>
            <td style="border:1px solid black; font-weight:bold;">'.$total_weight_outbound.'</td>
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
            <td style="border:1px solid black; font-weight:bold;text-align:center;color:red;" colspan="2">'.$total_remaining_qty.'</td>
            <td style="border:1px solid black; font-weight:bold;text-align:center;color:red;" colspan="2">'.number_format((float)$total_remaining_wgt, 2).'</td>
            <td style="border:1px solid black; font-weight:bold;text-align:center;color:red;" colspan="2">Remaining</td>
            <td style="border:1px solid black;"></td>
            <td style="border:1px solid black;"></td>
            <td style="border:1px solid black;"></td>

        </tr>



    ';


    echo '  
        <tr>
             <td style="border:1px solid black;" colspan="10"></td>
        </tr>

        <tr>
             <td style="border:1px solid black;" colspan="10"><h3 style="text-align:center;">'.$itemname.'</h3></td>
        </tr>
         
        
        <tr>
             <td style="border:1px solid black;"></td>
             <td style="border:1px solid black;"></td>
             <td style="border:1px solid black;"></td>
             <td style="border:1px solid black;">Quantity</td>
             <td style="border:1px solid black;">Weight</td>
             
             <td style="border:1px solid black;">CV Number</td>
             <td style="border:1px solid black;">Batch</td>
             <td style="border:1px solid black;">OtherReference</td>
             <td style="border:1px solid black;"></td>
             <td style="border:1px solid black;"></td>
        </tr>
    ';


    if($datetotal == 1)
    {   

        $qty = 0;
        $wgt = 0;
        $total_qty = 0;
        $total_wgt = 0;
       
           $query_breakdown = "SELECT
                                    SUM(ri.Beg_Quantity),
                                    SUM(ri.Beg_Weight),
                                    (SELECT IFNULL(SUM(Quantity), 0)
                                        FROM wms_outbound.tbl_view_gm_outbound_report gm
                                        WHERE ItemID = $ItemID AND CustomerID = $CustomerID
                                        AND rec.Container = gm.Container) AS Quantity_Out,
                                    (SELECT IFNULL(SUM(Weight), 0)
                                        FROM wms_outbound.tbl_view_gm_outbound_report gm
                                        WHERE ItemID = $ItemID AND CustomerID = $CustomerID
                                        AND rec.Container = gm.Container) AS Weight_Out,
                                    Container,
                                    Batch,
                                    OtherReference
                                    FROM wms_inbound.tbl_receivingitems ri
                                    LEFT JOIN wms_inbound.tbl_receiving rec on ri.IBN = rec.IBN
                                    WHERE ri.ItemID = $ItemID AND ri.CustomerID = $CustomerID
                                ";
        if($SubFilter == null || $SubFilter == '')
        {
            $query_breakdown .= "GROUP BY rec.Container";
        }
        else if($SubFilter == 1)
        {
            if($Co_SubFilter == 'all')
            {
                $query_breakdown .= "GROUP BY rec.Container";
            }
            else
            {
                $query_breakdown .= "AND Container = '$Co_SubFilter'
                GROUP BY rec.Container";
            }
        }

        else if($SubFilter == 2)
        {
            if($Co_SubFilter == 'all')
            {
                $query_breakdown .= "GROUP BY rec.Container";
            }
            else
            {
                $query_breakdown .= "AND Batch = '$Co_SubFilter'
                GROUP BY rec.Container";
            }
        }

        else if($SubFilter == 3)
        {   
            if($Co_SubFilter == 'all')
            {
                $query_breakdown .= "GROUP BY rec.Container";
            }
            else
            {
                $query_breakdown = "SELECT
                                    SUM(ri.Beg_Quantity),
                                    SUM(ri.Beg_Weight),
                                    (SELECT IFNULL(SUM(Quantity), 0)
                                        FROM wms_outbound.tbl_view_gm_outbound_report gm
                                        WHERE ItemID = $ItemID AND CustomerID = $CustomerID
                                        AND rec.Container = gm.Container
                                        AND AllocatedExpiry = '$Co_SubFilter') AS Quantity_Out,
                                    (SELECT IFNULL(SUM(Weight), 0)
                                        FROM wms_outbound.tbl_view_gm_outbound_report gm
                                        WHERE ItemID = $ItemID AND CustomerID = $CustomerID
                                        AND rec.Container = gm.Container
                                        AND AllocatedExpiry = '$Co_SubFilter') AS Weight_Out,
                                    Container,
                                    Batch,
                                    OtherReference
                                    FROM wms_inbound.tbl_receivingitems ri
                                    LEFT JOIN wms_inbound.tbl_receiving rec on ri.IBN = rec.IBN
                                    WHERE ri.ItemID = $ItemID AND ri.CustomerID = $CustomerID
                                    AND ExpiryDate = '$Co_SubFilter'
                                    GROUP BY rec.Container";
            }
        }

        else if($SubFilter == 4)
        {
            if($Co_SubFilter == 'all')
            {
                $query_breakdown .= "GROUP BY rec.Container";
            }

            else if($Co_SubFilter == 'no_or')
            {
                $query_breakdown .= "AND (OtherReference IS NULL OR OtherReference = '')
               GROUP BY rec.Container";
            }

            else
            {
                $query_breakdown .= "AND ReceivingID = '$Co_SubFilter'
                GROUP BY rec.Container";
            }
        }
        

            $result = mysqli_query($conn, $query_breakdown);

            while($rows = mysqli_fetch_array($result))
            {
                $qty = $rows[0] - $rows[2];
                $wgt = $rows[1] - $rows[3];
                $total_qty = $qty + $total_qty;
                $total_wgt = $wgt + $total_wgt;

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
                         <td style="border:1px solid black; font-weight:bold">'.$qty.'</td>
                         <td style="border:1px solid black; font-weight:bold">'.number_format((float)$wgt, 2).'</td>
                         <td style="border:1px solid black;">'.$rows[4].'</td>
                         <td style="border:1px solid black;">'.$rows[5].'</td>
                         <td style="border:1px solid black;">'.$rows[6].'</td>
                         <td style="border:1px solid black;"></td>
                         <td style="border:1px solid black;"></td>
                    </tr>

                ';
                }

                
            }
    }
    else
    {   

        $qty = 0;
        $wgt = 0;
        $total_qty = 0;
        $total_wgt = 0;
       
           $query_breakdown = "SELECT
                                SUM(ri.Beg_Quantity),
                                SUM(ri.Beg_Weight),
                                
                                
                                (SELECT SUM(ri.Beg_Quantity) 
                                FROM wms_inbound.tbl_receivingitems ri
                                LEFT JOIN wms_inbound.tbl_receiving reci on ri.IBN = reci.IBN
                                WHERE ri.ItemID = $ItemID AND ri.CustomerID = $CustomerID
                                AND reci.ReceivingDate BETWEEN '2000-01-01T07:07' AND '$datefrom'
                                AND reci.Container = rec.Container
                                GROUP BY ri.ItemID) AS Begin_Qty,

                                (SELECT SUM(ri.Beg_Weight) 
                                FROM wms_inbound.tbl_receivingitems ri
                                LEFT JOIN wms_inbound.tbl_receiving reci on ri.IBN = reci.IBN
                                WHERE ri.ItemID = $ItemID AND ri.CustomerID = $CustomerID
                                AND reci.ReceivingDate BETWEEN '2000-01-01T07:07' AND '$datefrom'
                                AND reci.Container = rec.Container
                                GROUP BY ri.ItemID) AS Begin_Wgt,
                                
                                
                                (SELECT IFNULL(SUM(Quantity), 0)
                                    FROM wms_outbound.tbl_view_gm_outbound_report gm
                                    WHERE ItemID = $ItemID AND CustomerID = $CustomerID
                                    AND rec.Container = gm.Container
                                    AND IssuanceDate BETWEEN '$datefrom' AND '$dateto') AS Quantity_Out,
                                    
                                    
                                (SELECT IFNULL(SUM(Weight), 0)
                                    FROM wms_outbound.tbl_view_gm_outbound_report gm
                                    WHERE ItemID = $ItemID AND CustomerID = $CustomerID
                                    AND rec.Container = gm.Container
                                    AND IssuanceDate BETWEEN '$datefrom' AND '$dateto') AS Weight_Out,
                                    
                                Container,
                                Batch,
                                OtherReference
                            FROM wms_inbound.tbl_receivingitems ri
                            LEFT JOIN wms_inbound.tbl_receiving rec on ri.IBN = rec.IBN
                            WHERE ri.ItemID = $ItemID AND ri.CustomerID = $CustomerID
                            -- AND rec.ReceivingDate BETWEEN '$datefrom' AND '$dateto'
                            ";

        if($SubFilter == null || $SubFilter == '')
        {
            $query_breakdown .= "GROUP BY rec.Container";
        }
        else if($SubFilter == 1)
        {
            if($Co_SubFilter == 'all')
            {
                $query_breakdown .= "GROUP BY rec.Container";
            }
            else
            {
                $query_breakdown .= "AND Container = '$Co_SubFilter'
                GROUP BY rec.Container";
            }
        }

        else if($SubFilter == 2)
        {
            if($Co_SubFilter == 'all')
            {
                $query_breakdown .= "GROUP BY rec.Container";
            }
            else
            {
                $query_breakdown .= "AND Batch = '$Co_SubFilter'
                GROUP BY rec.Container";
            }
        }

        else if($SubFilter == 3)
        {   
            if($Co_SubFilter == 'all')
            {
                $query_breakdown .= "GROUP BY rec.Container";
            }
            else
            {
                $query_breakdown = "SELECT
                                    SUM(ri.Beg_Quantity),
                                    SUM(ri.Beg_Weight),
                                    
                                    
                                    (SELECT SUM(ri.Beg_Quantity) 
                                    FROM wms_inbound.tbl_receivingitems ri
                                    LEFT JOIN wms_inbound.tbl_receiving reci on ri.IBN = reci.IBN
                                    WHERE ri.ItemID = $ItemID AND ri.CustomerID = $CustomerID
                                    AND reci.ReceivingDate BETWEEN '2000-01-01T07:07' AND '$datefrom'
                                    AND reci.Container = rec.Container AND ExpiryDate = '$Co_SubFilter'
                                    GROUP BY ri.ItemID) AS Begin_Qty,

                                    (SELECT SUM(ri.Beg_Weight) 
                                    FROM wms_inbound.tbl_receivingitems ri
                                    LEFT JOIN wms_inbound.tbl_receiving reci on ri.IBN = reci.IBN
                                    WHERE ri.ItemID = $ItemID AND ri.CustomerID = $CustomerID
                                    AND reci.ReceivingDate BETWEEN '2000-01-01T07:07' AND '$datefrom'
                                    AND reci.Container = rec.Container AND ExpiryDate = '$Co_SubFilter'
                                    GROUP BY ri.ItemID) AS Begin_Wgt,
                                    
                                    
                                    (SELECT IFNULL(SUM(Quantity), 0)
                                        FROM wms_outbound.tbl_view_gm_outbound_report gm
                                        WHERE ItemID = $ItemID AND CustomerID = $CustomerID
                                        AND rec.Container = gm.Container
                                        AND IssuanceDate BETWEEN '$datefrom' AND '$dateto'
                                        AND AllocatedExpiry = '$Co_SubFilter') AS Quantity_Out,
                                        
                                        
                                    (SELECT IFNULL(SUM(Weight), 0)
                                        FROM wms_outbound.tbl_view_gm_outbound_report gm
                                        WHERE ItemID = $ItemID AND CustomerID = $CustomerID
                                        AND rec.Container = gm.Container
                                        AND IssuanceDate BETWEEN '$datefrom' AND '$dateto'
                                        AND AllocatedExpiry = '$Co_SubFilter') AS Weight_Out,
                                        
                                    Container,
                                    Batch,
                                    OtherReference
                                FROM wms_inbound.tbl_receivingitems ri
                                LEFT JOIN wms_inbound.tbl_receiving rec on ri.IBN = rec.IBN
                                WHERE ri.ItemID = $ItemID AND ri.CustomerID = $CustomerID
                                AND ExpiryDate = '$Co_SubFilter'
                                GROUP BY rec.Container";
            }
        }

        else if($SubFilter == 4)
        {
            if($Co_SubFilter == 'all')
            {
                $query_breakdown .= "GROUP BY rec.Container";
            }

            else if($Co_SubFilter == 'no_or')
            {
                $query_breakdown .= "AND (OtherReference IS NULL OR OtherReference = '')
               GROUP BY rec.Container";
            }

            else
            {
                $query_breakdown .= "AND ReceivingID = '$Co_SubFilter'
                GROUP BY rec.Container";
            }
        }

            $result = mysqli_query($conn, $query_breakdown);

            while($rows = mysqli_fetch_array($result))
            {
                if($rows[2] == null || $rows[2] == ''){
                    $qty = $rows[0] - $rows[4];
                    $wgt = $rows[1] - $rows[5];
                    $total_qty = $qty + $total_qty;
                    $total_wgt = $wgt + $total_wgt;
                    
                }
                else{
                    $qty = $rows[2] - $rows[4];
                    $wgt = $rows[3] - $rows[5];
                    $total_qty = $qty + $total_qty;
                    $total_wgt = $wgt + $total_wgt;
                    
                }

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
                         <td style="border:1px solid black; font-weight:bold">'.$qty.'</td>
                         <td style="border:1px solid black; font-weight:bold">'.number_format((float)$wgt, 2).'</td>
                         <td style="border:1px solid black;">'.$rows[6].'</td>
                         <td style="border:1px solid black;">'.$rows[7].'</td>
                         <td style="border:1px solid black;">'.$rows[8].'</td>
                         <td style="border:1px solid black;"></td>
                         <td style="border:1px solid black;"></td>
                    </tr>

                ';
                }
            }

    }

             echo '

                <tr>
                     <td style="border:1px solid black;"></td>
                     <td style="border:1px solid black;"></td>
                     <td style="border:1px solid black; font-weight:bold">Total</td>
                     <td style="border:1px solid black; font-weight:bold;color:red;">'.$total_qty.'</td>
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
        <option value="1">Container</option>
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


// Reports











// Receiving module
    function CPGenerateIBN()
    {
        include 'dbcon.php';
        
        $query = "SELECT TempIBN FROM wms_inbound.tbl_temp LIMIT 1";
        
        $TempIBN = 0;
        $NewTempIBN = 0;
        
        $IBN = "";
        
        $result = mysqli_query($conn, $query);
        while($rows = mysqli_fetch_row($result))
        {
            //get total tempibn
            $TempIBN = $rows[0];
            //add 1 to total tempibn
            $NewTempIBN = $TempIBN + 1;
            
            $IBN = "";
            
            $userid = $_SESSION['CustomerId'];
            // update the total num of temp IBN 
            $query = "UPDATE wms_inbound.tbl_temp SET TempIBN=$NewTempIBN";
            if(mysqli_query($conn, $query))
            {
                //get user email 
                $query = "SELECT CustomerEmail FROM wms_cloud.tbl_customers WHERE CustomerID = '$userid'";
                $result = mysqli_query($conn, $query);
                if(mysqli_num_rows($result) == 1)
                {
                    while($row = mysqli_fetch_assoc($result))
                    {
                        $createdby = $row['CustomerEmail'];
                    }
                }
                
                $IBN = "IBN".sprintf('%09d', $TempIBN);
                $query = "INSERT INTO wms_inbound.tbl_receiving (`IBN`, `StatusID`, `CusID`, `CreatedBy`, `LastUpdatedBy`,`FromCP`, `CPStatus_id`) VALUES ('$IBN',0, '$userid', '$createdby', '$createdby', 'True', 0)";
                
                if(mysqli_query($conn, $query))
                {
                    echo $IBN;
                }
                else
                {
                    echo "Erro: " . $query . "<br>" . mysqli_error($conn);
                }  
            }
            else
            {
                echo "Error: " . $query . "<br>" . mysqli_error($conn);
            }
        }
    }

    function Warehouses()
    {
        include 'dbcon.php';
        
//        SELECT
//        DISTINCT(cus.WarehouseID), wh.Warehouse
//        FROM wms_cloud.tbl_customers AS cus
//        LEFT JOIN wms_cloud.tbl_Warehouses AS wh ON cus.WarehouseID = wh.WarehouseID
//        WHERE cus.CustomerCommonCode = "NES0168"
        $query = "SELECT * FROM wms_cloud.tbl_Warehouses";
        $result = mysqli_query($conn, $query);
        while($rows = mysqli_fetch_array($result))
        {
            echo '<option value="'.$rows[0].'">'.$rows[1].'</option>';
        }
    }

    function TruckType()
    {
        include 'dbcon.php';

        $query = "SELECT * FROM wms_cloud.tbl_trucktypes";
        $result = mysqli_query($conn, $query);
        while($rows = mysqli_fetch_array($result))
        {
            echo '<option value="'.$rows[0].'">'.$rows[1].'</option>';
        }

    }

   function SubmitASN($ibn_no, $selected_warehouse, $supplier_name ,$container_no, $vehicle_plateno, $seal_no, $client_rep, $date_arrival, $selected_truck)
   {
       include 'dbcon.php';
       
       $query = "UPDATE wms_inbound.tbl_receiving SET ReceivingDate = '$date_arrival', Container = '$container_no', VehiclePlate = '$vehicle_plateno', Seal = '$seal_no', Supplier = '$supplier_name', RequestedBy = '$client_rep', Warehouse_id = '$selected_warehouse', CPStatus_id = 2, TruckType = '$selected_truck' WHERE IBN = '$ibn_no'";
       if(mysqli_query($conn, $query))
       {
           echo "Save Successfully!";
       }
       else
       {
           echo "Error: " . $query . "<br>" . mysqli_error($conn);
       }
   }

   function ReturnToPending($ibn_no, $selected_warehouse, $supplier_name ,$container_no, $vehicle_plateno, $seal_no, $client_rep, $date_arrival)
   {
       include 'dbcon.php';
       $userid = $_SESSION['CustomerId'];
       $query = "SELECT CustomerEmail FROM wms_cloud.tbl_customers WHERE CustomerID = '$userid'";
       $result = mysqli_query($conn, $query);
       if(mysqli_num_rows($result) == 1)
       {
            while($row = mysqli_fetch_assoc($result))
            {
                $createdby = $row['CustomerEmail'];
            }

            $query = "UPDATE wms_inbound.tbl_receiving SET ReceivingDate = '$date_arrival', Container = '$container_no', VehiclePlate = '$vehicle_plateno', Seal = '$seal_no', Supplier = '$supplier_name', RequestedBy = '$client_rep', Warehouse_id = '$selected_warehouse', LastUpdatedBy = '$createdby', CPStatus_id = 1 WHERE IBN = '$ibn_no'";
            if(mysqli_query($conn, $query))
            {
                echo "Receiving Moved to Pending";
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

   function GetPendingList()
   {
       include 'dbcon.php';

       $userID = $_SESSION['CustomerId']; 

       $query = "SELECT IBN, CompanyName, CreatedBy, LastUpdatedBy FROM wms_inbound.tbl_receiving LEFT JOIN wms_cloud.tbl_customers on wms_inbound.tbl_receiving.CusID = wms_cloud.tbl_customers.CustomerID  WHERE CPStatus_id = 1";
            
            $result = mysqli_query($conn, $query);
            while ($rows = mysqli_fetch_row($result))
            {
                echo '
                    <tr>
                        <td>'.$rows[0].'</td>
                        <td>'.$rows[1].'</td>
                        <td>'.$rows[2].'</td>
                        <td>'.$rows[3].'</td>
                        <td><button class="btn btn-primary btn-sm" data-dismiss="modal" onclick="asndetails(\''.$rows[0].'\')">Open</button></td>
                    </tr>
                ';
            }
   }
   function GetOpenIBNList()
   {
       include 'dbcon.php';
       $userID = $_SESSION['CustomerId'];
       
       $query = "SELECT IBN, CompanyName, CreatedBy FROM wms_inbound.tbl_receiving LEFT JOIN wms_cloud.tbl_customers on wms_inbound.tbl_receiving.CusID = wms_cloud.tbl_customers.CustomerID  WHERE CPStatus_id = 0";
       $result = mysqli_query($conn, $query);
       while($rows = mysqli_fetch_row($result))
       {
            echo '
                <tr>
                    <td>'.$rows[0].'</td>
                    <td>'.$rows[1].'</td>
                    <td>'.$rows[2].'</td>
                    <td></td>
                    <td><button class="btn btn-primary" data-dismiss="modal" onclick="asndetails(\''.$rows[0].'\')">Open</button></td>
                </tr>
            ';
       }
    }

    function GetOnProcessList()
    {
        include 'dbcon.php';

        $userID = $_SESSION['CustomerId'];
        $query = "SELECT CustomerEmail FROM wms_cloud.tbl_customers WHERE CustomerID = '$userID'";
        $result = mysqli_query($conn, $query);
        if(mysqli_num_rows($result) == 1)
        {
            while($row = mysqli_fetch_array($result))
            {
                $useremail = $row[0];
            }

            $query = "SELECT IBN, CompanyName, CreatedBy, LastUpdatedBy FROM wms_inbound.tbl_receiving LEFT JOIN wms_cloud.tbl_customers on wms_inbound.tbl_receiving.CusID = wms_cloud.tbl_customers.CustomerID  WHERE CPStatus_id = 2";
            $result = mysqli_query($conn, $query);
            
            while($rows = mysqli_fetch_array($result))
            {
                if($rows[3] == $useremail)
                {
                    echo '
                        <tr>
                            <td>'.$rows[0].'</td>
                            <td>'.$rows[1].'</td>
                            <td>'.$rows[2].'</td>
                            <td>'.$rows[3].'</td>
                            <td><button class="btn btn-primary" data-dismiss="modal" onclick="asndetails(\''.$rows[0].'\')">Open</button></td>
                        </tr>
                    ';
                }
                else
                {
                    echo '
                        <tr>
                            <td>'.$rows[0].'</td>
                            <td>'.$rows[1].'</td>
                            <td>'.$rows[2].'</td>
                            <td>'.$rows[3].'</td>
                            <td><button class="btn btn-primary" data-dismiss="modal" onclick="asndetails(\''.$rows[0].'\')" disabled>Open</button></td>
                        </tr>
                    ';
                }
            }
        }
        else
        {
            echo "Error: " . $query . "<br>" . mysqli_error($conn);
        }
    }

    function GetOpenCount()
    {
        include 'dbcon.php';

        $query = "SELECT COUNT(*) FROM wms_inbound.tbl_receiving WHERE CPStatus_id = 0";
        $result = mysqli_query($conn, $query);
        while ($rows = mysqli_fetch_array($result))
        {
            echo $rows[0];
        }
    }

    function GetPendingCount()
    {
        include 'dbcon.php';

        $query = "SELECT COUNT(*) FROM wms_inbound.tbl_receiving WHERE CPStatus_id = 1";
        $result = mysqli_query($conn, $query);
        while ($rows = mysqli_fetch_array($result))
        {
            echo $rows[0];
        }
    }

    function GetOnProcessCount()
    {
        include 'dbcon.php';

        $query = "SELECT COUNT(*) FROM wms_inbound.tbl_receiving WHERE CPStatus_id = 2";
        $result = mysqli_query($conn, $query);
        while ($rows = mysqli_fetch_array($result))
        {
            echo $rows[0];
        }
    }

    function GetASNDetails($IBN)
    {
        include 'dbcon.php';

        $userID = $_SESSION['CustomerId'];
        $query = "SELECT CustomerEmail FROM wms_cloud.tbl_customers WHERE CustomerID = '$userID'";
        $result = mysqli_query($conn, $query);
        if(mysqli_num_rows($result) == 1)
        {
            while($row = mysqli_fetch_array($result))
            {
                $useremail = $row[0];
            }

            $query = "UPDATE wms_inbound.tbl_receiving SET CPStatus_id = 2, LastUpdatedBy = '$useremail' WHERE IBN = '$IBN'";
            if(mysqli_query($conn, $query))
            {
                $query = "SELECT IBN, Warehouse_id, Supplier, Container, VehiclePlate, Seal, RequestedBy, ReceivingDate, CusID FROM wms_inbound.tbl_receiving WHERE FromCP = 'True' AND IBN = '$IBN' LIMIT 1";
                $result = mysqli_query($conn, $query);
                while($rows = mysqli_fetch_array($result))
                {
                    $arr[] = array(
                        'IBN'=>$rows[0],
                        'Warehouse_id'=>$rows[1],
                        'Supplier'=>$rows[2],
                        'Container'=>$rows[3],
                        'VehiclePlace'=>$rows[4],
                        'Seal'=>$rows[5],
                        'RequestedBy'=>$rows[6],
                        'ReceivingDate'=>$rows[7],
                        'CusID'=>$rows[8]
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
        else
        {
            echo "Error: " . $query . "<br>" . mysqli_error($conn);
        }

    }

   function AvailableItems($storagetype)
   {
       include 'dbcon.php';

       $userid = $_SESSION['CustomerId'];

       if($storagetype == '1')
       {
            $query = "SELECT ItemID, ItemDesc, ItemCode, Client_SKU FROM tbl_items WHERE ItemCustomerID = '$userid'  AND Weight >= 1 AND Status = 'Active'";
            $result = mysqli_query($conn, $query);
            while($rows = mysqli_fetch_array($result))
            {
                echo '<option value="'.$rows[0].'">'.$rows[1].' ('.$rows[2].'-'.$rows[3].')</option>';
            }
       }
       else
       {
            $query = "SELECT ItemID, ItemDesc, ItemCode, Client_SKU FROM tbl_items WHERE ItemCustomerID = '$userid'  AND Weight = 0 AND Status = 'Active'";
            $result = mysqli_query($conn, $query);
            while($rows = mysqli_fetch_array($result))
            {
                echo '<option value="'.$rows[0].'">'.$rows[1].' ('.$rows[2].'-'.$rows[3].')</option>';
            }
       }

    
       
    }

    function GetUOM($ItemID)
    {
        include 'dbcon.php';

        $query = "SELECT uom.UOMID, uom.UOM_Abv FROM tbl_weightuom uom LEFT JOIN tbl_items items ON uom.UOMID = items.UOMID WHERE ItemID = '$ItemID'";
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
            echo "Error: " . $query . "<br>" . mysqli_error($conn);
        }
    }

    function GetWeight($storagType, $selected_item)
    {
        include 'dbcon.php';

        $query = "SELECT ItemID, Weight
        FROM wms_cloud.tbl_items
        WHERE Weight >= 1 
        AND ItemID = '$selected_item'";
        $result = mysqli_query($conn, $query);
        while($row = mysqli_fetch_array($result))
        {
            echo $row[1];
        }
    }

    function AddReceivingItems($r_ibn, $r_item, $r_itemqty, $storagType, $r_itemexpirydate, $r_itemuom, $r_weight)
    {
        include 'dbcon.php';

        $userID = $_SESSION['CustomerId'];

        $query = "SELECT Weight FROM wms_cloud.tbl_items WHERE ItemID = $r_item";
        $result = mysqli_query($conn, $query);
        while($row = mysqli_fetch_array($result))
        {
            $Weight = $row[0];
        }
        if($storagType == '1')
        {
            $beg_weight = $Weight * $r_itemqty;

            $query = "INSERT INTO wms_inbound.tbl_receivingitemsummary (`IBN`, `ItemID`, `Beg_Quantity`, `Beg_Weight`,`Quantity`, `Weight`, `StorageType`, `ExpiryDate`) VALUES ('$r_ibn', '$r_item', '$r_itemqty', '$beg_weight', '$r_itemqty', '$beg_weight','$storagType', '$r_itemexpirydate')";
            if(mysqli_query($conn, $query))
            {
                echo $r_ibn;
            }
            else
            {
                echo "Error: " . $query . "<br>" . mysqli_error($conn);
            }
        }
        if($storagType == '2')
        {
            if(($r_weight != '') || ($r_weight != null))
            {
                $query = "INSERT INTO wms_inbound.tbl_receivingitemsummary (`IBN`, `ItemID`, `Beg_Quantity`, `Beg_Weight`,`Quantity`, `Weight`, `StorageType`, `ExpiryDate`) VALUES ('$r_ibn', '$r_item', '$r_itemqty', '$r_weight', '$r_itemqty', '$r_weight','$storagType', '$r_itemexpirydate')";
                if(mysqli_query($conn, $query))
                {
                    echo $r_ibn;
                }
                else
                {
                    echo "Error: " . $query . "<br>" . mysqli_error($conn);
                }
            }
            else
            {
                $query = "INSERT INTO wms_inbound.tbl_receivingitemsummary (`IBN`, `ItemID`, `Beg_Quantity`, `Beg_Weight`,`Quantity`, `Weight`, `StorageType`, `ExpiryDate`) VALUES ('$r_ibn', '$r_item', '$r_itemqty', '$r_itemqty', '$r_itemqty', '$r_itemqty','$storagType', '$r_itemexpirydate')";
                if(mysqli_query($conn, $query))
                {
                    echo $r_ibn;
                }
                else
                {
                    echo "Error: " . $query . "<br>" . mysqli_error($conn);
                }
            }
        }        
    }

    function AddedItemsSummary($IBN)
    {
        include 'dbcon.php';

        $query = "SELECT ris.ReceivingItemSummaryID, ris.IBN, i.ItemID, i.ItemDesc, i.ItemCode, i.Client_SKU, uom.UOM_Abv, ris.Quantity, ris.StorageType, ris.ExpiryDate, ris.beg_Weight FROM wms_inbound.tbl_receivingitemsummary ris
        LEFT JOIN wms_cloud.tbl_items i ON ris.ItemID = i.ItemID
        LEFT JOIN wms_cloud.tbl_weightuom uom ON i.UOMID = uom.UOMID 
        WHERE ris.IBN = '$IBN'";
        $result = mysqli_query($conn, $query);
        $no = 1;

        while($rows = mysqli_fetch_array($result))
        {
            $arr[] = array(
                'id' =>$rows[0],
                'items'=>$rows[3].'('.$rows[4].' - '.$rows[5].')',
                'uom'=>$rows[6],
                'quantity'=>$rows[7],
                'expiry_date'=>$rows[9],
                'totalweight'=>$rows[10],
                'action'=>'<div class="btn-group d-flex justify-content-center">
                        <button class="border-0 shadow-0" style="background-color: transparent" onclick="modalremoveconfirmation('.$rows[0].')"><i class="far fa-trash-alt"></i></button>
                        <button class="border-0 shadow-0" style="background-color: transparent" onclick="getitemdetailscanedit('.$rows[0].')"><i class="far fa-edit"></i></button>
                      </div>'
            );

            // echo 
            //     '<tr>
            //         <th>'.$no.'</th>
            //         <td>'.$rows[3].'('.$rows[4].' - '.$rows[5].')</td>
            //         <td>'.$rows[6].'</td>
            //         <td id="qty">'.$rows[7].'</td>
            //         <td>'.$rows[9].'</td>
            //         <td><div class="btn-group d-flex justify-content-center">
            //         <button class="border-0 shadow-0" style="background-color: transparent" onclick="modalremoveconfirmation('.$rows[0].')"><i class="far fa-trash-alt"></i></button>
            //         <button class="border-0 shadow-0" style="background-color: transparent" onclick="getitemdetailscanedit('.$rows[0].')"><i class="far fa-edit"></i></button>
            //       </div></td>
            //     </tr>';
            // $no++;
        }
        echo json_encode($arr);
        exit();
            
    }

    function GetItemDetailsCanEdit($id)
    {
        include 'dbcon.php';

        $query = "SELECT * FROM wms_inbound.tbl_receivingitemsummary WHERE ReceivingItemSummaryID = '$id'";
        $result = mysqli_query($conn, $query);

        while( $row = mysqli_fetch_array($result))
        {
            $arr[] = array(
                'quantity' => $row[5],
                'expiry_date' => $row[8]
            );
        }

        echo json_encode($arr);
        exit();
    }

    function EditItemDetails($itemid, $qty, $expiry)
    {
        include 'dbcon.php';

        $query = "UPDATE wms_inbound.tbl_receivingitemsummary SET Quantity = '$qty', ExpiryDate = '$expiry' WHERE ReceivingItemSummaryID = '$itemid'";

        if(mysqli_query($conn, $query))
        {
            echo 'Edit Success!';
        }
        else
        {
            echo "Error: " . $query . "<br>" . mysqli_error($conn);
        }
    }

    function removeItem($id)
    {
        include 'dbcon.php';

        $query = "DELETE FROM wms_inbound.tbl_receivingitemsummary WHERE ReceivingItemSummaryID = '$id'";

        if(mysqli_query($conn, $query))
        {
            echo 'Remove Success';
        }
        else
        {
            echo "Error: " . $query . "<br>" . mysqli_error($conn);
        }
    }

    function SubmitCompleteASN($IBN)
    {
        include 'dbcon.php';

        $query = "UPDATE wms_inbound.tbl_receiving SET CPStatus_id = 3, StatusID = 1 WHERE IBN = '$IBN'";
        if(mysqli_query($conn, $query))
        {
            echo 'Inbound Submitted';
        }
        else
        {
            echo "Error: " . $query . "<br>" . mysqli_error($conn);
        }

    }

    