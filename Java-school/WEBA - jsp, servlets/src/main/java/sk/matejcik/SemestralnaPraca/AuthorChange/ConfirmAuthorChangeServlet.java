package sk.matejcik.SemestralnaPraca.AuthorChange;

import sk.matejcik.SemestralnaPraca.Author.AuthorController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ConfirmAuthorChangeServlet", value = "/confirm-author-change-servlet")
public class ConfirmAuthorChangeServlet extends HttpServlet {
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
            AuthorController authorController = new AuthorController();
            AuthorChange authorChange = authorChangeController.getAuthorChange(id);

            if (authorChange != null) {
                authorController.updateAuthor(authorChange.getAuthor());
                authorChangeController.deleteAuthorChange(id);

            } else {
                request.getSession().setAttribute("error", "Unexpected problem occurs.");
                response.sendRedirect("error.jsp");
            }

        }

        response.sendRedirect("notification.jsp");
    }
}
