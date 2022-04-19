<?php

include 'auth.php';

?>


<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Client Portal | Dashboard</title>
  <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
  <link rel="stylesheet" href="dist/css/adminlte.min.css">
  <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
  <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
  <link rel="stylesheet" href="dist/fullcalendar/fullcalendar.min.css" />
  <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
  <link rel="stylesheet" href="plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
  <link rel="stylesheet" href="plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
  <link rel="stylesheet" href="dist/css/styles.css">
  <link rel="stylesheet" href="dist/css/select2.min.css"/>
  <link rel="stylesheet" href="node_modules/radioslider/dist/radioslider.min.css">
  <link rel="stylesheet" href="node_modules/bootstrap/dist/css/bootstrap.min.css">


  <script src="plugins/jquery/jquery.min.js"></script>
  <script src="dist/datatables/jquery.dataTables.min.js"></script>
  <script src="node_modules/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
  <script src="dist/js/select2.min.js"></script>
  <script src="node_modules/radioslider/dist/jquery.radioslider.min.js"></script>
  <script src="plugins/moment/moment.min.js"></script>
  <script src="plugins/daterangepicker/daterangepicker.js"></script>
  
  <script src="plugins/chart.js/Chart.min.js"></script>

  <?php
  $currDate = strtotime(date("d-M-Y H:i:s"));
  echo '
    <script src="script.js?v='.$currDate.'"></script>
    ';
  ?>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
      <li class="d-flex align-items-center">
         <img alt="image" src="./dist/img/avatar/avatar-1.png" class="rounded-circle" id="avatar"> 
        <div class="d-sm-none d-lg-inline-block" id="logged_account">Hi, <?php echo $_SESSION['Username']; ?></div>
      </li>
    </ul>
    <ul class="navbar-nav ms-auto mx-3 d-flex align-items-center">
      <li class="nav-item dropdown">
        <a class="nav-link" data-toggle="dropdown" href="#">
          <i class="far fa-bell"></i>
          <span class="badge badge-warning navbar-badge"></span>
        </a>
      </li>
    </ul>
  </nav>
  <aside class="main-sidebar">
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
        <div class="user-panel d-flex justify-content-center align-items-center mb-5">
            <div class="info">
                <p class="d-block my-2">Customer Portal</p>
            </div>
        </div>
      <?php include 'nav.php'?>
    </div>
  </aside>
    
    <div class="content-wrapper">
    <?php 
    if (isset($page_content))
    {
      include($page_content);
    }
    else
    {
      include($page_content);
    }

    include 'toast/toast_success.php';

    include 'modal_load.php';
    include 'modal/modal_pieChartLoadData.php';
    include 'modal/modal_barChartLoadData.php';
    include 'modal/modal_barChartLoadDataInCalendar.php';
    include 'modal/modal_itrdetails.php';
    include 'modal/modal_pending.php';
    include 'modal/modal_onProcess.php';
    include 'modal/modal_confirmation.php';
    include 'modal/modal_receivingEditItemSummary.php';
    include 'modal/modal_removeConfirmation.php';
    include 'modal/modal_approveConfirmation.php';
    include 'modal/modal_createOrder.php';
    include 'modal/modal_orderingPendings.php';
    include 'modal/modal_orderingEditGivenQty.php';
    include 'modal/modal_approveORD.php';
    include 'modal/modal_ORDdetails.php';
    include 'modal/modal_ordRemoveConfirmation.php';
    include 'modal/modal_orderRemoveItemConfirmation.php';
    include 'modal/modal_approveOrderConfirmation.php';
    include 'modal/modal_orderBacktoOpen.php';
    include 'modal/modal_accountaRemoveConfirmation.php';
    include 'modal/modal_accountActivationMessage.php';
    include 'modal/modal_accountRejectionMessage.php';
    include 'modal/modal_createNewItem.php';
    include 'modal/modal_updateInfoConfirmation.php';
    include 'modal/modal_addUserConfirmation.php';
    include 'modal/modal_success_message.php';
    include 'modal/modal_addStoreConfirmation.php';
    include 'modal/modal_removeStoreConfirmation.php';
    include 'modal/modal_forApproval.php';
    include 'modal/modal_resetPasswordConfirmation.php';
    include 'modal/modal_showResettedPassword.php';
    include 'modal/modal_showCPI.php';
    include 'modal/modal_accountDeativationMessage.php';
    include 'modal/modal_importOrderItems.php';
    include 'modal/modal_import_itemnotuploaded.php';
    include 'modal/modal_importReceivingItems.php';
    ?>
  </div>
  <footer class="main-footer">
    <strong>Copyright &copy; 2021-2022.</strong>
    All rights reserved.
  </footer>
  <aside class="control-sidebar control-sidebar-dark">
  </aside>
</div>

<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
<script>
  $.widget.bridge('uibutton', $.ui.button)
</script>
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
<script src="dist/js/adminlte.js"></script>

<script src="dist/datatables/dataTables.buttons.min.js"></script>
<script src="dist/datatables/dataTables.select.min.js"></script>
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
<script src="dist/datatables/jquery.steps.js"></script>

<script src="dist/fullcalendar/fullcalendar.min.js"></script>

</body>
</html>
<script>
  $(document).ready(function(){
  $('[data-toggle="tooltip"]').tooltip();
  setInterval(function () 
  {
    $('[data-toggle="tooltip"]').tooltip('hide'); 
  }, 2000);
});
</script>