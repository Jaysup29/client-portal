<div class="modal fade" id="modal_inboundtransaction" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header border-0">
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="closecpidisplay"></button>
      </div>
      <div class="modal-body p-0">
          <div class="container-fluid">
              <div class="row">
                  <div class="col">
                    <h5 class="text-center">Receiving Transaction no.:</h5>
                  </div>
              </div>
              <div class="row">
                  <div class="col">
                    <h1 class="mb-5 text-center" id="CPI"></h1>
                  </div>  
              </div>
          </div>
      </div>
    </div>
  </div>
</div>
<script>
    $('#closecpidisplay').click(function(){
        location.reload();
    })
</script>
