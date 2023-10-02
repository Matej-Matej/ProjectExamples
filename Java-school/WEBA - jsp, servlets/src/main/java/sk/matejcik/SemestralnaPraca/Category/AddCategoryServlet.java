package sk.matejcik.SemestralnaPraca.Category;

import sk.matejcik.SemestralnaPraca.User.User;
import sk.matejcik.SemestralnaPraca.User.UserController;
import sk.matejcik.SemestralnaPraca.User.UserRoleEnum;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "addCategoryServlet", value = "/add-category-servlet")
public class AddCategoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        request.setCharacterEncoding("UTF-8");

        String name = "";
        if (!validate(request)) {
            request.getSession().setAttribute("error", "There was a problem with validation.");
            response.sendRedirect("error.jsp");
        } else {
            name = request.getParameter("categoryName");

            CategoryController categoryController = new CategoryController();
            List<Category> categoryList = categoryController.getAllCategories();

            boolean usedName = false;

            for (Category c : categoryList) {
                if (c.getName().equals(name)) {
                    usedName = true;
                }
            }

            if (usedName) {
                request.getSession().setAttribute("error", "Category already exists.");
                response.sendRedirect("error.jsp");
            } else {
                Category category = new Category(null, name);
                int result = categoryController.insertCategory(category);
                if (result == 1) {
                    response.sendRedirect("categoryBrowse.jsp");
                } else {
                    request.getSession().setAttribute("error", "Problem with connecting to database.");
                    response.sendRedirect("error.jsp");
                }
            }
        }
    }

    private boolean validate(HttpServletRequest request) {
        String name = request.getParameter("categoryName") == null ? "" : request.getParameter("categoryName");

        if (name.length() == 0 || name.length() < 2 || name.length() > 30) {
            return false;
        }

        return true;
    }

}
