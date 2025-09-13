package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "Category")
public class Category {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cate_id")
    private int cateId; 

    @Column(name = "cate_name")
    private String cateName; 

    @Column(name = "icons")
    private String icon;

    public Category() {}
    

    public int getCateId() {
        return cateId;
    }
    public void setCateId(int cateId) {
        this.cateId = cateId;
    }
    public String getCateName() {
        return cateName;
    }
    public void setCateName(String cateName) {
        this.cateName = cateName;
    }
    public String getIcon() {
        return icon;
    }
    public void setIcon(String icon) {
        this.icon = icon;
    }
    @ManyToOne
    @JoinColumn(name = "userid") 
    private User user;


    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}