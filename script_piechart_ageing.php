<script>
  $(function () {
    // received
        var receivedChartData = {
            labels  : ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
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
              data                : [65, 59, 80, 81, 56, 55, 40, 65, 59, 80, 81, 56]
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
              data                : [28, 48, 40, 19, 86, 27, 90, 28, 48, 40, 19, 86]
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


          $(".change-graph").change(function()
          { 
            var dataBarGraph = $(".change-graph").val();
            if(dataBarGraph == 'Total SO')
            {
              var title = 'Total SO';
              data1 = [145, 59, 220, 81, 132, 235, 321, 165, 359, 280, 81, 256];
              data2 = [145, 459, 220, 421, 236, 355, 140, 165, 159, 210, 181, 156];
            }
            else if(dataBarGraph == 'Total Quantity')
            {
              var title = 'Total Quantity';
              data1 = [145, 59, 260, 81, 112, 235, 321, 165, 359, 280, 81, 256];
              data2 = [145, 459, 220, 421, 236, 355, 140, 165, 159, 810, 181, 156];
            }
            else if(dataBarGraph == 'Total Weight')
            {
              var title = 'Total Weight';
              data1 = [145, 59, 220, 881, 132, 235, 321, 165, 359, 280, 81, 256];
              data2 = [145, 459, 220, 421, 236, 323, 140, 165, 159, 890, 181, 456];
            }

            if (receivedChart)
            {
              receivedChart.destroy();
              var receivedChartData = {
                  labels  : ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
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
                    data                : data1
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
                    data                : data2
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
                title: 
                  {
                   display: true,
                   text: title
                }
                }

                $(document).ready( function() {
                        receivedChart = new Chart(receivedbarChartCanvas, {
                          type: 'bar',
                          data: receivedbarChartData,
                          options: barChartOptions
                        });
                      });

            }

          });

          var dates = $("#date").val();
          console.log(dates);
          $( '#loadSKUandDesc').change(function() 
              { 
                
            var dataBarGraph = $(".change-graph").val();
            if(dataBarGraph == 'Total SO')
            {
              var title = 'Total SO';
              data1 = [145, 59, 220, 81, 132, 235, 321, 165, 359, 280, 81, 256];
              data2 = [145, 459, 220, 421, 236, 355, 140, 165, 159, 210, 181, 156];
            }
            else if(dataBarGraph == 'Total Quantity')
            {
              var title = 'Total Quantity';
              data1 = [145, 59, 220, 81, 132, 235, 321, 165, 359, 280, 81, 256];
              data2 = [145, 459, 220, 421, 236, 355, 140, 165, 159, 810, 181, 156];
            }
            else if(dataBarGraph == 'Total Weight')
            {
              var title = 'Total Weight';
              data1 = [145, 59, 220, 81, 132, 235, 321, 165, 359, 280, 81, 256];
              data2 = [145, 459, 220, 421, 236, 355, 140, 165, 159, 810, 181, 156];
            }
            else
            {
              var title = '';
              data1 = [145, 59, 220, 81, 132, 235, 321, 165, 359, 280, 81, 256];
              data2 = [145, 459, 220, 421, 236, 355, 140, 165, 159, 810, 181, 156];
            }

            if (receivedChart)
            {
              receivedChart.destroy();
              var receivedChartData = {
                  labels  : ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
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
                    data                : data1
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
                    data                : data2
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
                title: 
                  {
                   display: true,
                   text: title
                }
                }

                $(document).ready( function() {
                        receivedChart = new Chart(receivedbarChartCanvas, {
                          type: 'bar',
                          data: receivedbarChartData,
                          options: barChartOptions
                        });
                      });

                  }
            });


      function clickHandReceived(click)
      {
          var points = receivedChart.getElementsAtEventForMode(click, 'nearest', {intersect:true}, true);
          if(points.length == 1) {
              
              var barGraph = points[0]._datasetIndex;
              var label = points[0]._index;
              label = label + 1;
              $('#view_bargraph_incalendar').modal();

              $('#view_bargraph_incalendar').attr('assetid');

              console.log(label);

              if(label == 1){ var ricksDate = new Date(2021, 0, 1); }
                  else if(label == 2){ var ricksDate = new Date(2021, 1, 1); }
                  else if(label == 3){ var ricksDate = new Date(2021, 2, 1); }
                  else if(label == 4){ var ricksDate = new Date(2021, 3, 1); }
                  else if(label == 5){ var ricksDate = new Date(2021, 4, 1); }
                  else if(label == 6){ var ricksDate = new Date(2021, 5, 1); }
                  else if(label == 7){ var ricksDate = new Date(2021, 6, 1); }
                  else if(label == 8){ var ricksDate = new Date(2021, 7, 1); }
                  else if(label == 9){ var ricksDate = new Date(2021, 8, 1); }
                  else if(label == 10){ var ricksDate = new Date(2021, 9, 1); }
                  else if(label == 11){ var ricksDate = new Date(2021, 10, 1); }
                  else if(label == 12){ var ricksDate = new Date(2021, 11, 1); }

              $.ajax({
                type: "POST",
                url: "ajax.php",
                data: { 
                  function: 'barChartLoadData',
                  barGraph:barGraph,
                  label:label,
                  reend:reend,
                  restart:restart
                },
                dataType:'text',
                success: function(data)
                {   
                  console.log(data);
                  
                  var cal = $('#calendar').fullCalendar({
                    header: {
                      left: '',
                      center: 'title',
                      right: ''
                    },
                    height: 950,
                    selectable: false,
                    selectHelper: false,
                    editable: false,
                    defaultDate: ricksDate,
                    events:'load.php' 
                  });
                 
                } 

              });

              if(label != '' || label == 0)
              {
                 $('#table_data_rec').DataTable().destroy();
                 $('#calendar').fullCalendar('destroy');
              }
                  
          }
      }

      canvas.onclick = clickHandReceived;

    // received

    // order
        var receivedChartData = {
            labels  : ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
            datasets: [
            {
              label               : 'Delivered',
              backgroundColor     : '#DC143C',
              borderColor         : 'rgba(210, 214, 222, 1)',
              pointRadius         : false,
              pointColor          : 'rgba(210, 214, 222, 1)',
              pointStrokeColor    : '#c1c7d1',
              pointHighlightFill  : '#fff',
              pointHighlightStroke: 'rgba(220,220,220,1)',
              data                : [65, 59, 80, 81, 56, 55, 40, 65, 59, 80, 81, 56]
            },
            {
              label               : 'UnDelivered',
              backgroundColor     : '#C1E1C1',
              borderColor         : 'rgba(60,141,188,0.8)',
              pointRadius          : false,
              pointColor          : '#3b8bba',
              pointStrokeColor    : 'rgba(60,141,188,1)',
              pointHighlightFill  : '#fff',
              pointHighlightStroke: 'rgba(60,141,188,1)',
              data                : [28, 48, 40, 19, 86, 27, 90, 28, 48, 40, 19, 86]
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

          var canvas = document.getElementById("barChart1");
          var ctx = canvas.getContext("2d");
          var orderChart = new Chart(ctx, {
            type: 'bar',
            data: receivedbarChartData,
            options: barChartOptions
          });


          $(".change-graph").change(function()
          { 
            var dataBarGraph = $(".change-graph").val();
            if(dataBarGraph == 'Total SO')
            {
              var title = 'Total SO';
              data1 = [145, 59, 220, 81, 132, 235, 321, 165, 359, 280, 81, 256];
              data2 = [145, 459, 220, 421, 236, 355, 140, 165, 159, 210, 181, 156];
            }
            else if(dataBarGraph == 'Total Quantity')
            {
              var title = 'Total Quantity';
              data1 = [145, 59, 220, 81, 132, 235, 321, 165, 359, 280, 81, 256];
              data2 = [145, 459, 220, 421, 236, 355, 140, 165, 159, 810, 181, 156];
            }
            else if(dataBarGraph == 'Total Weight')
            {
              var title = 'Total Weight';
              data1 = [145, 59, 220, 81, 132, 235, 321, 165, 359, 280, 81, 256];
              data2 = [145, 459, 220, 421, 236, 355, 140, 165, 159, 810, 181, 156];
            }

            if (orderChart)
            {
              orderChart.destroy();
              var receivedChartData = {
                  labels  : ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                  datasets: [
                  {
                    label               : 'Delivered',
                    backgroundColor     : '#DC143C',
                    borderColor         : 'rgba(210, 214, 222, 1)',
                    pointRadius         : false,
                    pointColor          : 'rgba(210, 214, 222, 1)',
                    pointStrokeColor    : '#c1c7d1',
                    pointHighlightFill  : '#fff',
                    pointHighlightStroke: 'rgba(220,220,220,1)',
                    data                : data1
                  },
                  {
                    label               : 'UnDelivered',
                    backgroundColor     : '#C1E1C1',
                    borderColor         : 'rgba(60,141,188,0.8)',
                    pointRadius          : false,
                    pointColor          : '#3b8bba',
                    pointStrokeColor    : 'rgba(60,141,188,1)',
                    pointHighlightFill  : '#fff',
                    pointHighlightStroke: 'rgba(60,141,188,1)',
                    data                : data2
                  },
                  ]
                }

                //-------------
                //- BAR CHART -
                //-------------
                var receivedbarChartCanvas = $('#barChart1').get(0).getContext('2d')
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
                title: 
                  {
                   display: true,
                   text: title
                }
                }

                $(document).ready( function() {
                        orderChart = new Chart(receivedbarChartCanvas, {
                          type: 'bar',
                          data: receivedbarChartData,
                          options: barChartOptions
                        });
                      });

            }

          });

          var dates = $("#date").val();
          console.log(dates);
          $( '#loadSKUandDesc').change(function() 
              { 
                
            var dataBarGraph = $(".change-graph").val();
            if(dataBarGraph == 'Total SO')
            {
              var title = 'Total SO';
              data1 = [145, 59, 220, 81, 132, 235, 321, 165, 359, 280, 81, 256];
              data2 = [145, 459, 220, 421, 236, 355, 140, 165, 159, 210, 181, 156];
            }
            else if(dataBarGraph == 'Total Quantity')
            {
              var title = 'Total Quantity';
              data1 = [145, 59, 220, 81, 132, 235, 321, 165, 359, 280, 81, 256];
              data2 = [145, 459, 220, 421, 236, 355, 140, 165, 159, 810, 181, 156];
            }
            else if(dataBarGraph == 'Total Weight')
            {
              var title = 'Total Weight';
              data1 = [145, 59, 220, 81, 132, 235, 321, 165, 359, 280, 81, 256];
              data2 = [145, 459, 220, 421, 236, 355, 140, 165, 159, 810, 181, 156];
            }
            else
            {
              var title = '';
              data1 = [145, 59, 220, 81, 132, 235, 321, 165, 359, 280, 81, 256];
              data2 = [145, 459, 220, 421, 236, 355, 140, 165, 159, 810, 181, 156];
            }

            if (orderChart)
            {
              orderChart.destroy();
              var receivedChartData = {
                  labels  : ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                  datasets: [
                  {
                    label               : 'Delivered',
                    backgroundColor     : '#DC143C',
                    borderColor         : 'rgba(210, 214, 222, 1)',
                    pointRadius         : false,
                    pointColor          : 'rgba(210, 214, 222, 1)',
                    pointStrokeColor    : '#c1c7d1',
                    pointHighlightFill  : '#fff',
                    pointHighlightStroke: 'rgba(220,220,220,1)',
                    data                : data1
                  },
                  {
                    label               : 'UnDelivered',
                    backgroundColor     : '#C1E1C1',
                    borderColor         : 'rgba(60,141,188,0.8)',
                    pointRadius          : false,
                    pointColor          : '#3b8bba',
                    pointStrokeColor    : 'rgba(60,141,188,1)',
                    pointHighlightFill  : '#fff',
                    pointHighlightStroke: 'rgba(60,141,188,1)',
                    data                : data2
                  },
                  ]
                }

                //-------------
                //- BAR CHART -
                //-------------
                var receivedbarChartCanvas = $('#barChart1').get(0).getContext('2d')
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
                title: 
                  {
                   display: true,
                   text: title
                }
                }

                $(document).ready( function() {
                        orderChart = new Chart(receivedbarChartCanvas, {
                          type: 'bar',
                          data: receivedbarChartData,
                          options: barChartOptions
                        });
                      });

            }
        });

      function clickHandOrder(click)
      {
          var points = orderChart.getElementsAtEventForMode(click, 'nearest', {intersect:true}, true);
          console.log(points);
          if(points.length == 1) {
              
              var barGraph = points[0]._datasetIndex;
              var label = points[0]._index;
              label = label + 1;
              $('#view_bargraph_incalendar').modal();

              $('#view_bargraph_incalendar').attr('assetid');

              console.log(barGraph);

              if(label == 1){ var ricksDate = new Date(2021, 0, 1); }
              else if(label == 2){ var ricksDate = new Date(2021, 1, 1); }
              else if(label == 3){ var ricksDate = new Date(2021, 2, 1); }
              else if(label == 4){ var ricksDate = new Date(2021, 3, 1); }
              else if(label == 5){ var ricksDate = new Date(2021, 4, 1); }
              else if(label == 6){ var ricksDate = new Date(2021, 5, 1); }
              else if(label == 7){ var ricksDate = new Date(2021, 6, 1); }
              else if(label == 8){ var ricksDate = new Date(2021, 7, 1); }
              else if(label == 9){ var ricksDate = new Date(2021, 8, 1); }
              else if(label == 10){ var ricksDate = new Date(2021, 9, 1); }
              else if(label == 11){ var ricksDate = new Date(2021, 10, 1); }
              else if(label == 12){ var ricksDate = new Date(2021, 11, 1); }

              $.ajax({
                type: "POST",
                url: "ajax.php",
                data: { 
                  function: 'barChartLoadData',
                  barGraph:barGraph,
                  label:label,
                  reend:reend,
                  restart:restart
                },
                dataType:'text',
                success: function(data)
                {   
                  console.log(data);
                  
                  var cal = $('#calendar').fullCalendar({
                    header: {
                      left: '',
                      center: 'title',
                      right: ''
                    },
                    height: 950,
                    selectable: false,
                    selectHelper: false,
                    editable: false,
                    defaultDate: ricksDate,
                    events:'loadOrder.php' 
                  });
                 
                } 

              });

              if(label != '' || label == 0)
              {
                 // $('#table_data_rec').DataTable().destroy();
                 $('#calendar').fullCalendar('destroy');
              }
                  
          }
      }

      canvas.onclick = clickHandOrder;

    // order


    // piechart
        var myNewChart;
        var data = {
          labels: [
          'Expired',
          'Less Than 2 Months',
          'Less Than 4 Months',
          'Less Than 6 Months',
          'More Than 6 Months',
          ],
          datasets: [
          {
            data: [
            <?php echo $expired ?>,
            <?php echo $lTwo ?>,
            <?php echo $lFour ?>,
            <?php echo $lSix ?>,
            <?php echo $mSix ?>,
            ],
            backgroundColor : ['#DC143C', '#f39c12', '#00c0ef', '#3c8dbc', '#00a65a'],
          }
          ]
        };
          
        var options = {
          tooltips: {
            enabled: false
          },
          plugins: {
            datalabels: {
                display: true,
              formatter: (value, ctx) => {
                let sum = 0;
                let sub_total = 0;
                let dataArr = ctx.chart.data.datasets[0].data;
                dataArr.map(data => {
                  sum += data;
                });
                // sub_total = <?php echo $lTwo ?> + <?php echo $lFour ?>;
                // sum = sum - sub_total;
                let percentage = (value*100 / sum).toFixed(2)+"%";
                return percentage;
              },
              color: '#fff',
              font: {
                  size: 15,
                  weight: 600
              },
            }
          },
            
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
          var from = start.format('YYYY-MM-DD');
          var to = end.format('YYYY-MM-DD');
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
                // console.log(data[0]);
                var donutData        = {
                  labels: [
                  ' Expired',
                  'Less Than 2 Months',
                  'Less Than 4 Months',
                  'Less Than 6 Months',
                  'More Than 6 Months',
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
                  tooltips: {
                    enabled: false
                  },
                  plugins: {
                    datalabels: {
                      formatter: (value, ctx) => {
                        let sum = 0;
                        let sub = 0;
                        let sub_total = 0;
                        let dataArr = ctx.chart.data.datasets[0].data;
                        dataArr.map(data => {
                          sum += data;
                          
                        });
                        // sub = dataArr[1] + dataArr[2];
                        // sum = sum - sub;
                        let percentage = (value*100 / sum).toFixed(2)+"%";
                        return percentage;
                      },
                      color: '#fff',
                    }
                  },
                  title: 
                  {
                  display: true,
                  text: title
                  // 19445 326,808
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

                console.log(barGraphData[1]);


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
                console.log(data[0]);
                var donutData        = {
                  labels: [
                  ' Expired',
                  'Less Than 2 Months',
                  'Less Than 4 Months',
                  'Less Than 6 Months',
                  'More Than 6 Months',
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
                    tooltips: {
                      enabled: false
                    },
                    plugins: {
                      datalabels: {
                        formatter: (value, ctx) => {
                          let sum = 0;
                          let sub_total = 0;
                          let dataArr = ctx.chart.data.datasets[0].data;
                          dataArr.map(data => {
                            sum += data;
                          });
                          let percentage = (value*100 / sum).toFixed(2)+"%";
                          return percentage;
                        },
                        color: '#fff',
                      }
                    },
                    
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

                console.log(barGraphData[1]);


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

            $('#view_client').modal();

            $('#view_client').attr('assetid',label);

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
            console.log(reend);
            console.log(from);
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
                restart:restart
              },
              dataType:'json',
              success: function(data)
              {   
                // console.log(data);

                $('#table_data').DataTable({

                  "data": data,
                  autoWidth: false,
                  responsive: true,
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
                  "bPaginate": false

                });

                $('#exampleModalLongTitle').empty();
                $('#exampleModalLongTitle').append('List of SKU of ' + label);
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


            // received

              var dataBarGraph = $(".change-graph").val();
              if(dataBarGraph == 'Total SO')
              {
                var title = 'Total SO';
                recdata1 = [145, 59, 250, 81, 135, 535, 351, 165, 359, 580, 81, 556];
                recdata2 = [145, 459, 220, 421, 236, 355, 240, 265, 259, 210, 181, 156];

                orderdata1 = [145, 59, 220, 81, 142, 245, 421, 165, 459, 280, 81, 256];
                orderdata2 = [145, 459, 220, 421, 246, 455, 140, 165, 159, 210, 181, 156];
              }
              else if(dataBarGraph == 'Total Quantity')
              {
                var title = 'Total Quantity';
                recdata1 = [145, 59, 220, 81, 142, 235, 321, 165, 359, 280, 81, 256];
                recdata2 = [145, 459, 220, 481, 236, 385, 140, 165, 159, 810, 181, 156];

                orderdata1 = [145, 59, 280, 81, 132, 235, 321, 165, 359, 280, 81, 256];
                orderdata2 = [145, 459, 220, 421, 286, 355, 140, 165, 159, 210, 181, 156];
              }
              else if(dataBarGraph == 'Total Weight')
              {
                var title = 'Total Weight';
                recdata1 = [145, 59, 220, 81, 132, 835, 321, 165, 359, 288, 81, 256];
                recdata2 = [145, 459, 220, 421, 236, 385, 140, 165, 159, 810, 181, 156];

                orderdata1 = [145, 59, 220, 81, 132, 235, 321, 185, 359, 280, 81, 256];
                orderdata2 = [145, 459, 220, 421, 236, 355, 180, 165, 159, 210, 181, 856];
              }
              else
              {
                var title = '';
                recdata1 = [145, 59, 220, 81, 132, 235, 321, 165, 359, 280, 81, 256];
                recdata2 = [145, 459, 220, 421, 236, 355, 140, 165, 159, 810, 181, 156];

                orderdata1 = [185, 59, 288, 81, 132, 235, 821, 165, 859, 280, 81, 256];
                orderdata2 = [145, 459, 280, 821, 236, 355, 180, 165, 189, 210, 181, 156];
              }
              receivedChart.destroy();

              var receivedChartData = {
                  labels  : ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
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
                    data                : recdata1
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
                    data                : recdata2
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
                title: 
                  {
                   display: true,
                   text: title
                }
                }

                $(document).ready( function() {
                        receivedChart = new Chart(receivedbarChartCanvas, {
                          type: 'bar',
                          data: receivedbarChartData,
                          options: barChartOptions
                        });
                      });
            // received

            // order
                orderChart.destroy();
                  var orderChartData = {
                      labels  : ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                      datasets: [
                      {
                        label               : 'UnDelivered',
                        backgroundColor     : '#DC143C',
                        borderColor         : 'rgba(210, 214, 222, 1)',
                        pointRadius         : false,
                        pointColor          : 'rgba(210, 214, 222, 1)',
                        pointStrokeColor    : '#c1c7d1',
                        pointHighlightFill  : '#fff',
                        pointHighlightStroke: 'rgba(220,220,220,1)',
                        data                : orderdata1
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
                        data                : orderdata2
                      },
                      ]
                    }

                    //-------------
                    //- BAR CHART -
                    //-------------
                    var orderbarChartCanvas = $('#barChart1').get(0).getContext('2d')
                    var orderbarChartData = $.extend(true, {}, orderChartData)
                    var temp0Order = orderChartData.datasets[0]
                    var temp1Order = orderChartData.datasets[1]
                    orderbarChartData.datasets[0] = temp1Order
                    orderbarChartData.datasets[1] = temp0Order

                    var barChartOptions = {
                      responsive              : true,
                      maintainAspectRatio     : false,
                      datasetFill             : false,
                      plugins: {
                        datalabels: {
                          display: false
                        }
                      },
                    title: 
                      {
                       display: true,
                       text: title
                    }
                    }

                    $(document).ready( function() {
                        orderChart = new Chart(orderbarChartCanvas, {
                          type: 'bar',
                          data: orderbarChartData,
                          options: barChartOptions
                        });
                      });
            // order

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
                    console.log(data[0]);
                    var donutData        = {
                      labels: [
                      ' Expired',
                      'Less Than 2 Months',
                      'Less Than 4 Months',
                      'Less Than 6 Months',
                      'More Than 6 Months',
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
                      tooltips: {
                        enabled: false
                      },
                      plugins: {
                        datalabels: {
                          formatter: (value, ctx) => {
                            let sum = 0;
                            let sub = 0;
                            let sub_total = 0;
                            let dataArr = ctx.chart.data.datasets[0].data;
                            dataArr.map(data => {
                              sum += data;
                              
                            });
                            // sub = dataArr[1] + dataArr[2];
                            // sum = sum - sub;
                            let percentage = (value*100 / sum).toFixed(2)+"%";
                            return percentage;
                          },
                          color: '#fff',
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

                    console.log(barGraphData[1]);


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
                  } 
                });
          
            // piechart


          $('#date').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
      });
      $('#date').html(start.format('MMMM D, YYYY') + ' - ' + moment().format('MMMM D, YYYY'));

    // End of DateRange Picker -----------------------------------------------------------------------------------------------------------------------------------



  });

</script>