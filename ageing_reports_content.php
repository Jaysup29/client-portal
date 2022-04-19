
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
            <h3>Ageing Report</h3>
          </div>
          <!-- /.card-header -->

          <div class="d-flex justify-content-center mt-2 ">
            <div class="filter text-center">
              <label>Warehouse:</label>
              <select class="form-control" id="warehouse">
              </select>
            </div>
          </div>
          <div class="d-flex bd-highlight mt-2 justify-content-center align-items-center flex-column flex-sm-row">
            <div class="p-2 bd-highlight">
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="container" value="" onclick="filteredAgeing('container')">
                <label class="form-check-label" for="inlineRadio2">Per CV Number</label>
              </div>
            </div>
            <div class="p-2 bd-highlight">
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="batch" value="" onclick="filteredAgeing('batch')">
                <label class="form-check-label" for="inlineRadio2">Per Batch</label>
              </div>
            </div>
            <div class="p-2 bd-highlight">
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="ref" value="" onclick="filteredAgeing('ref')">
                <label class="form-check-label" for="inlineRadio2">Per Other References</label>
              </div>
            </div>
          </div>
          <div class="d-flex justify-content-center mt-2">
            <div class="filter text-center mx-2">
              <label>Search by Filter:</label>
              <input class="form-control" id="search">
            </div>
          </div>

          <div class="card-body">
            <table id="ageing" class="table table-bordered table-hover">
              <thead>
                <tr>
                  <th>Client SKU</th>
                  <th>Item Description</th>

                  
                  <th>Quantity</th>
                  <th>UOM</th>
                  <th>Weight</th>

                  <th>CV Number</th>
                  <th>Other References</th>
                  <th>Batch/Lot</th>
                  <th>Expiration Date</th>
                  <th>Expiring in Days</th>

                </tr>
              </thead>
              <tbody id="ageing_body">

              </tbody>

              <tfoot>
                <tr>
                  <th></th>
                  <th></th>
                  <th style="color:red; font-weight: bold;">Total</th>
                  <th style="color:red; font-weight: bold;" id="quantity"></th>
                  <th style="color:red; font-weight: bold;" id="weight"></th>
                  <th></th>
                  <th></th>
                  <th></th>
                  <th></th>
                  <th></th>
                </tr>
              </tfoot>

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

  $(function(){
    var filter = $('.form-check-input').val();
    if(filter == '' || filter == null || filter == 0)
    {
      $("#search").prop('disabled', true);
    }
  });

  loadWarehouse();
  Report_GenerateAgeing();

  $("#warehouse").change(function()
    {
      $('#ageing').DataTable().destroy();
      Report_GenerateAgeing();
    });
  
  
  $( '#searchkey' ).keyup(function() 
  {
      var searchkey = $('#searchkey').val();
      searchingAgeing(searchkey);
  });
</script>