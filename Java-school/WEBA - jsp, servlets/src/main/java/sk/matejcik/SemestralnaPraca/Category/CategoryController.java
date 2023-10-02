package sk.matejcik.SemestralnaPraca.Category;

import sk.matejcik.SemestralnaPraca.BookAuthor.BookAuthor;
import sk.matejcik.SemestralnaPraca.BookAuthor.BookAuthorController;
import sk.matejcik.SemestralnaPraca.BookCategory.BookCategory;
import sk.matejcik.SemestralnaPraca.BookCategory.BookCategoryController;
import sk.matejcik.SemestralnaPraca.Helpers.DatabaseConnectionManager;
import sk.matejcik.SemestralnaPraca.User.User;

import javax.naming.NamingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryController {

    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM category ORDER BY name ASC";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {
            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                categories.add(new Category(resultSet.getInt("category_id"),resultSet.getString("name")));
            }

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }
    public int insertCategory(Category category) {
        String sql = "INSERT INTO category (name) VALUES (?)";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {
            ps.setString(1,category.getName());

            return ps.executeUpdate();
        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }
    public Category getCategoryById(int categoryId) {
        List<Category> categoryList = getAllCategories();
        for (Category c: categoryList) {
            if (c.getCategory_id() == categoryId) {
                return c;
            }
        }
        return null;
    }
    public int deleteCategory(int categoryId) {
        BookCategoryController bookCategoryController = new BookCategoryController();
        List<BookCategory> bookCategoryList = bookCategoryController.getAllBookCategory();

        for (BookCategory bc : bookCategoryList) {
            if (bc.getCategory_id() == categoryId) {
                bookCategoryController.deleteBookCategory(bc.getBook_category_id());
            }
        }

        String sql =  "DELETE FROM category WHERE category_id = ?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {

            ps.setInt(1,categoryId);

            return ps.executeUpdate();

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
