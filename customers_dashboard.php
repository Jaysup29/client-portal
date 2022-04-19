<?php 

  $userid = $_SESSION['UserID'];
  $CustomerID = $_SESSION['CustomerId'];

  // echo $CustomerID;

  $query = "SELECT role_id FROM wms_cloud.tbl_customers_users WHERE id = '$userid'";
  $result = mysqli_query($conn, $query);
  if(mysqli_num_rows($result) == 1)
  {
    while($row = mysqli_fetch_assoc($result))
    {
      $roleid = $row['role_id'];
    }

    if($roleid == 0)
    {
      echo 'Vemspm';
    }
    else
    {

      $query = "SELECT CommonCode FROM tbl_customers_users WHERE id = '$userid'";
      $result = mysqli_query($conn, $query);
      while($row = mysqli_fetch_assoc($result))
      {
        $commoncode = $row['CommonCode'];
      }

      $query = "SELECT CustomerID FROM tbl_customers WHERE CustomerCommonCode = '$commoncode'";
      $result = mysqli_query($conn, $query);
      if(mysqli_num_rows($result) == 1)
      {
        while($row = mysqli_fetch_assoc($result))
        {
          $CustomerID = $row['CustomerID'];
        }

        $lessThree = date('Y-m-d', strtotime('+3 months'));
        $lessSix = date('Y-m-d', strtotime('+6 months'));
      
        include 'dbcon.php';
        $query = "CALL wms_reports.SP_Ageing_Dashboard($CustomerID)";
        $result = mysqli_query($conn, $query);

        // echo $query;
        while($rows = mysqli_fetch_array($result))
        {
            $expired = $rows[0];
            $lThree = $rows[1];
            $lSix = $rows[2];
            $mSix = $rows[3];
            $noexpiry = $rows[4];
        } 
      
      }
    }
  }

?>

<style type="text/css">
.select2-container--default .select2-selection--single{
  height: 37px;
}


.my-custom-scrollbar {
position: relative;
height: 300px;
overflow: auto;
}
.table-wrapper-scroll-y {
display: block;
}

