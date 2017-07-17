<%--
  Created by IntelliJ IDEA.
  User: c-kx
  Date: 2016/8/3
  Time: 2:54
--%>

<%@ page import="microclass.UserInfo" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'common.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'bootstrap.min.css')}" type="text/css">
    <g:javascript src="jquery-2.1.3.min.js"/>
    <g:javascript src="echarts.min.js"/>
    <g:javascript src="bootstrap.min.js"/>
    <g:javascript src="layer/layer.js" />
</head>

<body>
<div class="container-fluid">
    <div class="xiangxiziliao">
        <div class="l_userziliao">
            <div class="userheaderimg">
                <img src="${resource(dir: '',file: userInfo?.image)}" width="100" height="100">
            </div>
            <div class="user_ziliaotable">
                <div class="panel panel-success" style="margin:0;">
                    <div class="panel-body pan_hei">
                       <label> 姓名</label>
                           <span style=" text-align: center;display: block;margin-top: -25px;">${userInfo?.name}</span>
                    </div>

                </div>
                <div class="panel panel-success" style="margin:0;">
                    <div class="panel-footer pan_hei">
                        <label> 用户名</label>
                        <span style=" text-align: center;display: block;margin-top: -25px;">${userInfo?.userName}</span>
                    </div>
                </div>
                <div class="panel panel-success" style="margin:0;">
                    <div class="panel-body pan_hei">
                    <label> 邮箱</label>
                    <span style=" text-align: center;display: block;margin-top: -25px;">${userInfo?.email}</span>
                    </div>
                </div>
                <div class="panel panel-success" style="margin:0;">
                    <div class="panel-footer pan_hei">
                        <label> 手机号</label>
                        <span style=" text-align: center;display: block;margin-top: -25px;">${userInfo?.mobilePhone}</span>
                    </div>
                </div>

                <div class="panel panel-success" style="margin:0;">
                    <div class="panel-body pan_hei">
                        <label>学校</label>
                        <span style=" text-align: center;display: block;margin-top: -25px;">${userInfo?.school}</span>
                    </div>
                </div>

                <div class="panel panel-success" style="margin:0;">
                    <div class="panel-footer pan_hei">
                        <label> 院系</label>
                        <span style=" text-align: center;display: block;margin-top: -25px;">${userInfo?.college}</span>
                    </div>
                </div>

                <div class="panel panel-success" style="margin:0;">
                    <div class="panel-body pan_hei">
                        <label>工号</label>
                        <span style=" text-align: center;display: block;margin-top: -25px;">${userInfo?.code}</span>
                    </div>
                </div>

                <div class="panel panel-success" style="margin:0;">
                    <div class="panel-footer pan_hei">
                        <label> 职称</label>
                        <span style=" text-align: center;display: block;margin-top: -25px;">${userInfo?.position}</span>
                    </div>
                </div>

            </div>
            <g:if test="${userInfo?.isCheck==1}">
            <button class="btn btn-default"style=" float:right;margin-top: 20px; margin-left: 10px;" onclick="auditing('${userInfo.id}','2')" >未通过</button>
            <button class="btn btn-success"style=" float:right;margin-top: 20px;" onclick="auditing('${userInfo.id}','3')" >通过</button>
            </g:if>
        </div>
        <div class="r_usermap" >
            <div id="test" style="padding: 50px 0;margin-top: 50px;background-color: #fff; width: 500px;height:450px;margin: 50px auto;"></div>
        </div>
    </div>
</div>
<script type="text/javascript">
    function auditing(id,state) {
        $.ajax({
            url:'<g:createLink controller="adminInfo" action="auditing" />',
            type:'post',
            dataType:'json',
            data:{id:id,state:state},
            success:function(msg){
                layer.msg('操作成功', {
                    icon: 1,
                    time: 2000//时间设置无反应
                });
            }
        })
        
    }
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('test'));
    var spgk = ${spgk}
    var zygx = ${zygx}
    var count=spgk+zygx
    // 指定图表的配置项和数据
    var option = {
        backgroundColor: '#fff',//背景色
        title : {
            text: '课程类别',
            subtext: '共'+count+"门课程",
            x:'center'
        },
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            orient: 'vertical',
            left: 'left',
            data: ['视频公开课','资源共享课']
        },
        series : [
            {
                name: '课程类型',
                type: 'pie',
                radius : '55%',
                center: ['50%', '60%'],
                data:[
                    {value:spgk, name:'视频公开课'},
                    {value:zygx, name:'资源共享课'},

                ],
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }
        ]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
</script>
</body>
</html>