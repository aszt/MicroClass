package microclass

import microclass.util.FileUtils
import grails.converters.JSON

class ResourceInfoController {
    private final static String fileName = "app-config";    //属性文件名称
    private static String MUSIC;
    private static String WORD;
    private static String VIDEO;
    private static String IMAGES;
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
            if (propertyName.equals("resource.music"))
                MUSIC = prb.getString("resource.music");
            if (propertyName.equals("resource.word"))
                WORD = prb.getString("resource.word");
            if (propertyName.equals("resource.video"))
                VIDEO = prb.getString("resource.video");
            if (propertyName.equals("resource.images"))
                IMAGES = prb.getString("resource.images");
        }
    }

    static {
        readConfig();
    }
    /*
    * 文件删除
    * */

    def delete() {

        def result = [success: true]
        render result as JSON
    }
    /*
       * 上传图片
       * */

    def uploadImg() {
        print("执行了上传图片============")
        def initialPreview = []
        def initialPreviewConfig = []
        def userIds = null
        def f
        def courseId
        try {
            userIds = session.userInfo.id
        } catch (Exception e) {
            redirect(uri: '/')
            return
        }
        //从页面得到当前课程id和当前课时的id
        courseId = params.courseId
        print("拿到课程id了===============" + courseId)
        if (request.getFile('img_file') != null) {
            f = request.getFile('img_file')
        }

        String name = f.getOriginalFilename()
        def extName = name.substring(name.lastIndexOf(".") + 1)
        //文件大小限制
        def fileSize = FileUtils.FormetFileSize(f.getSize())
        //重命名文件，根据当前时间确定文件名
        String reName = new Date().getTime()
        //上传文件储存路径
        //网站根目录
        def webRootDir = servletContext.getRealPath("/")
        String uploadDir = "uploads/${userIds}/" + courseId + "/"
        def path = webRootDir + uploadDir + reName + '.' + extName
        def userDir = new File(webRootDir, uploadDir)
        userDir.mkdirs()
        f.transferTo(new File("${path}"))
        def resource = new ResourceInfo()
        resource.name = name
        resource.extName = extName
        resource.convertName = reName
        resource.fileSize = fileSize
        resource.path = FileUtils.getRelPath(path)
        resource.userId = userIds
        resource.courseId = courseId
        resource.classPeriodId = ""
        resource.purpose = "image"
        resource.type = 'images'
        resource.save(flush: true)
        def message = "${resource.getId() + "," + webRootDir}"
//                返回值
        initialPreview << [
                "<img  src=../${resource.path} class='file-preview-image' alt='${resource.name}' title='${resource.name}'>"
        ]
        initialPreviewConfig << [
                key  : resource.path,
                url  : createLink(controller: 'resourceInfo', action: 'delete', id: resource.id),
                extra: [id: resource.id]
        ]
        def results = [initialPreview: initialPreview, initialPreviewConfig: initialPreviewConfig]
        render results as JSON
    }
    /*
    * 上传文本
    * */

    def uploadWord() {
        print("执行了上传文本============")
        def initialPreview = []
        def initialPreviewConfig = []
        def userIds = null
        def f
        def courseId
        def classPeriodId
        def purpose
        try {
            userIds = session.userInfo.id
        } catch (Exception e) {
            redirect(uri: '/')
            return
        }
        //从页面得到当前课程id和当前课时的id
        courseId = params.courseId
//        classPeriodId=params.classPeriodId
        purpose = params.purpose
        if (request.getFile('jj_file') != null) {
            f = request.getFile('jj_file')//简介
        } else if (request.getFile('jxdg_file') != null) {
            f = request.getFile('jxdg_file')//教学大纲
        } else if (request.getFile('sbb_file') != null) {
            f = request.getFile('sbb_file')//申报表
        } else if (request.getFile('sjzd_file') != null) {
            f = request.getFile('sjzd_file')//实践指导
        } else if (request.getFile('zdjc_file') != null) {
            f = request.getFile('zdjc_file')//指定教材
        } else if (request.getFile('ckwx_file') != null) {
            f = request.getFile('ckwx_file')//参考文献
        }
//            以下为课时上传内容
        else if (request.getFile('skja_file') != null) {
            f = request.getFile('skja_file')//授课教案
        } else if (request.getFile('zyxt_file') != null) {
            f = request.getFile('zyxt_file')//作业习题
        } else if (request.getFile('bjjs_file') != null) {
            f = request.getFile('bjjs_file')//本讲介绍
        } else if (request.getFile('resources_file') != null) {
            f = request.getFile('resources_file')//视频文件等资源
        }
        String name = f.getOriginalFilename()
        def extName = name.substring(name.lastIndexOf(".") + 1)
        //文件大小限制
        def fileSize = FileUtils.FormetFileSize(f.getSize())
        //重命名文件，根据当前时间确定文件名
        String reName = new Date().getTime()
        //上传文件储存路径
        //网站根目录
        def webRootDir = servletContext.getRealPath("/")
        def uploadDir
        if (classPeriodId != null && !classPeriodId.equals("")) {
            uploadDir = "uploads/${userIds}/" + courseId + "/" + classPeriodId + "/"
        } else {
            uploadDir = "uploads/${userIds}/" + courseId + "/"
        }
        def path = webRootDir + uploadDir + reName + '.' + extName
        def userDir = new File(webRootDir, uploadDir)
        userDir.mkdirs()
        f.transferTo(new File("${path}"))
        def resource = new ResourceInfo()
        resource.name = name
        resource.extName = extName
        resource.convertName = reName
        resource.fileSize = fileSize
        resource.path = FileUtils.getRelPath(path)
        resource.userId = userIds
        resource.courseId = courseId
        resource.classPeriodId = classPeriodId
        resource.purpose = purpose
        resource.type = 'word'
        resource.save(flush: true)
        def message = "${resource.getId() + "," + webRootDir}"
        //发送到队列
        sendJMSMessage("queue.processText", message)

        //                返回值
        initialPreview << [
                "<div class='file-preview-text'><h2><i class='glyphicon glyphicon-file'></i></h2>" + resource.name + "</div>"
        ]
        initialPreviewConfig << [
                key  : resource.id,
                url  : createLink(controller: 'resourceInfo', action: 'delete', id: resource.id),
                extra: [id: resource.id]
        ]
        def results = [initialPreview: initialPreview, initialPreviewConfig: initialPreviewConfig]
        render results as JSON
    }
    /*
    * 上传课时内容
    * */
    def upload() {
        print("执行了资源上传============")
        def initialPreview = []
        def initialPreviewConfig = []
        def userIds = null
        def f
        def courseId
        def classPeriodId
        def purpose
        try {
            userIds = session.userInfo.id
        } catch (Exception e) {
            redirect(uri: '/')
            return
        }
        //从页面得到当前课程id和当前课时的id
        courseId = params.courseId
        classPeriodId = params.classPeriodId
        purpose = params.purpose//用途
        print("课程id" + courseId)
        print("课时id" + classPeriodId)

        if (request.getFile('skja_file') != null) {
            f = request.getFile('skja_file')//授课教案
        } else if (request.getFile('zyxt_file') != null) {
            f = request.getFile('zyxt_file')//作业习题
        } else if (request.getFile('bjjs_file') != null) {
            f = request.getFile('bjjs_file')//本讲介绍
        } else if (request.getFile('resources_file') != null) {
            f = request.getFile('resources_file')//视频文件等资源
        }

        String name = f.getOriginalFilename()
        def extName = name.substring(name.lastIndexOf(".") + 1)
        //文件大小限制
        def fileSize = FileUtils.FormetFileSize(f.getSize())
        //重命名文件，根据当前时间确定文件名
        String reName = new Date().getTime()
        //上传文件储存路径
        //网站根目录
        def webRootDir = servletContext.getRealPath("/")
        String uploadDir = "uploads/${userIds}/" + courseId + "/" + classPeriodId + "/"
        def path = webRootDir + uploadDir + reName + '.' + extName
        def userDir = new File(webRootDir, uploadDir)
        userDir.mkdirs()
        f.transferTo(new File("${path}"))
        def resource = new ResourceInfo()
        resource.name = name
        resource.extName = extName
        resource.convertName = reName
        resource.fileSize = fileSize
        resource.path = FileUtils.getRelPath(path)
        resource.userId = userIds
        resource.courseId = courseId
        resource.classPeriodId = classPeriodId
        resource.purpose = purpose
        resource.type = "video"
        resource.orderNum = 0
        resource.save(flush: true)
        extName = extName.toLowerCase(); //toLowerCase这个方法是字符串变小写的方法
        def message = "${resource.getId() + "," + webRootDir}"
        if (WORD.indexOf(extName) > -1) {
            print("文档文件保存===========")
            print(resource.name)
            resource.type = 'word'
            resource.save(flush: true)
            sendJMSMessage("queue.processText", message)
        } else if (VIDEO.indexOf(extName) > -1) {
            print("视频文件保存=============")
            print(resource.name)
            resource.type = 'video'
            resource.save(flush: true)
            sendJMSMessage("queue.processVideo", message)
        }
        //                返回值
        initialPreview << [
                "<div class='file-preview-text'><h2><i class='glyphicon glyphicon-file'></i></h2>" + resource.name + "</div>"
        ]
        initialPreviewConfig << [
                key  : resource.id,
                url  : createLink(controller: 'resourceInfo', action: 'delete', id: resource.id),
                extra: [id: resource.id]
        ]
        def results = [initialPreview: initialPreview, initialPreviewConfig: initialPreviewConfig]
        render results as JSON
    }
}
