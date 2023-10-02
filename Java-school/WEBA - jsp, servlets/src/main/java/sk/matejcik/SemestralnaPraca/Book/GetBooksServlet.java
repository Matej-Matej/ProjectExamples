package sk.matejcik.SemestralnaPraca.Book;

import com.google.gson.Gson;
import sk.matejcik.SemestralnaPraca.Author.Author;
import sk.matejcik.SemestralnaPraca.Author.AuthorController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "GetBooksServlet", value = "/get-books-servlet")
public class GetBooksServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        request.setCharacterEncoding("UTF-8");

        BookController bookController = new BookController();
        List<Book> bookList = bookController.getAllBooks();
        Gson gson = new Gson();
        String json = gson.toJson(bookList);
        response.getWriter().write(json);
    }
}
