package sk.banas.kamencay.matejcik.semestralka.example.profile;

import androidx.annotation.NonNull;
import androidx.appcompat.app.ActionBarDrawerToggle;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.core.view.GravityCompat;
import androidx.drawerlayout.widget.DrawerLayout;

import android.annotation.SuppressLint;
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
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.material.navigation.NavigationView;

import java.util.Calendar;

import sk.banas.kamencay.matejcik.semestralka.MainActivity;
import sk.banas.kamencay.matejcik.semestralka.R;
import sk.banas.kamencay.matejcik.semestralka.database.DataBaseHelper;
import sk.banas.kamencay.matejcik.semestralka.database.SharedData;
import sk.banas.kamencay.matejcik.semestralka.database.User;
import sk.banas.kamencay.matejcik.semestralka.example.MapActivity;
import sk.banas.kamencay.matejcik.semestralka.example.activity.ManageActivities;
import sk.banas.kamencay.matejcik.semestralka.example.logreg.LoginActivity;
import sk.banas.kamencay.matejcik.semestralka.example.logreg.RegisterActivity;

import sk.banas.kamencay.matejcik.semestralka.example.clanky.blog;
import sk.banas.kamencay.matejcik.semestralka.example.logreg.LoginActivity;
import sk.banas.kamencay.matejcik.semestralka.example.logreg.RegisterActivity;
import sk.banas.kamencay.matejcik.semestralka.example.profile.ShowProfileActivity;
import sk.banas.kamencay.matejcik.semestralka.example.activity.ManageActivities;
import sk.banas.kamencay.matejcik.semestralka.example.qrScanner;


public class ShowProfileActivity extends AppCompatActivity implements EditProfileDialog.ExampleDialogListener, NavigationView.OnNavigationItemSelectedListener {

    private User loggedUser;
    private TextView profileFirstLetter, profileName, profileHeight, profileWeight, profileId, profileBirthDate, profileGender;
    private ImageView editProfile, editProfileCancel, profileLogOut;
    private Button manageActivities;


    private enum EditingParameterEnum{NONE, NAME, HEIGHT, WEIGHT, GENDER;} // podla toho ktory parameter editujem , podla toho sa zmeni hodnota z dialogoveho okna

    private EditingParameterEnum editingParameterEnum = EditingParameterEnum.NONE;
    
    private boolean editingProfile;
    private DatePickerDialog.OnDateSetListener setListener;
    private DataBaseHelper dataBaseHelper;

