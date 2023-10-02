package sk.matejcik.SemestralnaPraca.Category;

import sk.matejcik.SemestralnaPraca.Book.BookController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "DeleteCategoryServlet", value = "/delete-category-servlet")
public class DeleteCategoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        request.setCharacterEncoding("UTF-8");

        int id = -1;
        if (request.getParameter("deleteCategory") != null && !request.getParameter("deleteCategory").equals("")) {
            id = Integer.parseInt(request.getParameter("deleteCategory"));
        }

        CategoryController categoryController = new CategoryController();
        int res = categoryController.deleteCategory(id);

        if (res == 0) {
            response.sendRedirect("error.jsp");
        } else {
            response.sendRedirect("deleteRecord.jsp?type=category");
        }
    }
}
