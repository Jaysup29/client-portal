<?php 

include 'ageing_dashboard.php';
$CustomerID = $_SESSION['CustomerId'];

?>
<style type="text/css">
.select2-container--default .select2-selection--single{
  height: 37px;
}

</style>
<link rel="stylesheet" href="dist/css/styles2.css">
<div class="container-fluid p-2">
  <div class="bg-white rounded shadow-sm">
    <h4 class="p-2">Dashboard</h4>
  </div>
  <div class="row mb-2">
    <div class="col">
      <div class="bg-white p-2 rounded shadow-sm">
        <div class="menu-chart">
          <div class="row d-flex align-items-end">
            <div class="col-lg-3 col-md-6 col-sm-12">
              <select class="form-control change-graph">
                <option value='0' disabled selected>Click To Select Your Data</option>
                <option>Total SO</option>
                <option>Total Quantity</option>
                <option>Total Weight</option>
              </select>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-12">
              <div class="row px-2 d-flex justify-content-start justify-content-md-center">
                  <strong class="pt-2">Filter By:</strong>
              </div>
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
              <label class="m-0 mt-1">Search By Filter:</label>
              <select id="loadSKUandDesc" class="form-control">
                <option disabled="" value="0" selected="">Please Select From Filter</option>
              </select>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-12">
              <label class="m-0 mt-1">Date Range:</label>
              <div id="picker" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc; width: 100%">
                <i class="fa fa-calendar"></i>&nbsp;
                <span class="date" id="date"></span> <i class="fa fa-caret-down"></i>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-lg-6 col-md-12 col-sm-12 mb-md-2" id="Received">
      <div class="bg-white p-2 rounded shadow-sm mb-1 d-flex align-items-center" id="Received_Bar_G">
        <h4 class="m-0 fw-bold">Received Summary</h4>
      </div>
      <div class="bg-white p-2 rounded shadow-sm mb-2">
        <div class="chart">
          <canvas id="barChart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%;"></canvas>
        </div>
      </div>
      <div class="bg-white p-2 rounded shadow-sm">
        <table class="table table-bordered m-0" id="dashboard_table">
          <thead class="text-center">
            <th></th>
            <th>January</th>
            <th>February</th>
            <th>March</th>
            <th>April</th>
            <th>May</th>
            <th>June</th>
            <th>July</th>
            <th>August</th>
            <th>September</th>
            <th>October</th>
            <th>November</th>
            <th>December</th>
            <th style="color: red;">Total</th>
          </thead>
          <tbody id="rec-body" class="text-center">
            <tr>
              <td><span style="color: #A2C7FF">&#9632</span>Planned</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td style="color: red; font-weight:bold;">600.00</td>
            </tr>

            <tr>
              <td><span style="color: #6C5EFF">&#9632</span>Received</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td style="color: red; font-weight:bold;">600.00</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <div class="col-lg-6 col-md-12 col-sm-12">
      <div class="bg-white p-2 rounded shadow-sm mb-1" id="Order_Bar_G">
        <h4 class="m-0">Order Summary</h4>
      </div>
      <div class="bg-white p-2 rounded shadow-sm mb-2">
        <div class="chart">
          <canvas id="barChart1" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%;"></canvas>
        </div>
      </div>
      <div class="bg-white p-2 rounded shadow-sm">
        <table class="table table-bordered m-0" id="dashboard_table">
          <thead class="text-center">
            <th></th>
            <th>January</th>
            <th>February</th>
            <th>March</th>
            <th>April</th>
            <th>May</th>
            <th>June</th>
            <th>July</th>
            <th>August</th>
            <th>September</th>
            <th>October</th>
            <th>November</th>
            <th>December</th>
            <th style="color: red; width:2%">Total</th>
          </thead>
          <tbody id="rec-body" class="text-center">
            <tr>
              <td><span style="color: #9DFFAC">&#9632</span>Delivered</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td style="color: red; font-weight:bold;">600.00</td>
            </tr>

            <tr>
              <td><span style="color: #FF5E5E">&#9632</span>Undelivered</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td>50</td>
              <td style="color: red; font-weight:bold;">600.00</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <div class="row" id="ageing">
   <div class="col-lg-6 col-md-12 col-sm-12">
    <div class="bg-white p-2 rounded shadow-sm mb-1 d-flex align-items-center">
      <h4 class="m-0 fw-bold">Ageing Summary</h4>
    </div>
    <div class="bg-white p-2 rounded shadow-sm">
      <div class="chart">
        <canvas id="pieChart" style="min-height: 320px; height: 320px; max-height: 320px; max-width: 100%;"></canvas>

      </div>
    </div>
    <div class="bg-white p-2 rounded shadow-sm mb-1 d-flex flex-column">

      <table class="table table-bordered">
        <thead>
          <tr>
            <th>Expired</th>
            <th>Less Than 2 Months</th>
            <th>Less Than 4 Months</th>
            <th>Less Than 6 Months</th>
            <th>More Than 6 Months</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td id="exp"><?php echo $expired ?></td>
            <td id="lessTwo"><?php echo $lTwo ?></td>
            <td id="lessFour"><?php echo $lFour ?></td>
            <td id="lessSix"><?php echo $lSix ?></td>
            <td id="moreSix"><?php echo $mSix ?></td>
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
      <table class="table table-striped">
        <thead>
          <tr>
            <th>Room Types</th>
            <th>Pallet Utilization</th>
          </tr>
        </thead>
        <tbody>
          <?php 
            include 'dbcon.php';

            $query = "SELECT
                        IFNULL(rt.type, 'Unassigned'),
                        COUNT(DISTINCT ri.PalletID)
                      FROM wms_inbound.tbl_receivingitems ri
                      LEFT JOIN wms_inbound.tbl_pallets pal on ri.PalletID = pal.PalletID
                      LEFT JOIN wms_inbound.tbl_locations loc on pal.LocationID = loc.LocationID
                      LEFT JOIN wms_inbound.tbl_room room on loc.RoomCode = room.RoomCode
                      LEFT JOIN wms_cloud.tbl_roomtypes rt on room.RoomTypeID = rt.id
                      WHERE ri.Quantity > 0 AND ri.CustomerID = $CustomerID
                      GROUP BY rt.id";

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
</div>

</div>
<script>



</script>


<script>
  var restart = 0;
  var reend = 0;
  $(document).ready(function() {
    $('#loadSKUandDesc').select2();

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
  // include 'script_order_summary.php';
  // include 'script_received_summary.php';
include 'script_piechart_ageing.php';
include 'script_daterange.php';
?>

