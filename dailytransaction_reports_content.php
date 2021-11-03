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
            <h3>Daily Transactions Report</h3>
          </div>
          <!-- /.card-header -->
          <div class="card-body">
            <div class="d-flex justify-content-center mt-2 mb-2">
              <div class="filter text-center">
                <label>Filter by DateRange:</label>
                <input type="text" name="daterange" class="form-control" id="dir_dates">
              </div>
            </div>
            <div class="row mb-2">
              <div class="col d-flex justify-content-center">
                <button class="btn btn-primary" id="generate">Generate</button>
              </div>
            </div>
            <table id="DTR" class="table table-bordered table-hover">
              <thead>
                <th>Date</th>
                <th>Control #</th>
                <th>JO #</th>
                <th>SKU</th>
                <th>Description</th>
                <th>Quantity</th>
                <th>Weight</th>
                <th>Container</th>
                <th>Remarks</th>
              </thead>
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

<div class="d-flex justify-content-center">
  <div class="spinner-border" role="status">
    <span class="sr-only">Loading...</span>
  </div>
</div>
<script>
  Report_GenerateDTR();
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
  $("#generate").click(function () {
    $('#DTR').DataTable().destroy();
    Report_GenerateDTR();
    $('#DTR').DataTable().destroy();
  })
</script>
