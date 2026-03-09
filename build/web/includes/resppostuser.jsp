<%-- 
    Document   : postuser
    Created on : 5 мар. 2026 г., 20:47:57
    Author     : dex
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>User Info</title>
    </head>
    <body>
        <p>Name: <%= request.getParameter("username")%></p>
        <p>Country: <%= request.getParameter("country")%></p>
        <p>Gender: <%= request.getParameter("gender")%></p>
        <h4>Selected courses</h4>
        <ul>
            <%
                String[] courses = request.getParameterValues("courses");
                for (String course : courses) {
                    out.println("<li>" + course + "</li>");
                }
            %>
        </ul>
    </body>
</html>
