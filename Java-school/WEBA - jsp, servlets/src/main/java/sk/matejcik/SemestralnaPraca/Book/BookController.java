package sk.matejcik.SemestralnaPraca.Book;

import sk.matejcik.SemestralnaPraca.Author.Author;
import sk.matejcik.SemestralnaPraca.BookAuthor.BookAuthor;
import sk.matejcik.SemestralnaPraca.BookAuthor.BookAuthorController;
import sk.matejcik.SemestralnaPraca.BookCategory.BookCategory;
import sk.matejcik.SemestralnaPraca.BookCategory.BookCategoryController;
import sk.matejcik.SemestralnaPraca.BookState.BookState;
import sk.matejcik.SemestralnaPraca.BookState.BookStateController;
import sk.matejcik.SemestralnaPraca.Category.Category;
import sk.matejcik.SemestralnaPraca.Category.CategoryController;
import sk.matejcik.SemestralnaPraca.Helpers.DatabaseConnectionManager;

import javax.naming.NamingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookController {

    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM book ORDER BY name ASC";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {
            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                books.add(new Book(
                        resultSet.getInt("book_id"),
                        resultSet.getString("name"),
                        resultSet.getString("content"),
                        resultSet.getInt("page_count"),
                        resultSet.getInt("year"),
                        resultSet.getString("publisher"),
                        resultSet.getString("isbn"),
                        resultSet.getString("picture")
                ));
            }

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    public int insertBook(Book book) {
        String sql = "INSERT INTO book (name,content, page_count, year, publisher, isbn, picture) VALUES (?,?,?,?,?,?,?)";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {
            ps.setString(1,book.getName());
            ps.setString(2,book.getContent());
            ps.setInt(3,book.getPage_count());
            ps.setInt(4,book.getYear());
            ps.setString(5,book.getPublisher());
            ps.setString(6,book.getIsbn());
            ps.setString(7,book.getPicture());

            return ps.executeUpdate();
        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }
    public Book getBookWithName(String name) {
        List<Book> allBooks = getAllBooks();
        for (Book b : allBooks) {
            if (b.getName().equals(name)) {
                return b;
            }
        }
        return null;
    }
    public List<Book> getAllBooksByCategoryId(int categoryId) {
        List<Book> allBooks = getAllBooks();
        BookCategoryController bookCategoryController = new BookCategoryController();
        List<Integer> booksIdInteger = bookCategoryController.getAllBooksIdByCategoryId(categoryId);
        List<Book> ourBooksList = new ArrayList<>();

        for (Book b : allBooks) {
            for (Integer i : booksIdInteger) {
                if (b.getBook_id() == i) {
                    ourBooksList.add(b);
                }
            }
        }

        return ourBooksList;
    }
    public Book getBookById(int bookId) {
        List<Book> books = getAllBooks();
        for (Book b : books) {
            if (b.getBook_id() == bookId) {
                return b;
            }
        }
        return null;
    }
    public int deleteBook(int bookId) {
        BookAuthorController bookAuthorController = new BookAuthorController();
        List<BookAuthor> bookAuthorList = bookAuthorController.getAllBookAuthor();

        for (BookAuthor ba : bookAuthorList) {
            if (ba.getBook_id() == bookId) {
                bookAuthorController.deleteBookAuthor(ba.getBook_author_id());
            }
        }

        BookCategoryController bookCategoryController = new BookCategoryController();
        List<BookCategory> bookCategoryList = bookCategoryController.getAllBookCategory();

        for (BookCategory bc : bookCategoryList) {
            if (bc.getBook_id() == bookId) {
                bookCategoryController.deleteBookCategory(bc.getBook_category_id());
            }
        }

        BookStateController bookStateController = new BookStateController();
        List<BookState> bookStateList = bookStateController.getAllBookState();

        for (BookState bs : bookStateList) {
            if (bs.getBook_id() == bookId) {
                bookStateController.deleteBookState(bs.getBook_state_id());
            }
        }

        String sql =  "DELETE FROM book WHERE book_id = ?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {

            ps.setInt(1,bookId);

            return ps.executeUpdate();

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    public void updateBook(Book book) {
        String sql = "UPDATE book SET name = ?,content = ?,page_count = ?,year = ?,publisher = ?,isbn = ?,picture = ? WHERE book_id = ?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {
            ps.setString(1,book.getName());
            ps.setString(2,book.getContent());
            ps.setInt(3,book.getPage_count());
            ps.setInt(4,book.getYear());
            ps.setString(5,book.getPublisher());
            ps.setString(6,book.getIsbn());
            ps.setString(7,book.getPicture());
            ps.setInt(8,book.getBook_id());

            ps.executeUpdate();
        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }
    }
    public List<Book> getAllUserBooksWithState(int userId, String state) {
        List<Book> books = new ArrayList<>();
        String sql = "select * from book where book_id in ( select book_id from book_state where user_id=? and state=?)  ORDER BY name ASC";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {
            ps.setInt(1,userId);
            ps.setString(2,state);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                books.add(new Book(
                        resultSet.getInt("book_id"),
                        resultSet.getString("name"),
                        resultSet.getString("content"),
                        resultSet.getInt("page_count"),
                        resultSet.getInt("year"),
                        resultSet.getString("publisher"),
                        resultSet.getString("isbn"),
                        resultSet.getString("picture")
                ));
            }

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
}
