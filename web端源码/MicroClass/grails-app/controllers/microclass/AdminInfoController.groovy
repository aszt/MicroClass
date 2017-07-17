package microclass

class AdminInfoController {
    /*跳转到管理员登陆页*/

    def login() {
    }
    /*
    * 管理员登陆方法
    * */

    def doLogin(String name, String password) {
        def adminInstance = AdminInfo.findByNameAndPassword(name, password)
        if (adminInstance) {
            session.adminInfo = adminInstance
            redirect(uri: '/adminInfo/index')
        } else {
            flash.message = "用户名或者密码错误！"
            redirect(uri: '/adminInfo/login')
        }
    }
    /*
    * 用户列表
    * */

    def index() {
        def todo = params.id
        print todo
        try {
            def admin = session.adminInfo.name
        } catch (Exception e) {
            flash.message = "登录失效"
            redirect(uri: '/adminInfo/login')
            return
        }
        String search = params.search
        String page = params.pageNo
        int pageSize = 11;
        int pageNo = 1;
        int count = 0;
        int auditing
        def userInfoList
        if (page != null) {
            pageNo = Integer.parseInt(page)
        }
        if (todo == null || todo.equals("")) {
            if ((search == null || search.equals(""))) {
                userInfoList = UserInfo.list([max: pageSize, sort: "name", order: "asc", offset: (pageNo - 1) * pageSize])
                auditing = UserInfo.countByIsCheck(1)
                count = UserInfo.count()
            } else {
                userInfoList = UserInfo.findAllByUserNameIlikeOrNameIlike("%" + search + "%", "%" + search + "%", [max: pageSize, sort: "name", order: "asc", offset: (pageNo - 1) * pageSize])
                auditing = UserInfo.countByIsCheck(1)
                count = UserInfo.countByUserNameIlikeOrNameIlike("%" + search + "%", "%" + search + "%")
            }
        } else {
            if ((search == null || search.equals(""))) {
                userInfoList = UserInfo.findAllByIsCheck(1,[max: pageSize, sort: "name", order: "asc", offset: (pageNo - 1) * pageSize])
                auditing = UserInfo.countByIsCheck(1)
                count = auditing
            } else {
                def userInfoIdList = UserInfo.findAllByUserNameIlikeOrNameIlike("%" + search + "%", "%" + search + "%").id
                userInfoList=UserInfo.findAllByIdInListAndIsCheck(userInfoIdList,1)
                auditing = UserInfo.countByIdInListAndIsCheck(userInfoIdList,1)
                count = auditing
            }
        }
        [userInfoList: userInfoList, pageNo: pageNo, count: count, totalPage: (int) Math.ceil((float) count / pageSize), search: search, auditing: auditing]
    }
    /*
    * 改变用户状态
    * */

    def changeState(String id) {
        def userInfo = UserInfo.get(id)
        if (userInfo.state == 1) {
            userInfo.state = 2
        } else {
            userInfo.state = 1
        }
        userInfo.save(flush: true)
        render(contentType: "application/json") {
            state = userInfo.state
        }
    }
    /*
    * 显示用户详情
    * */

    def showUser(String id) {
        def gk = 0
        def gx = 0
        def userInfoInstance = UserInfo.get(id)
        if (userInfoInstance.isTeacher == 1) {
            gk = CourseInfo.countByUserIdAndType(id, "视频公开课")
            gx = CourseInfo.countByUserIdAndType(id, "资源共享课")
        } else {
            List courseIdList = Collect.findAllByUserId(id)
            gk = CourseInfo.findAllByIdInListAndType(courseIdList, "视频公开课")
            gx = CourseInfo.findAllByIdInListAndType(courseIdList, "资源共享课")
        }
        [userInfo: userInfoInstance, zygx: gx, spgk: gk]
    }
    /*
    * 审核成为老师申请
    * */

    def auditing(String id, int state) {
        print state
        def userInstance = UserInfo.get(id)
        userInstance.isCheck = state
        if (state == 3) {
            userInstance.isTeacher = 1
        }
        userInstance.save(flush: true)
        render(contentType: "application/json") {
            userInfo = userInstance
        }
    }

    /*
    * 资源统计
    * */
    def resCount(){
        render(contentType: "application/json") {
            zygxk=CourseInfo.countByType("资源共享课")
            spgkk=CourseInfo.countByType("视频公开课")
            video=ResourceInfo.countByType("video")
            word=ResourceInfo.countByType("word")
        }
    }
    /*
    * 管理员修改密码
    * */

    def changePwd(String oldPassword, String password) {
        def adminId
        try {
            adminId = session.adminInfo.id
        } catch (Exception e) {
            flash.message = "登录失效"
            redirect(uri: '/adminInfo/login')
            return
        }
        def adminInfo = AdminInfo.get(adminId)
        if (adminInfo.password.equals(oldPassword)) {
            adminInfo.password = password
            adminInfo.save(flush: true)
            render(contentType: "application/json") {
                state = 200
            }
        } else {
            render(contentType: "application/json") {
                state = 201
            }
        }
    }
}
