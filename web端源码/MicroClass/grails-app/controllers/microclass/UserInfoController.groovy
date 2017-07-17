package microclass

import static org.springframework.http.HttpStatus.*
import cn.itcast.mail.Mail
import cn.itcast.mail.MailUtils
import microclass.util.Uuid
import javax.mail.MessagingException
import javax.mail.Session

class UserInfoController {
    private final static String fileName = "app-config";    //属性文件名称
    private static String EMAIL_HOST;
    private static String EMAIL_USERNAME;
    private static String EMAIL_PASSWORD;
    private static String EMAIL_FROM;
    private static String WEBSITE_URL;
    /*
    * 加载配置文件
    * */

    private static void readConfig() {
        //PropertyResourceBundle使用属性文件中的静态字符串集合来管理语言环境资源。
        PropertyResourceBundle prb = (PropertyResourceBundle) PropertyResourceBundle.getBundle(fileName);
        //枚举Enumeration
        Enumeration enu = prb.getKeys();
        while (enu.hasMoreElements()) {
            String propertyName = enu.nextElement().toString();
            //读取配置文件中的静态字符串并且赋值给类成员变量
            if (propertyName.equals("email.host"))
                EMAIL_HOST = prb.getString("email.host");
            if (propertyName.equals("email.username"))
                EMAIL_USERNAME = prb.getString("email.username");
            if (propertyName.equals("email.password"))
                EMAIL_PASSWORD = prb.getString("email.password");
            if (propertyName.equals("email.from"))
                EMAIL_FROM = prb.getString("email.from");
            if (propertyName.equals("website.url"))
                WEBSITE_URL = prb.getString("website.url");
        }
    }

    static {
        readConfig();
    }

    //信息反馈
    def fankui(){

    }

//修改密码
    def updateNew(String oldPW,String newPW,String newPWS){
        def userInfo = session.userInfo
        def yuan = userInfo.password
        if(yuan==oldPW.encodeAsMD5()){
            if(newPW == newPWS){
                userInfo.password = newPW.encodeAsMD5()
                if (!userInfo.save(flush: true)) {
                    render(contentType: "application/json") {
                        state = 500
                        message = "修改失败,请重试！"
                    }
//                    redirect(uri: '/')
                    return
                }else{
                    render(contentType: "application/json") {
                        state = 200
                        message = "修改成功，请重新登录"
                    }
//                    flash.message = 200
//                    flash.registMsg = "修改成功，请重新登录"
                }
            }else {
                render(contentType: "application/json") {
                    state = 300
                    message = "两次密码不一致"
                }
//                print("两次密码不一致")
            }
        }else{
            render(contentType: "application/json") {
                state = 400
                message = "原密码有误"
            }
        }


    }

    //去修改密码
    def updatePW(){

    }


//    收藏课程列表
    def collection(){

        def userInfo
        def uesrId
        def collectInfoList
        try {
            userInfo = session.userInfo
            uesrId = session.userId
        } catch (Exception e) {
            redirect(uri: '/')
            return
        }
        collectInfoList = Collect.findAllByUserId(uesrId)
        List<Collect> collectIdList = new ArrayList<Collect>()
        def courseId
        for (Collect collect : collectInfoList) {
            courseId = collect.courseId
            collectIdList.add(courseId)
        }

        def courseInfoList = CourseInfo.findAllByIdInListAndState(collectIdList,1)
        [courseInfoList:courseInfoList,userInfo:userInfo]
    }

    //到注册页
    def loginRegister() {
    }

