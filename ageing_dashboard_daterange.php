<?php
session_start();
ini_set('max_execution_time', '300');
set_time_limit(300);
date_default_timezone_set('Asia/Manila');
$function = $_POST['function'];
$CustomerID = $_SESSION['CustomerId'];

if($function == 'loadPieChartByDateRange')
{
  $dataBarGraph = $_POST['dataBarGraph'];
  $searchkey = $_POST['searchSKU'];
  $to = $_POST['to'];
  $from = $_POST['from'];
  loadPieChartByDateRange($CustomerID, $dataBarGraph, $searchkey, $to, $from);
}

function loadPieChartByDateRange($CustomerID, $dataBarGraph, $searchkey, $to, $from)
{   
  
  $lessThree = date('Y-m-d', strtotime('+3 months'));
  $lessSix = date('Y-m-d', strtotime('+6 months'));

  $expired = 0;
  $lThree = 0;
  $lSix = 0;
  $mSix = 0;
  $noexpiry = 0;

  include ('dbcon.php');
  $date = date('Y-m-d');
  $sum = 0;
  if($dataBarGraph == 'Total Quantity')
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
         $query .= "WHERE CusID = $CustomerID AND LEFT(ExpiryDate, 10) BETWEEN '$from' AND '$to' AND wms_inbound.tbl_receiving.StatusID = 3
      GROUP BY ExpiryDate";
      }
      else if(!empty($searchkey))
      {
        $query .= "WHERE CusID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND LEFT(ExpiryDate, 10) BETWEEN '$from' AND '$to' AND wms_inbound.tbl_receiving.StatusID = 3
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
           else if($rows[0] > $date && $rows[0] <= $lessSix)
           {
             $lSix += $rows[1];
             // $lFour = $lFour + $lTwo;
           }
           else if($rows[0] > $lessSix)
           {
             $mSix += $rows[1];
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
         $query .= "WHERE CusID = $CustomerID AND LEFT(ExpiryDate, 10) BETWEEN '$from' AND '$to' AND wms_inbound.tbl_receiving.StatusID = 3
      GROUP BY ExpiryDate";
      }
      else if(!empty($searchkey))
      {
        $query .= "WHERE CusID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND  LEFT(ExpiryDate, 10) BETWEEN '$from' AND '$to' AND wms_inbound.tbl_receiving.StatusID = 3
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
           else if($rows[0] > $date && $rows[0] <= $lessSix)
           {
             $lSix += $rows[1];
             // $lFour = $lFour + $lTwo;
           }
           else if($rows[0] > $lessSix)
           {
             $mSix += $rows[1];
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
          $noexpiry = $rows[1];
      }

     $lSix = $lSix + $lThree;
     $data[] = array($expired, $lThree, $lSix, $mSix, $noexpiry);

     echo json_encode($data);
      

  }

  else if(empty($dataBarGraph))
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
         $query .= "WHERE CusID = $CustomerID AND LEFT(ExpiryDate, 10) BETWEEN '$from' AND '$to' AND wms_inbound.tbl_receiving.StatusID = 3
      GROUP BY ExpiryDate";
      }
      else if(!empty($searchkey))
      {
        $query .= "WHERE CusID = $CustomerID AND wms_cloud.tbl_items.ItemID = '$searchkey' AND  LEFT(ExpiryDate, 10) BETWEEN '$from' AND '$to' AND wms_inbound.tbl_receiving.StatusID = 3
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
           else if($rows[0] > $date && $rows[0] <= $lessSix)
           {
             $lSix += $rows[1];
             // $lFour = $lFour + $lTwo;
           }
           else if($rows[0] > $lessSix)
           {
             $mSix += $rows[1];
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
          $noexpiry = $rows[1];
      }

     $lSix = $lSix + $lThree;
     $data[] = array($expired, $lThree, $lSix, $mSix, $noexpiry);

     echo json_encode($data);
  }
  
}