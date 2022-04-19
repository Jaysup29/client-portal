<div class="container-fluid px-2">
    <div class="row py-2">
        <div class="col">
            <div class="bg-white rounded shadow-sm px-2">
                <div class="d-flex justify-content-between align-items-center">
                    <h4 class="p-2 m-0">Storelist</h4>
                    <input type="text" class="form-control w-25" placeholder="Search" id="searchmasterstoresonlist">
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col">
            <table class="table table-striped bg-white rounded" width="100%">
                <thead class="bg-secondary">
                    <tr class="">
                        <th class="py-3 text-uppercase">No</th>
                        <th class="py-3 text-uppercase">Company Name</th>
                        <th class="py-3 text-uppercase">Store Name</th>
                        <th class="py-3 text-uppercase">Username</th>
                        <th class="py-3 text-uppercase">Email</th>
                        <th class="py-3 text-uppercase">Contact no</th>
                        <th class="py-3 text-uppercase">Store Address</th>
                        <th class="py-3 text-uppercase">Status</th>
                        <th class="py-3 text-uppercase">Action</th>
                    </tr>
                </thead>
                <tbody id="master_storelist">
                </tbody>
            </table>
        </div>
    </div>
</div>
<script>
$(function(){
    master_storelist();
});
</script>