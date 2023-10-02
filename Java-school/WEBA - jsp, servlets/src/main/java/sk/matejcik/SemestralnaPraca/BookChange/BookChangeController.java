package sk.matejcik.SemestralnaPraca.BookChange;

import sk.matejcik.SemestralnaPraca.Author.Author;
import sk.matejcik.SemestralnaPraca.AuthorChange.AuthorChange;
import sk.matejcik.SemestralnaPraca.Book.Book;
import sk.matejcik.SemestralnaPraca.Helpers.DatabaseConnectionManager;

import javax.naming.NamingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookChangeController {

    public List<BookChange> getAllBookChange() {
        List<BookChange> bookChangeList = new ArrayList<>();
        String sql = "SELECT * FROM book_change";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {
            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                bookChangeList.add(new BookChange(
                        resultSet.getInt("book_change_id"),
                        new Book(
                                resultSet.getInt("book_id"),
                                resultSet.getString("name"),
                                resultSet.getString("content"),
                                resultSet.getInt("page_count"),
                                resultSet.getInt("year"),
                                resultSet.getString("publisher"),
                                resultSet.getString("isbn"),
                                resultSet.getString("picture")
                        )
                ));
            }

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }
        return bookChangeList;
    }
    public int insertBookChange(BookChange bookChange) {
        String sql = "INSERT INTO book_change (book_id,name,content, page_count, year, publisher, isbn, picture) VALUES (?,?,?,?,?,?,?,?)";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {
            ps.setInt(1,bookChange.getBook().getBook_id());
            ps.setString(2,bookChange.getBook().getName());
            ps.setString(3,bookChange.getBook().getContent());
            ps.setInt(4,bookChange.getBook().getPage_count());
            ps.setInt(5,bookChange.getBook().getYear());
            ps.setString(6,bookChange.getBook().getPublisher());
            ps.setString(7,bookChange.getBook().getIsbn());
            ps.setString(8,bookChange.getBook().getPicture());

            return ps.executeUpdate();
        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }
    public int deleteBookChange(int bookChangeId) {
        String sql =  "DELETE FROM book_change WHERE book_change_id = ?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {

            ps.setInt(1,bookChangeId);

            return ps.executeUpdate();

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    public BookChange getBookChange(int bookChangeId) {
        List<BookChange> bookChangeList = getAllBookChange();
        for (BookChange bc : bookChangeList) {
            if (bc.getBook_change_id() == bookChangeId) {
                return bc;
            }
        }
        return null;
    }
    
}
