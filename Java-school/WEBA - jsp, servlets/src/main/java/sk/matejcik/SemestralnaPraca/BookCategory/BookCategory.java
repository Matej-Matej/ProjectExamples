package sk.matejcik.SemestralnaPraca.BookCategory;

public class BookCategory {

    private Integer book_category_id;
    private int book_id;
    private int category_id;

    public BookCategory(Integer book_category_id, int book_id, int category_id) {
        this.book_category_id = book_category_id;
        this.book_id = book_id;
        this.category_id = category_id;
    }

    public Integer getBook_category_id() {
        return book_category_id;
    }

    public void setBook_category_id(Integer book_category_id) {
        this.book_category_id = book_category_id;
    }

    public int getBook_id() {
        return book_id;
    }

    public void setBook_id(int book_id) {
        this.book_id = book_id;
    }

    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }
}
