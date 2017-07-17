package microclass

import grails.converters.JSON
import microclass.converter.LuceneServices

import static org.springframework.http.HttpStatus.*
class CourseInfoController {

    /*
    * 前台首页
    * 课程列表页
    * */

    //删除课程
    def delCourse(String courseId){
        def courseInfo
        def classPeriodList
        def userId
        try {
            userId = session.userInfo.id
        }catch (Exception e){
            redirect(uri: '/')
            return
        }
        courseInfo = CourseInfo.get(courseId)//获取该课程
        classPeriodList = ClassPeriodInfo.findAllByCourseId(courseId)//获取该课程所有课时

        for (ClassPeriodInfo classPeriodInfo : classPeriodList) {
            def teachingPlan = ResourceInfo.get(classPeriodInfo.getTeachingPlan())//授课教案
            def homework = ResourceInfo.get(classPeriodInfo.getHomework())//作业习题
            def jieShao = ResourceInfo.get(classPeriodInfo.getJieShao())//本讲介绍

            //遍历删除每个课时里的文档资源
            teachingPlan?.delete(flush: true)
            homework?.delete(flush: true)
            jieShao?.delete(flush: true)

            //遍历删除每个课时
            classPeriodInfo?.delete(flush: true)
        }

        def declarationForm = ResourceInfo.get(courseInfo.declarationForm)//删除申报表
        def introduction = ResourceInfo.get(courseInfo.introduction)//删除课程介绍
        def program = ResourceInfo.get(courseInfo.program)//删除教学大纲
        def guidance = ResourceInfo.get(courseInfo.guidance)//删除实践指导
        def teachingMaterial = ResourceInfo.get(courseInfo.teachingMaterial)//删除指定教材
        def referenceDoc = ResourceInfo.get(courseInfo.referenceDoc)//删除参考文献
        def recommend = ResourceInfo.get(courseInfo.recommend)//删除课程推荐词

        //删除封面图片
        def images = ResourceInfo.findByCourseIdAndPurpose(courseId,"image");
        images?.delete(flush: true)

        //删除所有视频文档资源
        def resourceList = ResourceInfo.findAllByCourseIdAndPurpose(courseId,"classPeriod");

        for (ResourceInfo resourceInfo : resourceList) {
            resourceInfo?.delete(flush: true)
        }

        //删除课程所有上文档
        declarationForm?.delete(flush: true)//删除申报表
        introduction?.delete(flush: true)//删除课程介绍
        program?.delete(flush: true)//删除教学大纲
        guidance?.delete(flush: true)//删除实践指导
        teachingMaterial?.delete(flush: true)//删除指定教材
        referenceDoc?.delete(flush: true)//删除参考文献
        recommend?.delete(flush: true)//删除课程推荐词

        //最后删除课程===================================================================================================
        if (!courseInfo.delete(flush: true)){
            LuceneServices luceneServices=new LuceneServices()
            luceneServices.delIndex(courseInfo)
            redirect(controller: "userInfo", action: "myCourse")
        }else{
            redirect(controller: "userInfo", action: "myCourse")
        }
    }

    //收藏课程
    def collection(String courseId){
        print(courseId)
        def userId = null
        def collect
        try {
            userId = session.userInfo.id
        }catch (Exception e){
//            redirect(uri: '/')
            render(contentType: "application/json"){
                state = "100"
            }
            return
        }
            collect = Collect.findByUserIdAndCourseId(userId,courseId)
            if(collect){
                print("取消")
                collect.delete(flush: true)
                render(contentType: "application/json"){
                    state = "500"
                }
            }else {
                print("收藏")
                collect = new Collect()
                collect.userId=userId
                collect.courseId=courseId
                collect.save(flush: true)
                render(contentType: "application/json"){
                    state = "200"
                }
            }
    }

    def delete(String id) {
        def res=ResourceInfo.get(id)
        if(res.purpose.equals("classPeriod"))
            res?.delete(flush: true)
        def result = [success: true]
        render result as JSON
    }

    //创建课程页
    def createClazz(){
    }

    //测试上传框
    def test(){

    }

