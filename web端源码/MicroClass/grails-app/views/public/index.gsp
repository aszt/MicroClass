<!DOCTYPE html>
<html>
	<head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
        %{--<meta name="layout" content="main"/>--}%
        <title>p</title>
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
                        title: ['网易公开课', 'text-align: center;font-size:25px'],
                        skin: 'demo-class', /*自定义标题颜色*/
                        closeBtn: 2, /*关闭按钮风格*/
                        shadeClose: true,
                        shade: 0.8,
                        area: ['650px', '80%'],
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
            })
        </script>
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
                <li><a href="#">${test}</a></li>
            </ul>

            <div class="top_right">
                <p>欢迎来到网易公开课!</p>
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
                        <li class="hides_left"><a href="#" id="goLogin">登录/注册</a></li>
                    </g:else>
                    <li><a href="#" style="color: #2E9057">我的公开课</a></li>
                    <li><a href="#">+关注我们</a></li>
                    <li><a href="#" style="color: #2E9057">客户端下载</a></li>
                </ul>
            </div>
        </div>
    </div>
    <section>
        <img src="images/logo_big.png">

        <form>
            <input id="search" class="inputxt" name="query" type="text" placeholder="搜索课程、视频、公开课策划">
            <input id="search_btn" class="subbtn" value="" type="submit">
        </form>
    </section>
</header>
<nav>
    <div class="navigation">
        <ul>
            <li><a href="#">首页</a></li>
            <li><a href="#">视频公开课</a></li>
            <li><a href="#">资源共享课</a></li>
            <li><a href="#">中国大学MOCC</a></li>
            <li><a href="#">中国职教MOCC</a></li>
            <li><a href="#">在线课程中心</a></li>
            <li><a href="#">学习社区</a></li>
        </ul>
    </div>
