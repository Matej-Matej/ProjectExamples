package sk.banas.kamencay.matejcik.semestralka.example.activity;

import androidx.annotation.NonNull;
import androidx.appcompat.app.ActionBarDrawerToggle;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.core.view.GravityCompat;
import androidx.drawerlayout.widget.DrawerLayout;

import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;

import com.google.android.material.navigation.NavigationView;

import java.util.ArrayList;
import java.util.List;

import sk.banas.kamencay.matejcik.semestralka.MainActivity;
import sk.banas.kamencay.matejcik.semestralka.R;
import sk.banas.kamencay.matejcik.semestralka.database.Activity;
import sk.banas.kamencay.matejcik.semestralka.database.ActivityStatesEnum;
import sk.banas.kamencay.matejcik.semestralka.database.DataBaseHelper;
import sk.banas.kamencay.matejcik.semestralka.database.SharedData;
import sk.banas.kamencay.matejcik.semestralka.database.User;
import sk.banas.kamencay.matejcik.semestralka.database.UserActivity;
import sk.banas.kamencay.matejcik.semestralka.example.MapActivity;
import sk.banas.kamencay.matejcik.semestralka.example.logreg.LoginActivity;
import sk.banas.kamencay.matejcik.semestralka.example.profile.ShowProfileActivity;
import sk.banas.kamencay.matejcik.semestralka.example.qrScanner;

import sk.banas.kamencay.matejcik.semestralka.MainActivity;
import sk.banas.kamencay.matejcik.semestralka.example.clanky.blog;
import sk.banas.kamencay.matejcik.semestralka.example.logreg.LoginActivity;
import sk.banas.kamencay.matejcik.semestralka.example.logreg.RegisterActivity;
import sk.banas.kamencay.matejcik.semestralka.example.profile.ShowProfileActivity;
import sk.banas.kamencay.matejcik.semestralka.example.activity.ManageActivities;

public class ManageActivities extends AppCompatActivity implements DialogInterface.OnDismissListener, NavigationView.OnNavigationItemSelectedListener {

    private ImageView addActivity;

    private ListView activitiesList;
    private RadioButton rbCheckedActivities, rbStartedActivities, rbEndedActivities;
    private RadioGroup rgActivities;
    private TextView title;
    private DataBaseHelper dataBaseHelper;
    private User loggedUser;
    private ActivityStatesEnum currentState;

