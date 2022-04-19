<?php 
    $CustomerID = $_SESSION['CustomerId'];

    $start = date('Y-m-d',strtotime('last monday -7 days'));
    $start1 = date('Y-m-d', strtotime($start. ' + 0 days'));
    $start14 = date('Y-m-d', strtotime($start. ' + 13 days'));

    include 'dbcon.php';
    
    $query = "CALL wms_reports.SP_inbound_dashboard_received($CustomerID, '$start1', '$start14')";
    $result = mysqli_query($conn, $query);

    while($rows = mysqli_fetch_array($result))
    {
        $received[] = array('rec'=>$rows[1]);
    } 

    foreach ($received as $key => $value) {
       $receive[] = $value['rec'];
    }

    include 'dbcon.php';
    $query = "CALL wms_reports.SP_inbound_dashboard_planned($CustomerID, '$start1', '$start14')";
    $result = mysqli_query($conn, $query);

    while($rows = mysqli_fetch_array($result))
    {   
        $row_date = date('M d'.','.' Y', strtotime($rows[0]));
        $planned[] = array('plan'=>$rows[1]);
        $dated[] = array('date'=>$row_date);
    } 

    foreach ($planned as $key => $value) {
       $plan[] = $value['plan'];
    }

    foreach ($dated as $key => $value) {
       $date[] = $value['date'];
    }
  
    
    $data1 = json_encode($date);
    $received = json_encode($receive);
    $planned = json_encode($plan);
?>

<?php 
    $CustomerID = $_SESSION['CustomerId'];

    $start = date('Y-m-d',strtotime('last monday -7 days'));
    $start1 = date('Y-m-d', strtotime($start. ' + 0 days'));
    $start14 = date('Y-m-d', strtotime($start. ' + 13 days'));

    include 'dbcon.php';
    
    $query = "CALL wms_reports.SP_outbound_dashboard_undelivered($CustomerID, '$start1', '$start14')";
    $result = mysqli_query($conn, $query);
    // echo $query;
    while($rows = mysqli_fetch_array($result))
    {
        $ordered[] = array('rec'=>$rows[1]);
    } 

    foreach ($ordered as $key => $value) {
        $order[] = $value['rec'];
    }


    include 'dbcon.php';
    
    $query = "CALL wms_reports.SP_outbound_dashboard_delivered($CustomerID, '$start1', '$start14')";
    $result = mysqli_query($conn, $query);
    // echo $query;
    while($rows = mysqli_fetch_array($result))
    {
        $out[] = array('del'=>$rows[1]);
    } 

    foreach ($out as $key => $value) {
        $deliver[] = $value['del'];
    }

    $undelivered = json_encode($order);
    $delivered = json_encode($deliver);

    // echo $delivered;
?>

