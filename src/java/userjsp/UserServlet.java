package userjsp;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
  
@WebServlet("/user")
public class UserServlet extends HttpServlet {
  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Контекст приложения
//        request.setAttribute("name", "Tom");
//        request.setAttribute("age", 34);
         
        // Контекст сессии
        HttpSession session = request.getSession();
        session.setAttribute("name", "Tom");
        session.setAttribute("age", 34);
           
        
        getServletContext().getRequestDispatcher("/includes/basic.jsp").forward(request, response);
    }
}
