package microclass.util;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;
import org.wltea.analyzer.lucene.IKAnalyzer;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.PropertyResourceBundle;

/**
 * Created by c-kx on 2016/5/8.
 */
public class LuceneUtils {

    private final static String fileName="app-config";	//属性文件名称
    private static String DIRECTORY_PATH ;
    static{
        readConfig();
    }

    private static void readConfig(){
        //PropertyResourceBundle使用属性文件中的静态字符串集合来管理语言环境资源。
        PropertyResourceBundle prb=(PropertyResourceBundle) PropertyResourceBundle.getBundle(fileName);
        //枚举Enumeration
        Enumeration enu=prb.getKeys();
        while (enu.hasMoreElements()){
            String propertyName=enu.nextElement().toString();
            //读取配置文件中的静态字符串并且赋值给类成员变量
            if (propertyName.equals("directory.path"))
                DIRECTORY_PATH=prb.getString("directory.path");
        }

    }


    private static Directory directory=null;

    private static IndexWriterConfig config=null;
    private static Version matchVersion=null;

    private static Analyzer analyzer=null;

    static{

        try {
            directory = FSDirectory.open(new File(DIRECTORY_PATH));

            matchVersion= Version.LUCENE_44;

            analyzer = new IKAnalyzer();

            config=new IndexWriterConfig(matchVersion, analyzer);

        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }

    /**
     *
     *
     * @return返回用于操作索引的对象...
     * @throws IOException
     */
    public static IndexWriter getIndexWriter() throws IOException{

        IndexWriter indexWriter=new IndexWriter(directory,config);
        return indexWriter;
    }
    /**
     *
     * 返回用于读取索引的对象..
     * @return
     * @throws IOException
     */
    public static IndexSearcher getIndexSearcher() throws IOException{
        IndexReader indexReader= DirectoryReader.open(directory);

        IndexSearcher indexSearcher=new IndexSearcher(indexReader);

        return indexSearcher;

    }

    /**
     * 返回lucene 当前使用的版本信息...
     *
     * @return
     */
    public static Version getMatchVersion() {
        return matchVersion;
    }

    /**
     * 返回lucene 使用的分词器...
     * @return
     */
    public static Analyzer getAnalyzer() {
        return analyzer;
    }


}
