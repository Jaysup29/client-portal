<div class="modal fade" id="modal_importReceivingItems" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                        <input type="file" class="form-control" id="importreceiving">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col p-0">
                    <table class="table table-reponsive table-striped">
                        <thead style="background-color:#3B82F6;">
                            <tr>
                                <th>Item Description</th>
                                <th>Quantity</th>
                                <th>UOM</th>
                                <th>Weight</th>
                                <th>ExpiryDate</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="fst-italic">Egg Pie</td>
                                <td class="fst-italic">1</td>
                                <td class="fst-italic">Box</td>
                                <td class="fst-italic">12.50</td>
                                <td class="fst-italic">2021-01-01</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="uploadreceiving">Upload</button>
      </div>
    </div>
  </div>
</div>

<script>
    $(function () {

        $("#uploadreceiving").bind("click", function () {
            var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.csv|.txt)$/;
            if (regex.test($("#importreceiving").val().toLowerCase())) {
                if (typeof (FileReader) != "undefined") {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        var receiving = new Array();
                        var rows = e.target.result.split("\r\n");
                        for (var i = 1; i < rows.length; i++) {
                            var cells = rows[i].split(",");
                            if (cells.length > 1) {
                                var receivingitems = {};
                                receivingitems.ItemDesc = cells[0];
                                receivingitems.Quantity = cells[1];
                                receivingitems.UOM = cells[2];
                                receivingitems.Weight = cells[3];
                                receivingitems.ExpiryDate = cells[4];
                                receiving.push(receivingitems);
                            }
                        }
                        import_itemreceiving(receiving);
                    }
                    reader.readAsText($("#importreceiving")[0].files[0]);
                } else {
                    alert("This browser does not support HTML5.");
                }
            } else {
                // alert("Please upload a valid CSV file.");
                $('#toastuploadcsvfile').toast('show');
            }
        });

        $("#modal_importReceivingItems").on("hidden.bs.modal", function() {
            console.log('Modal Hide');
            $('#importreceiving').val('');
        });
    });
</script>