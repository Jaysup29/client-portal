<script>
	
	$(function () {
	    var orderbarchartdata = {
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
	        data                : [65, 59, 80, 81, 56, 55, 40, 65, 59, 80, 81, 56]
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
	        data                : [28, 48, 40, 19, 86, 27, 90, 28, 48, 40, 19, 86]
	      },
	      ],


	    }

	    //-------------
	    //- BAR CHART -
	    //-------------
	    var barChartCanvasOrder = $('#barChart1').get(0).getContext('2d')
	    var barChartDataOrder = $.extend(true, {}, orderbarchartdata)
	    var temp0Order = orderbarchartdata.datasets[0]
	    var temp1Order = orderbarchartdata.datasets[1]
	    barChartDataOrder.datasets[0] = temp1Order
	    barChartDataOrder.datasets[1] = temp0Order

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

	    $(document).ready(
		  function() {

		    var canvas = document.getElementById("barChart1");
		    var ctx = canvas.getContext("2d");
		    var orderChart = new Chart(ctx, {
		      type: 'bar',
		      data: barChartData,
		      options: barChartOptions
		    });

		    $(".change-graph").change(function()
		    {	
				var dataBarGraph = $(".change-graph").val();
				// console.log(dataBarGraph);
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
		    		var orderbarchartdata = {
				      labels  : ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
				      datasets: [
				      {
				        label               : 'Received',
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
				        label               : 'Planned',
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
				    var barChartCanvasOrder = $('#barChart1').get(0).getContext('2d')
				    var barChartDataOrder = $.extend(true, {}, orderbarchartdata)
				    var temp0Order = orderbarchartdata.datasets[0]
				    var temp1Order = orderbarchartdata.datasets[1]
				    barChartDataOrder.datasets[0] = temp1Order
				    barChartDataOrder.datasets[1] = temp0Order

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

				    orderChart = new Chart(barChartCanvasOrder, {
				      type: 'bar',
				      data: barChartData,
				      options: barChartOptions
				    })

		    	}

		    });

		    $( '#loadSKUandDesc').change(function() 
        	{	
				var dataBarGraph = $(".change-graph").val();
				// console.log(dataBarGraph);
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
		    		var orderbarchartdata = {
				      labels  : ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
				      datasets: [
				      {
				        label               : 'Received',
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
				        label               : 'Planned',
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
				    var barChartCanvasOrder = $('#barChart1').get(0).getContext('2d')
				    var barChartDataOrder = $.extend(true, {}, orderbarchartdata)
				    var temp0Order = orderbarchartdata.datasets[0]
				    var temp1Order = orderbarchartdata.datasets[1]
				    barChartDataOrder.datasets[0] = temp1Order
				    barChartDataOrder.datasets[1] = temp0Order

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

				    orderChart = new Chart(barChartCanvasOrder, {
				      type: 'bar',
				      data: barChartData,
				      options: barChartOptions
				    })

		    	}

		    });
		  });

	    

	  });
	
</script>