package dao;

import java.io.File;
import java.util.List;
import entity.Category;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import jpa.JpaConfig;
import util.Constant; 

public class CategoryDAO {
    
    public void create(Category category) {
        EntityManager em = JpaConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(category);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    public void update(Category category) {
        EntityManager em = JpaConfig.getEntityManager();	
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(category); // Dùng merge cho việc update
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }
    
    // PHẦN SỬA LỖI NẰM Ở ĐÂY
    public void delete(int cateId) {
        EntityManager em = JpaConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            
            // 1. Tìm Category cần xóa
            Category category = em.find(Category.class, cateId);
            
            if (category != null) {
                // 2. Xóa file ảnh liên quan (nếu có)
                if (category.getIcon() != null && !category.getIcon().isEmpty()) {
                    String filePath = Constant.DIR + File.separator + category.getIcon();
                    File file = new File(filePath);
                    if (file.exists()) {
                        file.delete();
                    }
                }
                
                // 3. Xóa đối tượng Category khỏi database
                em.remove(category);
            } else {
                // Tùy chọn: Ném ra exception nếu không tìm thấy
                throw new IllegalArgumentException("Không tìm thấy danh mục với ID: " + cateId);
            }
            
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e; // Ném lại exception để Controller có thể bắt
        } finally {
            em.close();
        }
    }
    
    public Category findById(int cateId) {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            Category category = em.find(Category.class, cateId);
            return category;
        } finally {
            em.close();
        }
    }

    public List<Category> findAll() {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT c FROM Category c";
            TypedQuery<Category> query = em.createQuery(jpql, Category.class);
            return query.getResultList();
        } finally {
            em.close(); // Quan trọng: Đảm bảo EntityManager được đóng
        }
    }
    public List<Category> findByUserId(int userId) {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT c FROM Category c WHERE c.user.id = :userId";
            TypedQuery<Category> query = em.createQuery(jpql, Category.class);
            query.setParameter("userId", userId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}