<div class="modal fade" id="modalReceivingEditItems" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header bg-primary">
        <h5 class="modal-title" id="exampleModalLabel">Edit Items Details</h5>
        <!-- <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
      </div>
      <div class="modal-body">
        <div class="container-fluid">
            <form class="">
            <div class="mb-2">
                <label for="editItemQty" class="form-label">Quantity</label>
                <input type="text" class="form-control mb-2" id="editItemQty">
            </div>
            <div class="mb-2">
                <label for="editItemQty" class="form-label">Weight</label>
                <input type="text" class="form-control mb-2" id="editItemWgt" disabled>
            </div>
            <div class="mb-2">
                <label for="" class="form-label">Expiry Date</label>
                <input min="1990-12-31" max="3050-12-30" placeholder="Select date" type="date" class="form-control" id="editItemExpiryDate">
            </div>
            </form>
      </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="edititemdetails()">Save changes</button>
      </div>
    </div>
  </div>
</div>

<script>

$('#editItemQty').keyup(function(e)
                                {
  if (/\D/g.test(this.value))
  {
    // Filter non-digits from input value.
    this.value = this.value.replace(/\D/g, '');
  }
});

// $('#editItemWgt').keyup(function(e)
//                                 {
//   if (/\D/g.test(this.value))
//   {
//     // Filter non-digits from input value.
//     this.value = this.value.replace(/\D/g, '');
//   }
// });
</script>