package sk.banas.kamencay.matejcik.semestralka.database;

import java.util.Arrays;

public class User {

    private int id;
    private String name;
    private String password;
    private float height;
    private float weight;
    private String birthdate;
    private boolean gender;

    public User(String name, String password) {
        this.name = name;
        this.password = password;
    }

    public User(int id, String name, String password, float height, float weight, String birthdate, boolean gender) {
        this.id = id;
        this.name = name;
        this.password = password;
        this.height = height;
        this.weight = weight;
        this.birthdate = birthdate;
        this.gender = gender;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", password='" + password + '\'' +
                ", gender=" + gender +
                '}';
    }

    public String getFirstLetter() {
        return this.name.substring(0,1).toUpperCase();
    }

    public String toString2() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", password='" + password + '\'' +
                ", gender=" + gender +
                ", height=" + height +
                ", weight=" + weight +
                ", birthdate=" + birthdate +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public float getHeight() {
        return height;
    }

    public void setHeight(float height) {
        this.height = height;
    }

    public float getWeight() {
        return weight;
    }

    public void setWeight(float weight) {
        this.weight = weight;
    }

    public String getBirthdate() {
        return birthdate;
    }

    public void setBirthdate(String birthdate) {
        this.birthdate = birthdate;
    }
}
