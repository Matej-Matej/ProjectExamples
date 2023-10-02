<%@ page import="sk.matejcik.SemestralnaPraca.User.UserController" %>
<%@ page import="sk.matejcik.SemestralnaPraca.BookCategory.BookCategoryController" %>
<%@ page import="sk.matejcik.SemestralnaPraca.Book.BookController" %>
<%@ page import="java.util.List" %>
<%@ page import="sk.matejcik.SemestralnaPraca.Book.Book" %>
<%@ page import="sk.matejcik.SemestralnaPraca.BookState.BookStateEnum" %><%--
  Created by IntelliJ IDEA.
  User: Matej
  Date: 29.4.2021
  Time: 11:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="header.jsp" %>
</head>
<body>
<% request.getSession().setAttribute("navbarType", "users");%>
<%@include file="navbar.jsp" %>

<%
    UserController userController = new UserController();

    int userId = -1;
    try {
        userId = Integer.parseInt(request.getParameter("id"));
    } catch (NumberFormatException e) {
        e.printStackTrace();
    }
    if (userId == -1) {
        response.sendRedirect("usersBrowse.jsp");
    }

    User ourUser = userController.getUserById(userId);

    if (ourUser == null) {
        response.sendRedirect("usersBrowse.jsp");
    }

%>

<div class="container" style="margin-top: 100px;">
    <div class="main-body">
        <div class="row gutters-sm">
            <div class="col-md-4 mb-3">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex flex-column align-items-center text-center">
                            <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="Admin"
                                 class="rounded-circle" width="150">
                            <div class="mt-3">
                                <h4><%=ourUser.getName()%> <%=ourUser.getLastname()%>
                                </h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%
                BookController bookController = new BookController();
                List<Book> planToReadBooks = bookController.getAllUserBooksWithState(ourUser.getUser_id(), BookStateEnum.PLAN_TO_READ.toString());
                List<Book> readingBooks = bookController.getAllUserBooksWithState(ourUser.getUser_id(), BookStateEnum.READING.toString());
                List<Book> completedBooks = bookController.getAllUserBooksWithState(ourUser.getUser_id(), BookStateEnum.COMPLETED.toString());
            %>


            <div class="col-md-8">
                <div class="card mb-3">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-sm-3">
                                <h6 class="mb-0">Plan to read</h6>
                            </div>
                            <ul class="list-group list-group-flush">
                                <% for (Book b : planToReadBooks) { %>
                                <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                                    <a href="bookProfile.jsp?id=<%=b.getBook_id()%>"><span
                                            class="text-secondary"><%=b.getName()%></span></a>
                                </li>
                                <%}%>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="card mb-3">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-sm-3">
                                <h6 class="mb-0">Reading</h6>
                            </div>
                            <ul class="list-group list-group-flush">
                                <% for (Book b : readingBooks) { %>
                                <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                                    <a href="bookProfile.jsp?id=<%=b.getBook_id()%>"><span
                                            class="text-secondary"><%=b.getName()%></span></a>
                                </li>
                                <%}%>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="card mb-3">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-sm-3">
                                <h6 class="mb-0">Completed</h6>
                            </div>
                            <ul class="list-group list-group-flush">
                                <% for (Book b : completedBooks) { %>
                                <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                                    <a href="bookProfile.jsp?id=<%=b.getBook_id()%>"><span
                                            class="text-secondary"><%=b.getName()%></span></a>
                                </li>
                                <%}%>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
</div>
</body>
</html>