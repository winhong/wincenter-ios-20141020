/**
 *Array.prototype.remove = function(s) {
 *	for (var i = 0; i < this.length; i++) {
 *		if (s == this[i])
 *			this.splice(i, 1);
 *	}
 *}
*/
/**
 * Simple Map
 * 
 * 
 * var m = new Map();
 * m.put('key','value');
 * ...
 * var s = "";
 * m.each(function(key,value,index){
 * 		s += index+":"+ key+"="+value+"\n";
 * });
 * alert(s);
 * 
 * @author dewitt
 * @date 2008-05-24
 */
function Map() {
    /** 存放键的数组(遍历用到) */
    this.keys = new Array();
    /** 存放数据 */
    this.data = new Object();

    /**
	 * 放入一个键值对
	 * @param {String} key
	 * @param {Object} value
	 */
    this.put = function(key, value) {
        if (this.data[key] == null) {
            this.keys.push(key);
        }
        this.data[key] = value;
    };

    /**
	 * 获取某键对应的值
	 * @param {String} key
	 * @return {Object} value
	 */
    this.get = function(key) {
        return this.data[key];
    };

    /**
	 * 删除一个键值对
	 * @param {String} key
	 */
    //this.remove = function(key) {
    //	this.keys.remove(key);
    //	this.data[key] = null;
    //};
    
    this.remove = function(key) {
//    	this.keys.removes(key);
    	this.data[key] = null;
    	for(var i = 0 ; i < this.keys.length ; i++){
    		if(key == this.keys[i])
    			this.keys.splice(i, 1);
    	}
    };
    
    /**
	 * 遍历Map,执行处理函数
	 * 
	 * @param {Function} 回调函数 function(key,value,index){..}
	 */
    this.each = function(fn) {
        if (typeof fn != 'function') {
            return;
        }
        var len = this.keys.length;
        for (var i = 0; i < len; i++) {
            var k = this.keys[i];
            fn(k, this.data[k], i);
        }
    };

    /**
	 * 获取键值数组(类似Java的entrySet())
	 * @return 键值对象{key,value}的数组
	 */
    this.entrys = function() {
        var len = this.keys.length;
        var entrys = new Array(len);
        for (var i = 0; i < len; i++) {
            entrys[i] = {
                key: this.keys[i],
                value: this.data[i]
            };
        }
        return entrys;
    };

    /**
	 * 判断Map是否为空
	 */
    this.isEmpty = function() {
        return this.keys.length == 0;
    };

    /**
	 * 获取键值对数量
	 */
    this.size = function() {
        return this.keys.length;
    };

    /**
	 * 重写toString 
	 */
    this.toString = function() {
        var s = "{";
        for (var i = 0; i < this.keys.length; i++, s += ',') {
            var k = this.keys[i];
            s += k + "=" + this.data[k];
        }
        s += "}";
        return s;
    };
}

