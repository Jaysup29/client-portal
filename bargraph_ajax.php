<?php 

	session_start();
    ini_set('max_execution_time', '300');
    set_time_limit(300);
    date_default_timezone_set('Asia/Manila');
	$function = $_POST['function'];
	$CustomerID = $_SESSION['CustomerId'];
	if($function == 'bargraph_ajax')
    {
        bargraph_ajax();
    }

    else if($function == 'bargraph_mainfilter_ajax')
    {
    	$dataBarGraph = $_POST['dataBarGraph'];
    	$CustomerID = $_POST['CustomerID'];
    	bargraph_mainfilter_ajax($dataBarGraph, $CustomerID);
    }

    else if($function == 'bargraph_mainfilter_ajax_order')
    {
    	$dataBarGraph = $_POST['dataBarGraph'];
    	$CustomerID = $_POST['CustomerID'];
    	bargraph_mainfilter_ajax_order($dataBarGraph, $CustomerID);
    }

    else if($function == 'bargraph_subfilter_ajax')
    {
    	$dataBarGraph = $_POST['dataBarGraph'];
    	$loadSKUandDesc = $_POST['loadSKUandDesc'];
    	$CustomerID = $_POST['CustomerID'];
    	bargraph_subfilter_ajax($dataBarGraph, $loadSKUandDesc, $CustomerID);
    }

    else if($function == 'bargraph_subfilter_ajax_order')
    {
    	$dataBarGraph = $_POST['dataBarGraph'];
    	$loadSKUandDesc = $_POST['loadSKUandDesc'];
    	$CustomerID = $_POST['CustomerID'];
    	bargraph_subfilter_ajax_order($dataBarGraph, $loadSKUandDesc, $CustomerID);
    }

    function bargraph_ajax()
    {	

    	$start = date('Y-m-d',strtotime('last monday -7 days'));

		$start1 = date('Y-m-d', strtotime($start. ' + 0 days'));
		$start2 = date('Y-m-d', strtotime($start. ' + 1 days'));
		$start3 = date('Y-m-d', strtotime($start. ' + 2 days'));
		$start4 = date('Y-m-d', strtotime($start. ' + 3 days'));
		$start5 = date('Y-m-d', strtotime($start. ' + 4 days'));
		$start6 = date('Y-m-d', strtotime($start. ' + 5 days'));
		$start7 = date('Y-m-d', strtotime($start. ' + 6 days'));
		$start8 = date('Y-m-d', strtotime($start. ' + 7 days'));
		$start9 = date('Y-m-d', strtotime($start. ' + 8 days'));
		$start10 = date('Y-m-d', strtotime($start. ' + 9 days'));
		$start11= date('Y-m-d', strtotime($start. ' + 10 days'));
		$start12 = date('Y-m-d', strtotime($start. ' + 11 days'));
		$start13 = date('Y-m-d', strtotime($start. ' + 12 days'));
		$start14 = date('Y-m-d', strtotime($start. ' + 13 days'));

		include 'dbcon.php';
		 $starttime = 'T00:00:01';
   		 $endtime = 'T23:59:59';
		// Received
			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID = 3 AND rec.ReceivingDate BETWEEN '$start1$starttime' AND '$start1$endtime' AND ri.CustomerID = $CustomerID";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day1 = $rows[0];
			}

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID = 3 AND rec.ReceivingDate BETWEEN '$start2$starttime' AND '$start2$endtime' AND ri.CustomerID = $CustomerID";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day2 = $rows[0];
			}

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID = 3 AND rec.ReceivingDate BETWEEN '$start3$starttime' AND '$start3$endtime' AND ri.CustomerID = $CustomerID";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day3 = $rows[0];
			}

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID = 3 AND rec.ReceivingDate BETWEEN '$start4$starttime' AND '$start4$endtime' AND ri.CustomerID = $CustomerID";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day4 = $rows[0];
			}

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID = 3 AND rec.ReceivingDate BETWEEN '$start5$starttime' AND '$start5$endtime' AND ri.CustomerID = $CustomerID";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day5 = $rows[0];
			}

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID = 3 AND rec.ReceivingDate BETWEEN '$start6$starttime' AND '$start6$endtime' AND ri.CustomerID = $CustomerID";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day6 = $rows[0];
			}

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID = 3 AND rec.ReceivingDate BETWEEN '$start7$starttime' AND '$start7$endtime' AND ri.CustomerID = $CustomerID";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day7 = $rows[0];
			}

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID = 3 AND rec.ReceivingDate BETWEEN '$start8$starttime' AND '$start8$endtime' AND ri.CustomerID = $CustomerID";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day8 = $rows[0];
			}

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID = 3 AND rec.ReceivingDate BETWEEN '$start9$starttime' AND '$start9$endtime' AND ri.CustomerID = $CustomerID";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day9 = $rows[0];
			}

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID = 3 AND rec.ReceivingDate BETWEEN '$start10$starttime' AND '$start10$endtime' AND ri.CustomerID = $CustomerID";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day10 = $rows[0];
			}

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID = 3 AND rec.ReceivingDate BETWEEN '$start11$starttime' AND '$start11$endtime' AND ri.CustomerID = $CustomerID";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day11 = $rows[0];
			}

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID = 3 AND rec.ReceivingDate BETWEEN '$start12$starttime' AND '$start12$endtime' AND ri.CustomerID = $CustomerID";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day12 = $rows[0];
			}

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID = 3 AND rec.ReceivingDate BETWEEN '$start13$starttime' AND '$start13$endtime' AND ri.CustomerID = $CustomerID";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day13 = $rows[0];
			}

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID = 3 AND rec.ReceivingDate BETWEEN '$start14$starttime' AND '$start14$endtime' AND ri.CustomerID = $CustomerID";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day14 = $rows[0];
			}
		// Received


		// Planned

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID < 3 AND rec.ReceivingDate BETWEEN '$start1 00:00:01' AND '$start1 23:59:59'";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day1_planned = $rows[0];
			}

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID < 3 AND rec.ReceivingDate BETWEEN '$start2 00:00:01' AND '$start2 23:59:59'";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day2_planned = $rows[0];
			}

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID < 3 AND rec.ReceivingDate BETWEEN '$start3 00:00:01' AND '$start3 23:59:59'";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day3_planned = $rows[0];
			}

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID < 3 AND rec.ReceivingDate BETWEEN '$start4 00:00:01' AND '$start4 23:59:59'";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day4_planned = $rows[0];
			}

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID < 3 AND rec.ReceivingDate BETWEEN '$start5 00:00:01' AND '$start5 23:59:59'";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day5_planned = $rows[0];
			}

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID < 3 AND rec.ReceivingDate BETWEEN '$start6 00:00:01' AND '$start6 23:59:59'";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day6_planned = $rows[0];
			}

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID < 3 AND rec.ReceivingDate BETWEEN '$start7 00:00:01' AND '$start7 23:59:59'";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day7_planned = $rows[0];
			}

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID < 3 AND rec.ReceivingDate BETWEEN '$start8 00:00:01' AND '$start8 23:59:59'";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day8_planned = $rows[0];
			}

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID < 3 AND rec.ReceivingDate BETWEEN '$start9 00:00:01' AND '$start9 23:59:59'";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day9_planned = $rows[0];
			}

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID < 3 AND rec.ReceivingDate BETWEEN '$start10 00:00:01' AND '$start10 23:59:59'";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day10_planned = $rows[0];
			}

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID < 3 AND rec.ReceivingDate BETWEEN '$start11 00:00:01' AND '$start11 23:59:59'";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day11_planned = $rows[0];
			}

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID < 3 AND rec.ReceivingDate BETWEEN '$start12 00:00:01' AND '$start12 23:59:59'";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day12_planned = $rows[0];
			}

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID < 3 AND rec.ReceivingDate BETWEEN '$start13 00:00:01' AND '$start13 23:59:59'";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day13_planned = $rows[0];
			}

			$query = "SELECT 
					IFNULL(SUM(Beg_Quantity), 0)
					FROM wms_inbound.tbl_receivingitems ri
					LEFT JOIN wms_inbound.tbl_receiving rec ON ri.IBN = rec.IBN
					WHERE StatusID < 3 AND rec.ReceivingDate BETWEEN '$start14 00:00:01' AND '$start14 23:59:59'";
			$result = mysqli_query($conn, $query);

			while($rows = mysqli_fetch_array($result))
			{
				$day14_planned = $rows[0];
			}

		// Planned

			$start = date('M d'.','.' Y', strtotime($start));
			$start1 = date('M d'.','.' Y', strtotime($start1));
			$start2 = date('M d'.','.' Y', strtotime($start2));
			$start3 = date('M d'.','.' Y', strtotime($start3));
			$start4 = date('M d'.','.' Y', strtotime($start4));
			$start5 = date('M d'.','.' Y', strtotime($start5));
			$start6 = date('M d'.','.' Y', strtotime($start6));
			$start7 = date('M d'.','.' Y', strtotime($start7));
			$start8 = date('M d'.','.' Y', strtotime($start8));
			$start9 = date('M d'.','.' Y', strtotime($start9));
			$start10 = date('M d'.','.' Y', strtotime($start10));
			$start11 = date('M d'.','.' Y', strtotime($start11));
			$start12 = date('M d'.','.' Y', strtotime($start12));
			$start13 = date('M d'.','.' Y', strtotime($start13));
			$start14 = date('M d'.','.' Y', strtotime($start14));

			$data1 = [$start1, $start2, $start3, $start4, $start5, $start6, $start7, $start8, $start9, $start10, $start11, $start12, $start13, $start14];
			$received = [$day1, $day2, $day3, $day4, $day5, $day6, $day7, $day8, $day9, $day10, $day11, $day12, $day13, $day14];
			$planned = [$day1_planned, $day2_planned, $day3_planned, $day4_planned, $day5_planned, $day6_planned, $day7_planned, $day8_planned, $day9_planned, $day10_planned, $day11_planned, $day12_planned, $day13_planned, $day14_planned];
			
			$data[] = array(
				'data1' => $data1,
				'data2' => $received,
				'data3' => $planned 
		    );

    	echo json_encode($data);
    }

    function bargraph_mainfilter_ajax($dataBarGraph, $CustomerID)
    {

		include 'dbcon.php';
		$starttime = 'T00:00:01';
   		$endtime = 'T23:59:59';
		if($dataBarGraph == 'Total Quantity')
		{
			$start = date('Y-m-d',strtotime('last monday -7 days'));
		    $start1 = date('Y-m-d', strtotime($start. ' + 0 days'));
		    $start14 = date('Y-m-d', strtotime($start. ' + 13 days'));

		    include 'dbcon.php';
		    
		    $query = "CALL wms_reports.SP_inbound_dashboard_received($CustomerID, '$start1', '$start14')";
		    $result = mysqli_query($conn, $query);

		    while($rows = mysqli_fetch_array($result))
		    {
		        $received[] = array('rec'=>$rows[1]);
		    } 

		    foreach ($received as $key => $value) {
		       $receive[] = $value['rec'];
		    }

		    include 'dbcon.php';
		    $query = "CALL wms_reports.SP_inbound_dashboard_planned($CustomerID, '$start1', '$start14')";
		    $result = mysqli_query($conn, $query);

		    while($rows = mysqli_fetch_array($result))
		    {   
		        $row_date = date('M d'.','.' Y', strtotime($rows[0]));
		        $planned[] = array('plan'=>$rows[1]);
		        $dated[] = array('date'=>$row_date);
		    } 

		    foreach ($planned as $key => $value) {
		       $plan[] = $value['plan'];
		    }

		    foreach ($dated as $key => $value) {
		       $date[] = $value['date'];
		    }
		  

		    $data[] = array(
                'data1' => $date,
                'data2' => $receive,
                'data3' => $plan
            );

		}

		else if($dataBarGraph == 'Total Weight')
		{
			$start = date('Y-m-d',strtotime('last monday -7 days'));
		    $start1 = date('Y-m-d', strtotime($start. ' + 0 days'));
		    $start14 = date('Y-m-d', strtotime($start. ' + 13 days'));

		    include 'dbcon.php';
		    
		    $query = "CALL wms_reports.SP_inbound_dashboard_received($CustomerID, '$start1', '$start14')";
		    $result = mysqli_query($conn, $query);

		    while($rows = mysqli_fetch_array($result))
		    {
		        $received[] = array('rec'=>$rows[2]);
		    } 

		    foreach ($received as $key => $value) {
		       $receive[] = $value['rec'];
		    }

		    include 'dbcon.php';
		    $query = "CALL wms_reports.SP_inbound_dashboard_planned($CustomerID, '$start1', '$start14')";
		    $result = mysqli_query($conn, $query);

		    while($rows = mysqli_fetch_array($result))
		    {   
		    	$wgt = number_format((float)$rows[2], 2);
		        $row_date = date('M d'.','.' Y', strtotime($rows[0]));
		        $planned[] = array('plan'=>$rows[2]);
		        $dated[] = array('date'=>$row_date);
		    } 

		    foreach ($planned as $key => $value) {
		       $plan[] = $value['plan'];
		    }

		    foreach ($dated as $key => $value) {
		       $date[] = $value['date'];
		    }
		  

		    $data[] = array(
                'data1' => $date,
                'data2' => $receive,
                'data3' => $plan
            );
		}

    	echo json_encode($data);
    }


    function bargraph_subfilter_ajax($dataBarGraph, $loadSKUandDesc, $CustomerID)
    {

		include 'dbcon.php';

		if($dataBarGraph == 'Total Quantity')
		{
			$start = date('Y-m-d',strtotime('last monday -7 days'));
		    $start1 = date('Y-m-d', strtotime($start. ' + 0 days'));
		    $start14 = date('Y-m-d', strtotime($start. ' + 13 days'));

		    include 'dbcon.php';
		    
		    $query = "CALL wms_reports.SP_inbound_dashboard_received_by_item($CustomerID, '$start1', '$start14', $loadSKUandDesc)";
		    $result = mysqli_query($conn, $query);

		    while($rows = mysqli_fetch_array($result))
		    {
		        $received[] = array('rec'=>$rows[1]);
		    } 

		    foreach ($received as $key => $value) {
		       $receive[] = $value['rec'];
		    }

		    include 'dbcon.php';
		    $query = "CALL wms_reports.SP_inbound_dashboard_planned_by_item($CustomerID, '$start1', '$start14', $loadSKUandDesc)";
		    $result = mysqli_query($conn, $query);

		    while($rows = mysqli_fetch_array($result))
		    {   
		        $row_date = date('M d'.','.' Y', strtotime($rows[0]));
		        $planned[] = array('plan'=>$rows[1]);
		        $dated[] = array('date'=>$row_date);
		    } 

		    foreach ($planned as $key => $value) {
		       $plan[] = $value['plan'];
		    }

		    foreach ($dated as $key => $value) {
		       $date[] = $value['date'];
		    }
		  

		    $data[] = array(
                'data1' => $date,
                'data2' => $receive,
                'data3' => $plan
            );
		}

		else if($dataBarGraph == 'Total Weight')
		{
			$start = date('Y-m-d',strtotime('last monday -7 days'));
		    $start1 = date('Y-m-d', strtotime($start. ' + 0 days'));
		    $start14 = date('Y-m-d', strtotime($start. ' + 13 days'));

		    include 'dbcon.php';
		    
		    $query = "CALL wms_reports.SP_inbound_dashboard_received_by_item($CustomerID, '$start1', '$start14', $loadSKUandDesc)";
		    $result = mysqli_query($conn, $query);

		    while($rows = mysqli_fetch_array($result))
		    {
		        $received[] = array('rec'=>$rows[2]);
		    } 

		    foreach ($received as $key => $value) {
		       $receive[] = $value['rec'];
		    }

		    include 'dbcon.php';
		    $query = "CALL wms_reports.SP_inbound_dashboard_planned_by_item($CustomerID, '$start1', '$start14', $loadSKUandDesc)";
		    $result = mysqli_query($conn, $query);

		    while($rows = mysqli_fetch_array($result))
		    {   
		        $row_date = date('M d'.','.' Y', strtotime($rows[0]));
		        $planned[] = array('plan'=>$rows[2]);
		        $dated[] = array('date'=>$row_date);
		    } 

		    foreach ($planned as $key => $value) {
		       $plan[] = $value['plan'];
		    }

		    foreach ($dated as $key => $value) {
		       $date[] = $value['date'];
		    }
		  

		    $data[] = array(
                'data1' => $date,
                'data2' => $receive,
                'data3' => $plan
            );
		}

    	echo json_encode($data);
    }

    function bargraph_mainfilter_ajax_order($dataBarGraph, $CustomerID)
    {
    	// Quantity Undelivered
	    	
			include 'dbcon.php';

			if($dataBarGraph == 'Total Quantity')
			{
				$start = date('Y-m-d',strtotime('last monday -7 days'));
			    $start1 = date('Y-m-d', strtotime($start. ' + 0 days'));
			    $start14 = date('Y-m-d', strtotime($start. ' + 13 days'));

			    include 'dbcon.php';
			    
			    $query = "CALL wms_reports.SP_outbound_dashboard_undelivered($CustomerID, '$start1', '$start14')";
			    $result = mysqli_query($conn, $query);
			    // echo $query;
			    while($rows = mysqli_fetch_array($result))
			    {   
			        $row_date = date('M d'.','.' Y', strtotime($rows[0]));
			        $ordered[] = array('plan'=>$rows[1]);
			        $dated[] = array('date'=>$row_date);
			    } 

			    foreach ($ordered as $key => $value) {
			       $undelivered[] = $value['plan'];
			    }

			    foreach ($dated as $key => $value) {
			       $date[] = $value['date'];
			    }
			  
			    include 'dbcon.php';
    
			    $query = "CALL wms_reports.SP_outbound_dashboard_delivered($CustomerID, '$start1', '$start14')";
			    $result = mysqli_query($conn, $query);
			    // echo $query;
			    while($rows = mysqli_fetch_array($result))
			    {
			        $out[] = array('del'=>$rows[1]);
			    } 

			    foreach ($out as $key => $value) {
			        $deliver[] = $value['del'];
			    }

			    $data[] = array(
					'data1' => $date,
					'data2' => $undelivered,
					'data3' => $deliver,
			    );
			}
			else if($dataBarGraph == 'Total Weight')
			{
				$start = date('Y-m-d',strtotime('last monday -7 days'));
			    $start1 = date('Y-m-d', strtotime($start. ' + 0 days'));
			    $start14 = date('Y-m-d', strtotime($start. ' + 13 days'));

			    include 'dbcon.php';
			    
			    $query = "CALL wms_reports.SP_outbound_dashboard_undelivered($CustomerID, '$start1', '$start14')";
			    $result = mysqli_query($conn, $query);
			    // echo $query;
			    while($rows = mysqli_fetch_array($result))
			    {   
			    	$wgt = $rows[2] * $rows[1];
			        $row_date = date('M d'.','.' Y', strtotime($rows[0]));
			        $ordered[] = array('plan'=>$wgt);
			        $dated[] = array('date'=>$row_date);
			    } 

			    foreach ($ordered as $key => $value) {
			       $undelivered[] = $value['plan'];
			    }

			    foreach ($dated as $key => $value) {
			       $date[] = $value['date'];
			    }
			  
			    include 'dbcon.php';
    
			    $query = "CALL wms_reports.SP_outbound_dashboard_delivered($CustomerID, '$start1', '$start14')";
			    $result = mysqli_query($conn, $query);
			    // echo $query;
			    while($rows = mysqli_fetch_array($result))
			    {	
			    	$wgt = $rows[2];
			        $out[] = array('del'=>$wgt);
			    } 

			    foreach ($out as $key => $value) {
			        $deliver[] = $value['del'];
			    }

			    $data[] = array(
					'data1' => $date,
					'data2' => $undelivered,
					'data3' => $deliver,
			    );
			}
		// Quantity
    	echo json_encode($data);
    }

    function bargraph_subfilter_ajax_order($dataBarGraph, $loadSKUandDesc, $CustomerID)
    {
    	// Quantity Undelivered
	    	
			include 'dbcon.php';

			if($dataBarGraph == 'Total Quantity')
			{
				$start = date('Y-m-d',strtotime('last monday -7 days'));

			    $start1 = date('Y-m-d', strtotime($start. ' + 0 days'));
			    $start2 = date('Y-m-d', strtotime($start. ' + 1 days'));
			    $start3 = date('Y-m-d', strtotime($start. ' + 2 days'));
			    $start4 = date('Y-m-d', strtotime($start. ' + 3 days'));
			    $start5 = date('Y-m-d', strtotime($start. ' + 4 days'));
			    $start6 = date('Y-m-d', strtotime($start. ' + 5 days'));
			    $start7 = date('Y-m-d', strtotime($start. ' + 6 days'));
			    $start8 = date('Y-m-d', strtotime($start. ' + 7 days'));
			    $start9 = date('Y-m-d', strtotime($start. ' + 8 days'));
			    $start10 = date('Y-m-d', strtotime($start. ' + 9 days'));
			    $start11= date('Y-m-d', strtotime($start. ' + 10 days'));
			    $start12 = date('Y-m-d', strtotime($start. ' + 11 days'));
			    $start13 = date('Y-m-d', strtotime($start. ' + 12 days'));
			    $start14 = date('Y-m-d', strtotime($start. ' + 13 days'));

			    $from_date = '00:00:01';
			    $to_date = '23:59:59';

			     $day1_unde = 0;
			     $day2_unde = 0;
			     $day3_unde = 0;
			     $day4_unde = 0;
			     $day5_unde = 0;
			     $day6_unde = 0;
			     $day7_unde = 0;
			     $day8_unde = 0;
			     $day9_unde = 0;
			     $day10_unde = 0;
			     $day11_unde = 0;
			     $day12_unde = 0;
			     $day13_unde = 0;
			     $day14_unde = 0;
			
			    $query = "SELECT 
			              SUM(Quantity)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
			              WHERE LEFT(OrderDate, 10) = '$start1' AND CustomerID = $CustomerID AND ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day1_unde = $rows[0];

			        if(empty($day1_unde))
			        {
			        	$day1_unde = 0;
			        }
			      }

			    $query = "SELECT 
			              SUM(Quantity)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
			              WHERE LEFT(OrderDate, 10) = '$start2' AND CustomerID = $CustomerID AND ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day2_unde = $rows[0];

			        if(empty($day2_unde))
			        {
			        	$day2_unde = 0;
			        }
			      }

			    $query = "SELECT 
			              SUM(Quantity)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
			              WHERE LEFT(OrderDate, 10) = '$start3' AND CustomerID = $CustomerID AND ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day3_unde = $rows[0];

			        if(empty($day3_unde))
			        {
			        	$day3_unde = 0;
			        }
			      }

			    $query = "SELECT 
			              SUM(Quantity)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
			              WHERE LEFT(OrderDate, 10) = '$start4' AND CustomerID = $CustomerID AND ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day4_unde = $rows[0];

			        if(empty($day4_unde))
			        {
			        	$day4_unde = 0;
			        }
			      }

			    $query = "SELECT 
			              SUM(Quantity)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
			              WHERE LEFT(OrderDate, 10) = '$start5' AND CustomerID = $CustomerID AND ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day5_unde = $rows[0];

			        if(empty($day5_unde))
			        {
			        	$day5_unde = 0;
			        }
			      }

			    $query = "SELECT 
			              SUM(Quantity)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
			              WHERE LEFT(OrderDate, 10) = '$start6' AND CustomerID = $CustomerID AND ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day6_unde = $rows[0];

			        if(empty($day6_unde))
			        {
			        	$day6_unde = 0;
			        }
			      }

			    $query = "SELECT 
			              SUM(Quantity)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
			              WHERE LEFT(OrderDate, 10) = '$start7' AND CustomerID = $CustomerID AND ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day7_unde = $rows[0];

			        if(empty($day7_unde))
			        {
			        	$day7_unde = 0;
			        }
			      }

			    $query = "SELECT 
			              SUM(Quantity)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
			              WHERE LEFT(OrderDate, 10) = '$start8' AND CustomerID = $CustomerID AND ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day8_unde = $rows[0];

			        if(empty($day8_unde))
			        {
			        	$day8_unde = 0;
			        }
			      }

			    $query = "SELECT 
			              SUM(Quantity)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
			              WHERE LEFT(OrderDate, 10) = '$start9' AND CustomerID = $CustomerID AND ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day9_unde = $rows[0];

			        if(empty($day9_unde))
			        {
			        	$day9_unde = 0;
			        }
			      }

			    $query = "SELECT 
			              SUM(Quantity)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
			              WHERE LEFT(OrderDate, 10) = '$start10' AND CustomerID = $CustomerID AND ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day10_unde = $rows[0];

			        if(empty($day10_unde))
			        {
			        	$day10_unde = 0;
			        }
			      }


			    $query = "SELECT 
			              SUM(Quantity)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
			              WHERE LEFT(OrderDate, 10) = '$start11' AND CustomerID = $CustomerID AND ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day11_unde = $rows[0];

			        if(empty($day11_unde))
			        {
			        	$day11_unde = 0;
			        }
			      }

			    $query = "SELECT 
			              SUM(Quantity)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
			              WHERE LEFT(OrderDate, 10) = '$start12' AND CustomerID = $CustomerID AND ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day12_unde = $rows[0];

			        if(empty($day12_unde))
			        {
			        	$day12_unde = 0;
			        }
			      }

			    $query = "SELECT 
			              SUM(Quantity)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
			              WHERE LEFT(OrderDate, 10) = '$start13' AND CustomerID = $CustomerID AND ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day13_unde = $rows[0];

			        if(empty($day13_unde))
			        {
			        	$day13_unde = 0;
			        }
			      }

			    $query = "SELECT 
			              SUM(Quantity)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
			              WHERE LEFT(OrderDate, 10) = '$start14' AND CustomerID = $CustomerID AND ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day14_unde = $rows[0];

			        if(empty($day14_unde))
			        {
			        	$day14_unde = 0;
			        }
			      }
			    // Undeliverd

			    $start = date('M d'.','.' Y', strtotime($start));
			    $start1 = date('M d'.','.' Y', strtotime($start1));
			    $start2 = date('M d'.','.' Y', strtotime($start2));
			    $start3 = date('M d'.','.' Y', strtotime($start3));
			    $start4 = date('M d'.','.' Y', strtotime($start4));
			    $start5 = date('M d'.','.' Y', strtotime($start5));
			    $start6 = date('M d'.','.' Y', strtotime($start6));
			    $start7 = date('M d'.','.' Y', strtotime($start7));
			    $start8 = date('M d'.','.' Y', strtotime($start8));
			    $start9 = date('M d'.','.' Y', strtotime($start9));
			    $start10 = date('M d'.','.' Y', strtotime($start10));
			    $start11 = date('M d'.','.' Y', strtotime($start11));
			    $start12 = date('M d'.','.' Y', strtotime($start12));
			    $start13 = date('M d'.','.' Y', strtotime($start13));
			    $start14 = date('M d'.','.' Y', strtotime($start14));

			    $data_date = [$start1, $start2, $start3, $start4, $start5, $start6, $start7, $start8, $start9, $start10, $start11, $start12, $start13, $start14];
			    $delivered = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			    $undelivered = [$day1_unde, $day2_unde, $day3_unde, $day4_unde, $day5_unde, $day6_unde, $day7_unde, $day8_unde, $day9_unde, $day10_unde, $day11_unde, $day12_unde, $day13_unde, $day14_unde];

			    $data[] = array(
					'data1' => $data_date,
					'data2' => $delivered,
					'data3' => $undelivered 
			    );
		
			}
		// Quantity

		// Weight

			else if($dataBarGraph == 'Total Weight')
			{
				$start = date('Y-m-d',strtotime('last monday -7 days'));

			    $start1 = date('Y-m-d', strtotime($start. ' + 0 days'));
			    $start2 = date('Y-m-d', strtotime($start. ' + 1 days'));
			    $start3 = date('Y-m-d', strtotime($start. ' + 2 days'));
			    $start4 = date('Y-m-d', strtotime($start. ' + 3 days'));
			    $start5 = date('Y-m-d', strtotime($start. ' + 4 days'));
			    $start6 = date('Y-m-d', strtotime($start. ' + 5 days'));
			    $start7 = date('Y-m-d', strtotime($start. ' + 6 days'));
			    $start8 = date('Y-m-d', strtotime($start. ' + 7 days'));
			    $start9 = date('Y-m-d', strtotime($start. ' + 8 days'));
			    $start10 = date('Y-m-d', strtotime($start. ' + 9 days'));
			    $start11= date('Y-m-d', strtotime($start. ' + 10 days'));
			    $start12 = date('Y-m-d', strtotime($start. ' + 11 days'));
			    $start13 = date('Y-m-d', strtotime($start. ' + 12 days'));
			    $start14 = date('Y-m-d', strtotime($start. ' + 13 days'));

			    $from_date = '00:00:01';
			    $to_date = '23:59:59';

			     $day1_unde = 0;
			     $day2_unde = 0;
			     $day3_unde = 0;
			     $day4_unde = 0;
			     $day5_unde = 0;
			     $day6_unde = 0;
			     $day7_unde = 0;
			     $day8_unde = 0;
			     $day9_unde = 0;
			     $day10_unde = 0;
			     $day11_unde = 0;
			     $day12_unde = 0;
			     $day13_unde = 0;
			     $day14_unde = 0;
			
			    $query = "SELECT
                          Quantity,
			              SUM(item.Weight)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
                          LEFT JOIN wms_cloud.tbl_items item ON ordi.ItemID = item.ItemID
			              WHERE LEFT(OrderDate, 10) = '$start1' AND CustomerID = $CustomerID AND ordi.ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day1_unde = $rows[0] * $rows[1];
			        $day1_unde = number_format((float)$day1_unde, 2);
			        $day1_unde = str_replace(',', '', $day1_unde);
			        $num = $day1_unde;
					$int = (int)$num;
					$day1_unde = (float)$num;

			        if(empty($day1_unde))
			        {
			        	$day1_unde = 0;
			        }
			      }
			      // echo $query;
			    $query = "SELECT
                          Quantity,
			              SUM(item.Weight)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
                          LEFT JOIN wms_cloud.tbl_items item ON ordi.ItemID = item.ItemID
			              WHERE LEFT(OrderDate, 10) = '$start2' AND CustomerID = $CustomerID AND ordi.ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day2_unde = $rows[0] * $rows[1];
			        $day2_unde = number_format((float)$day2_unde, 2);
			        $day2_unde = str_replace(',', '', $day2_unde);
			        $num = $day2_unde;
					$int = (int)$num;
					$day2_unde = (float)$num;

			        if(empty($day2_unde))
			        {
			        	$day2_unde = 0;
			        }
			      }

			    $query = "SELECT
                          Quantity,
			              SUM(item.Weight)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
                          LEFT JOIN wms_cloud.tbl_items item ON ordi.ItemID = item.ItemID
			              WHERE LEFT(OrderDate, 10) = '$start3' AND CustomerID = $CustomerID AND ordi.ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day3_unde = $rows[0] * $rows[1];
			        $day3_unde = number_format((float)$day3_unde, 2);
			        $day3_unde = str_replace(',', '', $day3_unde);
			        $num = $day3_unde;
					$int = (int)$num;
					$day3_unde = (float)$num;

			        if(empty($day3_unde))
			        {
			        	$day3_unde = 0;
			        }
			      }

			    $query = "SELECT
                          Quantity,
			              SUM(item.Weight)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
                          LEFT JOIN wms_cloud.tbl_items item ON ordi.ItemID = item.ItemID
			              WHERE LEFT(OrderDate, 10) = '$start4' AND CustomerID = $CustomerID AND ordi.ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day4_unde = $rows[0] * $rows[1];
			        $day4_unde = number_format((float)$day4_unde, 2);
			        $day4_unde = str_replace(',', '', $day4_unde);
			        $num = $day4_unde;
					$int = (int)$num;
					$day4_unde = (float)$num;

			        if(empty($day4_unde))
			        {
			        	$day4_unde = 0;
			        }
			      }

			    $query = "SELECT
                          Quantity,
			              SUM(item.Weight)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
                          LEFT JOIN wms_cloud.tbl_items item ON ordi.ItemID = item.ItemID
			              WHERE LEFT(OrderDate, 10) = '$start5' AND CustomerID = $CustomerID AND ordi.ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day5_unde = $rows[0] * $rows[1];
			        $day5_unde = number_format((float)$day5_unde, 2);
			        $day5_unde = str_replace(',', '', $day5_unde);
			        $num = $day5_unde;
					$int = (int)$num;
					$day5_unde = (float)$num;

			        if(empty($day5_unde))
			        {
			        	$day5_unde = 0;
			        }
			      }

			    $query = "SELECT
                          Quantity,
			              SUM(item.Weight)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
                          LEFT JOIN wms_cloud.tbl_items item ON ordi.ItemID = item.ItemID
			              WHERE LEFT(OrderDate, 10) = '$start6' AND CustomerID = $CustomerID AND ordi.ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day6_unde = $rows[0] * $rows[1];
			        $day6_unde = number_format((float)$day6_unde, 2);
			        $day6_unde = str_replace(',', '', $day6_unde);
			        $num = $day6_unde;
					$int = (int)$num;
					$day6_unde = (float)$num;

			        if(empty($day6_unde))
			        {
			        	$day6_unde = 0;
			        }
			      }

			    $query = "SELECT
                          Quantity,
			              SUM(item.Weight)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
                          LEFT JOIN wms_cloud.tbl_items item ON ordi.ItemID = item.ItemID
			              WHERE LEFT(OrderDate, 10) = '$start7' AND CustomerID = $CustomerID AND ordi.ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day7_unde = $rows[0] * $rows[1];
			        $day7_unde = number_format((float)$day7_unde, 2);
			        $day7_unde = str_replace(',', '', $day7_unde);
			        $num = $day7_unde;
					$int = (int)$num;
					$day7_unde = (float)$num;

			        if(empty($day7_unde))
			        {
			        	$day7_unde = 0;
			        }
			      }

			    $query = "SELECT
                          Quantity,
			              SUM(item.Weight)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
                          LEFT JOIN wms_cloud.tbl_items item ON ordi.ItemID = item.ItemID
			              WHERE LEFT(OrderDate, 10) = '$start8' AND CustomerID = $CustomerID AND ordi.ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day8_unde = $rows[0] * $rows[1];
			        $day8_unde = number_format((float)$day8_unde, 2);
			        $day8_unde = str_replace(',', '', $day8_unde);
			        $num = $day8_unde;
					$int = (int)$num;
					$day8_unde = (float)$num;

			        if(empty($day8_unde))
			        {
			        	$day8_unde = 0;
			        }
			      }

			    $query = "SELECT
                          Quantity,
			              SUM(item.Weight)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
                          LEFT JOIN wms_cloud.tbl_items item ON ordi.ItemID = item.ItemID
			              WHERE LEFT(OrderDate, 10) = '$start9' AND CustomerID = $CustomerID AND ordi.ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day9_unde = $rows[0] * $rows[1];
			        $day9_unde = number_format((float)$day9_unde, 2);
			        $day9_unde = str_replace(',', '', $day9_unde);
			        $num = $day9_unde;
					$int = (int)$num;
					$day9_unde = (float)$num;

			        if(empty($day9_unde))
			        {
			        	$day9_unde = 0;
			        }
			      }

			    $query = "SELECT
                          Quantity,
			              SUM(item.Weight)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
                          LEFT JOIN wms_cloud.tbl_items item ON ordi.ItemID = item.ItemID
			              WHERE LEFT(OrderDate, 10) = '$start10' AND CustomerID = $CustomerID AND ordi.ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day10_unde = $rows[0] * $rows[1];
			        $day10_unde = number_format((float)$day10_unde, 2);
			        $day10_unde = str_replace(',', '', $day10_unde);
			        $num = $day10_unde;
					$int = (int)$num;
					$day10_unde = (float)$num;

			        if(empty($day10_unde))
			        {
			        	$day10_unde = 0;
			        }
			      }


			    $query = "SELECT
                          Quantity,
			              SUM(item.Weight)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
                          LEFT JOIN wms_cloud.tbl_items item ON ordi.ItemID = item.ItemID
			              WHERE LEFT(OrderDate, 10) = '$start11' AND CustomerID = $CustomerID AND ordi.ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day11_unde = $rows[0] * $rows[1];
			        $day11_unde = number_format((float)$day11_unde, 2);
			        $day11_unde = str_replace(',', '', $day11_unde);
			        $num = $day11_unde;
					$int = (int)$num;
					$day11_unde = (float)$num;

			        if(empty($day11_unde))
			        {
			        	$day11_unde = 0;
			        }
			      }

			    $query = "SELECT
                          Quantity,
			              SUM(item.Weight)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
                          LEFT JOIN wms_cloud.tbl_items item ON ordi.ItemID = item.ItemID
			              WHERE LEFT(OrderDate, 10) = '$start12' AND CustomerID = $CustomerID AND ordi.ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day12_unde = $rows[0] * $rows[1];
			        $day12_unde = number_format((float)$day12_unde, 2);
			        $day12_unde = str_replace(',', '', $day12_unde);
			        $num = $day12_unde;
					$int = (int)$num;
					$day12_unde = (float)$num;

			        if(empty($day12_unde))
			        {
			        	$day12_unde = 0;
			        }
			      }

			    $query ="SELECT
                          Quantity,
			              SUM(item.Weight)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
                          LEFT JOIN wms_cloud.tbl_items item ON ordi.ItemID = item.ItemID
			              WHERE LEFT(OrderDate, 10) = '$start13' AND CustomerID = $CustomerID AND ordi.ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day13_unde = $rows[0] * $rows[1];
			        $day13_unde = number_format((float)$day13_unde, 2);
			        $day13_unde = str_replace(',', '', $day13_unde);
			        $num = $day13_unde;
					$int = (int)$num;
					$day13_unde = (float)$num;

			        if(empty($day13_unde))
			        {
			        	$day13_unde = 0;
			        }
			      }

			    $query = "SELECT
                          Quantity,
			              SUM(item.Weight)
			              FROM wms_outbound.tbl_ordering ord
			              LEFT JOIN wms_outbound.tbl_orderingitems ordi ON ord.ORD = ordi.ORD
                          LEFT JOIN wms_cloud.tbl_items item ON ordi.ItemID = item.ItemID
			              WHERE LEFT(OrderDate, 10) = '$start14' AND CustomerID = $CustomerID AND ordi.ItemID = $loadSKUandDesc";
			    $result = mysqli_query($conn, $query);

			      while($rows = mysqli_fetch_array($result))
			      {
			        $day14_unde = $rows[0] * $rows[1];
			        $day14_unde = number_format((float)$day14_unde, 2);
			        $day14_unde = str_replace(',', '', $day14_unde);
			        $num = $day14_unde;
					$int = (int)$num;
					$day14_unde = (float)$num;
			        if(empty($day14_unde))
			        {
			        	$day14_unde = 0;
			        }
			      }
			    // Undeliverd

			    $start = date('M d'.','.' Y', strtotime($start));
			    $start1 = date('M d'.','.' Y', strtotime($start1));
			    $start2 = date('M d'.','.' Y', strtotime($start2));
			    $start3 = date('M d'.','.' Y', strtotime($start3));
			    $start4 = date('M d'.','.' Y', strtotime($start4));
			    $start5 = date('M d'.','.' Y', strtotime($start5));
			    $start6 = date('M d'.','.' Y', strtotime($start6));
			    $start7 = date('M d'.','.' Y', strtotime($start7));
			    $start8 = date('M d'.','.' Y', strtotime($start8));
			    $start9 = date('M d'.','.' Y', strtotime($start9));
			    $start10 = date('M d'.','.' Y', strtotime($start10));
			    $start11 = date('M d'.','.' Y', strtotime($start11));
			    $start12 = date('M d'.','.' Y', strtotime($start12));
			    $start13 = date('M d'.','.' Y', strtotime($start13));
			    $start14 = date('M d'.','.' Y', strtotime($start14));

			    $data_date = [$start1, $start2, $start3, $start4, $start5, $start6, $start7, $start8, $start9, $start10, $start11, $start12, $start13, $start14];
			    $delivered = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			    $undelivered = [$day1_unde, $day2_unde, $day3_unde, $day4_unde, $day5_unde, $day6_unde, $day7_unde, $day8_unde, $day9_unde, $day10_unde, $day11_unde, $day12_unde, $day13_unde, $day14_unde];

			    $data[] = array(
					'data1' => $data_date,
					'data2' => $delivered,
					'data3' => $undelivered 
			    );
		
			}

		// Weight
    	echo json_encode($data);
    }

