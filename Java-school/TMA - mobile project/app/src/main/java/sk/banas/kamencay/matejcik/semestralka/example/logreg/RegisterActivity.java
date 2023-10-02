package sk.banas.kamencay.matejcik.semestralka.example.logreg;

import androidx.annotation.NonNull;
import androidx.appcompat.app.ActionBarDrawerToggle;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.core.view.GravityCompat;
import androidx.drawerlayout.widget.DrawerLayout;

import android.app.DatePickerDialog;
import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.Switch;
import android.widget.Toast;

import com.google.android.material.navigation.NavigationView;

import java.util.Calendar;

import sk.banas.kamencay.matejcik.semestralka.MainActivity;
import sk.banas.kamencay.matejcik.semestralka.R;
import sk.banas.kamencay.matejcik.semestralka.database.DataBaseHelper;
import sk.banas.kamencay.matejcik.semestralka.database.User;

import sk.banas.kamencay.matejcik.semestralka.example.MapActivity;
import sk.banas.kamencay.matejcik.semestralka.example.clanky.blog;
import sk.banas.kamencay.matejcik.semestralka.example.logreg.LoginActivity;
import sk.banas.kamencay.matejcik.semestralka.example.logreg.RegisterActivity;
import sk.banas.kamencay.matejcik.semestralka.example.profile.ShowProfileActivity;
import sk.banas.kamencay.matejcik.semestralka.example.activity.ManageActivities;
import sk.banas.kamencay.matejcik.semestralka.example.qrScanner;

public class RegisterActivity extends AppCompatActivity implements NavigationView.OnNavigationItemSelectedListener {

    private EditText registerName, registerPassword, registerRepeatPassword, registerWeight, registerHeight ,registerBirthdate;
    private Switch registerGender;
    private Button registerButton;
    private DatePickerDialog.OnDateSetListener setListener;

    //menu bar
    DrawerLayout drawerLayout;
    NavigationView navigationView;
    Toolbar toolbar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register);
        this.viewsInit();
        this.registerButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                registerNewUser();
            }
        });
        this.registerBirthdate.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                disableKeyboard(view);
                DatePickerDialog datePickerDialog = new DatePickerDialog(
                        RegisterActivity.this,
                        android.R.style.Theme_Holo_Dialog_MinWidth,
                        setListener,
                        Calendar.getInstance().get(Calendar.YEAR),
                        Calendar.getInstance().get(Calendar.MONTH),
                        Calendar.getInstance().get(Calendar.DAY_OF_MONTH));
                datePickerDialog.getWindow().setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
                datePickerDialog.show();
            }
        }); // zobrazi kalendar a po vybrati z kalendara to zapise ako text
        this.setListener = new DatePickerDialog.OnDateSetListener() {
            @Override
            public void onDateSet(DatePicker datePicker, int year, int month, int dayOfMonth) {
                month = month + 1;
                String date = dayOfMonth + "." + month + "." + year;
                registerBirthdate.setText(date);
            }
        };

        ////////////////////////////////////// HOOKS
        drawerLayout = findViewById(R.id.drawer_layout_register);
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
        this.registerName = findViewById(R.id.et_edit_profile_name);
        this.registerPassword = findViewById(R.id.et_edit_profile_password);
        this.registerRepeatPassword = findViewById(R.id.et_edit_profile_repeat_password);
        this.registerGender = findViewById(R.id.s_edit_profile_gender_k);
        this.registerWeight = findViewById(R.id.et_edit_profile_weight);
        this.registerHeight = findViewById(R.id.et_edit_profile_height);
        this.registerButton = findViewById(R.id.b_edit_profile);
        this.registerBirthdate = findViewById(R.id.et_edit_profile_birthdate);
    }

    public void disableKeyboard(View view) {
        if (view != null) {
            InputMethodManager imm = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
            imm.hideSoftInputFromWindow(view.getWindowToken(), 0);
        }
    }

    public boolean registerNewUser() {
        DataBaseHelper dataBaseHelper = new DataBaseHelper(RegisterActivity.this);
        String registerName = this.registerName.getText().toString();
        String password = this.registerPassword.getText().toString();
        String registerDate = this.registerBirthdate.getText().toString();
        float weight = 0.0f;
        float height = 0.0f;
        try {
            weight = Float.parseFloat(this.registerWeight.getText().toString());
            height = Float.parseFloat(this.registerHeight.getText().toString());
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        if (registerName.length() > 0) {
            if (!dataBaseHelper.isUserNameUnique(registerName)) {
                Toast.makeText(this, "Pouzivatelske meno sa uz pouziva.", Toast.LENGTH_SHORT).show();
                return false;
            }
        } else {
            Toast.makeText(this, "Meno je mensie ako 0 znakov.", Toast.LENGTH_SHORT).show();
            return false;
        }
        if (password.length() > 0) {
            if (!password.equals(registerRepeatPassword.getText().toString())) {
                Toast.makeText(this,"Hesla sa neopakuju.",Toast.LENGTH_SHORT).show();
                return false;
            }
        } else {
            Toast.makeText(this, "Heslo je mensie ako 0 znakov.", Toast.LENGTH_SHORT).show();
            return false;
        }
        User user = new User(-1,registerName,password,height,weight,registerDate,this.registerGender.isChecked());

        if (!dataBaseHelper.insertUser(user)) {
            Toast.makeText(RegisterActivity.this,"Nastala chyba pri pridavani pouzivatela",Toast.LENGTH_SHORT).show();
        }

        startActivity(new Intent(this,LoginActivity.class)); // prehodi to naspat na login activity

        return true;
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
