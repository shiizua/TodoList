<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ma.formation.todolist.todolist.model.Todo" %>

<!DOCTYPE html>
<html>
<head>
    <title>Todo List</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { max-width: 700px; margin: 30px auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { color: #333; margin-bottom: 30px; }
        .form-section { background: #f9f9f9; padding: 20px; border-radius: 5px; margin-bottom: 30px; }
        .form-section h2 { font-size: 18px; margin-bottom: 15px; color: #555; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; color: #333; }
        input, textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; font-family: Arial; }
        textarea { resize: vertical; min-height: 80px; }
        input:focus, textarea:focus { outline: none; border-color: #4CAF50; box-shadow: 0 0 5px rgba(76,175,80,0.3); }
        button { padding: 12px 24px; background: #4CAF50; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; }
        button:hover { background: #45a049; }
        .error { color: #d32f2f; padding: 10px; background: #ffebee; border-radius: 4px; margin-bottom: 15px; }
        .todo-list h2 { margin-bottom: 20px; color: #333; }
        .todo-item { padding: 15px; border: 1px solid #ddd; margin-bottom: 15px; border-radius: 4px; background: #fafafa; }
        .todo-item.completed { opacity: 0.6; }
        .todo-item.completed .title { text-decoration: line-through; }
        .title { font-weight: bold; font-size: 18px; color: #333; margin-bottom: 5px; }
        .description { color: #666; margin: 10px 0; }
        .date { font-size: 12px; color: #999; margin: 10px 0; }
        .actions { margin-top: 10px; }
        .actions a { margin-right: 15px; text-decoration: none; color: #4CAF50; }
        .actions a:hover { text-decoration: underline; }
        .delete-link { color: #d32f2f; }
        .empty { text-align: center; color: #999; padding: 40px; }
    </style>
</head>
<body>
<div class="container">
    <h1>📝 Ma Liste de Tâches</h1>

    <% if (request.getAttribute("error") != null) { %>
    <div class="error"><%= request.getAttribute("error") %></div>
    <% } %>

    <div class="form-section">
        <h2>Ajouter une nouvelle tâche</h2>
        <form method="post" action="<%= request.getContextPath() %>/todo">
            <input type="hidden" name="action" value="add">
            <div class="form-group">
                <label>Titre <span style="color: red;">*</span></label>
                <input type="text" name="title" placeholder="Entrez le titre de la tâche" required>
            </div>
            <div class="form-group">
                <label>Description</label>
                <textarea name="description" placeholder="Entrez une description (optionnel)"></textarea>
            </div>
            <button type="submit">Ajouter la tâche</button>
        </form>
    </div>

    <div class="todo-list">
        <h2>Mes Tâches</h2>
        <%
            List<Todo> todos = (List<Todo>) request.getAttribute("todos");
            if (todos != null && !todos.isEmpty()) {
                for (Todo todo : todos) {
        %>
        <div class="todo-item <%= todo.isCompleted() ? "completed" : "" %>">
            <div class="title"><%= todo.getTitle() %></div>
            <% if (todo.getDescription() != null && !todo.getDescription().isEmpty()) { %>
            <div class="description"><%= todo.getDescription() %></div>
            <% } %>
            <div class="date">📅 <%= todo.getFormattedDate() %></div>
            <div class="actions">
                <a href="<%= request.getContextPath() %>/todo?action=edit&id=<%= todo.getId() %>">✏️ Modifier</a>
                <a href="<%= request.getContextPath() %>/todo?action=delete&id=<%= todo.getId() %>" class="delete-link" onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette tâche?')">🗑️ Supprimer</a>
            </div>
        </div>
        <%
            }
        } else {
        %>
        <div class="empty">
            <p>Aucune tâche pour le moment. Commencez à en ajouter!</p>
        </div>
        <%
            }
        %>
    </div>
</div>
</body>
</html>