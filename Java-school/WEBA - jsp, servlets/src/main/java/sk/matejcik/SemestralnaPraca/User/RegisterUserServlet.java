package sk.matejcik.SemestralnaPraca.User;

import org.springframework.security.crypto.bcrypt.BCrypt;
import sk.matejcik.SemestralnaPraca.Author.AddAuthorServlet;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "RegisterUserServlet", value = "/register-user-servlet")
public class RegisterUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");
        request.setCharacterEncoding("UTF-8");

        if (!validation(request)) {
            request.getSession().setAttribute("error", "There was a problem with validation.");
            response.sendRedirect("error.jsp");
        } else {
            String name = request.getParameter("name");
            String lastname = request.getParameter("lastname");
            String password = request.getParameter("password");
            String email = request.getParameter("email");


            UserController userController = new UserController();

            List<String> emails = userController.getAllEmails();
            boolean usedEmail = false;

            for (String e : emails) {
                if (e.equals(email)) {
                    usedEmail = true;
                }
            }

            if (usedEmail) {
                response.getWriter().write("e;Used email");
            } else {
                String hashPassword = BCrypt.hashpw(password,BCrypt.gensalt());
                User user = new User(null,name,lastname,hashPassword,email,"",UserRoleEnum.USER.toString());

                int result = userController.insertUser(user);
                if (result == 1) {
                    user = userController.getUser(email);
                    if (user != null) {
                        request.getSession().setAttribute("user",user);
                        response.getWriter().write("s");
                    }
                } else {
                    response.getWriter().write("red;");
                }
            }
        }
    }

    public boolean validation(HttpServletRequest request) {
        String name = request.getParameter("name") == null ? "" : request.getParameter("name");
        String lastName = request.getParameter("lastname") == null ? "" : request.getParameter("lastname");
        String password = request.getParameter("password") == null ? "" : request.getParameter("password");
        String email = request.getParameter("email") == null ? "" : request.getParameter("email");

        if (name.length() == 0 || name.length() < 3 || name.length() > 30) {
            return false;
        }

        if (lastName.length() == 0 || lastName.length() < 3 || lastName.length() > 50) {
            return false;
        }

        if (password.length() == 0 || password.length() < 3 || password.length() > 50) {
            return false;
        }

        if (email.length() == 0 || !email.contains("@") || !email.contains(".")) {
            return false;
        }

        return true;
    }
}