    //menu bar
    DrawerLayout drawerLayout;
    NavigationView navigationView;
    Toolbar toolbar;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_show_profile);
        this.viewsInit();
        this.editingProfile = false;
        this.dataBaseHelper = new DataBaseHelper(this);
        this.editProfile.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (editingProfile) {
                    updateUserInDatabase();
                }
                setEditingProfile(!editingProfile);
                editProfileCancel.setVisibility(editingProfile? view.VISIBLE : view.INVISIBLE);
            }
        });
        this.editProfileCancel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                setEditingProfile(false);
                fillProfile();
                editProfileCancel.setVisibility(View.INVISIBLE);
            }
        });
        this.profileName.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (editingProfile) {
                    editingParameterEnum = EditingParameterEnum.NAME;
                    openStringDialog();
                }
            }
        });
        this.profileHeight.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (editingProfile) {
                    editingParameterEnum = EditingParameterEnum.HEIGHT;
                    openFloatDialog();
                }
            }
        });
        this.profileWeight.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (editingProfile) {
                    editingParameterEnum = EditingParameterEnum.WEIGHT;
                    openFloatDialog();
                }
            }
        });
        this.profileGender.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (editingProfile) {
                    editingParameterEnum = EditingParameterEnum.GENDER;
                    openBooleanDialog();
                }
            }
        });
        this.profileLogOut.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                SharedData.saveLoggedUser(ShowProfileActivity.this,-1);
                startActivity(new Intent(ShowProfileActivity.this, LoginActivity.class));
            }
        });
        this.profileBirthDate.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (editingProfile) {
                    disableKeyboard(view);
                    DatePickerDialog datePickerDialog = new DatePickerDialog(
                            ShowProfileActivity.this,
                            android.R.style.Theme_Holo_Dialog_MinWidth,
                            setListener,
                            Calendar.getInstance().get(Calendar.YEAR),
                            Calendar.getInstance().get(Calendar.MONTH),
                            Calendar.getInstance().get(Calendar.DAY_OF_MONTH));
                    datePickerDialog.getWindow().setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
                    datePickerDialog.show();
                }
            }
        }); // zobrazi kalendar a po vybrati z kalendara to zapise ako text
        this.manageActivities.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                openWindowToManageActivities();
            }
        });
        this.setListener = new DatePickerDialog.OnDateSetListener() {
            @Override
            public void onDateSet(DatePicker datePicker, int year, int month, int dayOfMonth) {
                month = month + 1;
                String date = dayOfMonth + "." + month + "." + year;
                profileBirthDate.setText(date);
            }
        };
        this.loggedUser = this.dataBaseHelper.getUserByID(SharedData.loadLoggedUser(this));
        if (this.loggedUser == null) {
            startActivity(new Intent(this, LoginActivity.class));
        }


        ////////////////////////////////////// HOOKS
        drawerLayout = findViewById(R.id.drawer_layout_profile);
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

    public void openWindowToManageActivities() {
        startActivity(new Intent(this, ManageActivities.class));
    }

    public void updateUserInDatabase() {
        User user = new User(this.loggedUser.getId(),
                    this.profileName.getText().toString(),
                    this.loggedUser.getPassword(),
                    Float.parseFloat(this.profileHeight.getText().toString()),
                    Float.parseFloat(this.profileWeight.getText().toString()),
                    this.profileBirthDate.getText().toString(),
                    this.profileGender.getText().toString().equals("Woman"));
        if (dataBaseHelper.updateUserByID(this.loggedUser.getId(),user)) {
            this.loggedUser = user;
        }
    }

    private void disableKeyboard(View view) {
        if (view != null) {
            InputMethodManager imm = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
            imm.hideSoftInputFromWindow(view.getWindowToken(), 0);
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (SharedData.loadLoggedUser(this) <= -1) {
            startActivity(new Intent(ShowProfileActivity.this,LoginActivity.class));
        } else {
            fillProfile();
        }
    }

    @Override
    public void applyTextString(String value) {
        switch (editingParameterEnum) {
            case NAME:
                if (dataBaseHelper.isUserNameUnique(value)) {
                    this.profileName.setText(value);
                    this.profileFirstLetter.setText(value.substring(0,1).toUpperCase());
                } else {
                    Toast.makeText(ShowProfileActivity.this,"Zadane meno sa uz pouziva",Toast.LENGTH_SHORT).show();
                    this.profileName.setText(this.loggedUser.getName());
                    this.profileFirstLetter.setText(this.loggedUser.getName().substring(0,1).toUpperCase());
                }
                break;
            default:
                break;
        }
    }

    @Override
    public void applyTextFloat(String value) {
        switch (editingParameterEnum) {
            case HEIGHT:
                this.profileHeight.setText(value);
                break;
            case WEIGHT:
                this.profileWeight.setText(value);
                break;
            default:
                break;
        }
    }

    @Override
    public void applyTextBoolean(boolean value) {
        switch (editingParameterEnum) {
            case GENDER:
                this.profileGender.setText(value ? "Woman" : "Man");
        }

    }

    private void setEditingProfile(boolean value) {
        this.editingProfile = value;
        if (this.editingProfile) {
            this.editProfile.setImageResource(R.drawable.ic_profile_done);
        } else {
            this.editProfile.setImageResource(R.drawable.ic_edit_button);
        }
    }

    private void openStringDialog() {
        new EditProfileDialog(EditProfileDialog.EditingParameterEnum.STRING,"Name",this.loggedUser.getName()).show(getSupportFragmentManager(),"dialog");
    }

    private void openFloatDialog() {
        switch (editingParameterEnum) {
            case HEIGHT:
                 new EditProfileDialog(EditProfileDialog.EditingParameterEnum.FLOAT,"Height",Float.parseFloat(this.profileHeight.getText().toString())).show(getSupportFragmentManager(), "dialog");
                break;
            case WEIGHT:
                new EditProfileDialog(EditProfileDialog.EditingParameterEnum.FLOAT,"Weight",Float.parseFloat(this.profileWeight.getText().toString())).show(getSupportFragmentManager(), "dialog");
                break;
            default:
                new EditProfileDialog(EditProfileDialog.EditingParameterEnum.FLOAT,"",Float.toString(0.0f)).show(getSupportFragmentManager(), "dialog");
                break;
        }
    }

    private void openBooleanDialog() {
        new EditProfileDialog(EditProfileDialog.EditingParameterEnum.BOOLEAN,"Gender",this.loggedUser.isGender()).show(getSupportFragmentManager(),"dialog");
    }

    private void viewsInit() {
        this.profileFirstLetter = findViewById(R.id.tv_profile_first_letter);
        this.profileName = findViewById(R.id.tv_profile_name);
        this.editProfile = findViewById(R.id.iv_profile_edit);
        this.profileWeight = findViewById(R.id.tv_profile_weight);
        this.profileHeight = findViewById(R.id.tv_profile_height);
        this.profileId = findViewById(R.id.tv_profile_id);
        this.editProfileCancel = findViewById(R.id.iv_profile_cancel);
        this.profileBirthDate = findViewById(R.id.tv_profile_birth_date);
        this.profileGender = findViewById(R.id.tv_profile_gender);
        this.profileLogOut = findViewById(R.id.iv_profile_logout);
        this.manageActivities = findViewById(R.id.b_profile_manage_activities);
    }

    @SuppressLint("SetTextI18n")
    private void fillProfile() {
        if (this.loggedUser != null) {
            this.profileFirstLetter.setText(loggedUser.getFirstLetter());
            this.profileName.setText(loggedUser.getName());
            this.profileHeight.setText(Float.toString(this.loggedUser.getHeight()));
            this.profileWeight.setText(Float.toString(this.loggedUser.getWeight()));
            this.profileId.setText("#"+ this.loggedUser.getId());
            this.profileBirthDate.setText(this.loggedUser.getBirthdate());
            this.profileGender.setText(this.loggedUser.isGender() ? "Woman" : "Man");
        }
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