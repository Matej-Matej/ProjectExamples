package sk.matejcik.SemestralnaPraca.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class UserChecker {

    public static boolean isUserLogged(HttpServletRequest request) {
        return request.getSession().getAttribute("user") != null;
    }
    public static boolean isUserAdmin(HttpServletRequest request) {
        User user = getLoggedUser(request);
        if (user == null) {
            return false;
        } else {
            return user.getRole().equals(UserRoleEnum.ADMIN.toString());
        }
    }
    public static User getLoggedUser(HttpServletRequest request) {
        if (isUserLogged(request)) {
            return (User) request.getSession().getAttribute("user");
        }
        return null;
    }
}
