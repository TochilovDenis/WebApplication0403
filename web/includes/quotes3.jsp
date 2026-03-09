<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String header = "Цитаты";
    String[] quote = new String[]{"Цитата 1", "Цитата 2", "Цитата 3"};

%>

<h3><%= header%></h3>
<p><% out.print(quote[(int) (Math.random() * quote.length)]);%></p>




<!-- Задание 3
Создайте веб-приложение, отображающее произвольную цитату. 
Каждый раз, когда пользователь обновляет страницу, на экране появляктся новая цитата -->


