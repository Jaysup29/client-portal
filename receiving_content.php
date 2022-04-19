<div class="container-fluid pt-2">

    <div class="d-flex flex-row bd-highlight mb-2 bg-white rounded shadow-sm p-2">
        <div class="pr-2 bd-highlight d-flex align-items-center "><h4 class="m-0 text-secondary">Receiving</h4></div>
        <?php 
            $userid = $_SESSION['UserID'];

            $query = "SELECT cu.role_id 
            FROM wms_cloud.tbl_customers_users cu
            LEFT JOIN wms_cloud.tbl_customers c ON cu.CommonCode = c.CustomerCommonCode
            WHERE cu.id = $userid";
            $result = mysqli_query($conn, $query);
            while($row = mysqli_fetch_array($result))
            {
                $role_id = $row[0];
            }
    
            if($role_id == 1)
            {
                echo '<div class="px-2 bd-highlight">
                <button type="button" class="btn btn-primary btn-sm" onclick="receiving_pending()">Pending <span class="badge" id="total_pendingcount">0</span>
                </button>
                </div>
                <div class="px-2 bd-highlight">
                <button type="button" class="btn btn-primary btn-sm" onclick="receiving_onprocess()">On Process <span class="badge" id="total_onprocesscount">0</span>
                </button>
                </div>
                <div class="px-2 bd-highlight">
                    <button type="button" class="btn btn-primary btn-sm" onclick="receiving_forapprove()">For Approval <span class="badge" id="total_forapprovalcount">0</span>
                    </button>
                </div>';
            }
            else
            {
                echo '<div class="px-2 bd-highlight">
                <button type="button" class="btn btn-primary btn-sm" onclick="receiving_pending()">Pending <span class="badge" id="total_pendingcount">0</span>
                </button>
                </div>
                <div class="px-2 bd-highlight">
                <button type="button" class="btn btn-primary btn-sm" onclick="receiving_onprocess()">On Process <span class="badge" id="total_onprocesscount">0</span>
                </button>
                </div>';
            }
        ?>
        
    </div>
    <div class="row g-2">
        <div class="col-lg-8">
            <div class="bg-white rounded shadow-sm p-2 py-4 py-sm-0 py-md-2 h-100">
                <form id="form_receivingdetails ">
                    <div class="row p-2">
                        <div value="" id="r_CPI"></div>
                        <div class="col-lg-4 col-md-6">
                            <p class="fw-light m-0 px-1">Warehouse<span class="text-danger">*</span></p>
                            <select class="form-control" id="receiving_selectedWH" value="" style="width: 100%;" data-bs-toggle="tooltip">
                            <option disabled="" value="" selected="">Select Warehouse</option>
                            </select>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <p class="fw-light m-0 px-1">Truck Type<span class="text-danger">*</span></p>
                            <select class="form-control" id="receiving_selectedTruck" value="" style="width: 100%;">
                                <option disabled="" value="" selected="">Select Truck type</option>
                            </select>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <p class="fw-light m-0 px-1">Estimated Date of Arrival<span class="text-danger" >*</span></p>
                            <input id="receiving_datearrive" class="form-control" placeholder="Select date" type="datetime-local">
                        </div>
                    </div>
                    <div class="row p-2">
                        <div class="col-lg-4 col-md-6">
                            <p class="fw-light m-0 px-1">Container Number</p>
                            <input class="form-control" id="receiving_containerno" name="receiving_containerno" placeholder="Please input container no.">
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <p class="fw-light m-0 px-1">Vehicle Plate Number</p>
                            <input class="form-control" id="receiving_vehicleplateno" placeholder="Please input plate no.">
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <p class="fw-light m-0 px-1">Supplier Name</p>
                            <input class="form-control" id="receiving_suppliername" placeholder="Please input supplier name">
                        </div>
                    </div>
                    <div class="row p-2">
                        <div class="col-lg-4 col-md-6">
                            <p class="fw-light m-0 px-1">Seal Number</p>
                            <input class="form-control" id="receiving_sealno" placeholder="Please input seal no.">
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <p class="fw-light m-0 px-1">Client Representative</p>
                            <input class="form-control" id="receiving_clientrepresentative" placeholder="Please input representative">
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <p class="fw-light m-0 px-1">Remarks</p>
                            <input class="form-control" id="receiving_remarks" placeholder="Please input remarks">
                        </div>
                    </div>
                </form>

            </div>
        </div>
        <div class="col-lg-4">
            <div class="bg-white rounded shadow-sm p-2 py-4 m-lg-0 mt-md-2 mt-sm-2 py-sm-0 py-md-2 " id="iteminput" data-toggle="tooltip" title = "Please fill out all required field(*).">
                <form class="p-2 disabled" id="itemform" onsubmit="return false" autocomplete="off">
                    <p class="m-0">Item Description<span class="text-danger">*</span></p>
                    <select class="form-control mb-2" id="receiving_items" style="width: 100%;">
                        <option disabled="" value="0" selected="">Please Select Item</option>
                    </select>
                    <div class="row">
                        <div class="col">
                            <p class="m-0 mt-2">Quantity<span class="text-danger">*</span></p>
                            <input class="form-control" id="receiving_qty" placeholder="0" required autocomplete="false">
                        </div>
                        <div class="col">
                            <p class="m-0 mt-2">Weight(kg)<span class="text-danger">*</span></p>
                            <input class="form-control " id="receiving_wtg" placeholder="0.00" disabled autocomplete="false">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <p class="m-0 mt-2">Unit of Measure (UOM)</p>
                            <input class="form-control " id="receiving_uom" disabled>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <p class="m-0 mt-2">Expiration Date<span class="text-danger">*</span></p>
                            <input placeholder="Select date" type="date" id="receiving_expiration" value="" class="form-control" min="1990-12-31" max="3050-12-30">
                        </div>
                    </div>
                    
                    <button class="btn btn-primary mt-3 w-100" onclick="addreceivingitems()">Add</button>
                </form>
            </div>
        </div>
    </div>