    //    查询我的课程
    def findCourse(String category, String title) {
        print("类别" + category + "==============标题" + title)
        def userInfo = null
        def uesrId
        def CourseInfoList
        def pageSize = 8

        userInfo = session.userInfo
        uesrId = session.userId
        CourseInfoList = CourseInfo.findAllByCategoryAndUserIdAndState(category, uesrId,1, [max: pageSize, sort: "name", order: "asc", offset: 0 * pageSize])

    }

//    用户所有课程(包括查询)
    def myCourse(Integer max, String title, String category) {
        print("标题" + title + "=====类别" + category)
        if(category=="全部"){
            category = null
        }
        params.max = Math.min(max ?: 8, 100)
        def userInfo = null
        def uesrId
        def courseInfoList
        def courseInSize
        print(params.offset + "======从多少条开始")
        print(params.max + "=========最多加载多少条")
        try {
            def pageSize = 8
            userInfo = session.userInfo
            uesrId = session.userId

            if (title != null && !title.equals("") && category != null && !category.equals("")) {
                courseInSize = CourseInfo.findAllByUserIdAndCategoryAndNameIlikeAndState(uesrId, category, "%" + title + "%",1)
//总记录数
                if (params.offset == 0 || params.offset == null) {
                    courseInfoList = CourseInfo.findAllByUserIdAndCategoryAndNameIlikeAndState(uesrId, category, "%" + title + "%", 1,[max: pageSize, sort: "name", order: "asc", offset: 0])
                } else {
                    courseInfoList = CourseInfo.findAllByUserIdAndCategoryAndNameIlikeAndState(uesrId, category, "%" + title + "%",1, [max: pageSize, sort: "name", order: "asc", offset: params.offset])
                }

            } else if (title != null && !title.equals("")) {
                courseInSize = CourseInfo.findAllByUserIdAndNameIlikeAndState(uesrId, "%" + title + "%",1)//总记录数
                if (params.offset == 0 || params.offset == null) {
                    courseInfoList = CourseInfo.findAllByUserIdAndNameIlikeAndState(uesrId, "%" + title + "%", 1,[max: pageSize, sort: "name", order: "asc", offset: 0])
                } else {
                    courseInfoList = CourseInfo.findAllByUserIdAndNameIlikeAndState(uesrId, "%" + title + "%",1 ,[max: pageSize, sort: "name", order: "asc", offset: params.offset])
                }

            } else if (category != null && !category.equals("")) {
                courseInSize = CourseInfo.findAllByUserIdAndCategoryAndState(uesrId, category,1)//总记录数
                if (params.offset == 0 || params.offset == null) {
                    courseInfoList = CourseInfo.findAllByUserIdAndCategoryAndState(uesrId, category, 1,[max: pageSize, sort: "name", order: "asc", offset: 0])
                } else {
                    courseInfoList = CourseInfo.findAllByUserIdAndCategoryAndState(uesrId, category,1, [max: pageSize, sort: "name", order: "asc", offset: params.offset])
                }

            } else {
                courseInSize = CourseInfo.findAllByUserIdAndState(uesrId,1)
                if (params.offset == 0 || params.offset == null) {
                    print("第一页数据加载")
                    courseInfoList = CourseInfo.findAllByUserIdAndState(uesrId,1, [max: pageSize, sort: "name", order: "asc", offset: 0])
                } else {
                    print("其他页数据加载")
                    courseInfoList = CourseInfo.findAllByUserIdAndState(uesrId,1, [max: pageSize, sort: "name", order: "asc", offset: params.offset])
                }
            }

        } catch (Exception e) {
            redirect(uri: '/')
            return
        }
        [params: params, userInfo: userInfo, courseInfoList: courseInfoList, courseInstanceTotal: courseInSize.size(), title: title, category: category]
    }

    //成为教师
    def changeToTeacher() {

    }

    //用户个人中心
    def user() {
        def userInfo = null
        def uesrId
        def courseInfoList
        try {
            userInfo = session.userInfo
            uesrId = session.userId
            courseInfoList = CourseInfo.findAllByUserId(uesrId)
        } catch (Exception e) {
            redirect(uri: '/')
            return
        }
        userInfo = UserInfo.get(uesrId)
        if (userInfo.isTeacher == 1) {
            render(view: 'teacher', model: [userInfo: userInfo, courseInfoList: courseInfoList])
            return
        } else {
            render(view: 'user', model: [userInfo: userInfo, courseInfoList: courseInfoList])
        }
//        [userInfo: userInfo, courseInfoList: courseInfoList]
    }

