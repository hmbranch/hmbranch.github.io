package dao;

import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import like.LikeDTO;
import post.PostDTO;

public class PostCrud {
    private final String MAPPER_NAME ="postMapper"; // mapper name 수정
    
    public Integer getNextPostId(SqlSession session, String category) {
        return session.selectOne(MAPPER_NAME + ".getNextPostId", category);
    }
 // 검색 결과 수 조회
    public int getSearchCount(String category, String keyword) {
        SqlSession session = getSession();
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("category", category);
            params.put("keyword", keyword);
            return session.selectOne(MAPPER_NAME + ".getSearchCount", params);
        } finally {
            session.close();
        }
    }

    // 검색 결과 조회
    public List<PostDTO> searchPosts(String category, String keyword, int start, int end) {
        SqlSession session = getSession();
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("category", category);
            params.put("keyword", keyword);
            params.put("start", start);
            params.put("end", end);
            return session.selectList(MAPPER_NAME + ".searchPosts", params);
        } finally {
            session.close();
        }
    }
    public boolean deletePost(String category, int postId) {
        SqlSession session = getSession();
        boolean result = false;
        
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("category", category);
            params.put("postId", postId);
            
            // 게시글에 달린 댓글도 함께 삭제
            session.delete(MAPPER_NAME + ".deleteComments", params);
            // 게시글 삭제
            result = session.delete(MAPPER_NAME + ".deletePost", params) > 0;
            
            session.commit();
        } catch(Exception e) {
            session.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }
    
    public boolean updatePost(PostDTO post) {
        SqlSession session = getSession();
        boolean result = false;
        
        try {
            result = session.update(MAPPER_NAME + ".updatePost", post) > 0;
            session.commit();
        } catch(Exception e) {
            session.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }
    	
    public boolean addLike(int postId, String category, String userId) {
        SqlSession session = getSession();
        boolean result = false;
        
        try {
            LikeDTO likeDTO = new LikeDTO();
            likeDTO.setPostId(postId);
            likeDTO.setCategory(category);
            likeDTO.setUserId(userId);
            
            int count = session.selectOne(MAPPER_NAME + ".checkLike", likeDTO);
            
            if(count == 0) {
                session.insert(MAPPER_NAME + ".insertLike", likeDTO);
                
                Map<String, Object> params = new HashMap<>();
                params.put("postId", postId);
                params.put("category", category);
                session.update(MAPPER_NAME + ".updatePostLikes", params);
                
                session.commit();
                result = true;
            }
        } catch(Exception e) {
            session.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }
    
    public PostDTO getPost(String category, int postId) {
        SqlSession session = getSession();
        PostDTO post = null;
        
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("category", category);
            params.put("postId", postId);
            
            System.out.println("Executing getPost query with params: " + params);
            post = session.selectOne(MAPPER_NAME + ".getPost", params);
            System.out.println("Query result: " + (post != null ? "게시글 찾음" : "게시글 없음"));
            
            return post;
        } catch(Exception e) {
            System.out.println("Error in getPost: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            session.close();
        }
    }
 // 게시글 목록 조회
    public List<PostDTO> getPostList(String category, int start, int end, 
                                   String searchType, String searchKeyword) {
        SqlSession session = getSession();
        List<PostDTO> list = null;
        
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("category", category);
            map.put("start", start);
            map.put("end", end);
            map.put("searchType", searchType);
            map.put("searchKeyword", searchKeyword);
            
            list = session.selectList(MAPPER_NAME + ".getPostList", map);
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return list;
    }

    // 전체 게시글 수 조회
    public int getTotalCount(String category, String searchType, String searchKeyword) {
        SqlSession session = getSession();
        int count = 0;
        
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("category", category);
            map.put("searchType", searchType);
            map.put("searchKeyword", searchKeyword);
            
            count = session.selectOne(MAPPER_NAME + ".getTotalCount", map);
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return count;
    }
    // 조회수 증가
    public void increaseViewCount(String category, int postId) {
        SqlSession session = getSession();
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("category", category);
            params.put("postId", postId);
            
            session.update(MAPPER_NAME + ".increaseViewCount", params);
            session.commit();
        } finally {
            session.close();
        }
    }
    // 게시글 삽입 메소드
    public int insertPost(PostDTO dto) {
        int result = 0;
        SqlSession session = this.getSession();
        try {
            // postId 생성
            Integer postId = session.selectOne(MAPPER_NAME+".getNextPostId", dto.getCategory());
            
            // PostDTO에 생성된 postId 설정
            dto.setPostId(postId);
            
            // insertPost 쿼리 실행
            result = session.insert(MAPPER_NAME+".insertPost", dto);
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
            session.rollback();
        } finally {
            session.close();
        }
        return result;
    }

    // SqlSession 객체 생성
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