    //menu bar
    DrawerLayout drawerLayout;
    NavigationView navigationView;
    Toolbar toolbar;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_manage_activities);
        this.viewsInit();

        dataBaseHelper = new DataBaseHelper(getApplicationContext());

        loggedUser = dataBaseHelper.getUserByID(SharedData.loadLoggedUser(getApplicationContext()));
        if (loggedUser == null) {
            startActivity(new Intent(this, LoginActivity.class));
        }

        currentState = ActivityStatesEnum.CHOOSED;
        fillListWithActivities(currentState);

        this.rgActivities.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(RadioGroup radioGroup, int i) {
                if (i == rbCheckedActivities.getId()) {
                    currentState = ActivityStatesEnum.CHOOSED;
                    title.setText(R.string.activity_manage_title_checked);
                } else if (i == rbStartedActivities.getId()) {
                    currentState = ActivityStatesEnum.STARTED;
                    title.setText(R.string.activity_manage_title_started);
                } else {
                    currentState = ActivityStatesEnum.ENDED;
                    title.setText(R.string.activity_manage_title_ended);
                }
                fillListWithActivities(currentState);
            }
        });

        this.addActivity.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                openAllActivities();
            }
        });

        this.activitiesList.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                ActivityCell activityCell = (ActivityCell) activitiesList.getItemAtPosition(i);
                Activity activity = dataBaseHelper.getActivityByID(Integer.parseInt(activityCell.getActivityId()));
                if (activity != null) {
                    if (currentState == ActivityStatesEnum.CHOOSED) {
                        qrScanner.koordinacie("0 0 " +activity.getStartPoint());
                        startActivity(new Intent(getApplicationContext(), MapActivity.class));
                    }
                    if (currentState == ActivityStatesEnum.STARTED) {
                        UserActivity userActivity = dataBaseHelper.getUserActivity(loggedUser.getId(),activity.getId());
                        if (userActivity != null) {
                            qrScanner.koordinacie("0 0 " + userActivity.getNewPoint());
                            startActivity(new Intent(getApplicationContext(), MapActivity.class));
                        }
                    }

                }
            }
        });

        this.activitiesList.setOnItemLongClickListener(new AdapterView.OnItemLongClickListener() {
            @Override
            public boolean onItemLongClick(AdapterView<?> adapterView, View view, int i, long l) {
                ActivityCell activityCell = (ActivityCell) activitiesList.getItemAtPosition(i);
                dataBaseHelper.deleteUserActivity(loggedUser.getId(), activityCell.getActivityId());
                fillListWithActivities(currentState);
                return true;
            }
        });

        ////////////////////////////////////// HOOKS
        drawerLayout = findViewById(R.id.drawer_layout_manageactivities);
        navigationView = findViewById(R.id.nav_view);
        toolbar = findViewById(R.id.toolbarmenu);

        /////////////////////////////////////// TOOL BAR
        /*setSupportActionBar(toolbar);*/

        /////////////////////////// NAVIGATION DRAWER MENU
        navigationView.bringToFront();
        ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(this, drawerLayout, toolbar, R.string.navigation_drawer_open, R.string.navigation_drawer_closed);
        drawerLayout.addDrawerListener(toggle);
        toggle.syncState();

        navigationView.setNavigationItemSelectedListener(this);
    }

    @Override
    protected void onResume() {
        super.onResume();
        loggedUser = dataBaseHelper.getUserByID(SharedData.loadLoggedUser(getApplicationContext()));
        if (loggedUser == null) {
            startActivity(new Intent(this, LoginActivity.class));
        }
        fillListWithActivities(currentState);
    }
    public void onBackPressed(){
        if (drawerLayout.isDrawerOpen(GravityCompat.START)){
            drawerLayout.closeDrawer(GravityCompat.START);
        } else{
            super.onBackPressed();
        }
    }

    @Override
    public void onDismiss(DialogInterface dialogInterface) {
        fillListWithActivities(currentState);
    }

    public void fillListWithActivities(ActivityStatesEnum stateOfActivity) {
        if (loggedUser != null) {
            List<Activity> activityList = dataBaseHelper.getAllActivitiesWithState(loggedUser.getId(), stateOfActivity);
            ArrayList<ActivityCell> activityCellArrayList = new ArrayList<>();
            int index = 0;

            for (Activity a : activityList) {
                activityCellArrayList.add(new ActivityCell("" + index, String.valueOf(a.getId()), a.getName(), String.valueOf(a.getPoints()), String.valueOf(a.getDistance()), String.valueOf(a.getDifficulty())));
                index++;
            }

            ActivityCellAdapter adapter = new ActivityCellAdapter(getApplicationContext(), 0, activityCellArrayList);
            activitiesList.setAdapter(adapter);
        }
    }

    public void openAllActivities() {
        AddActivityToUserDialog addActivityToUserDialog = new AddActivityToUserDialog();
        addActivityToUserDialog.show(getSupportFragmentManager(),"example dialog");
    }




    private void viewsInit() {
        this.addActivity = findViewById(R.id.iv_add_new_activity);
        this.activitiesList = findViewById(R.id.lw_activity_manage_all_activities);
        this.rbCheckedActivities = findViewById(R.id.rb_activity_manage_checked);
        this.rbStartedActivities = findViewById(R.id.rb_activity_manage_started);
        this.rbEndedActivities = findViewById(R.id.rb_activity_manage_ended);
        this.rgActivities = findViewById(R.id.rg_activity_manage_radio_group);
        this.title = findViewById(R.id.tv_activity_manage_title);

    }

    @Override
    public boolean onNavigationItemSelected(@NonNull MenuItem item) {
        switch (item.getItemId()){
            case R.id.nav_home:
                startActivity(new Intent(this, MainActivity.class));
                break;
            case R.id.nav_profile:
                startActivity(new Intent(this, ShowProfileActivity.class));
                break;
            case R.id.nav_activies:
                startActivity(new Intent(this, ManageActivities.class));
                break;
            case R.id.nav_map:
                startActivity(new Intent(this, MapActivity.class));
                break;
            case R.id.nav_scanner:
                startActivity(new Intent(this, qrScanner.class));
                break;
            case R.id.nav_blog:
                startActivity(new Intent(this, blog.class));
                break;
        }
        drawerLayout.closeDrawer(GravityCompat.START);
        return true;
    }

}