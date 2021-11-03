// Dashboard
    
function loadSKUNo()
{
    $.ajax({
        type: "POST",
        url: "ajax.php",
        data: { function: 'loadSKUNo'},
        success: function(data)
        {   
            // console.log(data);
            $('#searchSKUNo').empty();
            $('#searchSKUNo').append("<option value='0' disabled selected>Select From SKU Number</option>");
            $('#searchSKUNo').append(data);
            
        } 
    });
}

function loadSKUDesc()
{
    $.ajax({
        type: "POST",
        url: "ajax.php",
        data: { function: 'loadSKUDesc'},
        success: function(data)
        {   
            // console.log(data);
            $('#searchSKUDesc').empty();
            $('#searchSKUDesc').append("<option value='0' disabled selected>Select From SKU Description</option>");
            $('#searchSKUDesc').append(data);
            
        } 
    });
}


function filterBySKU(prop)
{
    $("#searchSKU").prop('disabled', false);

    if($('#filterBySKUNo').is(':checked'))
      {
          var filter = 'SKUNo';
      }
      else if($('#filterBySKUDesc').is(':checked'))
      {
          var filter = 'SKUDesc';
      }

      $.ajax({
        type: "POST",
        url: "ajax.php",
        data: { function: 'loadSKUandDesc', filter:filter},
        success: function(data)
        {   
            // console.log(data);
            $('#loadSKUandDesc').empty();
            $('#loadSKUandDesc').append("<option value='0' disabled selected>Select From SKU</option>");
            $('#loadSKUandDesc').append(data);
            
        } 
      });
    
}

// Dashboard

// Reports
function Report_GenerateSOH()
{   
    
    var WarehouseID = $('#warehouse').val();

    console.log(WarehouseID);
    $.ajax({
        type: 'POST',  
        url: 'ajax.php', 
        data: {
            function: 'soh_report',
            WarehouseID:WarehouseID
        },
        dataType: 'json',
        beforeSend: function() 
        {
            $('.spinner-border').show();
        },
        success: function(data) 
        {   
           // console.log(data);     
           $('#soh').DataTable({

               "data": data,
                dom: 'lBfrtip',
                autoWidth: false,
                responsive: true,
                buttons: [
                    { extend: 'copyHtml5', footer: true,
                      exportOptions: {
                            columns: [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ]
                        }
                    },
                    { extend: 'excelHtml5', footer: true,
                      exportOptions: {
                            columns: [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ]
                        } 
                    },
                    { extend: 'csvHtml5', footer: true,
                      exportOptions: {
                            columns: [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ]
                        } 
                    },
                    { extend: 'pdfHtml5', footer: true, 
                      exportOptions: {
                            columns: [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ],
                           
                        },
                        orientation: 'landscape',  
                        pageSize: 'LEGAL'
                    }
                ],
                initComplete: function () {
                    var btns = $('.dt-button');
                    btns.addClass('ml-2 mb-2 btn btn-success btn-md');
                    btns.removeClass('dt-button');

                },
            "order": [[ 0, "asc" ]],
            "columnDefs": 
            [
                {
                    "targets": [ 0 ],
                    "visible": false,
                    "searchable": false,
                }
            ],
            "aoColumnDefs": [
                {
                    "targets": 7,
                    "data": "expirydate",
                    "mRender": function(data) {
                        return Date.create(data).format('{dd}-{MM}-{yyyy}');
                    }
                }
            ],
            "columns": [
                    {
                        "data": "itemid"          
                    },
                    {
                        "data": "sku"          
                    },
                    {
                        "data": "item"          
                    },
                    {
                        "data": "qty"          
                    },
                    {
                        "data": "wgt"          
                    },
                    {
                        "data": "oum"          
                    },
                    {
                        "data": "itemstatus"          
                    },
                    {
                        "data": "expirydate",
                         render: function(data, type, row){
                                    if(type === "sort" || type === "type"){
                                        return data;
                                    }else if(data === ''){
                                        return "";
                                    }
                                    return moment(data).format("MMM-D-YYYY");
                                }         
                    },
                    {
                        "data": "batch"          
                    },
                    {
                        "data": "prod"          
                    },
                    {
                        "data": "cvnumber"          
                    },
                    {
                        "data": "otherref"          
                    },
                    {
                        "data": "controlno"          
                    }

                ],
               "bPaginate": false,

                  "footerCallback": function ( row, data, start, end, display ) {
                    var api = this.api(), data;
                    var intVal = function ( i ) {
                        return typeof i === 'string' ?
                            i.replace(/[\$,]/g, '')*1 :
                            typeof i === 'number' ?
                                i : 0;
                    };
                    
                    // Total over all pages
                    total = api
                        .column( 3 )
                        .data()
                        .reduce( function (a, b) {
                            return intVal(a) + intVal(b);
                        }, 0 );
         
                    // Total over this page
                    pageTotal = api
                        .column( 3, { page: 'current'} )
                        .data()
                        .reduce( function (a, b) {
                            return intVal(a) + intVal(b);
                        }, 0 );
         
                    // Update footer
                    $( api.column( 3 ).footer() ).html(
                        pageTotal
                    );

                    // Total over all pages
                    total = api
                        .column( 4 )
                        .data()
                        .reduce( function (a, b) {
                            return intVal(a) + intVal(b);
                        }, 0 );
         
                    // Total over this page
                    pageTotal = api
                        .column( 4, { page: 'current'} )
                        .data()
                        .reduce( function (a, b) {
                            var num = intVal(a) + intVal(b);
                            num = Math.round(num * 100) / 100;

                            return num;
                        }, 0 );
         
                    // Update footer
                    $( api.column( 4 ).footer() ).html(
                        pageTotal
                    );
                }

            });

           // $('title').html("Stock On-Hand Report As Of " + today);
        },

        complete: function()
        {  
            $('.spinner-border').hide();
        }

    });

}

