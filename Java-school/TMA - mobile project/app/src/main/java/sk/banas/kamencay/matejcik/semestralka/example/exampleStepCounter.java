package sk.banas.kamencay.matejcik.semestralka.example;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.content.Intent;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.mikhaellopez.circularprogressbar.CircularProgressBar; // pouzivam odtialto https://github.com/lopspower/CircularProgressBar

import sk.banas.kamencay.matejcik.semestralka.R;
import sk.banas.kamencay.matejcik.semestralka.example.logreg.LoginActivity;

public class exampleStepCounter extends AppCompatActivity implements SensorEventListener {

    private SensorManager sensorManager;
    private CircularProgressBar circularProgressBar;
    private TextView tv_steps;
    private boolean running = false;
    private float totalSteps = 0f;
    private float lastSteps = 0f;
    private float stepsLimit = 200f;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_example_step_counter);
        sensorManager = (SensorManager) getSystemService(Context.SENSOR_SERVICE);
        circularProgressBar = (CircularProgressBar) findViewById(R.id.circularProgressBar);
        circularProgressBar.setProgressMax(stepsLimit);
        tv_steps = (TextView) findViewById(R.id.tv_steps);

        Button logBut = (Button) findViewById(R.id.button3);
        logBut.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                switchToLogin();
            }
        });
    }

    @Override
    protected void onResume() {
        super.onResume();
        running = true;
        Sensor countSensor = sensorManager.getDefaultSensor(Sensor.TYPE_STEP_COUNTER);
        if (countSensor != null) {
            sensorManager.registerListener(this, countSensor, SensorManager.SENSOR_DELAY_UI); // malo by sa to updatovat pomalsie, aby to nebralo velke mnozsto zdrojov
        } else {
            Toast.makeText(this, "Senzor sa v zariadeni nenachadza!", Toast.LENGTH_SHORT).show();
        }
    }

    @Override
    public void onSensorChanged(SensorEvent sensorEvent) {
        if (running) {
            if (lastSteps == 0f) lastSteps = sensorEvent.values[0];
            totalSteps = sensorEvent.values[0] - lastSteps;
            tv_steps.setText(String.valueOf(totalSteps));
            circularProgressBar.setProgressWithAnimation(totalSteps);
        }
    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int i) {

    }

    public void switchToLogin() {
        //TODO zmazat do buducna
        startActivity(new Intent(this, LoginActivity.class));
    }
}