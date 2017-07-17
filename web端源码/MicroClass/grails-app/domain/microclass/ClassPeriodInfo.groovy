package microclass

class ClassPeriodInfo {
    String id
    String name //课时名称
    int orderNum //序号
    Date dateCreated //课时创建时间
    String teachingPlan //授课教案/教学教案
    String homework//作业习题
    String userId //课时创建者
    String courseId //课程id
    String jieShao//本讲介绍/要求
    int state=0
    String image//课时图片(视频缩略图)
    static constraints = {
        name(nullable: true)
        orderNum(nullable: true)
        teachingPlan(nullable: true)
        homework(nullable: true)
        jieShao(nullable: true)
        userId(blank: true)
        courseId(blank: true)
        image(nullable: true)
    }
    static mapping = {
        id generator: 'uuid.hex'
    }
    String toString(){
        return name
    }
}
