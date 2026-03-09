<%-- 
    Document   : calculator
    Created on : 5 мар. 2026 г., 20:14:22
    Author     : dex
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="calculatorjsp.Calculator "%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Калькулятор</h1>
        <h2>Square of 3 = <%= new Calculator().square(3) %></h2>
    </body>
</html>

