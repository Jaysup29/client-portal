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
        
        $lessThree = date('Y-m-d', strtotime('+3 months'));
        $lessSix = date('Y-m-d', strtotime('+6 months'));

        $expired = 0;
        $lThree = 0;
        $lSix = 0;
        $mSix = 0;
        $noexpiry = 0;

        $date = date('Y-m-d');
        if($dataBarGraph == 'Total Quantity' || $dataBarGraph == 'Total SO')
        {
            $query = "SELECT
                        LEFT(ExpiryDate, 10),
                        SUM(wms_inbound.tbl_receivingitems.Quantity)
                        FROM wms_inbound.tbl_receivingitems
                        LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
                        LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                        ";

              if(empty($searchkey))
              {
                 $query .= "WHERE CustomerID = $CustomerID AND LEFT(ExpiryDate, 10) BETWEEN '$from' AND '$to' AND wms_inbound.tbl_receiving.StatusID = 3
              GROUP BY ExpiryDate";
              }
              else
              {
                $query .= "WHERE CustomerID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND  LEFT(ExpiryDate, 10) BETWEEN '$from' AND '$to' AND wms_inbound.tbl_receiving.StatusID = 3
              GROUP BY ExpiryDate";
              }

              $res = mysqli_query($conn, $query);

              while($rows = mysqli_fetch_array($res))
              {
                   if($rows[0] <= $date)
                   {
                     $expired += $rows[1];
                   }
                   else if($rows[0] > $date && $rows[0] <= $lessThree)
                   {
                     $lThree += $rows[1];
                   }
                   else if($rows[0] > $lessThree && $rows[0] <= $lessSix)
                   {
                     $lSix += $rows[1];
                   }
                   else if($rows[0] > $lessSix)
                   {
                     $mSix += $rows[1];
                   }
             }
             
            //  echo $query;
             $query = "SELECT
                        LEFT(ExpiryDate, 10),
                        SUM(wms_inbound.tbl_receivingitems.Quantity)
                        FROM wms_inbound.tbl_receivingitems
                        LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
                        LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                        ";

              if(empty($searchkey))
              {
                $query .= "WHERE CustomerID = $CustomerID AND (ExpiryDate IS NULL OR LEFT(ExpiryDate, 10) = '0000-00-00') AND wms_inbound.tbl_receiving.StatusID = 3
              GROUP BY ExpiryDate";
              }
              else
              {
                $query .= "WHERE CustomerID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND (ExpiryDate IS NULL OR LEFT(ExpiryDate, 10) = '0000-00-00') AND wms_inbound.tbl_receiving.StatusID = 3
              GROUP BY ExpiryDate";
              }

              $res = mysqli_query($conn, $query);
              while($rows = mysqli_fetch_array($res))
              {
                $noexpiry += $rows[1];
              }

            // $lSix = $lThree + $lSix;
            $data[] = array($expired, $lThree, $lSix, $mSix, $noexpiry);

            echo json_encode($data);

        }
        else if($dataBarGraph == 'Total Weight')
        {
            $query = "SELECT
                        LEFT(ExpiryDate, 10),
                        SUM(wms_inbound.tbl_receivingitems.Weight)
                        FROM wms_inbound.tbl_receivingitems
                        LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
                        LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                        ";

            if(empty($searchkey))
            {
              $query .= "WHERE CustomerID = $CustomerID AND LEFT(ExpiryDate, 10) BETWEEN '$from' AND '$to' AND wms_inbound.tbl_receiving.StatusID = 3
            GROUP BY ExpiryDate";
            }
            else
            {
              $query .= "WHERE CustomerID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND  LEFT(ExpiryDate, 10) BETWEEN '$from' AND '$to' AND wms_inbound.tbl_receiving.StatusID = 3
            GROUP BY ExpiryDate";
            }

              $res = mysqli_query($conn, $query);

              while($rows = mysqli_fetch_array($res))
              {
                  if($rows[0] <= $date)
                  {
                    $expired += $rows[1];
                  }
                  else if($rows[0] > $date && $rows[0] <= $lessThree)
                  {
                    $lThree += $rows[1];
                  }
                  else if($rows[0] > $lessThree && $rows[0] <= $lessSix)
                  {
                    $lSix += $rows[1];
                  }
                  else if($rows[0] > $lessSix)
                  {
                    $mSix += $rows[1];
                  }
             }
            

             $query = "SELECT
                        LEFT(ExpiryDate, 10),
                        SUM(wms_inbound.tbl_receivingitems.Weight)
                        FROM wms_inbound.tbl_receivingitems
                        LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
                        LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                        ";

              if(empty($searchkey))
              {
                $query .= "WHERE CustomerID = $CustomerID AND (ExpiryDate IS NULL OR LEFT(ExpiryDate, 10) = '0000-00-00') AND wms_inbound.tbl_receiving.StatusID = 3
              GROUP BY ExpiryDate";
              }
              else
              {
                $query .= "WHERE CustomerID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND (ExpiryDate IS NULL OR LEFT(ExpiryDate, 10) = '0000-00-00') AND wms_inbound.tbl_receiving.StatusID = 3
              GROUP BY ExpiryDate";
              }

              $res = mysqli_query($conn, $query);
              while($rows = mysqli_fetch_array($res))
              {
                $noexpiry += $rows[1];
              }

            
            $data[] = array($expired, $lThree, $lSix, $mSix, $noexpiry);

            echo json_encode($data);

            
        }
        
    }