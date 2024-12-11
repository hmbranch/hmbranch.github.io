package login;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserCrud;



/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login.do")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
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
		String id = request.getParameter("ID");
		String password = request.getParameter("PWD");
		UserCrud dao = new UserCrud();
		LoginDTO dto = new LoginDTO(); dto.setUser_id(id);dto.setUser_password(password);
		String yesOrNo = dao.getIdByLogin(dto);
		if(yesOrNo != null) {//로그인 성공한 경우
			//로그인 성공했으므로 HttpSession에 데이터(일반적으로 계정)를 저장한다.
			HttpSession session = request.getSession();	
			 session.setAttribute("ID", id);
			 session.setAttribute("LOGIN_MESSAGE", "success");
			 response.sendRedirect("index.jsp");
		}else {//로그인 실패한 경우
			 HttpSession session = request.getSession();
			    session.setAttribute("LOGIN_MESSAGE", "failure");
			    response.sendRedirect("index.jsp"); 
		}
	}
}
