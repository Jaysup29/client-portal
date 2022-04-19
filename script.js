// Login

    function login()
    {
        var username = $('#username').val();
        var password = $('#userpword').val();

        if((username == null || username == "") || (password == null || password == ""))
        {
            alert("Please input something");
        }
        else
        {
            $.ajax({
                type: 'POST',
                url: 'ajax.php',
                dataType: 'text',
                data:
                {
                    function: 'login',
                    username:username,
                    password:password
                },
                success: function(data)
                {
                    alert(data);
                    if (data.includes("Success!")) {
                        //                alert("Login Successfully!")
                        window.location = "index.php";
                    }
                }
            });
        }
    }

// Login


// Dashboard

    function loadSKUNo()
    {
        $.ajax({
            type: "POST",
            url: "ajax.php",
            data: { function: 'loadSKUNo'},
            success: function(data)
            {   
                console.log(data);
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
                console.log(data);
                $('#searchSKUDesc').empty();
                $('#searchSKUDesc').append("<option value='0' disabled selected>Select From SKU Description</option>");
                $('#searchSKUDesc').append(data);
                
            } 
        });
    }

    function filterBySKU(prop)
    {
        $("#searchSKU").prop('disabled', false);

        var CustomerID = $('#cus_id').val();

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
            data: { function: 'loadSKUandDesc', filter:filter, CustomerID:CustomerID},
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
        var CustomerID = $('#cus_id').val();

        var today = new Date();
        var dd = String(today.getDate()).padStart(2, '0');
        var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
        var yyyy = today.getFullYear();
        today = mm + '/' + dd + '/' + yyyy;
        
        var WarehouseName;
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            dataType: 'text',
            data: 
            {
                function: 'GetWarehouseExport',
                WarehouseID:WarehouseID
            },
            success: function(data)
            {
                  WarehouseName = data;
                  console.log(WarehouseName);
            }
        });

        $.ajax({
            type: 'POST',  
            url: 'ajax.php', 
            data: {
                function: 'soh_report',
                WarehouseID:WarehouseID,
                CustomerID:CustomerID
            },
            dataType: 'json',
            beforeSend: function() 
            {
                $('.spinner-border').show();
            },
            success: function(data) 
            {   
               console.log(data);
               var totalWGT = $.fn.dataTable.render.number( ',', '.', 2, ''  ).display;
               var numberRenderer = $.fn.dataTable.render.number( ',', '.', '', ''  ).display;     
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
                            pageSize: 'LEGAL',
                            messageTop: 'Filter:' + WarehouseName,
                            
                        },

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
                            "data": "oum"          
                        },
                        {
                            "data": "wgt"          
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
                                                return "No Expiry";
                                            }
                                            return moment(data).format("D-MMM-YYYY");
                                        }         
                            },
                            {
                                "data": "batch"          
                            },
                            {
                                "data": "prod",
                                render: function(data, type, row){
                                        if(type === "sort" || type === "type"){
                                            return data;
                                        }else if(data === ''){
                                            return "No Production Date";
                                        }
                                        return moment(data).format("MMM-D-YYYY");
                                    }              
                            },
                        {
                            "data": "cvnumber"          
                        },
                        {
                            "data": "otherref"          
                        },

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
                            numberRenderer( pageTotal )
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
                           totalWGT( pageTotal )
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
        
        console.log(WarehouseID);
        if(WarehouseID == null || WarehouseID == '' || WarehouseID == 0)
        {
            $('title').html("Stock On-Hand Report As Of " + today);
            console.log('Venwadwadwosn');
        }
        else
        {
            $('title').html("Stock On-Hand Report As Of " + today);
            console.log('Venosn');
        }
        
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

        var WarehouseName;
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            dataType: 'text',
            data: 
            {
                function: 'GetWarehouseExport',
                WarehouseID:WarehouseID
            },
            success: function(data)
            {
                  WarehouseName = data;
                  console.log(WarehouseName);
            }
        });

        var message = '';
        if(prop == 'container')
        {
            message = 'CV Number';
        }
        else if(prop == 'item')
        {
            message = 'Item';
        }
        if(prop == 'batch')
        {
            message = 'Batch';
        }
        if(prop == 'status')
        {
            message = 'Status';
        }
        if(prop == 'ref')
        {
            message = 'Other Reference';
        }

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
            var totalWGT = $.fn.dataTable.render.number( ',', '.', 2, ''  ).display;
            var numberRenderer = $.fn.dataTable.render.number( ',', '.', '', ''  ).display;
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
                        pageSize: 'LEGAL',
                        messageTop: 'Filter: ' + WarehouseName + ',' + message
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
                // "aoColumnDefs": [
                //     {
                //         "targets": 7,
                //         "data": "expirydate",
                //         "mRender": function(data) {
                //             return Date.create(data).format('{dd}-{MM}-{yyyy}');
                //         }
                //     }
                // ],
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
                            "data": "oum"          
                        },
                        {
                            "data": "wgt"          
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
                                                return "No Expiry";
                                            }
                                            return moment(data).format("D-MMM-YYYY");
                                        }         
                            },
                            {
                                "data": "batch"          
                            },
                            {
                                "data": "prod",
                                render: function(data, type, row){
                                        if(type === "sort" || type === "type"){
                                            return data;
                                        }else if(data === ''){
                                            return "No Production Date";
                                        }
                                        return moment(data).format("MMM-D-YYYY");
                                    }              
                            },
                        {
                            "data": "cvnumber"          
                        },
                        {
                            "data": "otherref"          
                        },
                        // {
                        //     "data": "controlno"          
                        // }
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
                                numberRenderer( pageTotal )
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
                                 totalWGT( pageTotal )
                            );
                        }


                });
            },
            complete: function()
            {  
                $('.spinner-border').hide();
            }
        });
        
        var today = new Date();
        var dd = String(today.getDate()).padStart(2, '0');
        var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
        var yyyy = today.getFullYear();
        today = mm + '/' + dd + '/' + yyyy;
        $('title').html("Stock On-Hand Report As Of " + today);
    }

    function searching(key)
    {   
        var CustomerID = $('#cus_id').val();
        var WarehouseID = $('#warehouse').val();
        $('#soh').DataTable().destroy();
        $('#soh_body').empty();

        var message = '';
        if($('#container').is(':checked'))
        {
            var filter = 'container';
            message = 'CV Number';
        }
        else if($('#item').is(':checked'))
        {
            var filter = 'item';
            message = 'Item';
        }
        else if($('#batch').is(':checked'))
        {
            var filter = 'batch';
            message = 'Batch';
        }
        else if($('#status').is(':checked'))
        {
            var filter = 'status';
            message = 'Status';
        }
        else if($('#ref').is(':checked'))
        {
            var filter = 'ref';
            message = 'Other Reference';
        }

       var WarehouseName;
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            dataType: 'text',
            data: 
            {
                function: 'GetWarehouseExport',
                WarehouseID:WarehouseID
            },
            success: function(data)
            {
                  WarehouseName = data;
                  console.log(WarehouseName);
            }
        });
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
                var totalWGT = $.fn.dataTable.render.number( ',', '.', 2, ''  ).display;
                var numberRenderer = $.fn.dataTable.render.number( ',', '.', '', ''  ).display;
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
                            pageSize: 'LEGAL',
                            messageTop: 'Filter: ' + 
                                        WarehouseName + ',' + 
                                        message + '  Search:' + 
                                        key,

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
                    // "aoColumnDefs": [
                    //     {
                    //         "targets": 7,
                    //         "data": "expirydate",
                    //         "mRender": function(data) {
                    //             return Date.create(data).format('{dd}-{MM}-{yyyy}');
                    //         }
                    //     }
                    // ],
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
                                "data": "oum"          
                            },
                            {
                                "data": "wgt"          
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
                                                return "No Expiry";
                                            }
                                            return moment(data).format("D-MMM-YYYY");
                                        }         
                            },
                            {
                                "data": "batch"          
                            },
                            {
                                "data": "prod",
                                render: function(data, type, row){
                                        if(type === "sort" || type === "type"){
                                            return data;
                                        }else if(data === ''){
                                            return "No Production Date";
                                        }
                                        return moment(data).format("MMM-D-YYYY");
                                    }              
                            },
                            {
                                "data": "cvnumber"          
                            },
                            {
                            "data": "otherref"          
                            },
                            // {
                            //     "data": "controlno"          
                            // }
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
                            numberRenderer( pageTotal )
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
                            totalWGT( pageTotal )
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

        var today = new Date();
        var dd = String(today.getDate()).padStart(2, '0');
        var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
        var yyyy = today.getFullYear();
        today = mm + '/' + dd + '/' + yyyy;

        $('title').html("Stock On-Hand Report As Of " + today);

    }

    function Report_GenerateAgeing()
    {   
        var CustomerID = $('#cus_id').val();
        var WarehouseID = $('#warehouse').val();

        var WarehouseName;
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            dataType: 'text',
            data: 
            {
                function: 'GetWarehouseExport',
                WarehouseID:WarehouseID
            },
            success: function(data)
            {
                  WarehouseName = data;
                  console.log(WarehouseName);
            }
        });

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
                var totalWGT = $.fn.dataTable.render.number( ',', '.', 2, ''  ).display;
                var numberRenderer = $.fn.dataTable.render.number( ',', '.', '', ''  ).display;
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
                            orientation: 'landscape',  pageSize: 'LEGAL',
                            messageTop: 'Filter:' + WarehouseName
                        }
                    ],
                    // columnDefs: [
                    //    {"targets": 9, "orderable": false }
                    //  ],
                    initComplete: function () {
                        var btns = $('.dt-button');
                        btns.addClass('ml-2 btn btn-success btn-md');
                        btns.removeClass('dt-button');

                    },
                    "ordering": false,
                    "columns": [
                            {
                                "data": "sku"          
                            },
                            {
                                "data": "item"          
                            },
                            
                            {
                                "data": "qty",          
                            },
                            {
                                "data": "oum"          
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
                                .column( 2 )
                                .data()
                                .reduce( function (a, b) {
                                    return intVal(a) + intVal(b);
                                }, 0 );
                 
                            // Total over this page
                            pageTotal = api
                                .column( 2, { page: 'current'} )
                                .data()
                                .reduce( function (a, b) {
                                    return intVal(a) + intVal(b);
                                }, 0 );
                 
                            // Update footer
                            $( api.column( 2 ).footer() ).html(
                                numberRenderer( pageTotal )
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
                                totalWGT( pageTotal )
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


        var WarehouseName;
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            dataType: 'text',
            data: 
            {
                function: 'GetWarehouseExport',
                WarehouseID:WarehouseID
            },
            success: function(data)
            {
                  WarehouseName = data;
                  console.log(WarehouseName);
            }
        });

        var message = '';
        if(prop == 'container')
        {
            message = 'CV Number';
        }
        if(prop == 'batch')
        {
            message = 'Batch';
        }
        if(prop == 'ref')
        {
            message = 'Other Reference';
        }


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
                var totalWGT = $.fn.dataTable.render.number( ',', '.', 2, ''  ).display;
                var numberRenderer = $.fn.dataTable.render.number( ',', '.', '', ''  ).display;
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
                            orientation: 'landscape',  pageSize: 'LEGAL',
                            messageTop: 'Filter: ' + WarehouseName + ',' + message
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
                                "data": "qty",          
                            },
                            {
                                "data": "oum"          
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
                                .column( 2 )
                                .data()
                                .reduce( function (a, b) {
                                    return intVal(a) + intVal(b);
                                }, 0 );
                 
                            // Total over this page
                            pageTotal = api
                                .column( 2, { page: 'current'} )
                                .data()
                                .reduce( function (a, b) {
                                    return intVal(a) + intVal(b);
                                }, 0 );
                 
                            // Update footer
                            $( api.column( 2 ).footer() ).html(
                                numberRenderer( pageTotal )
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
                                totalWGT( pageTotal )
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


        var WarehouseName;
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            dataType: 'text',
            data: 
            {
                function: 'GetWarehouseExport',
                WarehouseID:WarehouseID
            },
            success: function(data)
            {
                  WarehouseName = data;
                  console.log(WarehouseName);
            }
        });

        var message = '';
        if(filter == 'container')
        {
            message = 'CV Number';
        }
        if(filter == 'batch')
        {
            message = 'Batch';
        }
        if(filter == 'ref')
        {
            message = 'Other Reference';
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
                var totalWGT = $.fn.dataTable.render.number( ',', '.', 2, ''  ).display;
                var numberRenderer = $.fn.dataTable.render.number( ',', '.', '', ''  ).display;
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
                            orientation: 'landscape',  pageSize: 'LEGAL',
                            messageTop: 'Filter: ' + 
                                        WarehouseName + ',' + 
                                        message + '  Search:' + 
                                        key,
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
                                "data": "qty",          
                            },
                            {
                                "data": "oum"          
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
                                .column( 2 )
                                .data()
                                .reduce( function (a, b) {
                                    return intVal(a) + intVal(b);
                                }, 0 );
                 
                            // Total over this page
                            pageTotal = api
                                .column( 2, { page: 'current'} )
                                .data()
                                .reduce( function (a, b) {
                                    return intVal(a) + intVal(b);
                                }, 0 );
                 
                            // Update footer
                            $( api.column( 2 ).footer() ).html(
                                numberRenderer( pageTotal )
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
                                totalWGT( pageTotal )
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

        $('#DTR').DataTable().destroy();
        
        var datefrom = $("#datefrom").val();
        var dateto = $("#dateto").val();
        var CustomerID = $('#cus_id').val();

        console.log(datefrom);
        console.log(dateto);


         $('#modal_load').modal('show');
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
               console.log(data);

               console.log('Ven');
               $('#DTR').DataTable({
                    "data": data,
                    dom: 'Bfrtip',
                    responsive: true,
                    searching:true,
                    buttons: [
                        { extend: 'copyHtml5', footer: true,
                              exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                }
                            },
                            { extend: 'excelHtml5', footer: true,
                              exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                } 
                            },
                            { extend: 'csvHtml5', footer: true,
                              exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
                                } 
                            },
                            { extend: 'pdfHtml5', footer: true, 
                              exportOptions: {
                                    columns: [ 0, 1, 2, 3, 4, 5, 6, 7 ],
                                   
                                },
                                orientation: 'landscape',  
                                pageSize: 'LEGAL',
                                messageTop: 'Filter: ' + datefrom + '-' + dateto
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
                            // {
                            //     "data": "controlno"          
                            // },
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
                                "data": "qty",
                                render: $.fn.dataTable.render.number(',', '.', '', '')       
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
                
                setTimeout(function() 
                {
                    $('#modal_load').modal('hide');
                }, 1000);
            }

        });

        if(CustomerID == null || CustomerID == '')
        {
            $('#DTR').DataTable().destroy();
        }

    }

    function Report_GenerateGM()
    {   

        var CustomerID = $('#cus_id').val();
        var ItemID = $('#loadItem').val();
        var SubFilter = $('#subfilter').val();
        var Co_SubFilter = $('#subfilter2').val();

        var datefrom = $("#datefrom").val();
        var dateto = $("#dateto").val();
        
        if(ItemID == null || ItemID == '')
        {
            alert('Please From The List!');
        }
        else
        {
            $('#modal_load').modal('show');
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
    }

    function Report_GenerateITR()
    {   

        var datefrom = $("#datefrom").val();
        var dateto = $("#dateto").val();
        
        var WarehouseID = $('#warehouse').val();
        var CustomerID = $('#cus_id').val();

        var message = '';
        if($('#container').is(':checked'))
        {
            var filter = 'Container';
            message = 'CV Number'
        }
        else if($('#controlno').is(':checked'))
        {
            var filter = 'IBN';
            message = 'Control Number'
        }
        else if($('#status').is(':checked'))
        {
            var filter = 'StatusID';
            message = 'Status';
        }
        else
        {
            var filter = '';
        }

        var WarehouseName;
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            dataType: 'text',
            data: 
            {
                function: 'GetWarehouseExport',
                WarehouseID:WarehouseID
            },
            success: function(data)
            {
                  WarehouseName = data;
                  console.log(WarehouseName);
            }
        });

        var searchkey = $('#search').val();

        if(WarehouseID == null || WarehouseID == '')
        {
            alert('Please Select Warehouse!');
        }
        else
        {
           $('#modal_load').modal('show');
            // console.log(WarehouseID);
            $.ajax({
                type: 'POST',  
                url: 'ajax.php', 
                data: {
                    function: 'Report_GenerateITR',
                    datefrom:datefrom,
                    dateto:dateto,
                    WarehouseID:WarehouseID,
                    filter:filter,
                    searchkey:searchkey,
                    CustomerID:CustomerID
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
                      orientation: 'landscape',  pageSize: 'LEGAL',
                      messageTop: 'Filter: ' + 
                                        WarehouseName + ',' + 
                                        message + ',' + datefrom + '-' + dateto +'  Search:' + 
                                        searchkey,
                      }
                      ],
                      "order": [[ 0, "desc" ]],
                      "columns": [
                        {
                            "data": "recDate",     
                        },
                        {
                            "data": "cpi"          
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
                            "data": "qty",
                            render: $.fn.dataTable.render.number(',', '.', '', '')           
                        },
                        {
                            "data": "wgt",
                            render: $.fn.dataTable.render.number(',', '.', 2, '')          
                        },
                        {
                            "data": "container"          
                        },
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


        
    }

    function view_details_itr(IBN)
    {

        $('#view_details_itr').modal('show');
        var CustomerID = $('#cus_id').val();
        var IBN = IBN;
        console.log(IBN);
        $.ajax({
            type: 'POST',  
            url: 'ajax.php', 
            data: {
                function: 'Report_GenerateITRDetails',
                IBN:IBN,
                CustomerID:CustomerID
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

        var datefrom = $("#datefrom").val();
        var dateto = $("#dateto").val();
        var WarehouseID = $('#warehouse').val();
        var CustomerID = $('#cus_id').val();
        var search = $("#search").val();

        var message = '';
        if($('#container').is(':checked'))
        {
            var filter = 'Container';
            message = 'CV Number'
        }
        else if($('#controlno').is(':checked'))
        {
            var filter = 'controlno';
            message = 'Control Number'
        }
        else if($('#status').is(':checked'))
        {
            var filter = 'StatusID';
            message = 'Status';
        }
        else
        {
            var filter = '';
        }

        var WarehouseName;
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            dataType: 'text',
            data: 
            {
                function: 'GetWarehouseExport',
                WarehouseID:WarehouseID
            },
            success: function(data)
            {
                  WarehouseName = data;
                  console.log(WarehouseName);
            }
        });

        if(WarehouseID == null || WarehouseID == '')
        {
            alert('Please Select Warehouse!');
        }
        else
        {
                $('#modal_load').modal('show');
                $.ajax({
                type: 'POST',  
                url: 'ajax.php', 
                data: {
                    function: 'Report_GenerateDOR2',
                    datefrom:datefrom,
                    dateto:dateto,
                    WarehouseID:WarehouseID,
                    search:search,
                    filter:filter,
                    CustomerID:CustomerID
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
                          pageSize: 'LEGAL',
                          messageTop: 'Filter: ' + 
                                        WarehouseName + ',' + 
                                        message + ',' + datefrom + '-' + dateto +'  Search:' + 
                                        search,
                          }
                          ],
                          "order": [[ 0, "desc" ]],
                          "columns": [
                                {
                                    "data": "recDate",     
                                },
                                // {
                                //     "data": "controlord"          
                                // },
                                {
                                    "data": "cpo"          
                                },
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
        }


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


    function exportgm(tableID)
    {
        var filename = "Good Movements Report";
        var downloadLink;
        var dataType = 'application/vnd.ms-excel';
        var tableSelect = document.getElementById(tableID);
        var tableHTML = tableSelect.outerHTML.replace(/ /g, '%20');

        // Specify file name
        filename = filename?filename+'.xls':'excel_data.xls';
        
        // Create download link element
        downloadLink = document.createElement("a");
        
        document.body.appendChild(downloadLink);
        
        if(navigator.msSaveOrOpenBlob)
        {
            var blob = new Blob(['\ufeff', tableHTML], {
                type: dataType
            });
            navigator.msSaveOrOpenBlob( blob, filename);
        }
        else
        {
            // Create a link to the file
            downloadLink.href = 'data:' + dataType + ', ' + tableHTML;

            // Setting the file name
            downloadLink.download = filename;
            
            //triggering the function
            downloadLink.click();
        }
    }
// Reports
    
// ReceivingModule

    function receiving_ctrlno()
    {
        var generate_ibnfield = $('#receiving_CPI').val();
        var warehouse = $('#receiving_selectedWH').val();
        
        if((warehouse == null) || (warehouse == ""))
        {
            $('#toastwarehousefirst').toast('show');
        }
        else
        {
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
                    generate_ibnfield:generate_ibnfield,
                    warehouse:warehouse
                },
                success: function(data)
                {
                    console.log(data);
                    //console.log(warehouse);
                    $('#receiving_CPI').val(data);
                }
                });
            }
            else
            {
                alert("Nakagenerate ka na ng inbound code!!!");
            }
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
                console.log(data);
                $('#receiving_selectedWH').empty();
                $('#receiving_selectedWH').append("<option value='' disabled selected>Select Warehouse</option>");
                $('#receiving_selectedWH').append(data);   
                
                $('#order_warehouse').empty();
                $('#order_warehouse').append("<option value='' disabled selected>Select Warehouse</option>");
                $('#order_warehouse').append(data); 
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
                $('#receiving_selectedTruck').append("<option value='0' disabled selected>Select Truck type</option>");
                $('#receiving_selectedTruck').append(data);          
            } 
        });
    }

    function returntopending()
    {
        var cpi_no = $('#r_CPI').val();
        var selected_warehouse = $('#receiving_selectedWH').val();
        var supplier_name = $('#receiving_suppliername').val();
        var container_no = $('#receiving_containerno').val();
        var vehicle_plateno = $('#receiving_vehicleplateno').val();
        var seal_no = $('#receiving_sealno').val();
        var client_rep = $('#receiving_clientrepresentative').val();
        var date_arrival = $('#receiving_datearrive').val();
        var selected_truck = $('#receiving_selectedTruck').val();
        var remarks = $('#receiving_remarks').val();

        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            dataType: 'text',
            data:
            {
                function: 'ReturnToPending',
                cpi_no:cpi_no,
                selected_warehouse:selected_warehouse,
                supplier_name:supplier_name,
                container_no:container_no,
                vehicle_plateno:vehicle_plateno,
                seal_no:seal_no,
                client_rep:client_rep,
                date_arrival:date_arrival,
                selected_truck:selected_truck,
                remarks:remarks
                },
                success: function(data)
                {
                    console.log(data);

                    if(data == 0)
                    {
                        $('#toastmovetopendingwarning').toast('show');
                    }
                    else
                    {
                        $('#toastpending').toast('show');
                    
                        setTimeout(function(){
                            $('#toastpending').toast('hide');
                            location.reload();
                        }, 1500);
                    }
                    
                    
                }
            });
    }

    function receiving_pending()
    {
        $('#modal_receiving_pending').modal('show');
        var btn_label = "Pending Transactions";
        $('#rcvng_btn_label').html(btn_label);
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
        $('#modal_receiving_onprocess').modal('show');
        var btn_label = "On Process";
        $('#rcvng_btn_label').html(btn_label);
        $.ajax({
            type: 'POST',  
            url: 'ajax.php', 
            data: {
                function: 'GetOnprocesslist',
            },
            dataType: 'text',
            success: function(data) 
            {
                console.log(data); 
                $('#onprocess_list').empty();
                $('#onprocess_list').append(data);
            }
        });
    }

    function receiving_forapprove()
    {
        $('#modal_receiving_forapproval').modal('show');
        var btn_label = "For Approval";
        $('#rcvng_btn_label').html(btn_label);
        $.ajax({
            type: 'POST',  
            url: 'ajax.php', 
            data: {
                function: 'GetForApprovallist',
            },
            dataType: 'text',
            success: function(data) 
            {
                console.log(data); 
                $('#forapprove_list').empty();
                $('#forapprove_list').append(data);
            }
        });
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

    function forapproval_count()
    {
        setInterval( function()
        {
            $.ajax({
                type: 'POST',
                url: 'ajax.php',
                data:
                {
                    function: 'GetForApprovalCount'
                },
                dataType: 'text',
                success: function(data)
                {
                    //console.log(data);
                    $('#total_forapprovalcount').text(data);
                    //console.log(data);
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
                    // console.log(data);
                    $('#total_onprocesscount').text(data);
                }
            });
        }, 1500);
    }

    function asndetails(CPI)
    {
        $('#modal_receiving_pending').modal('hide');
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data:
            {
                function: 'GetASNDetails',
                CPI:CPI
            },
            dataType: 'json',
            success: function(data)
            {
                console.log(data);
                $('#r_CPI').val(data[0]['CPI']);
                $('#receiving_selectedWH').val(data[0]['Warehouse_id']);
                $('#receiving_suppliername').val(data[0]['Supplier']);
                $('#receiving_containerno').val(data[0]['Container']);
                $('#receiving_vehicleplateno').val(data[0]['VehiclePlace']);
                $('#receiving_sealno').val(data[0]['Seal']);
                $('#receiving_clientrepresentative').val(data[0]['RequestedBy']);
                $('#receiving_datearrive').val(data[0]['ReceivingDate']);
                $('#receiving_selectedTruck').val(data[0]['TruckType']);
                $('#receiving_remarks').val(data[0]['Remarks']);

                $('#receiving_selectedWH').prop('disabled', false);
                $('#tooltiptext').addClass('invi');
                $("#SubmitBtn").prop("disabled", false);
                $('#modal_receiving_forapproval').modal('hide');
                showsummaryaddeditems();

                if(data[0]['CPStatus_id'] == 1)
                {
                    $('#itemform').removeClass('disabled');
                    
                }
                else if(data[0]['CPStatus_id'] == 2)
                {
                    $('#itemform').removeClass('disabled');
                    $('#receiving_selectedWH').addClass('disabled');
                    $('#receiving_selectedTruck').addClass('disabled');
                    $('#receiving_datearrive').addClass('disabled');

                }
            }
        });
    }

    function getavailableitems()
    {
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            dataType: 'text',
            data: 
            {
                function: 'AvailableItems'
            },
            success: function(data)
            {
                //console.log(data);
                $('#receiving_items').empty();
                $('#receiving_items').append("<option disabled selected>Please Select From List</option>");
                $('#receiving_items').append(data);

            }
        });
    }

    function getuom(ItemID)
    {
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
                console.log(data);
                $('#receiving_uom').empty();
                $('#receiving_uom').val(data);   
            }
        });
    }

    function getweight()
    {
        var selected_item = $('#receiving_items').val();

        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            dataType: 'text',
            data:
            {
                function: 'GetWeight',
                selected_item:selected_item
            },
            success: function(data)
            {
                console.log(data);
                if(data > 0)
                {
                    $('#receiving_wtg').val(data);
                    $('#receiving_wtg').prop('disabled', true);
                    
                }
                else
                {
                    $('#receiving_wtg').prop('disabled', false);
                    $('#receiving_qty').val('');
                    $('#receiving_wtg').val('');
                }
                
            }
        });
    }

    function order_opencount()
    {
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data:
            {
                function: 'CountOpenCPO'
            },
            dataType: 'text',
            success: function(data)
            {
                // console.log(data);
                $('#total_order_opencount').empty();
                $('#total_order_opencount').append(data);
            }
        });
    }

    function order_open()
    {
        $('#modal_ordering_pendings').modal('show');

        $.ajax({
            type: 'POST',  
            url: 'ajax.php', 
            data: {
                function: 'openOpenCPOModal',
            },
            dataType: 'text',
            success: function(data) 
            { 
                
                $('#order_list').empty();
                $('#order_list').append(data);
                order_opencount();
            }
        });
        
    }

    function order_backtoOpenConfirmation(itemid)
    {
        $('#modalOrderBacktoOpen').modal('show');

        $('#modalOrderBacktoOpen').attr('itemid', itemid); 
    }

    function order_backtoOpen()
    {
        var itemid = $('#modalOrderBacktoOpen').attr('itemid');

        $.ajax({
            type:'POST',
            url: 'ajax.php',
            dataType: 'text',
            data:
            {
                function: 'PutOrderToOpen',
                itemid:itemid
            },
            success: function(data)
            {
                console.log(data);
                ORDlistTable();
                order_opencount();
                $('#modalOrderBacktoOpen').modal('hide');
            }
        });
    }

    function addreceivingitems()
    {
        var r_CPI = $('#r_CPI').val();
        var r_item = $('#receiving_items').val();
        var r_itemqty = $('#receiving_qty').val();
        var r_itemexpirydate = $('#receiving_expiration').val();
        var r_itemuom = $('#receiving_uom').val();
        var r_weight = $('#receiving_wtg').val();

        if ((r_item!=null && r_item!=="") && (r_itemexpirydate!=null && r_itemexpirydate !=="")){
            if ((r_itemqty!=null && r_itemqty!==""))
            {
                $.ajax({
                    type: 'POST',
                    url: 'ajax.php',
                    data:
                    {
                        function: 'AddReceivingItems',
                        r_item:r_item,
                        r_itemqty:r_itemqty,
                        r_itemexpirydate:r_itemexpirydate,
                        r_itemuom:r_itemuom,
                        r_weight:r_weight,
                        r_CPI:r_CPI
                    },
                    dataType: 'text',
                    success: function(data)
                    {
                        console.log(data);
                        showsummaryaddeditems();
                        $('#toastaddsuccess').toast('show');
                        setTimeout(function(){
                                $('#itemform')[0].reset();
                                $('#receiving_items').append("<option disabled selected>Please Select From List</option>");
                                $('#receiving_uom').append("<option value='0' disabled selected>Please Select From List</option>");
                                $("#SubmitBtn").prop("disabled", false);
                            }, 1000);
                    }
                });
            }
            else
            {
                $('#toastproperly').toast('show');
            }
        }
        else
        {
            $('#toastproperly').toast('show');
        }
    }

    function showsummaryaddeditems()
    {
        var r_CPI = $('#r_CPI').val();

        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data:
            {
                function: 'AddedItemsSummary',
                r_CPI:r_CPI
            },
            dataType: 'text',
            success: function(data)
            {
                // console.log(data);
                $('#receivingitemsummary').empty();
                $('#receivingitemsummary').append(data);
            } 
                    
        });
    }

    function modalremoveconfirmation(itemid)
    {
        $('#modalRemoveConfirmation').modal('show');

        $('#modalRemoveConfirmation').attr('itemid', itemid);
    }

    function removeitemdetails()
    {
        var itemid = $('#modalRemoveConfirmation').attr('itemid');
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data: 
            {
                function: 'removeItem',
                itemid:itemid
            },
            dataType: 'text',
            success: function(data)
            {
                $('#toastremovesuccess').toast('show');
                $('#modalRemoveConfirmation').modal('hide');
                
                setTimeout(function(){
                    $('#toastremovesuccess').toast('hide');
                    showsummaryaddeditems();
                }, 1000);
            }
        });
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
                $('#editItemExpiryDate').val(data[0]['expirydate']);
                $('#editItemWgt').val(data[0]['weight']);
                console.log(data);
                if(data[0]['storagetype'] == '1')
                {
                    $('#editItemWgt').prop('disabled', true);
                }
                else
                {
                    $('#editItemWgt').prop('disabled', false);
                }
            }
        });
    }

    function edititemdetails()
    {
        var id = $('#modalReceivingEditItems').attr('itemid');
        var editQty = $('#editItemQty').val();
        var editWgt = $('#editItemWgt').val();
        var expiry = $('#editItemExpiryDate').val();

        if((editQty == "null" || editQty == "" || editQty == '0') ||(expiry == "null" || expiry == "") || (editWgt == "null" || editWgt == "" || editWgt == '0'))
        {
            $('#toastproperly').toast('show');
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
                    expiry: expiry,
                    editWgt:editWgt
                },
                dataType: 'text',
                success: function(data)
                {
                    // console.log(data);
                    $('#toastchangesuccess').toast('show');
                    setTimeout(function(){
                        $('#modalReceivingEditItems').modal('hide');
                        $('#toastchangesuccess').toast('hide');
                        showsummaryaddeditems();
                    }, 1000);
                }
            });
        }
    }

    function approvalconfirmation()
    {
        var r_CPI = $('#r_CPI').val();
        var warehouse = $('#receiving_selectedWH').val();
        var trucktype = $('#receiving_selectedTruck').val();
        var dateofarrival = $('#receiving_datearrive').val();
        var containerno = $('#receiving_containerno').val();
        var plateno = $('#receiving_vehicleplateno').val();
        var suppliername = $('#receiving_suppliername').val();
        var sealnumber = $('#receiving_sealno').val();
        var client_rep = $('#receiving_clientrepresentative').val();
        var remarks = $('#receiving_remarks').val();

        if((warehouse == "" || warehouse == null) && (trucktype == "" || trucktype == null) && (dateofarrival == "" || dateofarrival == null))
        {
            $('#toastnoapprove').toast('show');
        }
        else
        {
            if(trucktype == '4' || trucktype == '5')
            {
                if(containerno == null || containerno == "")
                {
                    $('#toastnocv').toast('show');
                }
                else
                {
                    $.ajax({
                        type: 'POST',
                        url: 'ajax.php',
                        data:
                        {
                            function: 'CheckIfHasReceivingItems',
                            r_CPI:r_CPI
                        },
                        dataType: 'text',
                        success: function(data)
                        {
                            // console.log(data);
                            if(data == 1)
                            {
                                $('#modal_approveconfirmation').modal('show');
                            }
                            else
                            {
                                $('#toastnoapprove').toast('show');
                            }
                        }
                    });
                    
                }
            }
            else
            {
                $.ajax({
                    type: 'POST',
                    url: 'ajax.php',
                    data:
                    {
                        function: 'CheckIfHasReceivingItems',
                        r_CPI:r_CPI
                    },
                    dataType: 'text',
                    success: function(data)
                    {
                        console.log(data);
                        if(data == 1)
                        {
                            $('#modal_approveconfirmation').modal('show');
                        }
                        else
                        {
                            $('#toastnoapprove').toast('show');
                        }
                        
                    }
                });
                
            }
        }
    }

    function approvebtn()
    {
        var r_CPI = $('#r_CPI').val();
        var warehouse = $('#receiving_selectedWH').val();
        var trucktype = $('#receiving_selectedTruck').val();
        var dateofarrival = $('#receiving_datearrive').val();
        var containerno = $('#receiving_containerno').val();
        var plateno = $('#receiving_vehicleplateno').val();
        var suppliername = $('#receiving_suppliername').val();
        var sealnumber = $('#receiving_sealno').val();
        var client_rep = $('#receiving_clientrepresentative').val();
        var remarks = $('#receiving_remarks').val();

        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data:
            {
                function: 'forApprove',
                warehouse:warehouse,
                trucktype:trucktype,
                dateofarrival:dateofarrival,
                containerno:containerno,
                plateno:plateno,
                suppliername:suppliername,
                sealnumber:sealnumber,
                client_rep:client_rep,
                remarks:remarks,
                r_CPI:r_CPI
            },
            dataType: 'text',
            success: function(data)
            {
                // console.log(data);
                if(r_CPI == null || r_CPI == "")
                {
                    if(data === 0)
                    {
                        $('#toastnorecord').toast('show');
                        $('#modal_approveconfirmation').modal('hide');
                    }
                    else
                    {
                        $('#toastsubmitsuccess').toast('show');
                        $('#modal_approveconfirmation').modal('hide');
        
                        setTimeout(function(){
                            $('#toastsubmitsuccess').toast('hide');
                            $('#modal_inboundtransaction').modal({backdrop: 'static', keyboard: false});
                            $('#modal_inboundtransaction').modal('show');
                            $('#CPI').append(data);
                        }, 1000);
                    }
                }
                else
                {
                    if(data === 0)
                    {
                        $('#toastnorecord').toast('show');
                        $('#modal_approveconfirmation').modal('hide');
                    }
                    else
                    {
                        $('#toastsubmitsuccess').toast('show');
                        $('#modal_approveconfirmation').modal('hide');
        
                        setTimeout(function(){
                            $('#toastsubmitsuccess').toast('hide');
                            location.reload();
                        }, 1000);
                    }
                }
            }
        });  
    }

    function submitconfirmation()
    {
        var r_CPI = $('#r_CPI').val();
        var receiving_selectedWH = $('#receiving_selectedWH').val();
        var receiving_selectedTruck = $('#receiving_selectedTruck').val();
        var receiving_datearrive = $('#receiving_datearrive').val();
        var receiving_containerno = $('#receiving_containerno').val();
        var receiving_vehicleplateno = $('#receiving_vehicleplateno').val();
        var receiving_suppliername = $('#receiving_suppliername').val();
        var receiving_sealno = $('#receiving_sealno').val();
        var receiving_clientrepresentative = $('#receiving_clientrepresentative').val();
        var receiving_remarks = $('#receiving_remarks').val();

        if((receiving_selectedWH == null || receiving_selectedWH == '') || (receiving_selectedTruck == null || receiving_selectedTruck == '') || (receiving_datearrive == null || receiving_datearrive == ''))
        {
            $('#toastsubmitwarning').toast('show');
        }
        else
        {
            if(receiving_selectedTruck == '4' || receiving_selectedTruck == '5')
            {
                if(receiving_containerno == null || receiving_containerno == "")
                {
                    $('#toastnocv').toast('show');
                }
                else
                {
                    $.ajax({
                        type: 'POST',
                        url: 'ajax.php',
                        data:
                        {
                            function: 'item_checker',
                            r_CPI:r_CPI
                        },
                        dataType: 'text',
                        success: function(data)
                        {
                            // console.log(data);
                            if(data == 1)
                            {
                                $('#modal_confirmation').modal('show');
                            }
                            else
                            {
                                $('#toastnoitem').toast('show');
                            }
                        }
                    });
                }
            }
            else
            {
                $.ajax({
                    type: 'POST',
                    url: 'ajax.php',
                    data:
                    {
                        function: 'item_checker',
                        r_CPI:r_CPI
                    },
                    dataType: 'text',
                    success: function(data)
                    {
                        console.log(data);
                        if(data == 1)
                        {
                            $('#modal_confirmation').modal('show');
                        }
                        else
                        {
                            $('#toastnoitem').toast('show');
                        }
                    }
                });
            }
        }
    }

    function submitreceiving()
    {
        var r_CPI = $('#r_CPI').val();
        var receiving_selectedWH = $('#receiving_selectedWH').val();
        var receiving_selectedTruck = $('#receiving_selectedTruck').val();
        var receiving_datearrive = $('#receiving_datearrive').val();
        var receiving_containerno = $('#receiving_containerno').val();
        var receiving_vehicleplateno = $('#receiving_vehicleplateno').val();
        var receiving_suppliername = $('#receiving_suppliername').val();
        var receiving_sealno = $('#receiving_sealno').val();
        var receiving_clientrepresentative = $('#receiving_clientrepresentative').val();
        var receiving_remarks = $('#receiving_remarks').val();

        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data:
            {
                function: 'SubmitReceivingTransaction',
                receiving_selectedWH:receiving_selectedWH,
                receiving_selectedTruck:receiving_selectedTruck, 
                receiving_datearrive:receiving_datearrive,
                receiving_containerno:receiving_containerno,
                receiving_vehicleplateno:receiving_vehicleplateno,
                receiving_suppliername:receiving_suppliername,
                receiving_sealno:receiving_sealno,
                receiving_clientrepresentative:receiving_clientrepresentative,
                receiving_remarks:receiving_remarks,
                r_CPI:r_CPI
            },
            dataType: 'text',
            success: function(data)
            {
                // console.log(data);
                if(r_CPI == null || r_CPI == "")
                {
                    if(data === 0)
                    {
                        $('#toastpleaseaddrecord').toast('show');
                    }
                    else
                    {
                        
                        $('#modal_confirmation').modal('hide');
                        $('#itemform').removeClass('disabled');
                        $('#toastsubmitssuccess').toast('show');
                        setTimeout(() => {
                            $('#modal_inboundtransaction').modal({backdrop: 'static', keyboard: false});
                            $('#modal_inboundtransaction').modal('show');
                            $('#CPI').append(data);
                        }, 1000);
                    }
                }
                else
                {
                    if(data === 0)
                    {
                        $('#toastpleaseaddrecord').toast('show');
                    }
                    else
                    {
                        $('#modal_confirmation').modal('hide');
                        $('#itemform').removeClass('disabled');
                        $('#toastsubmitssuccess').toast('show');
                        setTimeout(() => {
        
                            location.reload();
                        }, 1000);
                    }
                }
            }
        });
    }

    function showingApproveBtn()
    {
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data:
            {
                function: 'forApproveBtn'
            },
            dataType: 'text',
            success: function(data)
            {
                $('#forapprovebtn').html(data);
            }
        });
    }

    function enableditemform()
    {
        var warehouse = $('#receiving_selectedWH').val();
        var trucktype = $('#receiving_selectedTruck').val();
        var datearrive = $('#receiving_datearrive').val();
        var containerno = $('#receiving_containerno').val();


        if(warehouse == '' || warehouse == null || trucktype == '' || trucktype == null || datearrive == '' || datearrive == null)
        {
            $('#itemform').addClass('disabled');
            
            // console.log('wala');
        }
        else
        {
            $('#cpi_modalimport').prop("disabled", false);
            if(trucktype == '4' || trucktype == '5')
            {
                if(containerno == null || containerno == "")
                {
                    $('#itemform').addClass('disabled');
                    $('#cpi_modalimport').prop("disabled", true);
                }
                else
                {
                    $('#itemform').removeClass('disabled');
                    $('#iteminput').tooltip('disable');
                    $('#cpi_modalimport').prop("disabled", false);
                }
            }
            else
            {
                $('#itemform').removeClass('disabled');
                $('#iteminput').tooltip('disable');
            }
        }   
    }

    function checkifhasitemtobesubmitted()
    {
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data:
            {
                function: 'item_checker'
            },
            dataType: 'text',
            success: function(data)
            {
                // console.log
            }
        });
    }

    function import_itemreceiving(receiving)
    {
        var receivingitems = JSON.stringify(receiving);
        var cpi = $('#r_CPI').val();
        if(receiving == "" || receiving == null)
        {
            $('#toastnoitemtoimport').toast('show');
        }
        else
        {
            $.ajax({
                type: 'POST',
                url: 'ajax.php',
                dataType: 'text',
                data:
                {
                    function: 'ImportedReceivingItems',
                    receivingitems:receivingitems,
                    cpi:cpi
                },
                success: function(data)
                {
                    console.log(data);
                    if(data != 0)
                    {
                        $('#failedtable').empty();
                        $('#failedtable').append("<table class='table table-reponsive table-striped'><thead style='background-color:#3B82F6;'><tr><th class='text-white'>Item Description</th><th class='text-white'>Quantity</th><th class='text-white'>UOM</th><th class='text-white'>Weight</th><th class='text-white'>Expiry Date</th></tr></thead><tbody id='faileditems'></tbody></table>");
                        $('#faileditems').empty();
                        $('#faileditems').append(data);
                        setTimeout(() => {
                            $('#modal_importItemNotUploaded').modal('show');
                        }, 1500);
                    }
                    else
                    {
                        console.log('Success');
                    }
    
                    showsummaryaddeditems();
                    $('#modal_importReceivingItems').modal('hide');
    
                    $('#SubmitBtn').prop("disabled", false);
                }
            });
        }
        
    }

