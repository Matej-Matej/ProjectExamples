package sk.matejcik.SemestralnaPraca.User;

import org.springframework.security.crypto.bcrypt.BCrypt;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "LoginUserServlet", value = "/login-user-servlet")
public class LoginUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");
        request.setCharacterEncoding("UTF-8");

        String email = "";
        String password = "";
        User user = null;


        if (request.getParameter("email") != null && request.getParameter("password") != null) {
            try {
                email = request.getParameter("email");
                password = request.getParameter("password");

            }catch (Exception e) {
                e.printStackTrace();
            }
        }

        UserController userController = new UserController();
        user = userController.getUser(email);

        if (user == null) {
            response.getWriter().write("e;User not found.");
        } else {
            if (BCrypt.checkpw(password,user.getPassword())) {
                request.getSession().setAttribute("user",user);
                response.getWriter().write("s;success");
            } else {
                response.getWriter().write("e;Wrong password.");
            }
        }
    }
}
