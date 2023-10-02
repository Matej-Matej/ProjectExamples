package sk.matejcik.SemestralnaPraca.Author;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "DeleteAuthorServlet", value = "/delete-author-servlet")
public class DeleteAuthorServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        request.setCharacterEncoding("UTF-8");

        int id = -1;
        if (request.getParameter("deleteAuthor") != null && !request.getParameter("deleteAuthor").equals("")) {
            id = Integer.parseInt(request.getParameter("deleteAuthor"));
        }

        AuthorController authorController = new AuthorController();
        int res = authorController.deleteAuthor(id);

        if (res == 0) {
            response.sendRedirect("error.jsp");
        } else {
            response.sendRedirect("deleteRecord.jsp?type=author");
        }
    }
}
