package sk.matejcik.SemestralnaPraca.BookCategory;

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

public class BookCategoryController {

    public List<BookCategory> getAllBookCategory() {
        List<BookCategory> bookCategory = new ArrayList<>();
        String sql = "SELECT * FROM book_category";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {
            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                bookCategory.add(new BookCategory(
                        resultSet.getInt("book_category_id"),
                        resultSet.getInt("book_id"),
                        resultSet.getInt("category_id")
                ));
            }
        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }
        return bookCategory;
    }
    public int insertBookCategory(BookCategory bookCategory) {
        String sql = "INSERT INTO book_category (book_id,category_id) VALUES (?,?)";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {
            ps.setInt(1,bookCategory.getBook_id());
            ps.setInt(2,bookCategory.getCategory_id());

            return ps.executeUpdate();
        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }
    public List<Integer> getAllBooksIdByCategoryId(int categoryId) {
        CategoryController categoryController = new CategoryController();
        List<Category> categoryList = categoryController.getAllCategories();

        List<BookCategory> bookCategoryList = getAllBookCategory();
        List<Integer> booksId = new ArrayList<>();

        for (BookCategory bc : bookCategoryList) {
            if (bc.getCategory_id() == categoryId) {
                booksId.add(bc.getBook_id());
            }
        }
        return booksId;
    }
    public List<Category> getCategoriesOfBook(int bookId) {
        CategoryController categoryController = new CategoryController();

        List<BookCategory> bookCategoryList = getAllBookCategory();
        List<Category> categoryList = new ArrayList<>();

        for (BookCategory bc : bookCategoryList) {
            if (bc.getBook_id() == bookId) {
                Category c = categoryController.getCategoryById(bc.getCategory_id());
                if (c != null) {
                    categoryList.add(c);
                }
            }
        }
        return categoryList;
    }
    public void deleteBookCategory(int book_category_id) {
        String sql =  "DELETE FROM book_category WHERE book_category_id = ?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {
            ps.setInt(1,book_category_id);

            ps.executeUpdate();

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }
    }
}
