package sk.banas.kamencay.matejcik.semestralka.example.logreg;

import androidx.annotation.NonNull;
import androidx.appcompat.app.ActionBarDrawerToggle;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.core.view.GravityCompat;
import androidx.drawerlayout.widget.DrawerLayout;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.material.navigation.NavigationView;

import sk.banas.kamencay.matejcik.semestralka.MainActivity;
import sk.banas.kamencay.matejcik.semestralka.R;
import sk.banas.kamencay.matejcik.semestralka.database.DataBaseHelper;
import sk.banas.kamencay.matejcik.semestralka.database.SharedData;
import sk.banas.kamencay.matejcik.semestralka.database.User;
import sk.banas.kamencay.matejcik.semestralka.example.MapActivity;
import sk.banas.kamencay.matejcik.semestralka.example.profile.ShowProfileActivity;
import sk.banas.kamencay.matejcik.semestralka.example.qrScanner;

import sk.banas.kamencay.matejcik.semestralka.example.clanky.blog;
import sk.banas.kamencay.matejcik.semestralka.example.logreg.LoginActivity;
import sk.banas.kamencay.matejcik.semestralka.example.logreg.RegisterActivity;
import sk.banas.kamencay.matejcik.semestralka.example.profile.ShowProfileActivity;
import sk.banas.kamencay.matejcik.semestralka.example.activity.ManageActivities;

public class LoginActivity extends AppCompatActivity implements NavigationView.OnNavigationItemSelectedListener {

    public static final String SHARED_PREFERENCES = "shared_preferences";
    public static final String SP_ID = "user_id";
    public static final String SP_LOGGED = "user_logged";

    private EditText loginName, loginPassword;
    private TextView registerHere;
    private Button loginButton;

    //menu bar
    DrawerLayout drawerLayout;
    NavigationView navigationView;
    Toolbar toolbar;


    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        viewsInit();
        this.loginButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                checkLogin();
            }
        });
        this.registerHere.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                openNewRegistration();
            }
        });

        ////////////////////////////////////// HOOKS
        drawerLayout = findViewById(R.id.drawer_layout_login);
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
    public void onBackPressed(){
        if (drawerLayout.isDrawerOpen(GravityCompat.START)){
            drawerLayout.closeDrawer(GravityCompat.START);
        } else{
            super.onBackPressed();
        }
    }

    private void viewsInit() {
        this.loginName = findViewById(R.id.et_login_name);
        this.loginPassword = findViewById(R.id.et_login_password);
        this.loginButton = findViewById(R.id.b_login_button);
        this.registerHere = findViewById(R.id.tv_register_here);
    }

    private void checkLogin() {
        DataBaseHelper dataBaseHelper = new DataBaseHelper(LoginActivity.this);
        int userID = dataBaseHelper.loginUser(new User(this.loginName.getText().toString(),this.loginPassword.getText().toString()));
        SharedData.saveLoggedUser(this,userID);
        if (userID > -1) {
            startActivity(new Intent(this, ShowProfileActivity.class));
        } else {
            Toast.makeText(this,"Prihlasenie nebolo uspesne",Toast.LENGTH_SHORT).show();
        }
    }

    private void openNewRegistration() {
        startActivity(new Intent(this,RegisterActivity.class));
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