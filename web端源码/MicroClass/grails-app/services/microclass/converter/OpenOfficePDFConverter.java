package microclass.converter;

import microclass.util.FileUtils;
import org.artofsolving.jodconverter.OfficeDocumentConverter;
import org.artofsolving.jodconverter.office.DefaultOfficeManagerConfiguration;
import org.artofsolving.jodconverter.office.OfficeManager;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Enumeration;
import java.util.PropertyResourceBundle;
import java.util.concurrent.*;

public class OpenOfficePDFConverter implements IPDFConverter {

    private static OfficeManager officeManager;
    private final static String fileName="app-config";	//属性文件名称
    private static String OFFICE_HOME ;
    private static int port[] = {8100};

    static{
        readConfig();
    }

    //读取配置文件信息
    @SuppressWarnings("unchecked")
    private static void readConfig(){
        //PropertyResourceBundle使用属性文件中的静态字符串集合来管理语言环境资源。
        PropertyResourceBundle prb=(PropertyResourceBundle) PropertyResourceBundle.getBundle(fileName);
        //枚举Enumeration
        Enumeration enu=prb.getKeys();
        while (enu.hasMoreElements()){
            String propertyName=enu.nextElement().toString();
            //读取配置文件中的静态字符串并且赋值给类成员变量
            if (propertyName.equals("convert.openOffice"))
                OFFICE_HOME=prb.getString("convert.openOffice");
        }

    }

    public  String  convert2PDF(String inputFile, final String pdfFile) {
            if(inputFile.endsWith(".txt")){
                String odtFile = FileUtils.getFilePrefix(inputFile)+".odt";
                if(new File(odtFile).exists()){
                    inputFile = odtFile;
                }else{
                    try {
                        FileUtils.copyFile(inputFile, odtFile);
                        inputFile = odtFile;
                    } catch (FileNotFoundException e) {
                        e.printStackTrace();
                        return null;
                    }
                }
        }
        startService();
        final OfficeDocumentConverter converter = new OfficeDocumentConverter(officeManager);
        System.out.print("转换前");
        //定义成final不然下面访问不到
        final String finalInputFile = inputFile;
        ExecutorService executor = Executors.newSingleThreadExecutor();
        // 使用Callable接口作为构造参数
        FutureTask<String> future = new FutureTask<String>(new Callable<String>() {
            public String call() {
                // 封装好的转换方法，你可以认为是converter.convert(inputFile, outputFile);
                converter.convert(new File(finalInputFile),new File(pdfFile));
                // call方法要求返回字符串
                return "1";
            }
        });
        executor.execute(future);
        try {
            String result = future.get(60000, TimeUnit.MILLISECONDS);
            // 设置超时执行时间为15秒，超过时间限制抛出超时异常
            if (result.equals("1")) {
                System.out.print("转换结束");
                File file = new File(pdfFile);
                if (!file.exists()) {
                    System.err.println("转换失败");
                    return null;
                }
            }
        } catch (InterruptedException e) {
            return null;
        } catch (ExecutionException e) {
            return null;
        } catch (TimeoutException e) {
            System.out.println("超时");
            try {
                Runtime.getRuntime().exec("taskkill /f /im soffice.exe");
                return null;
            } catch (IOException e1) {
                e1.printStackTrace();
                return null;
            }
        } finally {
            executor.shutdown();
        }
       return FileUtils.getRelPath(pdfFile);
    }

    public String  convert2PDF(String inputFile) {
        String pdfFile = FileUtils.getFilePrefix(inputFile)+".pdf";
        return convert2PDF(inputFile,pdfFile);
    }

    public static void startService(){
        DefaultOfficeManagerConfiguration configuration = new DefaultOfficeManagerConfiguration();
        try {
            configuration.setOfficeHome(OFFICE_HOME);//设置OpenOffice.org安装目录
            configuration.setPortNumbers(port); //设置转换端口，默认为8100
            configuration.setTaskExecutionTimeout(1000 * 60 * 5L);//设置任务执行超时为5分钟
            configuration.setTaskQueueTimeout(1000 * 60 * 60 * 24L);//设置任务队列超时为24小时

            officeManager = configuration.buildOfficeManager();
            officeManager.start();	//启动服务
        } catch (Exception ce) {
            ce.printStackTrace();
        }
    }

    public static void stopService(){
        if (officeManager != null) {
            officeManager.stop();
        }
    }
}
