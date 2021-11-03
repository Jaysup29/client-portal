
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
            <h3>Stock On Hand Report</h3>
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
                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="container" value="" onclick="filteredSOH('container')">
                <label class="form-check-label" for="inlineRadio1">Per Container</label>
              </div>
            </div>
            <div class="p-2 bd-highlight">
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="item" value="" onclick="filteredSOH('item')">
                <label class="form-check-label" for="inlineRadio1">Per Item</label>
              </div>
            </div>
            <div class="p-2 bd-highlight">
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="batch" value="" onclick="filteredSOH('batch')">
                <label class="form-check-label" for="inlineRadio1">Per Batch</label>
              </div>
            </div>
            <div class="p-2 bd-highlight">
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="status" value="" onclick="filteredSOH('status')">
                <label class="form-check-label" for="inlineRadio1">Per Item Status</label>
              </div>
            </div>
            <div class="p-2 bd-highlight">
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="ref" value="" onclick="filteredSOH('ref')">
                <label class="form-check-label" for="inlineRadio1">Per Other Reference</label>
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
            <table id="soh" class="table table-bordered table-hover">
              <thead>
                <tr>
                  <th style="display:none;">Item ID</th>
                  <th>Client SKU</th>
                  <th>Item Description</th>
                  <th>Quantity</th>
                  <th>Weight</th>
                  <th>UOM</th>
                  <th>ItemStatus</th>
                  <th>Expiry</th>
                  <th>Batch No.</th>
                  <th>Production Date</th>
                  <th>CV Number</th>
                  <th>Other Reference</th>
                  <th>Control Number</th>
                </tr>
              </thead>
              <tbody id="soh_body">

              </tbody>
              <tfoot id="total"><tr>
                <td></td>
                <td></td>
                <td style="color:red; font-weight: bold;">Total</td>
                <td style="color:red; font-weight: bold;"></td>
                <td style="color:red; font-weight: bold;"></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
              </tr></tfoot>
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
    if(filter == '')
    {
      $("#search").prop('disabled', true);
    }
  });

  loadWarehouse();
  Report_GenerateSOH();

  $("#warehouse").change(function()
    {
      $('#soh').DataTable().destroy();
      Report_GenerateSOH();
    });
  
  
  $( '#searchkey' ).keyup(function() 
  {
      var searchkey = $('#searchkey').val();
      searching(searchkey);
  });

</script>