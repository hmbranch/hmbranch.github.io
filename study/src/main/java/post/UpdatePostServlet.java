package post;

import java.io.IOException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import dao.PostCrud;

@WebServlet("/updatePost.do")
public class UpdatePostServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("EUC-KR");
        String uploadPath = "/upload";
        int maxSize = 10 * 1024 * 1024;  // 10MB
        
        ServletContext context = this.getServletContext();
        String realPath = context.getRealPath(uploadPath);
        
        MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, 
                "EUC-KR", new DefaultFileRenamePolicy());
        
        int postId = Integer.parseInt(multi.getParameter("postId"));
        String category = multi.getParameter("category");
        String title = multi.getParameter("title");
        String content = multi.getParameter("content");
        String newFile = multi.getFilesystemName("file");
        String deleteFile = multi.getParameter("deleteFile");
        
        PostDTO post = new PostDTO();
        post.setPostId(postId);
        post.setCategory(category);
        post.setTitle(title);
        post.setContent(content);
        
        // 파일 처리
        if(newFile != null) {
            post.setFilePath(newFile);
        } else if("true".equals(deleteFile)) {
            post.setFilePath("");
        }
        
        PostCrud dao = new PostCrud();
        boolean success = dao.updatePost(post);
        
        if(success) {
            response.sendRedirect("viewPost.do?category=" + category + "&postId=" + postId);
        } else {
            response.sendRedirect("postList.do");
        }
    }
}