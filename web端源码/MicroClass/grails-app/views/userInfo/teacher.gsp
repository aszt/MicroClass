<%--
  Created by IntelliJ IDEA.
  User: tong
  Date: 2016/10/25
  Time: 12:44
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>个人中心/教师</title>
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'bootstrap.min.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'teacher.css')}" type="text/css">
    <g:javascript src="jquery-2.1.3.min.js"/>
    <g:javascript src="bootstrap.min.js"/>
    <g:javascript src="layer/layer.js"/>

    <script type="text/javascript">
        function update() {
            $('#xg').css('display','block')
            $('#ys').css('display','none')

        }
        function cancel() {
            $('#ys').css('display','block')
            $('#xg').css('display','none')
        }

        //        修改个人信息
        function updateInfo() {
            var userName = $("#userName").val();
            var name = $("#name").val();
            var sex  = $('input[name="Fruit"]:checked').val(); //获取被选中Radio的Value值
            var mobilePhone = $("#mobilePhone").val();
            var school = $("#school").val();
            var college = $("#college").val();
            var code = $("#code").val();
            var position = $("#position").val();
            $.ajax({
                url:'<g:createLink controller="userInfo" action="update" />',
                type:'post',
                dataType:'json',
                data:{
                    userName:userName,
                    sex:sex,
                    mobilePhone:mobilePhone,
                    name:name,
                    school:school,
                    college:college,
                    code:code,
                    position:position,
                },
                success:function(msg){
                    if(msg.msg=="200"){
                        parent.location.reload(); // 父页面刷新
                    }
                }
            });
        }
        $(document).ready(function() {
            //修改密码
            $('#updatePw').on('click', function () {
                layer.open({
                    type: 2,
                    title: ['修改密码', 'text-align: center;font-size:25px'],
                    skin: 'demo-class', /*自定义标题颜色*/
                    closeBtn: 2, /*关闭按钮风格*/
                    shadeClose: true,
                    shade: 0.8,
                    area: ['600px', '70%'],//小屏幕上正好
                    content: "<g:createLink controller="userInfo" action="updatePW"/>",
                    end: function () {
                    }
                });
            });
        })

        //换头像
        $(document).ready(function(){
            //个人中心头像上传弹窗
            $('.huantouxiang').on('click', function(){

                layer.open({
                    title :'头像上传',
                    type: 1,
                    shade: 0.8,
                    area: ['630px', '500px'],
                    shadeClose: true, //点击遮罩关闭
                    content:$('#shangchuan')

                });
            });
        })
    </script>
</head>

<body>
<header>
    <div class="top_nav">
        <div class="top_container">
            <ul class="top_left">
                <li><g:link controller="microClass" action="index">网站首页</g:link></li>
            </ul>
            <div class="top_right">
                <!--<p>欢迎来到网易公开课!</p>-->
                <ul>
                    <li class="hides_left"><img class="top_tx" src="${resource(dir: '',file:userInfo.image )}" style="width: 40px;height: 40px"></li>
                    <li class="hides_left"><a href="javascript:void(0);" id="goLogin">${userInfo.name}</a></li>
                    <li><a href="javascript:void(0);" style="color: #2E9057" id="updatePw">修改密码</a></li>
                    <li><g:link controller="userInfo" action="loginOut">退出登录</g:link></li>
                    <li><a href="${resource(dir: 'uploads', file: 'MicroClass_app.apk')}"  target="_blank" style="color: #2E9057">客户端下载</a></li>
                </ul>
            </div>
        </div>
    </div>
