<?php
    session_start();
    ini_set('max_execution_time', '300');
    set_time_limit(300);
    date_default_timezone_set('Asia/Manila');
    $function = $_POST['function'];
    $CustomerID = $_SESSION['CustomerId'];

    if($function == 'loadPieChartByDropdown')
    {   
        $dataBarGraph = $_POST['dataBarGraph'];
        $to = $_POST['to'];
        $from = $_POST['from'];
        $filter = $_POST['filter'];
        $searchkey = $_POST['searchkey'];
        $date = date('Y-m-d');
        $sub = date('Y-m-d', strtotime('-29 day', strtotime($date)));

        if($to == $date && $from == $sub)
        {
            $from = '1970-01-01';
            $to = '2040-01-01';
        }

        loadPieChartByDropdown($dataBarGraph, $CustomerID, $to, $from, $filter, $searchkey);
    }

    function loadPieChartByDropdown($dataBarGraph, $CustomerID, $to, $from, $filter, $searchkey)
    {
        include 'dbcon.php';
        $lessTwo = date('Y-m-d', strtotime('+2 months'));
        $lessFour = date('Y-m-d', strtotime('+4 months'));
        $lessSix = date('Y-m-d', strtotime('+6 months'));

        $expired = 0;
        $lTwo = 0;
        $lFour = 0;
        $lSix = 0;
        $mSix = 0;

        $date = date('Y-m-d');
        if($dataBarGraph == 'Total SO')
        {
            $query = "SELECT
                        ExpiryDate,
                        COUNT(Client_SKU)
                        FROM wms_inbound.tbl_receivingitems
                        LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
                        LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                        ";

              if($searchkey == null && $searchkey == '' && $searchkey == 0)
              {
                 $query .= "WHERE CusID = $CustomerID AND ExpiryDate BETWEEN '$from' AND '$to'
              GROUP BY ExpiryDate";
              }
              else if(!empty($searchkey))
              {
                $query .= "WHERE CusID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND  ExpiryDate BETWEEN '$from' AND '$to'
              GROUP BY ExpiryDate";
              }

              $res = mysqli_query($conn, $query);

              while($rows = mysqli_fetch_array($res))
              {
                   if($rows[0] <= $date)
                   {
                     $expired += $rows[1];
                   }
                   else if($rows[0] > $date && $rows[0] <= $lessTwo)
                   {
                     $lTwo += $rows[1];
                   }
                   else if($rows[0] > $date && $rows[0] <= $lessFour)
                   {
                     $lFour += $rows[1];
                   }
                   else if($rows[0] > $date && $rows[0] <= $lessSix)
                   {
                     $lSix += $rows[1];
                   }
                   else if($rows[0] > $lessSix)
                   {
                     $mSix += $rows[1];
                   }
             }

            $data[] = array($expired, $lTwo, $lFour, $lSix, $mSix);

            echo json_encode($data);
        }
        else if($dataBarGraph == 'Total Quantity')
        {
            $query = "SELECT
                        ExpiryDate,
                        SUM(wms_inbound.tbl_receivingitems.Quantity)
                        FROM wms_inbound.tbl_receivingitems
                        LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
                        LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                        ";

              if($searchkey == null && $searchkey == '' && $searchkey == 0)
              {
                 $query .= "WHERE CusID = $CustomerID AND ExpiryDate BETWEEN '$from' AND '$to'
              GROUP BY ExpiryDate";
              }
              else if(!empty($searchkey))
              {
                $query .= "WHERE CusID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND  ExpiryDate BETWEEN '$from' AND '$to'
              GROUP BY ExpiryDate";
              }

              $res = mysqli_query($conn, $query);

              while($rows = mysqli_fetch_array($res))
              {
                   if($rows[0] <= $date)
                   {
                     $expired += $rows[1];
                   }
                   else if($rows[0] > $date && $rows[0] <= $lessTwo)
                   {
                     $lTwo += $rows[1];
                   }
                   else if($rows[0] > $date && $rows[0] <= $lessFour)
                   {
                     $lFour += $rows[1];
                   }
                   else if($rows[0] > $date && $rows[0] <= $lessSix)
                   {
                     $lSix += $rows[1];
                   }
                   else if($rows[0] > $lessSix)
                   {
                     $mSix += $rows[1];
                   }
             }

            $data[] = array($expired, $lTwo, $lFour, $lSix, $mSix);

            echo json_encode($data);

        }
        else if($dataBarGraph == 'Total Weight')
        {
            $query = "SELECT
                        ExpiryDate,
                        SUM(wms_inbound.tbl_receivingitems.Weight)
                        FROM wms_inbound.tbl_receivingitems
                        LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
                        LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                        ";

              if($searchkey == null && $searchkey == '' && $searchkey == 0)
              {
                 $query .= "WHERE CusID = $CustomerID AND ExpiryDate BETWEEN '$from' AND '$to'
              GROUP BY ExpiryDate";
              }
              else if(!empty($searchkey))
              {
                $query .= "WHERE CusID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND  ExpiryDate BETWEEN '$from' AND '$to'
              GROUP BY ExpiryDate";
              }

              $res = mysqli_query($conn, $query);

              while($rows = mysqli_fetch_array($res))
              {     

                   if($rows[0] <= $date)
                   {
                     $expired += $rows[1];
                   }
                   else if($rows[0] > $date && $rows[0] <= $lessTwo)
                   {
                     $lTwo += $rows[1];
                   }
                   else if($rows[0] > $date && $rows[0] <= $lessFour)
                   {
                     $lFour += $rows[1];
                   }
                   else if($rows[0] > $date && $rows[0] <= $lessSix)
                   {
                     $lSix += $rows[1];
                   }
                   else if($rows[0] > $lessSix)
                   {
                     $mSix += $rows[1];
                   }


             }

            $data[] = array($expired, $lTwo, $lFour, $lSix, $mSix);

            echo json_encode($data);

        }
        
    }