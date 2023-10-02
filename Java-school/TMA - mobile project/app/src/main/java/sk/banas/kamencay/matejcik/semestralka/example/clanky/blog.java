package sk.banas.kamencay.matejcik.semestralka.example.clanky;

import androidx.annotation.NonNull;
import androidx.appcompat.app.ActionBarDrawerToggle;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.core.view.GravityCompat;
import androidx.drawerlayout.widget.DrawerLayout;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;


import com.google.android.material.navigation.NavigationView;

import sk.banas.kamencay.matejcik.semestralka.MainActivity;
import sk.banas.kamencay.matejcik.semestralka.R;
import sk.banas.kamencay.matejcik.semestralka.example.MapActivity;
import sk.banas.kamencay.matejcik.semestralka.example.activity.ManageActivities;
import sk.banas.kamencay.matejcik.semestralka.example.profile.ShowProfileActivity;
import sk.banas.kamencay.matejcik.semestralka.example.qrScanner;




public class blog extends AppCompatActivity implements NavigationView.OnNavigationItemSelectedListener {

    //menu bar
    DrawerLayout drawerLayout;
    NavigationView navigationView;
    Toolbar toolbar;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_blog);

        ////////////////////////////////////// HOOKS
        drawerLayout = findViewById(R.id.drawer_layout_blog);
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

    public void onimage1 (View view){
        Intent image1Intent = new Intent(Intent.ACTION_VIEW, Uri.parse("https://slovenskycestovatel.sk/item/banicky-naucny-chodnik"));
        startActivity(image1Intent);
    }
    public void onimage2 (View view){
        Intent image1Intent = new Intent(Intent.ACTION_VIEW, Uri.parse("https://slovenskycestovatel.sk/item/naucny-chodnik-slovensky-raj-nizke-tatry"));
        startActivity(image1Intent);
    }
    public void onimage3 (View view){
        Intent image1Intent = new Intent(Intent.ACTION_VIEW, Uri.parse("https://slovenskycestovatel.sk/item/tura-na-teryho-chatu"));
        startActivity(image1Intent);
    }
    public void onimage4 (View view){
        Intent image1Intent = new Intent(Intent.ACTION_VIEW, Uri.parse("https://slovenskycestovatel.sk/item/tura-na-zbojnicku-chatu"));
        startActivity(image1Intent);
    }
    public void onimage5 (View view){
        Intent image1Intent = new Intent(Intent.ACTION_VIEW, Uri.parse("https://slovenskycestovatel.sk/item/tura-z-belianskych-do-vysokych-tatier"));
        startActivity(image1Intent);
    }
    public void onimage6 (View view){
        Intent image1Intent = new Intent(Intent.ACTION_VIEW, Uri.parse("https://slovenskycestovatel.sk/item/vylet-na-studenovodske-vodopady"));
        startActivity(image1Intent);
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