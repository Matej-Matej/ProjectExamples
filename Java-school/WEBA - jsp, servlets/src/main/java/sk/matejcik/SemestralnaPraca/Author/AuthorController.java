package sk.matejcik.SemestralnaPraca.Author;

import sk.matejcik.SemestralnaPraca.Book.Book;
import sk.matejcik.SemestralnaPraca.BookAuthor.BookAuthor;
import sk.matejcik.SemestralnaPraca.BookAuthor.BookAuthorController;
import sk.matejcik.SemestralnaPraca.BookCategory.BookCategoryController;
import sk.matejcik.SemestralnaPraca.Category.Category;
import sk.matejcik.SemestralnaPraca.Helpers.DatabaseConnectionManager;

import javax.naming.NamingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AuthorController {

    public List<Author> getAllAuthors() {
        List<Author> authors = new ArrayList<>();
        String sql = "SELECT * FROM author ORDER BY name ASC";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {
            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                authors.add(new Author(
                        resultSet.getInt("author_id"),
                        resultSet.getString("name"),
                        resultSet.getString("last_name"),
                        resultSet.getDate("birth_date"),
                        resultSet.getDate("death_date"),
                        resultSet.getString("picture"),
                        resultSet.getString("biography"),
                        resultSet.getString("birth_place")
                ));
            }

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }
        return authors;
    }
    public int insertAuthor(Author author) {
        String sql = "INSERT INTO author (name,last_name,birth_date,death_date,picture,biography,birth_place) VALUES (?,?,?,?,?,?,?)";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {
            ps.setString(1,author.getName());
            ps.setString(2,author.getLastname());
            ps.setDate(3,author.getBirthDate());
            ps.setDate(4,author.getDeathDate());
            ps.setString(5,author.getPicture());
            ps.setString(6,author.getBiography());
            ps.setString(7,author.getBirthPlace());

            return ps.executeUpdate();
        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }
    public Author getAuthorById(int authorId) {
        List<Author> authorList = getAllAuthors();
        for (Author a: authorList) {
            if (a.getAuthor_id() == authorId) {
                return a;
            }
        }
        return null;
    }
    public int deleteAuthor(int authorId) {
        BookAuthorController bookAuthorController = new BookAuthorController();
        List<BookAuthor> bookAuthorList = bookAuthorController.getAllBookAuthor();
        for (BookAuthor ba : bookAuthorList) {
            if (ba.getAuthor_id() == authorId) {
                bookAuthorController.deleteBookAuthor(ba.getBook_author_id());
            }
        }

        String sql =  "DELETE FROM author WHERE author_id = ?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {

            ps.setInt(1,authorId);

            return ps.executeUpdate();

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    public void updateAuthor(Author author) {
        String sql = "UPDATE author SET name = ?,last_name = ?,birth_date = ?,death_date = ?,picture = ?,biography = ?,birth_place = ? WHERE author_id = ?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {
            ps.setString(1,author.getName());
            ps.setString(2,author.getLastname());
            ps.setDate(3,author.getBirthDate());
            ps.setDate(4,author.getDeathDate());
            ps.setString(5,author.getPicture());
            ps.setString(6,author.getBiography());
            ps.setString(7,author.getBirthPlace());
            ps.setInt(8,author.getAuthor_id());

           ps.executeUpdate();
        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }
    }
}
