<%--
  Created by IntelliJ IDEA.
  User: c-kx
  Date: 2016/11/16
  Time: 20:59
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>信息反馈</title>
    <g:javascript src="layer/layer.js"/>
    <g:javascript src="jquery-2.1.3.min.js"/>
    <style>
        .a{
            width: 100%;
            margin-top: 30px;
        }
        .b{
            border: 0px solid #00BDEF;
            width: 500px;
            margin: 0 auto;
        }
        .c{
            margin-left: 60px
        }
        h3{
            color: #8a6d3b;
        }
        .q1{
            /*float: left;*/
            width: 80px;
            height:30px;
            border-radius: 10px;
            border: 0px;
            background-color: #2CA368;
            margin-top: 20px;
            margin-right: 15px;
        }
        .d{
            margin-left: 280px;
        }
    </style>
</head>

<body>
<div class="a">
    <div class="b">
            <h3>请详细描述您的建议、意见、问题等</h3>
            <textarea cols="60" rows="15" placeholder="建议不超过500字左右" id="introduction" class="c"></textarea><br>
            <div class="d">
            <button id="save" class="q1" style="color: white" onclick="save();">提交</button>
            <button id="cancel" class="q1" style="color: white" onclick="save();" >下次吧</button>
            </div>
    </div>
</div>
</body>
<script type="application/javascript">
    function save() {
        var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
        parent.layer.close(index); //执行关闭
    }
</script>
</html>