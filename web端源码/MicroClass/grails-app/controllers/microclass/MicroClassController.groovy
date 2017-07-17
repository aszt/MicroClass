package microclass

import microclass.converter.LuceneServices
import microclass.util.FileUtils

class MicroClassController {

    def error(){

    }
    def show2(){
        def id =params.id
        def firstUrl = ResourceInfo.get(id).convertPath
        [firstUrl:firstUrl]
    }

    def index() {
        print "m预加载执行了"

        def courseLunboList
        courseLunboList = CourseInfo.findAllByStateAndIsCarousel(1,1)



        def newCourseList
        newCourseList = CourseInfo.findAllByState(1,[max: 10,sort: "dateCreated", order: "desc", offset: 0])

        def countCourseList
        countCourseList = CourseInfo.findAllByState(1,[max: 10,sort: "count", order: "desc", offset: 0])



        def literature//文学
        def language//语言
        def philosophy//哲学
        def history//历史
        def religion//宗教
        def art//艺术
        def economics//经济
        def politics//政治
        def law//法律
        def geography//地理

        def education//教育
        def psychology//心理
        def management//管理
        def media//传播
        def sociology//社会
        def speech//演讲
        def mathematics//数学
        def physics//物理
        def chemistry//化学
        def biology//生物
        def geoscience//地球科学
        def computer//计算机
        def medicine//医学
        literature = CourseInfo.findAllByCategoryAndState("文学",1)
        language = CourseInfo.findAllByCategoryAndState("语言",1)
        philosophy = CourseInfo.findAllByCategoryAndState("哲学",1)
        history = CourseInfo.findAllByCategoryAndState("历史",1)
        religion = CourseInfo.findAllByCategoryAndState("宗教",1)
        art = CourseInfo.findAllByCategoryAndState("艺术",1)
        economics = CourseInfo.findAllByCategoryAndState("经济",1)
        politics = CourseInfo.findAllByCategoryAndState("政治",1)
        law = CourseInfo.findAllByCategoryAndState("法律",1)
        geography = CourseInfo.findAllByCategoryAndState("地理",1)
        education = CourseInfo.findAllByCategoryAndState("教育",1)
        psychology = CourseInfo.findAllByCategoryAndState("心理",1)
        management = CourseInfo.findAllByCategoryAndState("管理",1)
        media = CourseInfo.findAllByCategoryAndState("传播",1)
        sociology = CourseInfo.findAllByCategoryAndState("社会",1)
        speech = CourseInfo.findAllByCategoryAndState("演讲",1)
        mathematics = CourseInfo.findAllByCategoryAndState("数学",1)
        physics = CourseInfo.findAllByCategoryAndState("物理",1)
        chemistry = CourseInfo.findAllByCategoryAndState("化学",1)
        biology = CourseInfo.findAllByCategoryAndState("生物",1)
        geoscience = CourseInfo.findAllByCategoryAndState("地球科学",1)
        computer = CourseInfo.findAllByCategoryAndState("计算机",1)
        medicine = CourseInfo.findAllByCategoryAndState("医学",1)
        [literature: literature, language: language, philosophy: philosophy, history: history, religion: religion, art: art, economics: economics,
         politics  : politics, law: law, geography: geography, education: education, psychology: psychology, management: management,
         media     : media, sociology: sociology, speech: speech, mathematics: mathematics, physics: physics, chemistry: chemistry, biology: biology,
         geoscience: geoscience, computer: computer, medicine: medicine,newCourseList:newCourseList,countCourseList:countCourseList,courseLunboList:courseLunboList
        ]
    }