    //退出登录
    def loginOut = {
        session.invalidate()
        redirect(uri: "/")
    }

    /*
    * 个人中心
    * */

    def index() {
        def userInfoInstance = null
        try {
            userInfoInstance = session.userInfo
        } catch (Exception e) {
            redirect(uri: '/')
            return
        }
        userInfoInstance = UserInfo.get(userInfoInstance.id)
        if (userInfoInstance.isTeacher == 1) {
            render(view: "teaIndex", model: [userInfo: userInfoInstance])
        }
        [userInfo: userInfoInstance]
    }
    /*
    * 检测邮箱
    * 返回200存在该邮箱注册的用户
    * 返回201无该邮箱注册的用户
    * */

    def checkEmail(String email) {
        def userInfo = UserInfo.findByEmail(email)
        if (userInfo) {
            render(contentType: "application/json") {
                state = 200
            }
        } else {
            render(contentType: "application/json") {
                state = 201
            }
        }
    }
    /*
    * 检测用户名是否已经被注册过
    * 返回200用户名已被注册
    * 返回201用户名未被注册
    * */

    def checkUserName(String userName) {
        def userInfo = UserInfo.findByUserName(userName)
        if (userInfo) {
            render(contentType: "application/json") {
                state = 200
            }
        } else {
            render(contentType: "application/json") {
                state = 201
            }
        }
    }
    /*
    * 注册
    * */

    def register(String email, String userName, String password, String passwords) {
        //创建用户
        def user = new UserInfo()
        user.password = password.encodeAsMD5()
        user.userName = userName
        user.email = email
        user.activateCode = Uuid.uuid()
        if (!user.save(flush: true)) {
            flash.message = 500
            flash.registMsg = "注册失败,请重试！"
            redirect(uri: '/loginRegister')
            return
        }
        String host = EMAIL_HOST;// 获取服务器主机
        String uname = EMAIL_USERNAME;// 获取用户名
        String pwd = EMAIL_PASSWORD;// 获取密码
        String from = EMAIL_FROM;// 获取发件人
        String to = user.email;// 获取收件人
        String subject = "来自精品课程网站的注册邮件";// 获取主题
        String content = "<a href=${WEBSITE_URL}/userInfo/active?activateCode=${user.activateCode}>点击激活</a>";// 获取邮件内容
        Session session = MailUtils.createSession(host, uname, pwd);// 得到session
        Mail mail = new Mail(from, to, subject, content);// 创建邮件对象
        try {
            MailUtils.send(session, mail);// 发邮件！
        } catch (MessagingException e) {
            user.delete(flush: true)
            flash.message = 500
            flash.registMsg = "注册失败,请重试！"
            redirect(uri: '/loginRegister')
            return
        }
        flash.loginMessage = "注册成功，请到邮箱激活"
        redirect(uri: '/loginRegister')
    }
    /*
    * 激活
    * */

    def active() {
        String activateCode = params.activateCode
        def userInfo = UserInfo.findByActivateCode(activateCode)
        if (userInfo == null) {
            flash.registMsg = "激活码无效"
            redirect(uri: "/")
        } else if (userInfo.state != 0) {
            flash.registMsg = "你已经激活过了，不用再次激活"
            redirect(uri: "/")
        } else {
            userInfo.state = 1
            userInfo.save(flush: true)
            flash.registMsg = "激活成功，请登录"
            redirect(uri: "/")
        }
    }
    /*
    * 发送重置密码邮件
    * */

