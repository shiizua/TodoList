package ma.formation.todolist.todolist.dao;

import ma.formation.todolist.todolist.model.Todo;
import java.sql.SQLException;
import java.util.List;

public interface TodoDAO {
    void addTodo(Todo todo) throws SQLException;
    List<Todo> getAllTodos() throws SQLException;
    Todo getTodoById(int id) throws SQLException;
    void updateTodo(Todo todo) throws SQLException;
    void deleteTodo(int id) throws SQLException;
}