function filteredSOH(prop)
{   
    var CustomerID = $('#cus_id').val();
    var WarehouseID = $('#warehouse').val();

    console.log(WarehouseID);
    $('#soh').DataTable().destroy();
    $('#soh_body').empty();

    $("#search").prop('disabled', false);

    $('#search').val('');

    $( '#search' ).keyup(function() 
    {
        var search = $('#search').val();
        searching(search);
    });

    $.ajax({
    type: 'POST',  
    url: 'ajax.php', 
    data: {
        function: 'filteredSOH',
        filtered: prop, 
        CustomerID:CustomerID, 
        WarehouseID:WarehouseID
    },
    dataType: 'json',
    beforeSend: function() 
    {
        $('.spinner-border').show();
    },
    success: function(data) 
    {   
        // console.log(data);
        $('#soh').DataTable({

           "data": data,
            dom: 'Bfrtip',
            autoWidth: false,
            responsive: true,
            searching:true,
            buttons: [
                { extend: 'copyHtml5', footer: true,
                  exportOptions: {
                        columns: [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ]
                    }
                },
                { extend: 'excelHtml5', footer: true,
                  exportOptions: {
                        columns: [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ]
                    } 
                },
                { extend: 'csvHtml5', footer: true,
                  exportOptions: {
                        columns: [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ]
                    } 
                },
                { extend: 'pdfHtml5', footer: true, 
                  exportOptions: {
                        columns: [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ],
                       
                    },
                    orientation: 'landscape',  
                    pageSize: 'LEGAL'
                }
            ],
            initComplete: function () {
                var btns = $('.dt-button');
                btns.addClass('ml-2 mb-2 btn btn-success btn-md');
                btns.removeClass('dt-button');

            },
            "aaSorting": [],
            "columnDefs": 
            [
                {
                    "targets": [ 0 ],
                    "visible": false,
                    "searchable": false,
                }
            ],
            "aoColumnDefs": [
                {
                    "targets": 7,
                    "data": "expirydate",
                    "mRender": function(data) {
                        return Date.create(data).format('{dd}-{MM}-{yyyy}');
                    }
                }
            ],
            "columns": [
                    {
                        "data": "itemid"          
                    },
                    {
                        "data": "sku"          
                    },
                    {
                        "data": "item"          
                    },
                    {
                        "data": "qty"          
                    },
                    {
                        "data": "wgt"          
                    },
                    {
                        "data": "oum"          
                    },
                    {
                        "data": "itemstatus"          
                    },
                    {
                        "data": "expirydate",
                         render: function(data, type, row){
                                    if(type === "sort" || type === "type"){
                                        return data;
                                    }else if(data === ''){
                                        return "";
                                    }
                                    return moment(data).format("MMM-D-YYYY");
                                }         
                    },
                    {
                        "data": "batch"          
                    },
                    {
                        "data": "prod"          
                    },
                    {
                        "data": "cvnumber"          
                    },
                    {
                        "data": "otherref"          
                    },
                    {
                        "data": "controlno"          
                    }
                ],
               "bPaginate": false,
               "footerCallback": function ( row, data, start, end, display ) {
                        var api = this.api(), data;
             
                        // Remove the formatting to get integer data for summation
                        var intVal = function ( i ) {
                            return typeof i === 'string' ?
                                i.replace(/[\$,]/g, '')*1 :
                                typeof i === 'number' ?
                                    i : 0;
                        };
                        
                        // Total over all pages
                        total = api
                            .column( 3 )
                            .data()
                            .reduce( function (a, b) {
                                return intVal(a) + intVal(b);
                            }, 0 );
             
                        // Total over this page
                        pageTotal = api
                            .column( 3, { page: 'current'} )
                            .data()
                            .reduce( function (a, b) {
                                return intVal(a) + intVal(b);
                            }, 0 );
             
                        // Update footer
                        $( api.column( 3 ).footer() ).html(
                            pageTotal
                        );

                        // Total over all pages
                        total = api
                            .column( 4 )
                            .data()
                            .reduce( function (a, b) {
                                return intVal(a) + intVal(b);
                            }, 0 );
             
                        // Total over this page
                        pageTotal = api
                            .column( 4, { page: 'current'} )
                            .data()
                            .reduce( function (a, b) {
                                var num = intVal(a) + intVal(b);
                                num = Math.round(num * 100) / 100;

                                return num;
                            }, 0 );
             
                        // Update footer
                        $( api.column( 4 ).footer() ).html(
                            pageTotal
                        );
                    }


            });
        },
        complete: function()
        {  
            $('.spinner-border').hide();
        }
    });
    

}

function searching(key)
{   
    var CustomerID = $('#cus_id').val();
    var WarehouseID = $('#warehouse').val();
    $('#soh').DataTable().destroy();
    $('#soh_body').empty();

    if($('#container').is(':checked'))
    {
        var filter = 'container';
    }
    else if($('#item').is(':checked'))
    {
        var filter = 'item';
    }
    else if($('#batch').is(':checked'))
    {
        var filter = 'batch';
    }
    else if($('#status').is(':checked'))
    {
        var filter = 'status';
    }
    else if($('#ref').is(':checked'))
    {
        var filter = 'ref';
    }

    $.ajax({
        type: 'POST',  
        url: 'ajax.php', 
        data: { 
            function: 'searchSOH',
            filtered: filter, 
            key:key, 
            CustomerID:CustomerID,
            WarehouseID:WarehouseID
        },
        dataType: 'json',
        beforeSend: function() 
        {
            $('.spinner-border').show();
        },
        success: function(data) 
        {   
            $('#soh').DataTable().destroy();
            // console.log(data);
            $('#soh').DataTable({

               "data": data,
                dom: 'Bfrtip',
                autoWidth: false,
                responsive: true,
                searching:true,
                buttons: [
                    { extend: 'copyHtml5', footer: true,
                      exportOptions: {
                            columns: [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ]
                        }
                    },
                    { extend: 'excelHtml5', footer: true,
                      exportOptions: {
                            columns: [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ]
                        } 
                    },
                    { extend: 'csvHtml5', footer: true,
                      exportOptions: {
                            columns: [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ]
                        } 
                    },
                    { extend: 'pdfHtml5', footer: true, 
                      exportOptions: {
                            columns: [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ],
                           
                        },
                        orientation: 'landscape',  
                        pageSize: 'LEGAL'
                    }
                ],
                initComplete: function () {
                    var btns = $('.dt-button');
                    btns.addClass('ml-2 mb-2 btn btn-success btn-md');
                    btns.removeClass('dt-button');

                },
                "aaSorting": [],
                "columnDefs": 
                [
                    {
                        "targets": [ 0 ],
                        "visible": false,
                        "searchable": false,
                    }
                ],
                "aoColumnDefs": [
                    {
                        "targets": 7,
                        "data": "expirydate",
                        "mRender": function(data) {
                            return Date.create(data).format('{dd}-{MM}-{yyyy}');
                        }
                    }
                ],
                "columns": [
                        {
                            "data": "itemid"          
                        },
                        {
                            "data": "sku"          
                        },
                        {
                            "data": "item"          
                        },
                        {
                            "data": "qty"          
                        },
                        {
                            "data": "wgt"          
                        },
                        {
                            "data": "oum"          
                        },
                        {
                            "data": "itemstatus"          
                        },
                        {
                            "data": "expirydate",
                             render: function(data, type, row){
                                        if(type === "sort" || type === "type"){
                                            return data;
                                        }else if(data === ''){
                                            return "";
                                        }
                                        return moment(data).format("MMM-D-YYYY");
                                    }         
                        },
                        {
                            "data": "batch"          
                        },
                        {
                            "data": "prod"          
                        },
                        {
                            "data": "cvnumber"          
                        },
                        {
                        "data": "otherref"          
                        },
                        {
                            "data": "controlno"          
                        }
                ],
               "bPaginate": false,
               "footerCallback": function ( row, data, start, end, display ) {
                    var api = this.api(), data;
         
                    // Remove the formatting to get integer data for summation
                    var intVal = function ( i ) {
                        return typeof i === 'string' ?
                            i.replace(/[\$,]/g, '')*1 :
                            typeof i === 'number' ?
                                i : 0;
                    };
                    
                    // Total over all pages
                    total = api
                        .column( 3 )
                        .data()
                        .reduce( function (a, b) {
                            return intVal(a) + intVal(b);
                        }, 0 );
         
                    // Total over this page
                    pageTotal = api
                        .column( 3, { page: 'current'} )
                        .data()
                        .reduce( function (a, b) {
                            return intVal(a) + intVal(b);
                        }, 0 );
         
                    // Update footer
                    $( api.column( 3 ).footer() ).html(
                        pageTotal
                    );

                    // Total over all pages
                    total = api
                        .column( 4 )
                        .data()
                        .reduce( function (a, b) {
                            return intVal(a) + intVal(b);
                        }, 0 );
         
                    // Total over this page
                    pageTotal = api
                        .column( 4, { page: 'current'} )
                        .data()
                        .reduce( function (a, b) {
                            var num = intVal(a) + intVal(b);
                            num = Math.round(num * 100) / 100;

                            return num;
                        }, 0 );
         
                    // Update footer
                    $( api.column( 4 ).footer() ).html(
                        pageTotal
                    );
                }

            });
        },

        complete: function()
        {
            
            $('.spinner-border').hide();
        }
    });

    $('#soh').DataTable().destroy();

}

