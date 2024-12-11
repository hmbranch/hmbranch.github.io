package post;

import java.io.IOException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import dao.PostCrud;

@WebServlet("/writePost.do")
public class WritePostServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public WritePostServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("EUC-KR");
        String uploadPath = "/upload";
        int maxLimit = 5 * 1024 * 1024;
        String encType = "EUC-KR";
        ServletContext ctx = this.getServletContext();
        String realPath = ctx.getRealPath(uploadPath);
        String fileName = "";
        
        try {
            MultipartRequest multipart = new MultipartRequest(request, realPath,
                    maxLimit, encType, new DefaultFileRenamePolicy());
            
            fileName = multipart.getFilesystemName("file");
            String category = multipart.getParameter("category");
            String title = multipart.getParameter("title");
            String content = multipart.getParameter("content");
            if(fileName == null) {
            	fileName="";
            }
            System.out.println("카테고리 :"+category);
            System.out.println("타이틀 : "+title);
            System.out.println("콘텐트 : "+content);
            System.out.println("파일네임:"+fileName);
            
  
            PostDTO dto = new PostDTO();
            dto.setCategory(category);
            dto.setTitle(title);
            dto.setContent(content);
            dto.setFilePath(fileName);
            
            HttpSession session = request.getSession();
            String author = (String)session.getAttribute("ID");
            dto.setAuthor(author);
            
            PostCrud dao = new PostCrud();
            int result = dao.insertPost(dto);
            System.out.println("dto 카테고리 : "+dto.getCategory());
            System.out.println("dto 타이틀 : "+dto.getTitle());
            System.out.println("dto 콘텐트 : "+dto.getContent());
            System.out.println("dto 파일 : "+dto.getFilePath());
            System.out.println("dto postid : "+dto.getPostId());
            System.out.println("dto 게시자 : "+dto.getAuthor());
            if(result > 0) {
                System.out.println("업로드 성공");
            } else {
                System.out.println("업로드 실패");
            }
            
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        response.sendRedirect("index.jsp");
    }
}