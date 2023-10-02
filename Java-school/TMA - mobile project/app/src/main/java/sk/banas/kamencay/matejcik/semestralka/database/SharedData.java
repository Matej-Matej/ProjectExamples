package sk.banas.kamencay.matejcik.semestralka.database;

import android.content.Context;
import android.content.SharedPreferences;
import android.widget.Toast;

public class SharedData {

    public static final String SHARED_PREFERENCES = "shared_preferences";
    public static final String SP_ID = "user_id";


    public static void saveLoggedUser(Context context, int userID){
        SharedPreferences sharedPreferences = context.getSharedPreferences(SHARED_PREFERENCES,Context.MODE_PRIVATE); // ziadna ina aplikacia nemoze zmenit nase SP
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.putInt(SP_ID,userID);
        editor.apply();
    }

    public static int loadLoggedUser(Context context) {
        SharedPreferences sharedPreferences = context.getSharedPreferences(SHARED_PREFERENCES,Context.MODE_PRIVATE); // ziadna ina aplikacia nemoze zmenit nase SP
        return sharedPreferences.getInt(SP_ID,-1);
    }

}
