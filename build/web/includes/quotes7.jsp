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

    // Загружаем сохраненные цитаты из сессии (если есть)
    if (session.getAttribute("quotes") != null) {
        quotes = (Map<String, String[]>) session.getAttribute("quotes");
    }

    // Для отслеживания пользовательских цитат
    Map<String, List<Boolean>> userAddedQuotes = new HashMap<String, List<Boolean>>();

    // Загружаем пользовательские цитаты из сессии
    if (session.getAttribute("userAddedQuotes") != null) {
        userAddedQuotes = (Map<String, List<Boolean>>) session.getAttribute("userAddedQuotes");
    } else {
        // Инициализируем для каждой категории (все исходные цитаты - не пользовательские)
        for (String category : quotes.keySet()) {
            List<Boolean> userAdded = new ArrayList<Boolean>();
            for (int i = 0; i < quotes.get(category).length; i++) {
                userAdded.add(true);
            }
            userAddedQuotes.put(category, userAdded);
        }
    }

    // Получаем параметры
    String about = request.getParameter("about");
    String searchWord = request.getParameter("searchWord");

    // Параметры для новой цитаты
    String newQuote = request.getParameter("newQuote");
    String newAuthor = request.getParameter("newAuthor");
    String newCategory = request.getParameter("newCategory");
    String addQuote = request.getParameter("addQuote");

    // Параметры для редактирования
    String editQuote = request.getParameter("editQuote");
    String editIndex = request.getParameter("editIndex");
    String editCategory = request.getParameter("editCategory");
    String editText = request.getParameter("editText");
    String editAuthor = request.getParameter("editAuthor");
    String saveEdit = request.getParameter("saveEdit");

    // Добавление новой цитаты
    if (addQuote != null && newQuote != null && !newQuote.trim().isEmpty()
            && newAuthor != null && !newAuthor.trim().isEmpty()
            && newCategory != null && !newCategory.trim().isEmpty()) {

        String category = newCategory.trim();
        String quoteText = newQuote.trim() + " (автор: " + newAuthor.trim() + ")";

        // Получаем существующие цитаты категории
        String[] existingQuotes = quotes.get(category);
        String[] updatedQuotes;

        // Получаем список пользовательских цитат для этой категории
        List<Boolean> userAdded = userAddedQuotes.get(category);
        if (userAdded == null) {
            userAdded = new ArrayList<Boolean>();
        }

        if (existingQuotes != null) {
            // Создаем новый массив на один элемент больше
            updatedQuotes = new String[existingQuotes.length + 1];
            System.arraycopy(existingQuotes, 0, updatedQuotes, 0, existingQuotes.length);
            updatedQuotes[existingQuotes.length] = quoteText;

            // Добавляем true для новой пользовательской цитаты
            while (userAdded.size() < existingQuotes.length) {
                userAdded.add(false);
            }
            userAdded.add(true);
        } else {
            // Создаем новый массив с одной цитатой
            updatedQuotes = new String[]{quoteText};
            userAdded = new ArrayList<Boolean>();
            userAdded.add(true);
        }

        // Обновляем map
        quotes.put(category, updatedQuotes);
        userAddedQuotes.put(category, userAdded);

        // Сохраняем ВСЕ данные в сессию
        session.setAttribute("quotes", quotes);
        session.setAttribute("userAddedQuotes", userAddedQuotes);

        session.setAttribute("message", "Цитата успешно добавлена в категорию \"" + category + "\"!");

        // Перенаправляем, чтобы избежать повторной отправки формы
        response.sendRedirect("quotes7.jsp" + (about != null ? "?about=" + about : ""));
        return;
    }

    // Сохранение отредактированной цитаты
    if (saveEdit != null && editText != null && !editText.trim().isEmpty()
            && editAuthor != null && !editAuthor.trim().isEmpty()
            && editCategory != null && editIndex != null) {

        int index = Integer.parseInt(editIndex);
        String category = editCategory;
        String updatedQuote = editText.trim() + " (автор: " + editAuthor.trim() + ")";

        // Обновляем цитату в массиве
        String[] categoryQuotes = quotes.get(category);
        if (categoryQuotes != null && index >= 0 && index < categoryQuotes.length) {
            categoryQuotes[index] = updatedQuote;
            quotes.put(category, categoryQuotes);

            // Убеждаемся, что цитата помечена как пользовательская
            List<Boolean> userAdded = userAddedQuotes.get(category);
            if (userAdded != null && index < userAdded.size()) {
                userAdded.set(index, true);
            } else {
                if (userAdded == null) {
                    userAdded = new ArrayList<Boolean>();
                }
                while (userAdded.size() <= index) {
                    userAdded.add(false);
                }
                userAdded.set(index, true);
                userAddedQuotes.put(category, userAdded);
            }

            // Сохраняем ВСЕ данные в сессию
            session.setAttribute("quotes", quotes);
            session.setAttribute("userAddedQuotes", userAddedQuotes);
            session.setAttribute("message", "Цитата успешно отредактирована!");

            // Перенаправляем, чтобы избежать повторной отправки формы
            response.sendRedirect("quotes7.jsp" + (about != null ? "?about=" + about : ""));
            return;
        }
    }

    // Получаем сообщение из сессии
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
            .edit-quote-form {
                margin-bottom: 20px;
                padding: 20px;
                background-color: #fff3cd;
                border: 1px solid #ffeeba;
                border-radius: 8px;
            }
            .edit-quote-form h3 {
                color: #856404;
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
            .btn-warning {
                background-color: #ffc107;
                color: #212529;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
            }
            .btn-warning:hover {
                background-color: #e0a800;
            }
            .btn-secondary {
                background-color: #6c757d;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                text-decoration: none;
                display: inline-block;
            }
            .btn-secondary:hover {
                background-color: #545b62;
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
                position: relative;
            }
            .user-quote {
                border-left-color: #28a745;
                background-color: #f0fff4;
            }
            .quote-actions {
                margin-top: 5px;
                text-align: right;
            }
            .edit-btn {
                background-color: #ffc107;
                color: #212529;
                border: none;
                padding: 3px 10px;
                border-radius: 3px;
                cursor: pointer;
                font-size: 12px;
                text-decoration: none;
                display: inline-block;
            }
            .edit-btn:hover {
                background-color: #e0a800;
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
            .user-badge {
                background-color: #28a745;
                font-size: 0.7em;
                margin-left: 5px;
                padding: 1px 5px;
            }
        </style>
    </head>
    <body>
        <% if (message != null) {%>
        <div class="success-message">
            <%= message%>
        </div>
        <% }%>

        <div class="menu">
            <h3>Выберите тему:</h3>
            <a href="quotes7.jsp?about=Про образование" <%= "Про образование".equals(about) ? "class='active'" : ""%>>Образование</a>
            <a href="quotes7.jsp?about=Про личное развитие" <%= "Про личное развитие".equals(about) ? "class='active'" : ""%>>Личное развитие</a>
            <a href="quotes7.jsp?about=Про отношения" <%= "Про отношения".equals(about) ? "class='active'" : ""%>>Отношения</a>
            <a href="quotes7.jsp?about=Про история" <%= "Про история".equals(about) ? "class='active'" : ""%>>История</a>
        </div>

        <div class="search-form">
            <form method="get" action="quotes7.jsp">
                <h3>Поиск цитат по ключевому слову:</h3>
                <input type="text" name="searchWord" placeholder="Введите слово для поиска..." 
                       value="<%= searchWord != null ? searchWord : ""%>">
                <input type="submit" value="Найти">
                <% if (searchWord != null && !searchWord.isEmpty()) { %>
                <a href="quotes7.jsp" style="margin-left: 10px; color: #dc3545;">Сбросить поиск</a>
                <% } %>
            </form>
        </div>

        <!-- Форма редактирования -->
        <% if (editQuote != null && "true".equals(editQuote) && editIndex != null && editCategory != null) {
                int index = Integer.parseInt(editIndex);
                String[] categoryQuotes = quotes.get(editCategory);
                if (categoryQuotes != null && index >= 0 && index < categoryQuotes.length) {
                    String quoteText = categoryQuotes[index];
                    // Парсим текст и автора
                    String text = quoteText;
                    String author = "";
                    int authorStart = quoteText.lastIndexOf(" (автор: ");
                    if (authorStart > 0) {
                        text = quoteText.substring(0, authorStart);
                        author = quoteText.substring(authorStart + 9, quoteText.length() - 1);
                    }
        %>
        <div class="edit-quote-form">
            <h3>✏️ Редактировать цитату</h3>
            <form method="post" action="quotes7.jsp">
                <input type="hidden" name="editIndex" value="<%= editIndex%>">
                <input type="hidden" name="editCategory" value="<%= editCategory%>">
                <input type="hidden" name="about" value="<%= about != null ? about : ""%>">

                <div class="form-group">
                    <label for="editText">Текст цитаты:</label>
                    <textarea name="editText" id="editText" required><%= text%></textarea>
                </div>

                <div class="form-group">
                    <label for="editAuthor">Автор:</label>
                    <input type="text" name="editAuthor" id="editAuthor" value="<%= author%>" required>
                </div>

                <button type="submit" name="saveEdit" value="true" class="btn-warning">💾 Сохранить изменения</button>
                <a href="quotes7.jsp<%= about != null ? "?about=" + about : ""%>" class="btn-secondary">Отмена</a>
            </form>
        </div>
        <%
                }
            }
        %>

        <!-- Форма добавления новой цитаты -->
        <div class="add-quote-form">
            <h3>➕ Добавить новую цитату</h3>
            <form method="post" action="quotes7.jsp">
                <input type="hidden" name="about" value="<%= about != null ? about : ""%>">

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
                        List<Boolean> userAdded = userAddedQuotes.get(category);

                        if (categoryQuotes != null) {
                            for (int i = 0; i < categoryQuotes.length; i++) {
                                String quote = categoryQuotes[i];
                                if (quote != null && quote.toLowerCase().contains(searchTerm)) {
                                    if (!found) {
                                        found = true;
                                    }

                                    boolean isUserAdded = (userAdded != null && i < userAdded.size() && userAdded.get(i) == true);
                                    String quoteClass = isUserAdded ? "user-quote" : "";
                                    String userBadge = isUserAdded ? " <span class='category-badge user-badge'>📝 Пользовательская</span>" : "";

                                    // Подсвечиваем искомое слово
                                    String highlightedQuote = quote.replaceAll("(?i)(" + searchTerm + ")", "<span class='highlight'>$1</span>");

                                    out.println("<li class='" + quoteClass + "'>" + highlightedQuote + userBadge);

                                    // Добавляем кнопку редактирования для пользовательских цитат
                                    if (isUserAdded) {
                                        out.println("<div class='quote-actions'>");
                                        out.println("<a href='quotes7.jsp?editQuote=true&editIndex=" + i + "&editCategory=" + category + (about != null ? "&about=" + about : "") + "' class='edit-btn'>✏️ Редактировать</a>");
                                        out.println("</div>");
                                    }

                                    out.println("</li>");
                                }
                            }
                        }
                    }

                    if (!found) {
                        out.println("<p>Цитаты, содержащие слово \"" + searchWord + "\", не найдены.</p>");
                    }

                } else if (about != null && !about.isEmpty()) {
                    // РЕЖИМ ПРОСМОТРА ПО КАТЕГОРИИ
                    String[] quotes_ = quotes.get(about);
                    List<Boolean> userAdded = userAddedQuotes.get(about);

                    out.println("<h2>" + about + ":</h2>");

                    if (quotes_ != null && quotes_.length > 0) {
                        out.println("<ul>");
                        for (int i = 0; i < quotes_.length; i++) {
                            if (quotes_[i] != null) {
                                boolean isUserAdded = (userAdded != null && i < userAdded.size() && userAdded.get(i) == true);
                                String quoteClass = isUserAdded ? "user-quote" : "";
                                String userBadge = isUserAdded ? " <span class='category-badge user-badge'>📝 Пользовательская</span>" : "";

                                out.println("<li class='" + quoteClass + "'>" + quotes_[i] + userBadge);

                                // Добавляем кнопку редактирования для пользовательских цитат
                                if (isUserAdded) {
                                    out.println("<div class='quote-actions'>");
                                    out.println("<a href='quotes7.jsp?editQuote=true&editIndex=" + i + "&editCategory=" + about + "' class='edit-btn'>✏️ Редактировать</a>");
                                    out.println("</div>");
                                }

                                out.println("</li>");
                            }
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
                        List<Boolean> userAdded = userAddedQuotes.get(category);

                        out.println("<h4>" + category + ":</h4>");
                        out.println("<ul>");
                        if (categoryQuotes != null) {
                            for (int i = 0; i < categoryQuotes.length; i++) {
                                if (categoryQuotes[i] != null) {
                                    boolean isUserAdded = (userAdded != null && i < userAdded.size() && userAdded.get(i) == true);
                                    String quoteClass = isUserAdded ? "user-quote" : "";
                                    String userBadge = isUserAdded ? " <span class='category-badge user-badge'>📝 Пользовательская</span>" : "";

                                    out.println("<li class='" + quoteClass + "'>" + categoryQuotes[i] + userBadge);

                                    // Добавляем кнопку редактирования для пользовательских цитат
//                                    if (isUserAdded) {
//                                        out.println("<div class='quote-actions'>");
//                                        out.println("<a href='quotes7.jsp?editQuote=true&editIndex=" + i + "&editCategory=" + category + "' class='edit-btn'>✏️ Редактировать</a>");
//                                        out.println("</div>");
//                                    }
                                    out.println("<div class='quote-actions'>");
                                    out.println("<a href='quotes7.jsp?editQuote=true&editIndex=" + i + "&editCategory=" + category + "' class='edit-btn'>✏️ Редактировать</a>");
                                    out.println("</div>");

                                    out.println("</li>");
                                }
                            }
                        }
                        out.println("</ul>");
                    }
                }
            %>
        </div>
    </body>
</html>

<!--Задание 7
Добавьте к шестому заданию возможность редактирования пользовательской цитаты.

-->
