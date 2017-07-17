<%--
  Created by IntelliJ IDEA.
  User: tong
  Date: 2016/11/13
  Time: 14:52
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>修改密码</title>
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'updatePW.css')}" type="text/css">
    <g:javascript src="jquery-2.1.3.min.js"/>
    <g:javascript src="layer/layer.js"/>
    <script type="application/javascript">
        $(document).ready(function () {
//            修改密码
            $('#updatePW').on('click', function () {
                var oldpw = $("#oldpw").val()
                var newpw = $("#newpw").val()
                var newpws = $("#newpws").val()
                if(newpw.length<6 || newpw.length>15){
                    layer.msg("密码长度必须为6--15位", function(){
                    });
                }else {
                    $.ajax({
                        url:'<g:createLink controller="userInfo" action="updateNew" />',
                        type:'post',
                        dataType:'json',
                        data:{
                            oldPW:oldpw,
                            newPW:newpw,
                            newPWS:newpws
                        },
                        success:function(msg){
                            if(msg.state=="200"){
                                layer.msg(msg.message, function(){
//                                修改成功，销毁session回到首页
                                    parent.location = "<g:createLink controller="userInfo" action="loginOut" />";
                                });
                            }else if(msg.state=="500"){
                                layer.msg(msg.message, function(){
                                });
                            }
                            else if(msg.state=="300"){
                                layer.msg(msg.message, function(){
                                });
                            }
                            else if(msg.state=="400"){
                                layer.msg(msg.message, function(){
                                });
                            }
                        }
                    });
                }

            })
        })
    </script>

</head>

<body>
<div class="wai">
    <div class="nei">
        <div class="biaoDan">
                <input type="password" name="oldPW" id="oldpw" placeholder="请输入原密码" class="em"><br>
                <input type="password" name="newPW" id="newpw" placeholder="请输入新密码" class="em"><br>
                <input type="password" name="newPWS" id="newpws" placeholder="请输入新密码" class="em"><br>
                <input type="submit" value="修改" class="sb" id="updatePW">
        </div>
    </div>
</div>
</body>
</html>