package ma.formation.todolist.todolist.service;

import ma.formation.todolist.todolist.model.Todo;
import java.sql.SQLException;
import java.util.List;

public interface TodoService {
    void createTodo(String title, String description) throws SQLException;
    List<Todo> getAllTodos() throws SQLException;
    Todo getTodoById(int id) throws SQLException;
    void updateTodo(int id, String title, String description, boolean completed) throws SQLException;
    void deleteTodo(int id) throws SQLException;
}