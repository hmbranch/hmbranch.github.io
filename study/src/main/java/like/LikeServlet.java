package like;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.PostCrud;
import post.PostDTO;

/**
 * Servlet implementation class LikeServlet
 */
@WebServlet("/likePost.do")
public class LikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LikeServlet() {
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
		  response.setContentType("text/html;charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        
	        HttpSession session = request.getSession();
	        String userId = (String) session.getAttribute("ID");
	        
	        if(userId == null) {
	            out.print("{\"success\":false, \"message\":\"로그인이 필요합니다.\"}");
	            return;
	        }
	        
	        int postId = Integer.parseInt(request.getParameter("postId"));
	        String category = request.getParameter("category");
	        
	        PostCrud dao = new PostCrud();
	        boolean success = dao.addLike(postId, category, userId);
	        
	        if(success) {
	            PostDTO post = dao.getPost(category, postId);
	            // viewPost.jsp와 index.jsp 모두 업데이트하기 위한 처리
	            String referer = request.getHeader("Referer");
	            if(referer != null && referer.contains("postList.do")) {
	                response.sendRedirect("postList.do?category=" + category);
	            } else {
	                out.print("{\"success\":true, \"likes\":" + post.getLikes() + "}");
	            }
	        } else {
	            out.print("{\"success\":false, \"message\":\"이미 추천한 게시글입니다.\"}");
	        }
	    }
	}
