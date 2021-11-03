<?php

  if(!isset($_SESSION["CustomerEmail"]))
  {
    header("location: login.php");
    exit;
  }

?>