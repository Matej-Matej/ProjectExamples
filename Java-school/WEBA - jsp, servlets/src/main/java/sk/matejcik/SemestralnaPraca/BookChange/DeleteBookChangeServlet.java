package sk.matejcik.SemestralnaPraca.BookChange;

import sk.matejcik.SemestralnaPraca.AuthorChange.AuthorChangeController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "DeleteBookChangeServlet", value = "/delete-book-change-servlet")
public class DeleteBookChangeServlet extends HttpServlet {
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
            bookChangeController.deleteBookChange(id);
        }

        response.sendRedirect("notification.jsp");
    }
}