    def sendResetEmail() {
        def email = params.resetEmail
        def userInfo = UserInfo.findByEmail(email)
        if (userInfo == null) {
            flash.registMsg = "重置密码出错!!!"
            redirect(uri: "/")
        }
        String host = EMAIL_HOST;// 获取服务器主机
        String uname = EMAIL_USERNAME;// 获取用户名
        String pwd = EMAIL_PASSWORD;// 获取密码
        String from = EMAIL_FROM;// 获取发件人
        String to = userInfo.email;// 获取收件人
        String subject = "来自知识库管理系统的重置密码邮件";// 获取主题

        String content = "<a href=${WEBSITE_URL}/userInfo/resetPassword?email=${userInfo.email}&activateCode=${userInfo.activateCode}>点击重置密码</a>";
// 获取邮件内容
        Session session = MailUtils.createSession(host, uname, pwd);// 得到session
        Mail mail = new Mail(from, to, subject, content);// 创建邮件对象
        try {
            MailUtils.send(session, mail);// 发邮件！
        } catch (MessagingException e) {
            flash.registMsg = "密码重置邮件发送失败！请稍后重试"
        }
        flash.registMsg = "密码重置邮件已发送。"
        redirect(uri: "/")
    }
    /*
    * 到重置密码页
    * */

    def resetPassword(String email, String activateCode) {
        [email: email, code: activateCode]
    }
    /*
    * 重置密码
    * */

    def doResetPassword(String email, String activateCode, String password) {
        def userInfo = UserInfo.findByEmailAndActivateCode(email, activateCode)
        if (userInfo) {
            userInfo.password = password.encodeAsMD5()
            userInfo.save(flush: true)
            flash.registMsg = "密码重置成功"
            redirect(uri: "/")
        } else {
            flash.registMsg = "密码重置失败"
            redirect(uri: "/")
        }
    }
    /*=
    * 用户登陆
    * */

    def login(String userName, String password) {
        def userInstance = UserInfo.findByUserNameAndPassword(userName, password.encodeAsMD5())
        def userInstance1 = UserInfo.findByEmailAndPassword(userName, password.encodeAsMD5())
        if (userInstance) {
            //flash.message="恭喜你，登录成功"
            if (userInstance.state == 1) {
                session.userInfo = userInstance
                session.userName = userInstance.userName
                session.image = userInstance.image
                session.userId = userInstance.id
                session['userInfo'] = userInstance
                flash.loginMessage = 200
                redirect(uri: '/loginRegister')
            } else {
                flash.loginMessage = "账号未激活或被禁用！"
                redirect(uri: '/loginRegister')
                print("账号未激活或被禁用！");
            }
        } else if (userInstance1) {
            if (userInstance1.state == 1) {
                session['userInfo'] = userInstance1
                session.userName = userInstance1.userName
                session.image = userInstance1.image
                session.userId = userInstance1.id
                session['userInfo'] = userInstance1
                flash.loginMessage = 200
                redirect(uri: '/loginRegister')
            } else {
                flash.loginMessage = "账号未激活或被禁用！"
                redirect(uri: '/loginRegister')
            }
        } else {
            flash.loginMessage = "用户名或者密码错误！"
            redirect(uri: '/loginRegister')
        }
    }
    /*
    * 打开头像上传框
    * */

    def upload() {
    }
    /*
    * 头像上传
    * */

    def doUpload() {
        def userInstance = null
        try {
            userInstance = session.userInfo
        } catch (Exception e) {
            redirect(uri: '/')
            return
        }
        userInstance = UserInfo.get(userInstance.id)
        def f = request.getFile('__avatar1')
        def webRootDir = servletContext.getRealPath("/")
        String uploadDir = "uploads/${userInstance.id}/"
        def path = webRootDir + uploadDir + userInstance.id + ".jpg"
        def userDir = new File(webRootDir, uploadDir)
        userDir.mkdirs()
        f.transferTo(new File("${path}"))
        userInstance.image = uploadDir + userInstance.id + ".jpg"
        userInstance.save(flush: true)
        render(contentType: "application/json") {
            success = true
        }
    }
    /*
    * 编辑个人信息
    * 返回200成功
    * 返回500失败
    * */

