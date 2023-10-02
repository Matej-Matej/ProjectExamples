<%@ page import="sk.matejcik.SemestralnaPraca.Book.Book" %>
<%@ page import="sk.matejcik.SemestralnaPraca.Book.BookController" %>
<%@ page import="sk.matejcik.SemestralnaPraca.Category.Category" %>
<%@ page import="sk.matejcik.SemestralnaPraca.Category.CategoryController" %>
<%@ page import="java.util.List" %>
<%@ page import="sk.matejcik.SemestralnaPraca.BookCategory.BookCategoryController" %>
<%@ page import="sk.matejcik.SemestralnaPraca.BookAuthor.BookAuthorController" %>
<%@ page import="sk.matejcik.SemestralnaPraca.Author.Author" %>
<%@ page import="sk.matejcik.SemestralnaPraca.BookState.BookStateEnum" %>
<%@ page import="sk.matejcik.SemestralnaPraca.BookState.BookStateController" %>
<%@ page import="sk.matejcik.SemestralnaPraca.BookState.BookState" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="header.jsp" %>
</head>
<body>
<% request.getSession().setAttribute("navbarType","books");%>
<%@include file="navbar.jsp" %>

<%
    BookController bookController = new BookController();
    BookCategoryController bookCategoryController = new BookCategoryController();
    BookAuthorController bookAuthorController = new BookAuthorController();

    int bookId = -1;
    try {
        bookId = Integer.parseInt(request.getParameter("id"));
    } catch (NumberFormatException e) {
        e.printStackTrace();
    }
    if (bookId == -1) {
        response.sendRedirect("booksBrowse.jsp");
    }


    Book ourBook = bookController.getBookById(bookId);

    if (ourBook == null) {
        response.sendRedirect("booksBrowse.jsp");
    }

    List<Category> categoryList = bookCategoryController.getCategoriesOfBook(bookId);
    List<Author> authorList = bookAuthorController.getAuthorsOfBook(bookId);

%>

