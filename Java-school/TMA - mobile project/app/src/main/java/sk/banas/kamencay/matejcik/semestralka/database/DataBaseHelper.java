package sk.banas.kamencay.matejcik.semestralka.database;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import androidx.annotation.Nullable;

import java.util.ArrayList;
import java.util.List;

public class DataBaseHelper extends SQLiteOpenHelper {

    private static final int DATABASE_VERSION = 14;

    public static final String DATABASE_NAME = "database.db";

    public static final String USER_TABLE_NAME = "USER_TABLE";
    public static final String USER_TABLE_ID = "ID";
    public static final String USER_TABLE_COLUMN_NAME = "NAME";
    public static final String USER_TABLE_COLUMN_PASSWORD = "PASSWORD";
    public static final String USER_TABLE_COLUMN_HEIGHT = "HEIGHT";
    public static final String USER_TABLE_COLUMN_WEIGHT = "WEIGHT";
    public static final String USER_TABLE_COLUMN_BIRTH_DATE = "BIRTH";
    public static final String USER_TABLE_COLUMN_GENDER = "GENDER";

    public static final String ACTIVITY_TABLE_NAME = "ACTIVITY_TABLE";
    public static final String ACTIVITY_TABLE_ID = "ID";
    public static final String ACTIVITY_TABLE_COLUMN_NAME = "NAME";
    public static final String ACTIVITY_TABLE_COLUMN_START = "START_POINT";
    public static final String ACTIVITY_TABLE_COLUMN_END = "END_POINT";
    public static final String ACTIVITY_TABLE_COLUMN_DISTANCE = "DISTANCE";
    public static final String ACTIVITY_TABLE_COLUMN_POINTS = "POINTS"; // pocet zastavok
    public static final String ACTIVITY_TABLE_COLUMN_DIFFICULTY = "DIFFICULTY";

    public static final String USER_ACTIVITY_TABLE_NAME ="USER_ACTIVITY_TABLE";
    public static final String USER_ACTIVITY_TABLE_ID ="ID";
    public static final String USER_ACTIVITY_TABLE_ID_USER ="ID_USER";
    public static final String USER_ACTIVITY_TABLE_ID_ACTIVITY ="ID_ACTIVITY";
    public static final String USER_ACTIVITY_TABLE_STATE ="STATE";
    public static final String USER_ACTIVITY_TABLE_NEW_POINT ="NEW_POINT";


    public DataBaseHelper(@Nullable Context context) {
        super(context, DATABASE_NAME, null,DATABASE_VERSION);
    }

