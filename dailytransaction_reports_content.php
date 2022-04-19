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
            <div class="row mb-2">
              <div class="col d-flex justify-content-center">
                <button class="btn btn-primary" id="generate" onclick="Report_GenerateDTR()">Generate</button>
              </div>
            </div>
            <table id="DTR" class="table table-bordered table-hover">
              <thead>
                <th>Date</th>
                <th>CPI/CPO</th>
                <th>Client SKU</th>
                <th>Item Description</th>
                <th>Quantity</th>
                <th>Weight</th>
                <th>CV Number</th>
                <th>Remarks</th>
              </thead>

              <tbody>
                <?php 

                    include ('dbcon.php');
                    $data = "";
                    $starttime = 'T00:00:01';
                    $endtime = 'T23:59:59';
                    $CustomerID = $_SESSION['CustomerId'];
                    $start = date('Y-m-d');           
                    $query = "SELECT 
                                    B.Date_created,
                                    A.CPI,
                                    Client_SKU,
                                    ItemCode,
                                    ItemDesc,
                                    IFNULL(A.Beg_Quantity,0),
                                    IFNULL(A.Beg_Weight, 0),
                                    C.Container,
                                    C.Remarks
                                FROM wms_clientportal.tbl_inbounditems A
                                LEFT JOIN wms_clientportal.tbl_inbound B ON A.CPI = B.CPI
                                LEFT JOIN wms_inbound.tbl_receiving C ON A.CPI = C.ASN
                                LEFT JOIN wms_cloud.tbl_items D ON A.ItemID = D.ItemID
                                WHERE LEFT(Date_created, 10) = '$start' AND B.CusID = $CustomerID";
                 
                    $result = mysqli_query($conn, $query);
                    
                    while($rows = mysqli_fetch_array($result))
                    {   
                        if(empty($rows[2]))
                        {
                            $itemcode = $rows[3];
                            $itemcode = '<span style="color:red">*(' .$itemcode. ')*</span>';
                        }
                        else
                        {
                            $itemcode = $rows[2];
                        }

                        echo '
                           <tr>
                              <td>'.$rows[0].'</td>
                              <td>'.$rows[1].'</td>
                              <td>'.$itemcode.'</td>
                              <td>'.$rows[4].'</td>
                              <td>'.$rows[5].'</td>
                              <td>'.$rows[6].'</td>
                              <td>'.$rows[7].'</td>
                              <td>'.$rows[8].'</td>
                           </tr>
                        ';
                    }
                  
                  $query = "
                              SELECT
                                LEFT(A.OrderDate, 10) AS ORDDate,
                                CPO,
                                Z.ItemCode,
                                Z.ItemDesc,
                                (SELECT SUM(Quantity) FROM wms_outbound.tbl_orderingitems WHERE ORD = A.ORD),
                                Z.Weight,
                                F.Container,
                                F.Remarks
                                FROM wms_outbound.tbl_ordering A
                                LEFT JOIN wms_cloud.tbl_customers B ON A.CustomerID = B.CustomerID
                                LEFT JOIN wms_outbound.tbl_orderingitems C ON A.ORD = C.ORD
                                LEFT JOIN wms_outbound.tbl_picking D ON A.ORD = D.ORD
                                LEFT JOIN wms_outbound.tbl_issuancelist E ON D.PCK = E.PCK
                                LEFT JOIN wms_outbound.tbl_issuances F ON E.OBD = F.OBD
                                LEFT JOIN wms_cloud.tbl_items Z ON C.ItemID = Z.ItemID
                            WHERE
                    A.CustomerID = $CustomerID
                    AND LEFT(A.OrderDate, 10) = '$start' AND CPO IS NOT NULL
                          ";
                  $result = mysqli_query($conn, $query);
                  while ($rows = mysqli_fetch_row($result))
                  {
                      $IssuanceDate = strtotime($rows[0]);
                      $IssuanceDate = date('d-M-Y',$IssuanceDate);
                      $wgt_out = number_format((float)$rows[5], 2);
                      $wgt_out = floatval(preg_replace('/[^\d.]/', '', $wgt_out));
                     
                     echo '
                           <tr>
                              <td>'.$IssuanceDate.'</td>
                              <td>'.$rows[1].'</td>
                              <td>'.$rows[2].'</td>
                              <td>'.$rows[3].'</td>
                              <td>'.$rows[4].'</td>
                              <td>'.$wgt_out.'</td>
                              <td>'.$rows[6].'</td>
                              <td>'.$rows[7].'</td>
                           </tr>
                        ';
                  }
                 ?>
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

<!-- <div class="d-flex justify-content-center">
  <div class="spinner-border" role="status">
    <span class="sr-only">Loading...</span>
  </div>
</div> -->
<script>
  // Report_GenerateDTR();
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


<script>
  $(function(){
   var table = $('#DTR').DataTable({
      dom: 'Bfrtip',
      responsive: true,
      searching:true,
      buttons: [
        { extend: 'copyHtml5', footer: true,
          exportOptions: {
                columns: [ 0, 2, 3, 4, 5, 6, 7]
            }
        },
        { extend: 'excelHtml5', footer: true,
          exportOptions: {
                columns: [ 0, 2, 3, 4, 5, 6, 7]
            },
            title : function() {
                    return "Daily Transaction Reports";
                },
        },
        { extend: 'csvHtml5', footer: true,
          exportOptions: {
                columns: [ 0, 2, 3, 4, 5, 6, 7]
            },
            title : function() {
                    return "Daily Transaction Reports";
                },
        },
        { extend: 'pdfHtml5', footer: true, 
          exportOptions: {
                columns: [ 0, 2, 3, 4, 5, 6, 7],
               
            },
            orientation: 'landscape',  
            pageSize : 'LEGAL',
            title : function() {
                    return "Daily Transaction Reports";
                },
                
        }
    ],
    initComplete: function () {
      var btns = $('.dt-button');
      btns.addClass('ml-2 btn btn-success btn-md');
      btns.removeClass('dt-button');

    },
    // "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],
    "bPaginate": false,

  });

 });

</script>
