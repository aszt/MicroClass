package microclass

class ResourceInfo {
    String id
    Date dateCreated //资源上传时间
    int orderNum //序号
    String name //资源名称
    String path //资源地址
    String type //类型
    String extName  //原始文件扩展名
    String convertName  //上传文件改名
    String fileSize //文件大小
    String preImgPath   //预览图
    String convertPath //转换路径
    String content //文本的全部内容
    int isConvert = 0   //0 代表未转换，1代表转换成功，2表示转换失败
    String userId//上传者
    String courseId//课程id
    String classPeriodId//课时id
    String purpose//该资源的用途
    static constraints = {
        orderNum(nullable:false)
        name(blank: false)
        path(blank: false)
        type(blank: false)
        extName(nullable: true)
        convertName(blank: false)
        fileSize(nullable: true)
        preImgPath(nullable: true)
        convertPath(nullable: true)
        content(nullable: true)
        userId(blank: false)
        courseId(blank: false)
        classPeriodId(nullable: true)
        purpose(nullable: true)
    }
    static mapping = {
        id generator: 'uuid.hex'
    }
    String toString(){
        return name
    }
}
