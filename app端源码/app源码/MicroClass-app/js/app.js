(function($, owner) {

	/*
	 *用户登陆 
	 **/
	owner.login = function(loginInfo, callback) {	
		callback = callback || $.noop;
		loginInfo = loginInfo || {};
		loginInfo.userName = loginInfo.userName || '';
		loginInfo.password = loginInfo.password || '';
		if(loginInfo.userName.length < 1) {
			return callback('用户名不能为空');
		}
		if(loginInfo.password.length < 6) {
			return callback('密码最短为 6 个字符');
		}
		mui.ajax(request_url + 'userInfo/login_app', {
			
			data: {
				userName: loginInfo.userName,
				password: loginInfo.password
			},
			dataType: 'json', //服务器返回json格式数据
			type: 'post', //HTTP请求类型
			timeout: 5000, //超时时间设置为5秒；
			success: function(data) {
				//服务器返回响应，根据响应结果，分析是否登录成功
				if(owner.getSettings().autoLogin) {
					owner.createLoginConf(loginInfo.userName, loginInfo.password)
				}

				return owner.createState(data.userInfo.userName, data.userInfo.email, data.userInfo.id, data.userInfo.image, callback);
			},
			error: function(xhr, type, errorThrown) {
				if(errorThrown == 'Not Found') {
					return callback('账户名或者密码错误');
				} else if(errorThrown == 'Forbidden') {
					return callback('账号未激活');
				} else {
					return callback('未知错误,请重试');
				}
			}
		});
	};
	/*
	 * 注册方法
	 * */
	owner.register = function(userInfo, callback) {
		callback = callback || $.noop;
		userInfo = userInfo || {};
		userInfo.userName = userInfo.userName || '';
		userInfo.email = userInfo.email || '';
		userInfo.password = userInfo.password || '';

		if(userInfo.userName.length < 1) {
			return callback('用户名不能为空');
		}
		if(userInfo.email.length < 1) {
			return callback('电子邮箱不能为空');
		}
		var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
		if(!filter.test(userInfo.email)) {
			return callback('您的电子邮件格式不正确');
		}
		if(userInfo.password.length < 6 || userInfo.password.length > 18) {
			return callback('密码应该为 6-18 个字符');
		}

		mui.ajax(request_url + 'userInfo/register_app', {
			data: {
				email: userInfo.email,
				userName: userInfo.userName,
				password: userInfo.password
			},
			dataType: 'json', //服务器返回json格式数据
			type: 'post', //HTTP请求类型
			timeout: 10000, //超时时间设置为10秒；
			success: function(data) {
				//服务器返回响应，根据响应结果，分析是否登录成功
				return callback();
			},
			error: function(xhr, type, errorThrown) {
				if(errorThrown == "Forbidden") {
					return callback('邮箱或用户名已被注册');
				} else if(errorThrown == 'Not Found') {
					return callback('注册失败，请重试');
				} else {
					return callback('未知错误，请重试');
				}
			}
		});

	};
	/*
	 * 重置密码
	 * */
	owner.restPassword = function(userInfo, callback) {
		callback = callback || $.noop;
		userInfo = userInfo || {};
		userInfo.email = userInfo.email || '';

		if(userInfo.email.length < 1) {
			return callback('电子邮箱不能为空');
		}
		var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
		if(!filter.test(userInfo.email)) {
			return callback('您的电子邮件格式不正确');
		}
		mui.ajax(request_url + 'userInfo/sendResetEmail_app', {
			data: {
				email: userInfo.email,
			},
			dataType: 'json', //服务器返回json格式数据
			type: 'post', //HTTP请求类型
			timeout: 10000, //超时时间设置为10秒；
			success: function(data) {
				return callback();
			},
			error: function(xhr, type, errorThrown) {
				if(errorThrown == 'Forbidden') {
					return callback('发送邮件失败');
				} else if(errorThrown == 'Not Found') {
					return callback('没有找到用户');
				} else {
					return callback('未知错误，请重试');
				}
			}
		});
	};
	/*
	 *请求服务器获取课程信息集合
	 * */
	owner.getCourseInfoList=function(pageNo, seach,page,userId) {
		mui.ajax(request_url + 'courseInfo/getCourseInfoList_app', {
			data: {
				seach: seach,
				pageNo: pageNo,
				page:page,
				userId:userId
			},
			dataType: 'json', //服务器返回json格式数据
			type: 'post', //HTTP请求类型
			timeout: 10000, //超时时间设置为10秒；
			success: function(data) {
				var courseInfoList = data.courseInfoList;
				
				return data.courseInfoList;
			},
			error: function(xhr, type, errorThrown) {}
		});
	};
	/*
	 *构建课程列表内容
	 * */
	owner.createCourseList=function(courseInfoList,listLenth) {
		var fragment = document.createDocumentFragment();
		var span;
		for (var i = 0; i < listLenth; i++) {
			var courseInfo=courseInfoList.get(i);
			span = document.createElement('span');
			span.innerHTML ='<li class="mui-table-view-cell mui-media mui-col-xs-6" id="'+courseInfo.id+'">'+
			'<a href="#">'+
			'<img class="mui-media-object" src="'+request_url+courseInfo.image+'">'+
			'<div class="mui-media-body">'+courseInfo.name+'</div>'+
			'</a></li>';
			fragment.appendChild(span)
		}
		return fragment;
	};
	/*
	 *请求服务器获取课程信息
	 * */
	owner.getCourseInfo=function(courseId) {
		mui.ajax(request_url + 'courseInfo/getCourseInfo_app', {
			data: {
				courseId: courseId	
			},
			dataType: 'json', //服务器返回json格式数据
			type: 'post', //HTTP请求类型
			timeout: 10000, //超时时间设置为10秒；
			success: function(data) {
				return data;
			},
			error: function(xhr, type, errorThrown) {}
		});
	};
	/*
	 *构建课时列表内容
	 * */
	owner.createClassPeriodList=function(classPeriodList) {
		var fragment = document.createDocumentFragment();
		var span;
		for (var i = 0; i < classPeriodList; i++) {
			var courseInfo=courseInfoList.get(i);
			span = document.createElement('span');
			
			fragment.appendChild(span)
		}
		return fragment;
	};
	/*
	 *保存用户登陆信息 
	 * */
	owner.createState = function(account, email, userId, image, callback) {
		var state = owner.getState();
		state.userName = account;
		state.email = email;
		state.userId = userId;
		state.image = image;
		owner.setState(state);
		return callback();
	};

	/*
	 *记住用户名密码
	 * */
	owner.createLoginConf = function(account, psw) {
		var loginConf = owner.getLoginConf();
		loginConf.account = account;
		loginConf.password = psw;
		owner.setLoginConf(loginConf);
	};

	/**
	 * 获取用户名密码
	 **/
	owner.getLoginConf = function() {
		var loginConfText = localStorage.getItem('$loginConf') || "{}";
		return JSON.parse(loginConfText);
	};

	/**
	 * 设置用户名密码
	 **/
	owner.setLoginConf = function(loginConf) {
		loginConf = loginConf || {};
		localStorage.setItem('$loginConf', JSON.stringify(loginConf));
	};

	/**
	 * 获取当前状态
	 **/
	owner.getState = function() {
		var stateText = localStorage.getItem('$state') || "{}";
		return JSON.parse(stateText);
	};

	/**
	 * 设置当前状态
	 **/
	owner.setState = function(state) {
		state = state || {};
		localStorage.setItem('$state', JSON.stringify(state));
	};
	/**
	 *设置应用本地配置
	 **/
	owner.setSettings = function(settings) {
		settings = settings || {};
		localStorage.setItem('$settings', JSON.stringify(settings));
	}

	/**
	 *获取应用本地配置
	 **/
	owner.getSettings = function() {
		var settingsText = localStorage.getItem('$settings') || "{}";
		return JSON.parse(settingsText);
	}

}(mui, window.app = {}));