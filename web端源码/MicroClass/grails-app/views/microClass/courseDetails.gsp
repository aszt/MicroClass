<%--
  Created by IntelliJ IDEA.
  User: tong
  Date: 2016/10/30
  Time: 14:06
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>课程详情</title>
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'bootstrap.min.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'courseDetails.css')}" type="text/css">
    <g:javascript src="jquery-2.1.3.min.js"/>
    <g:javascript src="layer/layer.js"/>

%{--pdf.js--}%
    %{--<link rel="stylesheet" href="${resource(dir: 'css',file: 'textshow.css')}" type="text/css">--}%
    <link href="${resource(dir: 'css', file: 'viewer.css')}" rel="stylesheet">
    <g:javascript src="compatibility.js"/>
    <link href="${resource(dir: 'locale', file: 'locale.properties')}" rel="resource" type="application/l10n">
    <g:javascript src="l10n.js"/>
    <g:javascript src="build/pdf.js"/>
    <g:javascript src="debugger.js"/>
    <g:javascript src="viewer.js"/>

    <script type="application/javascript">
        $(document).ready(function() {

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
                %{--<li class="hides_left"><a href="javascript:void(0);" id="goLogin">登录/注册</a></li>--}%
                <li><a href="#" style="color: #2E9057" id="myCollection">我的收藏</a></li>
                %{--<li><a href="#">+关注我们</a></li>--}%
                <li><a href="${resource(dir: 'uploads', file: 'MicroClass_app.apk')}"  target="_blank" style="color: #2E9057">客户端下载</a></li>
            </ul>
        </div>
    </div>
</div>
    <div class="dh">
        <div class="nr">
            %{--<a href="#" class="size">${courseInfo.type}></a>--}%
            %{--<a href="" class="size">首页></a>--}%
            <g:link controller="microClass" action="index" class="size">首页></g:link>
            ${userInfo.school}公开课：${userInfo.name}
        </div>
    </div>
    <div class="bgp">
            <div class="zt">
                <img class="zuo" src="${resource(dir: '',file: courseInfo.image)}" alt="${courseInfo.name}" width="380" height="285">
                <div class="you">
                    <h2>${courseInfo.name}</h2>
                    <br>
                    <p>课程介绍</p>
                    <p id="courseJJ">${introduction.content}</p>
                    <b></b>

                </div>
                <g:if test="${collectState==1}">
                    <a href="javascript:void(0);" onclick="collection('${courseInfo.id}')" class="shoucan"><i class="glyphicon glyphicon-heart ysc"  ></i></a>
                </g:if>
                <g:else>
                    <a href="javascript:void(0);" onclick="collection('${courseInfo.id}')" class="shoucan"><i class="glyphicon glyphicon-heart sc"  ></i></a>
                </g:else>


                <g:link controller="microClass" action="play" id="${courseInfo.id}" style="color: white"><button class="study" id="col">开始学习</button></g:link>
            </div>
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
                                $(".sc").attr("class","glyphicon glyphicon-heart ysc")
                               //window.getElementByName("sc").setAttribute("class", "glyphicon glyphicon-heart ysc");
                                layer.msg('收藏成功', function(){
                                    //关闭后的操作
                                });
                            }else if(msg.state=="100"){
                                layer.msg('您还没有登录，请登录', function(){
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

                                $(".ysc").attr("class","glyphicon glyphicon-heart sc")
                                layer.msg('取消收藏', function(){
                                    //关闭后的操作
                                });
                            }
                        }
                    });
                }
            </script>
    </div>