    //课程详情页
    def courseDetails(String id) {
        def courseInfo
        def userInfo
        def clazzInfoList
        def declarationForm //申报表
        def introduction    //课程介绍
        def program         //教学大纲
        def guidance        //实践指导
        def teachingMaterial//指定教材
        def referenceDoc    //参考文献
        def recommend       //课程推荐词（用于视频公开课）



        courseInfo = CourseInfo.findById(id);
        courseInfo.count=courseInfo.count+1
        courseInfo.save(flush: true)
        userInfo = UserInfo.findById(courseInfo.userId)
        clazzInfoList = ClassPeriodInfo.findAllByCourseIdAndState(id,1)

//        返回课程资源
        declarationForm = ResourceInfo.findById(courseInfo.declarationForm)
        introduction = ResourceInfo.findById(courseInfo.introduction)
        program = ResourceInfo.findById(courseInfo.program)
        guidance = ResourceInfo.findById(courseInfo.guidance)
        teachingMaterial = ResourceInfo.findById(courseInfo.teachingMaterial)
        referenceDoc = ResourceInfo.findById(courseInfo.referenceDoc)
        recommend = ResourceInfo.findById(courseInfo.recommend)
        def collectState=0

        def cid = session?.userInfo?.id

        print(cid+"=============")
        if(cid!=null&&!cid.trim().equals("")){
            if(Collect.findAllByUserIdAndCourseId(session.userInfo.id,id)){
                collectState=1
            }
        }

        [courseInfo     : courseInfo, userInfo: userInfo, clazzInfoList: clazzInfoList,
         declarationForm: declarationForm, introduction: introduction, program: program,
         guidance       : guidance, teachingMaterial: teachingMaterial, referenceDoc: referenceDoc,
         recommend      : recommend,collectState:collectState
        ]

    }