// ReceivingModule

//Orde Module

    function generatingcpo()
    {
        var CPO_no = $('#GeneratedCPO').val();
        var Warehouse = $('#order_warehouse').val();

        if((Warehouse == null) || (Warehouse == ""))
        {
            $('#toastwarehousefirst').toast('show');
        }
        else
        {
            if((CPO_no == null) || (CPO_no == ""))
            {
                $.ajax({
                    type: 'POST',
                    url: 'ajax.php',
                    dataType: 'text',
                    data: 
                    {
                        function: 'GenerateCPO',
                        CPO_no:CPO_no,
                        Warehouse:Warehouse
                    },
                    success: function(data)
                    {
                        console.log(data);
                        $('#GeneratedCPO').val(data);
                        $('#addingItems').prop('disabled', false);
                        $('#addingItems').removeClass('bg-secondary');
                        // order_opencount();
                    }
                });
            }
            else
            {
                alert("Customer Portal Number has been generated");
            }
        } 
    }

    function order_getallitems()
    {
        $.ajax({
            type: 'POST',
            url:'ajax.php',
            dataType: 'text',
            data:
            {
                function: 'Order_GetAllItems'
            },
            success: function(data)
            {
                // console.log(data);
                $('#order_items').empty();
                $('#order_items').append("<option disabled selected>Please Select From Lists</option>");
                $('#order_items').append(data);

            }
        });
    }

    function order_itemfworcw()
    {
        var selected_item = $('#order_items').val();

        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            dataType: 'text',
            data: 
            {
                function: 'OrderFWorCW',
                selected_item:selected_item
            },
            success: function(data)
            {
                console.log(data);
                
                if(data == "" || data == null)
                {
                    $('#order_weight').prop('disabled', true);
                    $('#order_quantity').prop('disabled', true);
                    $('#order_weight').val(data);
                }
                else if(data == 0)
                {
                    $('#order_weight').prop('disabled', false);
                    $('#order_quantity').prop('disabled', false);
                    $('#order_weight').val();
                }
                else
                {
                    $('#order_quantity').prop('disabled', false);
                    $('#order_weight').prop('disabled', true);
                    $('#order_weight').val(data);
                }
            }
        });
    }

    function add_orderitem()
    {
        var warehouse = $('#order_warehouse').val();
        var SOnumber = $('#SOnumber').val();
        var storename = $('#storename').val();
        var order_remarks = $('#order_remarks').val();
        var Ordered_Item = $('#order_items').val();
        var Ordered_Qty = $('#order_quantity').val();
        var Ordered_Wtg = $('#order_weight').val();
        var GeneratedCPO = $('#GeneratedCPO').val();
        var order_pickupdate = $('#order_pickupdate').val();

        if((warehouse!=null && warehouse!=="") && (Ordered_Item!=null && Ordered_Item !=="") && (order_pickupdate!=null && order_pickupdate !==""))
        {
            if((Ordered_Qty!=null && Ordered_Qty!==""))
            {
                $.ajax({
                    type: 'POST',
                    url: 'ajax.php',
                    dataType: 'text',
                    data:
                    {
                        function: 'AddOrderItem',
                        Ordered_Item:Ordered_Item,
                        Ordered_Qty:Ordered_Qty,
                        Ordered_Wtg:Ordered_Wtg,
                        SOnumber:SOnumber,
                        GeneratedCPO:GeneratedCPO,
                        order_pickupdate:order_pickupdate
                    },
                    success: function(data)
                    {
                        console.log(data);
                        get_orderedItems();
                        $('#additemform')[0].reset();
                        $('#order_items').append("<option disabled selected>Please Select From Lists</option>");
                    }
                });
            }
            else
            {
                $('#toastrequired').toast('show');
            }
        }
        else
        {
            $('#toastrequired').toast('show');
        }
    }

    function get_orderedItems()
    {
        var generatedCPO = $('#GeneratedCPO').val()

        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            dataType: 'text',
            data:
            {
                function: 'GetAllOrderedItems',
                generatedCPO:generatedCPO
            },
            success: function(data)
            {
                $('#orderedItems').empty();
                $('#orderedItems').append(data);
            }
        });
    }

    function editgivenqty_modal(itemid)
    {
        $('#modalOrderingChangeQty').modal('show');

        $('#modalOrderingChangeQty').attr('itemid', itemid);

        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data:
            {
                function: 'OrderingGetItem', 
                itemid:itemid
            },
            dataType: 'json',
            success: function(data)
            {
                console.log(data);
                $('#o_editItemQty').val(data[0]['givenQty']);
                $('#o_editItemWgt').val(data[0]['weight']);
            }
        });
    }

    function edit_givenqty()
    {
        var newGivenQty = $('#o_editItemQty').val();
        var newGivenWgt = $('#o_editItemWgt').val();

        var id = $('#modalOrderingChangeQty').attr('itemid');

        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            dataType: 'text',
            data:
            {
                function: 'SetNewItemQty',
                newGivenWgt:newGivenWgt,
                newGivenQty:newGivenQty,
                id:id
            },
            success: function(data)
            {
                $('#modalOrderingChangeQty').modal('hide');
                get_orderedItems();  
                console.log(data);                   
            }
        });
    }

    function modal_order_removeitemconfirmation(itemid)
    {
        $('#modalOrderRemoveItemConfirmation').modal('show');

        $('#modalOrderRemoveItemConfirmation').attr('itemid', itemid);
    }

    function order_removeitem()
    {
        var itemid = $('#modalOrderRemoveItemConfirmation').attr('itemid');

        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            dataType: 'text',
            data:
            {
                function: 'OrderRemoveItem',
                itemid:itemid
            },
            success: function(data)
            {
            console.log(data);
                $('#modalOrderRemoveItemConfirmation').modal('hide'); 
                get_orderedItems();                    
            }
        });
    }

    function submitforapprovalBtn()
    {
        var warehouse = $('#order_warehouse').val();
        var SOnumber = $('#SOnumber').val();
        var storeid = $('#storename').val();
        var order_pickupdate = $('#order_pickupdate').val();
        var order_remarks = $('#order_remarks').val();
        var Ordered_Item = $('#order_items').val();
        var Ordered_Qty = $('#order_quantity').val();
        var Ordered_Wtg = $('#order_weight').val();
        var generatedCPO = $('#GeneratedCPO').val();

        if((warehouse == null || warehouse == ""))
        {
            $('#toastsubmitwarning').toast('show');
        }
        else
        {
            $.ajax({
                type: 'POST',
                url: 'ajax.php',
                dataType: 'text',
                data:
                {
                    function: 'SubmitForApproval',
                    warehouse:warehouse,
                    SOnumber:SOnumber,
                    storeid:storeid,
                    order_remarks:order_remarks,
                    Ordered_Item:Ordered_Item,
                    Ordered_Qty:Ordered_Qty,
                    Ordered_Wtg:Ordered_Wtg,
                    generatedCPO:generatedCPO,
                    order_pickupdate:order_pickupdate
                },
                success: function(data)
                {
                    console.log(data);
                    if(data == 0)
                    {
                        $('#toastoutofstock').toast('show');
                    }
                    else if(data == 2)
                    {
                        $('#toastpleaseaddrecord').toast('show');
                    }
                    else if(data == 1)
                    {
                        $('#makeorder').modal('hide');
                        $('#orderedItems').empty();
                        ORDlistTable();

                    }
                }
            });
        }
        
    }

    function ORDlistTable()
    {
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            dataType: 'text',
            data:
            {
                function: 'GetORDList'
            },
            success: function(data)
            {
                $('#ORDlist_table').empty();
                $('#ORDlist_table').append(data);
            }
        });
    }

    function modal_order_details(id)
    {
        $('#modal_order_details').modal('show');

        $('#modal_order_details').attr('itemid', id);    

        console.log(id);
        orderdetailsview();
        listoforder();
        orddetailsapprovebtn();
        sumoflistorders();
    }

    function orddetailsapprovebtn()
    {
        var item_id = $('#modal_order_details').attr('itemid'); 
        
        $.ajax({
            type:'POST',
            url: 'ajax.php',
            dataType: 'text',
            data:
            {
                function: 'ORDdetailsApprovebtn',
                item_id:item_id
            },
            success: function(data)
            {
                console.log(data);
                $('#close-approvebtn').empty();
                $('#close-approvebtn').append(data);
            }
        });
    }

    function orderdetailsview()
    {
        var item_id = $('#modal_order_details').attr('itemid');    

        $.ajax({
            type:'POST',
            url: 'ajax.php',
            dataType: 'json',
            data:
            {
                function: 'GetOrderDetail',
                item_id:item_id
            },
            success: function(data)
            {
                // console.log(data);
                $('#cpo_no').empty(data[0]['CPO_no']);
                $('#cpo_no').append(data[0]['CPO_no']);
                $('#date_created').empty(data[0]['Date_created']);
                $('#date_created').append(data[0]['Date_created']);
                $('#store_name').empty(data[0]['Store_name']);
                $('#store_name').append(data[0]['Store_name']);
                $('#warehouse').empty(data[0]['warehouse']);
                $('#warehouse').append(data[0]['warehouse']);
            }
        });
    }

    function listoforder()
    {
        var item_id = $('#modal_order_details').attr('itemid'); 

        $.ajax({
            type:'POST',
            url: 'ajax.php',
            dataType: 'text',
            data:
            {
                function: 'GetListofOrder',
                item_id:item_id
            },
            success: function(data)
            {
                console.log(data);
                $('#orderdetaillist').empty();
                $('#orderdetaillist').append(data);
                sumoflistorders();
            }
        });
    }

    function sumoflistorders()
    {
        var item_id = $('#modal_order_details').attr('itemid'); 

        $.ajax({
            type:'POST',
            url: 'ajax.php',
            dataType: 'text',
            data:
            {
                function: 'GetSumOfListOrder',
                item_id:item_id
            },
            success: function(data)
            {
                // console.log(data);
                $('#orderdetailtotal').empty();
                $('#orderdetailtotal').append(data);
            }
        });
    }

    function modal_order_removeconfirmation(orderid)
    {
        $('#modalOrderRemoveConfirmation').modal('show');

        $('#modalOrderRemoveConfirmation').attr('orderid', orderid);
    }

    function remove_CPO()
    {
        var item_id = $('#modalOrderRemoveConfirmation').attr('orderid');
        console.log(item_id);
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            dataType: 'text',
            data:
            {
                function: 'RemoveCPOTrans',
                item_id:item_id
            },
            success: function(data)
            {
                //console.log(data);
                ORDlistTable();
                $('#modalOrderRemoveConfirmation').modal('hide');
            }
        });
    }

    function modal_approve_orderconfirmation()
    {
        $('#modalApproveOrderConfirmation').modal('show');
    }

    function approve_order()
    {
        var itemid = $('#modal_order_details').attr('itemid'); 

        $.ajax({
            type:'POST',
            url: 'ajax.php',
            dataType: 'text',
            data:
            {
                function: 'ApprovedORD',
                itemid:itemid
            },
            success: function(data)
            {
                console.log(data);
                if(data == 1)
                {
                    $('#toastapproved').toast('show');
                    $('#modal_order_details').modal('hide');
                    $('#modalApproveOrderConfirmation').modal('hide');
                    ORDlistTable();
                }
                else if(data == 0)
                {
                    $('#toastapproveagain').toast('show');
                }
            }
        });
    }

    function cpodetails(CPO)
    {
        console.log('clicked');
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data:
            {
                function: 'GetCPODetails',
                CPO:CPO
            },
            dataType: 'json',
            success: function(data)
            {
                console.log(data);
                $('#order_warehouse').val(data[0]['warehouseid']);
                $('#GeneratedCPO').val(data[0]['cpo']);
                $('#storename').val(data[0]['storeid']);
                $('#SOnumber').val(data[0]['so']);
                $('#order_remarks').val(data[0]['remarks']);

                $('#modal_ordering_pendings').modal('hide');
                get_orderedItems();
            }
        });
    }

    function import_itemorders(orders)
    {
        var orderitems = JSON.stringify(orders);

        if(orders == "" || orders == null)
        {
            $('#toastnoitemtoimport').toast('show');
        }
        else
        {
            $.ajax({
                type: 'POST',
                url: 'ajax.php',
                dataType: 'text',
                data:
                {
                    function: 'ImportedOrderItems',
                    orderitems:orderitems
                },
                success: function(data)
                {
                    console.log(data);
    
                    if(data != 0)
                    {
                        $('#failedtable').empty();
                        $('#failedtable').append("<table class='table table-reponsive table-striped'><thead style='background-color:#3B82F6;'><tr><th class='text-white'>SO</th><th class='text-white'>Item Description</th><th class='text-white'>Quantity</th><th class='text-white'>UOM</th><th class='text-white'>Weight</th></tr></thead><tbody id='faileditems'></tbody></table>");
                        $('#faileditems').empty();
                        $('#faileditems').append(data);
                        setTimeout(() => {
                            $('#modal_importItemNotUploaded').modal('show');
                        }, 1500);
                    }
                    else
                    {
                        console.log('Success');
                    }
    
                    get_orderedItems();
                    $('#modal_importOrderItems').modal('hide');
                }
            });
        }
    }

