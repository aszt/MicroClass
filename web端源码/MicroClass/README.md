# MicroClass
## 领域类
* User(用户)：用户名，邮箱，密码（注册），姓名，性别，头像，联系方式（个人中心），职称，学校，院系，简介（教师认证），是否是老师
* Admin（管理员）：用户名，密码
* Course（课程）：课程申报表，课程简介，教师队伍，教学大纲，实践指导（学习指南），资源下载，指定教材，参考文献，课程负责人，课时，课程名称，课程类型，课程类别，图片
* ClassPeriod（课时）：授课教案，作业习题，资源
* Resources（课程资源）：资源名称，资源地址

## 精品资源共享课程
* 课程最新申报表
* 课程简介
* 教师队伍
* 教学大纲
* 授课教案
* 作业习题
* 实践指导
* 指定教材
* 参考文献目录
* 教学录像

## 精品视频公开课
* 每门课程至少5讲

 	String id
    String userName //用户名
    String email //注册邮箱
    String password //密码
    int state //激活状态，0未激活，1正常，3禁用
    String activateCode //激活码
    String name //真实姓名
    String sex //性别
    String mobilePhone //联系方式
    String image //头像
    String school //学校
    String college //院系
    String code //教师工号
    String position //职称
    String introduction //个人简介
    int isTeacher=0//是否是老师(0不是老师，1是老师)
    int isCheck=0 //0是未提交审核信息，1是审核中，2审核失败，3审核成功
    
    
    
    管理员：