    //资源共享(视频公开)课资源上传
    def perfectClazz(String id){
        def courseInfo = CourseInfo.findById(id)
        print("课程类型======="+courseInfo.type)
        if(courseInfo.type.equals("视频公开课")){
            def image = ResourceInfo.findByPath(courseInfo.image)//封面图片
            def introduction = ResourceInfo.get(courseInfo.introduction)//课程介绍
            def recommend = ResourceInfo.get(courseInfo.recommend)//课程推荐词
            render(view: 'videoOpenClass',model: [image:image,courseInfo:courseInfo,introduction:introduction,recommend:recommend])
        }else {
            def image = ResourceInfo.findByPath(courseInfo.image)//封面图片
            def introduction = ResourceInfo.get(courseInfo.introduction)//课程介绍
            def declarationForm = ResourceInfo.get(courseInfo.declarationForm)//申报表
            def guidance = ResourceInfo.get(courseInfo.guidance)//实践指导
            def program = ResourceInfo.get(courseInfo.program)//教学大纲
            def teachingMaterial = ResourceInfo.get(courseInfo.teachingMaterial)//指定教材
            def referenceDoc = ResourceInfo.get(courseInfo.referenceDoc)//参考文献
            render(view: 'perfectClazz',model: [image:image,courseInfo:courseInfo,introduction:introduction,declarationForm:declarationForm,guidance:guidance,program:program,teachingMaterial:teachingMaterial,referenceDoc:referenceDoc])
        }
    }

//    预加载数据
    def index() {
        redirect(uri: '/')
    }
    def list(){
        def userId = null
        try {
            userId = session.userInfo.id
        }catch (Exception e){
            redirect(uri: '/')
            return
        }
        String search=params.search
        String page=params.pageNo
        int pageSize = 11;
        int pageNo = 1;
        int count = 0;
        def courseInfoList
        if(page!=null){
            pageNo=Integer.parseInt(page)
        }
        if ((search==null||search.equals(""))){
            courseInfoList=CourseInfo.findAllByUserIdAndState(userId,1,[max: pageSize, sort: "name", order: "asc", offset:(pageNo-1)*pageSize ])
            count=CourseInfo.countByUserIdAndState(userId,1)
        }else{
            courseInfoList=CourseInfo.findAllByUserIdAndNameIlikeAndState(userId,"%"+search+"%",1,[max: pageSize, sort: "name", order: "asc", offset:(pageNo-1) * pageSize])
            count=CourseInfo.countByUserIdAndNameIlikeAndState(userId,"%"+search+"%",1)
        }
        [courseInfoList:courseInfoList,pageNo:pageNo,count:count, totalPage:(int) Math.ceil((float) count / pageSize),search:search]
    }
    /*
    * 创建一个课程
    * 然后跳转到添加页面
    * */
    def add(String name,String type,String category){
        def userId = null
        try {
            userId = session.userInfo.id
        }catch (Exception e){
            redirect(uri: '/')
            return
        }
        CourseInfo courseInfo=new CourseInfo()
        courseInfo.name=name
        courseInfo.type=type
        courseInfo.category=category
        courseInfo.userId=userId
        courseInfo.introductionContent=""
        courseInfo.count=0
        courseInfo.save(flush: true)
        if(type.equals("视频公开课")){
            render(contentType: "application/json"){
                state = "200"
                courseInfoId = courseInfo.id
            }
        }
        else{
            render(contentType: "application/json"){
                state = "200"
                courseInfoId = courseInfo.id
            }
        }
//            render(view: 'perfectClazz',model: [couseInfo:courseInfo])
    }
    /*
    * 到课程修改页
    * */
    def update(String id){
        def courseInfo=CourseInfo.get(id)
        def introduction=ResourceInfo.get(courseInfo.introduction)
        def classPeriodInfoList=ClassPeriodInfo.findAllByCourseIdAndState(id,1)
        if(courseInfo.type.equals("视频公开课")){
            def recommend=ResourceInfo.get(courseInfo.recommend())
            render(view: 'updateVC',model: [couseInfo:courseInfo,classPeriodInfoList:classPeriodInfoList,introduction:introduction,recommend:recommend])
            return
        }
        def declarationForm=ResourceInfo.get(courseInfo.declarationForm)
        def teachingBody=ResourceInfo.get(courseInfo.teachingBody)
        def guidance=ResourceInfo.get(courseInfo.guidance)
        def program=ResourceInfo.get(courseInfo.program)
        def teachingMaterial=ResourceInfo.get(courseInfo.teachingMaterial)
        def referenceDoc=ResourceInfo.get(courseInfo.referenceDoc)
        [couseInfo:courseInfo,declarationForm:declarationForm,introduction:introduction,teachingBody:teachingBody,guidance:guidance,program:program,teachingMaterial:teachingMaterial,referenceDoc:referenceDoc,classPeriodInfoList:classPeriodInfoList]
    }
    /*
    *  完成课程(资源共享课)的添加
    *  课程的更新
    *  */
    def save(String id,String name,String type,String category,String image,String declarationForm,String introduction,String teachingBody,String program,String guidance,String teachingMaterial,String referenceDoc,String recommend){
        def courseInfo=CourseInfo.get(id)
//        courseInfo.name=name
//        courseInfo.type=type
//        courseInfo.category=category
        courseInfo.image=image
        courseInfo.declarationForm=declarationForm
        courseInfo.introduction=introduction
//        courseInfo.teachingBody=teachingBody
        courseInfo.guidance=guidance
        courseInfo.program=program
        courseInfo.teachingMaterial=teachingMaterial
        courseInfo.referenceDoc=referenceDoc
        courseInfo.recommend=recommend//课程推荐词
        courseInfo.state=1
        if(courseInfo.save(flush: true)){
            LuceneServices luceneServices=new LuceneServices()
            luceneServices.updateIndex(courseInfo)
            render(contentType: "application/json") {
                courseId=courseInfo.id
                state=200
            }
        }else{
            render(contentType: "application/json") {
                courseInfo=courseInfo
                state=500
            }
        }
    }


