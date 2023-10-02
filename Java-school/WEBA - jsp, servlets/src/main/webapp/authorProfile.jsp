<%@ page import="sk.matejcik.SemestralnaPraca.Author.Author" %>
<%@ page import="sk.matejcik.SemestralnaPraca.Author.AuthorController" %>
<%@ page import="java.util.List" %>
<%@ page import="sk.matejcik.SemestralnaPraca.BookAuthor.BookAuthorController" %>
<%@ page import="sk.matejcik.SemestralnaPraca.Book.Book" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="header.jsp" %>
</head>
<body>
<% request.getSession().setAttribute("navbarType","authors");%>
<%@include file="navbar.jsp" %>

<%
    AuthorController authorController = new AuthorController();
    BookAuthorController bookAuthorController = new BookAuthorController();

    int authorId = -1;
    try {
        if (request.getParameter("id") != null) {
            authorId = Integer.parseInt(request.getParameter("id"));
        }
    } catch (NumberFormatException e) {
        e.printStackTrace();
    }
    if (authorId == -1) {
        response.sendRedirect("authorsBrowse.jsp");
    }


    Author ourAuthor = authorController.getAuthorById(authorId);

    if (ourAuthor == null) {
        response.sendRedirect("authorsBrowse.jsp");
    }

    List<Book> authorBooks = bookAuthorController.getBooksOfAuthor(authorId);

%>

<div class="container" style="margin-top: 100px;">
    <div class="main-body">
        <div class="row gutters-sm">
            <div class="col-md-4 mb-3">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex flex-column align-items-center text-center">
                            <% if (ourAuthor.getPicture() == null || ourAuthor.getPicture().equals("")) {%>
                            <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="Admin"
                                 class="rounded-circle" width="150">
                            <% } else { %>
                            <img src="<%=ourAuthor.getPicture()%>" alt="Admin"
                                 class="rounded-circle" width="150">
                            <% } %>
                            <div class="mt-3">
                                <h4><%=ourAuthor.getName()%> <%=ourAuthor.getLastname()%></h4>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card mt-4">
                    <div class="col">
                        <h6 class="mb-0" style="padding: 5px;">Books</h6>
                    </div>
                    <ul class="list-group list-group-flush">
                        <% for (Book b : authorBooks) { %>
                        <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                            <a href="bookProfile.jsp?id=<%=b.getBook_id()%>"><span class="text-secondary"><%=b.getName()%></span></a>
                        </li>
                        <%}%>
                    </ul>
                </div>
            </div>
            <div class="col-md-8">
                <div class="card mb-3">
                    <% if (UserChecker.isUserLogged(request)) { %>
                    <div class="card-head">
                        <a href="add.jsp?type=author&idAuthor=<%=ourAuthor.getAuthor_id()%>" class="close float-right" style="padding: 10px; font-size: 15px;">Edit author</a>
                    </div>
                    <% } %>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-sm-3">
                                <h6 class="mb-0">Birth</h6>
                            </div>
                            <div class="col-sm-9 text-secondary">
                                <%=ourAuthor.getBirthDate()%> (<%=ourAuthor.getBirthPlace()%>)
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-3">
                                <h6 class="mb-0">Death</h6>
                            </div>
                            <div class="col-sm-9 text-secondary">
                                <% if (ourAuthor.getDeathDate() == null) {
                                    out.println("");
                                } else {
                                    out.println(ourAuthor.getDeathDate());
                                } %>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card mb-3">
                    <div class="card-body">
                        <div class="col-sm-3">
                            <h6 class="mb-0">Biography</h6>
                        </div>
                        <div class="col-sm-9 text-secondary">
                            <%=ourAuthor.getBiography()%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>