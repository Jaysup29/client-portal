<div class="modal fade" id="modalReceivingEditItems" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header bg-primary">
        <h5 class="modal-title" id="exampleModalLabel">Edit Items Details</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="container-fluid">
            <form class="">
            <div class="mb-2">
                <label for="editItemQty" class="form-label">Quantity</label>
                <input type="text" class="form-control mb-2" id="editItemQty">
            </div>
            <div class="mb-2">
                <label for="editItemExpiryDate" class="form-label">Expiry Date</label>
                <input placeholder="Select date" type="date" class="form-control" value="" id="editItemExpiryDate">
            </div>
            </form>
      </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="edititemdetails()">Save changes</button>
      </div>
    </div>
  </div>
</div>