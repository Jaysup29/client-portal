<?php
  if(!isset($_SESSION['UserID']))
  {
    header("location: login.php");
    exit;
  }

?>