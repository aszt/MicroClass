<%--
  Created by IntelliJ IDEA.
  User: tong
  Date: 2016/11/8
  Time: 8:16
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>课程列表</title>
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'bootstrap.min.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'search.css')}" type="text/css">
    <g:javascript src="jquery-2.1.3.min.js"/>
    <g:javascript src="bootstrap.min.js"/>
    <g:javascript src="layer/layer.js"/>
</head>

<body>
<header>
    <div class="top_nav">
        <div class="top_container">
            <ul class="top_left">
                <li><g:link controller="microClass" action="index">网站首页</g:link></li>
            </ul>
            <div class="top_right">
                <p>欢迎来到微课平台!</p>
                <input type="hidden" id="whether" value="${session?.userName}">
                <ul>
                    <g:if test="${session.userName != null}">
                        <li class="hides_left">
                            ${session.userName}
                            <div class="tuichu">
                                <span><g:link controller="userInfo" action="user">▷ 个人中心</g:link></span>
                                <span><g:link controller="userInfo" action="loginOut">▷ 退出登录</g:link></span>
                            </div>
                        </li>
                    </g:if>
                    <g:else>
                        <li class="hides_left"><a href="javascript:void(0);" id="goLogin">登录/注册</a></li>
                    </g:else>
                    <li><a href="#" style="color: #2E9057" id="myCollection">我的收藏</a></li>
                    %{--<li class="gkk"><a href="#">我的收藏</a></li>--}%
                    <li><a href="${resource(dir: 'uploads', file: 'MicroClass_app.apk')}"  target="_blank" style="color: #2E9057">客户端下载</a></li>
                </ul>
            </div>
        </div>
    </div>
</header>
<!--以上是网页头部-->
<div class="main">
    <div class="main_top">
        <g:form controller="microClass" action="search" method="post">
            <input type="text" name="keyWord" placeholder="搜索课程" value="${search}" >
            %{--<span class="sousuo"><g:img file="ss.png" /></span>--}%
            <button type="submit" class="sousuo" style=";">
                <g:img file="ss.png" />
            </button>
        </g:form>
        <p>&nbsp;</p>
    </div>
    <div class="zhuti">
        <h3>全部(<span>${CourseInfoList.size()}</span>)</h3>
        <g:each in="${CourseInfoList}" status="i" var="CourseInfo">
            %{--<div style="border: 1px solid #2CA368"></div>--}%
            <div class="nr">

                <g:if test="${CourseInfo?.type=='视频公开课'}">
                    <g:link controller="microClass" action="play" id="${CourseInfo.id}">
                        <img src="${resource(dir: '',file: CourseInfo.image)}" />
                    %{--<img class="lazy" src="${resource(dir: '',file: literatureInfo.image)}">--}%
                    </g:link>
                </g:if>
                <g:else>
                    <g:link controller="microClass" action="courseDetails" id="${CourseInfo.id}">
                        <img src="${resource(dir: '',file: CourseInfo.image)}" />
                    %{--<img class="lazy" src="${resource(dir: '',file: CourseInfo.image)}">--}%
                    </g:link>
                </g:else>


                %{--<img style="float: left" src="${resource(dir: '',file: CourseInfo.image)}" />--}%
                <div style="float: left;width: 100px">
                    <p>${raw(CourseInfo.name)}</p>
                    <h2 class="zz" style="width: 900px">${raw(CourseInfo.introductionContent)}</h2>
                </div>
            </div>
            <div style="height: 120px"></div>
        </g:each>
    </div>

    <div class="paging" style="width: 1160px;margin: 0 auto;">
        <nav style="width: 400px;float: right">
            <ul class="pagination" style="float: right">
                <page:paginate total="${courseList}" params="${params}"/>
            </ul>
        </nav>
    </div>
</div>
</body>
<script>

    //我的收藏
    $('#myCollection').on('click', function () {
        var whether = $("#whether").val()
//                alert(whether)
        if(whether == ""){
            layer.msg("请登录后查看", function(){
            });
        }else{
            parent.location = "<g:createLink controller="userInfo" action="collection" />";
        }

    })
    //登录
    $('#goLogin').on('click', function () {
        layer.open({
            type: 2,
            title: ['精品课程网', 'text-align: center;font-size:25px'],
            skin: 'demo-class', /*自定义标题颜色*/
            closeBtn: 2, /*关闭按钮风格*/
            shadeClose: true,
            shade: 0.8,
            area: ['650px', '80%'],//小屏幕上正好
//                        area: ['40%', '50%'],//大屏幕上正好
            content: "<g:createLink controller="userInfo" action="loginRegister"/>",
            end: function () {
            }
        });
    });

    $(document).ready(function(){
        //限制字符个数
        $(".zz").each(function(){
            //字符个数
            var maxwidth=180;
            if($(this).text().length>maxwidth){
                $(this).text($(this).html().substring(0,maxwidth));
                $(this).html($(this).html()+"...");
            }
        });
    });


</script>
</html>