.my-custom-scrollbar-pallet {
position: relative;
height: 165px;
overflow: auto;
}
.table-wrapper-scroll-y-pallet {
display: block;
}
</style>
<link rel="stylesheet" href="dist/css/styles2.css">
<div class="container-fluid p-2">
  <div class="bg-white rounded shadow-sm">
    <h4 class="p-2">Dashboard</h4>
  </div>
  <input type="text" class="cus_id" id="cus_id" value="<?php echo $CustomerID; ?>">
  <div class="row mb-2">
    <div class="col">
      <div class="bg-white p-2 rounded shadow-sm">
        <div class="menu-chart">
          <div class="row d-flex align-items-end">
            <div class="col-lg-3 col-md-6 col-sm-12">
              <div class="row px-2 d-flex justify-content-start justify-content-md-center">
                  <strong class="pt-2">Filter By:</strong>
              </div>
              <select class="form-control change-graph">
                <option value='0' disabled selected>Click To Select Your Data</option>
                <!-- <option value="Total Quantity">Total SO</option> -->
                <option value="Total Quantity">Total Quantity</option>
                <option value="Total Weight">Total Weight</option>
              </select>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-12">
              
              <div class="row py-1">
                  <div class="col-lg-6 col-md-6 col-sm-6 d-flex justify-content-center">
                      <div class="form-check">
                        <input class="form-check-input" type="radio" name="flexRadioDefault" id="filterBySKUNo" onclick="filterBySKU('filterBySKUNo')">
                        <label class="form-check-label text-nowrap"  for="filterBySKUNo">SKU No</label>
                      </div>
                  </div>
                  <div class="col-lg-6 col-md-6 col-sm-6 d-flex justify-content-center">
                      <div class="form-check">
                        <input class="form-check-input" type="radio" name="flexRadioDefault" id="filterBySKUDesc" onclick="filterBySKU('filterBySKUDesc')">
                        <label class="form-check-label text-nowrap" for="filterBySKUDesc">SKU Description</label>
                      </div>
                  </div>
              </div>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-12">
              <label class="m-0 mt-1"></label>
              <select id="loadSKUandDesc" class="form-control">
                <option disabled="" value="0" selected="">Please Select From Filter</option>
              </select>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-lg-6 col-md-12 col-sm-12 mb-md-2" id="Received">
      <div class="bg-white p-2 rounded shadow-sm mb-1 d-flex align-items-center" id="Received_Bar_G">
        <h4 class="m-0 fw-bold">Inbound Transaction Summary</h4>
      </div>
      <div class="bg-white p-2 rounded shadow-sm mb-2">
        <div class="chart">
          <canvas id="barChart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%;"></canvas>
        </div>
      </div>
    </div>
    <div class="col-lg-6 col-md-12 col-sm-12">
      <div class="bg-white p-2 rounded shadow-sm mb-1" id="Order_Bar_G">
        <h4 class="m-0 fw-bold">Outbound Transaction Summary</h4>
      </div>
      <div class="bg-white p-2 rounded shadow-sm mb-2">
        <div class="chart">
          <canvas id="barChart1" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%;"></canvas>
        </div>
      </div>
    </div>
  </div>

  <div id="messages"></div>
  <div class="row" id="ageing">
   <div class="col-lg-6 col-md-12 col-sm-12">
    <div class="bg-white p-2 rounded shadow-sm mb-1 d-flex justify-content-between align-items-center">
      <div>
        <h4 class="m-0 fw-bold">Ageing Summary</h4>
      </div>
      <!-- <div>
        <label class="m-0 mt-1">Date Range:</label>
        <div id="picker" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc; width: 100%">
          <i class="fa fa-calendar"></i>&nbsp;
          <span class="date" id="date"></span> <i class="fa fa-caret-down"></i>
        </div>
      </div> -->
    </div>

    <div class="bg-white p-2 rounded shadow-sm">
      <div class="chart">
        <canvas id="pieChart" style="min-height: 320px; height: 320px; max-height: 320px; max-width: 100%;"></canvas>
      </div>
    </div>
    <div class="bg-white p-2 rounded shadow-sm mb-1 d-flex flex-column">

      <table class="table table-bordered table-hover">
        <thead>
          <tr>
            <th></th>
            <th style="width:15%"></strong><span style="color: #e60000">&#9632</span> Expired </th>
            <th style="width:15%"></strong><span style="color: #f39c12;">&#9632</span> Less Than <br>3 Months</th>
            <th style="width:30%"></strong><span style="color: #00c0ef;">&#9632</span> More Than 3 Months <br>But Less Than 6 Months</th>
            <th style="width:20%"></strong><span style="color: #3c8dbc;">&#9632</span> More Than <br>6 Months</th>
            <th style="width:20%"></strong><span style="color: #00a65a;">&#9632</span> No Expiry</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td id="" style="font-weight: bold;">Value</td>
            <td id="exp"><?php echo number_format($expired) ?></td>
            <td id="lessTwo"><?php echo number_format($lThree) ?></td>
            <td id="lessFour"><?php echo number_format($lSix) ?></td>
            <td id="lessSix"><?php echo number_format($mSix) ?></td>
            <td id="moreSix"><?php echo number_format($noexpiry) ?></td>
          </tr>

          <?php  

            $percentage = 0;
            $percentage = $expired + $lThree + $lSix + $mSix + $noexpiry;

          ?>
          <tr>
            <td id="" style="font-weight: bold;">Percentage</td>
            <td id="exp_per"><?php echo number_format($expired/$percentage*100, 2) . '%' ?></td>
            <td id="lessTwo_per"><?php echo number_format($lThree/$percentage*100, 2) . '%' ?></td>
            <td id="lessFour_per"><?php echo number_format($lSix/$percentage*100, 2) . '%' ?></td>
            <td id="lessSix_per"><?php echo number_format($mSix/$percentage*100, 2) . '%' ?></td>
            <td id="moreSix_per"><?php echo number_format($noexpiry/$percentage*100, 2) . '%' ?></td>
          </tr>
        </tbody>
      </table>

    </div>
  </div>

  <div class="col-lg-6 col-md-12 col-sm-12">
    <div class="bg-white p-2 rounded shadow-sm mb-1 d-flex align-items-center">
      <h4 class="m-0 fw-bold">Pallet Utilization</h4>
    </div>
    <div class="bg-white p-2 rounded shadow-sm">
      <div class="table-wrapper-scroll-y-pallet my-custom-scrollbar-pallet">

       <table class="table table-striped">
        <thead>
          <tr>
            <th>Room Types</th>
            <th>Number of Pallets Occupied</th>
          </tr>
        </thead>
        <tbody>
          <?php 
            include 'dbcon.php';

            $query = "call wms_reports.sp_cp_palletutilization($CustomerID);";
            // echo $query;
            $result = mysqli_query($conn, $query);
           
            while ($rows = mysqli_fetch_array($result)) {

              echo '
                <tr>
                   <td>'.$rows[0].'</td>
                   <td>'.$rows[1].'</td>
                </tr>
              ';
            }

           ?>
        </tbody>
      </table>

      </div>
    </div>

    <div class="bg-white p-2 rounded shadow-sm mb-1 d-flex align-items-center mt-2">
      <h4 class="m-0 fw-bold">Non-Conforming Products</h4>
    </div>
    <div class="bg-white p-2 rounded shadow-sm">
      <div class="table-wrapper-scroll-y my-custom-scrollbar">

        <table class="table table-bordered table-striped mb-0">
          <thead>
            <tr>
              <th scope="col">Item Description</th>
              <th scope="col">Quantity</th>
              <th scope="col">UOM</th>
              <th scope="col">Weight</th>
              <th scope="col">Item Remarks</th>
            </tr>
          </thead>
          <tbody>
            <?php 
              include 'dbcon.php';
              $query = "call wms_reports.sp_nonconformingproducts($CustomerID);";

              $result = mysqli_query($conn, $query);
              $sumquantity = 0;
              $sumweight = 0; 
              
              while ($rows = mysqli_fetch_array($result)) {
        
                $sumquantity += $rows[1];
                $sumweight += $rows[3];
                echo '
                  <tr>
                     <td>'.$rows[0].'</td>
                     <td>'.number_format($rows[1]).'</td>
                     <td>'.$rows[2].'</td>
                     <td>'.number_format($rows[3], 2).'</td>
                     <td>'.$rows[4].'</td>
                  </tr>
                ';
                
              }

              echo '
                <tr>
                  <td style="color:red">Total</td>
                  <td style="color:red">'.number_format($sumquantity).'</td>
                  <td></td>
                  <td style="color:red">'.number_format($sumweight, 2).'</td>
                  <td></td>
                </tr>
              ';

             ?>
          </tbody>
        </table>

      </div>
    </div>

  </div>
</div>
</div>
<script>



</script>


<script>
  var restart = 0;
  var reend = 0;
  $(document).ready(function() {
    $('#loadSKUandDesc').select2();

    var users = $('#cus_id').val();


    console.log(users)

  });
  
  $(function(){

    var filter = $('.form-check-input').val();
    if(filter == '' || filter == null || filter == 0)
    {
      // $("#searchSKU").prop('disabled', true);
    }
  });

    // loadSKUNo();
    // loadSKUDesc();
    // loadSKUandDesc();

    $(function(){
      var filter = $('.change-graph').val();
      if(filter == '' || filter == null || filter == 0)
      {
      // $("#searchSKUNo").prop('disabled', true);
      // $("#searchSKUDesc").prop('disabled', true);
    }
  });
</script>

<?php 
  include 'script_piechart_ageing.php';
  include 'script_daterange.php';
?>