    //(视频/资源)课播放(课程id)
    def play(String id, String clazzId) {
        def courseInfo
        def userInfo
        def clazzInfoList
        def clazzInfo
        def introduction
        def recommend
        def jieShao
        def videoResource
        def videoResourceList
        def wordResourceList
        def teachingPlan
        def homework

        courseInfo = CourseInfo.findById(id)
        courseInfo.count=courseInfo.count+1
        courseInfo.save(flush: true)
        userInfo = UserInfo.findById(courseInfo.userId)
        clazzInfoList = ClassPeriodInfo.findAllByCourseIdAndState(id,1)
        introduction = ResourceInfo.findById(courseInfo.introduction)//课程介绍
        recommend = ResourceInfo.findById(courseInfo.recommend)//课程推荐词（用于视频公开课）

        if (courseInfo.type.equals("视频公开课")) {

            if (clazzId == null) {
                clazzInfo = ClassPeriodInfo.findByCourseIdAndOrderNum(id, 1)
            } else {
                print("有课时id进入了==============" + clazzId)
                clazzInfo = ClassPeriodInfo.findById(clazzId)
            }

            print(clazzInfo.jieShao + "===============")
            jieShao = ResourceInfo.findById(clazzInfo.jieShao)//本讲介绍
            videoResource = ResourceInfo.findByClassPeriodIdAndPurpose(clazzInfo.id, "classPeriod")
            print(videoResource.path)
            //找到指定课时的
            teachingPlan = ResourceInfo.findById(clazzInfo.teachingPlan)
            homework = ResourceInfo.findById(clazzInfo.homework)


            def collectState=0
            def cid = session?.userInfo?.id
            print(cid+"=============")
            if(cid!=null&&!cid.trim().equals("")){
                if(Collect.findAllByUserIdAndCourseId(session.userInfo.id,id)){
                    collectState=1
                }
            }


            videoResourceList = ResourceInfo.findAllByCourseIdAndPurpose(id, "classPeriod")//返回所有视频资源
            render(view: 'videoOpen', model: [courseInfo: courseInfo, userInfo: userInfo, clazzInfo: clazzInfo, clazzInfoList: clazzInfoList, introduction: introduction, recommend: recommend, jieShao: jieShao, videoResource: videoResource, videoResourceList: videoResourceList,collectState:collectState])
        } else {

            if (clazzId == null) {
                clazzInfo = ClassPeriodInfo.findByCourseIdAndOrderNum(id, 1)
            } else {
                print("有课时id进入了==============" + clazzId)
                clazzInfo = ClassPeriodInfo.findById(clazzId)
            }

            jieShao = ResourceInfo.findById(clazzInfo.jieShao)
            videoResourceList = ResourceInfo.findAllByClassPeriodIdAndPurposeAndType(clazzInfo.id, "classPeriod", "video")
            videoResource=videoResourceList.get(0)
            print(videoResource.path)
            teachingPlan = ResourceInfo.findById(clazzInfo.teachingPlan)//授课教案
            homework = ResourceInfo.findById(clazzInfo.homework)//作业习题

            //返回文档资源
            wordResourceList = ResourceInfo.findAllByClassPeriodIdAndPurposeAndType(clazzInfo.id, "classPeriod", "word")
            //返回视频资源
           // videoResourceList = ResourceInfo.findAllByClassPeriodIdAndPurposeAndType(clazzInfo.id, "classPeriod", "video")
            render(view: 'resourceShare', model: [courseInfo: courseInfo, userInfo: userInfo, clazzInfo: clazzInfo, clazzInfoList: clazzInfoList, introduction: introduction, recommend: recommend, jieShao: jieShao, videoResource: videoResource, videoResourceList: videoResourceList, teachingPlan: teachingPlan, homework: homework, wordResourceList: wordResourceList])
        }

    }
    def playOther(String id){
        def courseInfo
        def userInfo
        def clazzInfoList
        def clazzInfo
        def introduction
        def recommend
        def jieShao
        def videoResource
        def videoResourceList
        def wordResourceList
        def teachingPlan
        def homework
        def courseId=ResourceInfo.get(id).getCourseId()
        courseInfo = CourseInfo.findById(courseId)
        userInfo = UserInfo.findById(courseInfo.userId)
        clazzInfoList = ClassPeriodInfo.findAllByCourseIdAndState(courseId,1)
        introduction = ResourceInfo.findById(courseInfo.introduction)//课程介绍
        recommend = ResourceInfo.findById(courseInfo.recommend)//课程推荐词（用于视频公开课）
        clazzInfo = ClassPeriodInfo.findById(ResourceInfo.get(id).classPeriodId)

        print(clazzInfo.jieShao + "===============")
        jieShao = ResourceInfo.findById(clazzInfo.jieShao)//本讲介绍
        videoResource = ResourceInfo.get(id);
        videoResourceList = ResourceInfo.findAllByClassPeriodIdAndPurposeAndType(clazzInfo.id, "classPeriod", "video")
        print(videoResource.path)
        //找到指定课时的
        teachingPlan = ResourceInfo.findById(clazzInfo.teachingPlan)
        homework = ResourceInfo.findById(clazzInfo.homework)
        wordResourceList = ResourceInfo.findAllByClassPeriodIdAndPurposeAndType(clazzInfo.id, "classPeriod", "word")
        print("资源共享课要播放的视频========"+id)
        render(view: 'resourceShare', model: [courseInfo: courseInfo, userInfo: userInfo, clazzInfo: clazzInfo, clazzInfoList: clazzInfoList, introduction: introduction, recommend: recommend, jieShao: jieShao, videoResource: videoResource, videoResourceList: videoResourceList, teachingPlan: teachingPlan, homework: homework, wordResourceList: wordResourceList])
    }
    def search(String keyWord) {
        def CourseInfoList

        if (keyWord == null || keyWord.equals("")) {
            redirect(uri: '/')
            return
        }

        print(keyWord)

        //全文检索
        LuceneServices ls = new LuceneServices();
        CourseInfoList = ls.findIndex(keyWord , 0, 50)
        ['CourseInfoList': CourseInfoList, nextLoadingNumber: 50, 'search': keyWord, 'fillType': "home"]

        //字段检索
//        CourseInfoList = CourseInfo.findAllByNameIlikeOrCategoryIlike("%"+keyWord+"%","%"+keyWord+"%")
//        [CourseInfoList:CourseInfoList,keyWord:keyWord]

    }

    //按类型查找
    def typeFind(Integer max,String type){
        print("类型为=========="+type)
        params.max = Math.min(max ?: 10, 100)
        print(params.offset + "======从多少条开始")
        print(params.max + "=========最多加载多少条")
        def findCourseList//查找条数
        def courseList//总条数
        def pageSize = 10

        courseList = CourseInfo.findAllByType(type)
        if (params.offset == 0 || params.offset == null) {
            findCourseList = CourseInfo.findAllByTypeAndState(type,1,[max: pageSize, sort: "name", order: "asc", offset: 0])
        } else {
            findCourseList = CourseInfo.findAllByTypeAndState(type,1,[max: pageSize, sort: "name", order: "asc", offset: params.offset])
        }
//        print("查找条数"+findCourseList)
        render(view: 'list',model: [params:params,courseList:courseList.size(),CourseInfoList:findCourseList])
    }

}