<script>
  $(function () {

    
// received

        var receivedChartData = {
            labels  : <?php echo $data1?>,
            datasets: [
            {
              label               : 'Received',
              backgroundColor     : '#6082B6',
              borderColor         : 'rgba(210, 214, 222, 1)',
              pointRadius         : false,
              pointColor          : 'rgba(210, 214, 222, 1)',
              pointStrokeColor    : '#c1c7d1',
              pointHighlightFill  : '#fff',
              pointHighlightStroke: 'rgba(220,220,220,1)',
              data                : <?php echo $received?>
            },
            {
              label               : 'Planned',
              backgroundColor     : '#A7C7E7',
              borderColor         : 'rgba(60,141,188,0.8)',
              pointRadius          : false,
              pointColor          : '#3b8bba',
              pointStrokeColor    : 'rgba(60,141,188,1)',
              pointHighlightFill  : '#fff',
              pointHighlightStroke: 'rgba(60,141,188,1)',
              data                : <?php echo $planned?>
            },
            ]
          }

          //-------------
          //- BAR CHART -
          //-------------
          var receivedbarChartCanvas = $('#barChart').get(0).getContext('2d')
          var receivedbarChartData = $.extend(true, {}, receivedChartData)
          var temp0Received = receivedChartData.datasets[0]
          var temp1Received = receivedChartData.datasets[1]
          receivedbarChartData.datasets[0] = temp1Received
          receivedbarChartData.datasets[1] = temp0Received

          var barChartOptions = {
            responsive              : true,
            maintainAspectRatio     : false,
            datasetFill             : false,
            plugins: {
              datalabels: {
                display: false
              }
            },

          }
     
          var canvas = document.getElementById("barChart");
          var ctx = canvas.getContext("2d");
          var receivedChart = new Chart(ctx, {
            type: 'bar',
            data: receivedbarChartData,
            options: barChartOptions
          });


          // Changed Bar Graph --------------------------------------------------------------------


          $(".change-graph").change(function()
          { 
            var dataBarGraph = $(".change-graph").val();
            var CustomerID = $("#cus_id").val();
            
            // console.log(dataBarGraph);
            if(receivedChart)
            {
                receivedChart.destroy();

                $.ajax({
                type: 'POST',
                url: 'bargraph_ajax.php',
                dataType: 'json',
                data:
                {
                    function: 'bargraph_mainfilter_ajax', 
                    dataBarGraph:dataBarGraph,
                    CustomerID:CustomerID
                },
                success: function(data)
                {
                    // console.log(data);
                    var receivedChartData = {
                    labels  : data[0].data1,
                    datasets: [
                    {
                      label               : 'Received',
                      backgroundColor     : '#6082B6',
                      borderColor         : 'rgba(210, 214, 222, 1)',
                      pointRadius         : false,
                      pointColor          : 'rgba(210, 214, 222, 1)',
                      pointStrokeColor    : '#c1c7d1',
                      pointHighlightFill  : '#fff',
                      pointHighlightStroke: 'rgba(220,220,220,1)',
                      data                : data[0].data2
                    },
                    {
                      label               : 'Planned',
                      backgroundColor     : '#A7C7E7',
                      borderColor         : 'rgba(60,141,188,0.8)',
                      pointRadius          : false,
                      pointColor          : '#3b8bba',
                      pointStrokeColor    : 'rgba(60,141,188,1)',
                      pointHighlightFill  : '#fff',
                      pointHighlightStroke: 'rgba(60,141,188,1)',
                      data                : data[0].data3
                    },
                    ]
                  }

                  //-------------
                  //- BAR CHART -
                  //-------------
                  var receivedbarChartCanvas = $('#barChart').get(0).getContext('2d')
                  var receivedbarChartData = $.extend(true, {}, receivedChartData)
                  var temp0Received = receivedChartData.datasets[0]
                  var temp1Received = receivedChartData.datasets[1]
                  receivedbarChartData.datasets[0] = temp1Received
                  receivedbarChartData.datasets[1] = temp0Received

                  var barChartOptions = {
                    responsive              : true,
                    maintainAspectRatio     : false,
                    datasetFill             : false,
                    plugins: {
                      datalabels: {
                        display: false
                      }
                    },

                  }
             
                  var canvas = document.getElementById("barChart");
                  var ctx = canvas.getContext("2d");
                    receivedChart = new Chart(ctx, {
                    type: 'bar',
                    data: receivedbarChartData,
                    options: barChartOptions
                  });


                }
              
               });
            }
          });

          $('#loadSKUandDesc').change(function()
          { 
            var dataBarGraph = $(".change-graph").val();
            var loadSKUandDesc = $('#loadSKUandDesc').val();
            var CustomerID = $("#cus_id").val();
            
            // console.log(dataBarGraph);

            if(dataBarGraph == '' || dataBarGraph == null || dataBarGraph == 'Total SO')
            {
              dataBarGraph = 'Total Quantity';
            }

            if (receivedChart)
            {
                receivedChart.destroy();

                $.ajax({
                type: 'POST',
                url: 'bargraph_ajax.php',
                dataType: 'json',
                data:
                {
                    function: 'bargraph_subfilter_ajax', 
                    dataBarGraph:dataBarGraph,
                    loadSKUandDesc:loadSKUandDesc,
                    CustomerID:CustomerID
                },
                success: function(data)
                {
                    // console.log(data);
                    var receivedChartData = {
                    labels  : data[0].data1,
                    datasets: [
                    {
                      label               : 'Received',
                      backgroundColor     : '#6082B6',
                      borderColor         : 'rgba(210, 214, 222, 1)',
                      pointRadius         : false,
                      pointColor          : 'rgba(210, 214, 222, 1)',
                      pointStrokeColor    : '#c1c7d1',
                      pointHighlightFill  : '#fff',
                      pointHighlightStroke: 'rgba(220,220,220,1)',
                      data                : data[0].data2
                    },
                    {
                      label               : 'Planned',
                      backgroundColor     : '#A7C7E7',
                      borderColor         : 'rgba(60,141,188,0.8)',
                      pointRadius          : false,
                      pointColor          : '#3b8bba',
                      pointStrokeColor    : 'rgba(60,141,188,1)',
                      pointHighlightFill  : '#fff',
                      pointHighlightStroke: 'rgba(60,141,188,1)',
                      data                : data[0].data3
                    },
                    ]
                  }

                  //-------------
                  //- BAR CHART -
                  //-------------
                  var receivedbarChartCanvas = $('#barChart').get(0).getContext('2d')
                  var receivedbarChartData = $.extend(true, {}, receivedChartData)
                  var temp0Received = receivedChartData.datasets[0]
                  var temp1Received = receivedChartData.datasets[1]
                  receivedbarChartData.datasets[0] = temp1Received
                  receivedbarChartData.datasets[1] = temp0Received

                  var barChartOptions = {
                    responsive              : true,
                    maintainAspectRatio     : false,
                    datasetFill             : false,
                    plugins: {
                      datalabels: {
                        display: false
                      }
                    },

                  }
             
                  var canvas = document.getElementById("barChart");
                  var ctx = canvas.getContext("2d");
                    receivedChart = new Chart(ctx, {
                    type: 'bar',
                    data: receivedbarChartData,
                    options: barChartOptions
                  });


                }
              
               });
            }


          });

// received

// order

        var orderChartData = {
            labels  : <?php echo $data1?>,
            datasets: [
            {
              label               : 'Undelivered',
              backgroundColor     : '#DC143C',
              borderColor         : 'rgba(210, 214, 222, 1)',
              pointRadius         : false,
              pointColor          : 'rgba(210, 214, 222, 1)',
              pointStrokeColor    : '#c1c7d1',
              pointHighlightFill  : '#fff',
              pointHighlightStroke: 'rgba(220,220,220,1)',
              data                : <?php echo $undelivered?>
            },
            {
              label               : 'Delivered',
              backgroundColor     : '#C1E1C1',
              borderColor         : 'rgba(60,141,188,0.8)',
              pointRadius          : false,
              pointColor          : '#3b8bba',
              pointStrokeColor    : 'rgba(60,141,188,1)',
              pointHighlightFill  : '#fff',
              pointHighlightStroke: 'rgba(60,141,188,1)',
              data                : <?php echo $delivered?>
            },
            ]
          }

          //-------------
          //- BAR CHART -
          //-------------
          var orderbarChartCanvas = $('#barChart1').get(0).getContext('2d')
          var orderbarChartData = $.extend(true, {}, orderChartData)
          var temp0order = orderChartData.datasets[0]
          var temp1order = orderChartData.datasets[1]
          orderbarChartData.datasets[0] = temp1order
          orderbarChartData.datasets[1] = temp0order

          var barChartOptions = {
            responsive              : true,
            maintainAspectRatio     : false,
            datasetFill             : false,
            plugins: {
              datalabels: {
                display: false
              }
            },

          }
     
          var canvas = document.getElementById("barChart1");
          var ctx = canvas.getContext("2d");
            orderChart = new Chart(ctx, {
            type: 'bar',
            data: orderbarChartData,
            options: barChartOptions
          });


          // Changed Bar Graph --------------------------------------------------------------------


          $(".change-graph").change(function()
          { 
            var dataBarGraph = $(".change-graph").val();
            var CustomerID = $("#cus_id").val();
            
            // console.log(dataBarGraph + 'e');
            if (orderChart)
            {
                orderChart.destroy();

                $.ajax({
                type: 'POST',
                url: 'bargraph_ajax.php',
                dataType: 'json',
                data:
                {
                    function: 'bargraph_mainfilter_ajax_order', 
                    dataBarGraph:dataBarGraph,
                    CustomerID:CustomerID
                },
                success: function(data)
                {
                    console.log(data);
                    var orderChartData = {
                    labels  : data[0].data1,
                    datasets: [
                      {
                        label               : 'Undelivered',
                        backgroundColor     : '#DC143C',
                        borderColor         : 'rgba(210, 214, 222, 1)',
                        pointRadius         : false,
                        pointColor          : 'rgba(210, 214, 222, 1)',
                        pointStrokeColor    : '#c1c7d1',
                        pointHighlightFill  : '#fff',
                        pointHighlightStroke: 'rgba(220,220,220,1)',
                        data                : data[0].data2,
                      },
                      {
                        label               : 'Delivered',
                        backgroundColor     : '#C1E1C1',
                        borderColor         : 'rgba(60,141,188,0.8)',
                        pointRadius          : false,
                        pointColor          : '#3b8bba',
                        pointStrokeColor    : 'rgba(60,141,188,1)',
                        pointHighlightFill  : '#fff',
                        pointHighlightStroke: 'rgba(60,141,188,1)',
                        data                : data[0].data3
                      },
                    ]
                  }

                  //-------------
                  //- BAR CHART -
                  //-------------
                  var orderbarChartCanvas = $('#barChart1').get(0).getContext('2d')
                  var orderbarChartData = $.extend(true, {}, orderChartData)
                  var temp0order = orderChartData.datasets[0]
                  var temp1order = orderChartData.datasets[1]
                  orderbarChartData.datasets[0] = temp1order
                  orderbarChartData.datasets[1] = temp0order

                  var barChartOptions = {
                    responsive              : true,
                    maintainAspectRatio     : false,
                    datasetFill             : false,
                    plugins: {
                      datalabels: {
                        display: false
                      }
                    },

                  }
             
                  var canvas = document.getElementById("barChart1");
                  var ctx = canvas.getContext("2d");
                    orderChart = new Chart(ctx, {
                    type: 'bar',
                    data: orderbarChartData,
                    options: barChartOptions
                  });
                }
              
               });
            }
          });

          $('#loadSKUandDesc').change(function()
          { 
            var dataBarGraph = $(".change-graph").val();
            var loadSKUandDesc = $('#loadSKUandDesc').val();
            var CustomerID = $("#cus_id").val();
            
            // console.log(dataBarGraph);

            if(dataBarGraph == '' || dataBarGraph == null || dataBarGraph == 'Total SO')
            {
              dataBarGraph = 'Total Quantity';
            }

            if (orderChart)
            {
                orderChart.destroy();

                $.ajax({
                type: 'POST',
                url: 'bargraph_ajax.php',
                dataType: 'json',
                data:
                {
                    function: 'bargraph_subfilter_ajax_order', 
                    dataBarGraph:dataBarGraph,
                    loadSKUandDesc:loadSKUandDesc,
                    CustomerID:CustomerID
                },
                success: function(data)
                {
                    // console.log(data);
                    var orderChartData = {
                    labels  : data[0].data1,
                    datasets: [
                    {
                      label               : 'Undelivered',
                      backgroundColor     : '#DC143C',
                      borderColor         : 'rgba(210, 214, 222, 1)',
                      pointRadius         : false,
                      pointColor          : 'rgba(210, 214, 222, 1)',
                      pointStrokeColor    : '#c1c7d1',
                      pointHighlightFill  : '#fff',
                      pointHighlightStroke: 'rgba(220,220,220,1)',
                      data                : data[0].data3
                    },
                    {
                      label               : 'Delivered',
                      backgroundColor     : '#C1E1C1',
                      borderColor         : 'rgba(60,141,188,0.8)',
                      pointRadius          : false,
                      pointColor          : '#3b8bba',
                      pointStrokeColor    : 'rgba(60,141,188,1)',
                      pointHighlightFill  : '#fff',
                      pointHighlightStroke: 'rgba(60,141,188,1)',
                      data                : data[0].data2
                    },
                    ]
                  }

                  //-------------
                  //- BAR CHART -
                  //-------------
                  var orderbarChartCanvas = $('#barChart1').get(0).getContext('2d')
                  var orderbarChartData = $.extend(true, {}, orderChartData)
                  var temp0order = orderChartData.datasets[0]
                  var temp1order = orderChartData.datasets[1]
                  orderbarChartData.datasets[0] = temp1order
                  orderbarChartData.datasets[1] = temp0order

                  var barChartOptions = {
                    responsive              : true,
                    maintainAspectRatio     : false,
                    datasetFill             : false,
                    plugins: {
                      datalabels: {
                        display: false
                      }
                    },

                  }
             
                  var canvas = document.getElementById("barChart1");
                  var ctx = canvas.getContext("2d");
                    orderChart = new Chart(ctx, {
                    type: 'bar',
                    data: orderbarChartData,
                    options: barChartOptions
                  });


                }
              
               });
            }


          });

// order
    // piechart
        var myNewChart;
        var data = {
          labels: [
          'Expired',
          'Less Than 3 Months',
          'Less Than 6 Months',
          'More Than 6 Months',
          'No Expiry',
          ],
          datasets: [
          {
            data: [
            <?php echo $expired ?>,
            <?php echo $lThree ?>,
            <?php echo $lSix ?>,
            <?php echo $mSix ?>,
            <?php echo $noexpiry ?>,
            ],
            backgroundColor : ['#DC143C', '#f39c12', '#00c0ef', '#3c8dbc', '#00a65a'],
          }
          ]
        };
          
        var options = {
          legend: {
              display: false,
          },
          tooltips: {
               enabled: false
          },
          plugins: {
            datalabels: {
               display: false
            },
            outlabels: {
               display: true
            }
         }
        };
        var canvas = document.getElementById("pieChart");
        var ctx = canvas.getContext("2d");
        var myNewChart = new Chart(ctx, {
          type: 'pie',
          data: data,
          options:options
        });

        $(".change-graph").change(function()
        {  
          // var from = start.format('YYYY-MM-DD');
          // var to = end.format('YYYY-MM-DD');

          var from = '2000-01-01';
          var to = '2030-01-01';
          var searchkey = $('#loadSKUandDesc').val();
          var dataBarGraph = $(".change-graph").val();

          if(dataBarGraph == 'Total SO')
          {
            var title = 'Total SO';
          }
          else if(dataBarGraph == 'Total Quantity')
          {
            var title = 'Total Quantity';
          }
          else if(dataBarGraph == 'Total Weight')
          {
            var title = 'Total Weight';
          }
          
          var filter = '';
          if($('#filterBySKUNo').is(':checked'))
          {
              var filter = 'SKUNo';
          }
          else if($('#filterBySKUDesc').is(':checked'))
          {
              var filter = 'SKUDesc';
          }


          if(myNewChart)
          {
            myNewChart.destroy();
            console.log(to + 'e');
            $.ajax({
              type: "POST",
              url: "ageing_dashboard_dropdown.php",
              data: 
              { 
                function: 'loadPieChartByDropdown',
                dataBarGraph:dataBarGraph,
                filter:filter,
                searchkey:searchkey,
                from:from,
                to:to
              },
              dataType:'json',
              success: function(data)
              {   
                console.log(data);
                var donutData        = {
                  labels: [
                  'Expired',
                  'Less Than 3 Months',
                  'Less Than 6 Months',
                  'More Than 6 Months',
                  'No Expiry',
                  ],
                  datasets: [
                  {
                    data: data[0],
                    backgroundColor : ['#DC143C', '#f39c12', '#00c0ef', '#3c8dbc', '#00a65a'],
                  }
                  ]
                }
                var pieChartCanvas = $('#pieChart').get(0).getContext('2d')
                var pieData        = donutData;
                var options = {
                      legend: {
                          display: false,
                      },
                      tooltips: {
                           enabled: false
                      },
                      plugins: {
                        datalabels: {
                           display: false
                        },
                        outlabels: {
                           display: true
                        }
                     }
                    };

                $(document).ready( function() {
                  myNewChart = new Chart(pieChartCanvas, {
                    type: 'pie',
                    data: pieData,
                    options: options
                  });
                });

                var barGraphData = [];

                barGraphData = data[0];

                // console.log(barGraphData);


                if(dataBarGraph == 'Total SO')
                {
                  var num1 =barGraphData[0];
                  var n1 = num1.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                  var num2 =barGraphData[1];
                  var n2 = num2.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                  var num3 =barGraphData[2];
                  var n3 = num3.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                  var num4 =barGraphData[3];
                  var n4 = num4.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                  var num5 =barGraphData[4];
                  var n5 = num5.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                  percent = num1 + num2 + num3 + num4 + num5;

                  var n1_per = num1/percent * 100;
                  n1_per = n1_per.toFixed(2);

                  var n2_per = num2/percent * 100;
                  n2_per = n2_per.toFixed(2);

                  var n3_per = num3/percent * 100;
                  n3_per = n3_per.toFixed(2);

                  var n4_per = num4/percent * 100;
                  n4_per = n4_per.toFixed(2);

                  var n5_per = num5/percent * 100;
                  n5_per = n5_per.toFixed(2);

                  // console.log(n5_per);
                }
                else if(dataBarGraph == 'Total Quantity')
                {
                  var num1 =barGraphData[0];
                  var n1 = num1.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                  var num2 =barGraphData[1];
                  var n2 = num2.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                  var num3 =barGraphData[2];
                  var n3 = num3.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                  var num4 =barGraphData[3];
                  var n4 = num4.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                  var num5 =barGraphData[4];
                  var n5 = num5.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                  percent = num1 + num2 + num3 + num4 + num5;

                  var n1_per = num1/percent * 100;
                  n1_per = n1_per.toFixed(2);

                  var n2_per = num2/percent * 100;
                  n2_per = n2_per.toFixed(2);

                  var n3_per = num3/percent * 100;
                  n3_per = n3_per.toFixed(2);

                  var n4_per = num4/percent * 100;
                  n4_per = n4_per.toFixed(2);

                  var n5_per = num5/percent * 100;
                  n5_per = n5_per.toFixed(2);

                  // console.log(n5_per);
                }
                else if(dataBarGraph == 'Total Weight')
                {
                  var percent = 0;
                  // percent = num1 + num2 + num3 + num4 + num5;
                  var num1 =barGraphData[0];
                  var n1 = num1.toFixed(2);

                  var num2 =barGraphData[1];
                  var n2 = num2.toFixed(2);

                  var num3 =barGraphData[2];
                  var n3 = num3.toFixed(2);

                  var num4 =barGraphData[3];
                  var n4 = num4.toFixed(2);

                  var num5 =barGraphData[4];
                  var n5 = num5.toFixed(2);

                  console.log(n2);

                  percent = num1 + num2 + num3 + num4 + num5;
                  var n1_per = n1/percent * 100;
                  n1_per = n1_per.toFixed(2);

                  var n2_per = n2/percent * 100;
                  n2_per = n2_per.toFixed(2);

                  var n3_per = n3/percent * 100;
                  n3_per = n3_per.toFixed(2);

                  var n4_per = n4/percent * 100;
                  n4_per = n4_per.toFixed(2);

                  var n5_per = n5/percent * 100;
                  n5_per = n5_per.toFixed(2);


                  n1 = new Intl.NumberFormat().format(n1);
                  n2 = new Intl.NumberFormat().format(n2);
                  n3 = new Intl.NumberFormat().format(n3);
                  n4 = new Intl.NumberFormat().format(n4);
                  n5 = new Intl.NumberFormat().format(n5);
                }

                if(percent == 0)
                {
                  n1_per = 0;
                  n2_per = 0;
                  n3_per = 0;
                  n4_per = 0;
                  n5_per = 0;
                }

                $("#exp").empty();
                $("#exp").append(n1);

                $("#lessTwo").empty();
                $("#lessFour").empty();
                $("#lessSix").empty();
                $("#moreSix").empty();

                $("#lessTwo").append(n2);
                $("#lessFour").append(n3);
                $("#lessSix").append(n4);
                $("#moreSix").append(n5);

                $("#exp_per").empty();
                $("#exp_per").append(n1_per + '%');

                $("#lessTwo_per").empty();
                $("#lessFour_per").empty();
                $("#lessSix_per").empty();
                $("#moreSix_per").empty();

                $("#lessTwo_per").append(n2_per + '%');
                $("#lessFour_per").append(n3_per + '%');
                $("#lessSix_per").append(n4_per + '%');
                $("#moreSix_per").append(n5_per + '%');

              } 
            });
          }
        });

        $( '#loadSKUandDesc').change(function() 
        {  
          
          var searchkey = $('#loadSKUandDesc').val();
          var dataBarGraph = $(".change-graph").val();
          var from = start.format('YYYY-MM-DD');
          var to = end.format('YYYY-MM-DD');
          if($('#filterBySKUNo').is(':checked'))
          {
              var filter = 'SKUNo';
          }
          else if($('#filterBySKUDesc').is(':checked'))
          {
              var filter = 'SKUDesc';
          }
          console.log(reend);
          if(myNewChart)
          {
            myNewChart.destroy();
           
            $.ajax({
              type: "POST",
              url: "ageing_dashboard_bysku.php",
              data: 
              { 
                function: 'loadPieChartBySKUNo',
                dataBarGraph:dataBarGraph,
                filter:filter,
                searchkey:searchkey,
                from:from,
                to:to,
                reend:reend,
                restart:restart
              },
              dataType:'json',
              success: function(data)
              {   
                console.log(data);
                var donutData        = {
                  labels: [
                  'Expired',
                  'Less Than 3 Months',
                  'Less Than 6 Months',
                  'More Than 6 Months',
                  'No Expiry',
                  ],
                  datasets: [
                  {
                    data: data[0],
                    backgroundColor : ['#DC143C', '#f39c12', '#00c0ef', '#3c8dbc', '#00a65a'],
                  }
                  ]
                }
                var pieChartCanvas = $('#pieChart').get(0).getContext('2d')
                var pieData        = donutData;
                var options = {
                      legend: {
                          display: false,
                      },
                      tooltips: {
                           enabled: false
                      },
                      plugins: {
                        datalabels: {
                           display: false
                        },
                        outlabels: {
                           display: true
                        }
                     }
                    };

                $(document).ready( function() {
                  myNewChart = new Chart(pieChartCanvas, {
                    type: 'pie',
                    data: pieData,
                    options: options
                  });
                });

                var barGraphData = [];

                barGraphData = data[0];

                // console.log(barGraphData);


                // if(dataBarGraph == 'Total Quantity')
                // {
                  var num1 =barGraphData[0];
                  var n1 = num1.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                  var num2 =barGraphData[1];
                  var n2 = num2.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                  var num3 =barGraphData[2];
                  var n3 = num3.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                  var num4 =barGraphData[3];
                  var n4 = num4.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                  var num5 =barGraphData[4];
                  var n5 = num5.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                  percent = num1 + num2 + num3 + num4 + num5;

                  var n1_per = num1/percent * 100;
                  n1_per = n1_per.toFixed(2);

                  var n2_per = num2/percent * 100;
                  n2_per = n2_per.toFixed(2);

                  var n3_per = num3/percent * 100;
                  n3_per = n3_per.toFixed(2);

                  var n4_per = num4/percent * 100;
                  n4_per = n4_per.toFixed(2);

                  var n5_per = num5/percent * 100;
                  n5_per = n5_per.toFixed(2);

                  // console.log(percent);
                // }
                // else if(dataBarGraph == 'Total Weight')
                // {
                //   var percent = 0;
                //   // percent = num1 + num2 + num3 + num4 + num5;
                //   var num1 =barGraphData[0];
                //   var n1 = num1.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                //   var num2 =barGraphData[1];
                //   var n2 = num2.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                //   var num3 =barGraphData[2];
                //   var n3 = num3.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                //   var num4 =barGraphData[3];
                //   var n4 = num4.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                //   var num5 =barGraphData[4];
                //   var n5 = num5.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                //   percent = num1 + num2 + num3 + num4 + num5;
                //   var n1_per = n1/percent * 100;
                //   n1_per = n1_per.toFixed(2);

                //   var n2_per = n2/percent * 100;
                //   n2_per = n2_per.toFixed(2);

                //   var n3_per = n3/percent * 100;
                //   n3_per = n3_per.toFixed(2);

                //   var n4_per = n4/percent * 100;
                //   n4_per = n4_per.toFixed(2);

                //   var n5_per = n5/percent * 100;
                //   n5_per = n5_per.toFixed(2);

                //   console.log(percent);
                // }
                // console.log(n1_per);
                if(percent == 0)
                {
                  n1_per = 0;
                  n2_per = 0;
                  n3_per = 0;
                  n4_per = 0;
                  n5_per = 0;
                }

                $("#exp").empty();
                $("#exp").append(n1);

                $("#lessTwo").empty();
                $("#lessFour").empty();
                $("#lessSix").empty();
                $("#moreSix").empty();

                $("#lessTwo").append(n2);
                $("#lessFour").append(n3);
                $("#lessSix").append(n4);
                $("#moreSix").append(n5);

                $("#exp_per").empty();
                $("#exp_per").append(n1_per + '%');

                $("#lessTwo_per").empty();
                $("#lessFour_per").empty();
                $("#lessSix_per").empty();
                $("#moreSix_per").empty();

                $("#lessTwo_per").append(n2_per + '%');
                $("#lessFour_per").append(n3_per + '%');
                $("#lessSix_per").append(n4_per + '%');
                $("#moreSix_per").append(n5_per + '%');
              } 
            });
          }
        });

        canvas.onclick = function(evt) {
          var activePoints = myNewChart.getElementsAtEvent(evt);
          if (activePoints[0]) {
            var chartData = activePoints[0]['_chart'].config.data;
            var idx = activePoints[0]['_index'];

            var label = chartData.labels[idx];

            console.log(label);

            

            var searchkey = $('#loadSKUandDesc').val();

            if($('#filterBySKUNo').is(':checked'))
            {
                var filter = 'SKUNo';
            }
            else if($('#filterBySKUDesc').is(':checked'))
            {
                var filter = 'SKUDesc';
            }
            else
            {
              var filter = '';
            }
            var from = start.format('YYYY-MM-DD');
            var to = end.format('YYYY-MM-DD');
            var dataBarGraph = $(".change-graph").val();
            var CustomerID = $('#cus_id').val();
            // console.log(reend);
            // console.log(from);

            $('#modal_load').modal('show');


            $.ajax({
              type: "POST",
              url: "ajax.php",
              data: { function: 
                'pieChartLoadData', 
                label:label,
                dataBarGraph:dataBarGraph,
                filter:filter,
                searchkey:searchkey,
                from:from,
                to:to,
                reend:reend,
                restart:restart,
                CustomerID:CustomerID
              },
              dataType:'json',
              success: function(data)
              {   
                // console.log(reend);
                console.log(data);
                console.log(searchkey);
                $('#exampleModalLongTitle').empty();
                $('#exampleModalLongTitle').append('List of SKU That is ' + label);

                var totalWGT = $.fn.dataTable.render.number( ',', '.', 2, ''  ).display;
                var numberRenderer = $.fn.dataTable.render.number( ',', '.', '', ''  ).display;
                $('#table_data').DataTable({

                  "data": data,
                  autoWidth: false,
                  responsive: true,
                  // dom: 'Bfrtip',
                  buttons: [
                        { extend: 'copyHtml5', footer: true },
                        { extend: 'excelHtml5', footer: true },
                        { extend: 'csvHtml5', footer: true },
                        { extend: 'pdfHtml5', footer: true, 
                            orientation: 'landscape',  pageSize: 'LEGAL',
                           
                        }
                    ],
                  
                    initComplete: function () {
                        var btns = $('.dt-button');
                        btns.addClass('ml-2 btn btn-success btn-md');
                        btns.removeClass('dt-button');

                    },
                  "columns": [
                  {
                    "data": "sku"          
                  },
                  {
                    "data": "desc"          
                  },
                  {
                    "data": "noOfSKU"          
                  },
                  {
                    "data": "quantity"          
                  },
                  {
                    "data": "wgt"          
                  },
                  {
                    "data": "expiry"          
                  },
                  {
                    "data": "expiringInDays"          
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
                  setTimeout(function() 
                  {
                      $('#modal_load').modal('hide');

                  }, 800);
                  $('#view_client').modal('show');

                  $('#view_client').attr('assetid',label);
              } 

            });

          }

          if(label != '')
          {
            $('#table_data').DataTable().destroy();
          }

        };
        
    // piechart
        

    // DateRange Picker -----------------------------------------------------------------------------------------------------------------------------------
      
      var start = moment().subtract(29, 'days');
      var end = moment();
      $('#picker').daterangepicker({
          startDate: start,
          endDate: end,
          ranges: {
          'Today': [moment(), moment()],
          'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
          'Last 7 Days': [moment().subtract(6, 'days'), moment()],
          'Last 30 Days': [moment().subtract(29, 'days'), moment()],
          'This Month': [moment().startOf('month'), moment().endOf('month')],
          'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
          }
      }, function(start, end){


          // console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: '  + ')');
          var re_start = start.format('YYYY-MM-DD');
          var re_end = end.format('YYYY-MM-DD');

          restart = globalThis.restart = re_start;
          reend = globalThis.reend = re_end;

            // piechart
                myNewChart.destroy();

                var from = start.format('YYYY-MM-DD');
                var to = end.format('YYYY-MM-DD');
                // console.log(to);
                var dataBarGraph = $(".change-graph").val();
                var searchSKU = $('#loadSKUandDesc').val();
                if($('#filterBySKUNo').is(':checked'))
                {
                    var filter = 'SKUNo';
                }
                else if($('#filterBySKUDesc').is(':checked'))
                {
                    var filter = 'SKUDesc';
                }
                // console.log(myChart);
                $.ajax({
                  type: "POST",
                  url: "ageing_dashboard_daterange.php",
                  data: 
                  { 
                    function: 'loadPieChartByDateRange',
                    dataBarGraph:dataBarGraph,
                    searchSKU:searchSKU,
                    filter:filter,
                    from:from,
                    to:to
                  },
                  dataType:'json',
                  success: function(data)
                  {   
                    // console.log(data[0]);
                    var donutData        = {
                      labels: [
                      'Expired',
                      'Less Than 3 Months',
                      'Less Than 6 Months',
                      'More Than 6 Months',
                      'No Expiry',
                      ],
                      datasets: [
                      {
                        data: data[0],
                        backgroundColor : ['#DC143C', '#f39c12', '#00c0ef', '#3c8dbc', '#00a65a'],
                      }
                      ]
                    }
                    var pieChartCanvas = $('#pieChart').get(0).getContext('2d')
                    var pieData        = donutData;
                    var options = {
                      legend: {
                          display: false,
                      },
                      tooltips: {
                           enabled: false
                      },
                      plugins: {
                        datalabels: {
                           display: false
                        },
                        outlabels: {
                           display: true
                        }
                     }
                    };

                    $(document).ready( function() {
                      myNewChart = new Chart(pieChartCanvas, {
                        type: 'pie',
                        data: pieData,
                        options: options
                      });
                    });

                    var barGraphData = [];

                    barGraphData = data[0];

                    // console.log(dataBarGraph);


                    var percent = 0;
                    // percent = num1 + num2 + num3 + num4 + num5;
                    var num1 =barGraphData[0];
                    var n1 = num1.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                    var num2 =barGraphData[1];
                    var n2 = num2.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                    var num3 =barGraphData[2];
                    var n3 = num3.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                    var num4 =barGraphData[3];
                    var n4 = num4.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                    var num5 =barGraphData[4];
                    var n5 = num5.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                    percent = num1 + num2 + num3 + num4 + num5;
                    var n1_per = n1/percent * 100;
                    n1_per = n1_per.toFixed(2);

                    var n2_per = n2/percent * 100;
                    n2_per = n2_per.toFixed(2);

                    var n3_per = n3/percent * 100;
                    n3_per = n3_per.toFixed(2);

                    var n4_per = n4/percent * 100;
                    n4_per = n4_per.toFixed(2);

                    var n5_per = n5/percent * 100;
                    n5_per = n5_per.toFixed(2);
     

                   
                    

                    $("#exp").empty();
                    $("#exp").append(n1);

                    $("#lessTwo").empty();
                    $("#lessFour").empty();
                    $("#lessSix").empty();
                    $("#moreSix").empty();

                    $("#lessTwo").append(n2);
                    $("#lessFour").append(n3);
                    $("#lessSix").append(n4);
                    $("#moreSix").append(n5);

                    $("#exp_per").empty();
                    $("#exp_per").append(n1_per + '%');

                    $("#lessTwo_per").empty();
                    $("#lessFour_per").empty();
                    $("#lessSix_per").empty();
                    $("#moreSix_per").empty();

                    $("#lessTwo_per").append(n2_per + '%');
                    $("#lessFour_per").append(n3_per + '%');
                    $("#lessSix_per").append(n4_per + '%');
                    $("#moreSix_per").append(n5_per + '%');
                      } 
                    });
          
            // piechart


          $('#date').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
      });
      $('#date').html(start.format('MMMM D, YYYY') + ' - ' + moment().format('MMMM D, YYYY'));

    // End of DateRange Picker -----------------------------------------------------------------------------------------------------------------------------------



});

</script>



