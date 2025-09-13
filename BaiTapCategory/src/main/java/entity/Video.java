package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "videos")
public class Video {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false)
    private String title;

    private String description;

    @Column(unique = true, nullable = false)
    private String url;

    @ManyToOne
    @JoinColumn(name = "userid")
    private User user;

    // === Constructors ===
    public Video() {
        // Constructor không tham số bắt buộc cho JPA
    }

    public Video(String title, String description, String url, User user) {
        this.title = title;
        this.description = description;
        this.url = url;
        this.user = user;
    }

    // === Getters and Setters ===
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}