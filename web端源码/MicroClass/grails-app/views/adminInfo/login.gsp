<!doctype html>
<html lang="ch">

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="description" content="">
		<meta name="keywords" content="">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		<meta name="format-detection" content="telephone=no">
		<title>精品课程后台登陆</title>

		<link rel="stylesheet" href="${resource(dir: 'css',file: 'style.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css',file: 'iconfont.css')}">


		<g:javascript src="jquery.min.js"/>
		<g:javascript src="bootstrap.min.js"/>
		<!--验证码-->
		<script src="http://static.geetest.com/static/tools/gt.js"></script>
		<!--[if lt IE 9]>
          <!--<script src="js/html5shiv.min.js"></script>-->
		<g:javascript src="html5.js"/>

		<g:javascript src="respond.min.js"/>
        <![endif]-->
		<link href="${resource(dir: 'css',file: 'bootstrap.min.css')}" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="${resource(dir: 'css',file: 'common.css')}" />
		<link rel="stylesheet" type="text/css" href="${resource(dir: 'css',file: 'slide.css')}" />
		<link rel="stylesheet" type="text/css" href="${resource(dir: 'css',file: 'jquery.nouislider.css')}">
	</head>

	<body>
    	  
		<div id="wrap" style=" padding-top:100px;">
       <div class="logo">
            <a>
            <img src="${resource(dir: 'images',file: 'logo_big3.png')}">
            </a>
         </div>
        	<h3 style="width:100%; text-align:center;">精品课程系统后台登录</h3>
            <div class="login-box">
		<div class="box-con tran">
			<div class="login-con f-l">
			 <g:form controller="adminInfo" action="doLogin" method="post">
				<div class="form-group">
					<input type="text" placeholder="登录名" name="name" id="loginName"/>
					<span class="error-notic">登录名不能为空</span>
				</div>
				<div class="form-group"> 
					<input type="password" placeholder="密码" name="password" id="password"/>
					<span class="error-notic">密码不能为空</span>
				</div>
				<div id="float-captcha" ></div>
				<p id="wait" class="show">正在加载验证码......</p>
				<p id="notice" class="hide">请先拖动验证码到相应位置</p>
				<div class="form-group">
					<button type="button" class="tran pr" style=" cursor:pointer;"id="login-submit">
						<a href="javascript:;" class="tran" >登录</a>
					</button>
					<span class="error-notic" id="verifyError">验证码错误</span>
					<span style="font-size: 14px; color: #ff4e00; font-weight: 500;"> ${flash.message}</span>
				</div>
              </g:form>
			
			</div>
			<!-- 登录 -->
			
		 </div>
         </div>
			</div>
         </div>
		<div class="login-footer">
            <h1>精品课程系统后台</h1>
            <p style="margin-top:-5px;">14级软件班毕业设计选题  指导老师:吴昌雨</p>
            <p>童重远&陈凯旋</p>
	    </div>

	<script>
				function showNotic(_this){
					$(_this).parents(".form-group").find(".error-notic").fadeIn(100);
					$(_this).focus();
				}//错误提示显示
				function hideNotic(_this){
					$(_this).parents(".form-group").find(".error-notic").fadeOut(100);
				}//错误提示隐藏

				var handlerEmbed = function (captchaObj) {

					$("#login-submit").click(function (e) {

						if($("#loginName").val().length==0){
							showNotic("#loginName")
							return
						}
						if($("#password").val().length==0){
							showNotic("#password")
							return
						}
				var validate = captchaObj.getValidate();
				if (!validate) {
					$("#notice")[0].className = "show";
					setTimeout(function () {
						$("#notice")[0].className = "hide";
					}, 2000);
					e.preventDefault();
					return
				}

				$.ajax({
					url: "<g:createLink controller="public" action="verifyLogin"/>", // 进行二次验证
					type: "post",
					dataType: "json",
					data: {
						// 二次验证所需的三个值
						geetest_challenge: validate.geetest_challenge,
						geetest_validate: validate.geetest_validate,
						geetest_seccode: validate.geetest_seccode
					},
					success: function (data) {
						if (data && (data.status === "success")) {
							document.forms[0].submit();

						} else {
							showNotic("#verifyError")
							setTimeout(function () {
								hideNotic("#verifyError")
							}, 1000);
						}
					}
				});

			});

			// 将验证码加到id为captcha的元素里
			captchaObj.appendTo("#float-captcha");

			captchaObj.onReady(function () {
				$("#wait")[0].className = "hide";
			});

			// 更多接口参考：http://www.geetest.com/install/sections/idx-client-sdk.html
		};
		$.ajax({
			// 获取id，challenge，success（是否启用failback）
			url: "<g:createLink controller="public" action="startCaptcha"/>",
			type: "get",
			dataType: "json",
			success: function (data) {

				// 使用initGeetest接口
				// 参数1：配置参数
				// 参数2：回调，回调的第一个参数验证码对象，之后可以使用它做appendTo之类的事件
				initGeetest({
					gt: data.gt,
					challenge: data.challenge,
					product: "float", // 产品形式，包括：float，embed，popup。注意只对PC版验证码有效
					offline: !data.success // 表示用户后台检测极验服务器是否宕机，一般不需要关注
				}, handlerEmbed);
			}
		});

	</script>


	</body>

</html>