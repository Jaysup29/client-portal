<?php

//load.php

include 'dbcon.php';

$data1 = array();

$query = "SELECT 
			Count(ri.IBN),
            LEFT(ReceivingDate, 10)
		FROM wms_inbound.tbl_receivingitems ri
		LEFT JOIN wms_inbound.tbl_receiving r ON ri.IBN = r.IBN
        GROUP BY LEFT(ReceivingDate, 10)
		    ";

$result = mysqli_query($conn, $query);

while($row = mysqli_fetch_array($result))
{

 	$data1[] = array(
	 	  'title'          => $row[0] . ' Delivered',
          'start'          => $row[1],
          'allDay'         => 'true',
          'backgroundColor'=> '#C1E1C1',
          'borderColor'    => '#C1E1C1'
	 );
}



$query = "SELECT 
			Count(ri.IBN),
            LEFT(ReceivingDate, 10)
		FROM wms_inbound.tbl_receivingitems ri
		LEFT JOIN wms_inbound.tbl_receiving r ON ri.IBN = r.IBN
        GROUP BY LEFT(ReceivingDate, 10)
		    ";

$result = mysqli_query($conn, $query);

while($row = mysqli_fetch_array($result))
{

 	$data1[] = array(
	 	  'title'          => 50 . ' Undelivered',
          'start'          => $row[1],
          'allDay'         => 'true',
          'backgroundColor'=> '#DC143C',
          'borderColor'    => '#DC143C'
	 );
}

echo json_encode($data1);


