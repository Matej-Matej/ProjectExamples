package sk.matejcik.SemestralnaPraca.Category;

import com.google.gson.Gson;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "getCategoriesServlet", value = "/get-categories-servlet")
public class GetCategoriesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        CategoryController categoryController = new CategoryController();
        List<Category> categoryList = categoryController.getAllCategories();
        Gson gson = new Gson();
        String json = gson.toJson(categoryList);
        response.getWriter().write(json);
    }
}