</nav>
<!--幻灯片轮播开始-->
<div id="box">
    <ul class="big_img">
        <li>
            <a href=""><img class="IMG" src="images/header_da_1.png"></a>
        </li>
        <li>
            <a href=""><img class="IMG" src="images/header_da_2.jpg"></a>

            <div class="txt">
                <div class="tag"><img src="images/sk.png"></div>

                <h1>本草中国（1）：时间</h1>

                <p>讲述博大精深又魅力无穷的本草中国。</p>
            </div>
        </li>
        <li>
            <a href=""><img class="IMG" src="images/header_da_3.jpg"></a>

            <div class="txt">
                <div class="tag"><img src="images/sk.png"></div>

                <h1>折射人性动画短片：贪·狱</h1>

                <p>被一时的贪恋迷惑，一支空玻璃瓶成为它的坟墓。</p>
            </div>
        </li>
        <li>
            <a href=""><img class="IMG" src="images/header_da_4.jpg"></a>

            <div class="txt">
                <div class="tag"><img src="images/led.png"></div>

                <h1>泰国农民演讲改变你的世界观</h1>

                <p>泰国农民谈节约以及简单生活理念。</p>
            </div>
        </li>
        <li>
            <a href=""><img class="IMG" src="images/header_da_5.jpg"></a>

            <div class="txt">
                <div class="tag"><img src="images/ykt.png"></div>

                <h1>精选课程限时免费</h1>

                <p>#知识收割季#1元屯券 领185元课程红包。</p>
            </div>
        </li>
        <li>
            <a href=""><img class="IMG" src="images/header_da_6.jpg"></a>

            <div class="txt">
                <div class="tag"><img src="images/sk.png"></div>

                <h1>摄影技巧：让女友瞬间变女神</h1>

                <p>从此摆脱怪力乱神灵魂摄影师的称号，霸占女朋友的朋友圈！</p>
            </div>
        </li>
    </ul>

    <div class="niebu">
        <ul class="slider_list">
            <li index='1' class="current"><a><img src="images/header_xiao_1.png"></a></li>
            <li index='2'><a><img src="images/header_xiao_2.png"></a></li>
            <li index='3'><a><img src="images/header_xiao_3.png"></a></li>
            <li index='4'><a><img src="images/header_xiao_4.png"></a></li>
            <li index='5'><a><img src="images/header_xiao_5.png"></a></li>
            <li index='6'><a><img src="images/header_xiao_6.png"></a></li>
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
                        <li>
                            <i class="icon2">01</i>
                            <span class="ltxt">为什么我是测试数据？</span>
                            <span class="num"><img src="images/ship.png">87.0万</span>
                        </li>
                        <li>
                            <i class="icon2">02</i>
                            <span class="ltxt">性格的迷思--你究竟是谁？</span>
                            <span class="num"><img src="images/ship.png">86.5万</span>
                        </li>
                        <li>
                            <i class="icon2">03</i>
                            <span class="ltxt">足控福利：日本的丝袜</span>
                            <span class="num"><img src="images/ship.png">85.9万</span>
                        </li>
                        <li>
                            <i class="icon">04</i>
                            <span class="ltxt">什么是积极心理学？</span>
                            <span class="num"><img src="images/ship.png">58.0万</span>
                        </li>
                        <li>
                            <i class="icon">05</i>
                            <span class="ltxt">临刑会见-中国死刑犯</span>
                            <span class="num"><img src="images/ship.png">52.6万</span>
                        </li>
                        <li>
                            <i class="icon">06</i>
                            <span class="ltxt">马云斯坦福大学演讲</span>
                            <span class="num"><img src="images/ship.png">48.9万</span>
                        </li>
                        <li>
                            <i class="icon">07</i>
                            <span class="ltxt">你有拖延症吗?</span>
                            <span class="num"><img src="images/ship.png">42.5万</span>
                        </li>
                        <li>
                            <i class="icon">08</i>
                            <span class="ltxt">一位性工作者的诉求</span>
                            <span class="num"><img src="images/ship.png">39.8万</span>
                        </li>
                        <li>
                            <i class="icon">09</i>
                            <span class="ltxt">无人驾驶汽车</span>
                            <span class="num"><img src="images/ship.png">35.5万</span>
                        </li>
                        <li>
                            <i class="icon">10</i>
                            <span class="ltxt">Uber优步的故事</span>
                            <span class="num"><img src="images/ship.png">33.1万</span>
                        </li>
                    </ul>
                </div>

                <div class="hides" style="display: none">
                    <ul>
                        <li>
                            <i class="icon icon2">01</i>
                            <span class="ltxt">闭图像定理的证明</span>
                        </li>
                        <li>
                            <i class="icon icon2">02</i>
                            <span class="ltxt">开映射定理证明</span>
                        </li>
                        <li>
                            <i class="icon icon2">03</i>
                            <span class="ltxt">16彩色玻璃</span>
                        </li>
                        <li>
                            <i class="icon">04</i>
                            <span class="ltxt">15蜡烛</span>
                        </li>
                        <li>
                            <i class="icon">05</i>
                            <span class="ltxt">18越后国木屐</span>
                        </li>
                        <li>
                            <i class="icon">06</i>
                            <span class="ltxt">米其林星级甜点·Q弹小南瓜</span>
                        </li>
                        <li>
                            <i class="icon">07</i>
                            <span class="ltxt">14箱根寄木細工</span>
                        </li>
                        <li>
                            <i class="icon">08</i>
                            <span class="ltxt">筑地寻味：干鲣鱼</span>
                        </li>
                        <li>
                            <i class="icon">09</i>
                            <span class="ltxt">伤害性言论：好色客杂志诉法威尔案1</span>
                        </li>
                        <li>
                            <i class="icon">10</i>
                            <span class="ltxt">筑地寻味：草莓</span>
                        </li>
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
            <li><a href="#">语言</a></li>
            <li><a href="#">哲学</a></li>
            <li><a href="#">历史</a></li>
            <li><a href="#">宗教</a></li>
            <li><a href="#">艺术</a></li>
        </ul>

        <div class="yuan">社会</div>
        <ul class="shehui">
            <li><a href="#">经济</a></li>
            <li><a href="#">政治</a></li>
            <li><a href="#">法律</a></li>
            <li><a href="#">地理</a></li>
            <li><a href="#">教育</a></li>
            <li><a href="#">心理</a></li>
            <li><a href="#">管理</a></li>
            <li><a href="#">传播</a></li>
            <li><a href="#">社会</a></li>
            <li><a href="#">演讲</a></li>
        </ul>

        <div class="yuan">自然</div>
        <ul>
            <li><a href="#">数学</a></li>
            <li><a href="#">物理</a></li>
            <li><a href="#">化学</a></li>
            <li><a href="#">生物</a></li>
            <li><a href="#">地球科学</a></li>
            <li><a href="#">计算机</a></li>
        </ul>
    </div>
