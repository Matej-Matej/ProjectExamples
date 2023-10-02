<%@ page import="sk.matejcik.SemestralnaPraca.User.User" %>
<%@ page import="sk.matejcik.SemestralnaPraca.User.UserRoleEnum" %>
<%@ page import="sk.matejcik.SemestralnaPraca.User.UserChecker" %>
<%@ page import="sk.matejcik.SemestralnaPraca.AuthorChange.AuthorChange" %>
<%@ page import="sk.matejcik.SemestralnaPraca.AuthorChange.AuthorChangeController" %>
<%@ page import="sk.matejcik.SemestralnaPraca.BookChange.BookChangeController" %>
<div>
    <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
        <a class="navbar-brand" href="booksBrowse.jsp"><img src="res/logo.png" alt="Admin" class="rounded-circle"
                                                            width="33"></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>


        <div class="collapse navbar-collapse " id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <% if (request.getSession().getAttribute("navbarType") != null) {
                    if (request.getSession().getAttribute("navbarType").equals("books")) { %>
                <li class="nav-item active"><% } else {%>
                <li class="nav-item">
                        <% } } else { %>
                <li class="nav-item"><% } %>
                    <a class="nav-link" href="booksBrowse.jsp">Books <span class="sr-only">(current)</span></a>
                </li>
                <% if (request.getSession().getAttribute("navbarType") != null) {
                    if (request.getSession().getAttribute("navbarType").equals("authors")) { %>
                <li class="nav-item active"><% }  else {%>
                <li class="nav-item">
                        <% } } else { %>
                <li class="nav-item"><% } %>
                    <a class="nav-link" href="authorsBrowse.jsp">Authors</a>
                </li>
                <% if (request.getSession().getAttribute("navbarType") != null) {
                    if (request.getSession().getAttribute("navbarType").equals("categories")) { %>
                <li class="nav-item active"><% }  else {%>
                <li class="nav-item">
                        <% } } else { %>
                <li class="nav-item"><% } %>
                    <a class="nav-link" href="categoryBrowse.jsp">Categories</a>
                </li>
                <% if (request.getSession().getAttribute("navbarType") != null) {
                    if (request.getSession().getAttribute("navbarType").equals("users")) { %>
                <li class="nav-item active"><% }  else {%>
                <li class="nav-item">
                        <% } } else { %>
                <li class="nav-item"><% } %>
                    <a class="nav-link" href="usersBrowse.jsp">Users</a>
                </li>
            </ul>
            <ul class="navbar-nav border border-success rounded  my-2 my-lg-0">
                <%
                    User user = UserChecker.getLoggedUser(request);
                    if (user == null) {
                %>

                <li class="nav-item">
                    <a class="nav-link" href="logreg.jsp">Login - Register</a>
                </li>

                <% } else {%>

                <li class="nav-item">
                    <a class="nav-link" href="userProfile.jsp?id=<%=user.getUser_id()%>"><i
                            class="fas fa-user-circle"></i> Profile</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                       data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="fas fa-plus-circle"></i> Add
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="add.jsp?type=book">Book</a>
                        <a class="dropdown-item" href="add.jsp?type=author">Author</a>
                        <% if (user.getRole().equals(UserRoleEnum.ADMIN.toString())) { %>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="add.jsp?type=category">Category</a>
                        <% } %>

                    </div>
                </li>
                <%
                    int size = 0;
                    size += new AuthorChangeController().getAllAuthorChange().size();
                    size += new BookChangeController().getAllBookChange().size();

                    if (user.getRole().equals(UserRoleEnum.ADMIN.toString())) { %>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown1" role="button"
                       data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="fas fa-trash-alt"></i> Delete
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="deleteRecord.jsp?type=book">Book</a>
                        <a class="dropdown-item" href="deleteRecord.jsp?type=author">Author</a>
                        <a class="dropdown-item" href="deleteRecord.jsp?type=category">Category</a>

                    </div>
                </li>
                <% if (size > 0) { %>
                <li class="nav-item">
                    <a class="nav-link" href="notification.jsp"><i class="fas fa-bell"></i> Notifications (<%=size%>)</a>
                </li>
                <%} } %>

                <li class="nav-item">
                    <a class="nav-link" href="logout-user-servlet" type="submit"> <i class="fas fa-sign-out-alt"></i>
                        Log out</a>
                </li>

                <% } %>

            </ul>
        </div>
    </nav>
</div>