function Report_GenerateAgeing()
{   
    var CustomerID = $('#cus_id').val();
    var WarehouseID = $('#warehouse').val();

    $.ajax({
        type: 'POST',  
        url: 'ajax.php', 
        data: {
            function: 'ageing_report',
            CustomerID:CustomerID,
            WarehouseID:WarehouseID
        },
        dataType: 'json',
        beforeSend: function() 
        {
            $('.spinner-border').show();
        },
        success: function(data) 
        {      
            // console.log(data);
            $('#ageing').DataTable({

                "data": data,
                autoWidth:false,
                dom: 'Bfrtip',
                responsive: true,
                searching:true,
                buttons: [
                    { extend: 'copyHtml5', footer: true },
                    { extend: 'excelHtml5', footer: true },
                    { extend: 'csvHtml5', footer: true },
                    { extend: 'pdfHtml5', footer: true, 
                        orientation: 'landscape',  pageSize: 'LEGAL'
                    }
                ],
                columnDefs: [
                   {"targets": 9, "orderable": false }
                 ],
                initComplete: function () {
                    var btns = $('.dt-button');
                    btns.addClass('ml-2 btn btn-success btn-md');
                    btns.removeClass('dt-button');

                },
                "order": [[ 8, "asc" ]],
                "columns": [
                        {
                            "data": "sku"          
                        },
                        {
                            "data": "item"          
                        },
                        {
                            "data": "oum"          
                        },
                        {
                            "data": "qty",          
                        },
                        {
                            "data": "wgt", 
                            render: $.fn.dataTable.render.number(',', '.', 2, '')          
                        },
                        {
                            "data": "cvnumber"          
                        },
                        {
                            "data": "otherref"          
                        },
                        {
                            "data": "batch"          
                        },
                        {
                            "data": "expirydate",
                            render: function(data, type, row){
                                if(type === "sort" || type === "type"){
                                    return data;
                                }else if(data === ''){
                                    return "";
                                }
                                return moment(data).format("MMM-D-YYYY");
                            }
                           
                        },
                        {
                            "data": "expiring"          
                        }
                    ],
                    "bPaginate": false,
                    "footerCallback": function ( row, data, start, end, display ) {
                        var api = this.api(), data;
             
                        // Remove the formatting to get integer data for summation
                        var intVal = function ( i ) {
                            return typeof i === 'string' ?
                                i.replace(/[\$,]/g, '')*1 :
                                typeof i === 'number' ?
                                    i : 0;
                        };
                        
                        // Total over all pages
                        total = api
                            .column( 3 )
                            .data()
                            .reduce( function (a, b) {
                                return intVal(a) + intVal(b);
                            }, 0 );
             
                        // Total over this page
                        pageTotal = api
                            .column( 3, { page: 'current'} )
                            .data()
                            .reduce( function (a, b) {
                                return intVal(a) + intVal(b);
                            }, 0 );
             
                        // Update footer
                        $( api.column( 3 ).footer() ).html(
                            pageTotal
                        );

                        // Total over all pages
                        total = api
                            .column( 4 )
                            .data()
                            .reduce( function (a, b) {
                                return intVal(a) + intVal(b);
                            }, 0 );
             
                        // Total over this page
                        pageTotal = api
                            .column( 4, { page: 'current'} )
                            .data()
                            .reduce( function (a, b) {
                                var num = intVal(a) + intVal(b);
                                num = Math.round(num * 100) / 100;

                                return num;
                            }, 0 );
             
                        // Update footer
                        $( api.column( 4 ).footer() ).html(
                            pageTotal
                        );
                    }

            });
        },
        complete: function()
        {
            
            $('.spinner-border').hide();
        }
    });
    
}

function filteredAgeing(prop)
{
    var CustomerID = $('#cus_id').val();
    var WarehouseID = $('#warehouse').val();

    console.log(CustomerID);
    $('#ageing').DataTable().destroy();
    $('#ageing_body').empty();

    $("#search").prop('disabled', false);

    $('#search').val('');

    $( '#search' ).keyup(function() 
    {
        var search = $('#search').val();
        searchingAgeing(search);
    });

    $.ajax({
        type: 'POST',  
        url: 'ajax.php', 
        data: {
            function: 'filteredAgeing',
            filtered: prop, 
            CustomerID:CustomerID,
            WarehouseID:WarehouseID
        },
        dataType: 'json',
        beforeSend: function() 
        {
            $('.spinner-border').show();
        },
        success: function(data) 
        {      
            // console.log(data);
            $('#ageing').DataTable({

                "data": data,
                autoWidth:false,
                dom: 'Bfrtip',
                responsive: true,
                searching:true,
                buttons: [
                    { extend: 'copyHtml5', footer: true },
                    { extend: 'excelHtml5', footer: true },
                    { extend: 'csvHtml5', footer: true },
                    { extend: 'pdfHtml5', footer: true, 
                        orientation: 'landscape',  pageSize: 'LEGAL'
                    }
                ],
                columnDefs: [
                   {"targets": 9, "orderable": false }
                 ],
                initComplete: function () {
                    var btns = $('.dt-button');
                    btns.addClass('ml-2 btn btn-success btn-md');
                    btns.removeClass('dt-button');

                },
                "aaSorting": [],
                "columns": [
                        {
                            "data": "sku"          
                        },
                        {
                            "data": "item"          
                        },
                        {
                            "data": "oum"          
                        },
                        {
                            "data": "qty",          
                        },
                        {
                            "data": "wgt", 
                            render: $.fn.dataTable.render.number(',', '.', 2, '')          
                        },
                        {
                            "data": "cvnumber"          
                        },
                        {
                            "data": "otherref"          
                        },
                        {
                            "data": "batch"          
                        },
                        {
                            "data": "expirydate",
                            render: function(data, type, row){
                                if(type === "sort" || type === "type"){
                                    return data;
                                }else if(data === ''){
                                    return "";
                                }
                                return moment(data).format("MMM-D-YYYY");
                            }
                           
                        },
                        {
                            "data": "expiring"          
                        }
                    ],
                    "bPaginate": false,
                    "footerCallback": function ( row, data, start, end, display ) {
                        var api = this.api(), data;
             
                        // Remove the formatting to get integer data for summation
                        var intVal = function ( i ) {
                            return typeof i === 'string' ?
                                i.replace(/[\$,]/g, '')*1 :
                                typeof i === 'number' ?
                                    i : 0;
                        };
                        
                        // Total over all pages
                        total = api
                            .column( 3 )
                            .data()
                            .reduce( function (a, b) {
                                return intVal(a) + intVal(b);
                            }, 0 );
             
                        // Total over this page
                        pageTotal = api
                            .column( 3, { page: 'current'} )
                            .data()
                            .reduce( function (a, b) {
                                return intVal(a) + intVal(b);
                            }, 0 );
             
                        // Update footer
                        $( api.column( 3 ).footer() ).html(
                            pageTotal
                        );

                        // Total over all pages
                        total = api
                            .column( 4 )
                            .data()
                            .reduce( function (a, b) {
                                return intVal(a) + intVal(b);
                            }, 0 );
             
                        // Total over this page
                        pageTotal = api
                            .column( 4, { page: 'current'} )
                            .data()
                            .reduce( function (a, b) {
                                var num = intVal(a) + intVal(b);
                                num = Math.round(num * 100) / 100;

                                return num;
                            }, 0 );
             
                        // Update footer
                        $( api.column( 4 ).footer() ).html(
                            pageTotal
                        );
                    }
            });
        },
        complete: function()
        {
            
            $('.spinner-border').hide();
        }
    });
}

