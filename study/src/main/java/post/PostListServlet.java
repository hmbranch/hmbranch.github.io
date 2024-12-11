package post;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.PostCrud;

@WebServlet("/postList.do")
public class PostListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 10;        // 페이지당 게시글 수
    private static final int PAGE_GROUP = 10;       // 화면에 표시할 페이지 번호 수

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // 파라미터 받기
        String category = request.getParameter("category");
        if(category == null) category = "notice_post";  // 기본값

        String pageStr = request.getParameter("page");
        int currentPage = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;

        String searchType = request.getParameter("searchType");
        String searchKeyword = request.getParameter("searchKeyword");

        PostCrud dao = new PostCrud();
        
        // 전체 게시글 수 조회
        int totalCount = dao.getTotalCount(category, searchType, searchKeyword);
        
        if(totalCount > 0) {  // 게시글이 있는 경우
            // 전체 페이지 수 계산
            int totalPages = (totalCount + PAGE_SIZE - 1) / PAGE_SIZE;
            
            // 현재 페이지 그룹의 시작과 끝
            int currentGroup = (currentPage - 1) / PAGE_GROUP;
            int startPage = currentGroup * PAGE_GROUP + 1;
            int endPage = Math.min(startPage + PAGE_GROUP - 1, totalPages);

            // 게시글 범위 계산
            int start = (currentPage - 1) * PAGE_SIZE + 1;
            int end = currentPage * PAGE_SIZE;

            // 게시글 목록 조회
            List<PostDTO> postList = dao.getPostList(category, start-1, end, searchType, searchKeyword);

            // 결과 저장
            request.setAttribute("postList", postList);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("startPage", startPage);
            request.setAttribute("endPage", endPage);
        }

        request.setAttribute("category", category);
        request.setAttribute("searchType", searchType);
        request.setAttribute("searchKeyword", searchKeyword);

        // JSP로 포워딩
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}