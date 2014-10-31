var pc = {};
pc.debug=true;
// pc.constant = {
//     VCPUTOCPU: 0.3,
//     //vcpu与cpu比率
//     VCPUUNIT: internationalizationObj.common_pc_constant_check1,//个
//     MEMUNIT: "MB",
//     DISKUNIT: "GB",
//     CPUUNIT: internationalizationObj.common_pc_constant_check2//核
// };

// pc.constant.vmStateView = {
//     "OK": internationalizationObj.common_pc_constant_vmStateView_check1,//运行中
//     "STOPPED": internationalizationObj.common_pc_constant_vmStateView_check2,//已关机
//     "STOPPING": internationalizationObj.common_pc_constant_vmStateView_check3,//正在关机
//     "STARTING": internationalizationObj.common_pc_constant_vmStateView_check4,//正在开机
//     "DELETING": internationalizationObj.common_pc_constant_vmStateView_check5,//正在删除
//     "RESTARTING": internationalizationObj.common_pc_constant_vmStateView_check6,//正在重启
//     "EXECUTING": internationalizationObj.common_pc_constant_vmStateView_check7,//正在部署
//     "UNKNOWN": internationalizationObj.common_pc_constant_vmStateView_check8,//未知
//     "SUSPENDED":internationalizationObj.common_pc_constant_vmStateView_check9//挂起
// };

// pc.constant.linkStateNames = {
//     "DETACH": internationalizationObj.common_pc_constant_linkStateNames_check1,//未连接
//     "UNKNOWN": internationalizationObj.common_pc_constant_linkStateNames_check2,//未知
//     "UP": internationalizationObj.common_pc_constant_linkStateNames_check3,//运行
//     "DOWN": internationalizationObj.common_pc_constant_linkStateNames_check4//宕机
// };

// pc.constant.sendMode = {
//     "standard": internationalizationObj.common_pc_constant_sendMode_check1,//标准
//     "round_robin": internationalizationObj.common_pc_constant_sendMode_check2//轮询
// };

// pc.constant.sendStrategy = {
//     "default": internationalizationObj.common_pc_constant_sendStrategy_check1,//以目标IP地址确定发送适配器
//     "src_port": internationalizationObj.common_pc_constant_sendStrategy_check2,//以源UDP或TCP端口值确定发送适配器
//     "dst_port": internationalizationObj.common_pc_constant_sendStrategy_check3,//以目标UDP或TCP端口值确定发送适配器
//     "src_dst_port": internationalizationObj.common_pc_constant_sendStrategy_check4//以源和目标UDP和TCP端口值确定发送适配器
// };

// pc.constant.volumeState = {
//     "EXECUTING": internationalizationObj.common_pc_constant_volumeState_check1,//创建中
//     "OK": internationalizationObj.common_pc_constant_volumeState_check2,//正常
//     "FAILED": internationalizationObj.common_pc_constant_volumeState_check3,//创建失败
//     "DELETING": internationalizationObj.common_pc_constant_volumeState_check4,//删除中
//     "RESIZEING": internationalizationObj.common_pc_constant_volumeState_check5,//调整中
//     "RESIZEED": internationalizationObj.common_pc_constant_volumeState_check6,//调整成功
//     "RESIZEFAILDE": internationalizationObj.common_pc_constant_volumeState_check7//调整失败
// };

pc.constant.platform = {
	"winserver":"1",
	"vmware":"2",
	"powervm":"3"
};

pc.constant.platformType = {
	"vSphere":"vmware",
	"winserver":"winserver",
	"HMC":"powervm"
};

pc.constant.platformTypeShow = {
	"vSphere":"VMware",
	"winserver":"WinServer",
	"HMC":"PowerVM"
};

pc.msg = {
    _getErrorHtml: function() {
        return '<div id="Msg__errorInfoDialog"  class="error-info-dialog ">' + '<div id="Msg__errorTitleArea" class="error-title-area">' + '<span id="Msg__errorName"  class="error-name"></span> <span  onclick="$.unblockUI();" class="_close">关闭</span>' + '</div>' + '<div id="Msg__errorContentArea" class="error-content-area">' + '<div>' + '<span class="error-title">错误编码：</span><p id="Msg__errorCode"  class="error-content"></p>' + '<span class="error-title">错误信息：</span><p  id="Msg__errorMessage"  class="error-content"></p >' + '<div class="error-title error-detail-link"   onclick="pc.msg.swicthErrorStackTraceView(this);">查看详情</div>' + '<p  id="Msg__errorStackTrace"  class="error-content" style="display:none;"></p>' + '</div>' + '</div>';
    },
    /**显示错误信息，name=标题，msg={exceptionMessage:"",exceptionCode:"",stackTrace:""}**/
    showError: function(name, msg) {
    	
    	$("#Msg__errorInfoDialog").remove();
        $("body").append(this._getErrorHtml());
        $('#Msg__errorName').html(name);
        $('#Msg__errorMessage').html(msg.exceptionMessage);
        $('#Msg__errorCode').html(msg.exceptionCode);
        $('#Msg__errorStackTrace').html(msg.stackTrace);
        if ($(window).width() * 0.8 > 700) {
            $.blockUI({
                message: $('#Msg__errorInfoDialog'),
                css: {
                    width: '700',
                    height: '500',
                    top: '20%',
                    left: '30%',
                    textAlign: 'left',
                    cursor: 'default',
                    border: '1px solid #987654'
                },
                onOverlayClick: null
            });
            $("#Msg__errorContentArea").height(475);
        } else {
            $.blockUI({
                message: $('#Msg__errorInfoDialog'),
                css: {
                    width: '80%',
                    top: '10%',
                    left: '10%',
                    textAlign: 'left',
                    cursor: 'default',
                    border: '1px solid #987654'
                },
                onOverlayClick: null
            });
            $("#Msg__errorContentArea").height($(window).height() * 0.8 - 25);
        }
        $(".errorContent").width($("#Msg__errorTitleArea").width() - 40);
    },
    swicthErrorStackTraceView: function(src) {
        var st = $("#Msg__errorStackTrace").get(0);
        if (st.style.display == "none") {
            st.style.display = "block";
            src.style.borderBottom = "solid 1px blue";
        } else {
            st.style.display = "none";
            src.style.borderBottom = "";
        }
    }
};

