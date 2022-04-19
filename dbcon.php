
<?php
	$conn = mysqli_connect('localhost','root','P@55w0rd123','wms_cloud');
	// $conn = mysqli_con nect('localhost','root','P@55w0rd123','wms_cloud');
	// $conn = mysqli_connect('192.168.34.28','root1','P@55w0rd123','wms_cloud');
	// $conn = mysqli_connect("localhost","root","","wms_cloud");
	// $conn = mysqli_connect("localhost","wms","Password123","wms_cloud");
	// $conn = mysqli_connect("localhost","timekeeping","P@ssw0rd@123","wms_cloud");

	date_default_timezone_set('Asia/Manila');

	if (mysqli_connect_errno()) 
	{
	  echo "Failed to connect to MySQL: " . mysqli_connect_error();
	    
	  exit();

	}

?>
