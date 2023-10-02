package sk.matejcik.SemestralnaPraca.Author;

import java.sql.Date;

public class Author {

    private Integer author_id;
    private String name;
    private String lastname;
    private Date birthDate;
    private Date deathDate;
    private String picture;
    private String biography;
    private String birthPlace;

    public Author(Integer author_id, String name, String lastname, Date birthDate, Date deathDate, String picture, String biography, String birthPlace) {
        this.author_id = author_id;
        this.name = name;
        this.lastname = lastname;
        this.birthDate = birthDate;
        this.deathDate = deathDate;
        this.picture = picture;
        this.biography = biography;
        this.birthPlace = birthPlace;
    }

    public Integer getAuthor_id() {
        return author_id;
    }

    public void setAuthor_id(Integer author_id) {
        this.author_id = author_id;
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

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public Date getDeathDate() {
        if (deathDate == null || deathDate.after(new Date(300,1,1))) return null;
        return deathDate;
    }

    public void setDeathDate(Date deathDate) {
        this.deathDate = deathDate;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public String getBiography() {
        return biography;
    }

    public void setBiography(String biography) {
        this.biography = biography;
    }

    public String getBirthPlace() {
        return birthPlace;
    }

    public void setBirthPlace(String birthPlace) {
        this.birthPlace = birthPlace;
    }
}