//OrderModule


//SettingsModule

    function myinfo()
    {
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data:
            {
                function: 'GetMyInfo'
            },
            dataType: 'json',
            success: function(data)
            {
                console.log(data);
                $('#fullname').val(data[0]['fullname']);
                $('#username').val(data[0]['username']);
                $('#email').val(data[0]['email']);
                $('#contact_no').val(data[0]['contact_no']);
            }
        });
    }

    function modal_updateinfor_confirmation()
    {
        $('#modal_updateinfoconfirmation').modal('show');
    }

    function update_myinfo()
    {
        var fullname = $('#fullname').val();
        var username = $('#username').val();
        var email = $('#email').val();
        var contactno = $('#contact_no').val();
        var currpass = $('#curr_password').val();
        var newpass1 = $('#upd_password1').val();
        var newpass2 = $('#upd_password2').val();

        if(newpass1 == newpass2)
        {
            $.ajax({
                type: 'POST',
                url: 'ajax.php',
                data:
                {
                    function: 'UpdateMyinfo',
                    fullname:fullname,
                    username:username,
                    email:email,
                    contactno:contactno,
                    currpass:currpass,
                    newpass1:newpass1
                },
                dataType: 'text',
                success: function(data)
                {
                    $('#modal_updateinfoconfirmation').modal('hide');
                    setTimeout(() => {
                        $('#modal_successmessage').modal('show');
                    }, 1000);
                    
                    console.log(data);
                },
                complete: function() {
                    setInterval(() => {
                        $('#modal_successmessage').modal('hide');
                        location.reload();
                    }, 3000);
                },
            });
        }
        else
        {
            alert('Password not same');
        }
        
    }

    function modal_adduser_confirmation()
    {
        var new_fullname = $('#new_fullname').val();
        var new_username = $('#new_username').val();
        var new_email = $('#new_email').val();
        var new_contactno = $('#new_contactno').val();
        var new_userrole = $('#new_userrole').val();
        var new_password1 = $('#new_password1').val();
        var new_password2 = $('#new_password2').val();

        if((new_fullname == null || new_fullname == "") || (new_username == null || new_username == "") || (new_email == null || new_email == "") || (new_userrole == null || new_userrole == "") || (new_password1 == null || new_password1 == ""))
        {
            $('#toastpleaseaddrecord').toast('show');
            console.log(new_fullname);
            console.log(new_username);
            console.log(new_email);
            console.log(new_contactno);
            console.log(new_userrole);
            console.log(new_password1);
        }
        else
        {
            if(new_password1 !== new_password2)
            {
                $('#toastpassworddonotmatch').toast('show');
            }
            else
            {
                $('#modal_adduserconfirmation').modal('show');
            }

            $('#modal_adduserconfirmation').modal('show');
        }
    }

    function add_new_user()
    {
        var new_fullname = $('#new_fullname').val();
        var new_username = $('#new_username').val();
        var new_email = $('#new_email').val();
        var new_contactno = $('#new_contactno').val();
        var new_userrole = $('#new_userrole').val();
        var new_password1 = $('#new_password1').val();
        var new_password2 = $('#new_password2').val();

        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data:
            {
                function: 'AddNewUsers',
                new_fullname:new_fullname,
                new_username:new_username,
                new_email:new_email,    
                new_contactno:new_contactno,
                new_userrole:new_userrole,
                new_password1:new_password1,
                new_password2:new_password2
            },
            dataType: 'text',
            success: function(data)
            {
                console.log(data);
                $('#modal_adduserconfirmation').modal('hide');
                setTimeout(() => {
                    all_users();
                    $('#modal_successmessage').modal('show');
                }, 500);
            },
            complete: function() {
                setInterval(() => {
                    
                    $('#modal_successmessage').modal('hide');
                }, 2500);
            }
        });
    } 

    function all_users()
    {
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data:
            {
                function: 'GetAllUsers'
            },
            dataType: 'text',
            success: function(data)
            {
                // console.log(data);
                $('#registered_users').empty();
                $('#registered_users').append(data);
            }
        });
    }

    function modal_removeuser_confirmation(userid)
    {
        $('#modal_accountremoveconfirmation').modal('show');

        $('#modal_accountremoveconfirmation').attr('userid', userid);
    }

    function remove_user()
    {
        var userid = $('#modal_accountremoveconfirmation').attr('userid');
        
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data: 
            {
                function: 'DeleteUser',
                userid:userid
            },
            dataType: 'text',
            success: function(data)
            {
                console.log(data);
                $('#modal_accountremoveconfirmation').modal('hide');
                all_users();
            }
        });
    }

    function modal_reset_password_confirmation(userid)
    {
        $('#modal_resetpasswordconfirmation').modal('show');

        $('#modal_resetpasswordconfirmation').attr('userid', userid);
    }

    function reset_password()
    {
        var user_id = $('#modal_resetpasswordconfirmation').attr('userid');

        console.log(user_id);

        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data:
            {
                function: 'ResetPassword',
                user_id:user_id
            },
            dataType: 'text',
            success: function(data)
            {
                console.log(data);

                if(data == 1)
                {
                    $('#modal_resetpasswordconfirmation').modal('hide');

                    setTimeout(() => {
                        $('#modal_resettedpassword').modal('show');
                    }, 1000);
                }
                else if(data == 0)
                {
                    alert('Not Successful');
                }
            }
        });
    }

    function modal_addstore_confirmation()
    {
        var store_fullname = $('#store_fullname').val();
        var store_username = $('#store_username').val();
        var store_email = $('#store_email').val();
        var store_password1 = $('#store_password1').val();
        var store_password2 = $('#store_password2').val();
        var store_contactno = $('#store_contactno').val();
        var store_storeaddress = $('#store_storeaddress').val();

        if(store_fullname == '' || store_fullname == null || store_username == '' || store_username == null || store_email == '' || store_email == null || store_password1 == '' || store_password1 == null || store_password2 == '' || store_password2 == null || store_contactno == '' || store_contactno == null || store_storeaddress == '' || store_storeaddress == null)
        {
            $('#toastpleaseaddrecord').toast('show');
        }
        else
        {
            if(store_password1 !== store_password2)
            {
                $('#toastpassworddonotmatch').toast('show');
            }
            else
            {
                $('#modal_addstoreconfirmation').modal('show');
            }
        }
    }

    function add_new_store()
    {
        var store_fullname = $('#store_fullname').val();
        var store_username = $('#store_username').val();
        var store_email = $('#store_email').val();
        var store_password1 = $('#store_password1').val();
        var store_password2 = $('#store_password2').val();
        var store_contactno = $('#store_contactno').val();
        var store_storeaddress = $('#store_storeaddress').val();

        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data:
            {
                function: 'AddNewStores',
                store_fullname:store_fullname,
                store_username:store_username,
                store_email:store_email,
                store_password1:store_password1,
                store_password2:store_password2,
                store_contactno:store_contactno,
                store_storeaddress:store_storeaddress
            },
            dataType: 'text',
            success: function(data)
            {
                console.log(data);
                $('#modal_addstoreconfirmation').modal('hide');
                setTimeout(() => {
                    $('#modal_successmessage').modal('show');
                    all_stores();
                }, 500);
            },
            complete: function() {
                setInterval(() => {
                    
                    $('#modal_successmessage').modal('hide');
                }, 2500);
            }
        });
    }

    function all_stores()
    {
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data:
            {
                function: 'GetAllStores'
            },
            dataType: 'text',
            success: function(data)
            {
                $('#registered_stores').empty();
                $('#registered_stores').append(data);
                // console.log(data);
            }
        });
    }

    function modal_removestore_confirmation(storeid)
    {
        $('#modal_storeremoveconfirmation').modal('show');

        $('#modal_storeremoveconfirmation').attr('storeid', storeid);
    }

    function remove_store()
    {
        var storeid = $('#modal_storeremoveconfirmation').attr('storeid');
        
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data: 
            {
                function: 'DeleteStore',
                storeid:storeid
            },
            dataType: 'text',
            success: function(data)
            {
                // console.log(data);
                $('#modal_storeremoveconfirmation').modal('hide');
                all_stores();
            }
        });
    }

    function material_type()
    {
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data:
            {
                function: 'GetMaterialType'
            },
            dataType: 'text',
            success: function(data)
            {
                $('#select_materialtype').empty();
                $('#select_materialtype').append("<option value='' disabled selected>Select Material Type</option>");
                $('#select_materialtype').append(data);   
            }
        });
    }

    function storage_category()
    {
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data:
            {
                function: 'GetStorageType'
            },
            dataType: 'text',
            success: function(data)
            {
                $('#select_storagecategory').empty();
                $('#select_storagecategory').append("<option value='' disabled selected>Select Storage Category</option>");
                $('#select_storagecategory').append(data);   
            }
        });
    }

    function subcategory()
    {
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data:
            {
                function: 'GetSubCategory'
            },
            dataType: 'text',
            success: function(data)
            {
                $('#select_subcategory').empty();
                $('#select_subcategory').append("<option value='' disabled selected>Select Sub-Category</option>");
                $('#select_subcategory').append(data);   
            }
        });
    }

    function uom()
    {
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data:
            {
                function: 'GetUOMList'
            },
            dataType: 'text',
            success: function(data)
            {
                $('#select_uom').empty();
                $('#select_uom').append("<option value='' disabled selected>Select UOM</option>");
                $('#select_uom').append(data);   
            }
        });
    }

