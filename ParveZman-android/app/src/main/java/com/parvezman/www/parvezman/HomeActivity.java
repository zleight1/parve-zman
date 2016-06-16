package com.parvezman.www.parvezman;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;

public class HomeActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);
    }

    public void timerPressed(View view){
        Log.d("timerPressed", "Timer was pressed.");
        int id = view.getId();
        if(id == R.id.meatButton){
            //check if time needed
            navigateToTimer(Minhag.MEAT);
        } else {
            //check if time needed
            navigateToTimer(Minhag.DAIRY);
        }
    }

    public void settingsPressed(View view){
        Log.d("settingsPressed", "Settings was pressed.");
    }

    private void navigateToTimer(Minhag minhag){
        //Create intent
        Intent i = new Intent(this, TimerActivity.class);

        //Set options

        //Start activity
        startActivity(i);
    }
}
