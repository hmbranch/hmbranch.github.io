package post;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.PostCrud;

@WebServlet("/searchPost.do")
public class SearchPostServlet extends HttpServlet {
    private static final int PAGE_SIZE = 10;
    private static final int PAGE_GROUP = 10;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
            
        String category = request.getParameter("category");
        String searchKeyword = request.getParameter("searchKeyword");
        String pageStr = request.getParameter("page");
        int currentPage = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
        
        PostCrud dao = new PostCrud();
        
        // 검색 결과 수 조회
        int totalCount = dao.getSearchCount(category, searchKeyword);
        
        if(totalCount > 0) {
            int totalPages = (totalCount + PAGE_SIZE - 1) / PAGE_SIZE;
            int currentGroup = (currentPage - 1) / PAGE_GROUP;
            int startPage = currentGroup * PAGE_GROUP + 1;
            int endPage = Math.min(startPage + PAGE_GROUP - 1, totalPages);
            
            int start = (currentPage - 1) * PAGE_SIZE + 1;
            int end = currentPage * PAGE_SIZE;
            
            // 검색 결과 조회
            List<PostDTO> searchResults = dao.searchPosts(category, searchKeyword, start-1, end);
            
            request.setAttribute("postList", searchResults);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("startPage", startPage);
            request.setAttribute("endPage", endPage);
        }
        
        request.setAttribute("category", category);
        request.setAttribute("searchKeyword", searchKeyword);
        request.setAttribute("isSearch", true);  // 검색 결과임을 표시
        
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}