<!--    table-->
    <div class="row my-2">
        <div class="col mx-2 mb-2 shadow-sm bg-white rounded">
            <div class="row">
                <div class="col mx-0 px-0">
                    <div class="d-flex bd-highlight">
                        <div class="p-2 bd-highlight"><h4 class="m-0 px-1 py-2 text-secondary">Receiving Item Summary</h4></div>
                        <div class="ms-auto p-2 px-3 bd-highlight">
                            <div class="input-group">
                                <button class="btn btn-primary" id="cpi_modalimport" disabled>Import</button>
                                <input type="text" class="form-control" placeholder="Search" id="r_search">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col" style="max-height: 50vh; overflow-y:auto;">
                    <?php include 'receivingitems_summary.php'; ?>
                </div>
            </div>
            <center>
                <div id="forapprovebtn"></div>
            </center> 
        </div>
    </div>
</div>

<script>
$(function() {

    $('#cpi_modalimport').click(function(){
        $('#modal_importReceivingItems').modal('show');
    });

    $('#receiving_items').select2();
    $( ".tabledit-edit-button" ).click(function() {
        alert( "Handler for .click() called." );
    });
    $( ".tabledit-edit-button" ).click(function() {
        alert( "Handler for .click() called." );
    });

    setInterval(() => {
        enableditemform();
    }, 1000);

    getwarehouse();
    gettrucktype();
    getavailableitems();
    pending_count();
    forapproval_count();
    showingApproveBtn();
    onprocess_count();
    

    var dtToday = new Date();
    
    var month = dtToday.getMonth() + 1;
    var day = dtToday.getDate() + 1;
    var year = dtToday.getFullYear();
    var hour = dtToday.getHours() + 1;
    var minutes = dtToday.getMinutes() + 1;
    var second = dtToday.getSeconds();
    {
        if(year.lenght > 4)
        {

        }
        if(month < 10)
        month = '0' + month.toString();
        if(day < 10)
            day = '0' + day.toString();
        
        var minDate= year + '-' + month + '-' + day;
        $('#receiving_expiration').attr('min', minDate);
        $('#editItemExpiryDate').attr('min', minDate);
        $('#receiving_datearrive').attr('min', minDate);
    }
});

    $(document).ready(function(){
        $("#r_search").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#receivingitemsummary tr").filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });

    $('#receiving_qty').keyup(function(e)
                                    {
    if (/\D/g.test(this.value))
    {
        // Filter non-digits from input value.
        this.value = this.value.replace(/\D/g, '');
    }
    });

    $('#receiving_wtg').keypress(function(e) {
    if(isNaN(this.value+""+String.fromCharCode(e.charCode))) return false;
    })
    .on("cut copy paste",function(e){
    e.preventDefault();
    });


    $('#receiving_items').change(function ()
    {
        getuom(this.value);
        getweight(this.value);
    });

</script>