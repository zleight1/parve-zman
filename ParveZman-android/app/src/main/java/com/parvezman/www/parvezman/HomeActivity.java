package com.parvezman.www.parvezman;

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

        } else {

        }
    }

    public void settingsPressed(View view){
        Log.d("settingsPressed", "Settings was pressed.");
    }


}
