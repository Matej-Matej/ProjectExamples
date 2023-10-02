package sk.matejcik.SemestralnaPraca.User;

public class User {

    private Integer user_id;
    private String name;
    private String lastname;
    private String password;
    private String email;
    private String picture;
    private String role;

    public User(Integer user_id, String name, String lastname, String password, String email, String picture, String role) {
        this.user_id = user_id;
        this.name = name;
        this.lastname = lastname;
        this.password = password;
        this.email = email;
        this.picture = picture;
        this.role = role;
    }

    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
