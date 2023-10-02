package sk.matejcik.SemestralnaPraca.BookState;

        import sk.matejcik.SemestralnaPraca.Author.Author;
        import sk.matejcik.SemestralnaPraca.BookAuthor.BookAuthor;
        import sk.matejcik.SemestralnaPraca.BookAuthor.BookAuthorController;
        import sk.matejcik.SemestralnaPraca.Helpers.DatabaseConnectionManager;

        import javax.naming.NamingException;
        import java.sql.Connection;
        import java.sql.PreparedStatement;
        import java.sql.ResultSet;
        import java.sql.SQLException;
        import java.util.ArrayList;
        import java.util.List;

public class BookStateController {

    public List<BookState> getAllBookState() {
        List<BookState> bookStateList = new ArrayList<>();
        String sql = "SELECT * FROM book_state";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {
            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                bookStateList.add(new BookState(
                        resultSet.getInt("book_state_id"),
                        resultSet.getInt("user_id"),
                        resultSet.getInt("book_id"),
                        resultSet.getString("state")
                ));
            }

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }
        return bookStateList;
    }

    public int insertBookState(BookState bookState) {
        String sql = "INSERT INTO book_state (user_id,book_id,state) VALUES (?,?,?)";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {
            ps.setInt(1, bookState.getUser_id());
            ps.setInt(2, bookState.getBook_id());
            ps.setString(3, bookState.getState());

            return ps.executeUpdate();
        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public BookState getBookStateById(int userId, int bookId) {
        List<BookState> bookStateList = getAllBookState();
        for (BookState bs : bookStateList) {
            if (bs.getUser_id() == userId && bs.getBook_id() == bookId) {
                return bs;
            }
        }
        return null;
    }

    public void updateBookState(int bookStateId, String newState) {
        String sql = "UPDATE book_state SET state = ? WHERE book_state_id = ?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {
            ps.setString(1, newState);
            ps.setInt(2, bookStateId);

            ps.executeUpdate();
        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteBookState(int book_state_id) {
        String sql = "DELETE FROM book_state WHERE book_state_id = ?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {

            ps.setInt(1, book_state_id);

            ps.executeUpdate();

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }
    }
}
