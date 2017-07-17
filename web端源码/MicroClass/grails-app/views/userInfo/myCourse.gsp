<%--
  Created by IntelliJ IDEA.
  User: tong
  Date: 2016/10/25
  Time: 12:44
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>我的课程</title>
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'bootstrap.min.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'myCourse.css')}" type="text/css">
    <g:javascript src="jquery-2.1.3.min.js"/>
    <g:javascript src="bootstrap.min.js"/>
    <g:javascript src="layer/layer.js"/>

    <script type="text/javascript">

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

            //弹窗
            $('#create_clazz').on('click', function () {
                layer.open({
                    type: 2,
                    title: ['创建课程', 'font-size:25px;text-align: center;'],
                    skin: 'demo-class',/*自定义标题颜色*/
                    closeBtn:1,/*关闭按钮风格*/
                    shadeClose: true,
                    shade: 0.8,
                    area: ['52%', '77%'],
                    content: "<g:createLink controller="courseInfo" action="createClazz"/>",
                    end: function(){
                    }
                });
            });

//            查询
            $('#find').on('click', function () {
                var category = $("#czs").val();
                var title = $("#title").val();
                parent.location = "<g:createLink controller="userInfo" action="myCourse" />?title="+title+"&category="+category;
            });

        })

    </script>

    <script type="text/javascript">
        function tps(name) {
            $("#czs").val(name)
        }
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
                    <li class="hides_left"><img class="top_tx" src="${resource(dir: '',file:userInfo.image)}" style="width: 40px;height: 40px"></li>
                    <li class="hides_left"><a href="#" id="goLogin">${userInfo.name}</a></li>
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
        <div class="left" style="position: fixed;">
            <ul>
                <li onclick="info();" class="djs"><i class="glyphicon glyphicon-user"></i>
                    <g:link controller="userInfo" action="user">个人信息</g:link>
                </li>
                <li onclick="clazz();" class="dj"><i class="glyphicon glyphicon-align-right"></i>
                    <g:link controller="userInfo" action="myCourse">我的课程</g:link>
                </li>
                <li onclick="clazz();" class="djs"><i class="glyphicon glyphicon-heart"></i>
                    <g:link controller="userInfo" action="collection">我的收藏</g:link>
                </li>
            </ul>
        </div>
        <!--我的课程页面开始-->
        <div class="right" id="clazz" style="float: right">
            <div class="bt">
                <a class="lj" href="../">主页 > </a>
                <a href="#">我的课程</a>
            </div>
            <div class="kcc">
                <div class="xxk">
                    <label>类别</label>
                    <g:if test="${category==null}">
                        <input class="inys" id="czs" type="text" value="全部" disabled="disabled">
                    </g:if>
                    <g:else>
                        <input class="inys" id="czs" type="text" value="${category}" disabled="disabled">
                    </g:else>
                    %{--<input class="inys" id="czs" type="text" value="${category}" disabled="disabled">--}%
                    <div class="dropdown">
                        <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown">
                            点击选择栏目
                            <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu multi-level" role="menu" aria-labelledby="dropdownMenu">
                            <li><a tabindex="-1" href="javascript:;" onclick="tps('全部');">全部</a></li>
                            <li class="divider"></li><!--分割线-->
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
                    <!--下拉菜单结束-->
                    <div class="find">
                        <input id="title" class="form-control" name="title" value="${title}" placeholder="按标题查询" type="text">
                    </div>
                    <div class="df">
                        <button class="btn btn-default" id="find">
                            <span class="glyphicon glyphicon-search"></span>
                            点击查询
                        </button>
                    </div>
                    <span class="sv">
                        <a class="btn btn-default " href="#" id="create_clazz">
                            <span class="glyphicon glyphicon-plus"></span>
                            创建课程
                        </a>
                    </span>
                    <!--查询栏内容止-->
                    <!--<div style="clear: none"></div>-->
                </div>
                <!--课程列表展示=====================-->
                <div class="clazz_list">
                %{--遍历课程列表--}%
                    <g:each in="${courseInfoList}" status="i" var="courseInfoInstance">
                        <div class="p_show">
                            <img title="修改课程" src="${resource(dir: '',file: courseInfoInstance.image)}" style="width: 240px;height: 150px;border: 0px solid #2CA368" onclick="updateCourse('${courseInfoInstance.id}');">
                            <p class="tsy">${courseInfoInstance.name}</p>
                            %{--<i class="glyphicon glyphicon-trash" title="删除"></i>--}%
                            <p class="text-center">
                                <a class="btn btn-default btn-xs" href="javascript:void(0);"  title="查看课时" onclick="seeClazz('${courseInfoInstance.id}');">
                                    <i class="fa fa-edit"></i>
                                    查看课时
                                </a>
                                <a class="btn btn-danger btn-xs" href="javascript:void(0)" title="删除" onclick="delCourse('${courseInfoInstance.id}')">
                                    <i class=" fa fa-trash-o fa-fw"></i>
                                    删除
                                </a>
                            </p>
                            %{--<span>
                                <i class="glyphicon glyphicon-trash" title="删除"></i>
                                <i class="glyphicon glyphicon-search" title="查看课时" onclick="seeClazz('${courseInfoInstance.id}');"></i>
                            </span>--}%
                        </div>
                    </g:each>


                    <script>
                        //添加课时
                        function goSave(courseId) {
                            parent.location = "<g:createLink controller="classPeriodInfo" action="saveClassHour" />?id="+courseId;
                        }
                        //编辑课程信息
                        function updateCourse(courseId) {
                            %{--parent.location = "<g:createLink controller="courseInfo" action="test" />?id="+courseId;--}%
                                parent.location = "<g:createLink controller="courseInfo" action="perfectClazz" />?id="+courseId;
                        }
                        //查看课程列表
                        function seeClazz(courseId) {
                            parent.location = "<g:createLink controller="classPeriodInfo" action="seeClazzList" />?id="+courseId;
                        }
                        //删除课程
                        function delCourse(courseId) {
                            parent.location = "<g:createLink controller="courseInfo" action="delCourse" />?courseId="+courseId;
                        }
                    </script>
                    <!--分页-->

                </div>
                <div class="paging">
                    <nav>
                        <ul class="pagination">
                            <page:paginate total="${courseInstanceTotal}" params="${params}"/>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
        <!--我的课程页面结束-->
    </div>
</div>
%{--<div style="height: 660px"></div>--}%
%{--<div class="login-footer">--}%
%{--<span class="one">微课平台系统后台</span><br>--}%
%{--<span>14软件技术毕业设计====滁州职业技术学院</span><br>--}%
%{--<span>童重远、陈凯旋</span>--}%
%{--</div>--}%
</body>
</html>