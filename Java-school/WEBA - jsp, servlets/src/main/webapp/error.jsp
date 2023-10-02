<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="header.jsp" %>
</head>
<body>
<%@include file="navbar.jsp" %>

<%
    String errorMes = "";
    if (session.getAttribute("error") != null) {
        errorMes = String.valueOf(session.getAttribute("error"));
    };
%>
<div class="container" >
    <div class="row">
        <div class="offset-lg-2 col-lg-8 col-sm-8 col-8 border border-danger rounded main-section" style="background-color: var(--dark); margin-top: 20px;">
            <h3 class="text-center text-inverse error-title" >ERROR :(</h3>
            <hr>
                <div class="row">
                    <div class="col-lg-12 col-sm-12 col-12">
                        <p style="color: var(--red); font-size: 30px;"><%=errorMes%></p>
                    </div>
                </div>
        </div>
    </div>
</div>
</body>
</html>
