package sk.matejcik.SemestralnaPraca.Author;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import java.util.UUID;

@WebServlet(name = "AddAuthorServlet", value = "/add-author-servlet")
@MultipartConfig (
        fileSizeThreshold = 1024 * 1024 * 1, // 1MB
        maxFileSize = 1024 * 1024 * 10, //10MB
        maxRequestSize = 1024 * 1024 * 100 //100MB
)
public class AddAuthorServlet extends HttpServlet {

    public static final String UPLOAD_DIR = "public";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        request.setCharacterEncoding("UTF-8");

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
            name = request.getParameter("authorName");
            lastName = request.getParameter("authorLastName");
            birthDate = Date.valueOf(request.getParameter("authorBirthDate"));
            if (request.getParameter("authorDeathDate").equals("")) {
                deathDate = new Date(800,1,1);
            } else {
                deathDate = Date.valueOf(request.getParameter("authorDeathDate"));
            }
            biography = request.getParameter("authorBiography");
            birthPlace = request.getParameter("authorBirthPlace");

            AuthorController authorController = new AuthorController();
            List<Author> authorList = authorController.getAllAuthors();

            boolean usedName = false;

            for (Author a : authorList) {
                if (a.getName().equals(name) && a.getLastname().equals(lastName)) {
                    usedName = true;
                    break;
                }
            }

            if (usedName) {
                request.getSession().setAttribute("error", "This author already exists.");
                response.sendRedirect("error.jsp");
            } else {
                picture = AddAuthorServlet.uploadAuthorFile(request,getServletConfig().getServletContext().getRealPath("/") + AddAuthorServlet.UPLOAD_DIR);
                Author author = new Author(
                        null,
                        name,
                        lastName,
                        birthDate,
                        deathDate,
                        picture,
                        biography,
                        birthPlace
                );
                int result = authorController.insertAuthor(author);
                if (result == 1) {
                    response.sendRedirect("authorsBrowse.jsp");
                } else {
                    request.getSession().setAttribute("error", "Problem with connecting to database.");
                    response.sendRedirect("error.jsp");
                }
            }
        }
    }

    public static boolean authorValidation(HttpServletRequest request) {
        String name = request.getParameter("authorName") == null ? "" : request.getParameter("authorName");
        String lastName = request.getParameter("authorLastName") == null ? "" : request.getParameter("authorLastName");
        Date birthDate = request.getParameter("authorBirthDate").equals("") ? null : Date.valueOf(request.getParameter("authorBirthDate"));
        Date deathDate = request.getParameter("authorDeathDate").equals("") ? null : Date.valueOf(request.getParameter("authorDeathDate"));
        String biography = request.getParameter("authorBiography") == null ? "" : request.getParameter("authorBiography");
        String birthPlace = request.getParameter("authorBirthPlace") == null ? "" : request.getParameter("authorBirthPlace");

        if (name.length() == 0 || name.length() < 2 || name.length() > 30) {
            return false;
        }

        if (lastName.length() == 0 || lastName.length() < 3 || lastName.length() > 100) {
            return false;
        }

        if (birthDate == null || birthDate.after(new Date(121,5,1))) {
            return false;
        }

        if (deathDate != null && deathDate.after(new Date(121,5,1))) {
            return false;
        }

        if (biography.length() < 1) {
            return false;
        }

        if (birthPlace.length() == 0 || birthPlace.length() < 2 || birthPlace.length() > 30) {
            return false;
        }

        return true;
    }

    public static String uploadAuthorFile(HttpServletRequest request,String uploadFilePath) {

        String fileName = "";

        try {
            File uplDir = new File(uploadFilePath);
            if (!uplDir.exists()) {
                uplDir.mkdir();
            }

            Part part = request.getPart("pictureAuthor");

            String ext = part.getSubmittedFileName().split("\\.")[1];
            String newFileName = UUID.randomUUID().toString() + "." + ext;
            part.write(uploadFilePath + File.separator + newFileName);
            fileName = AddAuthorServlet.UPLOAD_DIR + File.separator + newFileName;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return fileName;
    }
}