pc.rest = {
    /**
		connectorId 数据库表connector的id
		apiKey 类RestApi的key值
		placeholder 请求的url中的占位符的值
		params 请求的url后面?跟随的值
		content 请求中body的值
		errorFun 发生错误时的函数,参数data:请求返回的数据|textStatus:请求的返回状态|custParam:自定义参数，对应callbackCustParam
		successFun 成功是的函数，参数data:请求返回的数据|textStatus:请求的返回状态|custParam:自定义参数，对应callbackCustParam
		async 是否异步 默认为true
		callbackCustParam:回调函数中要传递的自定义参数，用于提供回调函数上下文以外的对象。
		*/
    get: function(connectorId, apiKey, placeholder, params, errorFun, successFun, async, callbackCustParam) {
    	if(connectorId == null || connectorId == "null"){ return;  }//防止加载其他页面时 js继续运行 connectorId 为null的情况
        $.ajax({
            url: '/restServlet',
            type: 'POST',
            cache: false,
            data: {
                connectorId: connectorId,
                apiKey: apiKey,
                placeholder: placeholder,
                params:params,
                apiType: 'GET'
            },
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded; charset=utf-8',
            async: pc.rest.isAsync(async),
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                /*var errorData = {
            			"exceptionCode:":"WINCENTER001",
            			"exceptionMessage":"ajax请求失败：[GET] connectorId:" + connectorId + ",apiKey:" + apiKey + ",placeholder:" + placeholder + ",params:" + params + " -" + errorThrown,
            			"stackTrace:":textStatus
            	}
               errorFun(errorData);*/
            },
            success: function(data, textStatus) {
                if (data.exceptionMessage || data.exceptionCode) {
                    //				alert("错误编码:"+data.exceptionCode+"\n错误原因："+data.exceptionMessage);
                    errorFun(data, textStatus, callbackCustParam);
                } else {
                    successFun(data, textStatus, callbackCustParam);
                }
            }
        });
    },

    post: function(connectorId, apiKey, placeholder, content, errorFun, successFun, async, showLoadingEffect) {
        if(showLoadingEffect==undefined || showLoadingEffect != false){
            showLoading();
        }
        $.ajax({
            url: '/restServlet',
            type: 'POST',
            data: {
                connectorId: connectorId,
                apiKey: apiKey,
                placeholder: placeholder,
                content: content,
                apiType: 'POST'
            },
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded; charset=utf-8',
            async: pc.rest.isAsync(async),
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                //alert("ajax请求失败：[POST]" + apiKey + " -" + errorThrown);
                //alert("ajax请求失败：[POST] connectorId:" + connectorId + ",apiKey:" + apiKey + ",placeholder:" + placeholder + ",content:" + content + " -" + errorThrown);
                if(showLoadingEffect==undefined || showLoadingEffect != false){
                    hideLoading();
                }
                var errorData = {
                        "exceptionCode:":"WINCENTER001",
                        "exceptionMessage":"ajax请求失败：[POST] connectorId:" + connectorId + ",apiKey:" + apiKey + ",placeholder:" + placeholder + ",params:" + params + " -" + errorThrown,
                        "stackTrace:":textStatus
                }
                errorFun(errorData);
            },
            success: function(data, textStatus) {
                if(showLoadingEffect==undefined || showLoadingEffect != false){
                    hideLoading();
                }
                if (data.exceptionMessage || data.exceptionCode) {
                    //alert("错误编码:"+data.exceptionCode+"\n错误原因："+data.exceptionMessage);
                    errorFun(data, textStatus);
                } else {
                    successFun(data, textStatus);
                }
            }
        });

    },

    put: function(connectorId, apiKey, placeholder, content, errorFun, successFun, async, showLoadingEffect) {
        if(showLoadingEffect==undefined || showLoadingEffect != false){
            showLoading();
        }
        $.ajax({
            url: '/restServlet',
            type: 'POST',
            cache: false,
            data: {
                connectorId: connectorId,
                apiKey: apiKey,
                placeholder: placeholder,
                content: content,
                apiType: 'PUT'
            },
            async: pc.rest.isAsync(async),
            dataType: 'json',
            error: function(XMLHttpRequest, textStatus, errorThrown) {
            	//alert("ajax请求失败：[PUT]" + apiKey + " -" + errorThrown);
            	//alert("ajax请求失败：[PUT] connectorId:" + connectorId + ",apiKey:" + apiKey + ",placeholder:" + placeholder + ",content:" + content + " -" + errorThrown);
                if(showLoadingEffect==undefined || showLoadingEffect != false){
                    hideLoading();
                }
               // errorFun(internationalizationObj.common_pc_rest_error+"[PUT] connectorId:" + connectorId + ",apiKey:" + apiKey + ",placeholder:" + placeholder + ",content:" + content + " -" + errorThrown, textStatus);
            },//ajax请求失败：
            success: function(data, textStatus) {
                if(showLoadingEffect==undefined || showLoadingEffect != false){
                    hideLoading();
                }
                if (data.exceptionMessage || data.exceptionCode) {
                    errorFun(data, textStatus);
                } else {
                    successFun(data, textStatus);
                }
            }
        });
    },

    del: function(connectorId, apiKey, placeholder, content, errorFun, successFun, async, showLoadingEffect) {
        if(showLoadingEffect==undefined || showLoadingEffect != false){
            showLoading();
        }
        $.ajax({
            url: '/restServlet',
            type: 'POST',
            data: {
                connectorId: connectorId,
                apiKey: apiKey,
                placeholder: placeholder,
                content: content,
                apiType: 'DELETE'
            },
            async: pc.rest.isAsync(async),
            dataType: 'json',
            error: function(XMLHttpRequest, textStatus, errorThrown) {
            	//alert("ajax请求失败：[DELETE]" + apiKey + " -" + errorThrown);
            	//alert("ajax请求失败：[DELETE] connectorId:" + connectorId + ",apiKey:" + apiKey + ",placeholder:" + placeholder + ",content:" + content + " -" + errorThrown);
                if(showLoadingEffect==undefined || showLoadingEffect != false){
                    hideLoading();
                }
                //errorFun(internationalizationObj.common_pc_rest_error+"[DELETE] connectorId:" + connectorId + ",apiKey:" + apiKey + ",placeholder:" + placeholder + ",content:" + content + " -" + errorThrown, textStatus);
            },//ajax请求失败：
            success: function(data, textStatus) {
                if(showLoadingEffect==undefined || showLoadingEffect != false){
                    hideLoading();
                }
                if (data.exceptionMessage || data.exceptionCode) {
                    errorFun(data, textStatus);
                } else {
                    successFun(data, textStatus);
                }
            }
        });
    },

    delWithBody: function(connectorId, apiKey, placeholder, params, errorFun, successFun, async) {
        $.ajax({
            url: '/restServlet',
            type: 'POST',
            data: {
                connectorId: connectorId,
                apiKey: apiKey,
                placeholder: placeholder,
                params: params,
                apiType: 'DELETE'
            },
            async: pc.rest.isAsync(async),
            dataType: 'json',
            error: function(XMLHttpRequest, textStatus, errorThrown) {
            	//alert("ajax请求失败：[DELETE]" + apiKey + " -" + errorThrown);
            	//alert("ajax请求失败：[DELETE] connectorId:" + connectorId + ",apiKey:" + apiKey + ",placeholder:" + placeholder + ",params:" + params + " -" + errorThrown);
               // errorFun(internationalizationObj.common_pc_rest_error+"[DELETE] connectorId:" + connectorId + ",apiKey:" + apiKey + ",placeholder:" + placeholder + ",params:" + params + " -" + errorThrown, textStatus);
            },//ajax请求失败：
            success: function(data, textStatus) {
                if (data.exceptionMessage || data.exceptionCode) {
                    errorFun(data, textStatus);
                } else {
                    successFun(data, textStatus);
                }
            }
        });
    },

    //资源纳管单独的请求方法(因为ip不知道)
    getByIp: function(ip, apiKey, placeholder, params, errorFun, successFun, async) {
        $.ajax({
            url: '/restServlet',
            type: 'GET',
            cache: false,
            data: {
                ip: ip,
                apiKey: apiKey,
                placeholder: placeholder,
                params: params
            },
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded; charset=utf-8',
            async: pc.rest.isAsync(async),
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                errorFun(errorThrown, textStatus);
            },
            success: function(data, textStatus) {
                if (data.exceptionMessage) {
                    errorFun(data, textStatus);
                } else {
                    successFun(data, textStatus);
                }
            }
        });
    },

    postByIp: function(ip, apiKey, placeholder, content, errorFun, successFun, async) {
        $.ajax({
            url: '/restServlet',
            type: 'POST',
            data: {
                ip: ip,
                apiKey: apiKey,
                placeholder: placeholder,
                content: content
            },
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded; charset=utf-8',
            async: pc.rest.isAsync(async),
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                errorFun(errorThrown, textStatus);
            },
            success: function(data, textStatus) {
                if (data.exceptionMessage) {
                    errorFun(data, textStatus);
                } else {
                    successFun(data, textStatus);
                }
            }
        });
    },

    putByIp: function(ip, apiKey, placeholder, content, errorFun, successFun, async) {
        $.ajax({
            url: '/restServlet',
            cache: false,
            data: {
                ip: ip,
                apiKey: apiKey,
                placeholder: placeholder,
                content: content,
                apiType: 'PUT'
            },
            async: pc.rest.isAsync(async),
            dataType: 'json',
            error: function(XMLHttpRequest, textStatus, errorThrown) {},
            success: function(data, textStatus) {
                if (data.exceptionMessage || data.exceptionCode) {
                    errorFun(data, textStatus);
                } else {
                    successFun(data, textStatus);
                }
            }
        });
    },
    isAsync: function(async) {
        var asyncText = true;
        if (async != undefined) {
            asyncText = async;
        }
        return asyncText;
    },
    getBatchData: function(urls, onGet) {
        var BatchGetStore = new Array();
        var results = {};
        BatchGetStore.push(results);
        var indexAtStore = BatchGetStore.length - 1;

        var isBatchExecuted = function(results) {
            for (var s in results) {
                if (results[s].data == null) return false;
            }
            return true;
        }

        var eachError = function(data, textStatus, context) {
            var results = BatchGetStore[context.index];
            results[context.connectorId].data = data;
            results[context.connectorId].type = "faild";
            if (isBatchExecuted(results)) return onGet(results);
        };
        var eachSuccess = function(data, textStatus, context) {
            var results = BatchGetStore[context.index];
            results[context.connectorId].data = data;
            results[context.connectorId].type = "success";
            if (isBatchExecuted(results)) return onGet(results);
        };

        for (var i = 0; i < urls.length; i++) {
            var url = urls[i];
            results[url.connectorId + ""] = {
                "cid": url.connectorId,
                "url": url,
                "result": null,
                "resultType": null
            };
            pc.rest.get(url.connectorId, url.apiKey, url.placeholder, url.params, eachError, eachSuccess, true, {
                "index": indexAtStore,
                "connectorId": url.connectorId
            });

        }
    },

    /**
     * 批量执行get
     */
    batchGetData : function(urls,onGet){
        var results = {};
        
        var isBatchExecuted = function(results) {
            for (var s in results) {
                if (results[s].data == null || results[s].data == undefined){
                    return false;
                }
            }
            return true;
        }
        var eachError = function(data, textStatus, context) {
            results[context.index].data = data;
            results[context.index].type = "faild";
            if (isBatchExecuted(results)){
                return onGet(results);
            }
        };
        var eachSuccess = function(data, textStatus, context) {
            results[context.index].data = data;
            results[context.index].type = "success";
            if (isBatchExecuted(results)){
                return onGet(results);
            }
        };
        for (var i = 0; i < urls.length; i++) {
            var url = urls[i];
            results[i] = {
                "cid": url.connectorId,
                "url": url,
                "result": null,
                "resultType": null
            };
            pc.rest.get(url.connectorId, url.apiKey, url.placeholder, url.params, eachError, eachSuccess, true, {
                "index": i,
                "connectorId": url.connectorId
            });
        }
    }
}

