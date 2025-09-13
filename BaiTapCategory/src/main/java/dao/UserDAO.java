package dao;

import java.util.List; // THÊM IMPORT NÀY

import entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import jpa.JpaConfig;

public class UserDAO {
    
    // Phương thức này đã có
    public User findByUsernameAndPassword(String username, String password) {
        EntityManager em = JpaConfig.getEntityManager();
        String jpql = "SELECT u FROM User u WHERE u.username = :username AND u.password = :password";
        TypedQuery<User> query = em.createQuery(jpql, User.class);
        query.setParameter("username", username);
        query.setParameter("password", password);
        try {
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }
    
    // Phương thức này đã có
    public void update(User user) {
        EntityManager em = JpaConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(user);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    // === CÁC PHƯƠNG THỨC CẦN BỔ SUNG ===

    public List<User> findAll() {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u ORDER BY u.id ASC"; // Sắp xếp theo ID
            TypedQuery<User> query = em.createQuery(jpql, User.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public User findById(int id) {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            return em.find(User.class, id);
        } finally {
            em.close();
        }
    }

    public void create(User user) {
        EntityManager em = JpaConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(user);
            trans.commit();
        } catch (Exception e) {
            if(trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void delete(int id) {
        EntityManager em = JpaConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            User user = em.find(User.class, id);
//
            if (user != null) {
                em.remove(user);
            }
            trans.commit();
        } catch (Exception e) {
            if(trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
    
    public List<User> searchByUsername(String keyword) {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE u.username LIKE :keyword";
            TypedQuery<User> query = em.createQuery(jpql, User.class);
            query.setParameter("keyword", "%" + keyword + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}