    def update(String userName, String sex, String mobilePhone,String name,String school,String college,String code,String position) {
        //用户实体
        def userInstance = null
        try {
            userInstance = session.userInfo
        } catch (Exception e) {
            redirect(uri: '/')
            return
        }
        userInstance = UserInfo.get(userInstance.id)
        userInstance.mobilePhone = mobilePhone
        userInstance.userName = userName
        userInstance.sex = sex

//        老师还可修改以下内容
        userInstance.name = name
        userInstance.school = school
        userInstance.code = code
        userInstance.position = position
        userInstance.college = college

        if (userInstance.save(flush: true)) {
            render(contentType: "application/json") {
                msg = 200
            }
        } else
            render(contentType: "application/json") {
                msg = 500
            }
    }
    /*
    * 认证成老师
    * */

    def authentication(String name, String mobilePhone, String school, String college, String code, String position, String introduction) {
        def userInstance = null
        def sbuffer = null
        try {
            userInstance = session.userInfo
        } catch (Exception e) {
            redirect(uri: '/')
            return
        }
        userInstance = UserInfo.get(userInstance.id)
        sbuffer = new StringBuffer()
        if (name == null || name.equals(""))
            sbuffer.append("真实姓名不能为空<br/>")
        else
            userInstance.name = name
        if (mobilePhone == null || mobilePhone.equals(""))
            sbuffer.append("联系方式不能为空<br/>")
        else
            userInstance.mobilePhone = mobilePhone
        if (school == null || school.equals(""))
            sbuffer.append("学校不能为空<br/>")
        else
            userInstance.school = school
        if (college == null || college.equals(""))
            sbuffer.append("院系不能为空<br/>")
        else
            userInstance.college = college
        if (introduction == null || introduction.equals(""))
            sbuffer.append("个人简介不能为空<br/>")
        else
            userInstance.introduction = introduction
        if (code == null || code.equals(""))
            sbuffer.append("教师编码不能为空<br/>")
        else
            userInstance.code = code
        if (position == null || position.equals(""))
            sbuffer.append("职称不能为空<br/>")
        else
            userInstance.position = position
        if (sbuffer.length() != 0) {
            flash.message = sbuffer.toString()
//            返回错误提示信息
            redirect(uri: 'userInfo/index')
        } else {
            userInstance.isCheck = 1
            if (userInstance.save(flush: true)) {
                render(contentType: "application/json") {
                    flash.message = "认证信息提交成功，等待审核"
                    msg = 200
                    prompt = "认证信息提交成功，等待审核"
                }
//                flash.message="认证信息提交成功，等待审核"
//                redirect(uri: 'userInfo/index')
            } else {
                render(contentType: "application/json") {
                    flash.message = "信息提交失败，请稍后重试"
                    msg = 500
                    prompt = "信息提交失败，请稍后重试"
                }
//                flash.message="信息提交失败，请稍后重试"
//                redirect(uri: 'userInfo/index')
            }
        }
    }

    /*
    *收藏课程
    * */

    def collect(String id) {
        def userInstance = null
        try {
            userInstance = session.userInfo
        } catch (Exception e) {
            redirect(uri: '/')
            return
        }
        userInstance = UserInfo.get(userInstance.id)
        userInstance.college = userInstance.college + id + ","
        if (userInstance.save(flush: true)) {
            render(contentType: "application/json") {
                msg = 200
            }
        } else {
            render(contentType: "application/json") {
                msg = 500
            }
        }
    }
    /*
    * 取消收藏
    * */

    def cancelCollect(String id) {
        def userInstance = null
        try {
            userInstance = session.userInfo
        } catch (Exception e) {
            redirect(uri: '/')
            return
        }
        userInstance = UserInfo.get(userInstance.id)
        userInstance.college = userInstance.college.replace(id + ",", "")
        if (userInstance.save(flush: true)) {
            render(contentType: "application/json") {
                msg = 200
            }
        } else {
            render(contentType: "application/json") {
                msg = 500
            }
        }
    }
    /*
    * 我的收藏
    * */

    def myCollect() {
        def userInstance = null
        try {
            userInstance = session.userInfo
        } catch (Exception e) {
            redirect(uri: '/')
            return
        }
        userInstance = UserInfo.get(userInstance.id)
        def college = userInstance.college
        String[] array = college.split(",");
        def collegeList = Arrays.asList(array)
        def courseInfoList = CourseInfo.findAllByIdInList(collegeList)
        [courseInfoList: courseInfoList]
    }

