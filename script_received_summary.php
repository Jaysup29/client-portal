            // received
                receivedChart.destroy();
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
                  var areaChartData = {
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
                    var barChartCanvas = $('#barChart').get(0).getContext('2d')
                    var barChartData = $.extend(true, {}, areaChartData)
                    var temp0 = areaChartData.datasets[0]
                    var temp1 = areaChartData.datasets[1]
                    barChartData.datasets[0] = temp1
                    barChartData.datasets[1] = temp0

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
                            receivedChart = new Chart(barChartCanvas, {
                              type: 'bar',
                              data: barChartData,
                              options: barChartOptions
                            });
                          });

                }
            //received