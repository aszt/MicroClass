<%--
  Created by IntelliJ IDEA.
  User: tong
  Date: 2016/10/25
  Time: 12:56
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>创建课程</title>
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'bootstrap.min.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'createClazz.css')}" type="text/css">

    <g:javascript src="layer/layer.js"/>
    <g:javascript src="jquery-2.1.3.min.js"/>
    <g:javascript src="bootstrap.min.js"/>
    %{--多文件上传--}%
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'fileinput.min.css')}" type="text/css">
    <g:javascript src="fileinput.min.js"/>
    <g:javascript src="fileinput_locale_zh.js"/>
    <!--获取当前时间-->
    <script type="text/javascript">
        $(document).ready(function() {
            var date = new Date();
            var seperator1 = "-";
            var seperator2 = ":";
            var month = date.getMonth() + 1;
            var strDate = date.getDate();
            if (month >= 1 && month <= 9) {
                month = "0" + month;
            }
            if (strDate >= 0 && strDate <= 9) {
                strDate = "0" + strDate;
            }
            var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
                    + " " + date.getHours() + seperator2 + date.getMinutes()
                    + seperator2 + date.getSeconds();
            document.getElementById("tie").value=currentdate;
        })

        $(document).ready(function () {
            /*创建课程====================*/
            $("#dl").click(function () {
                var names = $(".in").val()
                var types = $("#cz").val()
                var category = $("#czs").val()
                if(names==""){
                    alert("请填写课程名称")
                }else{
                    $.ajax({
                        url:'<g:createLink controller="courseInfo" action="add" />',
                        type:'post',
                        dataType:'json',
                        data:{name:names,type:types,category:category},
                        success:function(msg){
                            if(msg.state=="200"){
                                var courseId = msg.courseInfoId;//返回创建课程的id
                                parent.location = "<g:createLink controller="courseInfo" action="perfectClazz" />?id="+courseId;
                            }
                        }
                    });
                }
            })
        })

    </script>

    <script type="text/javascript">
        function tp(name) {
            $("#cz").val(name)
        }
        function tps(name) {
            $("#czs").val(name)
        }
    </script>
</head>

<body>
<header>
    %{--<g:form controller="courseInfo" action="add" method="post">--}%
    <div class="nr">
        %{--<h2>填写内容</h2>--}%
        <hr style="width: 95%;margin: 10px auto">
        <div class="tx">
            <!--开始-->
            <div class="kzs">
                <div class="btkz"><label>课程类型</label></div>
                %{--<input name="type" class="inys" id="cz" type="text" value="资源共享课" disabled="disabled">--}%
                <g:textField name="type" value="资源共享课" class="inys" id="cz" disabled="disabled"/>
                <div class="dropdown">
                    <button class="btn btn-success dropdown-toggle" type="button" id="" data-toggle="dropdown">
                        点击选择栏目
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                        <li role="presentation"><a role="menuitem" tabindex="-1" herf="#" onclick="tp('资源共享课');">资源共享课</a></li>
                        <li role="presentation"><a role="menuitem" tabindex="-1" herf="#" onclick="tp('视频公开课');">视频公开课</a></li>
                    </ul>
                </div>
            </div>
            <div style="clear: both"></div>
            <!--=======================-->
            <div class="btkz"><label>所属类别</label></div>
            <input name="category" class="inys" id="czs" type="text" value="文学" disabled="disabled">
            <div class="dropdown">
                <button class="btn btn-success dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown">
                    点击选择栏目
                    <span class="caret"></span>
                </button>
                <ul class="dropdown-menu multi-level" role="menu" aria-labelledby="dropdownMenu">
                    <li class="dropdown-submenu">
                        <a tabindex="-1" href="javascript:;">人文</a>
                        <ul class="dropdown-menu">
                            <li><a tabindex="-1" href="javascript:;" onclick="tps('文学');">文学</a></li>
                            <li><a tabindex="-1" href="javascript:;" onclick="tps('语言');">语言</a></li>
                            <li><a tabindex="-1" href="javascript:;" onclick="tps('哲学');">哲学</a></li>
                            <li><a tabindex="-1" href="javascript:;" onclick="tps('历史');">历史</a></li>
                            <li><a tabindex="-1" href="javascript:;" onclick="tps('宗教');">宗教</a></li>
                            <li><a tabindex="-1" href="javascript:;" onclick="tps('艺术');">艺术</a></li>
                        </ul>
                    </li>
                    <li class="divider"></li><!--分割线-->
                    <li class="dropdown-submenu">
                        <a tabindex="-1" href="javascript:;">社会</a>
                        <ul class="dropdown-menu">
                            <li><a tabindex="-1" href="javascript:;" onclick="tps('经济');">经济</a></li>
                            <li><a tabindex="-1" href="javascript:;" onclick="tps('政治');">政治</a></li>
                            <li><a tabindex="-1" href="javascript:;" onclick="tps('法律');">法律</a></li>
                            <li><a tabindex="-1" href="javascript:;" onclick="tps('地理');">地理</a></li>
                            <li><a tabindex="-1" href="javascript:;" onclick="tps('教育');">教育</a></li>
                            <li><a tabindex="-1" href="javascript:;" onclick="tps('心理');">心理</a></li>
                            <li><a tabindex="-1" href="javascript:;" onclick="tps('管理');">管理</a></li>
                            <li><a tabindex="-1" href="javascript:;" onclick="tps('传播');">传播</a></li>
                            <li><a tabindex="-1" href="javascript:;" onclick="tps('社会');">社会</a></li>
                            <li><a tabindex="-1" href="javascript:;" onclick="tps('演讲');">演讲</a></li>
                        </ul>
                    </li>
                    <li class="divider"></li>
                    <li class="dropdown-submenu">
                        <a tabindex="-1" href="javascript:;">自然</a>
                        <ul class="dropdown-menu">
                            <li><a tabindex="-1" href="javascript:;" onclick="tps('数学');">数学</a></li>
                            <li><a tabindex="-1" href="javascript:;" onclick="tps('物理');">物理</a></li>
                            <li><a tabindex="-1" href="javascript:;" onclick="tps('化学');">化学</a></li>
                            <li><a tabindex="-1" href="javascript:;" onclick="tps('生物');">生物</a></li>
                            <li><a tabindex="-1" href="javascript:;" onclick="tps('地球科学');">地球科学</a></li>
                            <li><a tabindex="-1" href="javascript:;" onclick="tps('计算机');">计算机</a></li>
                            <li><a tabindex="-1" href="javascript:;" onclick="tps('医学');">医学</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
            <div style="clear: both"></div>
            <!--标题-->
            <div class="kzs">
                <div class="btkz"><label>课程名称</label></div>
                <input name="name" class="in" type="text">
                <span class="help-block" style="color:#FF9966">*</span>
            </div>
            <!--<div style="clear: both"></div>-->
            <!--当前时间-->
            <div class="kzs">
                <div class="btkz"><label>创建时间</label></div>
                <input id="tie" class="inys" type="text" value="" disabled="disabled">
            </div>

            <!--操作按钮-->
            <div class="btnn" style="margin-top: 50px">
                    <input id="dl" type="submit" value="下一步" class="sb" style="margin-top: 20px;border: none;background-color:inherit;width: 60%;
        height: 40px;border-radius: 20px;background-color: #2CA368; color: #FFFFFF">
            </div>
        </div>
    </div>
</header>
    %{--</g:form>--}%
%{--<div style="height: 100px"></div>--}%
</body>
</html>