    // volane prvy raz ked pristupujeme k db
    @Override
    public void onCreate(SQLiteDatabase sqLiteDatabase) {
        {
        String createUserTableStatement = "CREATE TABLE " + USER_TABLE_NAME +
                " (" + USER_TABLE_ID + " INTEGER PRIMARY KEY AUTOINCREMENT," +
                USER_TABLE_COLUMN_NAME + " TEXT NOT NULL," +
                USER_TABLE_COLUMN_PASSWORD + " TEXT NOT NULL," +
                USER_TABLE_COLUMN_HEIGHT + " REAL NOT NULL," +
                USER_TABLE_COLUMN_WEIGHT + " REAL NOT NULL," +
                USER_TABLE_COLUMN_BIRTH_DATE + " TEXT NOT NULL," +
                USER_TABLE_COLUMN_GENDER + " INTEGER NOT NULL)";

        String createActivityTableStatement = "CREATE TABLE " + ACTIVITY_TABLE_NAME +
                " (" + ACTIVITY_TABLE_ID + " INTEGER PRIMARY KEY AUTOINCREMENT," +
                ACTIVITY_TABLE_COLUMN_NAME + " TEXT NOT NULL, " +
                ACTIVITY_TABLE_COLUMN_START + " TEXT NOT NULL, " +
                ACTIVITY_TABLE_COLUMN_END + " TEXT NOT NULL, " +
                ACTIVITY_TABLE_COLUMN_DISTANCE + " REAL NOT NULL, " +
                ACTIVITY_TABLE_COLUMN_POINTS + " INTEGER NOT NULL, " +
                ACTIVITY_TABLE_COLUMN_DIFFICULTY + " INTEGER NOT NULL)";

        String createUserActivityTableStatement = "CREATE TABLE " + USER_ACTIVITY_TABLE_NAME +
                " (" + USER_ACTIVITY_TABLE_ID + " INTEGER PRIMARY KEY AUTOINCREMENT," +
                USER_ACTIVITY_TABLE_ID_USER + " INTEGER," +
                USER_ACTIVITY_TABLE_ID_ACTIVITY + " INTEGER," +
                USER_ACTIVITY_TABLE_STATE + " TEXT NOT NULL," +
                USER_ACTIVITY_TABLE_NEW_POINT + " TEXT," +
                " FOREIGN KEY(" + USER_ACTIVITY_TABLE_ID_USER + ") REFERENCES " + USER_TABLE_NAME + " (" + USER_TABLE_ID + ")," +
                " FOREIGN KEY(" + USER_ACTIVITY_TABLE_ID_ACTIVITY + ") REFERENCES " + USER_ACTIVITY_TABLE_NAME + " (" + USER_ACTIVITY_TABLE_ID + "))";

        sqLiteDatabase.execSQL(createUserTableStatement);
        sqLiteDatabase.execSQL(createActivityTableStatement);
        sqLiteDatabase.execSQL(createUserActivityTableStatement);
    } // vytvori vsetky databazy a vztahy medzi nimi
        {
            ContentValues cv = new ContentValues();
            User user = new User(-1, "user", "user", 180f, 100f, "", true);

            cv.put(USER_TABLE_COLUMN_NAME, user.getName());
            cv.put(USER_TABLE_COLUMN_PASSWORD, user.getPassword());
            cv.put(USER_TABLE_COLUMN_HEIGHT, user.getHeight());
            cv.put(USER_TABLE_COLUMN_WEIGHT, user.getWeight());
            cv.put(USER_TABLE_COLUMN_BIRTH_DATE, user.getBirthdate());
            cv.put(USER_TABLE_COLUMN_GENDER, user.isGender());

            sqLiteDatabase.insert(USER_TABLE_NAME, null, cv);

            cv.clear();

            Activity activityST = new Activity(-1,"S. Bystrica - Terchova","49.3463554 18.9372327","49.2583949 19.0248271",30.215f,4,2);

            cv.put(ACTIVITY_TABLE_COLUMN_NAME, activityST.getName());
            cv.put(ACTIVITY_TABLE_COLUMN_START, activityST.getStartPoint());
            cv.put(ACTIVITY_TABLE_COLUMN_END, activityST.getEndPoint());
            cv.put(ACTIVITY_TABLE_COLUMN_DISTANCE, activityST.getDistance());
            cv.put(ACTIVITY_TABLE_COLUMN_POINTS, activityST.getPoints());
            cv.put(ACTIVITY_TABLE_COLUMN_DIFFICULTY, activityST.getDifficulty());

            sqLiteDatabase.insert(ACTIVITY_TABLE_NAME, null, cv);

            cv.clear();

            Activity activityKT = new Activity(-1,"Krasy Terchovej","49.2576803 19.0302318","49.2564303 19.0655386",7.41f,3,3);

            cv.put(ACTIVITY_TABLE_COLUMN_NAME, activityKT.getName());
            cv.put(ACTIVITY_TABLE_COLUMN_START, activityKT.getStartPoint());
            cv.put(ACTIVITY_TABLE_COLUMN_END, activityKT.getEndPoint());
            cv.put(ACTIVITY_TABLE_COLUMN_DISTANCE, activityKT.getDistance());
            cv.put(ACTIVITY_TABLE_COLUMN_POINTS, activityKT.getPoints());
            cv.put(ACTIVITY_TABLE_COLUMN_DIFFICULTY, activityKT.getDifficulty());

            sqLiteDatabase.insert(ACTIVITY_TABLE_NAME, null, cv);


            cv.clear();

            Activity activityS = new Activity(-1,"Vysoke Tatry","49.1392134 20.2213451","49.1865587 20.2309312",15.3f,3,5);

            cv.put(ACTIVITY_TABLE_COLUMN_NAME, activityS.getName());
            cv.put(ACTIVITY_TABLE_COLUMN_START, activityS.getStartPoint());
            cv.put(ACTIVITY_TABLE_COLUMN_END, activityS.getEndPoint());
            cv.put(ACTIVITY_TABLE_COLUMN_DISTANCE, activityS.getDistance());
            cv.put(ACTIVITY_TABLE_COLUMN_POINTS, activityS.getPoints());
            cv.put(ACTIVITY_TABLE_COLUMN_DIFFICULTY, activityS.getDifficulty());

            sqLiteDatabase.insert(ACTIVITY_TABLE_NAME, null, cv);

            cv.clear();

            Activity activityK = new Activity(-1,"Kosice inak","48.7484235 21.2539062","48.6969440 21.2217021",68.3f,6,1);

            cv.put(ACTIVITY_TABLE_COLUMN_NAME, activityK.getName());
            cv.put(ACTIVITY_TABLE_COLUMN_START, activityK.getStartPoint());
            cv.put(ACTIVITY_TABLE_COLUMN_END, activityK.getEndPoint());
            cv.put(ACTIVITY_TABLE_COLUMN_DISTANCE, activityK.getDistance());
            cv.put(ACTIVITY_TABLE_COLUMN_POINTS, activityK.getPoints());
            cv.put(ACTIVITY_TABLE_COLUMN_DIFFICULTY, activityK.getDifficulty());

            sqLiteDatabase.insert(ACTIVITY_TABLE_NAME, null, cv);

            Activity activityT = new Activity(-1,"Teryho chata","49.1392134 20.2213451","49.1903078 20.2010457",32.3f,4,5);

            cv.put(ACTIVITY_TABLE_COLUMN_NAME, activityT.getName());
            cv.put(ACTIVITY_TABLE_COLUMN_START, activityT.getStartPoint());
            cv.put(ACTIVITY_TABLE_COLUMN_END, activityT.getEndPoint());
            cv.put(ACTIVITY_TABLE_COLUMN_DISTANCE, activityT.getDistance());
            cv.put(ACTIVITY_TABLE_COLUMN_POINTS, activityT.getPoints());
            cv.put(ACTIVITY_TABLE_COLUMN_DIFFICULTY, activityT.getDifficulty());

            sqLiteDatabase.insert(ACTIVITY_TABLE_NAME, null, cv);


            String [] nazvy = {"Velky Rozsutec","Saris","Zilina a okolie","Nitra a okolie","Potulky po BA","Krasy Cadce","Banska Stiavnica","Trenciniansky hrad","Strecno a okolie","Kostoly Trnavy","Po Dunaji","Komarno","Lietava a okolie","Presov","Po Vahu","Orava inak"};

            for (int i = 0 ; i < 10; i++) {
                cv.clear();

                Activity activity3 = new Activity(-1,nazvy[i],"4"+i+".44 18.8","49.44 1"+i+".78",51f+i,2+i,i%4);

                cv.put(ACTIVITY_TABLE_COLUMN_NAME, activity3.getName());
                cv.put(ACTIVITY_TABLE_COLUMN_START, activity3.getStartPoint());
                cv.put(ACTIVITY_TABLE_COLUMN_END, activity3.getEndPoint());
                cv.put(ACTIVITY_TABLE_COLUMN_DISTANCE, activity3.getDistance());
                cv.put(ACTIVITY_TABLE_COLUMN_POINTS, activity3.getPoints());
                cv.put(ACTIVITY_TABLE_COLUMN_DIFFICULTY, activity3.getDifficulty());

                sqLiteDatabase.insert(ACTIVITY_TABLE_NAME, null, cv);
            }




        } // vytvori cvicneho uzivatela na test a cvicne aktivity


    }

