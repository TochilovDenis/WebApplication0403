<%@ page import="java.util.Date, java.util.Locale, java.text.SimpleDateFormat" pageEncoding="UTF-8" %>


<p>Today <%= new Date()%> </p>

<%
    Locale ru = new Locale("ru", "RU");
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy, HH:mm", ru);
    Date now = new Date();
%>
<p>Сегодня <%= sdf.format(now)%>


<nav><a href="#">Home</a> | <a href="#">Contact</a> | <a href="#">About</a></nav>
<h2>Hello JSP header</h2>