!function ($) {
	$.PERFORMANCE = {
		debug : false,
		formVmJson : function(json){
			var performan = json.performan;
			var datas = {};
			//声明cpu的变量
			var cpuIndex = [];
			var cpuData = [];
			//声明内存的变量
			var memoryIndex = [];
			var memoryData = [];
			//声明磁盘的变量
			var vbdIndex = [];
			var vbdData = [];
			//声明网络的变量
			var netWorkIndex = [];
			var netWorkData = [];
			//获取每个指标的index值
			if(performan.length>1){
				//设置datas的整体属性
				var startTime = performan[performan.length-1].collectTime.substring(0,19);
				datas.start = new Date(Date.parse(startTime.replace(/-/g, "/"))).getTime();
				datas.end = new Date(Date.parse(performan[0].collectTime.substring(0,19).replace(/-/g, "/"))).getTime();
				datas.step = json.interval;
				var property = performan[0].collectProperty.split(",");
				for(var i=0;i<property.length;i++){
					if(property[i].indexOf("cpu")!=-1 && property[i].split("-").length<2
							&& property[i]!="cpu_avg"){
						cpuIndex[cpuIndex.length] = {"name":property[i],"index":i};
					}else if(property[i].indexOf("memory")!=-1 && property[i]!="memory_target"){
						memoryIndex[memoryIndex.length] = {"name":property[i],"index":i};
					}else if(property[i].indexOf("vbd")!=-1){
						vbdIndex[vbdIndex.length] = {"name":property[i],"index":i};
					}else if(property[i].indexOf("vif")!=-1){
						netWorkIndex[netWorkIndex.length] = {"name":property[i],"index":i};
					}
				}
			}
			
			var cpuMap = new Map();
			var memoryMap = new Map();
			var vbdMap = new Map();
			var netWorkMap = new Map();
			for(var i=performan.length-1;i>=0;i--){
				var value = performan[i].collectValue.split(",");
				this.setCpuMap(cpuMap,value,cpuIndex);
				this.setMemoryMap(memoryMap,value,memoryIndex);
				this.setVbdMap(vbdMap,value,vbdIndex);
				this.setNetWorkMap(netWorkMap,value,netWorkIndex);
			}
			
			//循环获取cpu使用率
			var totalCpu = [];
			var cpuInfo = [];
			var cpuTotal = [];
			cpuMap.each(function(key,value,i){
				cpuData[cpuData.length] = {"name":key,"value":value};
				cpuInfo[cpuInfo.length] = value;
			});
			
			if(cpuInfo.length>0){
				for(var i = 0;i<cpuInfo[0].length;i++){
					var cpuVal= 0;
					for(var j=0;j<cpuInfo.length;j++){
						cpuVal+=cpuInfo[j][i]=="NaN" ?"0":parseInt(cpuInfo[j][i]);
					}
					cpuTotal[cpuTotal.length] = cpuVal/cpuInfo.length;
				}
			}
			cpuData[cpuData.length] = {"name":"CPU","value":cpuTotal};
			
			//计算内存使用率
			var totalMemoryValues = memoryMap.get("memory");
			var freeMemoryValues = memoryMap.get("memory_internal_free");
			var useMemory = [];
			if(totalMemoryValues && freeMemoryValues){
				for(var i=0;i<totalMemoryValues.length;i++){
					var totalMemory = totalMemoryValues[i]/1024;
					useMemory[i] = totalMemory=="0"?"0":((totalMemory-freeMemoryValues[i])/totalMemory*100).toFixed(2);
				}
			}
			
			memoryData[0] = {
				//内存使用率
				"name"  : "内存",
				"value" : useMemory
			};
			
			//循环获取磁盘吞吐量
			vbdMap.each(function(key,value,i){
				vbdData[vbdData.length] = {"name":key,"value":value};
			});
			
			//循环获取磁盘吞吐量
			netWorkMap.each(function(key,value,i){
				netWorkData[netWorkData.length] = {"name":key,"value":value};
			});
			
			datas.cpuData = cpuData;
			datas.memoryData = memoryData;
			datas.vbdData = vbdData;
			datas.netWorkData = netWorkData;
			
			return datas;
			
		},
		setCpuMap : function(cpuMap,value,cpuIndex){
			for(var j=0;j<value.length;j++){
				if(cpuIndex[j]==null)continue;
				if(cpuMap.get(cpuIndex[j].name)==null){
					var valueArry =[];
					valueArry[0] = value[cpuIndex[j].index]=="NaN" ?"0":(value[cpuIndex[j].index]*100).toFixed(2);
					cpuMap.put(cpuIndex[j].name, valueArry);
				}else{
					var valueArry = cpuMap.get(cpuIndex[j].name);
					valueArry[valueArry.length] = value[cpuIndex[j].index]=="NaN" ?"0": (value[cpuIndex[j].index]*100).toFixed(2);
				}
			}
		},
		setMemoryMap : function(memoryMap,value,memoryIndex){
			for(var j=0;j<value.length;j++){
				if(memoryIndex[j]==null)continue;
				if(memoryMap.get(memoryIndex[j].name)==null){
					var valueArry =[];
					valueArry[0] = value[memoryIndex[j].index]=="NaN" ?"0":value[memoryIndex[j].index];
					memoryMap.put(memoryIndex[j].name, valueArry);
				}else{
					var valueArry = memoryMap.get(memoryIndex[j].name);
					valueArry[valueArry.length] = value[memoryIndex[j].index]=="NaN" ?"0":value[memoryIndex[j].index];
				}
			}
		},
		setVbdMap : function(vbdMap,value,vbdIndex){
			for(var j=0;j<value.length;j++){
				if(vbdIndex[j]==null)continue;
				if(vbdMap.get(vbdIndex[j].name)==null){
					var valueArry =[];
					valueArry[0] =value[vbdIndex[j].index]=="NaN" ?"0":(value[vbdIndex[j].index]/1024).toFixed(2);
					vbdMap.put(vbdIndex[j].name, valueArry);
				}else{
					var valueArry = vbdMap.get(vbdIndex[j].name);
					valueArry[valueArry.length] = value[vbdIndex[j].index]=="NaN" ?"0":(value[vbdIndex[j].index]/1024).toFixed(2);
				}
			}
		},
		setNetWorkMap : function(netWorkMap,value,netWorkIndex){
			for(var j=0;j<value.length;j++){
				if(netWorkIndex[j]==null)continue;
				if(netWorkMap.get(netWorkIndex[j].name)==null){
					var valueArry =[];
					valueArry[0] = (value[netWorkIndex[j].index]=="NaN" || 
					value[netWorkIndex[j].index]=="Infinity") ?"0":(value[netWorkIndex[j].index]/1024).toFixed(2);
					netWorkMap.put(netWorkIndex[j].name, valueArry);
				}else{
					var valueArry = netWorkMap.get(netWorkIndex[j].name);
					valueArry[valueArry.length] =  (value[netWorkIndex[j].index]=="NaN" || 
							value[netWorkIndex[j].index]=="Infinity") ?"0":(value[netWorkIndex[j].index]/1024).toFixed(2);
				}
			}
		},
		
		/**
		 * 获取单个虚拟机的性能监控
		 * 查询数据库
		 * */
		getPerformanceByVmId : function(dataCenterId,vmId,content,callback){
			// if(pc.debug && this.debug){
			// 	hideLoading();
			// 	$.get("/rmJs/mock/vm_performance.json",
			// 			function(data){
			// 				callback($.PERFORMANCE.formVmJson(data));
			// 			}
			// 	,"json");
			// 	return;
			// }
			// pc.rest.get(dataCenterId,"pc.winserver.vm.getVmPerformances",vmId,content,
			// 		function(data){
			// 			hideLoading();
			// 			//获取单个虚拟机的性能监控失败!
			// 			showError("testError", data);
			// 		},
			// 		function(data){
			// 			callback($.PERFORMANCE.formVmJson(data));
			// 		});
		},
		/**
		 * 获取单个虚拟机的性能监控
		 * 查询接口
		 * */
		getPerformanceApi : function(dataCenterId,vmId,content, vcpu,showErrorMsg, callback){
			// if(pc.debug && this.debug){
			// 	hideLoading();
			// 	$.get("/rmJs/mock/vm_performance.json",
			// 			function(data){
			// 				callback($.PERFORMANCE.formApiVmJson(data, vcpu));
			// 			}
			// 	,"json");
			// 	return;
			// }
			// pc.rest.get(dataCenterId,"pc.winserver.vm.getVmPerformance",vmId,content,
			// 		function(data){
   //      			    if(showErrorMsg && showErrorMsg==true){
   //      			    	//获取单个虚拟机的性能监控失败!
   //                          showError("testError", data);
   //                      }   
			// 		},
			// 		function(data){
			// 		    hideLoading();
			// 		    if(data && data.meta && data.meta.legend){
			// 		    	 if(data && data.meta && data.meta.legend){
			// 				        callback($.PERFORMANCE.formApiVmJson(data, vcpu));
			// 				    }else {
			// 				    	//获取单个虚拟机的性能监控失败!
			// 				        showError("testError", data);
			// 				    }
			// 		    }else {
			// 		        if(showErrorMsg && showErrorMsg==true){
			// 		        	//获取单个虚拟机的性能监控失败!
	  //                           showError("testError", data);
	  //                       }
			// 		    }
			// 		},true,"",false);
		},
		/**
		 * @param json 性能数据
		 * @param vcpu 虚拟机vcpu个数
		 */
		formApiVmJson : function(json, vcpu){
			var legends = json.meta.legend;
			var datas = {};
			//设置datas的整体属性
			datas.start = json.meta.start * 1000;
			datas.step = json.meta.step * 1000;
			datas.end = json.meta.end * 1000;
			//声明cpu的变量
			var cpuIndex = [];
			var cpuData = [];
			//声明内存的变量
			var memoryIndex = [];
			var memoryData = [];
			//声明磁盘的变量
			var vbdIndex = [];
			var vbdData = [];
			//声明网络的变量
			var netWorkIndex = [];
			var netWorkData = [];
			//获取每个指标的index值
			for(var i=0;i<legends.length;i++){
				if(legends[i].split(":")[3].indexOf("cpu")!=-1){
				    if(vcpu != undefined && vcpu > 0){
				        var cpuX = legends[i].split(":")[3].replace("cpu", "");
				        if(cpuX == undefined || "" == cpuX || "undefined" == cpuX || cpuX < vcpu){
				            cpuIndex[cpuIndex.length] = {"name":legends[i].split(":")[3],"index":i};
				        }
				    }
				    else {
				        cpuIndex[cpuIndex.length] = {"name":legends[i].split(":")[3],"index":i};
				    }
				}else if(legends[i].split(":")[3].indexOf("memory")!=-1 && legends[i].split(":")[3]!="memory_target"){
					memoryIndex[memoryIndex.length] = {"name":legends[i].split(":")[3],"index":i};
				}else if(legends[i].split(":")[3].indexOf("vbd")!=-1){
					vbdIndex[vbdIndex.length] = {"name":legends[i].split(":")[3],"index":i};
				}else if(legends[i].split(":")[3].indexOf("vif")!=-1){
					netWorkIndex[netWorkIndex.length] = {"name":legends[i].split(":")[3],"index":i};
				}
			}
			
			var cpuMap = new Map();
			var memoryMap = new Map();
			var vbdMap = new Map();
			var netWorkMap = new Map();
			
			if(json.data.length != undefined){
				for(var i=json.data.length-1;i>=0;i--){
					var value = json.data[i].v;
					this.setCpuMap(cpuMap,value,cpuIndex);
					this.setMemoryMap(memoryMap,value,memoryIndex);
					this.setVbdMap(vbdMap,value,vbdIndex);
					this.setNetWorkMap(netWorkMap,value,netWorkIndex);
				}
			}
			else if (json.data.row != undefined){//当json.data.length ==1时，json.data.length会变成undefined，需要通过json.data.row的方式访问json.data[0]
				var value = json.data.row.v;
				this.setCpuMap(cpuMap,value,cpuIndex);
				this.setMemoryMap(memoryMap,value,memoryIndex);
				this.setVbdMap(vbdMap,value,vbdIndex);
				this.setNetWorkMap(netWorkMap,value,netWorkIndex);
			}
			
			//循环获取cpu使用率
			var totalCpu = [];
			var cpuInfo = [];
			var cpuTotal = [];
			cpuMap.each(function(key,value,i){
				cpuData[cpuData.length] = {"name":key,"value":value};
				cpuInfo[cpuInfo.length] = value;
			});
			
			if(cpuInfo.length>0){
				for(var i = 0;i<cpuInfo[0].length;i++){
					var cpuVal= 0;
					for(var j=0;j<cpuInfo.length;j++){
						cpuVal+=cpuInfo[j][i]=="NaN" ?"0":parseInt(cpuInfo[j][i]);
					}
					cpuTotal[cpuTotal.length] = cpuVal/cpuInfo.length;
				}
			}
			cpuData[cpuData.length] = {"name":"CPU","value":cpuTotal};
			
			//计算内存使用率
			var totalMemoryValues = memoryMap.get("memory");
			var freeMemoryValues = memoryMap.get("memory_internal_free");
			var useMemory = [];
			if(totalMemoryValues && freeMemoryValues){
				for(var i=0;i<totalMemoryValues.length;i++){
					var totalMemory = totalMemoryValues[i]/1024;
					useMemory[i] = totalMemory=="0"?"0":((totalMemory-freeMemoryValues[i])/totalMemory*100).toFixed(2);
				}
			}
			
			memoryData[0] = {
				"name"  : "内存",
				"value" : useMemory
			};
			
			//循环获取磁盘吞吐量
			vbdMap.each(function(key,value,i){
				vbdData[vbdData.length] = {"name":key,"value":value};
			});
			
			//循环获取磁盘吞吐量
			netWorkMap.each(function(key,value,i){
				netWorkData[netWorkData.length] = {"name":key,"value":value};
			});
			
			datas.cpuData = cpuData;
			datas.memoryData = memoryData;
			datas.vbdData = vbdData;
			datas.netWorkData = netWorkData;
			
			return datas;
			
		},
		
		
		/**
		 * 获取物理主机的性能监控
		 * */
		getPerformanceByHostId : function(dataCenterId,hostId,content,showErrorMsg, callback){
			// if(pc.debug && this.debug){
			// 	hideLoading();
			// 	$.get("/rmJs/mock/host.performance.json",
			// 			function(data){
			// 				callback($.PERFORMANCE.formHostJson(data));
			// 			}
			// 	,"json");
			// 	return;
			// }
			// pc.rest.get(dataCenterId,"pc.winserver.host.getHostPerformance",hostId,content,
			// 		function(data){
			//             if(showErrorMsg && showErrorMsg==true){
			//             	//获取物理主机的性能监控失败!
			//                 showError("testError", data);
			//             }
			// 		},
			// 		function(data){
			// 		    if(data && data.meta && data.meta.legend){
			// 		        callback($.PERFORMANCE.formHostJson(data));
   //                      }else {
   //                          if(showErrorMsg && showErrorMsg==true){
   //                          	//获取物理主机的性能监控失败!
   //                              showError("testError", data);
   //                          }
   //                      }
			// 		},true,"",false);
		},
		formHostJson : function(json){
			eval("json = " + json);
			var legends = json.meta.legend;
			var datas = {};
			//设置datas的整体属性
			datas.start = json.meta.start * 1000;
			datas.step = json.meta.step * 1000;
			datas.end = json.meta.end * 1000;
			//声明cpu的变量
			var cpuIndex = [];
			var cpuData = [];
			//声明内存的变量
			var memoryIndex = [];
			var memoryData = [];
			//声明网络的变量
			var netWorkIndex = [];
			var netWorkData = [];
			//获取每个指标的index值
			for(var i=0;i<legends.length;i++){
				if(legends[i].split(":")[3].indexOf("cpu")!=-1 && legends[i].split(":")[3].split("-").length<2){
					if(legends[i].split(":")[3]=="cpu_avg"){
						cpuIndex[cpuIndex.length] = {"name":"CPU","index":i};
					}else{
						cpuIndex[cpuIndex.length] = {"name":legends[i].split(":")[3],"index":i};
					}
				}else if(legends[i].split(":")[3]=="memory_total_kib" || legends[i].split(":")[3]=="memory_free_kib"){
					memoryIndex[memoryIndex.length] = {"name":legends[i].split(":")[3],"index":i};
				}else if(legends[i].split(":")[3].indexOf("pif_eth")!=-1 || legends[i].split(":")[3].indexOf("pif_bond")!=-1){
					netWorkIndex[netWorkIndex.length] = {"name":legends[i].split(":")[3],"index":i};
				}
			}
			var cpuMap = new Map();
			var memoryMap = new Map();
			var netWorkMap = new Map();
			for(var i=json.data.length -1;i>=0;i--){
			    var value = json.data[i].v;
                this.setCpuMap(cpuMap,value,cpuIndex);
                this.setMemoryMap(memoryMap,value,memoryIndex);
                this.setNetWorkMap(netWorkMap,value,netWorkIndex);
			}
			if(json.meta.rows == "1"){
				var value = json.data.row.v;
                this.setCpuMap(cpuMap,value,cpuIndex);
                this.setMemoryMap(memoryMap,value,memoryIndex);
                this.setNetWorkMap(netWorkMap,value,netWorkIndex);
			}
			
			//循环获取cpu使用率
			cpuMap.each(function(key,value,i){
				cpuData[cpuData.length] = {"name":key,"value":value};
			});
			
			//计算内存使用率
			var totalMemoryValues = memoryMap.get("memory_total_kib");
			var freeMemoryValues = memoryMap.get("memory_free_kib");
			if(totalMemoryValues == undefined){
				totalMemoryValues = [];
			}
			if(freeMemoryValues == undefined){
				freeMemoryValues = [];
			}
			var useMemory = [];
			for(var i=0;i<totalMemoryValues.length;i++){
			    if(totalMemoryValues[i] == "0"){
			        useMemory[i] = "0";
			    }
			    else {
			        useMemory[i] = ((totalMemoryValues[i]-freeMemoryValues[i])/totalMemoryValues[i]*100).toFixed(2);
			    }
			}
			
			memoryData[0] = {
				"name"  : "内存",
				"value" : useMemory
			};
			
			
			//循环获取磁盘吞吐量
			netWorkMap.each(function(key,value,i){
				netWorkData[netWorkData.length] = {"name":key,"value":value};
			});
			
			datas.cpuData = cpuData;
			datas.memoryData = memoryData;
			datas.netWorkData = netWorkData;
			
			return datas;
			
		}
	};
}(window.jQuery);
