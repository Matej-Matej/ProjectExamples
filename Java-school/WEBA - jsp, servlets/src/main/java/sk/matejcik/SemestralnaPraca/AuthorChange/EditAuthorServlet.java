package sk.matejcik.SemestralnaPraca.AuthorChange;

import sk.matejcik.SemestralnaPraca.Author.AddAuthorServlet;
import sk.matejcik.SemestralnaPraca.Author.Author;
import sk.matejcik.SemestralnaPraca.Author.AuthorController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import java.util.UUID;

@WebServlet(name = "EditAuthorServlet", value = "/edit-author-servlet")
@MultipartConfig (
        fileSizeThreshold = 1024 * 1024 * 1, // 1MB
        maxFileSize = 1024 * 1024 * 10, //10MB
        maxRequestSize = 1024 * 1024 * 100 //100MB
)
public class EditAuthorServlet extends HttpServlet {

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
        String lastName = "";
        Date birthDate = new Date(100, 0, 1);
        Date deathDate = null;
        String picture = "";
        String biography = "";
        String birthPlace = "";


        if (!AddAuthorServlet.authorValidation(request)) {
            request.getSession().setAttribute("error", "There was a problem with validation.");
            response.sendRedirect("error.jsp");
        } else {
            id = Integer.parseInt(request.getParameter("authorId"));
            name = request.getParameter("authorName");
            lastName = request.getParameter("authorLastName");
            birthDate = Date.valueOf(request.getParameter("authorBirthDate"));
            if (!request.getParameter("authorDeathDate").equals("")) {
                deathDate = Date.valueOf(request.getParameter("authorDeathDate"));
            }
            biography = request.getParameter("authorBiography");
            birthPlace = request.getParameter("authorBirthPlace");

            AuthorChangeController authorChangeController = new AuthorChangeController();

            picture = AddAuthorServlet.uploadAuthorFile(request,getServletConfig().getServletContext().getRealPath("/") + AddAuthorServlet.UPLOAD_DIR);
            if (picture.equals("")) {
                picture = new AuthorController().getAuthorById(id).getPicture();
            }

            AuthorChange authorChange = new AuthorChange(
                    null,
                    new Author (
                            id,
                        name,
                        lastName,
                        birthDate,
                        deathDate,
                        picture,
                        biography,
                        birthPlace
                    )
            );
            int result = authorChangeController.insertAuthorChange(authorChange);
            if (result == 1) {
                response.sendRedirect("authorsBrowse.jsp");
            } else {
                request.getSession().setAttribute("error", "Problem with connecting to database.");
                response.sendRedirect("error.jsp");
            }
        }
    }
}

