package sk.banas.kamencay.matejcik.semestralka.database;

public class UserActivity {

    private int id;
    private int id_user;
    private int id_activity;
    private String state;
    private String newPoint;

    public UserActivity(int id, int id_user, int id_activity, String state, String newPoint) {
        this.id = id;
        this.id_user = id_user;
        this.id_activity = id_activity;
        this.state = state;
        this.newPoint = newPoint;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_user() {
        return id_user;
    }

    public void setId_user(int id_user) {
        this.id_user = id_user;
    }

    public int getId_activity() {
        return id_activity;
    }

    public void setId_activity(int id_activity) {
        this.id_activity = id_activity;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getNewPoint() {
        return newPoint;
    }

    public void setNewPoint(String newPoint) {
        this.newPoint = newPoint;
    }
}
