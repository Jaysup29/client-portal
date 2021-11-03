<div class="container-fluid pt-2">

    <div class="d-flex flex-row bd-highlight mb-2 bg-white rounded shadow-sm p-2">
        <div class="pr-2 bd-highlight d-flex align-items-center "><h4 class="m-0">Receiving</h4></div>
        <div class="bd-highlight">
            <button type="button" class="btn btn-primary btn-sm" onclick="receiving_open()">Open <span class="badge" id="total_opencount">0</span>
            </button>
        </div>
        <div class="px-2 bd-highlight">
            <button type="button" class="btn btn-primary btn-sm" onclick="receiving_pending()">Pending <span class="badge" id="total_pendingcount">0</span>
            </button>
        </div>
        <div class="bd-highlight">
            <button type="button" class="btn btn-primary btn-sm" onclick="receiving_onprocess()">On Process <span class="badge" id="total_onprocesscount">0</span>
            </button>
        </div>
    </div>
    <div class="row g-2">
        <div class="col-lg-8">
            <div class="bg-white rounded shadow-sm p-2 py-4 py-sm-0 py-md-2 h-100">
                <form>
                <div class="row p-2 ">
                <div class="col-lg-4 col-md-6">
                        <p class="fw-light m-0 px-1">Warehouse</p>
                        <select class="form-control" id="receiving_selectedWH" value="" style="width: 100%;">
                            <option disabled="" value="" selected="">Select Warehouse</option>
                        </select>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <p class="fw-light m-0 px-1">Control no.</p>
                        <div class="input-group">
                            <input class="form-control border-end-0" id="receiving_IBN" value="" disabled>
                            <button class="btn text-white" type="button" id="genbtn" onClick="receiving_ctrlno();"><i class="far fa-plus-square"></i></button>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <p class="fw-light m-0 px-1">Estimated date of Arrival*</p>
                        <input placeholder="Select date" type="date" id="receiving_datearrive" value="" class="form-control">
                    </div>
                </div>
                <div class="row p-2">
                    <div class="col-lg-4 col-md-6">
                        <p class="fw-light m-0 px-1">Truck type</p>
                        <select class="form-control" id="receiving_selectedTruck" value="" style="width: 100%;">
                            <option disabled="" value="0" selected="">Please Select Warehouse</option>
                        </select>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <p class="fw-light m-0 px-1">Container no.</p>
                        <input class="form-control" id="receiving_containerno">
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <p class="fw-light m-0 px-1">Vehicle Plate no.</p>
                        <input class="form-control" id="receiving_vehicleplateno">
                    </div>
                </div>
                <div class="row p-2">
                <div class="col-lg-4 col-md-6">
                        <p class="fw-light m-0 px-1">Supplier name</p>
                        <input class="form-control" id="receiving_suppliername">
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <p class="fw-light m-0 px-1">Seal no.</p>
                        <input class="form-control" id="receiving_sealno">
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <p class="fw-light m-0 px-1">Client Representative</p>
                        <input class="form-control" id="receiving_clientrepresentative">
                    </div>
                </div>
                </form>
                <div>
                    <center>
                        <button class="btn btn-primary mt-3 float-center" onclick="saveASN()">Save Receiving Details</button>
                        <button class="btn btn-primary mt-3 float-center" onclick="returntopending()">Return to Pending</button>
                    </center>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="bg-white rounded shadow-sm p-2 py-4 m-lg-0 mt-md-2 mt-sm-2 py-sm-0 py-md-2 disabled" id="iteminput">
                <form class="p-2" id="itemform">
                    <div id="radios">
                        <input id="FW" name="options" type="radio" value="1" checked>
                        <label for="FW" class="text-nowrap">Fixed Weight</label>

                        <input id="CW" name="options" type="radio" value="2">
                        <label for="CW" class="text-nowrap">Catch Weight</label>
                    </div>
                    <p class="m-0">Item*</p>
                    <select class="form-control mb-2" id="receiving_items" style="width: 100%;">
                        <option disabled="" value="0" selected="">Please Select Item</option>
                    </select>
                    <div class="row">
                        <div class="col">
                            <p class="m-0 mt-2">Quantity*</p>
                            <input class="form-control" id="receiving_qty">
                        </div>
                        <div class="col">
                            <p class="m-0 mt-2">Weight</p>
                            <input class="form-control " id="receiving_wtg" disabled>
                        </div>
                    </div>
                    <p class="m-0 mt-2">UOM</p>
                    <select class="form-control" id="receiving_uom" style="width: 100%;">
                        <option disabled="" value="0" selected="">Please Select UOM</option>
                    </select>
                    <p class="m-0 mt-2">Expiration</p>
                    <input placeholder="Select date" type="date" id="receiving_expiration" value="" class="form-control">
                </form>
                <button class="btn btn-primary mt-3 w-100" onclick="addreceivingitems()">Add</button>
            </div>
        </div>
    </div>
<!--    table-->
    <div class="row my-2">
        <div class="col mx-2 mb-2 shadow-sm bg-white rounded">
            <div class="row border-bottom mx-1">
                <div class="col px-0"><h4 class="m-0 px-0 py-2">Receiving Items Summary Details</h4></div>
            </div>
            <?php include 'receivingitems_summary.php'; ?>
            
            <center>
                <button class="btn btn-primary my-2" onclick="submitconfirmation()">Submit</button>
            </center>   
        </div>
    </div>
</div>
<script>
$(function() {
    $('#receiving_selectedWH').select2();
    $('#receiving_items').select2();
    $('#receiving_uom').select2();
    $('#receiving_selectedTruck').select2();

    var radios = $('#radios').radioslider({
        size: 'small',
        fit: true
    });
    $( ".tabledit-edit-button" ).click(function() {
        alert( "Handler for .click() called." );
    });

    getwarehouse();
    gettrucktype();
    getavailableitems();
    open_count();
    pending_count();
    onprocess_count();

});

$('#receiving_items').change(function ()
{
    getuom(this.value);
    getweight(this.value);
});

$('#radios input').on('change', function() {
    getavailableitems(this.value);
   var storageType = $('input[name=options]:checked', '#radios').val();
   if(storageType == '2')
   {
       $('#receiving_wtg').prop('disabled', false)
   }
   else
   {
    $('#receiving_wtg').prop('disabled', true);
   }
});
</script>