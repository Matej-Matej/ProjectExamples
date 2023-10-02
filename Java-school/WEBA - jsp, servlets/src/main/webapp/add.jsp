<%@ page import="sk.matejcik.SemestralnaPraca.Category.CategoryController" %>
<%@ page import="java.util.List" %>
<%@ page import="sk.matejcik.SemestralnaPraca.Category.Category" %>
<%@ page import="sk.matejcik.SemestralnaPraca.Book.Book" %>
<%@ page import="sk.matejcik.SemestralnaPraca.Book.BookController" %>
<%@ page import="sk.matejcik.SemestralnaPraca.Author.Author" %>
<%@ page import="sk.matejcik.SemestralnaPraca.Author.AuthorController" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="header.jsp" %>
</head>
<body>
<%@include file="navbar.jsp" %>
<%

    String redirect = "";
    if (!UserChecker.isUserLogged(request)) {
        redirect = "booksBrowse.jsp";
    }

    String type = "book";

    if (request.getParameter("type") != null) {
        type = request.getParameter("type");
    }

    int authorId = -1;
    int bookId = -1;
    Book ourBook = null;
    Author ourAuthor = null;
    if (request.getParameter("idBook") != null) {
        bookId = Integer.parseInt(request.getParameter("idBook"));
        ourBook = new BookController().getBookById(bookId);
        if (ourBook == null) {
            redirect = "booksBrowse.jsp";
        }
    }

    if (request.getParameter("idAuthor") != null) {
        authorId = Integer.parseInt(request.getParameter("idAuthor"));
        ourAuthor = new AuthorController().getAuthorById(authorId);
        if (ourAuthor == null) {
            redirect = "authorsBrowse.jsp";
        }
    }
%>
<% if (type.equals("author")) { %>
<div class="container">
    <div class="row">
        <div class="offset-lg-2 col-lg-8 col-sm-8 col-8 border border-success rounded main-section"
             style="background-color: var(--dark); margin-top: 20px;">
            <h3 class="text-center text-inverse add-title">Add author</h3>
            <hr>
            <% if (ourAuthor != null) { %>
            <form autocomplete="off" class="container" id="authorForm" method="post" action="edit-author-servlet"
                  enctype="multipart/form-data">
                <input hidden value="<%=ourAuthor.getAuthor_id()%>" id="authorId" name="authorId">
                    <% } else { %>
                <form autocomplete="off" class="container" id="authorForm" method="post" action="add-author-servlet"
                      enctype="multipart/form-data">
                    <% } %>
                    <div class="row">
                        <div class="col-lg-6 col-sm-6 col-6">
                            <div class="form-group">
                                <label class="text-inverse add-text" for="authorName"><i
                                        class="fas fa-user add-author-icon"></i>Author name</label>
                                <input type="text" class="form-control" id="authorName" name="authorName"
                                       placeholder="Enter author name"
                                       value="<%if (ourAuthor!=null) out.println(ourAuthor.getName()); %>">
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-6 col-6">
                            <div class="form-group">
                                <label class="text-inverse add-text" for="authorLastName"><i
                                        class="fas fa-user add-author-icon"></i>Author last name</label>
                                <input type="text" class="form-control" id="authorLastName" name="authorLastName"
                                       placeholder="Enter author last name"
                                       value="<%if (ourAuthor!=null) out.println(ourAuthor.getLastname()); %>">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-6 col-sm-6 col-6">
                            <div class="form-group">
                                <%
                                    String birthDate = "";
                                    if (ourAuthor != null) {
                                        birthDate = new SimpleDateFormat("yyyy-MM-dd").format(ourAuthor.getBirthDate());
                                    }
                                %>
                                <label class="text-inverse add-text" for="authorBirthDate"><i
                                        class="fas fa-birthday-cake add-author-icon"></i>Author birth date</label>
                                <input type="date" class="form-control input-sm add-date" placeholder="Date"
                                       id="authorBirthDate" name="authorBirthDate" value="<%=birthDate%>">
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-6 col-6">
                            <div class="form-group">

                                <%
                                    String deathDate = "";
                                    if (ourAuthor != null && ourAuthor.getDeathDate() != null) {
                                        deathDate = new SimpleDateFormat("yyyy-MM-dd").format(ourAuthor.getDeathDate());
                                    }
                                %>
                                <label class="text-inverse add-text" for="authorDeathDate"><i
                                        class="fas fa-skull-crossbones add-author-icon"></i>Author death date</label>
                                <input type="date" class="form-control input-sm add-date" placeholder="Date"
                                       id="authorDeathDate" name="authorDeathDate" value="<%=deathDate%>"/>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-6 col-sm-6 col-6">
                            <div class="form-group">
                                <label class="text-inverse add-text" for="authorBirthPlace"><i
                                        class="fas fa-map-marker add-author-icon"></i>Author birth place</label>
                                <input type="text" class="form-control input-sm add-date"
                                       placeholder="Author birth place"
                                       id="authorBirthPlace" name="authorBirthPlace"
                                       value="<%if (ourAuthor!=null) out.println(ourAuthor.getBirthPlace()); %>"/>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12 col-sm-12 col-12">
                            <div class="form-group">
                                <label class="text-inverse add-text" for="authorBiography"><i
                                        class="fas fa-scroll add-author-icon"></i>Author biography</label>
                                <textarea class="form-control" id="authorBiography" placeholder="Biography" rows="3"
                                          name="authorBiography"><%
                                    if (ourAuthor != null) out.println(ourAuthor.getBiography()); %></textarea>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12 col-sm-12 col-12">
                            <div class="form-group">
                                <label class="text-inverse add-text" for="pictureAuthor"><i
                                        class="fas fa-image add-author-icon"></i>Author image</label>
                                <input class="add-date" type="file" id="pictureAuthor"
                                       name="pictureAuthor" style="color: white;"
                                       value="<%if (ourAuthor!=null) out.println(ourAuthor.getPicture()); %>"/>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <%
                            String buttonText = "Add author";
                            if (ourAuthor != null) {
                                buttonText = "Send edit request to admin";
                            } %>
                        <div class="col-lg-12 col-sm-12 col-12 text-center">
                            <button class="btn btn-success" type="submit"><%=buttonText%>
                            </button>
                        </div>

                    </div>

                </form>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {

        $("#authorForm").validate({
            rules: {
                authorName: {
                    required: true,
                    minlength: 2,
                    maxlength: 30
                },
                authorLastName: {
                    required: true,
                    minlength: 3,
                    maxlength: 100
                },
                authorBirthDate: {
                    required: true
                },
                authorBirthPlace: {
                    required: true,
                    minlength: 2,
                    maxlength: 30
                },
                authorBiography: {
                    required: true,
                    minlength: 1
                }
            }
        });
    });
