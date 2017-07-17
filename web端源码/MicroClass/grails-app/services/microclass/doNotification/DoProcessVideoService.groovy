package microclass.doNotification

import microclass.ClassPeriodInfo
import microclass.ResourceInfo
import microclass.converter.LuceneServices
import microclass.converter.VideoConverter
import microclass.util.FileUtils
import org.apache.tika.metadata.Metadata
import org.apache.tika.parser.AutoDetectParser
import org.apache.tika.parser.ParseContext
import org.apache.tika.parser.Parser
import org.apache.tika.sax.BodyContentHandler

class DoProcessVideoService {

    boolean transactional = false
    static exposes = ['jms']
    static destination = "queue.processVideo"

    def onMessage(msg) {
        String[] message=msg.split(",");
        ResourceInfo resourceInfo=new ResourceInfo()
        try {
            resourceInfo = ResourceInfo.findById("${message[0]}")
            print "要处理的文件是：${resourceInfo.name}"
            /*
            * 处理视屏，对视频进行截图
            * */
            VideoConverter videoConverter=new VideoConverter();
            String preImgPath= videoConverter.videoCapture("${message[1]}"+resourceInfo.getPath())
            resourceInfo.preImgPath=FileUtils.getRelPath(FileUtils.getFilePrefix(preImgPath)+".jpg")
            def classP=ClassPeriodInfo.get(resourceInfo.classPeriodId)
            classP.image=FileUtils.getRelPath(FileUtils.getFilePrefix(preImgPath)+".jpg")
            classP.save(flush: true)
            resourceInfo.save(flush: true)
            /*
            *调用luncene分词
            * */
            /*LuceneServices luceneServices=new LuceneServices()
            luceneServices.addIndex(resourceInfo)*/
        }catch (Exception e){
            println e.printStackTrace()
            println"处理${resourceInfo.id}出错了！"
        }
        println "处理完毕"
    }
}