function searchingAgeing(key)
{
    var CustomerID = $('#cus_id').val();
    var WarehouseID = $('#warehouse').val();

    
    $('#ageing').DataTable().destroy();
    $('#ageing_body').empty();

    if($('#container').is(':checked'))
    {
        var filter = 'container';
    }
    else if($('#batch').is(':checked'))
    {
        var filter = 'batch';
    }
    else if($('#ref').is(':checked'))
    {
        var filter = 'ref';
    }

    $.ajax({
        type: 'POST',  
        url: 'ajax.php', 
        data: {
            function: 'searchAgeing',
            filtered: filter, 
            key:key, 
            CustomerID:CustomerID,
            WarehouseID:WarehouseID
        },
        dataType: 'json',
        beforeSend: function() 
        {
            $('.spinner-border').show();
        },
        success: function(data) 
        {    
            $('#ageing').DataTable().destroy();
            // console.log(data);
            $('#ageing').DataTable({

                "data": data,
                autoWidth:false,
                dom: 'Bfrtip',
                responsive: true,
                searching:true,
                buttons: [
                    { extend: 'copyHtml5', footer: true },
                    { extend: 'excelHtml5', footer: true },
                    { extend: 'csvHtml5', footer: true },
                    { extend: 'pdfHtml5', footer: true, 
                        orientation: 'landscape',  pageSize: 'LEGAL'
                    }
                ],
                columnDefs: [
                   {"targets": 9, "orderable": false }
                 ],
                initComplete: function () {
                    var btns = $('.dt-button');
                    btns.addClass('ml-2 btn btn-success btn-md');
                    btns.removeClass('dt-button');

                },
                "aaSorting": [],
                "columns": [
                        {
                            "data": "sku"          
                        },
                        {
                            "data": "item"          
                        },
                        {
                            "data": "oum"          
                        },
                        {
                            "data": "qty",          
                        },
                        {
                            "data": "wgt", 
                            render: $.fn.dataTable.render.number(',', '.', 2, '')          
                        },
                        {
                            "data": "cvnumber"          
                        },
                        {
                            "data": "otherref"          
                        },
                        {
                            "data": "batch"          
                        },
                        {
                            "data": "expirydate",
                            render: function(data, type, row){
                                if(type === "sort" || type === "type"){
                                    return data;
                                }else if(data === ''){
                                    return "";
                                }
                                return moment(data).format("MMM-D-YYYY");
                            }
                           
                        },
                        {
                            "data": "expiring"          
                        }
                    ],
                    "bPaginate": false,
                    "footerCallback": function ( row, data, start, end, display ) {
                        var api = this.api(), data;
             
                        // Remove the formatting to get integer data for summation
                        var intVal = function ( i ) {
                            return typeof i === 'string' ?
                                i.replace(/[\$,]/g, '')*1 :
                                typeof i === 'number' ?
                                    i : 0;
                        };
                        
                        // Total over all pages
                        total = api
                            .column( 3 )
                            .data()
                            .reduce( function (a, b) {
                                return intVal(a) + intVal(b);
                            }, 0 );
             
                        // Total over this page
                        pageTotal = api
                            .column( 3, { page: 'current'} )
                            .data()
                            .reduce( function (a, b) {
                                return intVal(a) + intVal(b);
                            }, 0 );
             
                        // Update footer
                        $( api.column( 3 ).footer() ).html(
                            pageTotal
                        );

                        // Total over all pages
                        total = api
                            .column( 4 )
                            .data()
                            .reduce( function (a, b) {
                                return intVal(a) + intVal(b);
                            }, 0 );
             
                        // Total over this page
                        pageTotal = api
                            .column( 4, { page: 'current'} )
                            .data()
                            .reduce( function (a, b) {
                                var num = intVal(a) + intVal(b);
                                num = Math.round(num * 100) / 100;

                                return num;
                            }, 0 );
             
                        // Update footer
                        $( api.column( 4 ).footer() ).html(
                            pageTotal
                        );
                    }



            });
        },
        complete: function()
        {
            
            $('.spinner-border').hide();
        }
    });

    $('#ageing').DataTable().destroy();
}

