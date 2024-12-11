package dao;

import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import comment.CommentDTO;

public class CommentCrud {
	private static final String MAPPER = "commentMapper";

	public List<CommentDTO> getComments(int postId, String category) {
	    SqlSession session = getSession();
	    List<CommentDTO> list = null;
	    
	    try {
	        Map<String, Object> map = new HashMap<>();
	        map.put("postId", postId);
	        map.put("category", category);
	        
	        list = session.selectList(MAPPER + ".getComments", map);
	    } catch(Exception e) {
	        e.printStackTrace();
	    } finally {
	        session.close();
	    }
	    return list;
	}

	// 댓글 작성
	public boolean insertComment(CommentDTO comment) {
	    SqlSession session = getSession();
	    boolean result = false;
	    
	    try {
	        result = session.insert(MAPPER + ".insertComment", comment) > 0;
	        session.commit();
	    } catch(Exception e) {
	        session.rollback();
	        e.printStackTrace();
	    } finally {
	        session.close();
	    }
	    return result;
	}

	// 댓글 삭제
	public boolean deleteComment(int commentId, String author) {
	    SqlSession session = getSession();
	    boolean result = false;
	    
	    try {
	        Map<String, Object> map = new HashMap<>();
	        map.put("commentId", commentId);
	        map.put("author", author);
	        
	        result = session.delete(MAPPER + ".deleteComment", map) > 0;
	        session.commit();
	    } catch(Exception e) {
	        session.rollback();
	        e.printStackTrace();
	    } finally {
	        session.close();
	    }
	    return result;
	}
    private SqlSession getSession() {
   	 String config = "mybatisConfig.xml"; // MyBatis 설정 파일
        InputStream is = null; // 파일을 불러올 InputStream 객체 선언
        try {
            is = Resources.getResourceAsStream(config); // MyBatis 설정 파일 로딩
        } catch (Exception e) {
            e.printStackTrace();
        }
        SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder();
        SqlSessionFactory factory = builder.build(is);
        SqlSession ss = factory.openSession(); // SqlSession 객체 생성
        return ss;
   }
}
