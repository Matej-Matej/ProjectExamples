package sk.matejcik.SemestralnaPraca.BookState;

public class BookState {

    private Integer book_state_id;
    private int user_id;
    private int book_id;
    private String state;

    public BookState(Integer book_state_id, int user_id, int book_id, String state) {
        this.book_state_id = book_state_id;
        this.user_id = user_id;
        this.book_id = book_id;
        this.state = state;
    }

    public Integer getBook_state_id() {
        return book_state_id;
    }

    public void setBook_state_id(Integer book_state_id) {
        this.book_state_id = book_state_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getBook_id() {
        return book_id;
    }

    public void setBook_id(int book_id) {
        this.book_id = book_id;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }
}
