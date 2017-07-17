<!DOCTYPE html>
<html>
	<head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
        %{--<meta name="layout" content="main"/>--}%
        <title>精品课程网络平台首页</title>
        %{--<link rel="stylesheet" href="${resource(dir: 'css',file: 'bootstrap.min.css')}" type="text/css">--}%
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'mains.css')}" type="text/css">
        <g:javascript src="jquery-2.1.3.min.js"/>
        %{--<g:javascript src="bootstrap.min.js"/>--}%
        <g:javascript src="layer/layer.js"/>
        <script>
            $(document).ready(function () {
                //弹出一个页面层
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

                function aa(menu) {
                    menu.getElementsByTagName("ul")[0].style.display = "block";
                }

                function bb(menu) {
                    menu.getElementsByTagName("ul")[0].style.display = "none";
                }

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

                <p>欢迎来到精品课程网!</p>
                <input type="hidden" id="whether" value="${session?.userName}">
                <ul>
                    %{--<li><a href="#" style="color: #2E9057">微课首页</a></li>--}%
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
                    %{--<li><a href="#" style="color: #2E9057">我的收藏</a></li>--}%
                    %{--<li><a href="#">+关注我们</a></li>--}%
                    <li><a href="${resource(dir: 'uploads', file: 'MicroClass_app.apk')}"  target="_blank" style="color: #2E9057">客户端下载</a></li>
                </ul>
            </div>
        </div>
    </div>
    <section>
        <img src="images/logo_big3.png">

        <g:form controller="microClass" action="search" method="post">
            <input id="search" class="inputxt" name="keyWord" type="text" placeholder="搜索课程、视频、公开课策划">
            <input id="search_btn" class="subbtn" value="" type="submit">
        </g:form>
    </section>
</header>
<nav>
    <div class="navigation">
        <ul>
            <li><a href="#">首页</a></li>
            <li><g:link controller="microClass" action="typeFind" params="[type:'视频公开课']">视频公开课</g:link></li>
            <li><g:link controller="microClass" action="typeFind" params="[type:'资源共享课']">资源共享课</g:link></li>
            %{--<li><a href="#">中国大学MOCC</a></li>
            <li><a href="#">中国职教MOCC</a></li>
            <li><a href="#">在线课程中心</a></li>
            <li><a href="#">学习社区</a></li>--}%
        </ul>
    </div>
</nav>
<!--幻灯片轮播开始-->
<div id="box">
    <ul class="big_img">

        <g:each in="${courseLunboList}" status="i" var="courseLunbo">
            <li>

                <g:if test="${courseLunbo?.type=='视频公开课'}">
                    <g:link controller="microClass" action="play" id="${courseLunbo.id}" style="text-decoration: none">
                        %{--<span class="ltxt" >${courseLunbo.name}</span>--}%
                        <img class="IMG" src="${resource(dir: '', file: courseLunbo.image)}" >
                    </g:link>
                </g:if>
                <g:else>
                    <g:link controller="microClass" action="courseDetails" id="${courseLunbo.id}" style="text-decoration: none">
                        %{--<span class="ltxt">${courseLunbo.name}</span>--}%
                        <img class="IMG" src="${resource(dir: '', file: courseLunbo.image)}">
                    </g:link>
                </g:else>

                %{--<a href=""><img class="IMG" src="${resource(dir: '', file: courseLunbo.image)}"></a>--}%
                <div class="txt">
                    <div class="tag"><img src="images/sk.png"></div>

                    <h1>${courseLunbo.name}</h1>

                    <p></p>
                </div>
            </li>
        </g:each>

    </ul>

    <div class="niebu">
        <ul class="slider_list">
            <g:each in="${courseLunboList}" status="i" var="courseLunbo">
                <li index='${i+1}'><a><img src="${resource(dir: '', file: courseLunbo.image)}" style="width: 70px;height: 45px"></a></li>
            </g:each>
        </ul>

        <!--推荐排行==============-->
        <section>
            <ul class="tab_top">
                <li class="active rm">热门排行</li>
                <li class="zx">最新课程</li>
				</ul>

            <div class="s_right">
                <div>
                    <ul>
                        <g:each in="${countCourseList}" status="i" var="countCourse">
                            <li>
                                <g:if test="${i<3}">
                                    <i class="icon icon2">${i+1}</i>
                                </g:if>
                                <g:else>
                                    <i class="icon">${i+1}</i>
                                </g:else>

                                <g:if test="${countCourse?.type=='视频公开课'}">
                                    <g:link controller="microClass" action="play" id="${countCourse.id}" style="text-decoration: none">
                                        <span class="ltxt" >${countCourse.name}</span>
                                    </g:link>
                                </g:if>
                                <g:else>
                                    <g:link controller="microClass" action="courseDetails" id="${countCourse.id}" style="text-decoration: none">
                                        <span class="ltxt">${countCourse.name}</span>
                                    </g:link>
                                </g:else>

                            </li>
                        </g:each>
                    </ul>
                </div>

                <div class="hides" style="display: none">
                    <ul>
                        <g:each in="${newCourseList}" status="i" var="newCourse">
                        <li>
                            <g:if test="${i<3}">
                                <i class="icon icon2">${i+1}</i>
                            </g:if>
                            <g:else>
                                <i class="icon">${i+1}</i>
                            </g:else>

                            <g:if test="${newCourse?.type=='视频公开课'}">
                                <g:link controller="microClass" action="play" id="${newCourse.id}" style="text-decoration: none">
                                    <span class="ltxt" >${newCourse.name}</span>
                                </g:link>
                            </g:if>
                            <g:else>
                                <g:link controller="microClass" action="courseDetails" id="${newCourse.id}" style="text-decoration: none">
                                    <span class="ltxt">${newCourse.name}</span>
                                </g:link>
                            </g:else>

                        </li>
                        </g:each>
                    </ul>
                </div>
            </div>
        </section>
		</div>

</div>

<div style="height: 420px"></div>
<!--不知道为什么少这么多高度-->
<!--幻灯片轮播结束-->
<div class="top" id="tcy">
    <div>
        <div class="yuan">人文</div>
        <ul>
            <li><a href="#literature">文学</a></li>
            <li><a href="#language">语言</a></li>
            <li><a href="#philosophy">哲学</a></li>
            <li><a href="#history">历史</a></li>
            <li><a href="#religion">宗教</a></li>
            <li><a href="#art">艺术</a></li>
        </ul>

        <div class="yuan">社会</div>
        <ul class="shehui">
            <li><a href="#economics">经济</a></li>
            <li><a href="#politics">政治</a></li>
            <li><a href="#law">法律</a></li>
            <li><a href="#geography">地理</a></li>
            <li><a href="#education">教育</a></li>
            <li><a href="#psychology">心理</a></li>
            <li><a href="#management">管理</a></li>
            <li><a href="#media">传播</a></li>
            <li><a href="#sociology">社会</a></li>
            <li><a href="#speech">演讲</a></li>
        </ul>

        <div class="yuan">自然</div>
        <ul class="ziran">
            <li><a href="#mathematics">数学</a></li>
            <li><a href="#physics">物理</a></li>
            <li><a href="#chemistry">化学</a></li>
            <li><a href="#biology">生物</a></li>
            <li><a href="#geoscience">地球科学</a></li>
            <li><a href="#computer">计算机</a></li>
            <li><a href="#medicine">医学</a></li>
        </ul>
    </div>
</div>

<div class="main">
    <div class="clear"></div>
    <!--以上是小编推荐-->
    <div class="clear"></div>
    <p id="literature"></p>
    <div class="TED Style">
        <section >
            <div class="last_one" >
                <h1>文学</h1>
                <p>literature</p>
            </div>

            <g:each in="${literature}" status="i" var="literatureInfo">
                <div>
                    <span class="Imgxz">
                        <g:if test="${literatureInfo?.type=='视频公开课'}">
                            <g:link controller="microClass" action="play" id="${literatureInfo.id}">
                                <img class="lazy" src="${resource(dir: '',file: literatureInfo.image)}">
                            </g:link>
                        </g:if>
                        <g:else>
                            <g:link controller="microClass" action="courseDetails" id="${literatureInfo.id}">
                                <img class="lazy" src="${resource(dir: '',file: literatureInfo.image)}">
                            </g:link>
                        </g:else>
                    </span>
                    <h2>${literatureInfo.name}</h2>
                </div>
            </g:each>

        </section>
        <div class="clear"></div>

        <p id="language"></p>
    %{--语言--}%
        <section >
            <div class="last_one" >
                <h1>语言</h1>
                <p>language</p>
            </div>

            <g:each in="${language}" status="i" var="languageInfo">
            <div>
                <span class="Imgxz">
                    <g:if test="${languageInfo?.type=='视频公开课'}">
                        <g:link controller="microClass" action="play" id="${languageInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: languageInfo.image)}">
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:link controller="microClass" action="courseDetails" id="${languageInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: languageInfo.image)}">
                        </g:link>
                    </g:else>
                </span>
                <h2>${languageInfo.name}</h2>
            </div>
            </g:each>

        </section>
        <div class="clear"></div>


    %{--哲学--}%
        <p id="philosophy"></p>
    <section >
        <div class="last_one" >
            <h1>哲学</h1>
            <p>philosophy</p>
        </div>

        <g:each in="${philosophy}" status="i" var="philosophyInfo">
            <div>
                <span class="Imgxz">
                    <g:if test="${philosophyInfo?.type=='视频公开课'}">
                        <g:link controller="microClass" action="play" id="${philosophyInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: philosophyInfo.image)}">
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:link controller="microClass" action="courseDetails" id="${philosophyInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: philosophyInfo.image)}">
                        </g:link>
                    </g:else>
                </span>
                <h2>${philosophyInfo.name}</h2>
            </div>
        </g:each>

    </section>
    <div class="clear"></div>


    %{--历史--}%
        <p id="history"></p>
    <section >
        <div class="last_one" >
            <h1>历史</h1>
            <p>history</p>
        </div>

        <g:each in="${history}" status="i" var="historyInfo">
            <div>
                <span class="Imgxz">
                    <g:if test="${historyInfo?.type=='视频公开课'}">
                        <g:link controller="microClass" action="play" id="${historyInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: historyInfo.image)}">
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:link controller="microClass" action="courseDetails" id="${historyInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: historyInfo.image)}">
                        </g:link>
                    </g:else>
                </span>
                <h2>${historyInfo.name}</h2>
            </div>
        </g:each>

    </section>
    <div class="clear"></div>

    %{--宗教--}%
        <p id="religion"></p>
    <section >
        <div class="last_one" >
            <h1>宗教</h1>
            <p>religion</p>
        </div>

        <g:each in="${religion}" status="i" var="religionInfo">
            <div>
                <span class="Imgxz">
                    <g:if test="${religionInfo?.type=='视频公开课'}">
                        <g:link controller="microClass" action="play" id="${religionInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: religionInfo.image)}">
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:link controller="microClass" action="courseDetails" id="${religionInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: religionInfo.image)}">
                        </g:link>
                    </g:else>
                </span>
                <h2>${religionInfo.name}</h2>
            </div>
        </g:each>

    </section>
    <div class="clear"></div>

    %{--艺术--}%
        <p id="art"></p>
    <section >
        <div class="last_one" >
            <h1>艺术</h1>
            <p>art</p>
        </div>

        <g:each in="${art}" status="i" var="artInfo">
            <div>
                <span class="Imgxz">
                    <g:if test="${artInfo?.type=='视频公开课'}">
                        <g:link controller="microClass" action="play" id="${artInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: artInfo.image)}">
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:link controller="microClass" action="courseDetails" id="${artInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: artInfo.image)}">
                        </g:link>
                    </g:else>
                </span>
                <h2>${artInfo.name}</h2>
            </div>
        </g:each>

    </section>
    <div class="clear"></div>

    %{--经济--}%
        <p id="economics"></p>
    <section >
        <div class="last_one" >
            <h1>经济</h1>
            <p>economics</p>
        </div>

        <g:each in="${economics}" status="i" var="economicsInfo">
            <div>
                <span class="Imgxz">
                    <g:if test="${economicsInfo?.type=='视频公开课'}">
                        <g:link controller="microClass" action="play" id="${economicsInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: economicsInfo.image)}">
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:link controller="microClass" action="courseDetails" id="${economicsInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: economicsInfo.image)}">
                        </g:link>
                    </g:else>
                </span>
                <h2>${economicsInfo.name}</h2>
            </div>
        </g:each>

    </section>
    <div class="clear"></div>

    %{--政治--}%
        <p id="politics"></p>
    <section >
        <div class="last_one" >
            <h1>政治</h1>
            <p>politics</p>
        </div>

        <g:each in="${politics}" status="i" var="politicsInfo">
            <div>
                <span class="Imgxz">
                    <g:if test="${politicsInfo?.type=='视频公开课'}">
                        <g:link controller="microClass" action="play" id="${politicsInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: politicsInfo.image)}">
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:link controller="microClass" action="courseDetails" id="${politicsInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: politicsInfo.image)}">
                        </g:link>
                    </g:else>
                </span>
                <h2>${politicsInfo.name}</h2>
            </div>
        </g:each>

    </section>
    <div class="clear"></div>

    %{--法律--}%
        <p id="law"></p>
    <section >
        <div class="last_one" >
            <h1>法律</h1>
            <p>law</p>
        </div>

        <g:each in="${law}" status="i" var="lawInfo">
            <div>
                <span class="Imgxz">
                    <g:if test="${lawInfo?.type=='视频公开课'}">
                        <g:link controller="microClass" action="play" id="${lawInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: lawInfo.image)}">
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:link controller="microClass" action="courseDetails" id="${lawInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: lawInfo.image)}">
                        </g:link>
                    </g:else>
                </span>
                <h2>${lawInfo.name}</h2>
            </div>
        </g:each>

    </section>
    <div class="clear"></div>

    %{--地理--}%
        <p id="geography"></p>
    <section >
        <div class="last_one" >
            <h1>地理</h1>
            <p>geography</p>
        </div>

        <g:each in="${geography}" status="i" var="geographyInfo">
            <div>
                <span class="Imgxz">
                    <g:if test="${geographyInfo?.type=='视频公开课'}">
                        <g:link controller="microClass" action="play" id="${geographyInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: geographyInfo.image)}">
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:link controller="microClass" action="courseDetails" id="${geographyInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: geographyInfo.image)}">
                        </g:link>
                    </g:else>
                </span>
                <h2>${geographyInfo.name}</h2>
            </div>
        </g:each>

    </section>
    <div class="clear"></div>

    %{--教育--}%
        <p id="education"></p>
    <section >
        <div class="last_one" >
            <h1>教育</h1>
            <p>education</p>
        </div>

        <g:each in="${education}" status="i" var="educationInfo">
            <div>
                <span class="Imgxz">
                    <g:if test="${educationInfo?.type=='视频公开课'}">
                        <g:link controller="microClass" action="play" id="${educationInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: educationInfo.image)}">
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:link controller="microClass" action="courseDetails" id="${educationInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: educationInfo.image)}">
                        </g:link>
                    </g:else>
                </span>
                <h2>${educationInfo.name}</h2>
            </div>
        </g:each>

    </section>
    <div class="clear"></div>

    %{--心理--}%
        <p id="psychology"></p>
    <section >
        <div class="last_one" >
            <h1>心理</h1>
            <p>psychology</p>
        </div>

        <g:each in="${psychology}" status="i" var="psychologyInfo">
            <div>
                <span class="Imgxz">
                    <g:if test="${psychologyInfo?.type=='视频公开课'}">
                        <g:link controller="microClass" action="play" id="${psychologyInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: psychologyInfo.image)}">
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:link controller="microClass" action="courseDetails" id="${psychologyInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: psychologyInfo.image)}">
                        </g:link>
                    </g:else>
                </span>
                <h2>${psychologyInfo.name}</h2>
            </div>
        </g:each>

    </section>
    <div class="clear"></div>

    %{--管理--}%
        <p id="management"></p>
    <section >
        <div class="last_one" >
            <h1>管理</h1>
            <p>management</p>
        </div>

        <g:each in="${management}" status="i" var="managementInfo">
            <div>
                <span class="Imgxz">
                    <g:if test="${managementInfo?.type=='视频公开课'}">
                        <g:link controller="microClass" action="play" id="${managementInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: managementInfo.image)}">
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:link controller="microClass" action="courseDetails" id="${managementInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: managementInfo.image)}">
                        </g:link>
                    </g:else>
                </span>
                <h2>${managementInfo.name}</h2>
            </div>
        </g:each>

    </section>
    <div class="clear"></div>

    %{--传播--}%
        <p id="media"></p>
    <section >
        <div class="last_one" >
            <h1>传播</h1>
            <p>media</p>
        </div>

        <g:each in="${media}" status="i" var="mediaInfo">
            <div>
                <span class="Imgxz">
                    <g:if test="${mediaInfo?.type=='视频公开课'}">
                        <g:link controller="microClass" action="play" id="${mediaInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: mediaInfo.image)}">
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:link controller="microClass" action="courseDetails" id="${mediaInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: mediaInfo.image)}">
                        </g:link>
                    </g:else>
                </span>
                <h2>${mediaInfo.name}</h2>
            </div>
        </g:each>

    </section>
    <div class="clear"></div>

    %{--社会--}%
        <p id="sociology"></p>
    <section >
        <div class="last_one" >
            <h1>社会</h1>
            <p>sociology</p>
        </div>

        <g:each in="${sociology}" status="i" var="sociologyInfo">
            <div>
                <span class="Imgxz">
                    <g:if test="${sociologyInfo?.type=='视频公开课'}">
                        <g:link controller="microClass" action="play" id="${sociologyInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: sociologyInfo.image)}">
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:link controller="microClass" action="courseDetails" id="${sociologyInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: sociologyInfo.image)}">
                        </g:link>
                    </g:else>
                </span>
                <h2>${sociologyInfo.name}</h2>
            </div>
        </g:each>

    </section>
    <div class="clear"></div>

    %{--演讲--}%
        <p id="speech"></p>
    <section >
        <div class="last_one" >
            <h1>演讲</h1>
            <p>speech</p>
        </div>

        <g:each in="${speech}" status="i" var="speechInfo">
            <div>
                <span class="Imgxz">
                    <g:if test="${speechInfo?.type=='视频公开课'}">
                        <g:link controller="microClass" action="play" id="${speechInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: speechInfo.image)}">
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:link controller="microClass" action="courseDetails" id="${speechInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: speechInfo.image)}">
                        </g:link>
                    </g:else>
                </span>
                <h2>${speechInfo.name}</h2>
            </div>
        </g:each>

    </section>
    <div class="clear"></div>

    %{--数学--}%
        <p id="mathematics"></p>
    <section >
        <div class="last_one" >
            <h1>数学</h1>
            <p>mathematics</p>
        </div>

        <g:each in="${mathematics}" status="i" var="mathematicsInfo">
            <div>
                <span class="Imgxz">
                    <g:if test="${mathematicsInfo?.type=='视频公开课'}">
                        <g:link controller="microClass" action="play" id="${mathematicsInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: mathematicsInfo.image)}">
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:link controller="microClass" action="courseDetails" id="${mathematicsInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: mathematicsInfo.image)}">
                        </g:link>
                    </g:else>
                </span>
                <h2>${mathematicsInfo.name}</h2>
            </div>
        </g:each>

    </section>
    <div class="clear"></div>

    %{--物理--}%
        <p id="physics"></p>
    <section >
        <div class="last_one" >
            <h1>物理</h1>
            <p>physics</p>
        </div>

        <g:each in="${physics}" status="i" var="physicsInfo">
            <div>
                <span class="Imgxz">
                    <g:if test="${physicsInfo?.type=='视频公开课'}">
                        <g:link controller="microClass" action="play" id="${physicsInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: physicsInfo.image)}">
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:link controller="microClass" action="courseDetails" id="${physicsInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: physicsInfo.image)}">
                        </g:link>
                    </g:else>
                </span>
                <h2>${physicsInfo.name}</h2>
            </div>
        </g:each>

    </section>
    <div class="clear"></div>

    %{--化学--}%
        <p id="chemistry"></p>
    <section >
        <div class="last_one" >
            <h1>化学</h1>
            <p>chemistry</p>
        </div>

        <g:each in="${chemistry}" status="i" var="chemistryInfo">
            <div>
                <span class="Imgxz">
                    <g:if test="${chemistryInfo?.type=='视频公开课'}">
                        <g:link controller="microClass" action="play" id="${chemistryInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: chemistryInfo.image)}">
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:link controller="microClass" action="courseDetails" id="${chemistryInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: chemistryInfo.image)}">
                        </g:link>
                    </g:else>
                </span>
                <h2>${chemistryInfo.name}</h2>
            </div>
        </g:each>

    </section>
    <div class="clear"></div>

    %{--生物--}%
        <p id="biology"></p>
    <section >
        <div class="last_one" >
            <h1>生物</h1>
            <p>biology</p>
        </div>

        <g:each in="${biology}" status="i" var="biologyInfo">
            <div>
                <span class="Imgxz">
                    <g:if test="${biologyInfo?.type=='视频公开课'}">
                        <g:link controller="microClass" action="play" id="${biologyInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: biologyInfo.image)}">
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:link controller="microClass" action="courseDetails" id="${biologyInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: biologyInfo.image)}">
                        </g:link>
                    </g:else>
                </span>
                <h2>${biologyInfo.name}</h2>
            </div>
        </g:each>

    </section>
    <div class="clear"></div>

    %{--地球科学--}%
        <p id="geoscience"></p>
    <section >
        <div class="last_one" >
            <h1>地球科学</h1>
            <p>geoscience</p>
        </div>

        <g:each in="${geoscience}" status="i" var="geoscienceInfo">
            <div>
                <span class="Imgxz">
                    <g:if test="${geoscienceInfo?.type=='视频公开课'}">
                        <g:link controller="microClass" action="play" id="${geoscienceInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: geoscienceInfo.image)}">
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:link controller="microClass" action="courseDetails" id="${geoscienceInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: geoscienceInfo.image)}">
                        </g:link>
                    </g:else>
                </span>
                <h2>${geoscienceInfo.name}</h2>
            </div>
        </g:each>

    </section>
    <div class="clear"></div>

    %{--计算机--}%
        <p id="computer"></p>
    <section >
        <div class="last_one" >
            <h1>计算机</h1>
            <p>computer</p>
        </div>

        <g:each in="${computer}" status="i" var="computerInfo">
            <div>
                <span class="Imgxz">
                    <g:if test="${computerInfo?.type=='视频公开课'}">
                        <g:link controller="microClass" action="play" id="${computerInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: computerInfo.image)}">
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:link controller="microClass" action="courseDetails" id="${computerInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: computerInfo.image)}">
                        </g:link>
                    </g:else>
                </span>
                <h2>${computerInfo.name}</h2>
            </div>
        </g:each>

    </section>
    <div class="clear"></div>

    %{--医学--}%
        <p id="medicine"></p>
    <section >
        <div class="last_one" >
            <h1>医学</h1>
            <p>medicine</p>
        </div>

        <g:each in="${medicine}" status="i" var="medicineInfo">
            <div>
                <span class="Imgxz">
                    <g:if test="${medicineInfo?.type=='视频公开课'}">
                        <g:link controller="microClass" action="play" id="${medicineInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: medicineInfo.image)}">
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:link controller="microClass" action="courseDetails" id="${medicineInfo.id}">
                            <img class="lazy" src="${resource(dir: '',file: medicineInfo.image)}">
                        </g:link>
                    </g:else>
                </span>
                <h2>${medicineInfo.name}</h2>
            </div>
        </g:each>

    </section>
    <div class="clear"></div>


    </div>
</div>

<div class="clear"></div>
<footer>
    <div class="f-container">
        <ul>
            <li><a href="#">About NetEase</a><span>-</span></li>
            <li><a href="#">公司简介</a><span>-</span></li>
            <li><a href="#">联系方式</a><span>-</span></li>
            <li><a href="#">招聘信息</a><span>-</span></li>
            <li><a href="#">客服服务</a><span>-</span></li>
            <li><a href="#">相关法律</a><span>-</span></li>
            <li><a href="#">网络营销</a><span>-</span></li>
            <li><a href="#">网站地图</a><span>-</span></li>
            <li><a href="#">用户体验计划</a></li>
        </ul>

        <p>中国大学视频公开课适用于《中华人民共和国著作权法》<br/>
            中国大学视频公开课经高等教育出版社许可使用，TED、BBC、Coursera经版权方许可使用。未经书面允许，请勿转播<br/>
            除非另有声明，本平台其它视频作品采用Creative Common知识共享署名-非商业性使用-相同方式共享 2.5 中国大陆许可协议进行许可
        </p>
        <img src="images/footer.png">
    </div>
</footer>
<ul class="scroll">
    <li class="ewm">
        <img src="images/erweima.png">
        <img class="ewm_img" src="images/2weima.png">
    </li>
    <li class="fk">
        <img src="images/fankui.png" onclick="fankui();">
    </li>
    <li class="sct">
        <div class="zhidin"></div>
    </li>
</ul>
<g:javascript src="main.js"/>
	</body>
<script type="application/javascript">
    //反馈
    function fankui() {
//        alert("去反馈")
        layer.open({
            type: 2,
            title: ['信息反馈', 'text-align: center;font-size:25px'],
            skin: 'demo-class', /*自定义标题颜色*/
            closeBtn: 1, /*关闭按钮风格*/
            shadeClose: true,
            shade: 0.8,
            area: ['650px', '60%'],//小屏幕上正好
//                        area: ['40%', '50%'],//大屏幕上正好
            content: "<g:createLink controller="userInfo" action="fankui"/>",
            end: function () {
            }
        });
    }
</script>
</html>