//SettingsModule

//SuperAdminSide

    function master_userlist()
    {
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data:
            {
                function: 'MasterUserList'
            },
            dataType: 'text',
            success: function(data)
            {
                // console.log(data);
                $('#master_userlist').empty();
                $('#master_userlist').append(data);
            }
        });
    }

    function master_itemlist()
    {
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data:
            {
                function: 'MasterItemList'
            },
            dataType: 'text',
            success: function(data)
            {
                console.log(data);
            }
        });
    }

    function master_storelist()
    {
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data:
            {
                function: 'MasterStoreList'
            },
            dataType: 'text',
            success: function(data)
            {
                console.log(data);
                $('#master_storelist').empty();
                $('#master_storelist').append(data);
            }
        });
    }

    function modal_deactivate_confirmation(userid)
    {
        $('#modal_accountdeactivationmessage').modal('show');
        $('#modal_accountdeactivationmessage').attr('userid', userid);
    }

    function master_userdeactivation()
    {
        var userid = $('#modal_accountdeactivationmessage').attr('userid');

        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data: {
                function : 'MasterDeactivate_Users',
                userid:userid
            },
            dataType: 'text',
            success: function(data)
            {
                console.log(data);
                master_userlist();
                $('#modal_accountdeactivationmessage').modal('hide');
            }
        });
    }

    function modal_useractivation_message(userid)
    {
        $('#modal_accountactivationmessage').modal('show');
        console.log(userid);
        $('#modal_accountactivationmessage').attr('userid', userid);
    }

    function master_useractivation()
    {
        var userid = $('#modal_accountactivationmessage').attr('userid');
        console.log(userid);
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data: 
            {
                function: 'MasterUserActivation',
                userid:userid
            },
            dataType: 'text',
            success: function(data)
            {
                console.log(data);
                master_userlist();
                $('#modal_accountactivationmessage').modal('hide');
            }
        });
    }

    function modal_userrejection_message(userid)
    {
        $('#modal_accountrejectionmessage').modal('show');
        $('#modal_accountrejectionmessage').attr('userid', userid);
    }

    function master_userrejection()
    {
        var userid = $('#modal_accountrejectionmessage').attr('userid');
        console.log(userid);
        $.ajax({
            type: 'POST',
            url: 'ajax.php',
            data: 
            {
                function: 'MasterUserRejection',
                userid:userid
            },
            dataType: 'text',
            success: function(data)
            {
                console.log(data);
                master_userlist();
                $('#modal_accountrejectionmessage').modal('hide');
            }
        });
    }

//SuperAdminSide


function registerall()
{
    $.ajax({
        type:'POST',
        url: 'ajax.php',
        data: {
            function: 'getregisterall'
        },
        dataType: 'text',
        success: function(data)
        {
            console.log(data);
            console.log("Clicked");
        }
    });
}