<div class="container-fluid p-2 pb-0">
  <div class="bg-white rounded shadow-sm">
    <h4 class="p-2">User Management</h4>
  </div>
</div>

<div class="container-fluid p-0">
    <div class="row m-1">
        <div class="col-lg-4 col-md-12 col-sm-12 p-0 p-1">
            <div class="accordion accordion-flush" id="accordionFlushExample">
                <div class="accordion-item">
                    <h2 class="accordion-header" id="flush-headingOne">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
                        My Information
                    </button>
                    </h2>
                    <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
                        <div class="accordion-body">
                            <div class="container-fluid p-0">
                                <form id="form_update_info" onsubmit="return false;">
                                    <div class="row my-3">
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Full name:</p>
                                            <input class="form-control" id="fullname">
                                        </div>
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Username:</p>
                                            <input class="form-control" id="username">
                                        </div>
                                    </div>
                                    <div class="row my-3">
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Email:</p>
                                            <input class="form-control" id="email">
                                        </div>
                                    </div>
                                    <div class="row my-3">
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Contact no:</p>
                                            <input class="form-control" id="contact_no">
                                        </div>
                                    </div>
                                    <div class="row my-3">
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Current Password:</p>
                                            <input class="form-control" type="password" id="curr_password">
                                            <input type="checkbox" id="showpass">Show Password
                                        </div>
                                    </div>
                                    <div class="row my-3">
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">New Password:</p>
                                            <input class="form-control" type="password" id="upd_password1">
                                        </div>
                                    </div>
                                    <div class="row my-3">
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Re-type New Password:</p>
                                            <input class="form-control" type="password" id="upd_password2">
                                        </div>
                                    </div>
                                    <div class="row p-2">
                                        <button class="btn btn-primary" type="submit" onclick="modal_updateinfor_confirmation()">Update Account</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="accordion-item">
                    <h2 class="accordion-header" id="flush-headingOne">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
                        Add Account
                    </button>
                    </h2>
                    <div id="flush-collapseTwo" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
                        <div class="accordion-body">
                            <div class="container-fluid p-0">
                                <form id="form_add_account" onsubmit="return false;">
                                    <div class="row my-3">
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Full name:</p>
                                            <input class="form-control" id="new_fullname">
                                        </div>
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Username:</p>
                                            <input class="form-control" id="new_username">
                                        </div>
                                    </div>
                                    <div class="row my-3">
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Email:</p>
                                            <input class="form-control" id="new_email">
                                        </div>
                                    </div>
                                    <div class="row my-3">
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Contact no:</p>
                                            <input class="form-control" id="new_contactno">
                                        </div>
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Role:</p>
                                            <select class="form-select" aria-label="Default select example" id="new_userrole">
                                                <option selected disabled>Select User Role</option>
                                                <option value="1">Top Management</option>
                                                <option value="2">Planner</option>
                                                <option value="3">QA</option>
                                                <option value="4">Sales</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row my-3">
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Password:</p>
                                            <input class="form-control" type="password" id="new_password1">
                                        </div>
                                    </div>
                                    <div class="row my-3">
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Re-type Password:</p>
                                            <input class="form-control" type="password" id="new_password2">
                                        </div>
                                    </div>
                                    <div class="row p-2">
                                        <button class="btn btn-primary" type="submit" onclick="modal_adduser_confirmation()">Submit</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="accordion-item">
                    <h2 class="accordion-header" id="flush-headingTwo">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="false" aria-controls="flush-collapseThree">
                        Add Store
                    </button>
                    </h2>
                    <div id="flush-collapseThree" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushExample">
                        <div class="accordion-body">
                            <div class="container-fluid p-0">
                                <form id="form_add_store" onsubmit="return false;">
                                    <div class="row my-3">
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Full name:</p>
                                            <input class="form-control" id="store_fullname">
                                        </div>
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Username:</p>
                                            <input class="form-control" id="store_username">
                                        </div>
                                    </div>
                                    <div class="row my-3">
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Email:</p>
                                            <input class="form-control" id="store_email">
                                        </div>
                                    </div>
                                    <div class="row my-3">
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Password:</p>
                                            <input class="form-control" type="password" id="store_password1">
                                        </div>
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Re-type Password:</p>
                                            <input class="form-control" type="password" id="store_password2">
                                        </div>
                                    </div>
                                    <div class="row my-3">
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Contact no:</p>
                                            <input class="form-control" id="store_contactno">
                                        </div>
                                    </div>
                                    <div class="row my-3">
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Store Address:</p>
                                            <input class="form-control" id="store_storeaddress">
                                        </div>
                                    </div>
                                    <div class="row p-2">
                                        <button class="btn btn-primary" type="submit" onclick="modal_addstore_confirmation()">Submit</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-8 col-md-12 col-sm-12 p-0 p-1">
        <div class="rounded shadow-sm" style="background-color:#3B82F6;">
            <h4 class="p-2 text-white text-center m-0">User's</h4>
            <?php
                include 'dbcon.php'; 
                $userid = $_SESSION['UserID'];

                $query = "SELECT role_id FROM tbl_customers_users WHERE id = '$userid'";
                $result = mysqli_query($conn, $query);
                while($rows = mysqli_fetch_assoc($result))
                {
                    $role = $rows['role_id'];
                }

                if($role === 0)
                {
                    echo '<div>
                            <select class="form-select" aria-label="Default select example">
                                <option selected>Open this select menu</option>
                                <option value="1">One</option>
                                <option value="2">Two</option>
                                <option value="3">Three</option>
                            </select>
                        </div>';
                }
                
            ?>
            <input type="text" class="form-control border-0 rounded-0 mb-1" placeholder="Seach" id="searchUsers">
        </div>
            <div class="row rounded" style="max-height: 35vh; overflow: auto;">
                <div class="col">
                <table class="table table-striped bg-white rounded">
                    <thead class="">
                        <tr class="">
                            <td>No</td>
                            <td>Fullname</td>
                            <td>Username</td>
                            <td>Email</td>
                            <td>Contact no</td>
                            <td>Status</td>
                            <td class="text-center">Action</td>
                        </tr>
                    </thead>
                    <tbody id="registered_users">

                    </tbody>
                </table>
                </div>
            </div>
            <div class="rounded shadow-sm mt-2" style="background-color:#3B82F6;">
                <h4 class="p-2 text-white text-center m-0">Store's</h4>
                <input type="text" class="form-control border-0 rounded-0 mb-1" placeholder="Seach" id="searchStore">
            </div>
            <div class="row rounded" style="max-height: 35vh; overflow: auto;">
                <div class="col">
                    <table class="table table-striped bg-white rounded">
                        <thead class="">
                            <tr class="">
                                <td>No</td>
                                <td>Fullname</td>
                                <td>Username</td>
                                <td>Email</td>
                                <td>Store Address</td>
                                <td>Contact no</td>
                                <td>Store Status</td>
                                <td class="text-center">Action</td>
                            </tr>
                        </thead>
                        <tbody id="registered_stores">

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(function(){
        myinfo();
        all_users();
        all_stores();

        $("#searchUsers").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#registered_users tr").filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });

        $("#searchStore").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#registered_stores tr").filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });

    $('#showpass').click(function()
    {
        if('password' == $('#curr_password').attr('type'))
        {
            $('#curr_password').prop('type', 'text');
        }
        else
        {
            $('#curr_password').prop('type', 'password');
        }
    });
</script>