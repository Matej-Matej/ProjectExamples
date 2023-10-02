package sk.matejcik.SemestralnaPraca.BookAuthor;

import sk.matejcik.SemestralnaPraca.Author.Author;
import sk.matejcik.SemestralnaPraca.Author.AuthorController;
import sk.matejcik.SemestralnaPraca.Book.Book;
import sk.matejcik.SemestralnaPraca.Book.BookController;
import sk.matejcik.SemestralnaPraca.Helpers.DatabaseConnectionManager;

import javax.naming.NamingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookAuthorController {

    public List<BookAuthor> getAllBookAuthor() {
        List<BookAuthor> bookAuthor = new ArrayList<>();
        String sql = "SELECT * FROM book_author";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {
            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                bookAuthor.add(new BookAuthor(
                        resultSet.getInt("book_author_id"),
                        resultSet.getInt("book_id"),
                        resultSet.getInt("author_id")
                ));
            }
        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }
        return bookAuthor;
    }
    public int insertBookAuthor(BookAuthor bookAuthor) {
        String sql = "INSERT INTO book_author (book_id,author_id) VALUES (?,?)";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {
            ps.setInt(1,bookAuthor.getBook_id());
            ps.setInt(2,bookAuthor.getAuthor_id());

            return ps.executeUpdate();
        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }
    public List<Author> getAuthorsOfBook(int bookId) {
        AuthorController authorController = new AuthorController();

        List<BookAuthor> bookAuthorList = getAllBookAuthor();
        List<Author> authorList = new ArrayList<>();

        for (BookAuthor ba : bookAuthorList) {
            if (ba.getBook_id() == bookId) {
                Author a = authorController.getAuthorById(ba.getAuthor_id());
                if (a != null) {
                    authorList.add(a);
                }
            }
        }
        return authorList;
    }
    public List<Book> getBooksOfAuthor(int authorId) {
        BookController bookController = new BookController();

        List<BookAuthor> bookAuthorList = getAllBookAuthor();
        List<Book> bookList = new ArrayList<>();

        for (BookAuthor ba : bookAuthorList) {
            if (ba.getAuthor_id() == authorId) {
                Book b = bookController.getBookById(ba.getBook_id());
                if (b != null) {
                    bookList.add(b);
                }
            }
        }
        return bookList;
    }
    public void deleteBookAuthor(int book_author_id) {
        String sql =  "DELETE FROM book_author WHERE book_author_id = ?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {
            ps.setInt(1,book_author_id);

            ps.executeUpdate();

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }
    }
}
