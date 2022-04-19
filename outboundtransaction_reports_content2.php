<style type="text/css">
  .red {
      background-color: red !important;
    }

</style>
<!-- Content Header (Page header) -->
<section class="content-header pt-1 pb-2">
  <div class="container-fluid">
    <div class="row">
      <div class="col">
        <ol class="breadcrumb float-sm-right">
          <li class="breadcrumb-item"><a href="#">Home</a></li>
          <li class="breadcrumb-item active">Reports</li>
        </ol>
      </div>
    </div>
  </div><!-- /.container-fluid -->
</section>

<div class="col-12">
  <div class="card bg-white">
    <div class="card-header">
      <h3>Reports</h3>
    </div>
  </div>
</div>

<?php include 'reports_menu.php' ?>
<input type="text" class="cus_id" id="cus_id" value="<?php echo $_SESSION['CustomerId']; ?>">
<section class="content">
  <div class="container-fluid">
    <div class="row">
      <div class="col-12">
        <div class="card bg-white">
          <div class="card-header">
            <h3>Outbound Transaction Report</h3>
          </div>
          <!-- /.card-header -->

          <div class="d-flex justify-content-center mt-2">
            <div class="filter text-center">
              <label>Warehouse:</label>
              <select class="form-control" id="warehouse">
              </select>
            </div>
          </div>
          <div class="d-flex bd-highlight mt-2 justify-content-center align-items-center flex-column flex-sm-row" style="display: none;">
            <div class="p-2 bd-highlight"  style="display: none;">
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="controlno" value="" onclick="filteredDOR('IBN')">
                <label class="form-check-label" for="inlineRadio1">Per Control Number</label>
              </div>

              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="container" value="" onclick="filteredDOR('Container')">
                <label class="form-check-label" for="inlineRadio1">Per CV Number</label>
              </div>

              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="status" value="" onclick="filteredDOR('StatusID')">
                <label class="form-check-label" for="inlineRadio1">Per Status</label>
              </div>
            </div>
          </div>
          <div class="d-flex justify-content-center mt-2" >
            <div class="filter text-center mx-2" style="display: none;">
              <label >Search by Filter:</label>
              <input class="form-control" id="search">
            </div>
          </div>

          <div class="d-flex justify-content-center mt-2">
            <div class="row">
                  <?php
                      date_default_timezone_set("Asia/Manila");
                      $date = date('d-M-Y');
                  ?>
                  <div class="col-6">
                      <label>From</label>
                      <input type="date" id="datefrom" class="form-control">
                  </div>
                  
                  <div class="col-6">
                      <label>To</label>
                      <input type="date" id="dateto" class="form-control">
                  </div>
              </div>
          </div>

          <div class="d-flex justify-content-center mt-2">
            <div class="filter text-center mx-2">
              <button class="btn btn-primary" onclick="Report_GenerateDOR2()">Generate</button>
            </div>
          </div>
   
          <div class="card-body">
            <table id="dor2" class="table table-bordered table-hover">
              <thead>
                <tr>
                  <th style="border: 1px solid black;">Date</th>
                   <!-- <th style="border: 1px solid black;">Control Number</th> -->
                   <th style="border: 1px solid black;">CPO</th>
                  <!-- <th style="border: 1px solid black;">JO Number</th> -->
                  <th style="border: 1px solid black;">Quantity</th>
                  <th style="border: 1px solid black;">Weight</th>
                  <th style="border: 1px solid black;">CV Number</th>
                  <!-- <th style="border: 1px solid black;">Checker Assigned</th> -->
                  <th style="border: 1px solid black;">Status</th>
                  <th style="border: 1px solid black;">Remarks</th>

                </tr>
              </thead>
              <tbody id="dor_body">

              </tbody>

            </table>
          </div>
          <!-- /.card-body -->
        </div>
        <!-- /.card -->
        <!-- /.card -->
      </div>
      <!-- /.col -->
    </div>
    <!-- /.row -->
  </div>
  <!-- /.container-fluid -->
</section>

<script>

  $(function(){
    var filter = $('.form-check-input').val();
    if(filter == '')
    {
      $("#search").prop('disabled', true);
    }
  });

  loadWarehouse();

    $(function()
    {
      $('input[name="daterange"]').daterangepicker({
        timePicker: true,
        startDate: moment().startOf('hour'),
        endDate: moment().startOf('hour').add(32, 'hour'),
        locale: {
          format: 'YYYY-MM-DD'
        }
      });
      
    });

</script>

