<%@ page import="sk.matejcik.SemestralnaPraca.Author.AuthorController" %>
<%@ page import="sk.matejcik.SemestralnaPraca.Author.Author" %>
<%@ page import="java.util.List" %>
<%@ page import="sk.matejcik.SemestralnaPraca.Category.CategoryController" %>
<%@ page import="sk.matejcik.SemestralnaPraca.Category.Category" %>
<%@ page import="sk.matejcik.SemestralnaPraca.BookCategory.BookCategory" %>
<%@ page import="sk.matejcik.SemestralnaPraca.Book.Book" %>
<%@ page import="sk.matejcik.SemestralnaPraca.Book.BookController" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="header.jsp" %>
</head>
<body>
<%@include file="navbar.jsp" %>
    <%
    if (!UserChecker.isUserLogged(request) || !UserChecker.isUserAdmin(request)) {
        response.sendRedirect("booksBrowse.jsp");
    }

    String type = "book";

    if (request.getParameter("type") != null) {
        type = request.getParameter("type");
    }
    %>
    <% if (type.equals("author")) { %>
<div class="add-container border border-danger rounded">
<form action="delete-author-servlet" class="logreg-form" id="form">
    <h3 class="text-center text-inverse add-delete-title">Delete author</h3>
    <select class="form-select" name="deleteAuthor" id="deleteAuthor" style="width: 100%; height: 40px; margin-top: 20px;" aria-label="Default select example ">
        <option value="" selected>Select Author to delete</option>
        <%
            AuthorController authorController = new AuthorController();
            List<Author> authorList = authorController.getAllAuthors();
            for (Author a : authorList) {
                out.println("<option value="+a.getAuthor_id()+" name=\"name\">" + a.getName() + " " + a.getLastname() + "</option>");
            }
        %>
    </select>
    <button class="logreg-button btn btn-danger" type="submit" name="">Delete
    </button>
</form>
</div>
<% } else if (type.equals("category")) {%>
<div class="add-container border border-danger rounded">
    <form action="delete-category-servlet" class="logreg-form" id="form1">
        <h3 class="text-center text-inverse add-delete-title">Delete category</h3>
        <select class="form-select" name="deleteCategory" id="deleteCategory" style="width: 100%; height: 40px; margin-top: 20px;" aria-label="Default select example ">
            <option value="" selected>Select Category to delete</option>
            <%
                CategoryController categoryController = new CategoryController();
                List<Category> categoryList = categoryController.getAllCategories();
                for (Category c : categoryList) {
                    out.println("<option value="+c.getCategory_id()+" name=\"name\">"  + c.getName() + "</option>");
                }
            %>
        </select>
        <button class="logreg-button btn btn-danger" type="submit" name="">Delete
        </button>
    </form>
</div>
<% } else { %>
<div class="add-container border border-danger rounded">
    <form action="delete-book-servlet" class="logreg-form" id="form2">
        <h3 class="text-center text-inverse add-delete-title">Delete book</h3>
        <select class="form-select" name="deleteBook" id="deleteBook" style="width: 100%; height: 40px; margin-top: 20px;" aria-label="Default select example ">
            <option value="" selected>Select Book to delete</option>
            <%
                BookController bookController = new BookController();
                List<Book> bookList = bookController.getAllBooks();
                for (Book b : bookList) {
                    out.println("<option value="+b.getBook_id()+" name=\"name\">" + b.getName() + "</option>");
                }
        %>
        </select>
        <button class="logreg-button btn btn-danger" type="submit" name="">Delete
        </button>
    </form>
</div>
<% } %>


</html>
