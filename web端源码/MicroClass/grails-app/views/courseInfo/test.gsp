<%--
  Created by IntelliJ IDEA.
  User: tong
  Date: 2016/11/2
  Time: 19:26
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>测试</title>
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'bootstrap.min.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'fileinput.min.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'test.css')}" type="text/css">
    <g:javascript src="jquery-2.1.3.min.js"/>
    <g:javascript src="bootstrap.min.js"/>
    <g:javascript src="fileinput.js"/>
    <g:javascript src="fileinput_locale_zh.js"/>

</head>


<body>
<div style="height: 200px;width: 500px">
<label class="control-label">选择文件</label>
<input id="input-44" name="input44[]" type="file" multiple class="file-loading">
<div id="errorBlock" class="help-block"></div>
</div>
<script>
    $(document).on('ready', function() {
        $("#input-44").fileinput({
            uploadUrl: '/file-upload-batch/2',
            maxFilePreviewSize: 10240
        });
    });
</script>
</body>
</html>