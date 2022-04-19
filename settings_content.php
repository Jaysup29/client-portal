<div class="container-fluid p-2">
  <div class="bg-white rounded shadow-sm">
    <h4 class="p-2">Settings</h4>
  </div>

  <div class="row">
      <div class="col-lg-2 col-md-3 col-sm-6">
        <div class="card btn" onClick="usersmanagement()">
            <div class="card-body text-center">
                User Management
            </div>
        </div>
      </div>
      <div class="col-lg-2 col-md-3 col-sm-6 hide">
        <div class="card btn" onClick="itemsmanagement()">
            <div class="card-body text-center">
                Item Management
            </div>
        </div>
      </div>
  </div>
</div>
<script>
    function usersmanagement()
    {
        window.location = "users_management.php";
    }

    function itemsmanagement()
    {
        alert("UNDER DEVELOPEMENT");
//        window.location = "items_management.php";
    }
</script>
