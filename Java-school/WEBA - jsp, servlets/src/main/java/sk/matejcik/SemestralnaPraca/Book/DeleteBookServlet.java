package sk.matejcik.SemestralnaPraca.Book;

import sk.matejcik.SemestralnaPraca.Author.AuthorController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "DeleteBookServlet", value = "/delete-book-servlet")
public class DeleteBookServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        request.setCharacterEncoding("UTF-8");

        int id = -1;
        if (request.getParameter("deleteBook") != null && !request.getParameter("deleteBook").equals("")) {
            id = Integer.parseInt(request.getParameter("deleteBook"));
        }

        BookController bookController = new BookController();
        int res = bookController.deleteBook(id);

        if (res == 0) {
            response.sendRedirect("error.jsp");
        } else {
            response.sendRedirect("deleteRecord.jsp?type=book");
        }
    }
}
