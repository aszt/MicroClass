package microclass.converter;

import microclass.CourseInfo;
import microclass.util.DocumentUtil;
import microclass.util.LuceneUtils;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.Term;
import org.apache.lucene.queryparser.classic.MultiFieldQueryParser;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.BooleanClause.Occur;
import org.apache.lucene.search.*;
import org.apache.lucene.search.highlight.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 使用lucene 来操作索引库...
 * Created by c-kx on 2016/5/9.
 */
public class LuceneServices {
    /**
     * 增删改索引都是通过indexWriter 对象来完成...
     * @throws IOException
     */
    public void addIndex(CourseInfo courseInfo) throws IOException {
        //用于操作索引的对象
        System.out.print("创建索引开始");
        IndexWriter indexWriter= LuceneUtils.getIndexWriter();
        Document doc= DocumentUtil.resToDocument(courseInfo);
        indexWriter.addDocument(doc);
        indexWriter.close();
        System.out.print("创建索引结束");
    }


    /**
     * 删除索引,根据id删
     * @param courseInfo
     * @throws IOException
     */
    public void delIndex(CourseInfo courseInfo) throws IOException{
        IndexWriter indexWriter= LuceneUtils.getIndexWriter();
        Term term=new Term("id", courseInfo.getId());
        //delete from table where condition
        indexWriter.deleteDocuments(term);

        indexWriter.close();

    }


    /**
     * 先删除符合条件的记录，再创建一个符合条件的记录....
     * @param courseInfo
     * @throws IOException
     */
    public void updateIndex(CourseInfo courseInfo) throws IOException{
        IndexWriter indexWriter= LuceneUtils.getIndexWriter();
        Term term=new Term("id", courseInfo.getId());
        Document doc= DocumentUtil.resToDocument(courseInfo);
        indexWriter.updateDocument(term, doc);
        indexWriter.close();
    }

    /**
     * 此方法用检索文件
     * @param keywords：搜索关键词
     * @param start：从第几条开始
     * @param rows；每次取多少
     * @return resourceInfoList:文件列表
     * @throws Exception
     */
    public List<CourseInfo> findIndex(String keywords,int start,int rows) throws Exception{
        IndexSearcher indexSearcher= LuceneUtils.getIndexSearcher();
        //封装查询条件(使用BooleanQuery对象，连接多个查询条件)
        QueryParser queryParser = new MultiFieldQueryParser(LuceneUtils.getMatchVersion(),new String[]{"introductionContent","name"}, LuceneUtils.getAnalyzer());
        Query query = queryParser.parse(keywords);
        TopDocs topDocs=indexSearcher.search(query, start+rows);
        System.out.println("总记录数==total=="+topDocs.totalHits);
        ScoreDoc scoreDocs []=topDocs.scoreDocs;
        Formatter formatter=new SimpleHTMLFormatter("<font color='red'>", "</font>");


        //query 里面条件，条件里面有搜索关键字
        QueryScorer fragmentScorer=new QueryScorer(query);

        //构造高亮气...
        /**
         * 1:我要高亮成什么颜色
         * 2：我要将那些关键字进行高亮...
         *
         */
        Highlighter highlighter=new Highlighter(formatter, fragmentScorer);
        /*
        * 设置高亮后的字符长度
        * */
        highlighter.setTextFragmenter(new SimpleFragmenter(230));

        CourseInfo courseInfo=null;
        List<CourseInfo> courseInfoList = new ArrayList<CourseInfo>();
        int endResult=Math.min(scoreDocs.length, start+rows);

        for(int i=start;i<endResult;i++){

            //docID lucene 的索引库里面有很多的document，lucene 为每个document 定义一个编号，唯一标识.. 自增长
            int docID=scoreDocs[i].doc;
            //System.out.println("编号的标识==="+docID+"得分=="+scoreDocs[i].score);
            Document document=indexSearcher.doc(docID);

            // 给想要的字段设置高亮
            String name=document.get("name");
            String content=document.get("introductionContent");
            String hName=highlighter.getBestFragment(LuceneUtils.getAnalyzer(), "name", name);
            String hContent=highlighter.getBestFragment(LuceneUtils.getAnalyzer(), "introductionContent", content);

            courseInfo=new CourseInfo();
            courseInfo= DocumentUtil.documentToRes(document);

            if(hName!=null){
                courseInfo.setName(hName);
            }

            if(hContent!=null){
                courseInfo.setIntroductionContent(hContent);
            }
            courseInfoList.add(courseInfo);
        }
        return courseInfoList;
    }


}
