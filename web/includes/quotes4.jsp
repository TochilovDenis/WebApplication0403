<%@page import="java.util.Map, java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String header = "Цитаты";
    Map<String, String[]> quotes = new HashMap<String, String[]>();

    String[] quote1 = new String[]{"Цитата образование 1", "Цитата образование 2", "Цитата образование  3"};
    String[] quote2 = new String[]{"Цитата развитие 1", "Цитата развитие 2", "Цитата развитие 3"};
    String[] quote3 = new String[]{"Цитата отношение 1", "Цитата отношение 2", "Цитата отношение 3"};
    String[] quote4 = new String[]{"Цитата история 1", "Цитата история 2", "Цитата история 3"};

    quotes.put("Про образование", quote1);
    quotes.put("Про личное развитие", quote2);
    quotes.put("Про отношения", quote3);
    quotes.put("Про история", quote4);
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Про Цитаты</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                max-width: 800px;
                margin: 20px auto;
                padding: 0 20px;
            }
            .menu {
                margin-bottom: 30px;
                padding: 15px;
                background-color: #f8f9fa;
                border-radius: 8px;
                text-align: center;
            }
            .menu a {
                display: inline-block;
                margin: 5px 10px;
                padding: 8px 16px;
                background-color: #007bff;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                transition: background-color 0.3s;
            }
            .menu a:hover {
                background-color: #0056b3;
            }
            .menu a.active {
                background-color: #28a745;
            }
            .quotes-container {
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            ul {
                list-style-type: none;
                padding: 0;
            }
            li {
                padding: 10px;
                margin: 5px 0;
                background-color: #f8f9fa;
                border-left: 4px solid #007bff;
                border-radius: 0 4px 4px 0;
            }
        </style>
    </head>
    <body>
        <div class="menu">
            <h3>Выберите тему:</h3>
            <a href="?about=Про образование" <%= request.getParameter("about") != null && request.getParameter("about").equals("Про образование") ? "class='active'" : "" %>>Образование</a>
            <a href="?about=Про личное развитие" <%= request.getParameter("about") != null && request.getParameter("about").equals("Про личное развитие") ? "class='active'" : "" %>>Личное развитие</a>
            <a href="?about=Про отношения" <%= request.getParameter("about") != null && request.getParameter("about").equals("Про отношения") ? "class='active'" : "" %>>Отношения</a>
            <a href="?about=Про история" <%= request.getParameter("about") != null && request.getParameter("about").equals("Про история") ? "class='active'" : "" %>>История</a>
        </div>

        <div class="quotes-container">
            <h3><%= header%></h3>
            
            <%
                String about = request.getParameter("about");
                
                if (about != null && !about.isEmpty()) {
                    String[] quotes_ = quotes.get(about);
                    out.println("<h2>" + about + ":" + "</h2>");
                    
                    if (quotes_ != null) {
                        out.println("<ul>");
                        for (String var_ : quotes_) {
                            out.println("<li>" + var_ + "</li>");
                        }
                        out.println("</ul>");
                    } else {
                        out.println("<p>Цитаты не найдены</p>");
                    }
                } else {
                    out.println("<p>Выберите тему из меню выше</p>");
                }
            %>
        </div>
    </body>
</html>

<!--Задание 4
Добавьте к третьему заданию возможность выбора цитаты. 
Например:
    * Образование
    * Личное развитие;
    * Отношения;
    * История-->

