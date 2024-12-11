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
 * Servlet implementation class AddCommentServlet
 */
@WebServlet("/addComment.do")
public class AddCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddCommentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 	request.setCharacterEncoding("EUC-KR");
		 	response.setCharacterEncoding("EUC-KR");
			HttpSession session = request.getSession();
	        String userId = (String) session.getAttribute("ID");
	        
	        if(userId == null) {
	            response.sendRedirect("index.jsp");
	            return;
	        }
	        
	        String category = request.getParameter("category");
	        int postId = Integer.parseInt(request.getParameter("postId"));
	        String content = request.getParameter("content");
	        
	        CommentDTO comment = new CommentDTO();
	        comment.setPostId(postId);
	        comment.setCategory(category);
	        comment.setContent(content);
	        comment.setAuthor(userId);
	        
	        CommentCrud dao = new CommentCrud();
	        boolean success = dao.insertComment(comment);
	        
	        session.setAttribute("COMMENT_MESSAGE", "success");
	        response.sendRedirect("viewPost.do?category=" + category + "&postId=" + postId);
	    }
	}
