package ma.formation.todolist.todolist.service;


import ma.formation.todolist.todolist.dao.TodoDAO;
import ma.formation.todolist.todolist.dao.TodoDAOImpl;
import ma.formation.todolist.todolist.model.Todo;
import java.sql.SQLException;
import java.util.List;

public class TodoServiceImpl implements TodoService {
    private TodoDAO todoDAO;

    public TodoServiceImpl() {
        this.todoDAO = new TodoDAOImpl();
    }

    @Override
    public void createTodo(String title, String description) throws SQLException {
        if (title == null || title.trim().isEmpty()) {
            throw new IllegalArgumentException("Le titre ne peut pas être vide");
        }
        Todo todo = new Todo(title.trim(), description != null ? description.trim() : "");
        todoDAO.addTodo(todo);
    }

    @Override
    public List<Todo> getAllTodos() throws SQLException {
        return todoDAO.getAllTodos();
    }

    @Override
    public Todo getTodoById(int id) throws SQLException {
        if (id <= 0) {
            throw new IllegalArgumentException("ID invalide");
        }
        return todoDAO.getTodoById(id);
    }

    @Override
    public void updateTodo(int id, String title, String description, boolean completed) throws SQLException {
        if (id <= 0) {
            throw new IllegalArgumentException("ID invalide");
        }
        if (title == null || title.trim().isEmpty()) {
            throw new IllegalArgumentException("Le titre ne peut pas être vide");
        }
        Todo todo = new Todo(id, title.trim(), description != null ? description.trim() : "", completed, null);
        todoDAO.updateTodo(todo);
    }

    @Override
    public void deleteTodo(int id) throws SQLException {
        if (id <= 0) {
            throw new IllegalArgumentException("ID invalide");
        }
        todoDAO.deleteTodo(id);
    }
}