    /*
    *  完成课程(视频公开课)的添加
    *  课程的更新
    *  */
    def saveVideoClazz(String id,String name,String type,String category,String image,String declarationForm,String introduction,String teachingBody,String program,String guidance,String teachingMaterial,String referenceDoc,String recommend){
        def courseInfo=CourseInfo.get(id)
//        courseInfo.name=name
//        courseInfo.type=type
//        courseInfo.category=category
        courseInfo.image=image
        courseInfo.declarationForm=declarationForm
        courseInfo.introduction=introduction
//        courseInfo.teachingBody=teachingBody
        courseInfo.guidance=guidance
        courseInfo.program=program
        courseInfo.teachingMaterial=teachingMaterial
        courseInfo.referenceDoc=referenceDoc
        courseInfo.recommend=recommend//课程推荐词
        courseInfo.state=1
        if(courseInfo.save(flush: true)){
            render(contentType: "application/json") {
                LuceneServices luceneServices=new LuceneServices()
                luceneServices.updateIndex(courseInfo)
                courseId=courseInfo.id
                state=200
            }
        }else{
            render(contentType: "application/json") {
                courseInfo=courseInfo
                state=500
            }
        }
    }

    /*
    * 显示课程
    * */
    def show(String id){
        def courseInfo=CourseInfo.get(id)
        def userInfo=UserInfo.get(courseInfo.userId)
        def introduction=ResourceInfo.get(courseInfo.introduction)
        def classPeriodInfoList=ClassPeriodInfo.findAllByCourseIdAndState(id,1)
        if(courseInfo.type.equals("视频公开课")){
            def recommend=ResourceInfo.get(courseInfo.recommend())
            def classPeriodInfo=ClassPeriodInfo.get(classPeriodInfoList.get(0))
            def jieSao=ResourceInfo.get(classPeriodInfo.jieShao)
            def resourceInfo=ResourceInfo.findByClassPeriodIdAndPurpose(classPeriodInfo.id,"classPeriod")
            render(view: 'showVC',model: [couseInfo:courseInfo,classPeriodInfoList:classPeriodInfoList,introduction:introduction,recommend:recommend,jieSao:jieSao,resourceInfo:resourceInfo,userInfo:userInfo])
            return
        }
        def declarationForm=ResourceInfo.get(courseInfo.declarationForm)
        def teachingBody=ResourceInfo.get(courseInfo.teachingBody)
        def guidance=ResourceInfo.get(courseInfo.guidance)
        def program=ResourceInfo.get(courseInfo.program)
        def teachingMaterial=ResourceInfo.get(courseInfo.teachingMaterial)
        def referenceDoc=ResourceInfo.get(courseInfo.referenceDoc)
        [couseInfo:courseInfo,declarationForm:declarationForm,introduction:introduction,teachingBody:teachingBody,guidance:guidance,program:program,teachingMaterial:teachingMaterial,referenceDoc:referenceDoc,classPeriodInfoList:classPeriodInfoList,userInfo:userInfo]
    }



/*
    * 以下方法为app方法
    * */
    def getCourseInfoList_app(String pageNo,String search,String page,String userId){
        print "${pageNo}==${search}==${page}==${userId}"
        int pageN=Integer.parseInt(pageNo)
        int pageSize = 12
        def courseInstanceList
        int count
        if(userId!=null&&!userId.trim().equals("")){
            def collectList=Collect.findAllByUserId(userId).courseId
            courseInstanceList=CourseInfo.findAllByIdInListAndState(collectList,1,[max: pageSize, sort: "dateCreated", order: "asc", offset:(pageN-1)*pageSize ])
            count=CourseInfo.countByUserIdInListAndState(collectList,1)
        }else if(page==null||page.trim().equals("")){
            if(search==null||search.trim().equals("")){
                courseInstanceList=CourseInfo.findAllByState(1,[max: pageSize, sort: "dateCreated", order: "asc", offset:(pageN-1)*pageSize ])
                count=CourseInfo.countByState(1)
                print "searc2"
            }else{
                print "search"
                courseInstanceList=CourseInfo.findAllByStateAndNameIlike(1,"%"+search+"%",[max: pageSize, sort: "dateCreated", order: "asc", offset:(pageN-1)*pageSize ])
                count=CourseInfo.countByStateAndNameIlike(1,"%"+search+"%")
            }
        }else{
            if(search==null||search.trim().equals("")){
                courseInstanceList=CourseInfo.findAllByTypeAndState(page,1,[max: pageSize, sort: "dateCreated", order: "asc", offset:(pageN-1)*pageSize ])
                count=CourseInfo.countByStateAndType(1,page)
            }else {
                print "search1"
                courseInstanceList=CourseInfo.findAllByTypeAndNameIlikeAndState(page,"%"+search+"%",1,[max: pageSize, sort: "dateCreated", order: "asc", offset:(pageN-1)*pageSize ])
                count=CourseInfo.countByStateAndTypeAndName(1,page,"%"+search+"%")
            }

        }
        render(contentType: "application/json", status: OK) {
            listLenth=courseInstanceList.size()
            totalPage=(int) Math.ceil((float) count / pageSize)
            courseInfoList=courseInstanceList
        }
    }
    /*
    * 获取课程信息
    * return ：userInfo,courseInfo,classPeriodList,collectState
    * */
    def getCourseInfo_app(String courseId,String userId){
        print "getCourseInfo_app,用户ID：${userId}"
        def userInstance
        def courseInstance
        def classPeriodInfoList
        def collectState=0
        if(userId!=null&&!userId.trim().equals("")){
            if(Collect.findAllByUserIdAndCourseId(userId,courseId)){
                collectState=1
            }
        }
        courseInstance=CourseInfo.get(courseId);
        userInstance=UserInfo.get(courseInstance.userId)
        classPeriodInfoList=ClassPeriodInfo.findAllByCourseId(courseId)
        def s=ResourceInfo.findByCourseIdAndPurpose(courseId,"introduction").content
        if(s.length()>150){
            s=s.substring(0,150)+"..."
        }
        courseInstance.introduction= s
        render(contentType: "application/json", status: OK) {
            collect=collectState
            listSize=classPeriodInfoList.size()
            courseInfo=courseInstance
            userInfo=userInstance
            classPeriodList=classPeriodInfoList
        }
    }
    /*
    * 获取课时详情
    * */
    def getClassPeriodInfo_app(String classPeriodId){
        print 'getClassPeriodInfo_app'
        def classPeriod
        classPeriod=ClassPeriodInfo.get(classPeriodId)
        classPeriod.image=ResourceInfo.findByClassPeriodIdAndPurposeAndType(classPeriodId,"classPeriod","video").path
        print classPeriod.image
        def s=ResourceInfo.get(classPeriod.jieShao).content
        if(s.length()>220){
            s=s.substring(0,220)+"..."
        }
        classPeriod.jieShao=s
        render(contentType: "application/json", status: OK) {
            classPeriodInfo=classPeriod
        }
    }
    /*
    * 收藏/取消收藏
    * return 1:收藏成功；0：取消收藏成功
    * */
    def doCollect_app(String courseId,String userId){

        def collect =Collect.findByUserIdAndCourseId(userId,courseId)
        if(collect){
            collect.delete(flush: true)
            render(contentType: "application/json", status: OK) {
                state=0
            }
        }else {
            collect=new Collect()
            collect.userId=userId
            collect.courseId=courseId
            collect.save(flush: true)
            render(contentType: "application/json", status: OK) {
                state=1
            }
        }
    }

}
