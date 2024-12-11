package login;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LogoutServlet
 */
@WebServlet("/logout.do")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // 먼저 ID 제거
        session.removeAttribute("ID");
        
        // 새로운 세션 생성하여 로그아웃 메시지 저장
        HttpSession newSession = request.getSession(true);
        newSession.setAttribute("LOGOUT_MESSAGE", "logout");
        
        // 리다이렉트
        response.sendRedirect("index.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
    throws ServletException, IOException {
        doGet(request, response);
    }
}
