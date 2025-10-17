package ma.formation.todolist.todolist.controller;

import ma.formation.todolist.todolist.model.Todo;
import ma.formation.todolist.todolist.service.TodoService;
import ma.formation.todolist.todolist.service.TodoServiceImpl;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class TodoController extends HttpServlet {
    private TodoService todoService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.todoService = new TodoServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("edit".equals(action)) {
                handleEdit(request, response);
            } else if ("delete".equals(action)) {
                handleDelete(request, response);
            } else {
                handleList(request, response);
            }
        } catch (SQLException e) {
            handleError(request, response, e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                handleAdd(request, response);
            } else if ("update".equals(action)) {
                handleUpdate(request, response);
            }
            response.sendRedirect(request.getContextPath() + "/todo");
        } catch (SQLException | IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            try {
                handleList(request, response);
            } catch (SQLException ex) {
                handleError(request, response, ex);
            }
        }
    }

    private void handleList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Todo> todos = todoService.getAllTodos();
        request.setAttribute("todos", todos);
        request.getRequestDispatcher("/jsp/index.jsp").forward(request, response);
    }

    private void handleEdit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        Todo todo = todoService.getTodoById(id);
        request.setAttribute("todo", todo);
        request.getRequestDispatcher("/jsp/editTodo.jsp").forward(request, response);
    }

    private void handleAdd(HttpServletRequest request, HttpServletResponse response)
            throws SQLException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        todoService.createTodo(title, description);
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        boolean completed = "on".equals(request.getParameter("completed"));
        todoService.updateTodo(id, title, description, completed);
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        todoService.deleteTodo(id);
        response.sendRedirect(request.getContextPath() + "/todo");
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response, SQLException e)
            throws ServletException, IOException {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
    }
}
