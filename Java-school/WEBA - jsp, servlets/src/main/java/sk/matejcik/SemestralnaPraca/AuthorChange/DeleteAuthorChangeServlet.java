package sk.matejcik.SemestralnaPraca.AuthorChange;

import sk.matejcik.SemestralnaPraca.Author.AuthorController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "DeleteAuthorChangeServlet", value = "/delete-author-change-servlet")
public class DeleteAuthorChangeServlet extends HttpServlet {
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

            AuthorChangeController authorChangeController = new AuthorChangeController();
            authorChangeController.deleteAuthorChange(id);
        }

        response.sendRedirect("notification.jsp");
    }
}
