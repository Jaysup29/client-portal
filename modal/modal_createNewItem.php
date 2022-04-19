<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">New Item</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <div class="container-fluid">
              <div class="row">
                  <div class="col-4 border d-flex align-items-center justify-content-center">
                      <div class="container px-5">
                      <input type="file" name="my_file" />
                      </div>
                  </div>
                  <div class="col-8">
                  <section id="embed">
                        <div id="example-embed" style="display: none;">
                            <h3></h3>
                            <section>
                                <div class="container-fluid p-2">
                                    <div class="row my-3">
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Item Code (Client SKU)</p>
                                            <input type="text" class="form-control">
                                        </div>
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Parent Code</p>
                                            <input type="text" class="form-control">
                                        </div>
                                    </div>

                                    <div class="row my-3">
                                        <div class="col-lg-8">
                                                <p class="fw-light m-0 px-1">Item Description</p>
                                                <input type="text" class="form-control">
                                        </div>
                                        <div class="col-lg-4">
                                                <p class="fw-light m-0 px-1">Weight</p>
                                                <input type="text" class="form-control">
                                        </div>
                                    </div>

                                    <div class="row my-3">
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Material Type</p>
                                            <select class="form-select" aria-label="Default select example" id="select_materialtype">
                                            </select>
                                        </div>
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Storage Category</p>
                                            <select class="form-select" aria-label="Default select example" id="select_storagecategory">
                                            </select>
                                        </div>
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Sub-Category</p>
                                            <select class="form-select" aria-label="Default select example" id="select_subcategory">
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </section>

                            <h3></h3>
                            <section>
                                <div class="container-fluid">
                                    <div class="row my-3">
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Min Temp</p>
                                            <input type="text" class="form-control">
                                        </div>
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Max Temp</p>
                                            <input type="text" class="form-control">
                                        </div>
                                    </div>
                                    <div class="row my-3">
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Length (cm)</p>
                                            <input type="text" class="form-control">
                                        </div>
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Width (cm)</p>
                                            <input type="text" class="form-control">
                                        </div>
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Height (cm)</p>
                                            <input type="text" class="form-control">
                                        </div>
                                    </div>
                                    <div class="row my-3">
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Unit Of Measurement</p>
                                            <select class="form-select" aria-label="Default select example" id="select_uom">
                                            </select>
                                        </div>
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">Pieces Per Case</p>
                                            <input type="text" class="form-control">
                                        </div>
                                    </div>
                                    <div class="row my-3">
                                        <div class="col">
                                            <p class="fw-light m-0 px-1">PAR Level Quantity / Safety Stock Quantity</p>
                                            <input type="text" class="form-control">
                                        </div>
                                    </div>
                                </div>
                            </section>

                            <h3></h3>
                            <section>
                                <div class="row my-3">
                                    <div class="col">
                                        <p class="fw-light m-0 px-1">Shelf Life (Days)</p>
                                        <input type="text" class="form-control">
                                    </div>
                                    <div class="col">
                                        <p class="fw-light m-0 px-1">Price</p>
                                        <input type="text" class="form-control">
                                    </div>
                                </div>
                                <div class="row my-3">
                                    <div class="col">
                                        <p class="fw-light m-0 px-1">Item Movement Classification</p>
                                        <select id="add_item_itemclass" class="form-select">
                                            <option value="Fast Moving">Fast Moving</option>
                                            <option value="Average Moving">Average Moving</option>
                                            <option value="Slow Moving">Slow Moving</option>
                                        </select>
                                    </div>
                                    <div class="col">
                                        <p class="fw-light m-0 px-1">Price Classification</p>
                                        <select id="add_item_priceclass" class="form-select">
                                            <option value="High Value">High Value</option>
                                            <option value="Average Value">Average Value</option>
                                            <option value="Low Value">Low Value</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row my-3">
                                    <div class="col">
                                        <p class="fw-light m-0 px-1">Minimum Pickface Room Quantity</p>
                                        <input type="text" class="form-control">
                                    </div>
                                    <div class="col">
                                        <p class="fw-light m-0 px-1">Maximum Pickface Room Quantity</p>
                                        <input type="text" class="form-control">
                                    </div>
                                </div>
                            </section>
                        </div>
                    </section>
                  </div>
              </div>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Submit</button>
      </div>
    </div>
  </div>
