<%--
  Created by IntelliJ IDEA.
  User: chaim
  Date: 10/17/2025
  Time: 11:06 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Ajouter une Tâche</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { max-width: 700px; margin: 30px auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { color: #333; margin-bottom: 30px; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; color: #333; }
        input, textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; font-family: Arial; }
        textarea { resize: vertical; min-height: 100px; }
        input:focus, textarea:focus { outline: none; border-color: #4CAF50; box-shadow: 0 0 5px rgba(76,175,80,0.3); }
        .button-group { margin-top: 30px; }
        button { padding: 12px 24px; background: #4CAF50; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; margin-right: 10px; }
        button:hover { background: #45a049; }
        .cancel-btn { background: #999; }
        .cancel-btn:hover { background: #777; }
        .error { color: #d32f2f; padding: 10px; background: #ffebee; border-radius: 4px; margin-bottom: 15px; }
    </style>
</head>
<body>
<div class="container">
    <h1>➕ Ajouter une Nouvelle Tâche</h1>

    <% if (request.getAttribute("error") != null) { %>
    <div class="error"><%= request.getAttribute("error") %></div>
    <% } %>

    <form method="post" action="<%= request.getContextPath() %>/todo">
        <input type="hidden" name="action" value="add">

        <div class="form-group">
            <label>Titre <span style="color: red;">*</span></label>
            <input type="text" name="title" placeholder="Entrez le titre de la tâche" required autofocus>
        </div>

        <div class="form-group">
            <label>Description</label>
            <textarea name="description" placeholder="Entrez une description (optionnel)"></textarea>
        </div>

        <div class="button-group">
            <button type="submit">💾 Ajouter la Tâche</button>
            <a href="<%= request.getContextPath() %>/todo" style="text-decoration: none;">
                <button type="button" class="cancel-btn">❌ Annuler</button>
            </a>
        </div>
    </form>
</div>
</body>
</html>