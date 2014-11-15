var cpuChartObj;
function drawLineCpu(data,cpuType){
    
    try{
        chartMap.remove('cpuChart');
        cpuChartObj.destroy();
    }catch(err){}
    
    if($("#cpuChart").length=0){
        return;
    }
    
    //线型图的数量
	var lineNum = 0;
	//X轴的步长
	//var xInterval = data.step;
	var xInterval = data.step;
	
	var str ="[";
	

	for(var i=0;i<data.cpuData.length;i++){
		if(cpuType=="all"){
			if(data.cpuData[i].name=="CPU"){
				lineNum = data.cpuData[i].value.length;
				str +="{pointStart:"+data.start+",pointInterval:"+ data.step
					 +",name:'"+data.cpuData[i].name.toUpperCase()+"',marker:{symbol:'circle'},data:["+data.cpuData[i].value+"]}";
			}
		}else{
			if(data.cpuData[i].name!="CPU"){
				lineNum = data.cpuData[i].value.length;
				str +="{pointStart:"+data.start+",pointInterval:"+ data.step
				+",name:'"+data.cpuData[i].name.toUpperCase()+"',marker:{symbol:'circle'},data:["+data.cpuData[i].value+"]}";
				if(type=="HOST"){
					if(i<data.cpuData.length-1) str+=",";
				}else{
					if(i<data.cpuData.length-2) str+=",";
				}
			}
		}
	}
	str +="]";
	if(lineNum>8){
		var result = counXInterval(lineNum,xInterval);
		lineNum = result.split(",")[0];
		xInterval = result.split(",")[1];
	}
	/*
	 * A highcharts spline graph, customized for a nicer Inspiritas-look.
	 *
	 * All the options can be separated into a reusable object,
	 * in order to create multiple charts with the same looks:
	 * http://www.highcharts.com/documentation/how-to-use
	 *
	 * TODO: Design the tooltips when hovering items.
	 */
	cpuChartObj = new Highcharts.Chart({
	    chart: {
	        renderTo: 'cpuChart',
	        defaultSeriesType: 'spline',
	        height: 280,
	        plotBorderColor: '#e3e6e8',
	        plotBorderWidth: 1,
	        plotBorderRadius: 0,
	        backgroundColor: '',
	        spacingLeft: 0,
	        plotBackgroundColor: '#FFFFFF',
	        marginTop: 45,
	        marginBottom: 35,
	        events:{
	        	load:function(){
	        		var series = this.series;
	        		var endTime = data.end;
	        		var loadData = function(){
	        			//var params = "startTime="+pc.util.timeToFormatStr(endTime + 5000,"yyyy-MM-dd HH:mm:ss")+"&endTime="+pc.util.timeToFormatStr(endTime+ 20000,"yyyy-MM-dd HH:mm:ss");
	        			var params = "startTime=" + (endTime + 20000)+"&cf=AVERAGE"; 
	        			if(type=="HOST"){
	        				$.PERFORMANCE.getPerformanceByHostId(dcId,hostId,params,function(cpuDate){
	        					if(cpuDate.end!="undefined" && cpuDate.end!=undefined){
	        						endTime = cpuDate.end;
	        						buildCpuDate(cpuDate,series);
	        					}
		        			});
	        			}else{
	        				/*$.PERFORMANCE.getPerformanceByVmId(dcId,vmId,params,function(cpuDate){
	        					if(cpuDate.end!="undefined" && cpuDate.end!=undefined){
		        					endTime = cpuDate.end;
		        					buildCpuDate(cpuDate,series);
	        					}
		        			});*/
	        				$.PERFORMANCE.getPerformanceApi(dcId,vmId,params,function(cpuDate){
	        					if(cpuDate.end!="undefined" && cpuDate.end!=undefined){
		        					endTime = cpuDate.end;
		        					buildCpuDate(cpuDate,series);
	        					}
		        			});
	        			}
	        		}
	        		if(data.step == 5000){
	        			//cpuPerformance = setInterval(loadData,20000);
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
	        text: "CPU使用率(%)"//CPU使用率
	    },

	    legend: {
	    	layout: 'vertical',
            align: 'right',
            width:120,
            height:120,
            verticalAlign: 'top',
            borderWidth: 0,
	        itemStyle: {
	            fontSize: '11px',
	            color: '#1E1E1E'
	        },
	        y:35
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
	    tooltip: {
            formatter: function() {
                    return '<b>'+ timeToFormatStr(this.x,"yyyy-MM-dd HH:mm:ss") +'</b><br/>'+
                    this.series.name+"使用率："+ this.y.toFixed(2) +'%';//使用率： 
            }
        },

	    xAxis: {
	    	
	        type: 'datetime',
	        lineWidth: 0,
	     //   maxZoom: 5 * 24 * 3600 * 1000, // 5 days
	        tickInterval:  xInterval, // 1 day
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
	    credits:{
        	enabled: false
        },

	    plotOptions: {
	        series: {
	            marker: {
	                lineWidth: 1, // The border of each point (defaults to white)
	                radius: 4    // The thickness of each point
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
	            }
	        }
	    },

	    /*
	     * Colors for the main lines.
	     *
	     * We recommend not using more lines than four in a single chart
	     * like this one, but if you must, then make sure you add more colors
	     * below, since otherwise you'll default to Highcharts' ugly colors :)
	     * 
	     * [{pointStart:1364828400000,
	    	pointInterval:3600000,
	    	name:'cpu0',
	    	marker:{symbol:'circle'},
	    	data:[0.0074,0.0074,0.0075,0.0054,0.0056,0.0048,0.0059,0.0060,0.0046,0.0051,0.0059,0.0077,0.0072,0.0090,0.0067,0.0042,0.0061,0.0063,0.0064,0.0081,0.0056,0.0065,0.0077,0.0082,0.0074,0.0077,0.0066,0.0053,0.0068]
	    	}]
	     */
	    colors: [
	        '#E35733', // orange
	        '#4c97d7', // blue
	        '#52d74c', // green
	        '#e268de' // purple
	    ],

	    series: eval(str)
	});
	//chartMap.put('cpuChart', cpuChartObj);
}

function buildCpuDate(cpuDate,series){
    if(!series){
        return;
    }
	for(var i=0;i<series.length;i++){
		for(var j=0;j<cpuDate.cpuData.length;j++){
			if(series[i].name==cpuDate.cpuData[j].name){
				for(var k=0;k<cpuDate.cpuData[j].value.length;k++){
					series[i].addPoint(parseInt(cpuDate.cpuData[j].value[k]),false,true);
				}
			}
		}
	}
	cpuChartObj.redraw();
}