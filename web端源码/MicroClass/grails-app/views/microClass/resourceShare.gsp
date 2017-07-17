<%--
  Created by IntelliJ IDEA.
  User: tong
  Date: 2016/10/30
  Time: 14:14
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>资源共享课</title>
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'resourceShare.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'slick.css')}" type="text/css">
    <g:javascript src="jquery-2.1.3.min.js"/>
    <g:javascript src="slick.min.js"/>
    <g:javascript src="layer/layer.js"/>
    <script type="application/javascript">
        $(document).ready(function() {

            //我的收藏
            $('#myCollection').on('click', function () {
                var whether = $("#whether").val()
//                alert(whether)
                if(whether == ""){
                    alert("请登录");
                    layer.open({
                        offset: '64px',
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

                }else{
                    parent.location = "<g:createLink controller="userInfo" action="collection" />";
                }

            })

            $('#goLogin').on('click', function () {
                layer.open({
                    offset: '64px',
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
                <p>欢迎来到微课平台!</p>
                <input type="hidden" id="whether" value="${session?.userName}">
                <ul>
                    %{--<li class="hides_left"><a href="#" id="goLogin">登录/注册</a></li>--}%
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
                    %{--<li><a href="#" style="color: #2E9057">我的收藏</a></li>--}%
                    <li><a href="#" style="color: #2E9057" id="myCollection">我的收藏</a></li>
                    %{--<li><a href="#">+关注我们</a></li>--}%
                    <li><a href="${resource(dir: 'uploads', file: 'MicroClass_app.apk')}"  target="_blank" style="color: #2E9057">客户端下载</a></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="titles">
        <div class="title">
            <g:img file="bofang.ico" style="width: 40px;height: 40px;" />
            %{--<p>c语言程序设计 第一章 第一讲 绪论</p>--}%
            %{--<p>${userInfo.name}《${courseInfo.name}》公开课</p>--}%
            <p>${courseInfo.name} 第${clazzInfo.orderNum}章 第一讲 ${clazzInfo.name}</p>
        </div>
    </div>
    <!--<div style="clear: both"></div>-->
    <div class="videos">
        <div class="video">
            %{--视频播放--}%
            <video id="video1" controls="controls" width="900px" height="" style="margin-top: 0px;margin-left: 50px">
                <source src="${resource(dir: '',file: videoResource.path)}"/>
            </video>
        </div>
        <div class="next">

            <div class="slider one-time">
                <g:each in="${videoResourceList}" status="i" var="videoResource">
                    <div>
                        <img onclick="playClazz('${videoResource.id}');" src="${resource(dir: '',file: videoResource.preImgPath)}">
                        <p>${videoResource.name}</p>
                    </div>
                </g:each>

            </div>

        </div>
    </div>
</header>
<div class="zys">
    <div class="zy">
        <div class="left">
            <div class="tx">
                <p class="bts">教学主讲人</p>
                <div class="getx">
                    <img style="margin: 10px 10px" src="${resource(dir: '',file:userInfo.image )}" alt="${userInfo.name}" width="130" height="130">

                    <span>${userInfo.name}</span>
                </div>
            </div>
            <div class="js">
                <span class="qwe">第${clazzInfo.orderNum}章 第1讲 ${clazzInfo.name}</span>
                <div style="border-top: 1px dashed #2CA368;margin-top: 20px;"> </div>
                <div class="qq">
                    <span class="cl">本章教学要求</span>
                    %{--<button class="q1">
                    <a href="javascript:void(0);" id="q">更多</a>
                    </button>--}%
                    <button class="q1" style="color: white" onclick="showText('${jieShao.id}')">更多</button>
                    <p class="nr">${jieShao.content}</p>
                </div>
            </div>
            <div class="ddt">
                <h4 style="line-height: 30px;margin-left: 20px;color: white">教学资料</h4>
                <div class="tt">
                    <div class="zz">
                        <p onclick="showText('${teachingPlan.id}')" style="line-height: 160px;text-align: center;font-size: 12px">授课教案</p>
                    </div>
                    <div class="jj">
                        <p onclick="showText('${homework.id}')" style="line-height: 160px;text-align: center;font-size: 12px">作业习题</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="right">
            <div class="unit">
                <p>其他资源</p>
                <div class="yd">
                    <ul>
                        <g:each in="${wordResourceList}" status="i" var="wordResource">
                            <li>
                                <a href="javascript:void(0);" onclick="showText('${wordResource.id}')">${wordResource.name}</a>
                            </li>
                        </g:each>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<div style="clear: both"></div>
<div style="height: 100px"></div>
<div class="login-footer">
    <span class="one">微课平台系统后台</span><br>
    <span>14软件技术毕业设计====滁州职业技术学院</span><br>
    <span>童重远、陈凯旋</span>
</div>
<script type="application/javascript">
    $(document).ready(function(){
        //限制字符个数
        $(".nr").each(function(){
            //字符个数
            var maxwidth=88;
            if($(this).text().length>maxwidth){
                $(this).text($(this).text().substring(0,maxwidth));
                $(this).html($(this).html()+"...");
            }
        });
    });

    function playClazz(id) {
        /*alert("课程id"+id)
        alert("课时id"+clazzId)*/
        parent.location = "<g:createLink controller="microClass" action="playOther" />?id="+id;
    }
    function showText(id) {
        layer.open({
            offset:"10px",
            type: 2,
            title: '',
            shadeClose: true,
            shade: 0.8,
            area: ['70%', '95%'],
            content: ['<g:createLink controller="microClass" action="show2"/>?id='+id, 'no']
        });
    }

    $('.one-time').slick({
        dots: false,
        infinite: false,
        speed: 300,
        slidesToShow: 5,
        touchMove: false,
        slidesToScroll: 1,
    });
</script>
</body>
</html>