function Report_GenerateDTR()
{
    var dates = $('#dir_dates').val();
    dates = dates.split(" - ");
    var datefrom = dates[0];
    var dateto = dates[1];
    var CustomerID = $('#cus_id').val();

    console.log(datefrom);
    console.log(dateto);

    if(datefrom == null || datefrom == '')
    {
        datefrom = '2001-01-01T09:10'
    }
    else
    {
        datefrom = dates[0];
    }

    if(dateto == null || dateto == '')
    {
        dateto = '2031-01-01T09:10'
    }
    else
    {
        dateto = dates[1];
    }

     $.ajax({
        type: 'POST',  
        url: 'ajax.php', 
        data: {
            function: 'Report_GenerateDTR',
            datefrom:datefrom,
            dateto:dateto,
            CustomerID:CustomerID
            
        },
        dataType: 'json',
        success: function(data) 
        {  
           // console.log(data);
           $('#DTR').DataTable({
                "data": data,
                dom: 'Bfrtip',
                responsive: true,
                searching:true,
                buttons: [
                    { extend: 'copyHtml5', footer: true,
                          exportOptions: {
                                columns: [ 0, 1, 2, 3, 4, 5, 6, 7, 8 ]
                            }
                        },
                        { extend: 'excelHtml5', footer: true,
                          exportOptions: {
                                columns: [ 0, 1, 2, 3, 4, 5, 6, 7, 8 ]
                            } 
                        },
                        { extend: 'csvHtml5', footer: true,
                          exportOptions: {
                                columns: [ 0, 1, 2, 3, 4, 5, 6, 7, 8 ]
                            } 
                        },
                        { extend: 'pdfHtml5', footer: true, 
                          exportOptions: {
                                columns: [ 0, 1, 2, 3, 4, 5, 6, 7, 8 ],
                               
                            },
                            orientation: 'landscape',  
                            pageSize: 'LEGAL'
                        }
                ],
                initComplete: function () {
                    var btns = $('.dt-button');
                    btns.addClass('ml-2 btn btn-success btn-md');
                    btns.removeClass('dt-button');

                },
                "order": [[ 0, "asc" ]],
                "columns": [
                        {
                            "data": "recDate"
                        },
                        {
                            "data": "controlno"          
                        },
                        {
                            "data": "ref"          
                        },
                        {
                            "data": "sku"          
                        },
                        {
                            "data": "desc"          
                        },
                        {
                            "data": "qty"          
                        },
                        {
                            "data": "wgt",
                            render: $.fn.dataTable.render.number(',', '.', 2, '')          
                        },
                        {
                            "data": "container"          
                        },
                        {
                            "data": "remarks"          
                        }
                        

                    ],
                    "bPaginate": false,
                    "autoWidth": false
            });
        },
        complete: function()
        {
            
            $('.spinner-border').hide();
        }

    });

}

function Report_GenerateGM()
{   

    var CustomerID = $('#cus_id').val();
    var ItemID = $('#loadItem').val();
    var SubFilter = $('#subfilter').val();
    var Co_SubFilter = $('#subfilter2').val();

    var dates = $('#dir_dates').val();
    dates = dates.split(" - ");
    var datefrom = dates[0];
    var dateto = dates[1];
    
    $('#modal_load').modal({
        backdrop: 'static',
        keyboard: false
    });
    $.ajax({
        type: "POST",
        url: "ajax.php",
        data: {
            function: 'Report_GenerateGM',
            CustomerID:CustomerID,
            ItemID:ItemID,
            SubFilter:SubFilter,
            Co_SubFilter:Co_SubFilter,
            datefrom:datefrom,
            dateto:dateto
        },
        success: function(data)
        {   
           console.log(data);
           $('#GM_table').empty();
           $('#GM_table').append(data);
        },
        complete: function()
        {
            setTimeout(function() 
            {
                $('#modal_load').modal('hide');
            }, 1000);
        }
    });
}

function Report_GenerateITR()
{   

    var dates = $('#itr_dates').val();
    dates = dates.split(" - ");
    var datefrom = dates[0];
    var dateto = dates[1];
    var WarehouseID = $('#warehouse').val();

    if($('#container').is(':checked'))
    {
        var filter = 'Container';
    }
    else if($('#controlno').is(':checked'))
    {
        var filter = 'IBN';
    }
    else if($('#status').is(':checked'))
    {
        var filter = 'StatusID';
    }
    else
    {
        var filter = '';
    }

    var searchkey = $('#search').val();

    $('#modal_load').modal({
        backdrop: 'static',
        keyboard: false
    });

    $.ajax({
        type: 'POST',  
        url: 'ajax.php', 
        data: {
            function: 'Report_GenerateITR',
            datefrom:datefrom,
            dateto:dateto,
            WarehouseID:WarehouseID,
            filter:filter,
            searchkey:searchkey
        },
        dataType: 'json',
        success: function(data) 
        { 
            console.log(data);
            $('#itr').DataTable({
              "data":data,
              dom: 'Bfrtip',
              responsive: true,
              searching:true,
              buttons: [
              { extend: 'copyHtml5', footer: true },
              { extend: 'excelHtml5', footer: true },
              { extend: 'csvHtml5', footer: true },
              { extend: 'pdfHtml5', footer: true, 
              orientation: 'landscape',  pageSize: 'LEGAL'
              }
              ],
              "order": [[ 0, "desc" ]],
              "columns": [
                {
                    "data": "recDate",     
                },
                {
                    "data": "controlno"          
                },
                {
                    "data": "goodqty"          
                },
                {
                    "data": "holdqty"          
                },
                {
                    "data": "blockqty"          
                },
                {
                    "data": "qty"          
                },
                {
                    "data": "wgt",
                    render: $.fn.dataTable.render.number(',', '.', 2, '')          
                },
                {
                    "data": "container"          
                },
                // {
                //     "data": "checker"          
                // },
                {
                    "data": "status"          
                },
                {
                    "data": "remarks"          
                },
                {
                    "data": "action"          
                }

            ],
              initComplete: function () {
                  var btns = $('.dt-button');
                  btns.addClass('ml-2 btn btn-success btn-md');
                  btns.removeClass('dt-button');

              },
              "bPaginate": false,
            });
        },
         complete: function()
        {
            setTimeout(function() 
            {
                $('#modal_load').modal('hide');
            }, 1000);
        }
    });


    if(datefrom != null || datefrom != '')
    {
        $('#itr').DataTable().destroy();
    }
}

function view_details_itr(IBN)
{
    $('#view_details_itr').modal();

    $('#view_details_itr').attr('assetid');
    var IBN = IBN;
    $.ajax({
        type: 'POST',  
        url: 'ajax.php', 
        data: {
            function: 'Report_GenerateITRDetails',
            IBN:IBN
        },
        dataType: 'json',
        success: function(data) 
        { 
            console.log(data);
            $('#itr_details').DataTable({
              "data":data,
              responsive: true,
              searching:true,
              "aaSorting": [],
              "columns": [
                {
                    "data": "recDate",     
                },
                {
                    "data": "controlno"          
                },
                {
                    "data": "itemcode"          
                },
                {
                    "data": "mtype"          
                },
                {
                    "data": "qty"          
                },
                {
                    "data": "wgt",
                    render: $.fn.dataTable.render.number(',', '.', 2, '')          
                },
                {
                    "data": "itemstat"          
                },
                {
                    "data": "container"          
                },
                {
                    "data": "status"          
                },
                {
                    "data": "remarks"          
                }

            ],
              initComplete: function () {
                  var btns = $('.dt-button');
                  btns.addClass('ml-2 btn btn-success btn-md');
                  btns.removeClass('dt-button');

              },
              "bPaginate": false,
              "footerCallback": function ( row, data, start, end, display ) {
                    var api = this.api(), data;
         
                    // Remove the formatting to get integer data for summation
                    var intVal = function ( i ) {
                        return typeof i === 'string' ?
                            i.replace(/[\$,]/g, '')*1 :
                            typeof i === 'number' ?
                                i : 0;
                    };
                    
                    // Total over all pages
                    total = api
                        .column( 4 )
                        .data()
                        .reduce( function (a, b) {
                            return intVal(a) + intVal(b);
                        }, 0 );
         
                    // Total over this page
                    pageTotal = api
                        .column( 4, { page: 'current'} )
                        .data()
                        .reduce( function (a, b) {
                            return intVal(a) + intVal(b);
                        }, 0 );
         
                    // Update footer
                    $( api.column( 4 ).footer() ).html(
                        pageTotal
                    );

                    // Total over all pages
                    total = api
                        .column( 5 )
                        .data()
                        .reduce( function (a, b) {
                            return intVal(a) + intVal(b);
                        }, 0 );
         
                    // Total over this page
                    pageTotal = api
                        .column( 5, { page: 'current'} )
                        .data()
                        .reduce( function (a, b) {
                            var num = intVal(a) + intVal(b);
                            num = Math.round(num * 100) / 100;

                            return num;
                        }, 0 );
         
                    // Update footer
                    $( api.column( 5 ).footer() ).html(
                        pageTotal
                    );
                }
            });
        },
         complete: function()
        {
            setTimeout(function() 
            {
                $('#modal_load').modal('hide');
            }, 1000);
        }
    });


    if(IBN != null || IBN != '')
    {
        $('#itr_details').DataTable().destroy();
    }
}

