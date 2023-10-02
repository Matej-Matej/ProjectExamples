package sk.banas.kamencay.matejcik.semestralka.example.activity;

public class ActivityCell {

    private String id;
    private String activityId;
    private String name;
    private String points;
    private String distance;
    private String difficulty;

    public ActivityCell(String id, String activityId, String name, String points, String distance, String difficulty) {
        this.id = id;
        this.activityId = activityId;
        this.name = name;
        this.points = points;
        this.distance = distance;
        this.difficulty = difficulty;
    }

    public String getActivityId() {
        return activityId;
    }

    public void setActivityId(String activityId) {
        this.activityId = activityId;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPoints() {
        return points;
    }

    public void setPoints(String points) {
        this.points = points;
    }

    public String getDistance() {
        return distance;
    }

    public void setDistance(String distance) {
        this.distance = distance;
    }

    public String getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(String difficulty) {
        this.difficulty = difficulty;
    }
}
