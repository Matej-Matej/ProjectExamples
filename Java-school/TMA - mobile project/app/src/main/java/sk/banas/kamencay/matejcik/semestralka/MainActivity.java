package sk.banas.kamencay.matejcik.semestralka;

import androidx.annotation.NonNull;
import androidx.appcompat.app.ActionBarDrawerToggle;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.view.GravityCompat;
import androidx.drawerlayout.widget.DrawerLayout;

import android.app.Dialog;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.Toast;
import androidx.appcompat.widget.Toolbar;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GoogleApiAvailability;
import com.google.android.material.navigation.NavigationView;

import sk.banas.kamencay.matejcik.semestralka.database.SharedData;
import sk.banas.kamencay.matejcik.semestralka.example.*;
import sk.banas.kamencay.matejcik.semestralka.example.clanky.blog;
import sk.banas.kamencay.matejcik.semestralka.example.logreg.LoginActivity;
import sk.banas.kamencay.matejcik.semestralka.example.logreg.RegisterActivity;
import sk.banas.kamencay.matejcik.semestralka.example.profile.ShowProfileActivity;
import sk.banas.kamencay.matejcik.semestralka.example.activity.ManageActivities;


public class MainActivity extends AppCompatActivity implements NavigationView.OnNavigationItemSelectedListener {

    private static final String TAG = "MainActivity";

    //konrola spravnej verzie
    private static final int ERROR_DIALOG_REQUEST = 9001;

    //menu bar
    DrawerLayout drawerLayout;
    NavigationView navigationView;
    Toolbar toolbar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ImageView ivScanner = (ImageView) findViewById(R.id.ivscanner);
        ivScanner.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                btnScannerClick();
            }
        });

        // onlicklistener pre profil

        ImageView ivProfil = (ImageView) findViewById(R.id.ivprofil);
        ivProfil.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                btnProfilClick();
            }
        });

        // onlicklistener pre aktivity

        ImageView ivaktivity = (ImageView) findViewById(R.id.ivaktivity);
        ivaktivity.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                btnAktivityClick();
            }
        });

        //onclicklistener pre mapa button

        ImageView ivMapa = (ImageView) findViewById(R.id.ivmapa);
        ivMapa.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                btnMapClick();
            }
        });

        //onclicklistener pre blog button

        ImageView ivblog = (ImageView) findViewById(R.id.ivblog);
        ivblog.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                btnBlogClick();
            }
        });

        ////////////////////////////////////// HOOKS
        drawerLayout = findViewById(R.id.drawer_layout);
        navigationView = findViewById(R.id.nav_view);
        toolbar = findViewById(R.id.toolbarmenu);

        /////////////////////////////////////// TOOL BAR

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

    //prepnutie na aktivitu mapa
    private void btnMapClick() {
        startActivity(new Intent(this, MapActivity.class));
    }

    //prepnutie na aktivitu scanner
    private void btnScannerClick() {
        startActivity(new Intent(this, qrScanner.class));
    }

    //prepnutie na aktivitu stepcounter
    private void btnclick() {
        startActivity(new Intent(this, LoginActivity.class));
    }

    //prepnutie na aktivitu blog
    private void btnBlogClick() { startActivity(new Intent(this, blog.class)); }

    //prepmunie na akivitu profil
    private void btnProfilClick() { startActivity(new Intent(this, ShowProfileActivity.class)); }

    //prepmunie na akivitu aktivity
    private void btnAktivityClick() { startActivity(new Intent(this, ManageActivities.class)); }


    public boolean isServicesOK(){
        Log.d(TAG, "isServicesOK: checking google services version");

        int available = GoogleApiAvailability.getInstance().isGooglePlayServicesAvailable(MainActivity.this);

        if(available == ConnectionResult.SUCCESS){
            //všetko funguje OK
            Log.d(TAG, "isServicesOK: Google Play Services is working");
            return true;
        }
        else if(GoogleApiAvailability.getInstance().isUserResolvableError(available)){
            //chyba ale vieme ju vyriešiť
            Log.d(TAG, "isServicesOK: an error occured but we can fix it");
            Dialog dialog = GoogleApiAvailability.getInstance().getErrorDialog(MainActivity.this, available, ERROR_DIALOG_REQUEST);
            dialog.show();
        }else{
            //chyba nejde vyriešiť
            Toast.makeText(this, "You can't make map requests", Toast.LENGTH_SHORT).show();
        }
        return false;
    }

    @Override
    public boolean onNavigationItemSelected(@NonNull MenuItem item) {
        switch (item.getItemId()){
            case R.id.nav_home:
                break;
            case R.id.nav_profile:
                btnProfilClick();
                break;
            case R.id.nav_activies:
                btnAktivityClick();
                break;
            case R.id.nav_map:
                btnMapClick();
                break;
            case R.id.nav_scanner:
                btnScannerClick();
                break;
            case R.id.nav_blog:
                btnBlogClick();
                break;
        }
        drawerLayout.closeDrawer(GravityCompat.START);
        return true;
    }
}