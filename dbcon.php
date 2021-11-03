
<?php
	$conn = mysqli_connect("127.0.0.1","root","","wms_cloud");
	// $conn = mysqli_connect("localhost","wms","Password123","wms_cloud");
	// $conn = mysqli_connect("localhost","timekeeping","P@ssw0rd@123","wms_cloud");

	date_default_timezone_set('Asia/Manila');

	if (mysqli_connect_errno()) 
	{
	  echo "Failed to connect to MySQL: " . mysqli_connect_error();
	    
	  exit();

	}

?>
