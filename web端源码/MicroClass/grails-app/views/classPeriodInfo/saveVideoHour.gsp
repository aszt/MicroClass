<%--
  Created by IntelliJ IDEA.
  User: tong
  Date: 2016/10/25
  Time: 15:33
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>添加课时(视频公开课)</title>
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'bootstrap.min.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'fileinput.min.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'saveClassHour.css')}" type="text/css">
    <g:javascript src="jquery-2.1.3.min.js"/>
    <g:javascript src="bootstrap.min.js"/>
    <g:javascript src="fileinput.min.js"/>
    <g:javascript src="fileinput_locale_zh.js"/>

    <g:javascript src="layer/layer.js"/>

    %{--创建课程将资源id保存--}%
    <script type="text/javascript">
        $(document).ready(function() {

            var orderNum = ${classPeriodInfo.orderNum};
            if(orderNum==0){
                $("#test").val("1");
            }else{
                $("#test").val(orderNum);
            }
            $("#cancel").click(function () {
                parent.location = "<g:createLink controller="classPeriodInfo" action="seeClazzList" id="${courseInfoInstance.id}" />";
            });

            $("#save").click(function () {
                var courseId = $("#courseId")[0].value;//课程id
                var clazzId = $("#clazzId")[0].value;//课程id
                var clazzName = $("#clazzName")[0].value;//课时名称
                var bjjsId = $("#bjjsId")[0].value;//本讲介绍id
                var resourcesId = $("#resourcesId")[0].value;//资源id不保存
                //课时序号
                var options=$("#test option:selected");  //获取选中的项
                var orderNum = options.val();

                if(courseId==""||clazzId==""||clazzName==""||bjjsId==""||resourcesId==""||orderNum==""){
                    alert("请按要求上传所需资源")
                    /*layer.msg("请按要求上传所需资源",{offset: '10px'}, function(){
                     });*/
                } else{
                    $.ajax({
                        url:'<g:createLink controller="classPeriodInfo" action="save" />',
                        type:'post',
                        dataType:'json',
                        data:{
                            id:clazzId,
                            name:clazzName,
                            orderNum:orderNum,
                            jieShao:bjjsId,
                        },
                        success:function(msg){
                            if(msg.state=="200"){
//                            添加课时成功,返回课程列表页
//                                var courseId = msg.courseId;//返回创建课程的id
                                parent.location = "<g:createLink controller="classPeriodInfo" action="seeClazzList" id="${courseInfoInstance.id}" />";
                            }
                        }
                    });
                }

            })

            //修改密码
            $('#updatePw').on('click', function () {
                layer.open({
                    offset: '64px',
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

        });
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
                    <li class="hides_left"><img class="tx" src="${resource(dir: '',file:session.userInfo.image)}" style="width: 40px;height: 40px"></li>
                    <li class="hides_left"><a href="#" id="goLogin">${session.userInfo.name}</a></li>
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
                <a class="lj" href="../">主页 > </a>
                <g:link controller="userInfo" action="myCourse">我的课程 ></g:link>
                <g:link controller="classPeriodInfo" action="seeClazzList" id="${courseInfoInstance.id}">课程列表 ></g:link>
                <a href="#">添加课时</a>
            </div>
            <div class="kcc" id="hg">
                <!--上传内容-->
                <div class="nr">
                    <h3>填写内容</h3>
                    <hr style="width: 100%;margin: 10px auto">
                    %{--<g:form controller="courseInfo" action="save" method="post">--}%
                    <div class="txs">
                        <!--标题-->
                        <div class="kzs">
                            <div class="btkz"><label>课程名称</label></div>
                            <input class="inys" type="text" value="${courseInfoInstance.name}" disabled="disabled">
                            %{--表单提交课程名称--}%
                            <input type="hidden" name="name" value="${courseInfoInstance.name}" />
                             <input type="hidden" id="courseId" name="id" value="${courseInfoInstance.id}" />
                            <input type="hidden" id="clazzId" name="id" value="${classPeriodInfo.id}" />
                            <!--<span class="help-block" style="color:#FF9966">*</span>-->
                        </div>

                    <div class="kzs">
                        <div class="btkz"><label>序号</label></div>
                        %{--<input class="inys" type="text" value="第一章">
                        <span class="help-block" style="color:#FF9966">*</span>--}%
                        <select class="inys" id="test">
                            <option value="1">第一章</option>
                            <option value="2">第二章</option>
                            <option value="3">第三章</option>
                            <option value="4">第四章</option>
                            <option value="5">第五章</option>
                            <option value="6">第六章</option>
                            <option value="7">第七章</option>
                            <option value="8">第八章</option>
                            <option value="9">第九章</option>
                            <option value="10">第十章</option>
                        </select>
                        <span class="help-block" style="color:#FF9966">*</span>
                    </div>

                    <div class="kzs">
                        <div class="btkz"><label>课时名称</label></div>
                        <input id="clazzName" class="inys" type="text" value="${classPeriodInfo.name}">
                        <span class="help-block" style="color:#FF9966">*</span>
                    </div>
                        <!--上传开始=======================-->
                        <!--本讲介绍-->
                    <div class="kzs">
                        <div class="btkz"><label>本讲介绍</label></div>
                        <span class="help-block" style="color:#737373">上传本讲介绍</span>
                    </div>
                    <!--本讲介绍上传-->
                    <div class="kzss">
                        <div class="btkz"><label></label></div>
                        <div class="uplo">
                            <div class="container kv-main" style="width: 500px;">
                                <form enctype="multipart/form-data">
                                    <div class="form-group">
                                        <input id="bjjs_file" name="bjjs_file"  type="file" class="file"/>
                                            <input type="hidden" id="bjjsId" name="jieShao" value="${resourceInfo?.id}" />
                                        <script>
                                            $("#bjjs_file").fileinput({
                                                language: "zh",
                                                uploadUrl: '<g:createLink controller="resourceInfo" action="upload"/>', //上传的地址
                                                maxFileCount: 1,
                                                validateInitialCount: true,
                                                autoReplace: true,
                                                showRemove:false,
//                                                    allowedFileExtensions: ["jpg", "png", "gif","mp4"],
                                                uploadExtraData:{
                                                    courseId:'${courseInfoInstance.id}',
                                                    classPeriodId:'${classPeriodInfo.id}',
                                                    purpose:'jieShao'
                                                }

                                                <g:if test="${jieShao?.preImgPath}">
                                                ,initialPreview:[
                                                    "<img  src='${resource(dir: '', file: jieShao.preImgPath)}' class='file-preview-image' alt='${jieShao?.name}' title='${jieShao?.name}'>"
                                                ],
                                                initialPreviewConfig: [
                                                    {
                                                        caption: "${jieShao?.name}",
                                                        size: "${jieShao?.fileSize}",
                                                        url: "${createLink(controller:'courseInfo', action:'delete', id: jieShao?.id)}",
                                                        key: "${jieShao.id}"
                                                    }
                                                ]
                                                </g:if>

                                            }).on('fileuploaded', function(event, data, id, index) {
                                                var uuid = data.response.initialPreviewConfig[0].key;
                                                $("#bjjsId").val(uuid);
                                            }).on('filedeleted', function (event, key) {
                                                $("#bjjsId").val("");
                                            });
                                        </script>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div style="clear: both"></div>

                    <!--资源上传-->
                    <div class="kzs">
                        <div class="btkz"><label>资源上传</label></div>
                        <span class="help-block" style="color:#737373">视频公开每课时只能添加一节视频,如修改请先删除</span>
                    </div>
                    <!--资源上传-->
                    <div class="kzss">
                        <div class="btkz"><label></label></div>
                        <div class="uplo">
                            <div class="container kv-main" style="width: 500px;">
                                <form enctype="multipart/form-data">
                                    <div class="form-group">
                                        <input id="resources_file" name="resources_file"  type="file" class="file"/>
                                        <input type="hidden" id="resourcesId" name="resources" value="" />
                                        <script>
                                            $("#resources_file").fileinput({
                                                language: "zh",
                                                uploadUrl: '<g:createLink controller="resourceInfo" action="upload"/>', //上传的地址
                                                maxFileCount: 1,
                                                validateInitialCount: true,
                                                autoReplace: true,
                                                showRemove:false,
//                                                    allowedFileExtensions: ["jpg", "png", "gif","mp4"],
                                                uploadExtraData:{
                                                    courseId:'${courseInfoInstance.id}',
                                                    classPeriodId:'${classPeriodInfo.id}',
                                                    purpose:'classPeriod'
                                                }

                                                <g:if test="${resourceInfo?.preImgPath}">
                                                ,initialPreview:[
                                                    "<img  src='${resource(dir: '', file: resourceInfo.preImgPath)}' class='file-preview-image' alt='${resourceInfo?.name}' title='${resourceInfo?.name}'>"
                                                ],
                                                initialPreviewConfig: [
                                                    {
                                                        caption: "${resourceInfo?.name}",
                                                        size: "${resourceInfo?.fileSize}",
                                                        url: "${createLink(controller:'courseInfo', action:'delete', id: resourceInfo?.id)}",
                                                        key: "${resourceInfo.id}"
                                                    }
                                                ]
                                                </g:if>


                                            }).on('fileuploaded', function(event, data, id, index) {
                                                var uuid = data.response.initialPreviewConfig[0].key;
                                                $("#resourcesId").val(uuid);
                                            }).on('filedeleted', function (event, key) {
                                                $("#resourcesId").val("");
                                            });
                                        </script>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                        %{--继续添加--}%
                        <!--<div style="clear: both"></div>-->
                        <!--操作按钮-->
                        <div class="btnn">
                            %{--<input type="submit" value="创建" style="margin-top: 20px;border: none;background-color:inherit;width: 30%;
                            height: 30px;border-radius: 20px;background-color: #2CA368; color: #FFFFFF">--}%
                            <button id="save" class="q1" style="color: white">保存</button>
                            <button id="cancel" class="q1" style="color: white">取消</button>
                        </div>
                    </div>
                    %{--</g:form>--}%
                </div>
            </header>
            </div>
        </div>
        <!--我的课程页面结束-->
    </div>
</div>

<div style="height: 660px"></div>
<!--<div class="login-footer">
    <span class="one">微课平台系统后台</span><br>
    <span>14软件技术毕业设计====滁州职业技术学院</span><br>
    <span>童重远、陈凯旋</span>
</div>-->
</body>
</html>