</script>
<% } else if (type.equals("category")) { %>

<%
    if (!UserChecker.isUserLogged(request) || !UserChecker.isUserAdmin(request)) {
        redirect = "categoryBrowse.jsp";
    }
%>
<div class="container">
    <div class="row">
        <div class="offset-lg-2 col-lg-8 col-sm-8 col-8 border border-success rounded main-section"
             style="background-color: var(--dark); margin-top: 20px;">
            <h3 class="text-center text-inverse add-title">Add category</h3>
            <hr>
            <form autocomplete="off" class="container" id="categoryForm" method="post" action="add-category-servlet">
                <div class="row">
                    <div class="col-lg-12 col-sm-12 col-12">
                        <div class="form-group">
                            <label class="text-inverse add-text" for="categoryName">Category name</label>
                            <input type="text" class="form-control" id="categoryName" name="categoryName"
                                   placeholder="Enter category name">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12 col-sm-12 col-12 text-center">
                        <button class="btn btn-success" type="submit">Add category</button>
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $("#categoryForm").validate({
            rules: {
                categoryName: {
                    required: true,
                    minlength: 2,
                    maxlength: 30
                }
            }
        });
    });
</script>
<% } else { %>
<div class="container">
    <div class="row">
        <div class="offset-lg-2 col-lg-8 col-sm-8 col-8 border border-success rounded main-section"
             style="background-color: var(--dark); margin-top: 20px;">
            <h3 class="text-center text-inverse add-title">Add book</h3>
            <hr>
            <% if (ourBook != null) { %>
            <form autocomplete="off" class="container" id="bookForm" method="post" action="edit-book-servlet"
                  enctype="multipart/form-data">
                <input hidden value="<%=ourBook.getBook_id()%>" id="bookId" name="bookId">
                    <% } else { %>
                <form autocomplete="off" id="bookForm" action="add-book-servlet" method="post" enctype="multipart/form-data">
                    <% } %>
                    <div class="row">
                        <div class="col-lg-12 col-sm-12 col-12">
                            <div class="form-group">
                                <label class="text-inverse add-text" for="bookName"><i
                                        class="fas fa-book add-author-icon"></i>Book name</label>
                                <input type="text" class="form-control" id="bookName" name="bookName"
                                       placeholder="Enter book name"
                                       value="<%if (ourBook!=null) out.println(ourBook.getName()); %>">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-6 col-sm-6 col-6">
                            <div class="form-group">
                                <label class="text-inverse add-text" for="bookYear"><i
                                        class="fas fa-map-marker add-author-icon"></i>Book year</label>
                                <% if (ourBook != null) { %>
                                <input type="number" class="form-control input-sm add-date" placeholder="Year"
                                       id="bookYear" name="bookYear"
                                       value="<%=ourBook.getYear()%>">
                                    <% } else { %>
                                <input type="number" class="form-control input-sm add-date" placeholder="Year"
                                       id="bookYear" name="bookYear">
                                <% } %>
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-6 col-6">
                            <div class="form-group">
                                <label class="text-inverse add-text" for="bookPublisher"><i
                                        class="fas fa-user add-author-icon"></i>Book publisher</label>
                                <input type="text" class="form-control input-sm add-date" placeholder="Book publisher"
                                       id="bookPublisher" name="bookPublisher"
                                       value="<%if (ourBook!=null) out.println(ourBook.getPublisher()); %>"/>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-6 col-sm-6 col-6">
                            <div class="form-group">
                                <label class="text-inverse add-text" for="bookPageCount"><i
                                        class="fas fa-file add-author-icon"></i>Page count</label>
                                <% if (ourBook != null) { %>
                                <input type="number" class="form-control input-sm add-date" placeholder="Book pages"
                                       id="bookPageCount" name="bookPageCount" value="<%=ourBook.getPage_count()%>"/>
                                <% } else { %>
                                <input type="number" class="form-control input-sm add-date" placeholder="Book pages"
                                       id="bookPageCount" name="bookPageCount"/>
                                <% } %>
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-6 col-6">
                            <div class="form-group">
                                <label class="text-inverse add-text" for="bookIsbn"><i
                                        class="fas fa-arrow-right add-author-icon"></i>ISBN</label>
                                <input type="text" class="form-control input-sm add-date" placeholder="ISBN"
                                       id="bookIsbn" name="bookIsbn"
                                       value="<%if (ourBook!=null) out.println(ourBook.getIsbn()); %>"/>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12 col-sm-12 col-12">
                            <div class="form-group">
                                <label class="text-inverse add-text" for="bookContent"><i
                                        class="fas fa-scroll add-author-icon"></i>Book content</label>
                                <textarea class="form-control" id="bookContent" placeholder="Content" rows="3"
                                          name="bookContent"><%
                                    if (ourBook != null) out.println(ourBook.getContent()); %></textarea>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12 col-sm-12 col-12">
                            <div class="form-group">
                                <label class="text-inverse add-text" for="pictureBook"><i
                                        class="fas fa-image add-author-icon"></i>Book image</label>
                                <input class="add-date" type="file" id="pictureBook"
                                       name="pictureBook" style="color: white;"/>
                            </div>
                        </div>
                    </div>

                    <!-- Modal -->
                    <div class="modal fade" id="modalCategories" tabindex="-1" role="dialog"
                         aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="modalCategoriesLabel">Add category</h5>
                                    <div class="float-right">
                                        <button type="button" class="btn btn-success" onclick="addCategory()">Add
                                        </button>
                                        <button type="button" class="btn btn-danger" onclick="removeCategory()">Remove
                                        </button>
                                    </div>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group" id="categoryFormGroup">

                                        <script>

                                            var catValue = 0
                                            var maxCategories = 3

                                            function addCategory() {
                                                if (catValue >= maxCategories) {
                                                    catValue = maxCategories
                                                } else {
                                                    catValue += 1
                                                    add()
                                                }

                                            }

                                            function removeCategory() {
                                                remove()
                                            }


                                            function add() {
                                                $.ajax({
                                                    url: 'get-categories-option-servlet',
                                                    type: 'POST',
                                                    success: function (data) {
                                                        let html = ''
                                                        let idName = "selectCategory" + catValue

                                                        html += '<select style="margin-top: 15px;" class="form-control" id="' + idName + '" name="' + idName + '">'
                                                        html += '<option value="-1"></option>'
                                                        data.forEach(categories => {
                                                            html += '<option value="' + categories.category_id + '">' + categories.name + '</option>'
                                                        })

                                                        html += '</select>'

                                                        document.getElementById("categoryFormGroup").insertAdjacentHTML("beforeend", html)

                                                    }
                                                })
                                            }

                                            function remove() {
                                                if (catValue > 0) {
                                                    document.getElementById("selectCategory" + catValue).remove()
                                                    catValue -= 1
                                                }
                                            }

                                        </script>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-success float-left" data-dismiss="modal"
                                            aria-label="Close">Save and close
                                    </button>

                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal fade" id="modalAuthors" tabindex="-1" role="dialog"
                         aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Add author</h5>
                                    <div class="float-right">
                                        <button type="button" class="btn btn-success" onclick="addAuthor()">Add</button>
                                        <button type="button" class="btn btn-danger" onclick="removeAuthor()">Remove
                                        </button>
                                    </div>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group" id="authorFormGroup">

                                        <script>

                                            var autValue = 0
                                            var maxAuthors = 3

                                            function addAuthor() {
                                                if (autValue >= maxAuthors) {
                                                    autValue = maxAuthors
                                                } else {
                                                    autValue += 1
                                                    addAuth()
                                                }
                                            }

                                            function removeAuthor() {
                                                removeAuth()
                                            }

                                            function addAuth() {
                                                $.ajax({
                                                    url: 'get-authors-option-servlet',
                                                    type: 'POST',
                                                    success: function (data) {
                                                        let html = ''
                                                        let idName = "selectAuthor" + autValue

                                                        html += '<select style="margin-top: 15px;" class="form-control" id="' + idName + '" name="' + idName + '">'
                                                        html += '<option value="-1"></option>'
                                                        data.forEach(authors => {
                                                            console.log(authors)
                                                            html += '<option value="' + authors.author_id + '">' + authors.name + " " + authors.lastname + '</option>'
                                                        })

                                                        html += '</select>'

                                                        document.getElementById("authorFormGroup").insertAdjacentHTML("beforeend", html)

                                                    }
                                                })
                                            }

                                            function removeAuth() {
                                                if (autValue > 0) {
                                                    document.getElementById("selectAuthor" + autValue).remove()
                                                    autValue -= 1
                                                }
                                            }

                                        </script>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-success float-left" data-dismiss="modal"
                                            aria-label="Close">Save and close
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <% if (ourBook == null) { %>
                        <div class="col-lg-6 col-sm-6 col-6 text-center">
                            <button class="btn btn-success" type="submit">Add book</button>
                        </div>
                        <div class="col-lg-3 col-sm-3 col-3 text-center">
                            <button type="button" class="btn btn-success" data-toggle="modal"
                                    data-target="#modalCategories">Add category
                            </button>
                        </div>
                        <div class="col-lg-3 col-sm-3 col-3 text-center">
                            <button type="button" class="btn btn-success" data-toggle="modal"
                                    data-target="#modalAuthors">
                                Add author
                            </button>
                        </div>
                        <% } else { %>
                        <div class="col-lg-12 col-sm-12 col-12 text-center">
                            <button class="btn btn-success" type="submit">Send edit request to admin</button>
                        </div>
                        <% } %>
                    </div>
                </form>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $("#bookForm").validate({
            rules: {
                bookName: {
                    required: true,
                    minlength: 2,
                    maxlength: 30
                },
                bookYear: {
                    required: true,
                    number: true,
                    max: 2100
                },
                bookPublisher: {
                    required: true,
                    minlength: 2,
                    maxlength: 50
                },
                bookPageCount: {
                    required: true,
                    min: 1
                },
                bookIsbn: {
                    required: true,
                    minlength: 2,
                    maxlength: 30
                },
                bookContent: {
                    required: true,
                    minlength: 1
                }
            }
        });
    });
</script>
<% }
    if (!redirect.equals("")) {
        response.sendRedirect(redirect);
    }
%>

</body>
</html>