function filteredITR(prop)
{   
    
    $("#search").prop('disabled', false);

}

function Report_GenerateDOR()
{   

    var dates = $('#dor_dates').val();
    dates = dates.split(" - ");
    var datefrom = dates[0];
    var dateto = dates[1];
    var WarehouseID = $('#warehouse').val();

    var search = $("#search").val();

    if($('#container').is(':checked'))
    {
        var filter = 'Container';
    }
    else if($('#controlno').is(':checked'))
    {
        var filter = 'controlno';
    }
    else if($('#status').is(':checked'))
    {
        var filter = 'StatusID';
    }
    else
    {
        var filter = '';
    }
    $('#modal_load').modal({
        backdrop: 'static',
        keyboard: false
    });

    $.ajax({
        type: 'POST',  
        url: 'ajax.php', 
        data: {
            function: 'Report_GenerateDOR',
            datefrom:datefrom,
            dateto:dateto,
            WarehouseID:WarehouseID,
            search:search,
            filter:filter
        },
        dataType: 'json',
        success: function(data) 
        { 
            console.log(data);
            $('#dor').DataTable({
              "data":data,
              processing: true,
              dom: 'Bfrtip',
              responsive: true,
              searching:true,
              buttons: [
                  { extend: 'copyHtml5', footer: true },
                  { extend: 'excelHtml5', footer: true },
                  { extend: 'csvHtml5', footer: true },
                  { extend: 'pdfHtml5', footer: true, 
                  orientation: 'landscape',  pageSize: 'LEGAL'
                  }
              ],
              // processing: true,
              // serverSide: true,
              "aaSorting": [],
              "columns": [
                {
                    "data": "recDate",     
                },
                {
                    "data": "controlno"          
                },
                {
                    "data": "ref"          
                },
                {
                    "data": "qty"          
                },
                {
                    "data": "wgt",
                    render: $.fn.dataTable.render.number(',', '.', 2, '')          
                },
                {
                    "data": "container"          
                },
                {
                    "data": "checker"          
                },
                {
                    "data": "status"          
                },
                {
                    "data": "remarks"          
                }

            ],
              initComplete: function () {
                  var btns = $('.dt-button');
                  btns.addClass('ml-2 btn btn-success btn-md');
                  btns.removeClass('dt-button');

              },
              "bPaginate": false
            });
        },
        complete: function()
        {
            setTimeout(function() 
            {
                $('#modal_load').modal('hide');
            }, 1000);
        }
    });


    if(datefrom != null || datefrom != '')
    {
        $('#dor').DataTable().destroy();
    }
}

function Report_GenerateDOR2()
{   

    var dates = $('#dor_dates').val();
    dates = dates.split(" - ");
    var datefrom = dates[0];
    var dateto = dates[1];
    var WarehouseID = $('#warehouse').val();

    var search = $("#search").val();

    if($('#container').is(':checked'))
    {
        var filter = 'Container';
    }
    else if($('#controlno').is(':checked'))
    {
        var filter = 'controlno';
    }
    else if($('#status').is(':checked'))
    {
        var filter = 'StatusID';
    }
    else
    {
        var filter = '';
    }

    console.log(filter);
    $('#modal_load').modal({
        backdrop: 'static',
        keyboard: false
    });

    $.ajax({
        type: 'POST',  
        url: 'ajax.php', 
        data: {
            function: 'Report_GenerateDOR2',
            datefrom:datefrom,
            dateto:dateto,
            WarehouseID:WarehouseID,
            search:search,
            filter:filter
        },
        dataType: 'json',
        success: function(data) 
        { 
            console.log(data);
            $('#dor2').DataTable({
                  dom: 'Bfrtip',
                  'data':data,
                  responsive: true,
                  searching:true,
                  buttons: [
                  { extend: 'copyHtml5', footer: true },
                  { extend: 'excelHtml5', footer: true },
                  { extend: 'csvHtml5', footer: true },
                  { extend: 'pdfHtml5', footer: true, 
                  orientation: 'landscape',  pageSize: 'LEGAL'
                  }
                  ],
                  "order": [[ 0, "desc" ]],
                  "columns": [
                        {
                            "data": "recDate",     
                        },
                        {
                            "data": "controlord"          
                        },
                        // {
                        //     "data": "controlpck"          
                        // },
                        // {
                        //     "data": "controlobd"          
                        // },
                        // {
                        //     "data": "ref"          
                        // },
                        {
                            "data": "qty"          
                        },
                        {
                            "data": "wgt",
                            // render: $.fn.dataTable.render.number(',', '.', 2, '')          
                        },
                        {
                            "data": "container"          
                        },
                        // {
                        //     "data": "checker"          
                        // },
                        {
                            "data": "status"          
                        },
                        {
                            "data": "remarks"          
                        }

                    ],
                  initComplete: function () {
                      var btns = $('.dt-button');
                      btns.addClass('ml-2 btn btn-success btn-md');
                      btns.removeClass('dt-button');

                  },
                  "bPaginate": false,
                });
        },
        complete: function()
        {
            setTimeout(function() 
            {
                $('#modal_load').modal('hide');
            }, 1000);
        }
    });


    if(datefrom != null || datefrom != '')
    {
        $('#dor2').DataTable().destroy();
    }
}

function filteredDOR(prop)
{   
    
    $("#search").prop('disabled', false);
    
}

function loadItem()
{   
    var customer = $('#cus_id').val();
     $.ajax({
        type: "POST",
        url: "ajax.php",
        data: { function: 'loadItem', customer:customer},
        success: function(data)
        {   
            // console.log(data);
            $('#loadItem').empty();
            $('#loadItem').append("<option value='0' disabled selected>Please Select From Item</option>");
            $('#loadItem').append(data);
            
        } 
    });
}

