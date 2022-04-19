<div class="modal fade" id="makeorder" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog" style="max-width: 90%">
    <div class="modal-content">
      <div class="modal-header">
        <div class="modal-title" id="staticBackdropLabel">
            <div class="d-flex flex-row bd-highlight d-flex align-items-center">
                <div class="px-2 bd-highlight">
                    <h5 class="pt-2">Create Order</h5>
                </div>
                <div class="bd-highlight">
                    <button type="button" class="btn btn-primary btn-sm" onclick="order_open()" data-toggle="tooltip" title="Open Created Orders">On Process <span class="badge" id="total_order_opencount">0</span>
                    </button>
                </div>
            </div>
        </div>
        
      </div>
      <div class="modal-body">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-7">
                    <h5 class="text-secondary m-0">Order Form</h5>
                    <hr class="bg-primary"/>
                    <form id="createorderform">
                        <div class="row mb-2">
                            <div class="col">
                                <div class="">
                                <p class="fw-light m-0 px-1" for="order_warehouse">Warehouse<span class="text-danger">*</span></p>
                                    <select class="form-control" id="order_warehouse" value="" style="width: 100%;"></select>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-2">
                            <div class="col">
                                <div class="">
                                <p class="fw-light m-0 px-1">Store Order Number</p>
                                    <input type="text" class="form-control" id="SOnumber" placeholder="Input Store Order Number">
                                </div>
                            </div>
                            <div class="col">
                                <div class="">
                                <p class="fw-light m-0 px-1">Store Name</p>
                                    <input type="text" class="form-control" id="storename" placeholder="Input Store Name">
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col">
                                <div class="">
                                    <p class="fw-light m-0 px-1">Pickup Date<span class="text-danger">*</span></p>
                                    <input id="order_pickupdate" class="form-control" placeholder="Select date" type="datetime-local">
                                </div>
                            </div>
                            <div class="col">
                                <div class="">
                                    <p class="fw-light m-0 px-1">Remarks</p>
                                    <input type="text" class="form-control" id="order_remarks" placeholder="Input Remarks">
                                </div>
                            </div>
                        </div>
                        <div id="GeneratedCPO"></div>
                    </form>
                </div>
                <div class="col-lg-5 mt-1">
                    <div class="card shadow-sm">
                        <h5 class="card-header text-center text-secondary">Add Item</h5>
                        <div class="card-body">
                            <form id="additemform" class="p-2 rounded" onsubmit="return false" autocomplete="off">
                                <div class="row ">
                                    <div class="col">
                                        <p class="fw-light m-0 px-1" for="order_items">Item Description<span class="text-danger">*</span></p>
                                        <select class="form-control" id="order_items" style="width: 100%;"></select>
                                    </div>
                                </div>
                                <div class="row my-2">
                                    <div class="col">
                                        <p class="fw-light m-0 px-1">Quantity<span class="text-danger">*</span></p>
                                        <input type="text" class="form-control" id="order_quantity" placeholder="0" disabled autocomplete="false">
                                    </div>
                                    <div class="col">
                                        <p class="fw-light m-0 px-1">Weight(kg)<span class="text-danger">*</span></p>
                                        <input type="text" class="form-control" id="order_weight" placeholder="0.00" disabled autocomplete="false">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col d-flex justify-content-center mt-3">
                                        <button class="btn btn-primary w-50" onclick="add_orderitem()">Add</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <hr class="my-2 mb-3 bg-primary" />
            <div class="row mb-2">
                <div class="col mx-2 p-0">
                    <div class="bg-white rounded shadow-sm border">
                        <div class="d-flex bd-highlight">
                            <div class="p-2 bd-highlight"><h4 class="p-2 m-0 text-secondary">Order Item Summary</h4></div>
                            <div class="ms-auto p-2 px-3 bd-highlight">
                                <div class="input-group">
                                    <button class="btn btn-primary" id="modalimport">Import</button>
                                    <input type="text" class="form-control" placeholder="Search" id="o_search">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row px-1">
            <div class="col mx-1 p-0" style="max-height: 75vh; overflow-y:auto;">
                <div class="card p-0">
                    <div class="card-body p-0">
                        <table class="table table-striped table-hover" >
                            <thead style="background-color:#3B82F6;">
                                <tr>
                                    <td class="py-2 pl-2 text-white">Store Order Number</td>
                                    <td class="w-50 text-white">Item Description</td>
                                    <td class="text-white">Quantity</td>
                                    <td class="text-white">UOM</td>
                                    <td class="text-white text-nowrap">Weight(kg)</td>
                                    <td class="text-white">Quantity Given</td>
                                    <td class="text-white">Action</td>
                                </tr>
                            </thead>
                            <tbody id="orderedItems">

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="submitforapprovalBtn()">Submit</button>
      </div>
    </div>
  </div>
</div>

<script>
    $(document).ready(function() {
        $("#o_search").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#orderedItems tr").filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });

        $('#order_items').select2({
            dropdownParent: $('#makeorder')
        });

        $("#makeorder").on("hidden.bs.modal", function() {
            // $('#addingItems').addClass('bg-secondary');
            console.log('Modal Hide');
            $('#createorderform')[0].reset();
            $('#additemform')[0].reset();
            $('#orderedItems').empty();
        });
    });

    $("#addingItems").change(function() {
        if($(this).prop('checked')) 
        {
            $("#addingItems").prop('value', 'checked');
            $("#additemform").removeClass('hide');
        } 
        else 
        {
            $("#addingItems").prop('value', 'uncheck');
            $("#additemform").addClass('hide');
        }
    });

    $('#modalimport').click(function(){

        $('#modal_importOrderItems').modal('show');
    });
    
    $('#order_items').on('change', function() {
    
    order_itemfworcw();

    $('#order_quantity').val('');
    $('#order_weight').val('');
    });

    $('#order_quantity').keyup(function(e)
                                {
    if (/\D/g.test(this.value))
    {
        // Filter non-digits from input value.
        this.value = this.value.replace(/\D/g, '');
    }
    });

    $('#order_weight').keypress(function(e) {

    if(isNaN(this.value+""+String.fromCharCode(e.charCode))) 

    return false;

    }).on("cut copy paste",function(e)
    {
        e.preventDefault();
    });
</script>
