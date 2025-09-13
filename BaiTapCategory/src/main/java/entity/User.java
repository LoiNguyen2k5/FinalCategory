package entity;

import java.util.List;
import jakarta.persistence.*;

@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(unique = true, nullable = false)
    private String username;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private int roleid;

    @Column(name = "fullname")
    private String fullname;
    
    @Column(name = "phone")
    private String phone;
    
    @Column(name = "images")
    private String images; 

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<Category> categories;

    public User() {
    }

    public User(String username, String password, int roleid, String fullname, String phone, String images) {
        this.username = username;
        this.password = password;
        this.roleid = roleid;
        this.fullname = fullname;
        this.phone = phone;
        this.images = images;
    }


    // === GETTERS AND SETTERS ===

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getRoleid() {
        return roleid;
    }

    public void setRoleid(int roleid) {
        this.roleid = roleid;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public List<Category> getCategories() {
        return categories;
    }

    public void setCategories(List<Category> categories) {
        this.categories = categories;
    }
}