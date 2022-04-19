<?php
// Initialize the session

include 'dbcon.php';

session_start();
// Destroy the session.
session_destroy();

unset($_SESSION);

// Redirect to login page
header("location: login.php");
exit;


// $userid = $_SESSION['UserID'];
//  echo $userid;
// Unset all of the session variables
// $_SESSION = array();

// $query = "SELECT * FROM wms_clientportal.tbl_users_session WHERE user_id = '$userid' AND session_status = 'active'";
// $result = mysqli_query($conn, $query);
// if(mysqli_num_rows($result) == 1)
// {
//     $query = "UPDATE wms_clientportal.tbl_users_session SET session_stop = NOW(), session_status = 'inactive' WHERE user_id = '$userid'";
//     if(mysqli_query($conn, $query))
//     {   
        // Destroy the session.
        // session_destroy();

        // unset($_SESSION);

        // Redirect to login page
        // header("location: login.php");
        // exit;
//     }
//     else
//     {
//         echo "Erro: " . $query . "<br>" . mysqli_error($conn);
//     }
// }

?>