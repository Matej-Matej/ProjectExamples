package sk.matejcik.SemestralnaPraca.BookState;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "AddBookStateServlet", value = "/add-book-state-servlet")
public class AddBookStateServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        request.setCharacterEncoding("UTF-8");

        String status = "";
        int bookId = 0;
        int userId = 0;

        if (request.getParameter("bookStatus") != null && request.getParameter("bookId") != null && request.getParameter("userId") != null) {
            status = request.getParameter("bookStatus");
            bookId = Integer.parseInt(request.getParameter("bookId"));
            userId = Integer.parseInt(request.getParameter("userId"));

            BookStateController bookStateController = new BookStateController();
            BookState bookState = bookStateController.getBookStateById(userId,bookId);

            if (bookState == null) {
                if (!status.equals("")) {
                    bookStateController.insertBookState(new BookState(null,userId,bookId,status));
                }
            } else {
                if (status.equals("")) {
                    bookStateController.deleteBookState(bookState.getBook_state_id());
                } else {
                    bookStateController.updateBookState(bookState.getBook_state_id(),status);
                }

            }

            response.sendRedirect("bookProfile.jsp?id="+bookId);
        } else {
            request.getSession().setAttribute("error", "Problem with communication with servlet.");
            response.sendRedirect("error.jsp");
        }



    }
}