    @Override
    public void onUpgrade(SQLiteDatabase sqLiteDatabase, int i, int i1) {
        if (i1 > i) {
            //TODO tieto zmazania db zrusit, je to tu len nateraz, kym sa databaza casto a vyrazne meni
            sqLiteDatabase.execSQL("DROP TABLE IF EXISTS " + USER_TABLE_NAME);
            sqLiteDatabase.execSQL("DROP TABLE IF EXISTS " + ACTIVITY_TABLE_NAME);
            sqLiteDatabase.execSQL("DROP TABLE IF EXISTS " + USER_ACTIVITY_TABLE_NAME);
            onCreate(sqLiteDatabase); // ak sa zisti, ze sa zvacsila verzia db, tak sa zavola
        }
    }

    // zisti, ci sa pouzivatelske meno uz nachadza v tabulke
    public boolean isUserNameUnique(String name) {
        List<User> returnList = getAllUsers();
        if (returnList.size() > 0) {
            for (User user : returnList) {
                if (user.getName().equals(name)) {
                    return false; // mena sa rovnaju
                }
            }
        }
        return true;
    }
    // zisti, ci sa pouzivatel nachadza v tabulke pomocou mena a hesla ; vrati ID pouzivatela ( -1 ak neexistuje)
    public int loginUser(User user) {
        String name = user.getName();
        String password = user.getPassword();
        int userID = -1;
        if (name.length() > 0 && password.length() > 0) {
            String queryString = "SELECT * FROM " +  USER_TABLE_NAME + " WHERE " + USER_TABLE_COLUMN_NAME + " = '" + name + "'" + " AND " +  USER_TABLE_COLUMN_PASSWORD + " = '" + password + "'"; // get data from database
            SQLiteDatabase db = this.getReadableDatabase();
            Cursor cursor = db.rawQuery(queryString,null);
            boolean findUserInDb = cursor.moveToFirst();
            if (findUserInDb) {
                userID = cursor.getInt(0);
            }
            cursor.close();
            db.close();
            return userID;
        }
        return userID;
    }
    // prida pozivatela do tabulky
    public boolean insertUser(User user) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues cv = new ContentValues();

