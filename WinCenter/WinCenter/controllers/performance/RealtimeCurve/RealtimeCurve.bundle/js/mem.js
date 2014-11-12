var memChartObj;
function drawLineMemory(data){
    try{
        chartMap.remove('memChart');
        memChartObj.destroy();
    }catch(err){}
    
    if($("#memChart").length=0){
        return;
    }
    
	 //线型图的数量
	var lineNum = 0;
	//X轴的步长
	var xInterval = data.step;
	
	var memoryData = data.memoryData[0];
	lineNum = memoryData.value.length;
	var memoryStr = "[]";
	if(memoryData.value.length>0){
		memoryStr = "[{pointStart:"+ data.start +",pointInterval:"+ data.step
			+",name:'"+memoryData.name+"',marker:{symbol:'circle'},data:["+memoryData.value+"]}]";
	}
	if(lineNum>8){
		var result = counXInterval(lineNum,xInterval);
		lineNum = result.split(",")[0];
		xInterval = result.split(",")[1];
	}
	
	memChartObj = new Highcharts.Chart({
	    chart: {
	        renderTo: 'memChart',
	        defaultSeriesType: 'spline',
	        height: 280,
	        plotBorderColor: '#e3e6e8',
	        plotBorderWidth: 1,
	        plotBorderRadius: 0,
	        backgroundColor: '',
	        spacingLeft: 0,
	        plotBackgroundColor: '#FFFFFF',
	        marginTop: 30,
	        marginBottom: 35,
	        events:{
	        	load:function(){
	        		var series = this.series;
	        		var endTime = data.end;
	        		var loadData = function(){
	        			//var params = "startTime="+pc.util.timeToFormatStr(endTime + 5000,"yyyy-MM-dd HH:mm:ss")+"&endTime="+pc.util.timeToFormatStr(endTime+ 20000,"yyyy-MM-dd HH:mm:ss");
	        			var params = "startTime=" + (endTime + 20000)+"&cf=AVERAGE"; 
	        			if(type=="HOST"){
	        				$.PERFORMANCE.getPerformanceByHostId(dcId,hostId,params,function(meData){
	        					if(meData.end!="undefined" && meData.end!=undefined){
		        					endTime = meData.end;
		        					buildMemoryDate(meData,series);
	        					}
		        			});
	        			}else{
	        				$.PERFORMANCE.getPerformanceApi(dcId,vmId,params,function(meData){
	        					if(meData.end!="undefined" && meData.end!=undefined){
		        					endTime = meData.end;
		        					buildMemoryDate(meData,series);
	        					}
		        			});
	        			}
	        		}
	        		if(data.step == 5000){
	        			//memoryPerformance = setInterval(loadData,20000);
	        		}
	        	}
	        }
	    },

	    /*
	     * NOTE: Highcharts is FREE for non-commercial projects only,
	     * and requires the credits ("Highcharts.com" in the corner).
	     *
	     * If you've purchased a license, you can remove the credit by
	     * adding `enabled: false` to `credits`.
	     *
	     */
	    credits: {
	        style: {
	            color: '#9fa2a5'
	        }
	    },

	    title: {
	    	 text: "内存使用率"+"(%)"//内存使用率
	    },

	    legend: {
	    	layout: 'horizontal',
            align: 'right',
            verticalAlign: 'right',
            width:120,
            borderWidth: 0,
	        itemStyle: {
	            fontSize: '11px',
	            color: '#1E1E1E'
	        }
	    },

	    yAxis: {
	        title: {
	            text: ''
	        },
	        gridLineWidth: 0,
	        alternateGridColor: ['rgba(68, 170, 213, 0.1)', 'rgba(0, 0, 0, 0)'],
	        opposite: true,
	        labels: {
	            style: {
	                color: '#9fa2a5'
	            }
	        },
	        min:0,
	        max:100
	    },
	    credits:{
        	enabled: false
        },
        tooltip: {
            formatter: function() {
                    return '<b>'+timeToFormatStr(this.x,"yyyy-MM-dd HH:mm:ss") +'</b><br/>'+
                    this.series.name+'使用率: '+ this.y.toFixed(2) +'%';
            }
        },

	    xAxis: {
	        type: 'datetime',
	        lineWidth: 0,
	 //       maxZoom: 5 * 24 * 3600 * 1000, // 5 days
	        tickInterval: xInterval, // 1 day
	        labels: {
	            formatter: function() {
	                return timeToFormatStr(this.value,"yyyy-MM-dd HH:mm");
	            },
	            x: 0,
	            style: {
	                color: '#9fa2a5'
	            },
	            align:'left'
	        }
	    },

	    plotOptions: {
	        series: {
	            marker: {
	                lineWidth: 1, // The border of each point (defaults to white)
	                radius: 4 // The thickness of each point
	            },

	            lineWidth: 3, // The thickness of the line between points
	            shadow: false
	        },
	        spline: {
	            lineWidth: 3,
	            states: {
	                hover: {
	                    lineWidth: 4
	                }
	            },
	            marker: {
	                enabled: false
	            },
	            pointInterval: 3600000, // one hour
	            pointStart: Date.UTC(2009, 9, 6, 0, 0, 0)
	        }
	    },

	    /*
	     * Colors for the main lines.
	     *
	     * We recommend not using more lines than four in a single chart
	     * like this one, but if you must, then make sure you add more colors
	     * below, since otherwise you'll default to Highcharts' ugly colors :)
	     */
	    colors: [
	        '#52d74c', // green
	        '#E35733', // orange
	        '#4c97d7', // blue
	        '#e268de' // purple
	    ],

	    series: eval(memoryStr)
	});
    chartMap.put('memChart', memChartObj);
}

function buildMemoryDate(meData,series){
    if(!series){
        return;
    }
	var addMeData = meData.memoryData[0];
	for(var i=0;i<series.length;i++){
		if(series[i].name==addMeData.name){
			for(var j=0;j<addMeData.value.length;j++){
				series[i].addPoint(parseInt(addMeData.value[j]),false,true);
			}
		}
	}
	memChartObj.redraw();
}

