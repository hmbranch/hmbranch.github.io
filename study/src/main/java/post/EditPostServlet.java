package post;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dao.PostCrud;

@WebServlet("/editPost.do")
public class EditPostServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String loginId = (String) session.getAttribute("ID");
        
        if(loginId == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        
        String category = request.getParameter("category");
        int postId = Integer.parseInt(request.getParameter("postId"));
        
        PostCrud dao = new PostCrud();
        PostDTO post = dao.getPost(category, postId);
        
        // 작성자 본인인지 확인
        if(post != null && loginId.equals(post.getAuthor())) {
            request.setAttribute("post", post);
            request.getRequestDispatcher("editPost.jsp").forward(request, response);
        } else {
            response.sendRedirect("postList.do");
        }
    }
}