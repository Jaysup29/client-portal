<div class="modal fade" id="modal_receiving_forapproval" tabindex="-1">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title text-secondary" id="rcvng_btn_label">Pendings</h5>
        <input type="text" class="form-control w-25" placeholder="Search" id="forapprove_search">
        <!-- <button type="button" class="btn-close" data-bs-dismiss="modal"></button> -->
      </div>
      <div class="modal-body">
      <table class="table table-striped" id="pending_table">
        <thead class="">
          <tr>
            <th scope="col">Customer Portal Number</th>
            <th scope="col">Date Created</th>
            <th scope="col">Created By</th>
            <th scope="col">Last Updated By</th>
            <?php 
              $userid = $_SESSION['UserID'];

              $query = "SELECT role_id FROM wms_cloud.tbl_customers_users WHERE id = '$userid'";
              $result = mysqli_query($conn, $query);
              $row = mysqli_fetch_array($result);
              $role_id = $row[0];

              if($role_id === '1')
              {
                echo '<th scope="col">Action</th>'; 
              }
              else
              {
                echo '';
              }
            ?>
            
          </tr>
        </thead>
        <tbody id="forapprove_list">
        </tbody>
      </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<script>
  $(document).ready(function() {
      $("#forapprove_search").on("keyup", function() {
          var value = $(this).val().toLowerCase();
          $("#forapprove_list tr").filter(function() {
          $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
          });
      });
  });
</script>