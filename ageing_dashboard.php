<?php 
  
  $CustomerID = $_SESSION['CustomerId'];
  $lessTwo = date('Y-m-d', strtotime('+2 months'));
  $lessFour = date('Y-m-d', strtotime('+4 months'));
  $lessSix = date('Y-m-d', strtotime('+6 months'));

  $expired = 0;
  $lTwo = 0;
  $lFour = 0;
  $lSix = 0;
  $mSix = 0;

  include ('dbcon.php');

  $query = "SELECT
              COUNT(Client_SKU)
          FROM wms_inbound.tbl_receivingitems
          LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
          LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
          WHERE CusID = $CustomerID AND ExpiryDate < CURDATE()
          ";

  $res = mysqli_query($conn, $query);

  while($rows = mysqli_fetch_array($res))
  {
    $expired = $rows[0];
  }

  $query = "SELECT
              COUNT(Client_SKU)
          FROM wms_inbound.tbl_receivingitems
          LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
          LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
          WHERE CusID = $CustomerID AND ExpiryDate BETWEEN CURDATE() AND '$lessTwo'
          ";

  $res = mysqli_query($conn, $query);

  while($rows = mysqli_fetch_array($res))
  {
    $lTwo = $rows[0];
  }


  $query = "SELECT
              COUNT(Client_SKU)
          FROM wms_inbound.tbl_receivingitems
          LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
          LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
          WHERE CusID = $CustomerID AND ExpiryDate BETWEEN CURDATE() AND '$lessFour'
          ";

  $res = mysqli_query($conn, $query);

  while($rows = mysqli_fetch_array($res))
  {
    $lFour = $rows[0];
  }


  $query = "SELECT
              COUNT(Client_SKU)
          FROM wms_inbound.tbl_receivingitems
          LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
          LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
          WHERE CusID = $CustomerID AND ExpiryDate BETWEEN CURDATE() AND '$lessSix'
          ";

  $res = mysqli_query($conn, $query);

  while($rows = mysqli_fetch_array($res))
  {
    $lSix = $rows[0];
  }

  $query = "SELECT
              COUNT(Client_SKU)
          FROM wms_inbound.tbl_receivingitems
          LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
          LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
          WHERE CusID = $CustomerID AND ExpiryDate BETWEEN '$lessSix' AND '2060-01-01'
          ";

  $res = mysqli_query($conn, $query);

  while($rows = mysqli_fetch_array($res))
  {
    $mSix = $rows[0];
  }



 ?>