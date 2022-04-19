<div class="container-fluid px-2">
    <div class="row py-2">
        <div class="col">
            <div class="bg-white rounded shadow-sm px-2">
                <div class="d-flex justify-content-between align-items-center">
                <h4 class="p-2 m-0">Userlist</h4>
                <input type="text" class="form-control w-25" placeholder="Search" id="searchmasterusersonlist">
                </div>
            </div>
        </div>
        <div class="col">
        <button class="btn btn-primary" onclick="registerall()">Register All</button>
        </div>
    </div>
    <div class="row">
        <div class="col">
            <table class="table table-striped bg-white rounded" width="100%">
                <thead class="bg-secondary sticky-top">
                    <tr class="">
                        <th class="py-3 text-uppercase">No</th>
                        <th class="py-3 text-uppercase">Company name</th>
                        <th class="py-3 text-uppercase">Full name</th>
                        <th class="py-3 text-uppercase">Username</th>
                        <th class="py-3 text-uppercase">Email</th>
                        <th class="py-3 text-uppercase">Contact no.</th>
                        <th class="py-3 text-uppercase">Role</th>
                        <th class="py-3 text-uppercase">Status</th>
                        <th class="py-3 text-uppercase">Action</th>
                    </tr>
                </thead>
                <tbody id="master_userlist">
                </tbody>
            </table>
        </div>
    </div>
</div>
<script>
    $(function(){
        master_userlist();

    $("#searchmasterusersonlist").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $("#master_userlist tr").filter(function() {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });
    });
    })
</script>