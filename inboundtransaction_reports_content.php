
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

<div class="bg-white rounded shadow-sm mx-3">
    <h4 class="p-2">Reports</h4>
</div>

<?php include 'reports_menu.php' ?>
<input type="text" class="cus_id" id="cus_id" value="<?php echo $_SESSION['CustomerId']; ?>">
<section class="content">
  <div class="container-fluid">
    <div class="row">
      <div class="col-12">
        <div class="card bg-white">
          <div class="card-header">
            <h3>Inbound Transaction Report</h3>
          </div>
          <!-- /.card-header -->

          <div class="d-flex justify-content-center mt-2">
            <div class="filter text-center">
              <label>Warehouse:</label>
              <select class="form-control" id="warehouse">
              </select>
            </div>
          </div>
          <div class="d-flex bd-highlight mt-2 justify-content-center align-items-center flex-column flex-sm-row">
            <div class="p-2 bd-highlight">
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="controlno" value="" onclick="filteredITR('IBN')">
                <label class="form-check-label" for="inlineRadio1">Per Control Number</label>
              </div>

              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="container" value="" onclick="filteredITR('Container')">
                <label class="form-check-label" for="inlineRadio1">Per CV Number</label>
              </div>

              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="status" value="" onclick="filteredITR('StatusID')">
                <label class="form-check-label" for="inlineRadio1">Per Status</label>
              </div>
            </div>
          </div>
          <div class="d-flex justify-content-center mt-2">
            <div class="filter text-center mx-2">
              <label>Search by Filter:</label>
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
              <button class="btn btn-primary" onclick="Report_GenerateITR()">Generate</button>
            </div>
          </div>
          
          <div class="card-body">
            <table id="itr" class="table table-bordered table-hover">
              <thead>

                <tr>
                    <th colspan="3"></th>
                    <th colspan="3" style="text-align:center;">ITEM STATUS</th>
                    <th colspan="7"></th>
                </tr>

                <tr>
                   <th>Date</th>
                   <th>CPI</th>

                   <th>GOOD</th>
                   <th>HOLD</th>
                   <th>BLOCK</th>
                   <th>Quantity</th>
                   <th>Weight</th>

                   <th>CV Number</th>

                   <th>Status</th>
                   <th>Remarks</th>
                   <th>Action</th>

                </tr>
              </thead>
              <tbody id="itr_body">

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
<!-- 
<div class="d-flex justify-content-center">
  <div class="spinner-border" role="status">
    <span class="sr-only">Loading...</span>
  </div>
</div>
 -->

<script>

  $(function(){
    var filter = $('.form-check-input').val();
    if(filter == '')
    {
      $("#search").prop('disabled', true);
    }
  });

  loadWarehouse();


  // $("#warehouse").change(function()
  //   {
  //     $('#itr').DataTable().destroy();
  //     Report_GenerateITR();
  //   });
  
  
  // $( '#search' ).keyup(function() 
  // {
  //     var searchkey = $('#search').val();
  //     searchingITR(searchkey);
  // });

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