</header>
<div class="contents">
<div class="bgnr">
    <div class="content">
        <table>
            <tr>
                <td>课程名称：${courseInfo.name}</td>
                <td>课程学时：${clazzInfoList.size()}</td>
            </tr>
            <tr>
                <td>所属学校：${userInfo.school}</td>
                <td>学科门类：自然</td>
            </tr>
            <tr>
                <td>负责人：${userInfo.name}</td>
                <td>专业类：${courseInfo.category}类</td>
            </tr>

            <tr>
                <td>课程属性：${courseInfo.type}</td>
                <td></td>
            </tr>
        </table>
    </div>
    <div class="kcjs">
        <p class="bt">课程介绍</p>
        <p class="nr">${introduction.content}</p>
        <button class="gd" onclick="showText('${introduction.id}')" style="color: white;">详情</button>
        <!--<div style="clear: none"></div>-->
        <div class="dg">
            <div class="t1">
                <div style="border: 1px solid #DDDDDD;width: 103px;height: 80px">
                    <img onclick="showText('${introduction.id}')" src="${resource(dir: '',file: introduction.preImgPath)}" style="width: 93px;height: 71px;padding: 5px">
                </div>
                <span>课程介绍</span>
            </div>
            <div class="t1">
                <div style="border: 1px solid #DDDDDD;width: 103px;height: 80px">
                    <img onclick="showText('${program.id}')" src="${resource(dir: '',file: program.preImgPath)}" style="width: 93px;height: 71px;padding: 5px">
                </div>
                <span>教学大纲</span>
            </div>
            <div class="t1">
                <div style="border: 1px solid #DDDDDD;width: 103px;height: 80px">
                    <img onclick="showText('${guidance.id}')" src="${resource(dir: '',file: guidance.preImgPath)}" style="width: 93px;height: 71px;padding: 5px">
                </div>
                <span>实践指导</span>
            </div>
            <div class="t1">
                <div style="border: 1px solid #DDDDDD;width: 103px;height: 80px">
                    <img onclick="showText('${teachingMaterial.id}')" src="${resource(dir: '',file: teachingMaterial.preImgPath)}" style="width: 93px;height: 71px;padding: 5px">
                </div>
                <span>指定教材</span>
            </div>
            <div class="t1">
                <div style="border: 1px solid #DDDDDD;width: 103px;height: 80px">
                    <img onclick="showText('${referenceDoc.id}')" src="${resource(dir: '',file: referenceDoc.preImgPath)}" style="width: 93px;height: 71px;padding: 5px">
                </div>
                <span>参考文献</span>
            </div>
            <div class="t1">
                <div style="border: 1px solid #DDDDDD;width: 103px;height: 80px">
                    <img onclick="showText('${declarationForm.id}')" src="${resource(dir: '',file: declarationForm.preImgPath)}" style="width: 93px;height: 71px;padding: 5px">
                </div>
                <span>申报表</span>
            </div>
        </div>
    </div>
    <div style="clear: both"></div>
    <div class="captain">
        <div class="unit">
            <p>教学单元</p>
            <div class="yd">
            <ul>
                <g:each in="${clazzInfoList}" status="i" var="clazzInfoInstance">
                    <li>
                        <a href="javascript:void(0);" onclick="playClazz('${courseInfo.id}','${clazzInfoInstance.id}')">第${clazzInfoInstance.orderNum}章 ${clazzInfoInstance.name}</a>
                    </li>
                </g:each>
            </ul>
            </div>
        </div>
        <div class="fing">
            <p class="bts">课程负责人</p>
            <div class="getx">
                <img style="margin: 10px 10px" src="${resource(dir: '',file:userInfo.image )}" alt="${userInfo.name}" width="200" height="200">
                <span>${userInfo.name}</span>
            </div>
            <div class="grjj" style="float: left;width: 320px;height: 220px">
                <p>${userInfo.introduction}</p>
                %{--<p>苏小红，女，博士，哈尔滨工业大学计算机科学与技术学院航天软件工程研究中心教授，博士生导师，中国计算机学会高级会员，计算机科学与技术国家实验教学示范中心副主任，计算机语言基础教研室主任，校教学带头人，校级教学名师奖和宝钢优秀教师奖获得者，2006-2010年教育部高等学校计算机专业教学指导委员会东北地区专家工作组成员，电子工业出版社特聘专家。曾先后被评为校“三育人”先进工作者、校优秀教师、校优秀共产党员、黑龙江省高校师德先进个人，黑龙江省优秀教师。现为国家级精品课、国家精品资源共享课程“C语言程序设计”和黑龙江省省级精品课...</p>--}%
                %{--字符数展示控制没写--}%
                %{--<p>${userInfo.introduction}</p>--}%
            </div>
            %{--<button class="q1"><a href="#" id="q">更多信息</a></button>--}%
            %{--<button class="q2"><a href="#" id="w">教学团队</a></button>--}%
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
</body>
<script>
    $(document).ready(function(){
        //限制字符个数
        $(".nr").each(function(){
            //字符个数
            var maxwidth=110;
            if($(this).text().length>maxwidth){
                $(this).text($(this).text().substring(0,maxwidth));
                $(this).html($(this).html()+"...");
            }
        });

        //课程介绍
        $("#courseJJ").each(function(){
            //字符个数
            var maxwidth=180;
            if($(this).text().length>maxwidth){
                $(this).text($(this).text().substring(0,maxwidth));
                $(this).html($(this).html()+"...");
            }
        });

    });
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
//        打开新标签页
        window.open("<g:createLink controller="microClass" action="play" />?id="+id+"&clazzId="+clazzId);
        %{--parent.location = "<g:createLink controller="microClass" action="play" />?id="+id+"&clazzId="+clazzId;--}%
    }
</script>
</html>