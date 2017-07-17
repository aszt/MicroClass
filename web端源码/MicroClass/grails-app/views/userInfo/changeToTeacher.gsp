<%--
  Created by IntelliJ IDEA.
  User: tong
  Date: 2016/10/30
  Time: 17:25
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>成为教师</title>
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'changeToTeacher.css')}" type="text/css">
    <g:javascript src="jquery-2.1.3.min.js"/>
    <script type="text/javascript">
    $(document).ready(function () {
            /*成为教师====================*/
            $("#z1").click(function () {
                //真实姓名、学校、院系、教师工号、职称、联系方式、个人简介
                var name = $("#name").val()
                var school = $("#school").val()
                var college = $("#college").val()
                var code = $("#code").val()
                var position = $("#position").val()
                var mobilePhone = $("#mobilePhone").val()
                var introduction = $("#introduction").val()
                if(name==""||school==""||college==""||code==""||position==""||mobilePhone==""||introduction==""){
                    alert("请填写完整信息")
                } else{

                $.ajax({
                    url:'<g:createLink controller="userInfo" action="authentication" />',
                    type:'post',
                    dataType:'json',
                    data:{
                        name:name,
                        school:school,
                        college:college,
                        code:code,
                        position:position,
                        mobilePhone:mobilePhone,
                        introduction:introduction,
                    },
                    success:function(msg){
                        if(msg.msg=="200"){
//                            返回审核已提交，等待管理员处理
                            var msg = "审核已提交，等待管理员处理"
                            var prompt = msg.prompt
                            parent.location.reload(); // 父页面刷新
                            var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
                            parent.layer.close(index);
                            %{--parent.location = "<g:createLink controller="userInfo" action="user" />?prompt="+prompt;--}%
                        }
                    }
                });

                }
            })
        })
    </script>
</head>

<body>
<div style="width: 100%">
    <div style="width: 600px;height: 600px;border: 0px solid #2CA368;margin: 0 auto">
        <h3>请填写内容，等待管理员审核</h3>
        <hr style="color: #2CA368">
        <div class="Info" id="ys">
            <table  cellspacing="10" class="">
                <tr>
                    <td class="l">真实姓名：</td>
                    <td><input type="text" id="name"></td>
                </tr>
                <tr>
                    <td class="l">学校：</td>
                    <td><input type="text" id="school"></td>
                </tr>
                <tr>
                    <td class="l">院系：</td>
                    <td><input type="text" id="college"></td>
                </tr>
                <tr>
                    <td class="l">教师工号：</td>
                    <td><input type="text" id="code"></td>
                </tr>
                <tr>
                    <td class="l">职称：</td>
                    <td><input type="text" id="position"></td>
                </tr>
                <tr>
                    <td class="l">联系方式：</td>
                    <td><input type="text" id="mobilePhone"></td>
                </tr>
                <tr>
                    <td class="l">个人简介：</td>
                    <td>
                        <textarea cols="40" rows="12" placeholder="建议不超过1000字左右" id="introduction"></textarea>
                    </td>
                </tr>
            </table>
            <div class="btts">
                <button class="cc"><a href="#" id="z1" onclick="abc();">保存</a></button>
                <button class="cc"><a href="#" id="z2">取消</a></button>
            </div>
        </div>
    </div>
</div>
</body>
</html>