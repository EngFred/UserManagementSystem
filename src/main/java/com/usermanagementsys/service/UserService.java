package com.usermanagementsys.service;

import com.usermanagementsys.dao.UserDao;
import com.usermanagementsys.model.User;

import java.util.List;

//Business logic layer

public class UserService {
    private final UserDao userDAO = new UserDao();

    public boolean registerUser(User user) {
        return userDAO.saveUser(user);
    }

    public User loginUser(String email, String password) {
        return userDAO.signin_user(email, password);
    }

    public User getUser(int id) {
        return userDAO.getUserById(id);
    }

    public List<User> getAllUsers(int currentUserId) {
        return userDAO.getAllUsers(currentUserId);
    }

    public void updateUser(User user) {
        userDAO.updateUser(user);
    }

    public void deleteUser(int id) {
        userDAO.deleteUser(id);
    }
}
