<div class="modal fade" id="modalOrderingChangeQty" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Change Given Quantity</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="container-fluid">
            <div class="mb-2">
                <p class="fw-light mb-1 px-1">Quantity</p>
                <input type="text" class="form-control mb-2" value="" id="o_editItemQty">
            </div>   
            <div class="mb-2">
                <p class="fw-light mb-1 px-1">Weight</p>
                <input type="text" class="form-control mb-2" value="" id="o_editItemWgt">
            </div> 
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="edit_givenqty()">Save changes</button>
      </div>
    </div>
  </div>
</div>
<script>
  $(function(){
    $("#modalOrderingChangeQty").on("hidden.bs.modal", function() {
      console.log('Modal Hide');
      $('#o_editItemQty').val('');
      $('#o_editItemWgt').val('');
    });
  });
</script>