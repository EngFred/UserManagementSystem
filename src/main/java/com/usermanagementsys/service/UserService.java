package com.usermanagementsys.service;

import com.usermanagementsys.dao.UserDao;
import com.usermanagementsys.model.User;

import javax.servlet.http.Part;
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

    public User updateUser(int userId, String username, String bio, Part filePart) {
        return userDAO.updateUser(userId, username, bio, filePart);
    }

    public boolean deleteUser(int id) {
        return userDAO.deleteUser(id);
    }

    public User findByEmail(String email) {
        return userDAO.findByEmail(email);
    }

    public boolean updatePassword(int userId, String newPassword) {
        return userDAO.updatePassword(userId, newPassword);
    }
}
