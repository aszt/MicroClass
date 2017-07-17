<%--
  Created by IntelliJ IDEA.
  User: tong
  Date: 2016/10/24
  Time: 10:26
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>登录/注册</title>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'userLogin.css')}" type="text/css">
    <g:javascript src="jquery-2.1.3.min.js"/>
    <!--验证码-->
    <script src="http://static.geetest.com/static/tools/gt.js"></script>

    <script type="text/javascript">
        <g:if test="${flash.loginMessage ==200}">
            parent.location.reload(); // 父页面刷新
            var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
            parent.layer.close(index);
        </g:if>

        $(document).ready(function () {
            $("#goRegister").click(function () {
                $(".login").hide();
                $(".register").show(1000, function () {
                });
            })
            $("#login").click(function () {
                $(".register").hide();
                $(".login").show(1000, function () {
                });
            })
        })
    </script>
</head>

<body>
<header>
    <!--登录-->
    <div class="login " style="margin-top: 50px;">
        <g:form controller="userInfo" action="login" method="post" id="loginForm">
            <g:textField name="userName" placeholder="邮箱/用户名" class="em" required="" id="loginName"/>
            <span id="p1" class="error-notic"></span>
            <br>
        %{--<input type="password" onblur="p(this)" placeholder="密码" class="ps" name="password">--}%
            <g:passwordField name="password" class="ps" placeholder="密码" required="" id="password"/>
            <span id="p" class="error-notic"></span>
            <br>

        %{--验证码==============--}%
        <div style="width: 328px;height: 33px;margin-top: 15px;">
            <div id="float-captcha"></div>
            <p id="wait" class="show">正在加载验证码......</p>
            <p id="notice" class="hide" style="color: #cc0000">请先拖动验证码到相应位置</p>
        </div>

            <input id="dl" type="button" value="登录" class="sb" style="margin-top: 20px">
        </g:form>
        <a href="#" style="float: left">忘记密码？</a>
        <a id="goRegister" href="#" style="float: right">注册账号</a>
        <div style="clear: both"></div>
        <span style="font-size: 14px; color: #ff4e00; font-weight: 500;float: left">${flash.loginMessage}</span>

    </div>

    <!--注册-->
    <div class="register" style="display: none;">
        <g:form controller="userInfo" action="register" method="post" id="registForm">
            <input type="text" placeholder="邮箱" class="em" name="email" id="email"><br>
            <input type="text" placeholder="用户名" class="ps" name="userName" id="userName"><br>
            <input type="password" placeholder="密码（字母、数字，至少6位）"id="psw1" class="ps" name="password">
            <br>
            <input type="password" placeholder="确认密码" class="ps" id="psw2" name="passwords"><br>

            <input id="zc" type="button" value="注册" class="sb" style="margin-top: 20px">
            <div id="popup-captcha"></div>
        </g:form>
    <span id="errorMsg" style="font-size: 14px; color: #ff4e00; font-weight: 500;float: left">${flash.registMsg}</span>
        <a id="login" href="#" style="float: right">已有账号?登录>></a>

        <div style="clear: both"></div>
    </div>
</header>
<script>
    function showNotic(_this) {
        $(_this).parents(".form-group").find(".error-notic").fadeIn(100);
        $(_this).focus();
    }//错误提示显示
    function hideNotic(_this) {
        $(_this).parents(".form-group").find(".error-notic").fadeOut(100);
    }//错误提示隐藏

    var handlerEmbed = function (captchaObj) {

        $("#dl").click(function (e) {

            if ($("#loginName").val().length == 0) {
               $("#p1").text("登录名不能为空")
                setTimeout(function () {
                    $("#p1").text("")
                }, 2000);
                return
            }
            if ($("#password").val().length == 0) {
                $("#p").text("密码不能为空")
                setTimeout(function () {
                    $("#p").text("")
                }, 2000);
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
                    if (data && (data.status =="success")) {
                        window.document.forms[0].submit()
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
            initGeetest({
                gt: data.gt,
                challenge: data.challenge,
                product: "float", // 产品形式，包括：float，embed，popup。注意只对PC版验证码有效
                offline: !data.success // 表示用户后台检测极验服务器是否宕机，一般不需要关注
            }, handlerEmbed);
        }
    });

    //登陆结束，注册开始
    var handlerPopup = function (captchaObj) {
        $("#zc").click(function () {
            //此处验证注册框内容
            var email=$("#email").val()
            if(email.length==0){
                $("#errorMsg").text("邮箱不能为空")
                setTimeout(function () {
                    $("#errorMsg").text("")
                }, 2000);
                return
            }
            var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            if (!filter.test(email)){
                $("#errorMsg").text("邮箱格式不正确")
                setTimeout(function () {
                    $("#errorMsg").text("")
                }, 2000);
                return
            }
            $.ajax({
                        url:'<g:createLink controller="userInfo" action="checkEmail" />',
                        type:'post',
                        dataType:'json',
                        data:{email:email},
                        success:function(msg){
                            if(msg.state=='200'){
                                $("#errorMsg").text("当前邮箱已被注册！")
                                setTimeout(function () {
                                    $("#errorMsg").text("")
                                }, 2000);
                                return
                            }
                        }
                    }
            );
            var userName=$("#userName").val()
            if(userName.length==0){
                $("#errorMsg").text("用户名不能为空！")
                setTimeout(function () {
                    $("#errorMsg").text("")
                }, 2000);
                return
            }
            $.ajax({
                        url:'<g:createLink controller="userInfo" action="checkUserName" />',
                        type:'post',
                        dataType:'json',
                        data:{userName:userName},
                        success:function(msg){
                            if(msg.state=='200'){
                                $("#errorMsg").text("当前用户名已被注册！")
                                setTimeout(function () {
                                    $("#errorMsg").text("")
                                }, 2000);
                                return
                            }
                        }
                    }
            );
            var psw1=$("#psw1").val()
            var psw2=$("#psw2").val()
            if(psw1.length<6||psw1.length>18){
                $("#errorMsg").text("密码不符合要求！")
                setTimeout(function () {
                    $("#errorMsg").text("")
                }, 2000);
                return
            }
            if(psw1!=psw2){
                $("#errorMsg").text("两次密码不一致！")
                setTimeout(function () {
                    $("#errorMsg").text("")
                }, 2000);
                return
            }
            var validate = captchaObj.getValidate();
            if (!validate) {
                alert('请先完成验证！');
                return;
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
                        document.forms[1].submit();

                    } else {
                        showNotic("#lverifyError")
                        setTimeout(function () {
                            hideNotic("#lverifyError")
                        }, 1000);
                    }
                }
            });
        });
        // 弹出式需要绑定触发验证码弹出按钮
        captchaObj.bindOn("#zc");
        // 将验证码加到id为captcha的元素里
        captchaObj.appendTo("#popup-captcha");

    };
    $.ajax({
        // 获取id，challenge，success（是否启用failback）
        url: "<g:createLink controller="public" action="startCaptcha"/>",
        type: "get",
        dataType: "json",
        success: function (data) {
            initGeetest({
                gt: data.gt,
                challenge: data.challenge,
                product: "popup", // 产品形式，包括：float，embed，popup。注意只对PC版验证码有效
                offline: !data.success // 表示用户后台检测极验服务器是否宕机，一般不需要关注
            }, handlerPopup);
        }
    });

    <g:if test="${flash.message ==500}">
    $(".login").hide();
    $(".register").show();
    </g:if>
</script>
</body>
</html>