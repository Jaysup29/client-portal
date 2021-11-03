    
<style type="text/css">
.select2-container--default .select2-selection--single{
  padding:6px;
  height: 37px;
  font-size: 1.2em;
}

table {
  border-collapse: collapse;
  border-spacing: 0;
  width: 100%;
  border: 1px solid #ddd;
}

th, td {
  text-align: left;
  padding: 8px;
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
            <h3>Goods Movement Report</h3>
          </div>
          <!-- /.card-header -->
          <div class="card-body">
            <div class="row mb-2">
              <div class="col d-flex justify-content-center">
                <select id="loadItem" class="col-md-3">
                </select>
              </div>
            </div>

            <div class="row mb-2">
              <div class="col d-flex justify-content-center">
                <select id="subfilter" class="col-md-3">
                  <option>Please Select From Sub Filter</option>
                </select>
              </div>
            </div>

            <div class="row mb-2">
              <div class="col d-flex justify-content-center">
                <select id="subfilter2" class="col-md-3">
                  <option>Please Select From Sub Filter</option>
                </select>
              </div>
            </div>

            <div class="row mb-2">
              <div class="col d-flex justify-content-center">
                <input type="text" name="daterange" class="form-control col-md-3" id="dir_dates">
              </div>
            </div>

            <div class="row mb-2">
              <div class="col d-flex justify-content-center">
                <button class="btn btn-primary" onclick="Report_GenerateGM()">Generate</button>
              </div>
            </div>
            <div style="overflow-x:auto;">
              <table class="table table-bordered table-striped table-sm" id="GM_table">
                <tr>

                 <td colspan="2">Inbound</td>
                 <td colspan="6">Outbound</td>

               </tr>

               <tr>
                 <td>Quantity</td>
                 <td>Weight</td>
                 <td>Quantity</td>
                 <td>Weight</td>
                 <td>Control Number</td>
                 <td>Batch</td>
                 <td>Other Reference</td>
                 <td>Date</td>
               </tr>
             </table>
          </div>
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

  $(document).ready(function() {
    $('#loadItem').select2();
    $('#subfilter').select2();
    $('#subfilter2').select2();
  });

  loadItem();
  loadSubfilterGM();
  loadSubfilter2GM();

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