    /*
    * 下面的方法为app端
    *
    * */
    /*
    * 登陆
    * */

    def login_app(String userName, String password) {
        print 111
        def userInstance = UserInfo.findByUserNameAndPassword(userName, password.encodeAsMD5())
        def userInstance1 = UserInfo.findByEmailAndPassword(userName, password.encodeAsMD5())
        if (userInstance) {
            if (userInstance.state == 1) {
                //登陆成功
                render(contentType: "application/json ", status: OK) {
                    userInfo = userInstance
                }
            } else {
                //账号未激活或被禁用
                render(contentType: "application/json ", status: FORBIDDEN)
            }
        } else if (userInstance1) {
            if (userInstance1.state == 1) {
                render(contentType: "application/json", status: OK) {
                    userInfo = userInstance1
                }
            } else {
                render(contentType: "application/json ", status: FORBIDDEN)
            }
        } else {
            //用户名或密码错误
            render(contentType: "application/json", status: NOT_FOUND)
        }
    }
/*
* 注册
* */

    def register_app(String email, String userName, String password) {

        def user = new UserInfo()
        user = UserInfo.findByEmailOrUserName(email, userName)
        if (user) {
            //用户名或邮箱已被注册
            print user
            render(contentType: "application/json", status: FORBIDDEN)
            return
        }
        def userInfo = new UserInfo()
        userInfo.userName = userName
        userInfo.password = password.encodeAsMD5()
        userInfo.email = email
        userInfo.activateCode = Uuid.uuid()
        if (!userInfo.save(flush: true)) {
            //注册失败
            render(contentType: "application/json", status: NOT_FOUND)
            return
        }
        String host = EMAIL_HOST;// 获取服务器主机
        String uname = EMAIL_USERNAME;// 获取用户名
        String pwd = EMAIL_PASSWORD;// 获取密码
        String from = EMAIL_FROM;// 获取发件人
        String to = userInfo.email;// 获取收件人
        String subject = "来自精品课程网站的注册邮件";// 获取主题
        String content = "<a href=${WEBSITE_URL}/userInfo/active?activateCode=${userInfo.activateCode}>点击激活</a>";
// 获取邮件内容
        Session session = MailUtils.createSession(host, uname, pwd);// 得到session
        Mail mail = new Mail(from, to, subject, content);// 创建邮件对象
        try {
            MailUtils.send(session, mail);// 发邮件！
        } catch (MessagingException e) {
            userInfo.delete(flush: true)
            //发送注册邮件失败
            render(contentType: "application/json", status: NOT_FOUND)
            return
        }
        //注册成功
        render(contentType: "application/json", status: OK)
    }
    /*
       * 发送重置密码邮件
       * */

    def sendResetEmail_app(email) {
        def userInfo = UserInfo.findByEmail(email)
        if (userInfo == null) {
            //没有找到该邮箱注册的用户
            render(contentType: "application/json", status: NOT_FOUND)
            return
        }
        String host = EMAIL_HOST;// 获取服务器主机
        String uname = EMAIL_USERNAME;// 获取用户名
        String pwd = EMAIL_PASSWORD;// 获取密码
        String from = EMAIL_FROM;// 获取发件人
        String to = userInfo.email;// 获取收件人
        String subject = "来自知识库管理系统的重置密码邮件";// 获取主题
        String content = "<a href=${WEBSITE_URL}/userInfo/resetPassword?email=${userInfo.email}&activateCode=${userInfo.activateCode}>点击重置密码</a>";
// 获取邮件内容
        Session session = MailUtils.createSession(host, uname, pwd);// 得到session
        Mail mail = new Mail(from, to, subject, content);// 创建邮件对象
        try {
            MailUtils.send(session, mail);// 发邮件！
        } catch (MessagingException e) {
            //发送重置密码邮件失败
            render(contentType: "application/json", status: FORBIDDEN)
        }
        render(contentType: "application/json", status: OK)
    }
}
