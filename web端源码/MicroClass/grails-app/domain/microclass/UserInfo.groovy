package microclass
class UserInfo {
    String id
    String userName //用户名
    String email //注册邮箱
    String password //密码
    int state=0 //激活状态，0未激活，1正常，2禁用
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
    String collect=""//收藏的课程Id
    static constraints = {
        userName(blank: false)
        email(blank: false)
        password(blank: false)
        name(nullable: true)
        sex(nullable: true)
        mobilePhone(nullable: true)
        image (nullable: true)
        school(nullable: true)
        college(nullable: true)
        position(nullable: true)
        introduction(nullable: true)
        code(nullable: true)
        isCheck(nullable:true)
        state(blank:false)
        activateCode(blank: false)
        collect(nullable: true)
    }
    static mapping = {
        id generator: 'uuid.hex'
    }
    String toString() {
        return userName
    }
}
