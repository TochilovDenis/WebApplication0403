<%-- 
    Document   : timer
    Created on : 5 мар. 2026 г., 21:46:25
    Author     : dex
--%>

<%@ page contentType="text/html;" pageEncoding="UTF-8" language="java" %>

<%
    // Получаем контекстный путь приложения
    String contextPath = request.getContextPath();
%>

<h1>Таймер обратного отсчета</h1>
    
<%-- Используем абсолютный путь от корня приложения --%>
<form method="get" action="<%= contextPath %>/includes/timer.jsp">
    <label for="seconds">Введите время в секундах:</label>
    <input type="number" id="seconds" name="seconds" min="1" value="10" required>
    <button type="submit" name="action" value="start">Запустить таймер</button>
</form>
    
<%
    String secondsParam = request.getParameter("seconds");
    String action = request.getParameter("action");
    String resetParam = request.getParameter("reset");
    
    // Сброс таймера
    if (resetParam != null && resetParam.equals("true")) {
        session.removeAttribute("startTime");
        session.removeAttribute("totalSeconds");
        session.removeAttribute("initialSeconds");
        session.removeAttribute("remainingSeconds");
        session.removeAttribute("timerFinished");
    }
    
    if (action != null && action.equals("start") && secondsParam != null && !secondsParam.isEmpty()) {
        try {
            int seconds = Integer.parseInt(secondsParam);
            
            // Получаем или создаем сессию
            session = request.getSession(true);
            
            // Устанавливаем начальное значение таймера
            if (session.getAttribute("startTime") == null) {
                session.setAttribute("startTime", System.currentTimeMillis());
                session.setAttribute("totalSeconds", seconds);
                session.setAttribute("initialSeconds", seconds);
            }
            
            // Вычисляем оставшееся время
            long startTime = (Long) session.getAttribute("startTime");
            int totalSeconds = (Integer) session.getAttribute("totalSeconds");
            int initialSeconds = (Integer) session.getAttribute("initialSeconds");
            
            long currentTime = System.currentTimeMillis();
            long elapsedSeconds = (currentTime - startTime) / 1000;
            long remainingSeconds = totalSeconds - elapsedSeconds;
            
            // Обновляем оставшееся время в сессии
            session.setAttribute("remainingSeconds", remainingSeconds);
            
            // Проверяем, не истекло ли время
            if (remainingSeconds <= 0) {
                session.setAttribute("remainingSeconds", 0);
                session.setAttribute("timerFinished", true);
                
                // Очищаем данные сессии для таймера
                session.removeAttribute("startTime");
                session.removeAttribute("totalSeconds");
                session.removeAttribute("initialSeconds");
            }
            
            // Получаем текущее значение для отображения
            long displaySeconds = remainingSeconds > 0 ? remainingSeconds : 0;
            
            // Форматируем время в минуты:секунды
            long minutes = displaySeconds / 60;
            long seconds_display = displaySeconds % 60;
            String timeFormatted = String.format("%02d:%02d", minutes, seconds_display);
%>
    
<div style="margin-top: 20px; padding: 10px; border: 1px solid #ccc;">
    <h2>Таймер запущен!</h2>
        
    <%
        if (session.getAttribute("timerFinished") != null && (Boolean) session.getAttribute("timerFinished")) {
    %>
        <p style="color: green; font-size: 24px;">⏰ Время истекло!</p>
    <%
            session.removeAttribute("timerFinished");
        } else {
    %>
        <p style="font-size: 20px;">⏱️ Осталось: <strong><%= timeFormatted %></strong></p>
        <p>Всего секунд: <%= displaySeconds %></p>
            
        <%-- Используем абсолютный путь и здесь --%>
        <form method="get" action="<%= contextPath %>/includes/timer.jsp" style="display: inline;">
            <input type="hidden" name="seconds" value="<%= initialSeconds %>">
            <input type="hidden" name="action" value="start">
            <button type="submit">🔄 Обновить таймер</button>
        </form>
    <%
        }
    %>
        
    <%-- И здесь абсолютный путь --%>
    <form method="get" action="<%= contextPath %>/includes/timer.jsp" style="display: inline; margin-left: 10px;">
        <button type="submit" name="reset" value="true">🛑 Сбросить таймер</button>
    </form>
</div>
    
<%
        } catch (NumberFormatException e) {
%>
        <p style="color: red;">❌ Ошибка: введите корректное число</p>
<%
        }
    }
%>
    
<script>
    // Автоматическое обновление страницы каждую секунду для обновления таймера
    <% 
        if (session.getAttribute("startTime") != null && 
            session.getAttribute("timerFinished") == null) { 
    %>
        setTimeout(function() {
            location.reload();
        }, 1000);
    <% } %>
</script>
    
<p style="margin-top: 20px;">
    <small>⏲️ Таймер автоматически обновляется каждую секунду</small>
</p>