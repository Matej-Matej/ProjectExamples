package sk.matejcik.SemestralnaPraca.Book;

import sk.matejcik.SemestralnaPraca.Author.AddAuthorServlet;
import sk.matejcik.SemestralnaPraca.Author.Author;
import sk.matejcik.SemestralnaPraca.Author.AuthorController;
import sk.matejcik.SemestralnaPraca.BookAuthor.BookAuthor;
import sk.matejcik.SemestralnaPraca.BookAuthor.BookAuthorController;
import sk.matejcik.SemestralnaPraca.BookCategory.BookCategory;
import sk.matejcik.SemestralnaPraca.BookCategory.BookCategoryController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@WebServlet(name = "AddBookServlet", value = "/add-book-servlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1MB
        maxFileSize = 1024 * 1024 * 10, //10MB
        maxRequestSize = 1024 * 1024 * 100 //100MB
)
public class AddBookServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "public";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        request.setCharacterEncoding("UTF-8");

        String name = "";
        String content = "";
        int page_count = 0;
        int year = 0;
        String publisher = "";
        String isbn = "";
        String picture = "";
        List<Integer> authors = new ArrayList<>();
        List<Integer> categories = new ArrayList<>();


        if (!AddBookServlet.validate(request)) {
            request.getSession().setAttribute("error", "There was a problem with validation.");
            response.sendRedirect("error.jsp");
        } else {
            name = request.getParameter("bookName");
            content = request.getParameter("bookContent");
            page_count = Integer.parseInt(request.getParameter("bookPageCount"));
            year = Integer.parseInt(request.getParameter("bookYear"));
            publisher = request.getParameter("bookPublisher");
            isbn = request.getParameter("bookIsbn");

            boolean value = true;
            int i = 1;
            while(value) {
                if (request.getParameter("selectCategory"+i) != null) {
                    if (Integer.parseInt(request.getParameter("selectCategory"+i)) >= 0) {
                        categories.add(Integer.parseInt(request.getParameter("selectCategory"+i)));
                    }
                } else {
                    value = false;
                }
                i++;
            }

            value = true;
            i = 1;
            while(value) {
                if (request.getParameter("selectAuthor"+i) != null) {
                    if (Integer.parseInt(request.getParameter("selectAuthor"+i)) >= 0) {
                        authors.add(Integer.parseInt(request.getParameter("selectAuthor"+i)));
                    }
                } else {
                    value = false;
                }
                i++;
            }

            BookController bookController = new BookController();
            List<Book> bookList = bookController.getAllBooks();

            boolean usedName = false;

            for (Book b : bookList) {
                if (b.getName().equals(name)) {
                    usedName = true;
                    break;
                }
            }

            if (usedName) {
                request.getSession().setAttribute("error", "This book already exists.");
                response.sendRedirect("error.jsp");
            } else {
                picture = AddBookServlet.uploadFile(request,getServletConfig().getServletContext().getRealPath("/") + AddAuthorServlet.UPLOAD_DIR);
                Book book = new Book(
                        null,
                        name,
                        content,
                        page_count,
                        year,
                        publisher,
                        isbn,
                        picture

                );
                int result = bookController.insertBook(book);
                if (result == 1) {
                    Book addedBook = bookController.getBookWithName(name);
                    if (addedBook != null) {
                        BookAuthorController bookAuthorController = new BookAuthorController();
                        for (Integer a : authors) {
                                bookAuthorController.insertBookAuthor(new BookAuthor(null, addedBook.getBook_id(), a));
                        }
                        BookCategoryController bookCategoryController = new BookCategoryController();
                        for (Integer c : categories) {
                                bookCategoryController.insertBookCategory(new BookCategory(null, addedBook.getBook_id(), c));
                        }
                    }
                    response.sendRedirect("booksBrowse.jsp");
                } else {
                    request.getSession().setAttribute("error", "Problem adding book");
                    response.sendRedirect("error.jsp");
                }
            }
        }
    }
    public static boolean validate(HttpServletRequest request) {

        String bookName = request.getParameter("bookName") == null ? "" : request.getParameter("bookName");
        String bookContent = request.getParameter("bookContent") == null ? "" : request.getParameter("bookContent");
        int bookPageCount = request.getParameter("bookPageCount") == null ? 0 : Integer.parseInt(request.getParameter("bookPageCount"));
        String bookPublisher = request.getParameter("bookPublisher") == null ? "" : request.getParameter("bookPublisher");
        String bookIsbn = request.getParameter("bookIsbn") == null ? "" : request.getParameter("bookIsbn");

        if (request.getParameter("bookYear") == null) {
            return false;
        }

        if (bookName.length() == 0 || bookName.length() < 2 || bookName.length() > 30) {
            return false;
        }

        if (bookPublisher.length() == 0 || bookPublisher.length() < 2 || bookPublisher.length() > 50) {
            return false;
        }

        if (bookIsbn.length() == 0 || bookIsbn.length() < 2 || bookIsbn.length() > 30) {
            return false;
        }

        if (bookPageCount < 1) {
            return false;
        }

        if (bookContent.length() < 1) {
            return false;
        }

        return true;
    }
    public static String uploadFile(HttpServletRequest request,String uploadFilePath) {

        String fileName = "";

        try {
            File uplDir = new File(uploadFilePath);
            if (!uplDir.exists()) {
                uplDir.mkdir();
            }

            Part part = request.getPart("pictureBook");

            String ext = part.getSubmittedFileName().split("\\.")[1];
            String newFileName = UUID.randomUUID().toString() + "." + ext;
            part.write(uploadFilePath + File.separator + newFileName);
            fileName = AddBookServlet.UPLOAD_DIR + File.separator + newFileName;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return fileName;
    }
}
