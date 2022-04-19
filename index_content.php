<?php 

include 'ageing_dashboard.php';
$CustomerID = $_SESSION['CustomerId'];
$userid = $_SESSION['UserID'];

include 'dbcon.php';

$query = "SELECT role_id FROM tbl_customers_users WHERE id = '$userid'";
$result = mysqli_query($conn, $query);
if(mysqli_num_rows($result) == 1)
{
  while($row = mysqli_fetch_assoc($result))
  {
    $role = $row['role_id'];
  }

  if($role == 0)
  {
    include 'master_userlist_content.php';
  }
  else
  {
    include 'customers_dashboard.php';
  }
}

?>