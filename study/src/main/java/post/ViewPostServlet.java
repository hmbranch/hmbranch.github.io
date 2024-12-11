package post;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import comment.CommentDTO;
import dao.CommentCrud;
import dao.PostCrud;

@WebServlet("/viewPost.do")
public class ViewPostServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String category = request.getParameter("category");
            int postId = Integer.parseInt(request.getParameter("postId"));
            
            System.out.println("Category: " + category);
            System.out.println("PostId: " + postId);

            PostCrud dao = new PostCrud();
            CommentCrud cdao = new CommentCrud();

            // 게시글 조회
            PostDTO post = dao.getPost(category, postId);
            
            if (post == null) {
                System.out.println("게시글을 찾을 수 없습니다.");
                response.sendRedirect("postList.do");
                return;
            }

            // 조회수 증가
            dao.increaseViewCount(category, postId);
            
            // 댓글 목록 조회 추가
            List<CommentDTO> comments = cdao.getComments(postId, category);
            
            request.setAttribute("post", post);
            request.setAttribute("comments", comments); // 댓글 목록을 request에 저장
            
            request.getRequestDispatcher("viewPost.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("postList.do");
        }
    }
}