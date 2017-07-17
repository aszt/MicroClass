<%--
  Created by IntelliJ IDEA.
  User: tong
  Date: 2016/10/28
  Time: 17:18
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>课程列表</title>
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'bootstrap.min.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'seeClazzList.css')}" type="text/css">
    <g:javascript src="jquery-2.1.3.min.js"/>
    <g:javascript src="bootstrap.min.js"/>
    %{--多文件上传--}%
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'fileinput.min.css')}" type="text/css">
    <g:javascript src="fileinput.min.js"/>
    <g:javascript src="fileinput_locale_zh.js"/>
    <g:javascript src="layer/layer.js"/>
</head>

<body>
<header>
    <div class="top_nav">
        <div class="top_container">
            <ul class="top_left">
                <li><a href="#">网易首页</a></li>
                <li><a href="#">视频</a></li>
                <li><a href="#">教育</a></li>
                <li><a href="#">网易云课堂</a></li>
            </ul>
            <div class="top_right">
                <!--<p>欢迎来到网易公开课!</p>-->
                <ul>
                    <li class="hides_left"><img class="tx" src="${resource(dir: '',file:session.userInfo.image)}" style="width: 40px;height: 40px"></li>
                    <li class="hides_left"><a href="#" id="goLogin">童重远</a></li>
                    <li><a href="#" style="color: #2E9057">修改密码</a></li>
                    <li><a href="#">退出登录</a></li>
                    <li><a href="#" style="color: #2E9057">客户端下载</a></li>
                </ul>
            </div>
        </div>
    </div>
</header>
<div class="zts">
    <div class="zt">
        <div class="left">
            <ul>
                <li class="djs">
                    <i class="glyphicon glyphicon-user"></i>
                    <g:link controller="userInfo" action="user">个人信息</g:link>
                </li>
                <li class="dj" style="background-color: #F5F5F5;">
                    <i class="glyphicon glyphicon-align-right"></i>
                    <g:link controller="userInfo" action="myCourse">我的课程</g:link>
                </li>
                <li onclick="clazz();" class="dj"><i class="glyphicon glyphicon-heart"></i>
                    <g:link controller="userInfo" action="collection">我的收藏</g:link>
                </li>
            </ul>
        </div>

        <!--下一步-->
        <div class="right" id="clazz" style="display: block">
            <div class="bt">
                <g:link controller="microClass" action="index">主页 > </g:link>
                <g:link controller="userInfo" action="myCourse">我的课程 ></g:link>
                <a href="#">课时列表</a>
            </div>
            <div class="kcc">
                <!--上传内容-->
                <div class="nr">
                    <h3>课时列表</h3>
                    <span class="sv" style="float: right;margin-top: -40px">
                        <a class="btn btn-default " href="#" id="create_clazz" onclick="goSave('${courseId}')">
                            <span class="glyphicon glyphicon-plus"></span>
                            创建课时
                        </a>
                    </span>
                <script>
                    //添加课时
                    function goSave(courseId) {
                            parent.location = "<g:createLink controller="ClassPeriodInfo" action="saveClassHour" />?id="+courseId;
                    }
                </script>
                    <hr style="width: 100%;margin: 10px auto">
                    <div class="captain">
                        <div class="unit">
                            <div class="yd">
                                <ul>
                                    %{--遍历课时列表--}%
                                    <g:each in="${clazzList}" status="i" var="clazzInfoInstance">
                                        <li>
                                            %{--<a href="#">第一章 ${clazzInfoInstance.name}</a>--}%
                                            <a href="javascript:void(0);" onclick="updateClazz('${clazzInfoInstance.id}')">${clazzInfoInstance.name}</a>
                                            <a href="javascript:void(0);" onclick="delClazz('${clazzInfoInstance.id}','${courseId}')" class="glyphicon glyphicon-trash" title="删除" style="color: red;float: right;margin-right: 1px;line-height: 30px"></a>
                                        </li>
                                    </g:each>
                                    <script>
                                        //编辑课时信息
                                        function updateClazz(clazzId) {
                                                parent.location = "<g:createLink controller="classPeriodInfo" action="update" />?id="+clazzId;
                                        }
                                        //删除课时信息
                                        function delClazz(clazzId,courseId) {
                                            $.ajax({
                                                url:'<g:createLink controller="classPeriodInfo" action="delClazz" />',
                                                type:'post',
                                                dataType:'json',
                                                data:{
                                                    clazzId:clazzId,
                                                    courseId:courseId,
                                                },
                                                success:function(msg){
                                                    if(msg.state=="200"){
                                                        layer.msg("删除成功",{time: 500}, function(){
                                                            parent.location = "<g:createLink controller="classPeriodInfo" action="seeClazzList" />?id="+courseId;
                                                        });
                                                    }else{
                                                        layer.msg("删除失败",{time: 500}, function(){
                                                            parent.location = "<g:createLink controller="classPeriodInfo" action="seeClazzList" />?id="+courseId;
                                                        });
                                                    }
                                                }
                                            });

                                        }
                                    </script>
                                </ul>
                            </div>
                        </div>
                    </div>

                </div>
            </header>
            </div>
        </div>
        <!--我的课程页面结束-->
    </div>
</div>

<!--<div style="height: 660px"></div>-->
<!--<div class="login-footer">
    <span class="one">微课平台系统后台</span><br>
    <span>14软件技术毕业设计====滁州职业技术学院</span><br>
    <span>童重远、陈凯旋</span>
</div>-->
</body>
</html>