</div>
<script>
$(function(){
    uom();
    storage_category();
    subcategory();
    material_type();

    $("#init-embed").one("click", function(e){
	e.stopPropagation();
	$(this).remove();
    });

    $("#example-embed").show().steps({
        headerTag:"h3",
        bodyTag: "section",
        transitionEffect: "fade"
    });
});
</script>
<!-- 
<div class="row my-3">
                  <div class="col">
                        <p class="fw-light m-0 px-1">Item Code (Client SKU)</p>
                        <input type="text" class="form-control">
                  </div>
                  <div class="col">
                        <p class="fw-light m-0 px-1">Parent Code</p>
                        <input type="text" class="form-control">
                  </div>
                  <div class="col">
                  </div>
              </div>
              <hr class="my-4" />
              <div class="row my-3">
                  <div class="col-lg-8">
                        <p class="fw-light m-0 px-1">Item Description</p>
                        <input type="text" class="form-control">
                  </div>
                  <div class="col-lg-4">
                        <p class="fw-light m-0 px-1">Weight</p>
                        <input type="text" class="form-control">
                  </div>
              </div>
              <hr class="my-4" />
              <div class="row my-3">
                  <div class="row mb-2">
                      <div class="col">
                            <p class="fw-light m-0 px-1">Material Type</p>
                            <input type="text" class="form-control">
                      </div>
                      <div class="col">
                            <p class="fw-light m-0 px-1">Storage Category</p>
                            <input type="text" class="form-control">
                      </div>
                      <div class="col">
                            <p class="fw-light m-0 px-1">Sub-Category</p>
                            <input type="text" class="form-control">
                      </div>
                  </div>
                  <div class="row my-3">
                      <div class="col">
                            <p class="fw-light m-0 px-1">Min Temp</p>
                            <input type="text" class="form-control">
                      </div>
                      <div class="col">
                            <p class="fw-light m-0 px-1">Max Temp</p>
                            <input type="text" class="form-control">
                      </div>
                  </div>
              </div>
              <hr class="my-4" />
              <div class="row my-3">
                    <div class="col">
                        <p class="fw-light m-0 px-1">Length (cm)</p>
                        <input type="text" class="form-control">
                    </div>
                    <div class="col">
                        <p class="fw-light m-0 px-1">Width (cm)</p>
                        <input type="text" class="form-control">
                    </div>
                    <div class="col">
                        <p class="fw-light m-0 px-1">Height (cm)</p>
                        <input type="text" class="form-control">
                    </div>
              </div>
              <hr class="my-4" />
              <div class="row my-3">
                    <div class="col">
                        <p class="fw-light m-0 px-1">Unit Of Measurement</p>
                        <input type="text" class="form-control">
                    </div>
                    <div class="col">
                        <p class="fw-light m-0 px-1">Pieces Per Case</p>
                        <input type="text" class="form-control">
                    </div>
                    <div class="col">
                        <p class="fw-light m-0 px-1">PAR Level Quantity / Safety Stock Quantity</p>
                        <input type="text" class="form-control">
                    </div>
              </div>
              <hr class="my-4" />
              <div class="row my-3">
                    <div class="col">
                        <p class="fw-light m-0 px-1">Shelf Life (Days)</p>
                        <input type="text" class="form-control">
                    </div>
                    <div class="col">
                        <p class="fw-light m-0 px-1">Price</p>
                        <input type="text" class="form-control">
                    </div>
              </div>
              <hr class="my-4" />
              <div class="row my-3">
                    <div class="col">
                        <p class="fw-light m-0 px-1">Item Movement Classification</p>
                        <input type="text" class="form-control">
                    </div>
                    <div class="col">
                        <p class="fw-light m-0 px-1">Price Classification</p>
                        <input type="text" class="form-control">
                    </div>
              </div>
              <hr class="my-4" />
              <div class="row my-3">
                    <div class="col">
                        <p class="fw-light m-0 px-1">Minimum Pickface Room Quantity</p>
                        <input type="text" class="form-control">
                    </div>
                    <div class="col">
                        <p class="fw-light m-0 px-1">Maximum Pickface Room Quantity</p>
                        <input type="text" class="form-control">
                    </div>
              </div><div class="row my-3">
                  <div class="col">
                        <p class="fw-light m-0 px-1">Item Code (Client SKU)</p>
                        <input type="text" class="form-control">
                  </div>
                  <div class="col">
                        <p class="fw-light m-0 px-1">Parent Code</p>
                        <input type="text" class="form-control">
                  </div>
                  <div class="col">
                  </div>
              </div>
              <hr class="my-4" />
              <div class="row my-3">
                  <div class="col-lg-8">
                        <p class="fw-light m-0 px-1">Item Description</p>
                        <input type="text" class="form-control">
                  </div>
                  <div class="col-lg-4">
                        <p class="fw-light m-0 px-1">Weight</p>
                        <input type="text" class="form-control">
                  </div>
              </div>
              <hr class="my-4" />
              <div class="row my-3">
                  <div class="row mb-2">
                      <div class="col">
                            <p class="fw-light m-0 px-1">Material Type</p>
                            <input type="text" class="form-control">
                      </div>
                      <div class="col">
                            <p class="fw-light m-0 px-1">Storage Category</p>
                            <input type="text" class="form-control">
                      </div>
                      <div class="col">
                            <p class="fw-light m-0 px-1">Sub-Category</p>
                            <input type="text" class="form-control">
                      </div>
                  </div>
                  <div class="row my-3">
                      <div class="col">
                            <p class="fw-light m-0 px-1">Min Temp</p>
                            <input type="text" class="form-control">
                      </div>
                      <div class="col">
                            <p class="fw-light m-0 px-1">Max Temp</p>
                            <input type="text" class="form-control">
                      </div>
                  </div>
              </div>
              <hr class="my-4" />
              <div class="row my-3">
                    <div class="col">
                        <p class="fw-light m-0 px-1">Length (cm)</p>
                        <input type="text" class="form-control">
                    </div>
                    <div class="col">
                        <p class="fw-light m-0 px-1">Width (cm)</p>
                        <input type="text" class="form-control">
                    </div>
                    <div class="col">
                        <p class="fw-light m-0 px-1">Height (cm)</p>
                        <input type="text" class="form-control">
                    </div>
              </div>
              <hr class="my-4" />
              <div class="row my-3">
                    <div class="col">
                        <p class="fw-light m-0 px-1">Unit Of Measurement</p>
                        <input type="text" class="form-control">
                    </div>
                    <div class="col">
                        <p class="fw-light m-0 px-1">Pieces Per Case</p>
                        <input type="text" class="form-control">
                    </div>
                    <div class="col">
                        <p class="fw-light m-0 px-1">PAR Level Quantity / Safety Stock Quantity</p>
                        <input type="text" class="form-control">
                    </div>
              </div>
              <hr class="my-4" />
              <div class="row my-3">
                    <div class="col">
                        <p class="fw-light m-0 px-1">Shelf Life (Days)</p>
                        <input type="text" class="form-control">
                    </div>
                    <div class="col">
                        <p class="fw-light m-0 px-1">Price</p>
                        <input type="text" class="form-control">
                    </div>
              </div>
              <hr class="my-4" />
              <div class="row my-3">
                    <div class="col">
                        <p class="fw-light m-0 px-1">Item Movement Classification</p>
                        <input type="text" class="form-control">
                    </div>
                    <div class="col">
                        <p class="fw-light m-0 px-1">Price Classification</p>
                        <input type="text" class="form-control">
                    </div>
              </div>
              <hr class="my-4" />
              <div class="row my-3">
                    <div class="col">
                        <p class="fw-light m-0 px-1">Minimum Pickface Room Quantity</p>
                        <input type="text" class="form-control">
                    </div>
                    <div class="col">
                        <p class="fw-light m-0 px-1">Maximum Pickface Room Quantity</p>
                        <input type="text" class="form-control">
                    </div>
              </div> -->