<?php
    session_start();
    ini_set('max_execution_time', '300');
    set_time_limit(300);
    date_default_timezone_set('Asia/Manila');
    $function = $_POST['function'];
    $CustomerID = $_SESSION['CustomerId'];

    if($function == 'loadPieChartBySKUNo')
    {   
        $dataBarGraph = $_POST['dataBarGraph'];
        $to = $_POST['to'];
        $from = $_POST['from'];
        $filter = $_POST['filter'];
        $searchkey = $_POST['searchkey'];
        $reend = $_POST['reend'];
        $restart = $_POST['restart'];
        $date = date('Y-m-d');
        $sub = date('Y-m-d', strtotime('-29 day', strtotime($date)));

        if($to == $date && $from == $sub)
        {
            $from = '1970-01-01';
            $to = '2040-01-01';
        }

        loadPieChartBySKUNo($dataBarGraph, $CustomerID, $to, $from, $filter, $searchkey, $restart, $reend);
    }

    function loadPieChartBySKUNo($dataBarGraph, $CustomerID, $to, $from, $filter, $searchkey, $restart, $reend)
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
        if($reend != 0)
        {
          if($dataBarGraph == 'Total Quantity' || $dataBarGraph == 'Total SO' || empty($dataBarGraph))
          {
              $query = "SELECT
                          LEFT(ExpiryDate, 10),
                          IFNULL(SUM(wms_inbound.tbl_receivingitems.Quantity), 0)
                          FROM wms_inbound.tbl_receivingitems
                          LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
                          LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                          ";

                if($searchkey == null && $searchkey == '' && $searchkey == 0)
                { 
                   $query .= "WHERE CustomerID = $CustomerID AND LEFT(ExpiryDate, 10) BETWEEN '$restart' AND '$reend' AND wms_inbound.tbl_receiving.StatusID = 3
                GROUP BY ExpiryDate";
                }
                else if(!empty($searchkey))
                {
                  $query .= "WHERE CustomerID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND LEFT(ExpiryDate, 10) BETWEEN '$restart' AND '$reend' AND wms_inbound.tbl_receiving.StatusID = 3
                GROUP BY ExpiryDate";
                }

                $res = mysqli_query($conn, $query);

                if(mysqli_num_rows($res) < 1)
                {
                  $expired = 0;
                  $lThree = 0;
                  $lSix = 0;
                  $mSix = 0;
                  $noexpiry = 0;
                }
                else
                {
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
                       else if($rows[0] > $date && $lessThree <= $lessSix)
                       {
                         $lSix += $rows[1];
                       }
                       else if($rows[0] > $lessSix)
                       {
                         $mSix += $rows[1];
                       }
                  }
                }


              $query = "SELECT
                          LEFT(ExpiryDate, 10),
                          IFNULL(SUM(wms_inbound.tbl_receivingitems.Quantity), 0)
                          FROM wms_inbound.tbl_receivingitems
                          LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
                          LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                          ";

                if($searchkey == null && $searchkey == '' && $searchkey == 0)
                { 
                   $query .= "WHERE CustomerID = $CustomerID AND (ExpiryDate IS NULL OR LEFT(ExpiryDate, 10) = '0000-00-00') AND wms_inbound.tbl_receiving.StatusID = 3
                GROUP BY ExpiryDate";
                }
                else if(!empty($searchkey))
                {
                  $query .= "WHERE CustomerID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND (ExpiryDate IS NULL OR LEFT(ExpiryDate, 10) = '0000-00-00') AND wms_inbound.tbl_receiving.StatusID = 3
                GROUP BY ExpiryDate";
                }

                $res = mysqli_query($conn, $query);

                while($rows = mysqli_fetch_array($res))
                {
                    $noexpiry = $rows[1];
                }

                $lSix = $lSix + $lThree;
                $data[] = array($expired, $lThree, $lSix, $mSix, $noexpiry);

                echo json_encode($data);

          }
          else if($dataBarGraph == 'Total Weight')
          {
              $query = "SELECT
                          LEFT(ExpiryDate, 10),
                          IFNULL(SUM(wms_inbound.tbl_receivingitems.Weight), 0)
                          FROM wms_inbound.tbl_receivingitems
                          LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
                          LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                          ";

                if($searchkey == null && $searchkey == '' && $searchkey == 0)
                { 
                   $query .= "WHERE CusID = $CustomerID AND LEFT(ExpiryDate, 10) BETWEEN '$restart' AND '$reend' AND wms_inbound.tbl_receiving.StatusID = 3
                GROUP BY ExpiryDate";
                }
                else if(!empty($searchkey))
                {
                  $query .= "WHERE CusID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND LEFT(ExpiryDate, 10) BETWEEN '$restart' AND '$reend' AND wms_inbound.tbl_receiving.StatusID = 3
                GROUP BY ExpiryDate";
                }

                $res = mysqli_query($conn, $query);

                if(mysqli_num_rows($res) < 1)
                {
                  $expired = 0;
                  $lThree = 0;
                  $lSix = 0;
                  $mSix = 0;
                  $noexpiry = 0;
                }
                else
                {
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
                       else if($rows[0] > $date && $lessThree <= $lessSix)
                       {
                         $lSix += $rows[1];
                         // $lFour = $lFour + $lTwo;
                       }
                       else if($rows[0] > $lessSix)
                       {
                         $mSix += $rows[1];
                       }
                  }
                }


              $query = "SELECT
                          LEFT(ExpiryDate, 10),
                          IFNULL(SUM(wms_inbound.tbl_receivingitems.Weight), 0)
                          FROM wms_inbound.tbl_receivingitems
                          LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
                          LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                          ";

                if($searchkey == null && $searchkey == '' && $searchkey == 0)
                { 
                   $query .= "WHERE CusID = $CustomerID AND (ExpiryDate IS NULL OR LEFT(ExpiryDate, 10) = '0000-00-00') AND wms_inbound.tbl_receiving.StatusID = 3
                GROUP BY ExpiryDate";
                }
                else if(!empty($searchkey))
                {
                  $query .= "WHERE CusID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND (ExpiryDate IS NULL OR LEFT(ExpiryDate, 10) = '0000-00-00') AND wms_inbound.tbl_receiving.StatusID = 3
                GROUP BY ExpiryDate";
                }

                $res = mysqli_query($conn, $query);

                while($rows = mysqli_fetch_array($res))
                {
                    $noexpiry += $rows[1];
                    // $noexpiry = number_format((float)$rows[1], 2);
                }
                $lSix = $lSix + $lThree;

                $data[] = array($expired, $lThree, $lSix, $mSix, $noexpiry);

                echo json_encode($data);

          }
        }
        else
        {
          if($dataBarGraph == 'Total Quantity' || $dataBarGraph == 'Total SO' || empty($dataBarGraph))
          {
              $query = "SELECT
                          LEFT(ExpiryDate, 10),
                          IFNULL(SUM(wms_inbound.tbl_receivingitems.Quantity), 0)
                          FROM wms_inbound.tbl_receivingitems
                          LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
                          LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                          ";

                if($searchkey == null && $searchkey == '' && $searchkey == 0)
                { 
                   $query .= "WHERE CustomerID = $CustomerID AND LEFT(ExpiryDate, 10) BETWEEN '$from' AND '$to' AND wms_inbound.tbl_receiving.StatusID = 3
                GROUP BY ExpiryDate";
                }
                else if(!empty($searchkey))
                {
                  $query .= "WHERE CustomerID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND  LEFT(ExpiryDate, 10) BETWEEN '$from' AND '$to' AND wms_inbound.tbl_receiving.StatusID = 3
                GROUP BY ExpiryDate";
                }

                $res = mysqli_query($conn, $query);

                if(mysqli_num_rows($res) < 1)
                {
                  $expired = 0;
                  $lThree = 0;
                  $lSix = 0;
                  $mSix = 0;
                  $noexpiry = 0;
                }
                else
                {
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
                       else if($rows[0] > $date && $lessThree <= $lessSix)
                       {
                         $lSix += $rows[1];
                         // $lFour = $lFour + $lTwo;
                       }
                       else if($rows[0] > $lessSix)
                       {
                         $mSix += $rows[1];
                       }


                  }
                }


              $query = "SELECT
                          LEFT(ExpiryDate, 10),
                          IFNULL(SUM(wms_inbound.tbl_receivingitems.Quantity), 0)
                          FROM wms_inbound.tbl_receivingitems
                          LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
                          LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                          ";

                if($searchkey == null && $searchkey == '' && $searchkey == 0)
                { 
                   $query .= "WHERE CusID = $CustomerID AND (ExpiryDate IS NULL OR LEFT(ExpiryDate, 10) = '0000-00-00') AND wms_inbound.tbl_receiving.StatusID = 3
                GROUP BY ExpiryDate";
                }
                else if(!empty($searchkey))
                {
                  $query .= "WHERE CusID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND (ExpiryDate IS NULL OR LEFT(ExpiryDate, 10) = '0000-00-00') AND wms_inbound.tbl_receiving.StatusID = 3
                GROUP BY ExpiryDate";
                }

                $res = mysqli_query($conn, $query);

                while($rows = mysqli_fetch_array($res))
                {
                    $noexpiry += $rows[1];
                }

                // $lSix = $lSix + $lThree;
                $data[] = array($expired, $lThree, $lSix, $mSix, $noexpiry);

                echo json_encode($data);

          }
          else if($dataBarGraph == 'Total Weight')
          {
              $query = "SELECT
                          LEFT(ExpiryDate, 10),
                          IFNULL(SUM(wms_inbound.tbl_receivingitems.Weight), 0)
                          FROM wms_inbound.tbl_receivingitems
                          LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
                          LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                          ";

                if($searchkey == null && $searchkey == '' && $searchkey == 0)
                { 
                   $query .= "WHERE CusID = $CustomerID AND LEFT(ExpiryDate, 10) BETWEEN '$from' AND '$to' AND wms_inbound.tbl_receiving.StatusID = 3
                GROUP BY ExpiryDate";
                }
                else if(!empty($searchkey))
                {
                  $query .= "WHERE CusID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND  LEFT(ExpiryDate, 10) BETWEEN '$from' AND '$to' AND wms_inbound.tbl_receiving.StatusID = 3
                GROUP BY ExpiryDate";
                }

                $res = mysqli_query($conn, $query);

                if(mysqli_num_rows($res) < 1)
                {
                  $expired = 0;
                  $lThree = 0;
                  $lSix = 0;
                  $mSix = 0;
                  $noexpiry = 0;
                }
                else
                {
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
                       else if($rows[0] > $date && $lessThree <= $lessSix)
                       {
                         $lSix += $rows[1];
                         // $lFour = $lFour + $lTwo;
                       }
                       else if($rows[0] > $lessSix)
                       {
                         $mSix += $rows[1];
                       }
                  }
                }


              $query = "SELECT
                          LEFT(ExpiryDate, 10),
                          IFNULL(SUM(wms_inbound.tbl_receivingitems.Weight), 0)
                          FROM wms_inbound.tbl_receivingitems
                          LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
                          LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                          ";

                if($searchkey == null && $searchkey == '' && $searchkey == 0)
                { 
                   $query .= "WHERE CusID = $CustomerID AND (ExpiryDate IS NULL OR LEFT(ExpiryDate, 10) = '0000-00-00') AND wms_inbound.tbl_receiving.StatusID = 3
                GROUP BY ExpiryDate";
                }
                else if(!empty($searchkey))
                {
                  $query .= "WHERE CusID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND (ExpiryDate IS NULL OR LEFT(ExpiryDate, 10) = '0000-00-00') AND wms_inbound.tbl_receiving.StatusID = 3
                GROUP BY ExpiryDate";
                }

                $res = mysqli_query($conn, $query);

                while($rows = mysqli_fetch_array($res))
                {
                    $noexpiry += $rows[1];
                    // $noexpiry = number_format((float)$rows[1], 2);
                }
                // $lSix = $lSix + $lThree;

                $data[] = array($expired, $lThree, $lSix, $mSix, $noexpiry);

                echo json_encode($data);

          }
        }
        
    }