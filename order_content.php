<div class="container-fluid">
  <div class="row g-2">
    <!-- <div class="col-lg-4 col-md-12 mt-3">
    <div class="border shadow-sm rounded" style="background-color:#3B82F6;">
        <div class="d-flex justify-content-between">
          <h4 class="my-1"></h4>
          <h4 class="my-1 text-white">Store</h4>
          <div></div>
        </div>
      </div>
      <div class="row">
        <div class="col-12 mt-3">
          <?php include 'order_storetable_content.php'?>
        </div>    
      </div>
    </div> -->
    <div class="col-lg-12 col-md-12 mt-3">
      <div class="shadow-sm rounded" style="background-color:#3B82F6;">
        <div class="row">
          <div class="col d-flex align-items-center">
            <a class="btn m-1 mx-2" data-bs-toggle="modal" data-bs-target="#makeorder" data-toggle="tooltip" title="Create Order"><i class="text-white fas fa-file-signature"></i></a>
          </div>
          <div class="col d-flex align-items-center justify-content-center">
            <h4 class="my-1 text-white">Planner</h4>
          </div>
          <div class="col d-flex align-items-center justify-content-right">
            <ul class="navbar-nav ml-auto px-3">
              <li class="nav-item d-flex">
                <div class="collapse fade" id="searchForm">
                  <input id="orderlist_search" type="search" class="form-control border-0 bg-light" placeholder="search" />
                </div>
                <a class="nav-link ml-auto px-2" href="#searchForm" data-target="#searchForm" data-toggle="collapse">
                <i class="fas fa-search text-white"></i>
                </a>
              </li>
            </ul>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-12 mt-1">
          <div class="container-fluid px-1" style="height: 80vh; overflow-y: scroll;" id="plannerorderview">
            <?php include 'order_plannertable_content.php'?>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<script>
$(function(){
  getwarehouse();
  getavailableitems();
  order_getallitems();

  setInterval(() => {
        ORDlistTable();
    }, 1000);

});

$(document).ready(function() {
    $("#orderlist_search").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $("#ORDlist_table tr").filter(function() {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });
    });
});
</script>
