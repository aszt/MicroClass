package microclass.util;

import microclass.CourseInfo;
import microclass.ResourceInfo;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.Field.Index;
import org.apache.lucene.document.Field.Store;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by c-kx on 2016/5/8.
 */
public class DocumentUtil {
     public static CourseInfo documentToRes(Document doc) throws ParseException {
         CourseInfo courseInfo=new CourseInfo();
         courseInfo.setIntroductionContent(doc.get("introductionContent"));
         courseInfo.setName(doc.get("name"));
         courseInfo.setUserId(doc.get("userId"));
         courseInfo.setId(doc.get("id"));
         courseInfo.setType(doc.get("type"));
         courseInfo.setImage(doc.get("image"));
        return courseInfo;
    }

    public static Document resToDocument(CourseInfo courseInfo) {
        Document doc = new Document();
        //Index.ANALYZED分词后更新到索引的目录区域(分词后索引)
        //Index.NOT_ANALYZED不分词，直接更新到索引的目录区域(不分词直接索引，例如URL、系统路径等，用于精确检索)
        // doc.add(new Field("dateCreated",resourceInfo.getDateCreated().toString(),Store.YES,Index.NOT_ANALYZED));
        //Index.NO不更新索引的目录区域(无法通过该字段搜索)(根本不索引，所以不会被检索到)
        //Store.YES ：存储原始value数值，可在检索后被提取 。
        doc.add(new Field("introductionContent",courseInfo.getIntroductionContent(), Store.YES, Index.ANALYZED));
        doc.add(new Field("name",courseInfo.getName(), Store.YES, Index.ANALYZED));

        doc.add(new Field("type",courseInfo.getType(),Store.YES,Index.NOT_ANALYZED));

        doc.add(new Field("id",courseInfo.getId(),Store.YES,Index.NOT_ANALYZED));
        doc.add(new Field("userId",courseInfo.getUserId(),Store.YES,Index.NO));
        doc.add(new Field("image",courseInfo.getImage(),Store.YES,Index.NO));

        return doc;
    }
}
