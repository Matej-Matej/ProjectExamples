package sk.matejcik.SemestralnaPraca.Author;

import com.google.gson.Gson;
import sk.matejcik.SemestralnaPraca.Category.Category;
import sk.matejcik.SemestralnaPraca.Category.CategoryController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "GetAuthorsServlet", value = "/get-authors-servlet")
public class GetAuthorsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        request.setCharacterEncoding("UTF-8");

        AuthorController authorController = new AuthorController();
        List<Author> authorList = authorController.getAllAuthors();
        Gson gson = new Gson();
        String json = gson.toJson(authorList);
        response.getWriter().write(json);
    }
}