function adapterSpeedNames(str, item) {
    if (item.type != "EtherChannel") {
        var strNum = "";
        var strTxt = "";
        var adapterSpeed = item.adapterSpeed;
        if (adapterSpeed == null || adapterSpeed == "") {
            return "";
        }
        var adapterSpeedObj = adapterSpeed.split("_");
        strNum = (adapterSpeedObj[0]);
        if (item.adapterSpeed == "Auto_Negotiation") {
           // str = internationalizationObj.common_function_adapterSpeedNames_check1;// 自动
        } else if (adapterSpeedObj[1] == "Full") {
            //strTxt = internationalizationObj.common_function_adapterSpeedNames_check2;// 全双工
            str = strNum + strTxt;
        } else if (adapterSpeedObj[1] == "Half") {
           // strTxt = internationalizationObj.common_function_adapterSpeedNames_check3;// 半双工
            str = strNum + strTxt;
        }
    }
    return str;
}

pc.util = {
		replaceQto:function(str){
			return  str == null ? "" :  pc.util.trim(str.replace(/\'/g,""));
		},
	storageUnitFormate:function(num){
		var dateNum = 0;
		var dataUnit = " GB";
		if(pc.util.isNotNull(num)){
			dateNum = num;
			if(dateNum > 1024){
				dateNum = dateNum/1024;
				dataUnit = " TB";
			}
			dateNum = pc.util.formatNumber(dateNum);
		}
		return dateNum+dataUnit;
	},
	trim:function (str,is_global){
		var result; 
		result = str.replace(/(^\s+)|(\s+$)/g,"");
		if(is_global.toLowerCase()==" ")
			result = result.replace(/\s/g,"");
		return result;
	},
    changeSort: function(columnName, sortOrder, listName) {
        var manager = $(listName).ligerGetGridManager();
        manager.changeSort(columnName, sortOrder);
    },
    isNotNull: function(exp) {
        return ! (exp == null || exp == "" || typeof(exp) == "undefined" || exp == "undefined" || exp == "null");
    },
    isNull: function(exp) {
        return !pc.util.isNotNull(exp);
    },
    alertWarn: function(content, ok_fun) {
        var info = '<div style="height:60px;display:table;"><div style="display:table-cell;vertical-align:middle;padding-right: 10px; ">' + content + '</div></div>';

        $.ligerDialog.warn(info, ok_fun);
    },
    success: function(content, ok_fun) {
        var info = '<div style="height:60px;display:table;"><div style="display:table-cell;vertical-align:middle;padding-right: 10px; ">' + content + '</div></div>';
        $.ligerDialog.success(info, internationalizationObj.common_pc_util_success_check, ok_fun);//提示信息
    },
    confirm: function(content, callback) {
        var info = '<div style="height:60px;display:table;"><div style="display:table-cell;vertical-align:middle;padding-right: 10px; ">' + content + '</div></div>';
        $.ligerDialog.confirm(info, callback);
    },
    waitting: function(content) {
        return $.ligerDialog.waitting(content);
    },
    accMul: function(arg1, arg2) //js 两数相乘  float精度问题 
    {
        var m = 0,
        s1 = arg1.toString(),
        s2 = arg2.toString();
        try {
            m += s1.split(".")[1].length
        } catch(e) {}
        try {
            m += s2.split(".")[1].length
        } catch(e) {}
        return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m);
    },
	accDiv:function(arg1,arg2){   //js 两数相除  float精度问题 
	    var t1=0,t2=0,r1,r2;  
	    try{t1=arg1.toString().split(".")[1].length}catch(e){}  
	    try{t2=arg2.toString().split(".")[1].length}catch(e){}  
	    with(Math){  
	        r1=Number(arg1.toString().replace(".",""));  
	        r2=Number(arg2.toString().replace(".",""));  
	        return (r1/r2)*pow(10,t2-t1);  
	    }
	},
	accAdd : function(arg1,arg2){//js 两数相加 float精度问题 
		var r1,r2,m;
		try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
		try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
		m=Math.pow(10,Math.max(r1,r2))
		return (arg1*m+arg2*m)/m
	},
	Subtr: function(arg1,arg2){
	     var r1,r2,m,n;
	     try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
	     try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
	     m=Math.pow(10,Math.max(r1,r2));
	     n=(r1>=r2)?r1:r2;
	     return ((arg1*m-arg2*m)/m).toFixed(n);
	},
    dateToStr: function(time, useType) //将时间类型转换成字符串
    {
    	var year = time.getFullYear();
        var month = time.getMonth();
        var day = time.getDate();
        var hour = time.getHours();
        var min = time.getMinutes();
        var seconds = time.getSeconds();
        
        var dataStr = year + "-" + pc.util.paddingLeftByZero((month + 1), 2) + "-" + pc.util.paddingLeftByZero(day, 2);
        if (useType != "notAddTime") {
        	dataStr += " "+ pc.util.paddingLeftByZero(hour, 2) + ":" + pc.util.paddingLeftByZero(min, 2) + ":" + pc.util.paddingLeftByZero(seconds, 2);
        }
        
        return dataStr;
    },
    dataStrFormat:function(str){//将2013-03-26 21:32:00 000形式的时间字符串，转换成2013-03-26 21:32:00
    	if(pc.util.isNull(str)) return str;
    	return str.substr(0,19);
    }
    ,
    timeToStr: function(time, useType) { //将时间戳类型转换成字符串
        var data = new Date(time);
        return pc.util.dateToStr(data, useType);
    },
    timeToFormatStr : function(time,format){//将时间戳转换成指定的格式字符串
    	 var t = new Date(time);
    	    var tf = function(i) {
    	        return (i < 10 ? '0': '') + i
    	    };
    	    return format.replace(/yyyy|MM|dd|HH|mm|ss/g,
    	    function(a) {
    	        switch (a) {
    	        case 'yyyy':
    	            return tf(t.getFullYear());
    	            break;
    	        case 'MM':
    	            return tf(t.getMonth() + 1);
    	            break;
    	        case 'mm':
    	            return tf(t.getMinutes());
    	            break;
    	        case 'dd':
    	            return tf(t.getDate());
    	            break;
    	        case 'HH':
    	            return tf(t.getHours());
    	            break;
    	        case 'ss':
    	            return tf(t.getSeconds());
    	            break;
    	        }
    	    })
    },
    paddingLeftByZero: function(orgi, digit) {
        /*数字位数达不到预期位数时，在左边位置补0。注：只适用整数。orig:原始数字，digit:预期位数*/
        var str = orgi + "";
        if (str.length < digit) {
            var needPadding = digit - str.length;
            for (var i = 0; i < needPadding; i++) {
                str = "0" + str;
            }
        }
        return str;
    },
    paddingRightByZero: function(orgi, digit) {
        /*数字位数达不到预期位数时，在左边位置补0。注：只适用整数。orig:原始数字，digit:预期位数*/
        var str = orgi + "";
        if (str.length < digit) {
            var needPadding = digit - str.length;
            for (var i = 0; i < needPadding; i++) {
                str =  str + "0";
            }
        }
        return str;
    },
    buildTreeUrl:function(connectorId, apiKey, placeholder, params){
    	return "/restServlet?connectorId="+connectorId+"&apiType=get&apiKey="+apiKey+"&placeholder="+placeholder+"&params="+params;
    },
    createIP : function (segmentValue){
    	
    	var mask = segmentValue.split("/")[1];
    	
    	var bit="";
    	for(var i=0;i<mask;i++){
    		bit +="1";
    	}
    	
    	var binary = this.paddingRightByZero(bit,32);
    	
    	var binaryCode =[];
    	
    	binaryCode[0] = binary.substring(0,8);
    	binaryCode[1] = binary.substring(8,16);
    	binaryCode[2] = binary.substring(16,24);
    	binaryCode[3] = binary.substring(24,32);
    	
    	var segment = "";
    	
    	for(var i=0;i<binaryCode.length;i++){
    		segment += this.bin2dec(binaryCode[i])+".";
    	}
    	
    	return segment.substring(0, segment.length-1);
    },
    bin2dec : function(bin){
    	var c = bin.split("");
    	var len = c.length;
    	var dec = 0;
    	for(i=0; i<len; i++){
    	  var temp = 1;
    	  if(c[i] == 1){
	    	  for(j=i+1; j<len; j++) temp *= 2;
	    	  dec += temp;
    	  }else if(c[i] != 0){
	    	  alert(internationalizationObj.common_pc_util_bin2dec_check);//二进制值有错误!
	    	  return false;
    	  }
    	}
    	 return dec;
     },
     formatNumber:function(num){//将数字转格式成千位符显示，num为字符串
    	 if(!isNaN(num)) num = ""+num;
    	 if(num == "0" || num == 0){//去掉0.00
    		 return num;
    	 }
    	 if(/[^0-9\.]/.test(num)) return num;
    	 num=num.replace(/^(\d*)$/,"$1.");
	      num=(num+"00").replace(/(\d*\.\d\d)\d*/,"$1");
	      num=num.replace(".",",");
	      var re=/(\d)(\d{3},)/;
	      while(re.test(num))
	              num=num.replace(re,"$1,$2");
	      num=num.replace(/,(\d\d)$/,".$1");
	      return num.replace(/^\./,"0.");
     },
	/**
	 * 获取当前时间
	 */
	getNowFormatDate:function () {
		var day = new Date();
		var Year = 0;
		var Month = 0;
		var Day = 0;
		var CurrentDate = "";
		//初始化时间 
		//Year= day.getYear();//有火狐下2008年显示108的bug 
		Year = day.getFullYear();//ie火狐下都可以 
		Month = day.getMonth() + 1;
		Day = day.getDate();
		Hour = day.getHours();
		Minute = day.getMinutes();
		Second = day.getSeconds();
		CurrentDate += Year + "-";
		if (Month >= 10) {
			CurrentDate += Month + "-";
		} else {
			CurrentDate += "0" + Month + "-";
		}
		if (Day >= 10) {
			CurrentDate += Day;
		} else {
			CurrentDate += "0" + Day;
		}
		CurrentDate += " ";

		if (Hour >= 10) {
			CurrentDate += Hour + ":";
		} else {
			CurrentDate += "0" + Hour + ":";
		}
		if (Minute >= 10) {
			CurrentDate += Minute + ":";
		} else {
			CurrentDate += "0" + Minute + ":";
		}
		if (Second >= 10) {
			CurrentDate += Second;
		} else {
			CurrentDate += "0" + Second;
		}
		return CurrentDate;
	},
	
	/**
	 * 获取当前日期前N天
	 */
	getAfterDate:function (curDate, days) {
		//获取s系统时间 
		var LSTR_ndate = new Date(Date.parse(curDate.replace(/-/g, "/")));
		var LSTR_Year = LSTR_ndate.getFullYear();
		var LSTR_Month = LSTR_ndate.getMonth();
		var LSTR_Date = LSTR_ndate.getDate();
		//处理 
		var uom = new Date(LSTR_Year, LSTR_Month, LSTR_Date);
		uom.setDate(uom.getDate() - days);//取得系统时间的前一天,重点在这里,负数是前几天,正数是后几天 
		var LINT_MM = uom.getMonth();
		LINT_MM++;
		var LSTR_MM = LINT_MM > 10 ? LINT_MM : ("0" + LINT_MM);
		var LINT_DD = uom.getDate();
		var LSTR_DD = LINT_DD >= 10 ? LINT_DD : ("0" + LINT_DD);
		//得到最终结果 
		uom = uom.getFullYear() + "-" + LSTR_MM + "-" + LSTR_DD;
		return uom + " 00:00:00";
	},
	/**
	 * 获取当前日期前N分钟（小时）
	 */
	getAfterTime:function (curDate, time, type) {
		var hour = "00";
		var minute = "00";
		//获取s系统时间 
		var LSTR_ndate = new Date(Date.parse(curDate.replace(/-/g, "/")));
		var LSTR_Year = LSTR_ndate.getFullYear();
		var LSTR_Month = LSTR_ndate.getMonth();
		var LSTR_Date = LSTR_ndate.getDate();
		var LSTR_Hour = LSTR_ndate.getHours();
		var LSTR_Minute = LSTR_ndate.getMinutes();
		var LSTR_seconds = LSTR_ndate.getSeconds();
		if(LSTR_seconds<10){
			LSTR_seconds ="0"+LSTR_seconds;
		}
		//处理 
		var uom = new Date(LSTR_Year, LSTR_Month, LSTR_Date);
		if(type == "hour"){
			if(LSTR_Hour < 1){
				uom.setDate(uom.getDate() - 1);
				hour = 59;
			}else{
				hour = LSTR_Hour - 1;
			}
			minute = LSTR_Minute;
		}else if(type == "minute"){
			if(LSTR_Minute < 10){
				//uom.setDate(uom.getDate() - 1);
				minute = 60 + LSTR_Minute - 10;
				if(LSTR_Hour > 1){
					hour = LSTR_Hour - 1;
				}else{
					hour = 23;
					uom.setDate(uom.getDate() - 1);
				}
			}else{
				minute = LSTR_Minute - 10;
				hour = LSTR_Hour;
			}
		}
		var LINT_MM = uom.getMonth();
		LINT_MM++;
		var LSTR_MM = LINT_MM > 10 ? LINT_MM : ("0" + LINT_MM);
		var LINT_DD = uom.getDate();
		var LSTR_DD = LINT_DD >= 10 ? LINT_DD : ("0" + LINT_DD);
		//得到最终结果 
		uom = uom.getFullYear() + "-" + LSTR_MM + "-" + LSTR_DD;
		if(hour != "00"){
			hour = hour < 10 ? ("0" + hour) : hour;
		}
		if(minute != "00"){
			minute = minute < 10 ? ("0" + minute) : minute;
		}
		return uom + " "+hour+":"+minute+":"+LSTR_seconds;
	},
    handlerWorkloadNum: function(workloadNum) {
        if (pc.util.isNotNull(workloadNum)) {
            workloadNum--; //虚拟机个数据减去vios
            if (workloadNum < 0) {
                workloadNum = 0;
            }
        } else {
            workloadNum = 0;
        }
        return workloadNum;
    },
    trim : function(str){
    	return str == null ? "": str.replace(/(^\s*)|(\s*$)/g, "");
    },
    showEmpty : function(str){
    	if(pc.util.isNotNull(str)){
    		return str;
    	}
    	return "";
    },
    invalidObjectAlert : function(str, reg, text){
    	if(reg.test(str)){
			alert(text);
			return true;
		} 
		return false;
    },
    /**
     * 检查是否包含查询条件中不允许的特殊字符&?=，包括特殊字符时，会自动提示。
     * @param str 待检查的字符
     * @return boolean值  true:包括特殊字符。false:不包括特殊字符。 
     */
    invalidQueryParam : function(str){
    	var reg = /[&=?#%_']+/;
		return pc.util.invalidObjectAlert(str, reg, internationalizationObj.common_pc_util_invalidQueryParam_check);//查询条件不能包含字符&=?#%_
    },
    invalidValueParam : function(str){
    	var reg = /[。~!@#$%\^\+\*&\\\/\?\|:\.<>{}【】';="]+/;
		return pc.util.invalidObjectAlert(str, reg, internationalizationObj.common_pc_util_invalidValueParam);//查询条件不能包含特殊字符
    },
    /**
     * pageNo 当前页数
     * perNum 每页容量 默认12
     */
    genPageQueryParam:function(pageNo,perNum){
    	var pNum = 12;
    	if(perNum){
    		pNum = perNum;
    	}
    	var firstResult=pageNo*pNum;
    	if(isNaN(firstResult)) return "firstResult=0&maxResult="+pNum;
    	return "firstResult="+firstResult+"&maxResult="+pNum;
    },
    bToGB:function(b){
    	if(isNaN(b) || b==0) return "0.00";
    	if(b){
    		return (b/Math.pow(1024, 3)).toFixed(2);
    	}else return b;
    },
    bToMB:function(b){
    	if(isNaN(b) || b==0) return "0.00";
    	if(b){
    		return (b/Math.pow(1024, 2)).toFixed(2);
    	}else return b;
    },
    mHzToGHz : function(mb){
    	if(isNaN(mb)) return "";
    	if(mb){
    		return (mb/1000).toFixed(2);
    	}else return mb;
    },
    mbToGb : function(mb){
    	if(isNaN(mb)) return "";
    	if(mb){
    		return (mb/1024).toFixed(2);
    	}else return mb;
    },
    gbToTb :  function(gb){
    	if(isNaN(gb)) return "";
    	if(gb){
    		return (gb/1024).toFixed(2);
    	}else return gb;
    },
    gbToMb : function(gb){
    	if(isNaN(gb)) return 0;
    	return (parseFloat(gb)*1024).toFixed(0);
    },
    strToFloat:function(num){
   	 try {
   		return parseFloat(num);
		} catch (e) {
			return 0;
		}
    },
    strToInt:function(num){
   	 try {
   		return parseInt(num);
		} catch (e) {
			return 0;
		}
    },
    formatLongInfo : function(maxsize,textBox){
    	var textBox=textBox||".format_long_info";
    	$(textBox).each(function(){
		    var info = $(this).text();
		    if(info.length > maxsize){
			    $(this).text(info.substring(0,maxsize-3)+"...");
			    $(this).attr("title",info);
		    }
	    });
    },
    cutOutStr :function(str,limit){
    	    str = (str == null ?  "" : str);
    	    var returnStr = str;
    	    var realLength = 0, len = str.length, charCode = -1;
    	    for (var i = 0; i < len; i++) {
    	        charCode = str.charCodeAt(i);
    	        if (charCode >= 0 && charCode <= 128){
    	        	 realLength += 1;
    	        }else{
    	        	realLength += 2;
    	        }
    	        if(realLength >= limit){
    	        	var tempStr = str.substr(0,i);
    				returnStr = tempStr +"...";
    				break;
    	        }
    	    }
			return returnStr;
    },
    enCode: function (str) {

		var ret = "";

		var strSpecial = "!\"#$%&'()*+,/:;<=>?[]^`{|}~%";

		for ( var i = 0; i < str.length; i++) {

			var chr = str.charAt(i);

			var c = str2asc(chr);

			//tt+= chr+":"+c+"n";

			if (parseInt("0x" + c) > 0x7f) {

				ret += "%" + c.slice(0, 2) + "%" + c.slice(-2);

			} else {

				if (chr == " ")

					ret += "+";

				else if (strSpecial.indexOf(chr) != -1)

					ret += "%" + c.toString(16);

				else

					ret += chr;

			}

		}

		return ret;

	},
    	
    deCode:	function (str) {

    		var ret = "";

    		for ( var i = 0; i < str.length; i++) {

    			var chr = str.charAt(i);

    			if (chr == "+") {

    				ret += " ";

    			} else if (chr == "%") {

    				var asc = str.substring(i + 1, i + 3);

    				if (parseInt("0x" + asc) > 0x7f) {

    					ret += asc2str(parseInt("0x" + asc
    							+ str.substring(i + 4, i + 6)));

    					i += 5;

    				} else {

    					ret += asc2str(parseInt("0x" + asc));

    					i += 2;

    				}

    			} else {

    				ret += chr;

    			}

    		}

    		return ret;

    	},
    	toFixed : function(number,fractionDigits){  
    		if(number ==0 || number == "0"){
    			return 0;
    		}
    	    with(Math){  
    	        return round(number*pow(10,fractionDigits))/pow(10,fractionDigits);  
    	    }  
    	}  
};

pc.validation = {
    /**
	 * 表单校验公共方法
	 * @param {Object} formId FORM表单ID
	 * @param {Object} submit_fun 校验成功的回调方法
	 */
    initValidation: function(formId, submit_fun) {
        $.metadata.setType("attr", "validate");
        var v = $("#" + formId).validate({
            errorPlacement: function(lable, element) {
                if (element.hasClass("l-textarea")) {
                    element.addClass("l-textarea-invalid");
                } else if (element.hasClass("l-text-field")) {
                    element.parent().addClass("l-text-invalid");
                }
                $(element).removeAttr("title").ligerHideTip();
                $(element).attr("title", lable.html()).ligerTip();
            },
            success: function(lable) {
                if (!lable.attr("for")) return;
                var element = $("#" + lable.attr("for"));
                if (element.hasClass("l-textarea")) {
                    element.removeClass("l-textarea-invalid");
                } else if (element.hasClass("l-text-field")) {
                    element.parent().removeClass("l-text-invalid");
                }
                $(element).removeAttr("title").ligerHideTip();
            },
            submitHandler: function() {
                submit_fun();
            }
        });

        $("#" + formId).ligerForm();
    }
};


/**
 * 去左右空格
 */
String.prototype.trim = function() 
{ 
	return this.replace(/(^\s*)|(\s*$)/g, ""); 
} 

/**
 * 去所有空格
 */
String.prototype.allTrim = function() 
{ 
	return this.replace(/\s+/g, ""); 
}

String.prototype.format = function(args){
	if(arguments.length>0){
		var result = this;
		if(arguments.length==1 && typeof(args)=="object"){
			for(var key in args){
				var reg = new RegExp("({"+key+"})","g");
				result = result.replace(reg,args[key]);
			}
		}else{
			for(var i=0;i<arguments.length;i++){
				if(arguments[i]==undefined){
					return "";
				}else{
					var reg = new RegExp("({["+i+"]})","g");
					result = result.replace(reg,arguments[i]);
				}
			}
		}
		return result;
	}else{
		return this;
	}
}

pc.input = {
	//搜索框默认显示内容：获取光标时隐藏、失去光标无value时显示
	autoShow : function(action, val, id, str){
		val = val.trim();
		if(action == "onfocus"){
			if(str == val){
				$("#"+id).val("");
				$("#"+id).focus();
			}
		}else if(action == "onblur"){
			if("" == val){
				$("#"+id).val(str);
			}
		}
	}
}