<div class="container" style="margin-top: 100px;">
    <div class="main-body">
        <div class="row gutters-sm">
            <div class="col-md-4 mb-3">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex flex-column align-items-center text-center">
                            <% if (ourBook.getPicture() == null || ourBook.getPicture().equals("")) {%>
                                 <img src="https://webstockreview.net/images/books-clipart-cute-4.png" alt="Admin"
                                     class="rounded-circle" width="150">
                            <% } else { %>
                                 <img src="<%=ourBook.getPicture()%>" alt="Admin"
                                       class="rounded-circle" width="150">
                            <% } %>

                            <div class="mt-3">
                                <h4><%=ourBook.getName()%>
                                </h4>
                                <% if (UserChecker.isUserLogged(request)) { %>

                                <%
                                    int userId = UserChecker.getLoggedUser(request).getUser_id();

                                    BookStateController bookStateController = new BookStateController();
                                    BookState bookState = bookStateController.getBookStateById(userId,bookId);
                                %>

                                <form method="post" action="add-book-state-servlet" id="resultform">
                                    <select class="form-select" style="padding: 10px" name="bookStatus" id="bookStatus">
                                        <%
                                            if (bookState != null) {
                                                if (BookStateEnum.PLAN_TO_READ.toString().equals(bookState.getState())) { %>
                                                    <option value="">Select book status</option>
                                                    <option selected value="<%=BookStateEnum.PLAN_TO_READ.toString()%>">Plan to read</option>
                                                    <option value="<%=BookStateEnum.READING.toString()%>">Reading</option>
                                                    <option value="<%=BookStateEnum.COMPLETED.toString()%>">Completed</option>
                                                <% } else if (BookStateEnum.READING.toString().equals(bookState.getState())) { %>
                                                    <option value="">Select book status</option>
                                                    <option value="<%=BookStateEnum.PLAN_TO_READ.toString()%>">Plan to read</option>
                                                    <option selected value="<%=BookStateEnum.READING.toString()%>">Reading</option>
                                                    <option value="<%=BookStateEnum.COMPLETED.toString()%>">Completed</option>
                                                <% } else if (BookStateEnum.COMPLETED.toString().equals(bookState.getState())) { %>
                                                    <option value="">Select book status</option>
                                                    <option value="<%=BookStateEnum.PLAN_TO_READ.toString()%>">Plan to read</option>
                                                    <option value="<%=BookStateEnum.READING.toString()%>">Reading</option>
                                                    <option selected value="<%=BookStateEnum.COMPLETED.toString()%>">Completed</option>
                                                <% } %>
                                        <% } else { %>
                                                <option selected value="">Select book status</option>
                                                <option value="<%=BookStateEnum.PLAN_TO_READ.toString()%>">Plan to read</option>
                                                <option value="<%=BookStateEnum.READING.toString()%>">Reading</option>
                                                <option value="<%=BookStateEnum.COMPLETED.toString()%>">Completed</option>
                                        <% } %>

                                    </select>
                                    <input hidden value="<%=bookId%>" name="bookId" id="bookId">
                                    <input hidden value="<%=userId%>" name="userId" id="userId">
                                </form>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card mt-2">
                    <% if (UserChecker.isUserLogged(request)) { %>
                    <!--
                    <div class="card-head">
                        <button class="close float-right" style="padding: 10px; font-size: 10px;">Edit authors</button>
                    </div>
                    -->
                    <% } %>
                    <div class="col">
                        <h6 class="mb-0" style="padding: 5px;">Authors</h6>
                    </div>
                    <ul class="list-group list-group-flush">
                        <% for (Author a : authorList) { %>
                        <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                            <a href="authorProfile.jsp?id=<%=a.getAuthor_id()%>"><span
                                    class="text-secondary"><%=a.getName()%>  <%=a.getLastname()%></span></a>
                        </li>
                        <%}%>
                    </ul>
                </div>
                <div class="card mt-2">
                    <% if (UserChecker.isUserLogged(request)) { %>
                    <!--
                        <div class="card-head">
                            <button class="close float-right" style="padding: 10px; font-size: 10px;">Edit categories</button>
                        </div>
                        -->
                    <% } %>
                    <div class="col">
                        <h6 class="mb-0" style="padding: 5px;">Categories</h6>
                    </div>
                    <ul class="list-group list-group-flush">
                        <% for (Category c : categoryList) { %>
                        <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                            <a href="booksBrowse.jsp?category=<%=c.getCategory_id()%>"><span
                                    class="text-secondary"><%=c.getName()%></span></a>
                        </li>
                        <%}%>
                    </ul>
                </div>
            </div>
            <div class="col-md-8">
                <div class="card mb-3">
                    <% if (UserChecker.isUserLogged(request)) { %>
                    <div class="card-head">
                        <a href="add.jsp?type=book&idBook=<%=ourBook.getBook_id()%>" class="close float-right" style="padding: 10px; font-size: 15px;">Edit book</a>
                    </div>
                    <% } %>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-sm-3">
                                <h6 class="mb-0">Page count</h6>
                            </div>
                            <div class="col-sm-9 text-secondary">
                                <%=ourBook.getPage_count()%>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-3">
                                <h6 class="mb-0">Year</h6>
                            </div>
                            <div class="col-sm-9 text-secondary">
                                <%=ourBook.getYear()%>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-3">
                                <h6 class="mb-0">Publisher</h6>
                            </div>
                            <div class="col-sm-9 text-secondary">
                                <%=ourBook.getPublisher()%>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-3">
                                <h6 class="mb-0">ISBN</h6>
                            </div>
                            <div class="col-sm-9 text-secondary">
                                <%=ourBook.getIsbn()%>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-3">
                                <h6 class="mb-0">Content</h6>
                            </div>
                            <div class="col-sm-9 text-secondary">
                                <%=ourBook.getContent()%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $("select").change(function() {
        $('#resultform').submit();
    })
</script>

</body>
</html>
