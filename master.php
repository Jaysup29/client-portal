<?php

include 'auth.php';

?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Client Portal | Dashboard</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="dist/css/adminlte.min.css">
  <!-- overlayScrollbars -->
  <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
  <!-- Daterange picker -->
  <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
  <link rel="stylesheet" href="dist/fullcalendar/fullcalendar.min.css" />
  <!-- DataTables -->
  <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
  <link rel="stylesheet" href="plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
  <link rel="stylesheet" href="plugins/datatables-buttons/css/buttons.bootstrap4.min.css">

  <link rel="stylesheet" href="dist/css/styles.css">

  <!-- Select 2 -->
  <link rel="stylesheet" href="dist/css/select2.min.css"/>
  <link rel="stylesheet" href="node_modules/radioslider/dist/radioslider.min.css">

  <!-- toast -->
  <!-- <link href="toastr/build/toastr.min.css" rel="stylesheet">
  <script src="toastr/build/toastr.min.js"></script> -->

  <script src="plugins/jquery/jquery.min.js"></script>
  <script src="dist/js/select2.min.js"></script>
  <script src="node_modules/radioslider/dist/jquery.radioslider.min.js"></script>
    <!-- daterangepicker -->
  <script src="plugins/moment/moment.min.js"></script>
  <script src="plugins/daterangepicker/daterangepicker.js"></script>
  <!-- Tempusdominus Bootstrap 4 -->

  <?php
  $currDate = strtotime(date("d-M-Y H:i:s"));
  echo '
    <script src="script.js?v='.$currDate.'"></script>
    ';
  ?>

</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

  <!-- Preloader -->
<!--
  <div class="preloader flex-column justify-content-center align-items-center">
    <img class="animation__shake" src="dist/img/AdminLTELogo.png" alt="AdminLTELogo" height="60" width="60">
  </div>
-->

  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
      <li class="d-flex align-items-center">
         <img alt="image" src="./dist/img/avatar/avatar-1.png" class="rounded-circle" id="avatar"> 
        <div class="d-sm-none d-lg-inline-block" id="logged_account">Hi, <?php echo $_SESSION['CompanyName']; ?></div>
      </li>
    </ul>

    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto mx-3 d-flex align-items-center">
      
      <!-- Notifications Dropdown Menu -->
      <li class="nav-item dropdown">
        <a class="nav-link" data-toggle="dropdown" href="#">
          <i class="far fa-bell"></i>
          <span class="badge badge-warning navbar-badge"></span>
        </a>
      </li>
      <li class="nav-item">
        <div class="theme-switch-wrapper nav-item">
            <label class="theme-switch m-0" for="checkbox">
                <input type="checkbox" id="checkbox" />
                <div class="slider round"></div>
          </label>
        </div>
      </li>
<!--
      <li class="dropdown d-flex align-items-center"><a href="#" data-toggle="dropdown" class="nav-link dropdown-toggle nav-link-lg nav-link-user">
         <img alt="image" src="./dist/img/avatar/avatar-1.png" class="rounded-circle" id="avatar"> 
        <div class="d-sm-none d-lg-inline-block" id="logged_account">Hi, <?php echo $_SESSION['CompanyName']; ?></div></a>
        <div class="dropdown-menu dropdown-menu-right">
          <a href="#" onclick="changepasswordmodal()" class="dropdown-item has-icon">
            <i class="fas fa-user"></i> Change Password
          </a>
          <a href="logout.php" class="dropdown-item has-icon text-danger">
            <i class="fas fa-sign-out-alt"></i> Logout
          </a>
        </div>
      </li>
-->
    </ul>
  </nav>
  <!-- /.navbar -->

  <!-- Main Sidebar Container -->
  <aside class="main-sidebar">
    <!-- Brand Logo -->
<!--
    <div class="user-panel mt-1 mb-3 border border-primary">
        <a href="#" class="brand-link">
        <img src="dist/img/gililogo.jpg" alt="AdminLTE Logo" class="brand-image img-circle" style="opacity: .8">
        <span class="brand-text">Client Portal</span>
        </a>
    </div>
-->
    
    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
        <div class="user-panel d-flex justify-content-center align-items-center mb-5">
            <div class="info">
                <p class="d-block my-2">Client Portal</p>
            </div>
        </div>

      <!-- Sidebar Menu -->
      <?php include 'nav.php'?>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>
    
    <div class="content-wrapper">
    <!-- /.content-header -->

    <!-- Main content -->
    <?php 
    // isset($page_content)?include($page_content):'index_content.php';
    if (isset($page_content))
    {
      include($page_content);
    }
    else
    {
      include($page_content);
    }
    include 'modal_load.php';
    include 'modal/modal_pieChartLoadData.php';
    include 'modal/modal_barChartLoadData.php';
    include 'modal/modal_barChartLoadDataInCalendar.php';
    include 'modal/modal_itrdetails.php';
    include 'modal/modal_pending.php';
    include 'modal/modal_confirmation.php';
    include 'modal/modal_receivingEditItemSummary.php';
    include 'modal/modal_removeConfirmation.php';
    ?>
    <!-- /.content -->
  </div>
  <footer class="main-footer">
    <strong>Copyright &copy; 2021-2022.</strong>
    All rights reserved.
  </footer>
  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->



<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button)
</script>
<!-- Bootstrap 4 -->
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- ChartJS -->
<script src="plugins/chart.js/Chart.min.js"></script>
<!--  -->
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@0.7.0"></script>
<!-- jQuery Knob Chart -->



<!-- Summernote -->

<!-- overlayScrollbars -->
<script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/adminlte.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="dist/datatables/jquery.dataTables.min.js"></script>
<script src="dist/datatables/dataTables.buttons.min.js"></script>
<script src="dist/datatables/dataTables.select.min.js"></script>
<!-- <script src="dist/datatables/dataTables.editor.min.js"></script> -->
<script src="dist/datatables/dataTables.dateTime.min.js"></script>
<script src="dist/datatables/buttons.html5.min.js"></script>
<script src="dist/datatables/stringMonthYear.js"></script>
<script src="dist/datatables/datetime-moment.js" type="text/javascript"></script>
<script src="dist/datatables/sum().js" type="text/javascript"></script>
<script src="dist/datatables/dataTables.responsive.min.js" type="text/javascript"></script>
<script src="dist/datatables/jszip.min.js" type="text/javascript"></script>
<script src="dist/datatables/buttons.colVis.min.js" type="text/javascript"></script>
<script src="dist/datatables/pdfmake.min.js" type="text/javascript"></script>
<script src="dist/datatables/vfs_fonts.js" type="text/javascript"></script>

<script src="dist/fullcalendar/fullcalendar.min.js"></script>

</body>
</html>
