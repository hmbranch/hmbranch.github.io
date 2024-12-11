package comment;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CommentCrud;

/**
 * Servlet implementation class DeleteCommentServlet
 */
@WebServlet("/deleteComment.do")
public class DeleteCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteCommentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("ID");
        
        if(userId == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        
        int commentId = Integer.parseInt(request.getParameter("commentId"));
        String category = request.getParameter("category");
        int postId = Integer.parseInt(request.getParameter("postId"));
        
        CommentCrud dao = new CommentCrud();
        dao.deleteComment(commentId, userId);
        
        response.sendRedirect("viewPost.do?category=" + category + "&postId=" + postId);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
