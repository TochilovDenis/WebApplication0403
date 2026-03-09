<%@page import="java.util.Map, java.util.HashMap, java.util.ArrayList, java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");
    
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
    
    // Получаем параметры
    String about = request.getParameter("about");
    String searchWord = request.getParameter("searchWord");
    
    
    // Параметры для новой цитаты
    String newQuote = request.getParameter("newQuote");
    String newAuthor = request.getParameter("newAuthor");
    String newCategory = request.getParameter("newCategory");
    String addQuote = request.getParameter("addQuote");
    
    // Добавление новой цитаты
    if (addQuote != null && newQuote != null && !newQuote.trim().isEmpty() && 
        newAuthor != null && !newAuthor.trim().isEmpty() && 
        newCategory != null && !newCategory.trim().isEmpty()) {
        
        String category = newCategory.trim();
        String quoteText = newQuote.trim() + " (автор: " + newAuthor.trim() + ")";
        
        // Получаем существующие цитаты категории или создаем новый массив
        String[] existingQuotes = quotes.get(category);
        String[] updatedQuotes;
        
        if (existingQuotes != null) {
            // Создаем новый массив на один элемент больше
            updatedQuotes = new String[existingQuotes.length + 1];
            // Копируем существующие цитаты
            System.arraycopy(existingQuotes, 0, updatedQuotes, 0, existingQuotes.length);
            // Добавляем новую цитату в конец
            updatedQuotes[existingQuotes.length] = quoteText;
        } else {
            // Создаем новый массив с одной цитатой
            updatedQuotes = new String[]{quoteText};
        }
        
        // Обновляем map
        quotes.put(category, updatedQuotes);
        
        // Сообщение об успехе
        session.setAttribute("message", "Цитата успешно добавлена в категорию \"" + category + "\"!");
    }
    
    // Получаем сообщение из сессии и удаляем его (чтобы не показывалось постоянно)
    String message = (String) session.getAttribute("message");
    if (message != null) {
        session.removeAttribute("message");
    }
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
            .search-form {
                margin-bottom: 20px;
                padding: 15px;
                background-color: #e9ecef;
                border-radius: 8px;
                text-align: center;
            }
            .search-form input[type="text"] {
                padding: 8px;
                width: 250px;
                border: 1px solid #ced4da;
                border-radius: 4px;
                margin-right: 10px;
            }
            .search-form input[type="submit"] {
                padding: 8px 20px;
                background-color: #28a745;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            .search-form input[type="submit"]:hover {
                background-color: #218838;
            }
            .add-quote-form {
                margin-bottom: 20px;
                padding: 20px;
                background-color: #d4edda;
                border: 1px solid #c3e6cb;
                border-radius: 8px;
            }
            .add-quote-form h3 {
                color: #155724;
                margin-top: 0;
            }
            .form-group {
                margin-bottom: 15px;
                text-align: left;
            }
            .form-group label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
                color: #155724;
            }
            .form-group input[type="text"],
            .form-group select,
            .form-group textarea {
                width: 100%;
                padding: 8px;
                border: 1px solid #ced4da;
                border-radius: 4px;
                box-sizing: border-box;
            }
            .form-group textarea {
                height: 80px;
                resize: vertical;
            }
            .form-group select {
                height: 38px;
                background-color: white;
            }
            .btn-success {
                background-color: #28a745;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
            }
            .btn-success:hover {
                background-color: #218838;
            }
            .success-message {
                background-color: #d4edda;
                color: #155724;
                padding: 10px;
                border-radius: 4px;
                margin-bottom: 15px;
                border: 1px solid #c3e6cb;
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
            .highlight {
                background-color: yellow;
                font-weight: bold;
            }
            .category-badge {
                display: inline-block;
                font-size: 0.8em;
                background-color: #6c757d;
                color: white;
                padding: 2px 8px;
                border-radius: 4px;
                margin-left: 10px;
            }
        </style>
    </head>
    <body>
        <% if (message != null) { %>
            <div class="success-message">
                <%= message %>
            </div>
        <% } %>
        
        <div class="menu">
            <h3>Выберите тему:</h3>
            <a href="?about=Про образование" <%= "Про образование".equals(about) ? "class='active'" : "" %>>Образование</a>
            <a href="?about=Про личное развитие" <%= "Про личное развитие".equals(about) ? "class='active'" : "" %>>Личное развитие</a>
            <a href="?about=Про отношения" <%= "Про отношения".equals(about) ? "class='active'" : "" %>>Отношения</a>
            <a href="?about=Про история" <%= "Про история".equals(about) ? "class='active'" : "" %>>История</a>
        </div>
        
        <div class="search-form">
            <form method="get" action="">
                <h3>Поиск цитат по ключевому слову:</h3>
                <input type="text" name="searchWord" placeholder="Введите слово для поиска..." 
                       value="<%= searchWord != null ? searchWord : "" %>">
                <input type="submit" value="Найти">
                <% if (searchWord != null && !searchWord.isEmpty()) { %>
                    <a href="?" style="margin-left: 10px; color: #dc3545;">Сбросить поиск</a>
                <% } %>
            </form>
        </div>
        
        <div class="add-quote-form">
            <h3>➕ Добавить новую цитату</h3>
            <form method="post" action="">
                <div class="form-group">
                    <label for="newQuote">Текст цитаты:</label>
                    <textarea name="newQuote" id="newQuote" placeholder="Введите текст цитаты..." required></textarea>
                </div>
                
                <div class="form-group">
                    <label for="newAuthor">Автор:</label>
                    <input type="text" name="newAuthor" id="newAuthor" placeholder="Введите имя автора..." required>
                </div>
                
                <div class="form-group">
                    <label for="newCategory">Категория:</label>
                    <select name="newCategory" id="newCategory" required>
                        <option value="">-- Выберите категорию --</option>
                        <option value="Про образование">Образование</option>
                        <option value="Про личное развитие">Личное развитие</option>
                        <option value="Про отношения">Отношения</option>
                        <option value="Про история">История</option>
                    </select>
                </div>
                
                <button type="submit" name="addQuote" value="true" class="btn-success">Добавить цитату</button>
            </form>
        </div>

        <div class="quotes-container">
            <h3><%= header%></h3>
            
            <%
                if (searchWord != null && !searchWord.trim().isEmpty()) {
                    // РЕЖИМ ПОИСКА ПО КЛЮЧЕВОМУ СЛОВУ
                    String searchTerm = searchWord.trim().toLowerCase();
                    out.println("<h2>Результаты поиска для: \"" + searchWord + "\"</h2>");
                    
                    boolean found = false;
                    
                    for (Map.Entry<String, String[]> entry : quotes.entrySet()) {
                        String category = entry.getKey();
                        String[] categoryQuotes = entry.getValue();
                        List<String> matchingQuotes = new ArrayList<String>();
                        
                        // Ищем цитаты, содержащие искомое слово
                        for (String quote : categoryQuotes) {
                            if (quote.toLowerCase().contains(searchTerm)) {
                                matchingQuotes.add(quote);
                            }
                        }
                        
                        // Если нашли совпадения в этой категории
                        if (!matchingQuotes.isEmpty()) {
                            found = true;
                            out.println("<h4>" + category + " <span class='category-badge'>найдено: " + matchingQuotes.size() + "</span></h4>");
                            out.println("<ul>");
                            for (String quote : matchingQuotes) {
                                // Подсвечиваем искомое слово в цитате
                                String highlightedQuote = quote.replaceAll(
                                    "(?i)(" + searchTerm + ")", 
                                    "<span class='highlight'>$1</span>"
                                );
                                out.println("<li>" + highlightedQuote + "</li>");
                            }
                            out.println("</ul>");
                        }
                    }
                    
                    if (!found) {
                        out.println("<p>Цитаты, содержащие слово \"" + searchWord + "\", не найдены.</p>");
                    }
                    
                } else if (about != null && !about.isEmpty()) {
                    // РЕЖИМ ПРОСМОТРА ПО КАТЕГОРИИ
                    String[] quotes_ = quotes.get(about);
                    out.println("<h2>" + about + ":</h2>");
                    
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
                    // РЕЖИМ ПО УМОЛЧАНИЮ (ВСЕ ЦИТАТЫ)
                    out.println("<h2>Все цитаты:</h2>");
                    
                    for (Map.Entry<String, String[]> entry : quotes.entrySet()) {
                        String category = entry.getKey();
                        String[] categoryQuotes = entry.getValue();
                        
                        out.println("<h4>" + category + ":</h4>");
                        out.println("<ul>");
                        for (String quote : categoryQuotes) {
                            out.println("<li>" + quote + "</li>");
                        }
                        out.println("</ul>");
                    }
                }
            %>
        </div>
    </body>
</html>


<!--Задание 6
Добавьте к пятому заданию возможность добавления пользовательской цитаты.
Пользователь вводит текст цитаты, информацию об авторе, категорию.
-->
