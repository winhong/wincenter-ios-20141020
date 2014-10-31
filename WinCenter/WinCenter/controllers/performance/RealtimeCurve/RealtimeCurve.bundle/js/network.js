var networkChartObj;

function drawLineNetWork(data,type){

    try{
        chartMap.remove('networkChart');
        networkChartObj.destroy();
    }catch(err){}
    
    if($("#networkChart").length=0){
        return;
    }

	//线型图的数量
	var lineNum = 0;
	//X轴的步长
	var xInterval = data.step;
	
	var networkStr ="[";
	
	for(var i=0;i<data.netWorkData.length;i++){
		lineNum = data.netWorkData[i].value.length;
		networkStr +="{pointStart:"+ data.start +",pointInterval:"+ data.step
			 +",name:'"+buildName(data.netWorkData[i].name,type)+"',marker:{symbol:'circle'},data:["+data.netWorkData[i].value+"]}";
		if(i<data.netWorkData.length-1) networkStr+=",";
	}

	networkStr +="]";

	if(Math.ceil(lineNum)>5){
		var result = counXInterval(lineNum,xInterval);
		lineNum = result.split(",")[0];
		xInterval = result.split(",")[1];
	}
	networkChartObj = new Highcharts.Chart({
	    chart: {
	        renderTo: 'networkChart',
	        defaultSeriesType: 'spline',
	        height: 180,
	        plotBorderColor: '#e3e6e8',
	        plotBorderWidth: 1,
	        plotBorderRadius: 0,
	        backgroundColor: '',
	        spacingLeft: 0,
	        plotBackgroundColor: '#FFFFFF',
	        marginTop: 35,
	        marginBottom: 35,
	        events:{
	        	load:function(){
	        		var series = this.series;
	        		var endTime = data.end;
	        		var loadData = function(){
	        			//var params = "startTime="+pc.util.timeToFormatStr(endTime + 5000,"yyyy-MM-dd HH:mm:ss")+"&endTime="+pc.util.timeToFormatStr(endTime+ 20000,"yyyy-MM-dd HH:mm:ss");
	        			var params = "startTime=" + (endTime + 20000)+"&cf=AVERAGE"; 
	        			if(type=="host"){
	        				$.PERFORMANCE.getPerformanceByHostId(dcId,hostId,params,function(netDate){
	        					if(netDate.end!="undefined" && netDate.end!=undefined){
		        					endTime = netDate.end;
		        					buildNetDate(netDate,series,"host");
	        					}
		        			});
	        			}else{
	        				$.PERFORMANCE.getPerformanceApi(dcId,vmId,params,function(netDate){
	        					if(netDate.end!="undefined" && netDate.end!=undefined){
	        						endTime = netDate.end;
	        						buildNetDate(netDate,series,"vm");
	        					}
		        			});
	        			}
	        		}
	        		if(data.step == 5000){
	        			//netPerformance = setInterval(loadData,20000);
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
	    	 text: "网络使用速率"+"(Kbps)",//网络使用速率
		     align:"center"
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
	        min:0
	    },
	    credits:{
        	enabled: false
        },
        tooltip: {
            // formatter: function() {
            //         return '<b>'+pc.util.timeToStr(this.x) +'</b><br/>'+
            //         this.series.name+$("#performance_js_network_useSpeed").html()+ this.y.toFixed(2) +'Kbps';//使用速率： 
            // }
        },

	    xAxis: {
	        type: 'datetime',
	        lineWidth: 0,
	    //    maxZoom: 5 * 24 * 3600 * 1000, // 5 days
	        tickInterval: xInterval, // 1 day
	        labels: {
	            formatter: function() {
	               // return pc.util.timeToFormatStr(this.value,"MM-dd HH:mm");
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
	        '#4c97d7', // blue
	        '#52d74c', // green
	        '#e268de', // purple
	        '#E35733' // orange
	    ],

	    series: eval(networkStr)
	});
	try{
        chartMap.put('networkChart',networkChartObj);
    }catch(err){}
	
}

function buildName(netName,type){
	var lineName = "";
	if(type=="vm"){
		lineName = "NIC "+netName.split("_")[1];
		if(netName.split("_")[2]=="tx"){
			lineName+="发送";//发送
		}else{
			lineName+="接收";//接收
		}
	}else{
		if(netName.indexOf("pif_eth")!=-1){
			lineName ="NIC "+netName.split("_")[1];
		}else{
			lineName ="绑定"+netName.split("_")[1];//绑定
		}
		if(netName.split("_")[2]=="tx"){
			lineName+="发送";//发送
		}else{
			lineName+="接收";//接收
		}
	}
	return lineName;
}

function buildNetDate(netDate,series,type){
    if(!series){
        return;
    }
	for(var i=0;i<series.length;i++){
		for(var j=0;j<netDate.netWorkData.length;j++){
			if(series[i].name==buildName(netDate.netWorkData[j].name,type)){
				for(var k=0;k<netDate.netWorkData[j].value.length;k++){
					series[i].addPoint(parseFloat(netDate.netWorkData[j].value[k]),false,true);
				}
			}
		}
	}
	networkChartObj.redraw();
}

