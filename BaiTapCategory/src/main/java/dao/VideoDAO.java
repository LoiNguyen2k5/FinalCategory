package dao;

import java.util.List;
import entity.Video;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import jpa.JpaConfig;

public class VideoDAO {

    public List<Video> findAll() {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT v FROM Video v ORDER BY v.id DESC";
            TypedQuery<Video> query = em.createQuery(jpql, Video.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Video> searchByTitle(String keyword) {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT v FROM Video v WHERE v.title LIKE :keyword";
            TypedQuery<Video> query = em.createQuery(jpql, Video.class);
            query.setParameter("keyword", "%" + keyword + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Video findById(int id) {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            return em.find(Video.class, id);
        } finally {
            em.close();
        }
    }

    public void create(Video video) {
        EntityManager em = JpaConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(video);
            trans.commit();
        } catch (Exception e) {
            if(trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
    
    public void update(Video video) {
        EntityManager em = JpaConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(video);
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
            Video video = em.find(Video.class, id);
            if (video != null) {
                em.remove(video);
            }
            trans.commit();
        } catch (Exception e) {
            if(trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}