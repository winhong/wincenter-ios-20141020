var storageChartObj;

function getLocalTime(nS) {     
    return new Date(parseInt(nS) * 1000).toLocaleString().replace(/年|月/g, "-").replace(/日/g, " ");      
}

function drawLineVbd(data){
	 //线型图的数量
	var lineNum = 0;
	//X轴的步长
	var xInterval = data.step; 
	
	var vbdstr ="[";
	for(var i=0;i<data.vbdData.length;i++){
		lineNum = data.vbdData[i].value.length;
		vbdstr +="{pointStart:"+ data.start +",pointInterval:"+ data.step
			 +",name:'"+buildStoName(data.vbdData[i].name)+"',marker:{symbol:'circle'},data:["+data.vbdData[i].value+"]}";
		if(i<data.vbdData.length-1) vbdstr+=",";
	}
	vbdstr +="]";
	if(lineNum>8){
		var result = counXInterval(lineNum,xInterval);
		lineNum = result.split(",")[0];
		xInterval = result.split(",")[1];
	}

	storageChartObj = new Highcharts.Chart({
	    chart: {
	        renderTo: 'storageChart',
	        defaultSeriesType: 'spline',
	        height: 280,
	        plotBorderColor: '#e3e6e8',
	        plotBorderWidth: 1,
	        plotBorderRadius: 0,
	        backgroundColor: '',
	        spacingLeft: 0,
	        plotBackgroundColor: '#FFFFFF',
	        marginTop: 5,
	        marginBottom: 35,
	        events:{
	        	load:function(){
	        		var series = this.series;
	        		var endTime = data.end;
	        		var loadData = function(){
	        			//var params = "startTime="+pc.util.timeToFormatStr(endTime + 5000,"yyyy-MM-dd HH:mm:ss")+"&endTime="+pc.util.timeToFormatStr(endTime+ 20000,"yyyy-MM-dd HH:mm:ss");
	        			var params = "startTime=" + (endTime + 20000)+"&cf=AVERAGE"; 
	        			if(type=="HOST"){
	        				$.PERFORMANCE.getPerformanceByHostId(dcId,hostId,params,function(stoDate){
	        					if(stoDate.end!="undefined" && stoDate.end!=undefined){
		        					endTime = stoDate.end;
		        					buildStorageDate(stoDate,series);
	        					}
		        			});
	        			}else{
	        				$.PERFORMANCE.getPerformanceApi(dcId,vmId,params,function(stoDate){
	        					if(stoDate.end!="undefined" && stoDate.end!=undefined){
		        					endTime = stoDate.end;
		        					buildStorageDate(stoDate,series);
	        					}
		        			});
	        			}
	        		}
	        		if(data.step == 5000){
	        			//storagePerformance = setInterval(loadData,20000);
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
	    	text: "磁盘使用速率"+"(KB/s)",//磁盘使用速率
		    align:"center"
	    },
	
	    legend: {
	    	layout: 'vertical',
            align: 'right',
            verticalAlign: 'top',
            borderWidth: 0,
            width:120,
            maxHeight:180,
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
	        min:0
	    },
	    tooltip: {
            formatter: function() {
                    return '<b>'+ timeToFormatStr(this.x,"yyyy-MM-dd HH:mm:ss") +'</b><br/>'+
                    this.series.name+"使用速率："+ this.y.toFixed(2) +'KB/s';//使用速率: 
            }
        },
	
	    xAxis: {
	        type: 'datetime',
	        lineWidth: 0,
	  //      maxZoom: 5 * 24 * 3600 * 1000, // 5 days
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
	    },credits:{
        	enabled: false
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
	        '#e268de', // purple
	        '#E35733', // orange
	        '#4c97d7', // blue
	        '#52d74c' // green
	    ],
	
	    series: eval(vbdstr)
	});
}

function buildStoName(stoName){
	var lineName = "硬盘"+stoName.split("_")[1];//硬盘
	if(stoName.split("_")[2]=="write"){
		lineName+="写入";//写入
	}else{
		lineName+="读取";//读取
	}
	return lineName;
}

function buildStorageDate(stoDate,series){
	for(var i=0;i<series.length;i++){
		for(var j=0;j<stoDate.vbdData.length;j++){
			if(series[i].name==buildStoName(stoDate.vbdData[j].name)){
				for(var k=0;k<stoDate.vbdData[j].value.length;k++){
					series[i].addPoint(parseInt(stoDate.vbdData[j].value[k]),false,true);
				}
			}
		}
	}
	storageChartObj.redraw();
}
