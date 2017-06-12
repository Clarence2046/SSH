package com.shark.ocean.lucene;

import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.analysis.cn.smart.SmartChineseAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.index.IndexableField;
import org.apache.lucene.index.Term;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.search.highlight.Formatter;
import org.apache.lucene.search.highlight.Highlighter;
import org.apache.lucene.search.highlight.InvalidTokenOffsetsException;
import org.apache.lucene.search.highlight.QueryScorer;
import org.apache.lucene.search.highlight.Scorer;
import org.apache.lucene.search.highlight.SimpleHTMLFormatter;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;


public class LuceneHelper {
private String indexDir = "index";

	
	/**
	 * ���ݴ����map������������map�ļ���Ϊ����
	 * @param infos
	 */
	public void buildIndexForone(Map<String,String> infos){
		try {
			//�򿪽�������Ŀ¼
			Directory d = FSDirectory.open(Paths.get(indexDir));
			//��������д��������ķִ���������ʹ�����ķִ���
			IndexWriterConfig conf = new IndexWriterConfig(getCNAnalyzer() );
			//��������д����
			IndexWriter  writer = new IndexWriter(d , conf );
			
			
			//������Ҫ����������document����
			Document  doc = new Document();
			Set<String> keySet = infos.keySet();
			for (String key : keySet) {
				if("id".equals(key)){
					writer.deleteDocuments(new Term(key,  infos.get(key)));
				}
				doc.add(new TextField(key, infos.get(key), Field.Store.YES));
			}
			//��ӵ�����д������
			writer.addDocument(doc);
			writer.close();
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("��ȡ����Ŀ¼"+indexDir+"ʧ��");
		}
	}

	
	/**
	 * ��ѯ������������ʲ�ѯ������ʱ��β�ѯ
	 * @return
	 */
	public List<Map<String,String>> searchIndex(String field, String searchTerm){
		List<Map<String,String>>  map = new ArrayList<Map<String,String>>();
		try {
			IndexReader reader = DirectoryReader.open(FSDirectory.open(Paths.get(indexDir)));
			IndexSearcher  searcher = new IndexSearcher(reader );
			
			QueryParser  parser = new QueryParser(field, getCNAnalyzer());
			Query query = parser.parse(searchTerm);
			TopDocs topDocs = searcher.search(query , 10000);
			System.out.println("ƥ��������"+ searchTerm+"������������"+topDocs.totalHits+"�����ݡ�");
			ScoreDoc[] scoreDocs = topDocs.scoreDocs;
			
			Scorer fragmentScorer = new QueryScorer(query);
			Formatter formatter = new SimpleHTMLFormatter("<b><font color='red'>","</font></b>");
			Highlighter  highlighter = new Highlighter(formatter , fragmentScorer );
			
			for (ScoreDoc scoreDoc : scoreDocs) {
				Map<String,String>  one = new HashMap<String, String>();
				//��ȡ�ĵ�id
				int docId = scoreDoc.doc;
				Document doc = searcher.doc(docId);
				List<IndexableField> fields = doc.getFields();
				for (IndexableField ifield : fields) {
					String fieldname = ifield.name();
					String fieldvalue = doc.get(fieldname);
					
					TokenStream tokenStream = getCNAnalyzer().tokenStream(fieldname, fieldvalue);
					String bestFragment = highlighter.getBestFragment(tokenStream , fieldvalue);
					if(bestFragment==null || "".equals(bestFragment)){
						bestFragment = fieldvalue;
					}
					one.put(fieldname, bestFragment);
				}
				map.add(one);
			}
			reader.close();
			
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (InvalidTokenOffsetsException e) {
			e.printStackTrace();
		}
		return map;
	}
	
	
	
	public Analyzer  getCNAnalyzer(){
		return  new SmartChineseAnalyzer();
	}
}