function loadSubfilterGM()
{   
    $("#loadItem").change(function()
    {
        $.ajax({
        type: "POST",
        url: "ajax.php",
        data: { function: 'loadSubfilter'},
        success: function(data)
        {   
            // console.log(data);
            $('#subfilter').empty();
            $('#subfilter').append("<option value='0' disabled selected>Please Select From Sub Filter</option>");
            $('#subfilter').append(data);
            
        } 
        });
    });   
}

function loadSubfilter2GM()
{   
    $('#loadItem').change(function(){
        var loadItem=$("#loadItem").val();
        console.log(loadItem);
        $("#subfilter").change(function()
        {
            var subfilter=$("#subfilter").val();
            console.log(subfilter);
            
            $.ajax({
                type: "POST",
                url: "ajax.php",
                data: { function: 'loadSubFilter_GM', subfilter:subfilter, loadItem:loadItem},
                success: function(data)
                {
                    $('#subfilter2').empty();
                    $('#subfilter2').append(data);
                    
                } 
            });
        });
    });
}

function loadWarehouse()
{   
    
     $.ajax({
        type: "POST",
        url: "ajax.php",
        data: { function: 'loadWarehouse'},
        success: function(data)
        {   
            // console.log(data);
            $('#warehouse').empty();
            $('#warehouse').append("<option value='0' disabled selected>Please Select From Warehouse</option>");
            $('#warehouse').append(data);
            
        } 
    });
}

// Reports
    











// Receiving Module
function receiving_ctrlno()
{
    var generate_ibnfield = $('#receiving_IBN').val();
    
    if((generate_ibnfield == null) || (generate_ibnfield == ""))
    {
        $.ajax({
        async: true,
        type: 'POST',
        url: 'ajax.php',
        dataType: 'text',
        data: 
        { 
            function: 'CPGenerateIBN', 
            generate_ibnfield:generate_ibnfield
        },
        success: function(data)
        {
            console.log(data);
            $('#receiving_IBN').val(data);
        }
        });
    }
    else
    {
        alert("Nakagenerate ka na ng inbound code!!!");
    }
}

function getwarehouse()
{
    $.ajax({
        type: 'POST',
        url: 'ajax.php',
        dataType: 'text',
        data: 
        { 
            function: 'Warehouses'
        },
        success: function(data)
        {   
            //console.log(data);
            $('#receiving_selectedWH').empty();
            $('#receiving_selectedWH').append("<option value='0' disabled selected>Please Select From Warehouse</option>");
            $('#receiving_selectedWH').append(data);        
        } 
    });
}

function gettrucktype()
{
    $.ajax({
        type: 'POST',
        url: 'ajax.php',
        dataType: 'text',
        data: 
        { 
            function: 'TruckType'
        },
        success: function(data)
        {   
            //console.log(data);
            $('#receiving_selectedTruck').empty();
            $('#receiving_selectedTruck').append("<option value='0' disabled selected>Please Select From Truck</option>");
            $('#receiving_selectedTruck').append(data);        
        } 
    });
}

function saveASN()
{
    var ibn_no = $('#receiving_IBN').val(); 
    var selected_warehouse = $('#receiving_selectedWH').val();
    var supplier_name = $('#receiving_suppliername').val();
    var container_no = $('#receiving_containerno').val();
    var vehicle_plateno = $('#receiving_vehicleplateno').val();
    var seal_no = $('#receiving_sealno').val();
    var client_rep = $('#receiving_clientrepresentative').val();
    var date_arrival = $('#receiving_datearrive').val();
    var selected_truck = $('#receiving_selectedTruck').val();
    
    if((ibn_no == "") || (ibn_no == null))
    {
        alert("Please provide a control number");
    }
    else
    {
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            dataType: 'text',
            data: 
            { 
                function: 'SubmitASN',
                ibn_no:ibn_no,
                selected_warehouse:selected_warehouse,
                supplier_name:supplier_name,
                container_no:container_no,
                vehicle_plateno:vehicle_plateno,
                seal_no:seal_no,
                client_rep:client_rep,
                date_arrival:date_arrival,
                selected_truck:selected_truck
            },
            success: function(data)
            {
                console.log(data);
                $('#iteminput').removeClass('disabled');
            }
        });
    }
}

function returntopending()
{
    var ibn_no = $('#receiving_IBN').val(); 
    var selected_warehouse = $('#receiving_selectedWH').val();
    var supplier_name = $('#receiving_suppliername').val();
    var container_no = $('#receiving_containerno').val();
    var vehicle_plateno = $('#receiving_vehicleplateno').val();
    var seal_no = $('#receiving_sealno').val();
    var client_rep = $('#receiving_clientrepresentative').val();
    var date_arrival = $('#receiving_datearrive').val();

    $.ajax({
        type: 'POST',
        url: 'ajax.php',
        dataType: 'text',
        data:
        {
            function: 'ReturnToPending',
            ibn_no:ibn_no,
            selected_warehouse:selected_warehouse,
            supplier_name:supplier_name,
            container_no:container_no,
            vehicle_plateno:vehicle_plateno,
            seal_no:seal_no,
            client_rep:client_rep,
            date_arrival:date_arrival
        },
        success: function(data)
        {
            //console.log(data);
        }
    });
}

function receiving_open()
{
    $('#modal_receiving_pending').modal();

    $.ajax({
        type: 'POST',  
        url: 'ajax.php', 
        data: {
            function: 'GetOpenIBNList',
        },
        dataType: 'text',
        success: function(data) 
        {
            //console.log(data); 
            $('#pending_list').empty();
            $('#pending_list').append(data);
        }
    });
}

function receiving_pending()
{
    $('#modal_receiving_pending').modal();

    $.ajax({
        type: 'POST',  
        url: 'ajax.php', 
        data: {
            function: 'GetPendingList',
        },
        dataType: 'text',
        success: function(data) 
        {
            //console.log(data); 
            $('#pending_list').empty();
            $('#pending_list').append(data);
        }
    });
}

function receiving_onprocess()
{
    $('#modal_receiving_pending').modal();

    $.ajax({
        type: 'POST',  
        url: 'ajax.php', 
        data: {
            function: 'GetOnProcessList',
        },
        dataType: 'text',
        success: function(data) 
        {
            //console.log(data); 
            $('#pending_list').empty();
            $('#pending_list').append(data);
        }
    });
}

function open_count()
{
    setInterval( function()
    {
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data:
            {
                function: 'GetOpenCount'
            },
            dataType: 'text',
            success: function(data)
            {
                //console.log(data);
                $('#total_opencount').text(data);
            }
        });
    }, 1500);
}

function pending_count()
{
    setInterval( function()
    {
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data:
            {
                function: 'GetPendingCount'
            },
            dataType: 'text',
            success: function(data)
            {
                //console.log(data);
                $('#total_pendingcount').text(data);
            }
        });
    }, 1500);
}

function onprocess_count()
{
    setInterval( function()
    {
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data:
            {
                function: 'GetOnProcessCount'
            },
            dataType: 'text',
            success: function(data)
            {
                //console.log(data);
                $('#total_onprocesscount').text(data);
            }
        });
    }, 1500);
}

