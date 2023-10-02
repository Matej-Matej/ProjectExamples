package sk.matejcik.SemestralnaPraca.Author;

import com.google.gson.Gson;
import sk.matejcik.SemestralnaPraca.Category.Category;
import sk.matejcik.SemestralnaPraca.Category.CategoryController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "GetAuthorsOptionServlet", value = "/get-authors-option-servlet")
public class GetAuthorsOptionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        response.getWriter().write(new Gson().toJson(new AuthorController().getAllAuthors()));
    }
}
