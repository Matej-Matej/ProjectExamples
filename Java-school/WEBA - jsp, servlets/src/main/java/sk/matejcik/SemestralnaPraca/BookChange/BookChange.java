package sk.matejcik.SemestralnaPraca.BookChange;

import sk.matejcik.SemestralnaPraca.Book.Book;

public class BookChange {
    private Integer book_change_id;
    private Book book;

    public BookChange(Integer book_change_id, Book book) {
        this.book_change_id = book_change_id;
        this.book = book;
    }

    public Integer getBook_change_id() {
        return book_change_id;
    }

    public void setBook_change_id(Integer book_change_id) {
        this.book_change_id = book_change_id;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }
}
