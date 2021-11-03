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
	 	  'title'          => $row[0] . ' Received',
          'start'          => $row[1],
          'allDay'         => 'true',
          'backgroundColor'=> '#6082B6',
          'borderColor'    => '#6082B6'
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
	 	  'title'          => 50 . ' Planned',
          'start'          => $row[1],
          'allDay'         => 'true',
          'backgroundColor'=> '#A7C7E7',
          'borderColor'    => '#A7C7E7'
	 );
}

echo json_encode($data1);


