package microclass.doNotification

import microclass.CourseInfo
import microclass.ResourceInfo
import microclass.converter.IPDFConverter
import microclass.converter.LuceneServices
import microclass.converter.OpenOfficePDFConverter
import microclass.converter.PDFPageCapture
import microclass.util.FileUtils
import org.apache.tika.metadata.Metadata
import org.apache.tika.parser.AutoDetectParser
import org.apache.tika.parser.ParseContext
import org.apache.tika.parser.Parser
import org.apache.tika.sax.BodyContentHandler


class DoProcessTextService {

    boolean transactional = false//事务
    static exposes = ['jms']//暴露Java Message Service
    static destination = "queue.processText"//目的地

    def onMessage(msg) {
        String[] message=msg.split(",");
        ResourceInfo resourceInfo=null
        String filePath=""
        try {
            resourceInfo=new ResourceInfo()
            resourceInfo = ResourceInfo.findById("${message[0]}")
            print "要处理的文件是：${resourceInfo.name}"
            /*
            * 拿到上传的文件使用tika解析获得源数据
            * */
            //文件绝对路径（带后缀名）
            filePath="${message[1]}"+resourceInfo.getPath()
            def file=new File(filePath)
            //要使用解析器接口的parse()方法，实例化任何为其提供实现这个接口的类
            Parser parser = new AutoDetectParser();
            //创建一个处理类的对象
            BodyContentHandler handler = new BodyContentHandler(1000000000);
            //创建的元数据对象
            Metadata metadata = new Metadata();
            InputStream inputstream = new FileInputStream(file);
            //创建一个解析的上下文对象
            ParseContext context = new ParseContext();
            //实例化解析器对象，调用parse方法，并通过所有需要的对象
            parser.parse(inputstream, handler, metadata, context);
            String content=""
            content=handler.toString()
            inputstream.close()
            resourceInfo.content=content

            if (resourceInfo.purpose.equals("introduction")){
              def courseInfo=  CourseInfo.get(resourceInfo.courseId)
                courseInfo.introductionContent=content
                courseInfo.image="../"
                courseInfo.save(flush: true)
                LuceneServices luceneServices=new LuceneServices()
                luceneServices.addIndex(courseInfo)
            }

            if (resourceInfo.extName.equals("pdf")){
                PDFPageCapture pdfPageCapture=new PDFPageCapture()
                pdfPageCapture.capturePages(filePath,FileUtils.getFilePath(filePath))
                println"DoProcessTextService中得到文件路径：${FileUtils.getFilePath(filePath)}"

                resourceInfo.preImgPath=FileUtils.getRelPath(FileUtils.getFilePrefix(filePath)+".jpg")
                println"截图路径${FileUtils.getRelPath(FileUtils.getRelPath(FileUtils.getFilePrefix(filePath)+".jpg"))}"
                resourceInfo.convertPath=resourceInfo.path
            }else {
                IPDFConverter pdfConverter=new OpenOfficePDFConverter()
                String pdfPath= pdfConverter.convert2PDF(filePath)
                resourceInfo.convertPath=pdfPath
                println"转换后pdf路径${pdfPath}"
                PDFPageCapture pdfPageCapture=new PDFPageCapture()
                pdfPageCapture.capturePages("${message[1]}${pdfPath}",FileUtils.getFilePath(filePath))
                resourceInfo.preImgPath=FileUtils.getRelPath(FileUtils.getFilePrefix(filePath)+".jpg")
            }
            resourceInfo.save(flush: true)

        }catch (Exception e){
            println e.printStackTrace()
            println"处理${resourceInfo.id}出错了！"
        }
        println "处理完毕"
    }
}
