package sk.matejcik.SemestralnaPraca.AuthorChange;

import sk.matejcik.SemestralnaPraca.Author.Author;

public class AuthorChange {

    private Integer author_change_id;
    private Author author;

    public AuthorChange(Integer author_change_id, Author author) {
        this.author_change_id = author_change_id;
        this.author = author;
    }

    public Integer getAuthor_change_id() {
        return author_change_id;
    }

    public void setAuthor_change_id(Integer author_change_id) {
        this.author_change_id = author_change_id;
    }

    public Author getAuthor() {
        return author;
    }

    public void setAuthor(Author author) {
        this.author = author;
    }
}
