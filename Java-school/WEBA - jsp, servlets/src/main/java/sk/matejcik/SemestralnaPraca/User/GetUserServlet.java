package sk.matejcik.SemestralnaPraca.User;

import com.google.gson.Gson;
import sk.matejcik.SemestralnaPraca.Category.Category;
import sk.matejcik.SemestralnaPraca.Category.CategoryController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "GetUserServlet", value = "/get-user-servlet")
public class GetUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        UserController userController = new UserController();
        List<User> userList = userController.getAllUser();
        Gson gson = new Gson();
        String json = gson.toJson(userList);
        response.getWriter().write(json);
    }
}