function asndetails(IBN)
{
    console.log(IBN);
    $.ajax({
        type: 'POST',
        url: 'ajax.php',
        data:
        {
            function: 'GetASNDetails',
            IBN:IBN
        },
        dataType: 'json',
        success: function(data)
        {
            console.log(data);
            $('#receiving_IBN').val(data[0]['IBN']);
            $('#receiving_selectedWH').val(data[0]['Warehouse_id']);
            $('#receiving_suppliername').val(data[0]['Supplier']);
            $('#receiving_containerno').val(data[0]['Container']);
            $('#receiving_vehicleplateno').val(data[0]['VehiclePlace']);
            $('#receiving_sealno').val(data[0]['Seal']);
            $('#receiving_clientrepresentative').val(data[0]['RequestedBy']);
            $('#receiving_datearrive').val(data[0]['ReceivingDate']);

            showsummaryaddeditems(IBN);
            $('#iteminput').removeClass('disabled');

        }
    });
}

function getavailableitems()
{
    var storagetype = $('input[name=options]:checked', '#radios').val();

    $.ajax({
        type: 'POST',
        url: 'ajax.php',
        dataType: 'text',
        data: 
        {
            function: 'AvailableItems',
            storagetype:storagetype
        },
        success: function(data)
        {
            console.log(data);
            $('#receiving_items').empty();
            $('#receiving_items').append("<option disabled selected>Please Select From List</option>");
            $('#receiving_items').append(data);
        }
    });
}

function getuom(ItemID)
{
    console.log(ItemID);
    $.ajax({
        type: 'POST',
        url: 'ajax.php',
        dataType: 'text',
        data: 
        {
            function: 'GetUOM',
            ItemID:ItemID
        },
        success: function(data)
        {
            //console.log(data);
            $('#receiving_uom').empty();
            $('#receiving_uom').append("<option value='0' disabled selected>Please Select From List</option>");
            $('#receiving_uom').append(data);   
        }
    });
}

function getweight()
{
    var storagType = $('input[name=options]:checked', '#radios').val();

    var selected_item = $('#receiving_items').val();
    $.ajax({
        type: 'POST',
        url: 'ajax.php',
        dataType: 'text',
        data:
        {
            function: 'GetWeight',
            storagType: storagType,
            selected_item:selected_item
        },
        success: function(data)
        {
            console.log(data);
            $('#receiving_wtg').val(data);
        }
    });

}

function addreceivingitems()
{
    var storagType = $('input[name=options]:checked', '#radios').val();
    var r_ibn = $('#receiving_IBN').val();
    var r_item = $('#receiving_items').val();
    var r_itemqty = $('#receiving_qty').val();
    var r_itemexpirydate = $('#receiving_expiration').val();
    var r_itemuom = $('#receiving_uom').val();
    var r_weight = $('#receiving_wtg').val();
    if(r_item == null || r_item == "" || r_itemqty == null || r_itemqty == "")
    {
        alert("Please fillout all fields with asterisk(*)")
    }
    else
    {
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            dataType: 'text',
            data: 
            {
                function: 'AddReceivingItems',
                r_ibn:r_ibn,
                r_item:r_item,
                r_itemqty:r_itemqty,
                r_itemexpirydate:r_itemexpirydate,
                r_itemuom:r_itemuom,
                storagType:storagType,
                r_weight:r_weight
            },
            success: function(IBN)
            {
                console.log("Added Success!");
                setTimeout(function(){
                    $('#itemform')[0].reset();
                    $('#receiving_items').append("<option disabled selected>Please Select From List</option>");
                    $('#receiving_uom').append("<option value='0' disabled selected>Please Select From List</option>");
                    showsummaryaddeditems();
                }, 1000);
            }
        });
    }
}

function showsummaryaddeditems()
{
    var IBN = $('#receiving_IBN').val();

    $.ajax({
        type: 'POST',
        url: 'ajax.php',
        data:
        {
            function: 'AddedItemsSummary',
            IBN:IBN
        },
        dataType: 'json',
        success: function(data)
        {
            console.log(data);
            // $('#receivingitemsummary').empty();
            // $('#receivingitemsummary').append(data);
            $('#receivingitemsummary').dataTable({
                "data": data,
                "columns": [
                    {
                        "data": "items"          
                    },
                    {
                        "data": "uom"          
                    },
                    {
                        "data": "quantity"          
                    },
                    {
                        "data": "totalweight"          
                    },
                    {
                        "data": "expiry_date"          
                    },
                    {
                        "data": "action"          
                    }
                ]
            });
        } 
                
    });
    $('#receivingitemsummary').DataTable().destroy(); 
}

function getitemdetailscanedit(id)
{
    $('#modalReceivingEditItems').modal('show');

    $('#modalReceivingEditItems').attr('itemid', id);

    $.ajax({
        type: 'POST',
        url: 'ajax.php',
        data:
        {
            function: 'GetItemDetailsCanEdit', 
            id:id
        },
        dataType: 'json',
        success: function(data)
        {
            $('#editItemQty').val(data[0]['quantity']);
            $('#editItemExpiryDate').val(data[0]['expiry_date']);
            console.log(data);
        }
    });
}

function edititemdetails()
{
    var id = $('#modalReceivingEditItems').attr('itemid');
    var editQty = $('#editItemQty').val();
    var expiry = $('#editItemExpiryDate').val();

    if((editQty == "null" || editQty == "")||(expiry == "null" || expiry == ""))
    {

    }
    else
    {
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data: 
            {
                function: 'EditItemDetails',
                id: id,
                editQty: editQty,
                expiry: expiry
            },
            dataType: 'text',
            success: function(data)
            {
                console.log(data);
                setTimeout(function(){
                    $('#modalReceivingEditItems').modal('hide');
                    showsummaryaddeditems();
                }, 1000);
            }
        });
    }
}

function modalremoveconfirmation(id)
{
    $('#modalRemoveConfirmation').modal('show');

    $('#modalRemoveConfirmation').attr('itemid', id);
}

function removeitemdetails()
{
    var id = $('#modalRemoveConfirmation').attr('itemid');

    $.ajax({
        type: 'POST',
        url: 'ajax.php',
        data: 
        {
            function: 'removeItem',
            id:id
        },
        dataType: 'text',
        success: function(data)
        {
            console.log(data);
            setTimeout(function(){
                $('#modalRemoveConfirmation').modal('hide');
                showsummaryaddeditems();
            }, 1000);
        }
    });
}

function submitconfirmation()
{
    var IBN = $('#receiving_IBN').val();
    if(IBN == "" || IBN == null)
    {

    }
    else
    {
        $('#modal_confirmation').modal();
    }
    
}

function submitASN()
{
    var IBN = $('#receiving_IBN').val();

    if(IBN == "" || IBN == null)
    {
        alert('Make a transaction!');
    }
    else
    {
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data:
            {
                function: 'SubmitCompleteASN',
                IBN:IBN
            },
            success: function(data)
            {
                console.log(data);
                location.reload();
            }
        }); 
    }
}

