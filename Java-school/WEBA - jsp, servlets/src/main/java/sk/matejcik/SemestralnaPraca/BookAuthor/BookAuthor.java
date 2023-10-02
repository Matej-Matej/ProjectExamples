package sk.matejcik.SemestralnaPraca.BookAuthor;

public class BookAuthor {

    private Integer book_author_id;
    private int book_id;
    private int author_id;

    public BookAuthor(Integer book_author_id, int book_id, int author_id) {
        this.book_author_id = book_author_id;
        this.book_id = book_id;
        this.author_id = author_id;
    }

    public Integer getBook_author_id() {
        return book_author_id;
    }

    public void setBook_author_id(Integer book_author_id) {
        this.book_author_id = book_author_id;
    }

    public int getBook_id() {
        return book_id;
    }

    public void setBook_id(int book_id) {
        this.book_id = book_id;
    }

    public int getAuthor_id() {
        return author_id;
    }

    public void setAuthor_id(int author_id) {
        this.author_id = author_id;
    }
}

