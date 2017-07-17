package microclass

class ClassPeriodInfoController {

    //删除课时信息
    def delClazz(String clazzId,String courseId){
        def userId
        def classPeriodInfo
        try {
            userId = session.userInfo.id
        }catch (Exception e){
            redirect(uri: '/')
            return
        }

        //获取该课时
        classPeriodInfo = ClassPeriodInfo.get(clazzId)

        def teachingPlan = ResourceInfo.get(classPeriodInfo.getTeachingPlan())//授课教案
        def homework = ResourceInfo.get(classPeriodInfo.getHomework())//作业习题
        def jieShao = ResourceInfo.get(classPeriodInfo.getJieShao())//本讲介绍
        def resourceList = ResourceInfo.findAllByCourseIdAndPurpose(courseId,"classPeriod");

        //删除课时资源
        for (ResourceInfo resourceInfo : resourceList) {
            resourceInfo?.delete(flush: true)
        }

        //遍历删除该课时里的文档资源
        teachingPlan?.delete(flush: true)
        homework?.delete(flush: true)
        jieShao?.delete(flush: true)

        //删除该课时
        if(!classPeriodInfo.delete(flush: true)){
            render(contentType: "application/json") {
                state=200
            }
        }else{
            render(contentType: "application/json") {
                state=500
            }
        }

    }

    //资源共享课播放页
    def resourceShare(){

    }

    //查看课时列表
    def seeClazzList(String id){
        print(id+"=============================================")
        def clazzList
        clazzList = ClassPeriodInfo.findAllByCourseIdAndState(id,1)
        if(clazzList.size()<1){
            print("还没有课时，快去添加吧")
            [courseId:id]
        }else{
            [clazzList:clazzList,courseId:id]
        }

    }

    //跳转至课时添加页
    def saveClassHour(String id){
        def userId = null
        try {
            userId = session.userInfo.id
        }catch (Exception e){
            redirect(uri: '/')
            return
        }
        def courseInfo=CourseInfo.get(id)
        def classPeriodInfo=new ClassPeriodInfo()
        classPeriodInfo.courseId=courseInfo.id
        classPeriodInfo.userId=userId
        classPeriodInfo.save(flush: true)
        print(classPeriodInfo.id+"===========课时id")
        if(courseInfo.type.equals("视频公开课")){
            render(view: 'saveVideoHour',model: [courseInfoInstance:courseInfo,classPeriodInfo:classPeriodInfo])
        }
        else
            [courseInfoInstance:courseInfo,classPeriodInfo:classPeriodInfo]
    }

    /*
    * 到课时修改页
    * String id
    String name //课时名称
    int orderNum //序号
    Date dateCreated //课时创建时间
    String teachingPlan //授课教案/教学教案
    String homework//作业习题
    String userId //课时创建者
    String courseId //课程id
    String jieShao//本讲介绍/要求
    int state=0
    String image//课时图片
    * */
    def update(String id){
        def classPeriodInfo = ClassPeriodInfo.get(id)
        def courseInfo = CourseInfo.get(classPeriodInfo.courseId)
        def jieShao = ResourceInfo.findByClassPeriodIdAndPurpose(id,"jieShao")
        if(courseInfo.type.equals("视频公开课")){
            def resourceInfo = ResourceInfo.findByClassPeriodIdAndPurpose(id,"classPeriod")
            render(view: 'saveVideoHour',model: [classPeriodInfo:classPeriodInfo,courseInfoInstance:courseInfo,jieShao:jieShao,resourceInfo:resourceInfo])
        }else{
            def teachingPlan=ResourceInfo.findByClassPeriodIdAndPurpose(id,"teachingPlan")//授课教案
            def homework=ResourceInfo.findByClassPeriodIdAndPurpose(id,"homework")//作业习题
            def resourceInfoVList=ResourceInfo.findAllByClassPeriodIdAndPurposeAndType(id,"classPeriod","video")//视频资源
            def resourceInfoWList=ResourceInfo.findAllByClassPeriodIdAndPurposeAndType(id,"classPeriod","word")//文档资源
            def resourceInfoList=ResourceInfo.findAllByClassPeriodIdAndPurpose(id,"classPeriod")//所有资源
            print(resourceInfoList.size()+"=================")
            render(view: 'saveClassHour',model: [classPeriodInfo:classPeriodInfo,courseInfoInstance:courseInfo,jieShao:jieShao,teachingPlan:teachingPlan,homework:homework,resourceInfoVList:resourceInfoVList,resourceInfoWList:resourceInfoWList,resourceInfoList:resourceInfoList])
        }
    }
    /*
    * 添加课时
    * 修改课时
    * */
    def save(String id,String name,String teachingPlan,String homework,String jieShao,int orderNum){
        print("执行了=============")
        def classPeriodInfo=ClassPeriodInfo.get(id)
//        def resourceInfoList=ResourceInfo.findAllByClassPeriodIdAndPurpose(id,"classPeriod")
//        if(resourceInfoList.size()<1){
//            render(contentType: "application/json") {
//                classPeriodInfo=classPeriodInfo
//                state=300
//            }
//            return
//        }
//         classPeriodInfo.image=resourceInfoList.get(0).preImgPath
        classPeriodInfo.name=name
        classPeriodInfo.orderNum=orderNum
        classPeriodInfo.teachingPlan=teachingPlan
        classPeriodInfo.homework=homework
        classPeriodInfo.jieShao=jieShao
        classPeriodInfo.state=1
        if(classPeriodInfo.save(flush: true)){
            render(contentType: "application/json") {
                classPeriodInfo=classPeriodInfo
                state=200
            }
    }else{
        render(contentType: "application/json") {
            classPeriodInfo=classPeriodInfo
            state=500
        }
    }
    }
    /*
     * 显示课程
     * */
    def show(String id){
        def classPeriodInfo=ClassPeriodInfo.get(id)
        def courseInfo=CourseInfo.get(classPeriodInfo.courseId)
        def userInfo=UserInfo.get(classPeriodInfo.userId)
        def jieShao=ResourceInfo.get(classPeriodInfo.jieShao)
        if(courseInfo.type.equals("视频公开课")){
            def introduction=ResourceInfo.get(courseInfo.introduction)
            def classPeriodInfoList=ClassPeriodInfo.findAllByCourseIdAndState(courseInfo.id,1)
            def recommend=ResourceInfo.get(courseInfo.recommend())
            def resourceInfo=ResourceInfo.findByClassPeriodIdAndPurpose(classPeriodInfo.id,"classPeriod")
            render(view: 'showVC',model: [couseInfo:courseInfo,classPeriodInfoList:classPeriodInfoList,introduction:introduction,recommend:recommend,jieSao:jieShao,resourceInfo:resourceInfo,userInfo:userInfo])
            return
        }
        def teachingPlan=ResourceInfo.findByClassPeriodIdAndPurpose(id,"teachingPlan")
        def homework=ResourceInfo.findByClassPeriodIdAndPurpose(id,"homework")
        def resourceInfoVList=ResourceInfo.findAllByClassPeriodIdAndPurposeAndType(id,"classPeriod","video")
        def resourceInfoWList=ResourceInfo.findAllByClassPeriodIdAndPurposeAndType(id,"classPeriod","word")
        [classPeriodInfo:classPeriodInfo,jieShao:jieShao,teachingPlan:teachingPlan,homework:homework,resourceInfoVList:resourceInfoVList,resourceInfoWList:resourceInfoWList,userInfo:userInfo]
    }
}