        cv.put(USER_TABLE_COLUMN_NAME, user.getName());
        cv.put(USER_TABLE_COLUMN_PASSWORD, user.getPassword());
        cv.put(USER_TABLE_COLUMN_HEIGHT,user.getHeight());
        cv.put(USER_TABLE_COLUMN_WEIGHT,user.getWeight());
        cv.put(USER_TABLE_COLUMN_BIRTH_DATE,user.getBirthdate());
        cv.put(USER_TABLE_COLUMN_GENDER, user.isGender());

        long insert = db.insert(USER_TABLE_NAME, null, cv);
        db.close();
        if (insert == -1) {
            return false;
        }
        return true;
    }
    // vrati vsetky zaznamy o pouzivateloch
    public List<User> getAllUsers() {
        List<User> returnList = new ArrayList<>();

        String queryString = "SELECT * FROM " + USER_TABLE_NAME; // get data from database

        SQLiteDatabase db = this.getReadableDatabase();

        Cursor cursor = db.rawQuery(queryString,null);

        if (cursor.moveToFirst()) { // vrati true, ak je tam vysledok nejaky
            do {
                int userID = cursor.getInt(0);
                String userName = cursor.getString(1);
                String userPassword = cursor.getString(2);
                Float userHeight = cursor.getFloat(3);
                Float userWeight = cursor.getFloat(4);
                String userBirthDate = cursor.getString(5);
                boolean userGender = cursor.getInt(6) == 1;

                User user = new User(userID,userName,userPassword,userHeight,userWeight,userBirthDate,userGender);
                returnList.add(user);
            } while (cursor.moveToNext());
        } else {
            // ziadny
        }
        cursor.close();
        db.close();
        return returnList;
    }
    // vrati pouzivatela podla ID
    public User getUserByID(int id) {
        String queryString = "SELECT * FROM " + USER_TABLE_NAME + " WHERE " + USER_TABLE_ID + " = " + String.valueOf(id); // get data from database
        Cursor cursor = this.getReadableDatabase().rawQuery(queryString,null);
        User user = null;
        if (cursor.moveToFirst()) { // vrati true, ak je tam vysledok nejaky
            int userID = cursor.getInt(0);
            String userName = cursor.getString(1);
            String userPassword = cursor.getString(2);
            Float userHeight = cursor.getFloat(3);
            Float userWeight = cursor.getFloat(4);
            String userBirthDate = cursor.getString(5);
            boolean userGender = cursor.getInt(6) == 1;
            user = new User(userID,userName,userPassword,userHeight,userWeight,userBirthDate,userGender);
        }
        cursor.close();
        return user;
    }
    // updatne info o userovi podla ID
    public boolean updateUserByID(int id, User user) {
        if (user == null) {
            return false;
        }
        ContentValues cv = new ContentValues();
        cv.put(USER_TABLE_COLUMN_NAME, user.getName());
        cv.put(USER_TABLE_COLUMN_PASSWORD, user.getPassword());
        cv.put(USER_TABLE_COLUMN_HEIGHT,user.getHeight());
        cv.put(USER_TABLE_COLUMN_WEIGHT,user.getWeight());
        cv.put(USER_TABLE_COLUMN_BIRTH_DATE,user.getBirthdate());
        cv.put(USER_TABLE_COLUMN_GENDER, user.isGender());

        this.getWritableDatabase().update(USER_TABLE_NAME,cv,"id = ?",new String[]{String.valueOf(id)});
        return true;
    }

    public List<Activity> getAllActivities() {
        List<Activity> returnList = new ArrayList<>();

        String queryString = "SELECT * FROM " + ACTIVITY_TABLE_NAME; // get data from database

        SQLiteDatabase db = this.getReadableDatabase();

        Cursor cursor = db.rawQuery(queryString,null);

        if (cursor.moveToFirst()) { // vrati true, ak je tam vysledok nejaky
            do {
                int activityId = cursor.getInt(0);
                String activityName = cursor.getString(1);
                String activityStartPoint = cursor.getString(2);
                String activityEndPoint = cursor.getString(3);
                Float activityDistance = cursor.getFloat(4);
                Integer activityPoints = cursor.getInt(5);
                Integer activityDifficulty = cursor.getInt(6);

                Activity activity = new Activity(activityId,activityName,activityStartPoint,activityEndPoint,activityDistance,activityPoints,activityDifficulty);
                returnList.add(activity);
            } while (cursor.moveToNext());
        }

        cursor.close();
        db.close();
        return returnList;
    }

    public boolean insertUserActivity(UserActivity userActivity) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues cv = new ContentValues();

        cv.put(USER_ACTIVITY_TABLE_ID_USER, userActivity.getId_user());
        cv.put(USER_ACTIVITY_TABLE_ID_ACTIVITY, userActivity.getId_activity());
        cv.put(USER_ACTIVITY_TABLE_STATE,userActivity.getState());
        cv.put(USER_ACTIVITY_TABLE_NEW_POINT,userActivity.getNewPoint());

        long insert = db.insert(USER_ACTIVITY_TABLE_NAME, null, cv);
        db.close();
        if (insert == -1) {
            return false;
        }
        return true;
    }
    public boolean isActivityChoosed(int activityId, int userId) {
        String queryString = "SELECT * FROM " + USER_ACTIVITY_TABLE_NAME + " WHERE " + USER_ACTIVITY_TABLE_ID_ACTIVITY + " = " + activityId + " AND " + USER_ACTIVITY_TABLE_ID_USER + " = " + userId; // get data from database

        SQLiteDatabase db = this.getReadableDatabase();

        Cursor cursor = db.rawQuery(queryString,null);
        boolean result = cursor.moveToFirst();

        cursor.close();
        db.close();
        return result;


    }
    public Activity getActivityByID(int activityId) {
        List<Activity> allActivities = getAllActivities();
        for (Activity a: allActivities) {
            if (a.getId() == activityId) {
                return a;
            }
        }
        return null;
    }

    public List<Activity> getAllActivitiesWithState(int userId, ActivityStatesEnum state) {
        List<Activity> returnList = new ArrayList<>();

        String queryString = "SELECT * FROM " + ACTIVITY_TABLE_NAME + " WHERE " + ACTIVITY_TABLE_ID + " IN " +
                "(SELECT " + USER_ACTIVITY_TABLE_ID_ACTIVITY + " FROM " + USER_ACTIVITY_TABLE_NAME +
                " WHERE " + USER_ACTIVITY_TABLE_ID_USER + " = " + userId + " AND " + USER_ACTIVITY_TABLE_STATE + " = '" + state.toString() + "')";

        SQLiteDatabase db = this.getReadableDatabase();

        Cursor cursor = db.rawQuery(queryString,null);

        if (cursor.moveToFirst()) { // vrati true, ak je tam vysledok nejaky
            do {
                int activityId = cursor.getInt(0);
                String activityName = cursor.getString(1);
                String activityStartPoint = cursor.getString(2);
                String activityEndPoint = cursor.getString(3);
                Float activityDistance = cursor.getFloat(4);
                Integer activityPoints = cursor.getInt(5);
                Integer activityDifficulty = cursor.getInt(6);

                Activity activity = new Activity(activityId,activityName,activityStartPoint,activityEndPoint,activityDistance,activityPoints,activityDifficulty);
                returnList.add(activity);
            } while (cursor.moveToNext());
        }

        cursor.close();
        db.close();
        return returnList;
    }

    public void deleteUserActivity(int userId, String activityId) {
        SQLiteDatabase db = this.getWritableDatabase();
        String sql = "DELETE FROM " + USER_ACTIVITY_TABLE_NAME + " WHERE " + USER_ACTIVITY_TABLE_ID_USER + " = " + userId + " AND " + USER_ACTIVITY_TABLE_ID_ACTIVITY + " = " + activityId;
        db.execSQL(sql);
        db.close();
    }

    public void updateUserActivity(int userId, int activityId, ActivityStatesEnum newState, String newPoint) {
        ContentValues cv = new ContentValues();
        cv.put(USER_ACTIVITY_TABLE_STATE, newState.toString());
        cv.put(USER_ACTIVITY_TABLE_NEW_POINT, newPoint);

        this.getWritableDatabase().update(USER_ACTIVITY_TABLE_NAME,cv,USER_ACTIVITY_TABLE_ID_USER + " = ? AND " + USER_ACTIVITY_TABLE_ID_ACTIVITY + " = ?",new String[]{String.valueOf(userId),String.valueOf(activityId)});
    }

    public List<UserActivity> getAllUserActivity() {
        List<UserActivity> returnList = new ArrayList<>();

        String queryString = "SELECT * FROM " + USER_ACTIVITY_TABLE_NAME; // get data from database

        SQLiteDatabase db = this.getReadableDatabase();

        Cursor cursor = db.rawQuery(queryString,null);

        if (cursor.moveToFirst()) { // vrati true, ak je tam vysledok nejaky
            do {
                int id = cursor.getInt(0);
                int idUser = cursor.getInt(1);
                int idActivity = cursor.getInt(2);
                String state = cursor.getString(3);
                String newPoint = cursor.getString(4);

                UserActivity userActivity = new UserActivity(id,idUser,idActivity,state,newPoint);
                returnList.add(userActivity);
            } while (cursor.moveToNext());
        }

        cursor.close();
        db.close();
        return returnList;
    }
    public UserActivity getUserActivity(int userId, int activityId) {
        List<UserActivity> userActivities = getAllUserActivity();
        for (UserActivity ua : userActivities) {
            if (ua.getId_user() == userId && ua.getId_activity() == activityId) {
                return ua;
            }
        }
        return null;
    }
}
