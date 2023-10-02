package sk.matejcik.SemestralnaPraca.User;

import sk.matejcik.SemestralnaPraca.Category.Category;
import sk.matejcik.SemestralnaPraca.Helpers.DatabaseConnectionManager;

import javax.naming.NamingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserController {

    public int insertUser(User user) {
        String sql = "INSERT INTO user (name,lastname,password,email,picture,role) VALUES (?,?,?,?,?,?)";
        try (
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
        ) {
            ps.setString(1,user.getName());
            ps.setString(2,user.getLastname());
            ps.setString(3,user.getPassword());
            ps.setString(4,user.getEmail());
            ps.setString(5,user.getPicture());
            ps.setString(6,user.getRole().toString());

            return ps.executeUpdate();
        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }
    public List<User> getAllUser() {
        List<User> userList = new ArrayList<>();
        String sql = "SELECT * FROM user ORDER BY name ASC";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {
            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                userList.add(new User(
                        resultSet.getInt("user_id"),
                        resultSet.getString("name"),
                        resultSet.getString("lastname"),
                        resultSet.getString("password"),
                        resultSet.getString("email"),
                        resultSet.getString("picture"),
                        resultSet.getString("role")

                        )
                );
            }

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }
    public User getUserById(int userId) {
        List<User> userList = getAllUser();

        for (User u : userList) {
            if (u.getUser_id() == userId) {
                return u;
            }
        }
        return null;
    }
    public User getUser(String email) {
        User user = null;
        String sql = "SELECT * FROM user WHERE email = ?";

        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {
            ps.setString(1,email);
            ResultSet resultSet = ps.executeQuery();
            while (resultSet.next()) {
                user = new User(
                        resultSet.getInt("user_id"),
                        resultSet.getString("name"),
                        resultSet.getString("lastname"),
                        resultSet.getString("password"),
                        resultSet.getString("email"),
                        resultSet.getString("picture"),
                        resultSet.getString("role")
                );
            }
        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }

        return user;
    }
    public List<String> getAllEmails() {
        List<String> emails = new ArrayList<>();
        String sql = "SELECT email FROM user";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {
            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                emails.add(resultSet.getString("email"));
            }

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }
        return emails;
    }

}