</header>
<div class="zts">
    <div class="zt">
        <div class="left">
            <ul>
                <li onclick="info();" class="dj"><i class="glyphicon glyphicon-user"></i>
                    <g:link controller="userInfo" action="user">个人信息</g:link>
                </li>
                <li onclick="clazz();" class="djs"><i class="glyphicon glyphicon-align-right"></i>
                    <g:link controller="userInfo" action="myCourse">我的课程</g:link>
                </li>
                <li onclick="clazz();" class="djs"><i class="glyphicon glyphicon-heart"></i>
                    <g:link controller="userInfo" action="collection">我的收藏</g:link>
                </li>
            </ul>
        </div>
        <div class="right" id="info">
            <div class="bt">
                <a class="lj" href="../">主页 > </a>
                <a href="#">个人信息</a>
            </div>
            <div class="xxs">
                <div class="headPortrait">
                    <img class="tx huantouxiang" src="${resource(dir: '',file:userInfo.image )}">
                    <h1>${userInfo.userName}</h1>
                    %{--<button class="touxiang"><a href="#" id="q" onclick="update();">修改资料</a></button>--}%
                    <button class="touxiang" onclick="update();" style="color: white">修改资料</button>
                </div>
                <div class="Info" id="ys" style="display: block;">
                    <table  cellspacing="15" class="">

                        <tr>
                            <td class="l">注册邮箱：</td>
                            <td>${userInfo.email}</td>
                        </tr>
                        <tr>
                            <td class="l">用户名：</td>
                            <td>${userInfo.userName}</td>
                        </tr>
                        <tr>
                            <td class="l">姓名：</td>
                            <td>${userInfo.name}</td>
                        </tr>
                        <tr>
                            <td class="l">性别：</td>
                            <td>${userInfo.sex}</td>
                        </tr>
                        <tr>
                            <td class="l">联系方式：</td>
                            <td>${userInfo.mobilePhone}</td>
                        </tr>
                        <tr>
                            <td class="l">学校：</td>
                            <td>${userInfo.school}</td>
                        </tr>
                        <tr>
                            <td class="l">院系：</td>
                            <td>${userInfo.college}</td>
                        </tr>
                        <tr>
                            <td class="l">教师工号：</td>
                            <td>${userInfo.code}</td>
                        </tr>
                        <tr>
                            <td class="l">职称：</td>
                            <td>${userInfo.position}</td>
                        </tr>
                        <tr>
                            %{--<td class="l">个人简介：</td>--}%
                            %{--<td>${userInfo.introduction}</td>--}%
                        </tr>
                    </table>
                </div>
                <!--修改资料隐藏样式开始-->
                <div class="Info" id="xg" style="display: none">
                    <table border="0"  cellspacing="15">
                        <tr>
                            <td>用户名：</td>
                            <td><input id="userName" class="form-control" type="text" readonly value="${userInfo.userName}"></td>
                        </tr>
                        <tr>
                            <td>真实姓名：</td>
                            <td><input id="name" class="form-control" type="text" value="${userInfo.name}"></td>
                        </tr>
                        <tr>
                            <td>性别</td>
                            <td>
                                <input  name="Fruit" type="radio" value="男" checked />男
                                <input  name="Fruit" type="radio" value="女" />女
                            </td>
                        </tr>
                        <tr>
                            <td>联系方式：</td>
                            <td><input id="mobilePhone" class="form-control" type="text" value="${userInfo.mobilePhone}"></td>
                        </tr>
                        <tr>
                            <td>学校：</td>
                            <td><input id="school" class="form-control" type="text" value="${userInfo.school}"></td>
                        </tr>
                        <tr>
                            <td>院系：</td>
                            <td><input id="college" class="form-control" type="text" value="${userInfo.college}"></td>
                        </tr>
                        <tr>
                            <td>教师工号：</td>
                            <td><input id="code" class="form-control" type="text" value="${userInfo.code}"></td>
                        </tr>
                        <tr>
                            <td>职称：</td>
                            <td><input id="position" class="form-control" type="text" value="${userInfo.position}"></td>
                        </tr>
                    </table>
                    <button class="q1" onclick="updateInfo();" style="color: white">修改</button>
                    <button class="q1" onclick="cancel();" style="color: white">取消</button>
                </div>
                <!--修改资料隐藏样式止-->
            </div>
        </div>
    </div>
</div>
%{--<div style="height: 660px"></div>--}%
%{--<div class="login-footer">--}%
    %{--<span class="one">微课平台系统后台</span><br>--}%
    %{--<span>14软件技术毕业设计====滁州职业技术学院</span><br>--}%
    %{--<span>童重远、陈凯旋</span>--}%
%{--</div>--}%
<div id="shangchuan" style="display: none;">
    <div class="demo">
        <p id="swfContainer">
        </p>
    </div>
</div>

<g:javascript src="swfobject.js"/>
<g:javascript src="fullAvatarEditor.js"/>

<script type="text/javascript">
    swfobject.addDomLoadEvent(function() {

        var swf = new fullAvatarEditor( "swfContainer", {
                    id: 'swf',
                    upload_url: '<g:createLink controller="userInfo" action="doUpload"></g:createLink>', //上传接口
                    method: 'post', //传递到上传接口中的查询参数的提交方式。更改该值时，请注意更改上传接口中的查询参数的接收方式
                    src_upload: 0, //是否上传原图片的选项，有以下值：0-不上传；1-上传；2-显示复选框由用户选择
                    avatar_box_border_width: 0,
                    avatar_sizes: '100*100|50*50|32*32',
                    avatar_sizes_desc: '100*100像素|50*50像素|32*32像素'
                }, function(msg) {
                    switch (msg.code)
                    {
                        case 1 :
                            //  alert("页面成功加载了组件！");
                            break;
                        case 2 :
                            //   alert("已成功加载图片到编辑面板。");
                            document.getElementById("upload").style.display = "inline";
                            break;
                        case 3 :
                            if (msg.type == 0)
                            {
                                alert("摄像头已准备就绪且用户已允许使用。");
                            }
                            else if (msg.type == 1)
                            {
                                alert("摄像头已准备就绪但用户未允许使用！");
                            }
                            else
                            {
                                alert("摄像头被占用！");
                            }
                            break;
                        case 5 :
                            setTimeout("window.location='<g:createLink controller="userInfo" action="user"/>'", 1000);

                            break;
                    }
                }
        );
        document.getElementById("upload").onclick = function() {
            swf.call("upload");
        };
    });
</script>
</body>
</html>