package com.usermanagementsys.dao;

import com.usermanagementsys.model.User;
import com.usermanagementsys.util.CloudinaryUtils;
import com.usermanagementsys.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.exception.ConstraintViolationException;
import org.hibernate.query.Query;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.http.Part;
import java.util.Collections;
import java.util.List;

public class UserDao {

    public boolean saveUser(User user) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();

            // Hash the password
            String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
            user.setPassword(hashedPassword);

            session.save(user);
            transaction.commit();
            return true;
        } catch (ConstraintViolationException e) {
            System.err.println("Duplicate email: " + user.getEmail());
            return false;
        } catch (Exception e) {
            if (transaction != null && transaction.getStatus().canRollback()) {
                transaction.rollback();
            }
            System.err.println("Error registering new user: " + e);
            return false;
        }
    }

    public User signin_user(String email, String password) {

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<User> query = session.createQuery("FROM User WHERE email = :email", User.class);
            query.setParameter("email", email);
            User user = query.uniqueResult();

            if (user != null && BCrypt.checkpw(password, user.getPassword())) {
                return user;
            } else {
                System.err.println("Invalid email or password.");
                return null;
            }
        } catch (Exception e) {
            System.err.println("Error signing in user: " + e);
            return null;
        }
    }

    public User getUserById(int id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(User.class, id);
        }
    }

    public List<User> getAllUsers(int currentUserId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<User> query = session.createQuery("FROM User WHERE id != :id", User.class);
            query.setParameter("id", currentUserId);
            return query.list();
        } catch (Exception e) {
            System.err.println("Error getting all users: " + e);
            return Collections.emptyList();
        }
    }

    public User updateUser(int userId, String username, String bio, Part filePart) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();

            //Fetch the user from the database first
            User user = session.get(User.class, userId);

            String imageUrl = null;
            if (filePart != null && filePart.getSize() > 0) {
                imageUrl = CloudinaryUtils.uploadProfileImage(filePart);
            }

            if (user != null) {
                user.setUsername(username);
                if(imageUrl != null && !imageUrl.isEmpty()) user.setImageUrl(imageUrl);
                user.setBio(bio);
                session.update(user);
            }

            transaction.commit();
            return user;
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            System.err.println("Error updating user: " + e.getMessage());
            return null;
        }
    }


    public boolean deleteUser(int id) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            User user = session.get(User.class, id);
            if (user != null) {
                session.delete(user);
            }
            transaction.commit();
            return true;
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            System.err.println("Error deleting user: " + e);
            return false;
        }
    }

    public User findByEmail(String email) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<User> query = session.createQuery("FROM User WHERE email = :email", User.class);
            query.setParameter("email", email);
            return query.uniqueResult();
        } catch (Exception e) {
            System.err.println("Error finding user by email: " + e);
            return null;
        }
    }

    public boolean updatePassword(int userId, String newPassword) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();

            User user = session.get(User.class, userId);
            if(user != null) {
                String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
                user.setPassword(hashedPassword);
                session.update(user);
            }

            transaction.commit();
            return true;
        } catch (Exception e) {
            System.err.println("Error updating password: " + e);
            return false;
        }
    }
}
