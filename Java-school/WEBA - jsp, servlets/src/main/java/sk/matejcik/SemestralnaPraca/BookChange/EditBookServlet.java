package sk.matejcik.SemestralnaPraca.BookChange;

import sk.matejcik.SemestralnaPraca.Author.AddAuthorServlet;
import sk.matejcik.SemestralnaPraca.Author.Author;
import sk.matejcik.SemestralnaPraca.AuthorChange.AuthorChange;
import sk.matejcik.SemestralnaPraca.AuthorChange.AuthorChangeController;
import sk.matejcik.SemestralnaPraca.Book.AddBookServlet;
import sk.matejcik.SemestralnaPraca.Book.Book;
import sk.matejcik.SemestralnaPraca.Book.BookController;
import sk.matejcik.SemestralnaPraca.BookAuthor.BookAuthor;
import sk.matejcik.SemestralnaPraca.BookAuthor.BookAuthorController;
import sk.matejcik.SemestralnaPraca.BookCategory.BookCategory;
import sk.matejcik.SemestralnaPraca.BookCategory.BookCategoryController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "EditBookServlet", value = "/edit-book-servlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1MB
        maxFileSize = 1024 * 1024 * 10, //10MB
        maxRequestSize = 1024 * 1024 * 100 //100MB
)
public class EditBookServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        request.setCharacterEncoding("UTF-8");

        int id = 0;
        String name = "";
        String content = "";
        int page_count = 0;
        int year = 0;
        String publisher = "";
        String isbn = "";
        String picture = "";


        if (!AddBookServlet.validate(request)) {
            request.getSession().setAttribute("error", "There was a problem with validation.");
            response.sendRedirect("error.jsp");
        } else {
            id = Integer.parseInt(request.getParameter("bookId"));
            name = request.getParameter("bookName");
            content = request.getParameter("bookContent");
            page_count = Integer.parseInt(request.getParameter("bookPageCount"));
            year = Integer.parseInt(request.getParameter("bookYear"));
            publisher = request.getParameter("bookPublisher");
            isbn = request.getParameter("bookIsbn");

            BookChangeController bookChangeController = new BookChangeController();

            picture = AddBookServlet.uploadFile(request, getServletConfig().getServletContext().getRealPath("/") + AddAuthorServlet.UPLOAD_DIR);
            if (picture.equals("")) {
                picture = new BookController().getBookById(id).getPicture();
            }
            BookChange bookChange = new BookChange(
                    null,
                    new Book(
                            id,
                    name,
                    content,
                    page_count,
                    year,
                    publisher,
                    isbn,
                    picture
                    )
            );
            int result = bookChangeController.insertBookChange(bookChange);
            if (result == 1) {
                response.sendRedirect("booksBrowse.jsp");
            } else {
                request.getSession().setAttribute("error", "Problem with connecting to database.");
                response.sendRedirect("error.jsp");
            }
        }
    }
}
