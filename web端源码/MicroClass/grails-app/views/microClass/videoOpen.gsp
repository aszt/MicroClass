<%--
  Created by IntelliJ IDEA.
  User: tong
  Date: 2016/10/30
  Time: 14:14
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>视频公开课</title>
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'bootstrap.min.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'videoOpen.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'slick.css')}" type="text/css">
    <g:javascript src="jquery-2.1.3.min.js"/>
    <g:javascript src="slick.min.js"/>
    <g:javascript src="layer/layer.js"/>
    <script type="application/javascript">
        $(document).ready(function() {

            //我的收藏
            $('#myCollection').on('click', function () {
                var whether = $("#whether").val()
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

//                    layer.msg('请登录后查看',{offset: '100px'}, {time: 5000, icon:6,});

//                    layer.msg("请登录后查看",{offset: '200px'}, function(){
//                    });
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
            %{--<img src="../../images/bofang.ico" style="width: 40px;height: 40px;">--}%
            <p>${userInfo.name}《${courseInfo.name}》公开课</p>
        </div>
    </div>
    <!--<div style="clear: both"></div>-->
</header>
<div class="nrs">
    <div class="brr">
        <p><g:link controller="microClass" action="index" class="sy">首页></g:link>${courseInfo.category}</p>
    </div>
    <div class="nr">
        <div class="vd_lefts">
                %{--视频内容--}%
            <div class="vid-wrappper">
                <video id="video1" controls="controls" width="680px" height="" style="margin-top: 40px;margin-left: 10px">
                    <source src="${resource(dir: '',file: videoResource.path)}"/>
                </video>
            </div>
        </div>
        <div class="js_right">
            <div class="right_top">
                <h3 style="color: #2CA368;margin-left: 10px;margin-top: 16px">本讲教师

                    <g:if test="${collectState==1}">
                        <a href="javascript:void(0);" onclick="collection('${courseInfo.id}')" class="shoucan"><i class="glyphicon glyphicon-heart ysc"  ></i></a>
                    </g:if>
                    <g:else>
                        <a href="javascript:void(0);" onclick="collection('${courseInfo.id}')" class="shoucan"><i class="glyphicon glyphicon-heart scc"  ></i></a>
                    </g:else>

                    %{--<a href="javascript:void(0);" onclick="collection('${courseInfo.id}')" class="shoucan"><i name="sc" class="glyphicon glyphicon-heart ysc"  ></i></a>--}%
                    %{--<a href="javascript:void(0);" onclick="collection('${courseInfo.id}')" class="shoucan" ></a>--}%
                </h3>
                <script type="application/javascript">
                    //收藏课程
                    function collection(courseId) {
                        var id = courseId;
                        $.ajax({
                            url:'<g:createLink controller="courseInfo" action="collection" />',
                            type:'post',
                            dataType:'json',
                            data:{
                                courseId:id
                            },
                            success:function(msg){
                                if(msg.state=="200"){
                                    $(".scc").attr("class","glyphicon glyphicon-heart ysc")
                                    layer.msg('收藏成功',{offset: '100px'}, function(){
                                        //关闭后的操作
                                    });
                                }else if(msg.state=="100"){
                                    layer.msg('您还没有登录，请登录',{offset: '100px'}, function(){
                                        layer.open({
                                            offset: '64px',
                                            type: 2,
                                            title: ['精品课程网', 'text-align: center;font-size:25px'],
                                            skin: 'demo-class', /*自定义标题颜色*/
                                            closeBtn: 2, /*关闭按钮风格*/
                                            shadeClose: true,
                                            shade: 0.8,
                                            area: ['650px', '80%'],//小屏幕上正好
                                            content: "<g:createLink controller="userInfo" action="loginRegister"/>",
                                            end: function () {
                                            }
                                        });
                                    });
                                } else if(msg.state=="500"){
                                    $(".ysc").attr("class","glyphicon glyphicon-heart scc")
                                    layer.msg('取消收藏',{offset: '100px'}, function(){
                                        //关闭后的操作
                                    });
                                }
                            }
                        });
                    }
                </script>
                <div class="t_lf">
                    <img src="${resource(dir: '',file:userInfo.image )}" alt="${userInfo.name}"  width="60" height="60" style="border: 1px solid #D0D0D0;padding: 5px;margin: 10px"/>

                    %{--<img style="border: 1px solid #D0D0D0;padding: 5px;margin: 10px" src="../../images/20140527175456a038d.jpg" width="60" height="60">--}%
                </div>
                <div class="n_rg">
                    <p>姓名： ${userInfo.name}</p>
                    <p>职称： ${userInfo.position}</p>
                    <p>学校： ${userInfo.school}</p>
                </div>
                <div style="clear: both"></div>
                %{--<p class="grjj" style="height: 80px">男，1979年1月，教授，博导，上海市浦江人才，荣获中国数学会计算数学分会应用数值代数奖，在国际期刊发表30余篇高质量论文。</p>--}%
                <p class="grjj" style="height: 80px">${userInfo.introduction}</p>
            </div>
            <div style="border: 0.5px solid #2CA368;margin-top: 10px;"></div>
            <div class="right_bottom">
                <h3 style="color: #2CA368;margin-left: 10px;margin-top: 16px">课程推荐词</h3>
                <p class="grjj">${recommend.content}</p>
                <div>
                    <button class="study" onclick="showText('${introduction.id}')" style="color: white">更多</button>
                </div>
            </div>
        </div>
    </div>
    <div class="ks">
        <div class="sc">共${clazzInfoList.size()}讲，当前播放第${clazzInfo.orderNum}讲</div>
        <div style="border: 1px solid #D1D1D1;width: 96%;margin: 20px auto"></div>
        <div class="next">

            <div class="slider one-time">
                <g:each in="${clazzInfoList}" status="i" var="abc">
                    <div>
                        <img onclick="playClazz('${courseInfo.id}','${abc.id}');" src="${resource(dir: '',file: abc.image)}">
                        <p>${abc.name}</p>
                    </div>
                </g:each>
            </div>

        </div>
    </div>
    <div class="kcbj">
        <div class="kcbj_left">
            <div class="zz">
                <p>课程介绍</p>

            </div>
            <div class="contents">
                <p class="kcjs">${introduction.content}</p>

                <button class="studys" onclick="showText('${introduction.id}')" style="color: white">详情</button>
                %{--<p>博弈论是运筹学的一个重要分支，是应用数学方法研究多人决策，在竞争和合作中寻找最优决策的方法。博弈论在经济学、营销学、行为科学、社会学、军事以及生物生存与进化中已有广泛的应用，比如纳什均衡、进化稳定性、信息不对称、逆向选择等。本课程介绍了博弈论的基本知识，以及生活中如果运用博弈论思想来考虑问题，提供了各种游戏以及经济、政治，电影和其他方面的案例来讨论和阐述。</p>--}%
            </div>
        </div>
        <div class="kcbj_right">
            <div class="zzs"><p>本讲介绍</p></div>
            <div class="contents">
                <p class="kcjs">${jieShao.content}</p>
                <button class="studys" onclick="showText('${jieShao.id}')" style="color: white">详情</button>
                %{--<p>博弈论是运筹学的一个重要分支，是应用数学方法研究多人决策，在竞争和合作中寻找最优决策的方法。博弈论在经济学、营销学、行为科学、社会学、军事以及生物生存与进化中已有广泛的应用，比如纳什均衡、进化稳定性、信息不对称、逆向选择等。本课程介绍了博弈论的基本知识，以及生活中如果运用博弈论思想来考虑问题，提供了各种游戏以及经济、政治，电影和其他方面的案例来讨论和阐述。</p>--}%
            </div>
        </div>
    </div>
    <div style="height: 100px"></div>
</div>

<!--<div class="login-footer">
    <span class="one">微课平台系统后台</span><br>
    <span>14软件技术毕业设计====滁州职业技术学院</span><br>
    <span>童重远、陈凯旋</span>
</div>-->
<script type="application/javascript">

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

    function playClazz(id,clazzId) {
        /*alert("课程id"+id)
        alert("课时id"+clazzId)*/
        parent.location = "<g:createLink controller="microClass" action="play" />?id="+id+"&clazzId="+clazzId;
    }

        $('.one-time').slick({
            dots: false,
            infinite: false,
            speed: 300,
            slidesToShow: 5,
            touchMove: false,
            slidesToScroll: 1,
        });

    $(document).ready(function(){
        //限制字符个数
        $(".grjj").each(function(){
            //字符个数
            var maxwidth=100;
            if($(this).text().length>maxwidth){
                $(this).text($(this).text().substring(0,maxwidth));
                $(this).html($(this).html()+"...");
            }
        });

        $(".kcjs").each(function(){
            //字符个数
            var maxwidth=200;
            if($(this).text().length>maxwidth){
                $(this).text($(this).text().substring(0,maxwidth));
                $(this).html($(this).html()+"...");
            }
        });


    });

</script>
</body>
</html>