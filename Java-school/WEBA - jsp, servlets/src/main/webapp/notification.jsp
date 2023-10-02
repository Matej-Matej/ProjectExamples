<%@ page import="sk.matejcik.SemestralnaPraca.AuthorChange.AuthorChangeController" %>
<%@ page import="java.util.List" %>
<%@ page import="sk.matejcik.SemestralnaPraca.AuthorChange.AuthorChange" %>
<%@ page import="sk.matejcik.SemestralnaPraca.BookChange.BookChangeController" %>
<%@ page import="sk.matejcik.SemestralnaPraca.BookChange.BookChange" %>
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
%>
<div class="container" style="margin-top: 100px;">
    <div class="main-body">
        <div class="row gutters-sm">
            <div class="col-md-12 mb-12">
                <div class="card-body">
                    <table class="table table-striped table-dark">
                        <thead>
                        <tr>
                            <th scope="col">Id</th>
                            <th scope="col">Name</th>
                            <th scope="col">Last name</th>
                            <th scope="col">Birth date</th>
                            <th scope="col">Death date</th>
                            <th scope="col">Biography</th>
                            <th scope="col">Birth place</th>
                        </tr>
                        </thead>
                        <tbody>
                            <%
                                AuthorChangeController authorChangeController = new AuthorChangeController();
                                List<AuthorChange> authorChangeList = authorChangeController.getAllAuthorChange();
                                for (AuthorChange ac : authorChangeList) { %>
                            <tr>
                                <td><%=ac.getAuthor().getAuthor_id()%></td>
                                <td><%=ac.getAuthor().getName()%></td>
                                <td><%=ac.getAuthor().getLastname()%></td>
                                <td><%=ac.getAuthor().getBirthDate()%></td>
                                <td><%=ac.getAuthor().getDeathDate()%></td>
                                <td><%=ac.getAuthor().getBiography()%></td>
                                <td><%=ac.getAuthor().getBirthPlace()%></td>
                                <td><a href="confirm-author-change-servlet?id=<%=ac.getAuthor_change_id()%>"><i class="fas fa-check-circle" style="color: var(--green);"></i></a></td>
                                <td><a href="delete-author-change-servlet?id=<%=ac.getAuthor_change_id()%>"><i class="fas fa-times-circle" style="color: var(--red);"></i></a></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="row gutters-sm">
            <div class="col-md-12 mb-12">
                <div class="card-body">
                    <table class="table table-striped table-dark">
                        <thead>
                        <tr>
                            <th scope="col">Id</th>
                            <th scope="col">Name</th>
                            <th scope="col">Content</th>
                            <th scope="col">Page count</th>
                            <th scope="col">Year</th>
                            <th scope="col">Publisher</th>
                            <th scope="col">Isbn</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            BookChangeController bookChangeController = new BookChangeController();
                            List<BookChange> bookChangeList = bookChangeController.getAllBookChange();
                            for (BookChange bc : bookChangeList) { %>
                        <tr>
                            <td><%=bc.getBook().getBook_id()%></td>
                            <td><%=bc.getBook().getName()%></td>
                            <td><%=bc.getBook().getContent()%></td>
                            <td><%=bc.getBook().getPage_count()%></td>
                            <td><%=bc.getBook().getYear()%></td>
                            <td><%=bc.getBook().getPublisher()%></td>
                            <td><%=bc.getBook().getIsbn()%></td>
                            <td><a href="confirm-book-change-servlet?id=<%=bc.getBook_change_id()%>"><i class="fas fa-check-circle" style="color: var(--green);"></i></a></td>
                            <td><a href="delete-book-change-servlet?id=<%=bc.getBook_change_id()%>"><i class="fas fa-times-circle" style="color: var(--red);"></i></a></td>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
