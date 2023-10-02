package sk.matejcik.SemestralnaPraca.Book;

import com.google.gson.Gson;
import sk.matejcik.SemestralnaPraca.Category.Category;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "GetBooksByCategoryServlet", value = "/get-books-by-category-servlet")
public class GetBooksByCategoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        request.setCharacterEncoding("UTF-8");

        int category = 0;
        if (request.getParameter("category") != null) {
            category = Integer.parseInt(request.getParameter("category"));
        }

        BookController bookController = new BookController();
        Gson gson = new Gson();
        List<Book> bookList = bookController.getAllBooksByCategoryId(category);
        String json = gson.toJson(bookList);
        response.getWriter().write(json);
    }
}
