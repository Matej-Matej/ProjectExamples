package sk.matejcik.SemestralnaPraca.BookChange;

import sk.matejcik.SemestralnaPraca.Author.AuthorController;
import sk.matejcik.SemestralnaPraca.AuthorChange.AuthorChange;
import sk.matejcik.SemestralnaPraca.AuthorChange.AuthorChangeController;
import sk.matejcik.SemestralnaPraca.Book.BookController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ConfirmBookChangeServlet", value = "/confirm-book-change-servlet")
public class ConfirmBookChangeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        request.setCharacterEncoding("UTF-8");

        int id = -1;

        if (request.getParameter("id") != null) {
            id = Integer.parseInt(request.getParameter("id"));

            BookChangeController bookChangeController = new BookChangeController();
            BookController bookController = new BookController();
            BookChange bookChange = bookChangeController.getBookChange(id);

            if (bookChange != null) {
                bookController.updateBook(bookChange.getBook());
                bookChangeController.deleteBookChange(id);

            } else {
                request.getSession().setAttribute("error", "Unexpected problem occurs.");
                response.sendRedirect("error.jsp");
            }

        }

        response.sendRedirect("notification.jsp");
    }
}