</div>

<div class="main">
    <div class="clear"></div>

    <div class="recommend">
        <h1>小编推荐</h1>
        <section>
            <div class="First">
                <span class="Imgxz">
                    <img class="lazy" src="images/imgsize.ph.1.jpg">
                </span>

                <h2>BBC评选，这是一份认真的名单</h2>
                <img class="ship" src="images/ship.png">

                <p>28.2万</p>
                <span class="imgtext">21世纪100部最伟大的电影</span>
            </div>

            <div>
                <span class="Imgxz">
                    <g:link controller="courseInfo" action="courseDetails">
                        <img class="lazy" src="images/imgsize.ph2.jpg">
                    </g:link>
                </span>

                <h2>睡眠十式</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">教你入睡的最佳方法</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/imgsize.ph.3.jpg">
                </span>

                <h2>我们是自愿把自己锁起来的</h2>
                <img class="ship" src="images/ship.png">

                <p>7.9万</p>
                <span class="imgtext">我们为什么会结婚</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/imgsize.ph.4.jpg">
                </span>

                <h2>中药版"舌尖上的中国"</h2>
                <img class="ship" src="images/ship.png">

                <p>6.1万</p>
                <span class="imgtext">本草中国</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/imgsize.ph.5.jpg">
                </span>

                <h2>不用修炼，也能欲仙欲死</h2>
                <img class="ship" src="images/ship.png">

                <p>4.2万</p>
                <span class="imgtext">10种让你飘飘欲仙食物</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/imgsize.ph.6.jpg">
                </span>

                <h2>不会念你就out了</h2>
                <img class="ship" src="images/ship.png">

                <p>3.8万</p>
                <span class="imgtext">教你正确发音时尚品牌</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/imgsize.ph.7.jpg">
                </span>

                <h2>刷新你自己的水平上限</h2>
                <img class="ship" src="images/ship.png">

                <p>7.5万</p>
                <span class="imgtext">测试你英文阅读速度多快</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/imgsize.ph.8.jpg">
                </span>

                <h2>你可能是你自己的双胞胎！</h2>
                <img class="ship" src="images/ship.png">

                <p>6.3万</p>
                <span class="imgtext">你DNA和你父母不符？</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/imgsize.ph.9.jpg">
                </span>

                <h2>你的这些小情绪们很正常</h2>
                <img class="ship" src="images/ship.png">

                <p>1.5万</p>
                <span class="imgtext">怎样化解嫉妒心和控制欲</span>
            </div>
        </section>
    </div>
    <!--以上是小编推荐-->
    <div class="clear"></div>

    <div class="TED Style">
        <section id="literature">
            <div class="last_one">
                <h1>语言</h1>

                <p>language</p>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div style="margin-right:0 ;">
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>
        </section>

        <div class="clear"></div>
        <section>
            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div style="margin-right:0 ;">
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>
        </section>

        <div class="clear"></div>
        <section>
            <div class="last_one">
                <h1>哲学</h1>

                <p>philosophy</p>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div style="margin-right:0 ;">
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>
        </section>

        <div class="clear"></div>
        <section>
            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div style="margin-right:0 ;">
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>
        </section>

        <div class="clear"></div>
        <section>
            <div class="last_one">
                <h1>历史</h1>

                <p>history</p>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div style="margin-right:0 ;">
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>
        </section>

        <div class="clear"></div>
        <section>
            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div style="margin-right:0 ;">
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>
        </section>

        <div class="clear"></div>
        <section>
            <div class="last_one">
                <h1>艺术</h1>

                <p>art</p>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div style="margin-right:0 ;">
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>
        </section>

        <div class="clear"></div>
        <section>
            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div>
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>

            <div style="margin-right:0 ;">
                <span class="Imgxz">
                    <img class="lazy" src="images/moren.png">
                </span>

                <h2>这是图片标题</h2>
                <img class="ship" src="images/ship.png">

                <p>5.9万</p>
                <span class="imgtext">这是一段文字</span>
            </div>
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
        <img src="images/fankui.png">
    </li>
    <li class="sct">
        <div class="zhidin"></div>
    </li>
</ul>
<g:javascript src="main.js"/>
	</body>
</html>
