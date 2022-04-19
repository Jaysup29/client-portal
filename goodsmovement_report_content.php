    
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

            <div class="row mb-2 d-none">
              <div class="col d-flex justify-content-center">
                <select id="subfilter" class="col-md-3">
                  <option>Please Select From Sub Filter</option>
                   <option value="">None</option>
                    <option value="1">CV Number</option>
                    <option value="2">Batch</option>
                    <option value="3">Expiry</option>
                    <option value="4">Other References</option>
                </select>
              </div>
            </div>

            <div class="row mb-2 d-none">
              <div class="col d-flex justify-content-center">
                <select id="subfilter2" class="col-md-3">
                  <option>Please Select From Sub Filter</option>
                </select>
              </div>
            </div>

            <div class="row mb-2">
              <div class="col d-flex justify-content-center">
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
            </div>

            <div class="row mb-2">
              <div class="col d-flex justify-content-center">
                <button class="btn btn-primary mr-2" onclick="Report_GenerateGM()">Generate</button>
                <!-- <button class="btn btn-primary" onclick="exportgm('GM_table')">Export</button> -->
              </div>
            </div>
            
              <div class="dt-buttons">
                <button class="buttons-copy buttons-html5 ml-2 mb-2 btn btn-success btn-md" tabindex="0" aria-controls="gm" type="button" onclick="selectElementContents( document.getElementById('GM_table') );"><span>Copy</span></button> 
                <button class="buttons-excel buttons-html5 ml-2 mb-2 btn btn-success btn-md" tabindex="0" aria-controls="gm" type="button" onclick="exportgm('GM_table')"><span>Excel</span></button> 
                <button class="buttons-csv buttons-html5 ml-2 mb-2 btn btn-success btn-md" tabindex="0" aria-controls="gm" type="button" onclick="exportgm('GM_table')"><span>CSV</span></button> 
                <button class="buttons-pdf buttons-html5 ml-2 mb-2 btn btn-success btn-md" tabindex="0" aria-controls="gm" type="button" onclick="createPDF()"><span>PDF</span></button>
              </div>

              <div style="overflow-x:auto;" id="tab">
                <!-- <p>Venosn</p> -->
              <table class="table table-bordered table-striped table-sm" id="GM_table">
                <tr>

                 <td colspan="2" style="text-align:center;">Inbound</td>
                 <td colspan="2" style="text-align:center;">Outbound</td>
                 <td colspan="4"></td>

               </tr>

               <tr>
                 <td>Quantity</td>
                 <td>Weight</td>
                 <td>Quantity</td>
                 <td>Weight</td>
                 <td>Control Number</td>
                 <td>Batch/Lot</td>
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
  // loadSubfilterGM();
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

<script type="text/javascript">
  function selectElementContents(el) {
      var body = document.body, range, sel;
      if (document.createRange && window.getSelection) {
          range = document.createRange();
          sel = window.getSelection();
          sel.removeAllRanges();
          try {
              range.selectNodeContents(el);
              sel.addRange(range);
          } catch (e) {
              range.selectNode(el);
              sel.addRange(range);
          }
          document.execCommand("copy");

      } else if (body.createTextRange) {
          range = body.createTextRange();
          range.moveToElementText(el);
          range.select();
          range.execCommand("Copy");
      }
  }
</script>

<script>

    var CustomerID1 = $('#cus_id').val();
    var ItemID1 = $('#loadItem').val();
    var SubFilter1 = $('#subfilter').val();
    var Co_SubFilter1= $('#subfilter2').val();

    var dates1 = $('#dir_dates').val();
    dates1 = dates1.split(" - ");
    var datefrom1 = dates1[0];
    var dateto1 = dates1[1];

    if(datefrom1 == null || datefrom1 == '')
    {
        datefrom1 = '2001-01-01T09:10'
    }
    else
    {
        datefrom1 = dates1[0];
    }

    if(dateto1 == null || dateto1 == '')
    {
        dateto1 = '2031-01-01T09:10'
    }
    else
    {
        dateto1 = dates1[1];
    }

    $.ajax({
        type: 'POST',
        url: 'ajax.php',
        dataType: 'text',
        data: 
        {
            function: 'GetCustomerExport',
            CustomerID1:CustomerID1
        },
        success: function(data)
        {
              WarehouseName = data;
              console.log(WarehouseName);
        }
    });

        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            dataType: 'text',
            data: 
            {
                function: 'GetSubFilterExport',
                SubFilter1:SubFilter1
            },
            success: function(data)
            {
                  SubFilter11 = data;
                  console.log(SubFilter11);
            }
        });
    
  function createPDF() {

      var sTable = document.getElementById('tab').innerHTML;

      var style = "<style>";
      style = style + "table {width: 100%;font: 17px Calibri;}";
      style = style + "table, th, td {border: solid 1px #DDD; border-collapse: collapse;";
      style = style + "padding: 2px 3px;text-align: center;}";
      style = style + "</style>";

      // CREATE A WINDOW OBJECT.
      var win = window.open('', '', 'height=700,width=700');

      win.document.write('<html><head>');
      win.document.write('<title></title>');   // <title> FOR PDF HEADER.
      win.document.write(style);          // ADD STYLE INSIDE THE HEAD TAG.
      win.document.write('</head>');
      win.document.write('<body> <h3>Goods Movement Report</h3> <br> Date Range:' + datefrom1 + '-' + dateto1);
      win.document.write(sTable);         // THE TABLE CONTENTS INSIDE THE BODY TAG.
      win.document.write('</body></html>');

      win.document.close();   // CLOSE THE CURRENT WINDOW.

      win.print();    // PRINT THE CONTENTS.

      
    }
</script>