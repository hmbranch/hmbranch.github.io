package post;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dao.PostCrud;

@WebServlet("/deletePost.do")
public class DeletePostServlet extends HttpServlet {
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
        
        if(post != null && loginId.equals(post.getAuthor())) {
            boolean success = dao.deletePost(category, postId);
            if(success) {
                // 삭제 성공 메시지
                session.setAttribute("DELETE_MESSAGE", "success");
            }
        }
        
        response.sendRedirect("postList.do?category=" + category);
    }
}