package sk.matejcik.SemestralnaPraca.Book;

import java.sql.Date;

public class Book {

    private Integer book_id;
    private String name;
    private String content;
    private int page_count;
    private int year;
    private String publisher;
    private String isbn;
    private String picture;

    public Book(Integer book_id, String name, String content, int page_count, int year, String publisher, String isbn, String picture) {
        this.book_id = book_id;
        this.name = name;
        this.content = content;
        this.page_count = page_count;
        this.year = year;
        this.publisher = publisher;
        this.isbn = isbn;
        this.picture = picture;
    }

    public Integer getBook_id() {
        return book_id;
    }

    public void setBook_id(Integer book_id) {
        this.book_id = book_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getPage_count() {
        return page_count;
    }

    public void setPage_count(int page_count) {
        this.page_count = page_count;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }
}
