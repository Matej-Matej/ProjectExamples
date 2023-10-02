package sk.matejcik.SemestralnaPraca.AuthorChange;

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
import java.sql.Date;
import java.util.List;

public class AuthorChangeController {

    public List<AuthorChange> getAllAuthorChange() {
        List<AuthorChange> authorChangeList = new ArrayList<>();
        String sql = "SELECT * FROM author_change";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {
            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                authorChangeList.add(new AuthorChange(
                        resultSet.getInt("author_change_id"),
                        new Author(
                                resultSet.getInt("author_id"),
                                resultSet.getString("name"),
                                resultSet.getString("last_name"),
                                resultSet.getDate("birth_date"),
                                resultSet.getDate("death_date"),
                                resultSet.getString("picture"),
                                resultSet.getString("biography"),
                                resultSet.getString("birth_place")
                        )
                ));
            }

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }
        return authorChangeList;
    }
    public int insertAuthorChange(AuthorChange authorChange) {
        String sql = "INSERT INTO author_change (author_id,name,last_name,birth_date,death_date,picture,biography,birth_place) VALUES (?,?,?,?,?,?,?,?)";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {
            Date date = authorChange.getAuthor().getDeathDate();
            if (date == null) {
                date =  new Date(800,1,1);
            }
            ps.setInt(1,authorChange.getAuthor().getAuthor_id());
            ps.setString(2,authorChange.getAuthor().getName());
            ps.setString(3,authorChange.getAuthor().getLastname());
            ps.setDate(4,authorChange.getAuthor().getBirthDate());
            ps.setDate(5,date);
            ps.setString(6,authorChange.getAuthor().getPicture());
            ps.setString(7,authorChange.getAuthor().getBiography());
            ps.setString(8,authorChange.getAuthor().getBirthPlace());

            return ps.executeUpdate();
        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }
    public int deleteAuthorChange(int authorChangeId) {
        String sql =  "DELETE FROM author_change WHERE author_change_id = ?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {

            ps.setInt(1,authorChangeId);

            return ps.executeUpdate();

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    public AuthorChange getAuthorChange(int authorChangeId) {
        List<AuthorChange> authorChangeList = getAllAuthorChange();
        for (AuthorChange ac : authorChangeList) {
            if (ac.getAuthor_change_id() == authorChangeId) {
                return ac;
            }
        }
        return null;
    }

}
