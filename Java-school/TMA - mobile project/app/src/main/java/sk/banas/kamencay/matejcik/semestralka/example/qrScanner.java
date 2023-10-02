package sk.banas.kamencay.matejcik.semestralka.example;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.ActionBarDrawerToggle;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.core.view.GravityCompat;
import androidx.drawerlayout.widget.DrawerLayout;

import com.google.android.material.navigation.NavigationView;
import com.google.zxing.integration.android.IntentIntegrator;
import com.google.zxing.integration.android.IntentResult;

import sk.banas.kamencay.matejcik.semestralka.MainActivity;
import java.util.List;

import sk.banas.kamencay.matejcik.semestralka.R;
import sk.banas.kamencay.matejcik.semestralka.database.Activity;
import sk.banas.kamencay.matejcik.semestralka.database.ActivityStatesEnum;
import sk.banas.kamencay.matejcik.semestralka.database.DataBaseHelper;
import sk.banas.kamencay.matejcik.semestralka.database.SharedData;
import sk.banas.kamencay.matejcik.semestralka.database.User;
import sk.banas.kamencay.matejcik.semestralka.example.clanky.blog;
import sk.banas.kamencay.matejcik.semestralka.example.logreg.LoginActivity;
import sk.banas.kamencay.matejcik.semestralka.example.logreg.RegisterActivity;
import sk.banas.kamencay.matejcik.semestralka.example.profile.ShowProfileActivity;
import sk.banas.kamencay.matejcik.semestralka.example.activity.ManageActivities;
import sk.banas.kamencay.matejcik.semestralka.database.UserActivity;
import sk.banas.kamencay.matejcik.semestralka.example.logreg.LoginActivity;


public class qrScanner extends AppCompatActivity implements NavigationView.OnNavigationItemSelectedListener {

    Button btnScanQR;
    String QRcontent;
    public static String[] words;

    public static double c1 = 0;
    public static double c2 = 0;

    private DataBaseHelper dataBaseHelper;
    public static final double errorValue = 0.00005d; // toto je hranica chyby, ako najviac od seba mozu byt suradnice z qr kodu a zo zaciatku aktivity podla DB
    //menu bar
    DrawerLayout drawerLayout;
    NavigationView navigationView;
    Toolbar toolbar;


    @Override
    protected void onCreate(Bundle savedInstanceState){
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_qrscanner);

        this.dataBaseHelper = new DataBaseHelper(this);

        btnScanQR = findViewById(R.id.btnScanQR);
        btnScanQR.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startQrScanner();
            }
        });

        startQrScanner();

        ////////////////////////////////////// HOOKS
        drawerLayout = findViewById(R.id.drawer_layout_scanner);
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

    public void startQrScanner() {
        IntentIntegrator intentIntegrator = new IntentIntegrator(
                qrScanner.this
        );
        intentIntegrator.setPrompt("Pre blesk použite tlačidlo pridať hlasitosť");

        intentIntegrator.setBeepEnabled(true);

        intentIntegrator.setOrientationLocked(true);

        intentIntegrator.setCaptureActivity(Capture.class);

        intentIntegrator.initiateScan();
    }

    @Override
    public void onBackPressed(){
        if (drawerLayout.isDrawerOpen(GravityCompat.START)){
            drawerLayout.closeDrawer(GravityCompat.START);
        } else{
            super.onBackPressed();
        }
    }


    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        IntentResult intentResult = IntentIntegrator.parseActivityResult(
                requestCode, resultCode,data
        );
        if (intentResult.getContents() != null){
            AlertDialog.Builder builder = new AlertDialog.Builder(
                    qrScanner.this
            );
            builder.setTitle("Vysledok");

            builder.setMessage(intentResult.getContents());

            QRcontent = intentResult.getContents();
            System.out.println(QRcontent);

            builder.setPositiveButton("OK", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int i) {
                            dialog.dismiss();
                        }
                    });
            //builder.show();

            User loggedUser = this.dataBaseHelper.getUserByID(SharedData.loadLoggedUser(this));
            if (loggedUser != null) {
                String[] qrAxis = parser(QRcontent); // suradnice z QR kodu
                if (qrAxis.length >= 4) {
                    List<Activity> activityListChoosed =  dataBaseHelper.getAllActivitiesWithState(loggedUser.getId(), ActivityStatesEnum.CHOOSED);
                    for (Activity a : activityListChoosed) {
                        String[] startAct = parser(a.getStartPoint()); // suradnice prveho bodu v aktivite
                        if (Math.abs(Double.parseDouble(qrAxis[0]) - Double.parseDouble(startAct[0])) <= errorValue
                                && Math.abs(Double.parseDouble(qrAxis[1]) - Double.parseDouble(startAct[1])) <= errorValue) {
                            this.dataBaseHelper.updateUserActivity(loggedUser.getId(),a.getId(),ActivityStatesEnum.STARTED,qrAxis[2] + " " + qrAxis[3]);
                        }
                    }

                    List<Activity> activityListStarted = dataBaseHelper.getAllActivitiesWithState(loggedUser.getId(),ActivityStatesEnum.STARTED);
                    for (Activity a : activityListStarted) {
                        UserActivity userActivity = this.dataBaseHelper.getUserActivity(loggedUser.getId(),a.getId());

                        String[] endAct = parser(a.getEndPoint()); // suradnice prveho bodu v aktivite
                        if (Math.abs(Double.parseDouble(qrAxis[0]) - Double.parseDouble(endAct[0])) <= errorValue
                                && Math.abs(Double.parseDouble(qrAxis[1]) - Double.parseDouble(endAct[1])) <= errorValue) {
                            this.dataBaseHelper.updateUserActivity(loggedUser.getId(),a.getId(),ActivityStatesEnum.ENDED,"");
                            Toast.makeText(this,"Gratulujem, presiel si trasu: "+ a.getName(),Toast.LENGTH_SHORT).show();
                            break;
                        }

                        String[] nextAct = parser(userActivity.getNewPoint());
                        if (Math.abs(Double.parseDouble(qrAxis[0]) - Double.parseDouble(nextAct[0])) <= errorValue
                                && Math.abs(Double.parseDouble(qrAxis[1]) - Double.parseDouble(nextAct[1])) <= errorValue) {
                            this.dataBaseHelper.updateUserActivity(loggedUser.getId(),a.getId(),ActivityStatesEnum.STARTED,qrAxis[2] + " " + qrAxis[3]);
                        }
                    }
                }
                koordinacie(QRcontent);
                startActivity(new Intent(this, MapActivity.class));
            } else {
                startActivity(new Intent(this, LoginActivity.class));
            }
        }
    }

    public static void koordinacie(String koordinacie){
        String[] words= parser(koordinacie);
        if (words.length >= 4) {
            c1 = Double.parseDouble(words[2]);
            c2 = Double.parseDouble(words[3]);
        }
    }

    public static String[] parser(String koordinacie) {
        return koordinacie.split("\\s");
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

