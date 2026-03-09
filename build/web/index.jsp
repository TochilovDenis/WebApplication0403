<%-- 
    Document   : index
    Created on : 5 мар. 2026 г., 19:49:39
    Author     : dex
--%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date, java.util.Locale" pageEncoding="UTF-8"  %>

<%
    String header = "Apache Tomcat";
%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="includes/header.jsp" />

        <%--<jsp:include page="includes/calculator.jsp" />--%>

        <jsp:include page="includes/postuser.jsp" />  

        <jsp:include page="includes/timer.jsp" />

        <jsp:include page="includes/quotes3.jsp" />

        <a href="includes/quotes4.jsp" target="_blank"
           style="border: 1px solid #333;
           padding: 5px 15px;
           color: #333;
           text-decoration: none;">
            Открыть цитаты 4 в новом окне
        </a>
        <br>
        <br>        
        <a href="includes/quotes5.jsp" target="_blank"
           style="border: 1px solid #333;
           padding: 5px 15px;
           color: #333;
           text-decoration: none;">
            Открыть цитаты 5 в новом окне
        </a>
        <br>
        <br>        
        <a href="includes/quotes6.jsp" target="_blank"
           style="border: 1px solid #333;
           padding: 5px 15px;
           color: #333;
           text-decoration: none;">
            Открыть цитаты 6 в новом окне
        </a>


        <jsp:include page="includes/footer.jsp" />
    </body>
</html>
