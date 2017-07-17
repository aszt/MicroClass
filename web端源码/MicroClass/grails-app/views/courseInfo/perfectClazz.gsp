<%--
  Created by IntelliJ IDEA.
  User: tong
  Date: 2016/10/25
  Time: 15:33
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>创建课程</title>
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'bootstrap.min.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'fileinput.min.css')}" type="text/css">
    %{--<link rel="stylesheet" href="${resource(dir: 'css',file: 'perfectClazz.css')}" type="text/css">--}%
    %{--不用自己的css，会有问题--}%
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'videoOpenClass.css')}" type="text/css">

    <g:javascript src="jquery-2.1.3.min.js"/>
    <g:javascript src="bootstrap.min.js"/>
    <g:javascript src="fileinput.min.js"/>
    <g:javascript src="fileinput_locale_zh.js"/>

    <g:javascript src="layer/layer.js"/>

    %{--创建课程将资源id保存--}%
    <script type="text/javascript">
        $(document).ready(function() {


            $("#cancel").click(function () {
                parent.location = "<g:createLink controller="userInfo" action="myCourse" />";
            });
            $("#save").click(function () {

                var id = $("#courseId")[0].value;//课程id
                var image = $("#imageId")[0].value;//封面图片id
                var introduction = $("#jjId")[0].value;//简介id
                var program = $("#jxdgId")[0].value;//教学大纲id
                var declarationForm = $("#sbbId")[0].value;//申报表id
                var guidance = $("#sjzdId")[0].value;//实践指导id
                var teachingMaterial = $("#zdjcId")[0].value;//指定教材id
                var referenceDoc = $("#ckwxId")[0].value;//参考文献id
                if(id==""||image==""||introduction==""||program==""||declarationForm==""||guidance==""||teachingMaterial==""||referenceDoc==""){
                    alert("请按要求上传所需资源")
                    /*layer.msg("请按要求上传所需资源",{offset: '10px'}, function(){
                    });*/
                } else{
                    $.ajax({
                        url:'<g:createLink controller="courseInfo" action="save" />',
                        type:'post',
                        dataType:'json',
                        data:{
                            id:id,
                            image:image,
                            introduction:introduction,
                            program:program,
                            declarationForm:declarationForm,
                            guidance:guidance,
                            teachingMaterial:teachingMaterial,
                            referenceDoc:referenceDoc
                        },
                        success:function(msg){
                            if(msg.state=="200"){
                           layer.confirm('操作成功！', {
                                offset:"20px",
                                        btn: ['添加课时','课程列表'] //按钮
                            }, function(){
                                var courseId = msg.courseId;//返回创建课程的id
                                parent.location = "<g:createLink controller="ClassPeriodInfo" action="saveClassHour" />?id="+courseId;
                            }, function(){
                                parent.location = "<g:createLink controller="userInfo" action="myCourse" />";
                            });
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
                <a href="#">创建/修改</a>
            </div>
            <div class="kcc" id="ca">
                <!--上传内容-->
                <div class="nr">
                    <h3>填写内容</h3>
                    <hr style="width: 100%;margin: 10px auto">
                    %{--<g:form controller="courseInfo" action="save" method="post">--}%
                    <div class="txs">
                        <!--标题-->
                        <div class="kzs">
                            <div class="btkz"><label>课程名称</label></div>
                            <input class="inys" type="text" value="${courseInfo.name}" disabled="disabled">
                            <input class="inys" type="hidden" id="courseId" value="${courseInfo.id}" disabled="disabled">
                            %{--表单提交课程名称--}%
                            <input type="hidden" name="name" value="${courseInfo.name}" />
                            <!--<span class="help-block" style="color:#FF9966">*</span>-->
                        </div>

                        <!--上传开始=======================-->

                        <!--封面图片-->
                        <div class="kzs">
                            <div class="btkz"><label>封面图片</label></div>
                            <span class="help-block" style="color:#737373">上传封面图片</span>
                        </div>
                        <!--封面图片上传-->
                        <div class="kzss">
                            <div class="btkz"><label></label></div>
                            <div class="uplo">
                                <div class="container kv-main" style="width: 500px;">
                                    <form enctype="multipart/form-data">
                                        <div class="form-group">
                                            <input id="img_file" name="img_file"  type="file" class="file"/>
                                            <input type="hidden" id="imageId" name="image" value="${courseInfo?.image}" />
                                            <script>
                                                $("#img_file").fileinput({
                                                    %{--uploadExtraData: {courseId:"${courseInfo.id}"},--}%
                                                    language: "zh",
                                                    uploadUrl: '<g:createLink controller="resourceInfo" action="uploadImg"/>', //上传的地址
                                                    maxFileCount: 1,
                                                    validateInitialCount: true,
                                                    autoReplace: true,
                                                    showRemove:false,
                                                    allowedFileExtensions: ["jpg", "png", "gif","jpeg"],
                                                    uploadExtraData:{
                                                        courseId:'${courseInfo.id}'
                                                    }

                                                    <g:if test="${courseInfo?.image}">
                                                    ,initialPreview:[
                                                        "<img  src='${resource(dir: '', file: courseInfo.image)}' class='file-preview-image' alt='${image?.name}' title='${image?.name}'>"
                                                    ],
                                                    initialPreviewConfig: [
                                                        {
                                                            caption: "${image?.name}",
                                                            size: "${image?.fileSize}",
                                                            url: "${createLink(controller:'courseInfo', action:'delete', id: image?.id)}",
                                                            key: "${image.id}"
                                                        }
                                                    ]
                                                    </g:if>

                                                }).on('fileuploaded', function(event, data, id, index) {
                                                    var uuid = data.response.initialPreviewConfig[0].key;
                                                    $("#imageId").val(uuid);
                                                }).on('filedeleted', function (event, key) {
                                                    $("#imageId").val("");
                                                });
                                            </script>

                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div style="clear: both"></div>

                        <!--简介-->
                        <div class="kzs">
                            <div class="btkz"><label>简介</label></div>
                            <span class="help-block" style="color:#737373">上传课程简介</span>
                        </div>
                        <!--简介-->
                        <div class="kzss">
                            <div class="btkz"><label></label></div>
                            <div class="uplo">
                                <div class="container kv-main" style="width: 500px;">
                                    <form enctype="multipart/form-data">
                                        <div class="form-group">
                                            <input id="jj_file" name="jj_file"  type="file" class="file"/>
                                            %{--<input type="text" id="jjId" name="jj" value="" />--}%
                                            <input type="hidden" id="jjId" name="introduction" value="${introduction?.id}" />
                                            <script>
                                                $("#jj_file").fileinput({
                                                    %{--uploadExtraData: {courseId:"${courseInfo.id}"},--}%
                                                    language: "zh",
                                                    uploadUrl: '<g:createLink controller="resourceInfo" action="uploadWord"/>', //上传的地址
                                                    maxFileCount: 1,
                                                    validateInitialCount: true,
                                                    autoReplace: true,
                                                    showRemove:false,
//                                                    allowedFileExtensions: ["jpg", "png", "gif","mp4"],
                                                    uploadExtraData:{
                                                        courseId:'${courseInfo.id}',
                                                        purpose:'introduction'
                                                    }

                                                    <g:if test="${introduction?.preImgPath}">
                                                    ,initialPreview:[
                                                        "<img  src='${resource(dir: '', file: introduction.preImgPath)}' class='file-preview-image' alt='${introduction?.name}' title='${introduction?.name}'>"
                                                    ],
                                                    initialPreviewConfig: [
                                                        {
                                                            caption: "${introduction?.name}",
                                                            size: "${introduction?.fileSize}",
                                                            url: "${createLink(controller:'courseInfo', action:'delete', id: introduction?.id)}",
                                                            key: "${introduction.id}"
                                                        }
                                                    ]
                                                    </g:if>

                                                }).on('fileuploaded', function(event, data, id, index) {
                                                    var uuid = data.response.initialPreviewConfig[0].key;
                                                    $("#jjId").val(uuid);
                                                }).on('filedeleted', function (event, key) {
                                                    $("#jjId").val("");
                                                });
                                            </script>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <!--上传止=======================-->
                        <div style="clear: both"></div>
                        <!--教学大纲-->
                        <div class="kzs">
                            <div class="btkz"><label>教学大纲</label></div>
                            <span class="help-block" style="color:#737373">上传课程教学大纲</span>
                        </div>
                        <!--教学大纲上传-->
                        <div class="kzss">
                            <div class="btkz"><label></label></div>
                            <div class="uplo">
                                <div class="container kv-main" style="width: 500px;">
                                    <form enctype="multipart/form-data">
                                        <div class="form-group">
                                            <input id="jxdg_file" name="jxdg_file"  type="file" class="file"/>
                                            <input type="hidden" id="jxdgId" name="program" value="${program?.id}" />
                                            <script>
                                                $("#jxdg_file").fileinput({
                                                    language: "zh",
                                                    uploadUrl: '<g:createLink controller="resourceInfo" action="uploadWord"/>', //上传的地址
                                                    maxFileCount: 1,
                                                    validateInitialCount: true,
                                                    autoReplace: true,
                                                    showRemove:false,
//                                                    allowedFileExtensions: ["jpg", "png", "gif","mp4"],
                                                    uploadExtraData:{
                                                        courseId:'${courseInfo.id}',
                                                        purpose:'program'
                                                    }

                                                    <g:if test="${program?.preImgPath}">
                                                    ,initialPreview:[
                                                        "<img  src='${resource(dir: '', file: program.preImgPath)}' class='file-preview-image' alt='${program?.name}' title='${program?.name}'>"
                                                    ],
                                                    initialPreviewConfig: [
                                                        {
                                                            caption: "${program?.name}",
                                                            size: "${program?.fileSize}",
                                                            url: "${createLink(controller:'courseInfo', action:'delete', id: program?.id)}",
                                                            key: "${program.id}"
                                                        }
                                                    ]
                                                    </g:if>

                                                }).on('fileuploaded', function(event, data, id, index) {
                                                    var uuid = data.response.initialPreviewConfig[0].key;
                                                    $("#jxdgId").val(uuid);
                                                }).on('filedeleted', function (event, key) {
                                                    $("#jxdgId").val("");
                                                });
                                            </script>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <div style="clear: both"></div>
                        <!--申报表-->
                        <div class="kzs">
                            <div class="btkz"><label>申报表</label></div>
                            <span class="help-block" style="color:#737373">上传课程申报表</span>
                        </div>
                        <!--申报表上传-->
                        <div class="kzss">
                            <div class="btkz"><label></label></div>
                            <div class="uplo">
                                <div class="container kv-main" style="width: 500px;">
                                    <form enctype="multipart/form-data">
                                        <div class="form-group">
                                            <input id="sbb_file" name="sbb_file"  type="file" class="file"/>
                                            <input type="hidden" id="sbbId" name="declarationForm" value="${declarationForm?.id}" />
                                            <script>
                                                $("#sbb_file").fileinput({
                                                    language: "zh",
                                                    uploadUrl: '<g:createLink controller="resourceInfo" action="uploadWord"/>', //上传的地址
                                                    maxFileCount: 1,
                                                    validateInitialCount: true,
                                                    autoReplace: true,
                                                    showRemove:false,
//                                                    allowedFileExtensions: ["jpg", "png", "gif","mp4"],
                                                    uploadExtraData:{
                                                        courseId:'${courseInfo.id}',
                                                        purpose:'declarationForm'
                                                    }

                                                    <g:if test="${declarationForm?.preImgPath}">
                                                    ,initialPreview:[
                                                        "<img  src='${resource(dir: '', file: declarationForm.preImgPath)}' class='file-preview-image' alt='${declarationForm?.name}' title='${declarationForm?.name}'>"
                                                    ],
                                                    initialPreviewConfig: [
                                                        {
                                                            caption: "${declarationForm?.name}",
                                                            size: "${declarationForm?.fileSize}",
                                                            url: "${createLink(controller:'courseInfo', action:'delete', id: declarationForm?.id)}",
                                                            key: "${declarationForm.id}"
                                                        }
                                                    ]
                                                    </g:if>

                                                }).on('fileuploaded', function(event, data, id, index) {
                                                    var uuid = data.response.initialPreviewConfig[0].key;
                                                    $("#sbbId").val(uuid);
                                                }).on('filedeleted', function (event, key) {
                                                    $("#sbbId").val("");
                                                });
                                            </script>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <div style="clear: both"></div>
                        <!--实践指导-->
                        <div class="kzs">
                            <div class="btkz"><label>实践指导</label></div>
                            <span class="help-block" style="color:#737373">上传实践指导</span>
                        </div>
                        <!--实践指导上传-->
                        <div class="kzss">
                            <div class="btkz"><label></label></div>
                            <div class="uplo">
                                <div class="container kv-main" style="width: 500px;">
                                    <form enctype="multipart/form-data">
                                        <div class="form-group">
                                            <input id="sjzd_file" name="sjzd_file"  type="file" class="file"/>
                                            <input type="hidden" id="sjzdId" name="guidance" value="${guidance?.id}" />
                                            <script>
                                                $("#sjzd_file").fileinput({
                                                    language: "zh",
                                                    uploadUrl: '<g:createLink controller="resourceInfo" action="uploadWord"/>', //上传的地址
                                                    maxFileCount: 1,
                                                    validateInitialCount: true,
                                                    autoReplace: true,
                                                    showRemove:false,
//                                                    allowedFileExtensions: ["jpg", "png", "gif","mp4"],
                                                    uploadExtraData:{
                                                        courseId:'${courseInfo.id}',
                                                        purpose:'guidance'
                                                    }

                                                    <g:if test="${guidance?.preImgPath}">
                                                    ,initialPreview:[
                                                        "<img  src='${resource(dir: '', file: guidance.preImgPath)}' class='file-preview-image' alt='${guidance?.name}' title='${guidance?.name}'>"
                                                    ],
                                                    initialPreviewConfig: [
                                                        {
                                                            caption: "${guidance?.name}",
                                                            size: "${guidance?.fileSize}",
                                                            url: "${createLink(controller:'courseInfo', action:'delete', id: guidance?.id)}",
                                                            key: "${guidance.id}"
                                                        }
                                                    ]
                                                    </g:if>

                                                }).on('fileuploaded', function(event, data, id, index) {
                                                    var uuid = data.response.initialPreviewConfig[0].key;
                                                    $("#sjzdId").val(uuid);
                                                }).on('filedeleted', function (event, key) {
                                                    $("#sjzdId").val("");
                                                });
                                            </script>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <div style="clear: both"></div>
                        <!--指定教材-->
                        <div class="kzs">
                            <div class="btkz"><label>指定教材</label></div>
                            <span class="help-block" style="color:#737373">上传课程指定教材</span>
                        </div>
                        <!--指定教材上传-->
                        <div class="kzss">
                            <div class="btkz"><label></label></div>
                            <div class="uplo">
                                <div class="container kv-main" style="width: 500px;">
                                    <form enctype="multipart/form-data">
                                        <div class="form-group">
                                            <input id="zdjc_file" name="zdjc_file"  type="file" class="file"/>
                                            <input type="hidden" id="zdjcId" name="teachingMaterial" value="${teachingMaterial?.id}" />
                                            <script>
                                                $("#zdjc_file").fileinput({
                                                    language: "zh",
                                                    uploadUrl: '<g:createLink controller="resourceInfo" action="uploadWord"/>', //上传的地址
                                                    maxFileCount: 1,
                                                    validateInitialCount: true,
                                                    autoReplace: true,
                                                    showRemove:false,
//                                                    allowedFileExtensions: ["jpg", "png", "gif","mp4"],
                                                    uploadExtraData:{
                                                        courseId:'${courseInfo.id}',
                                                        purpose:'teachingMaterial'
                                                    }

                                                    <g:if test="${teachingMaterial?.preImgPath}">
                                                    ,initialPreview:[
                                                        "<img  src='${resource(dir: '', file: teachingMaterial.preImgPath)}' class='file-preview-image' alt='${teachingMaterial?.name}' title='${teachingMaterial?.name}'>"
                                                    ],
                                                    initialPreviewConfig: [
                                                        {
                                                            caption: "${teachingMaterial?.name}",
                                                            size: "${teachingMaterial?.fileSize}",
                                                            url: "${createLink(controller:'courseInfo', action:'delete', id: teachingMaterial?.id)}",
                                                            key: "${teachingMaterial.id}"
                                                        }
                                                    ]
                                                    </g:if>

                                                }).on('fileuploaded', function(event, data, id, index) {
                                                    var uuid = data.response.initialPreviewConfig[0].key;
                                                    $("#zdjcId").val(uuid);
                                                }).on('filedeleted', function (event, key) {
                                                    $("#zdjcId").val("");
                                                });
                                            </script>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <div style="clear: both"></div>
                        <!--参考文献-->
                        <div class="kzs">
                            <div class="btkz"><label>参考文献</label></div>
                            <span class="help-block" style="color:#737373">上传课程参考文献目录</span>
                        </div>
                        <!--参考文献上传-->
                        <div class="kzss">
                            <div class="btkz"><label></label></div>
                            <div class="uplo">
                                <div class="container kv-main" style="width: 500px;">
                                    <form enctype="multipart/form-data">
                                        <div class="form-group">
                                            <input id="ckwx_file" name="ckwx_file"  type="file" class="file"/>
                                            <input type="hidden" id="ckwxId" name="referenceDoc" value="${referenceDoc?.id}" />
                                            <script>
                                                $("#ckwx_file").fileinput({
                                                    language: "zh",
                                                    uploadUrl: '<g:createLink controller="resourceInfo" action="uploadWord"/>', //上传的地址
                                                    maxFileCount: 1,
                                                    validateInitialCount: true,
                                                    autoReplace: true,
                                                    showRemove:false,
//                                                    allowedFileExtensions: ["jpg", "png", "gif","mp4"],
                                                    uploadExtraData:{
                                                        courseId:'${courseInfo.id}',
                                                        purpose:'referenceDoc'
                                                    }

                                                    <g:if test="${referenceDoc?.preImgPath}">
                                                    ,initialPreview:[
                                                        "<img  src='${resource(dir: '', file: referenceDoc.preImgPath)}' class='file-preview-image' alt='${referenceDoc?.name}' title='${referenceDoc?.name}'>"
                                                    ],
                                                    initialPreviewConfig: [
                                                        {
                                                            caption: "${referenceDoc?.name}",
                                                            size: "${referenceDoc?.fileSize}",
                                                            url: "${createLink(controller:'courseInfo', action:'delete', id: referenceDoc?.id)}",
                                                            key: "${referenceDoc.id}"
                                                        }
                                                    ]
                                                    </g:if>

                                                }).on('fileuploaded', function(event, data, id, index) {
                                                    var uuid = data.response.initialPreviewConfig[0].key;
                                                    $("#ckwxId").val(uuid);
                                                }).on('filedeleted', function (event, key) {
                                                    $("#ckwxId").val("");
                                                });
                                            </script>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>


                        <!--<div style="clear: both"></div>-->
                        <!--操作按钮-->
                        <div class="btnn">
                            %{--<input type="submit" value="创建" style="margin-top: 20px;border: none;background-color:inherit;width: 30%;
                            height: 30px;border-radius: 20px;background-color: #2CA368; color: #FFFFFF">--}%
                            <button id="save" class="q1" style="color: white">保存</button>
                            <button id="cancel" class="q1" style="color: white" >取消</button>
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