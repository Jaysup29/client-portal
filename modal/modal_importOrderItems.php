<div class="modal fade" id="modal_importOrderItems" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Import File</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="container-fluid">
            <div class="row mb-3">
                <div class="col p-0">
                    <h4 class="fs-bold">Sample Format:</h4>
                </div>
                <div class="col p-0">
                    <div class="input-group">
                        <input type="file" class="form-control" id="importorders">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col p-0">
                    <table class="table table-reponsive table-striped">
                        <thead style="background-color:#3B82F6;">
                            <tr>
                                <th>SO</th>
                                <th>Item Description</th>
                                <th>Quantity</th>
                                <th>UOM</th>
                                <th>Weight</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="fst-italic">123</td>
                                <td class="fst-italic">Egg Pie</td>
                                <td class="fst-italic">1</td>
                                <td class="fst-italic">Box</td>
                                <td class="fst-italic">12.50</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="uploadorders">Upload</button>
      </div>
    </div>
  </div>
</div>

<script>
    $(function () {
        $("#uploadorders").bind("click", function () {
            var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.csv|.txt)$/;
            if (regex.test($("#importorders").val().toLowerCase())) {
                if (typeof (FileReader) != "undefined") {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        var orders = new Array();
                        var rows = e.target.result.split("\r\n");
                        for (var i = 1; i < rows.length; i++) {
                            var cells = rows[i].split(",");
                            if (cells.length > 1) {
                                var itemorders = {};
                                itemorders.SO = cells[0];
                                itemorders.ItemDesc = cells[1];
                                itemorders.Quantity = cells[2];
                                itemorders.UOM = cells[3];
                                itemorders.Weight = cells[4];
                                orders.push(itemorders);
                            }
                        }
                        import_itemorders(orders);
                    }
                    reader.readAsText($("#importorders")[0].files[0]);
                } else {
                    alert("This browser does not support HTML5.");
                }
            } else {
                // alert("Please upload a valid CSV file.");
                $('#toastuploadcsvfile').toast('show');
            }
        });

        $("#modal_importOrderItems").on("hidden.bs.modal", function() {
            console.log('Modal Hide');
            $('#importorders').val('');
        });
    });
</script>