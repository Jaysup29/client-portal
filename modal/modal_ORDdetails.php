<div class="modal fade" id="modal_order_details" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Order Details</h5>
        <!-- <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
      </div>
      <div class="modal-body">
        <div class="container-fluid p-0">
            <div class="row mx-1">
                <div class="col p-0">
                    <p class="m-0 fw-bold">Custumer Portal Number: <span class="fw-light" id="cpo_no"></span></p>
                </div>
                <div class="col p-0">
                    <p class="m-0 fw-bold">Date: <span class="fw-light" id="date_created"></span></p>
                </div>
            </div>
            <div class="row mb-1 mx-1">
                <div class="col p-0">
                    <p class="m-0 fw-bold">Store name: <span class="fw-light" id="store_name"></span></p>
                </div>
                <div class="col p-0">
                    <p class="m-0 fw-bold">Warehouse: <span class="fw-light" id="warehouse"></span></p>
                </div>
            </div>
            <div class="row mx-1">
                <table class="table table-bordered table-striped m-0" width="100%" id="ordlistable">
                    <thead style="background-color:#3B82F6;">
                        <tr>
                            <td class="w-50 text-white">Item Description</td>
                            <td class="text-white">Quantity</td>
                            <td class="text-white">UOM</td>
                            <td class="text-white">Weight(kg)</td>
                            <td class="text-white">Quantity Given</td>
                        </tr>
                    </thead>
                    <tbody id="orderdetaillist">

                    </tbody>
                    <tfoot id="orderdetailtotal">
                    </tfoot>
                </table> 
            </div>
        </div>
      </div>
      <div class="modal-footer">
        <div id="close-approvebtn"></div>
      </div>
    </div>
  </div>
</div>
<script>
// $(document).ready(function() {
//   $("#modal_order_details").on("hidden.bs.modal", function() {
//     console.log('Modal Hide');
//   });
// });
</script>