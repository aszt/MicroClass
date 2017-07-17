package microclass

class CourseInfo {
    String id
    Date dateCreated //课程创建时间
    String userId//课程负责人
    String name //课程名称
    String type //课程类型（资源共享课，还是视频公开课）
    String category//课程类别
    int state=0//记录当前课程状态
    String image //课程图片

    String declarationForm //申报表
    String introduction //简介(课程介绍)
    String teachingBody //教师队伍（记录参与老师id）
    String program //教学大纲
    String guidance//实践指导
    String teachingMaterial//指定教材
    String referenceDoc//参考文献
    String recommend//课程推荐词（用于视频公开课）
    String introductionContent
    int count=0//统计点击次数
    int isCarousel=0//是否轮播，0不轮播，1轮播
    static constraints = {
        declarationForm(nullable: true)
        introduction(nullable: true)
        teachingBody(nullable: true)
        program(nullable: true)
        guidance(nullable: true)
        teachingMaterial(nullable: true)
        referenceDoc(nullable: true)
        userId(nullable: true)
        teachingBody(nullable: true)
        image(nullable: true)
        type(nullable: true)
        name(nullable: true)
        category(nullable: true)
        recommend(nullable: true)
        introductionContent(nullable: true)
        count(nullable: true)
        isCarousel(nullable: true)
    }
    static mapping = {
        id generator: 'uuid.hex'
    }
    String toString(){
        return name
    }
}
