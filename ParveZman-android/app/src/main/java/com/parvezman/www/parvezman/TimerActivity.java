package com.parvezman.www.parvezman;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.res.Resources;
import android.graphics.drawable.ColorDrawable;
import android.os.Build;
import android.os.Bundle;
import android.os.CountDownTimer;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.view.MenuItem;
import android.widget.TextView;

import com.pnikosis.materialishprogress.ProgressWheel;

public class TimerActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_timer);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
            ActionBar ab = getSupportActionBar();
            ab.setDisplayHomeAsUpEnabled(true);

            Bundle extras = getIntent().getExtras();
            if(extras != null){
                Minhag minhag = (Minhag)extras.get("minhag");
                StringBuilder timerTitle = new StringBuilder();
                ColorDrawable timerColor, rimColor;
                if(minhag == Minhag.MEAT){
                    timerTitle.append(getResources().getText(R.string.meatName));
                    rimColor = new ColorDrawable(ContextCompat.getColor(this, R.color.flatRedColor));
                    timerColor = new ColorDrawable(ContextCompat.getColor(this, R.color.flatLightRedColor));
                } else {
                    timerTitle.append(getResources().getText(R.string.dairyName));
                    rimColor = new ColorDrawable(ContextCompat.getColor(this, R.color.flatBlueColor));
                    timerColor = new ColorDrawable(ContextCompat.getColor(this, R.color.flatLightBlueColor));
                }
                timerTitle.append(" ");
                timerTitle.append(getResources().getText(R.string.timerName));
                ab.setTitle(timerTitle.toString());
                ab.setBackgroundDrawable(rimColor);
                //set the colors
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {
                    TextView timerText = (TextView) findViewById(R.id.timerText);
                    timerText.setTextColor(rimColor.getColor());
                    ProgressWheel wheel = (ProgressWheel) findViewById(R.id.progress_wheel);
                    wheel.setBarColor(timerColor.getColor());
                    wheel.setRimColor(rimColor.getColor());
                    wheel.setProgress(0.00f);
                }
            }
        }

        new CountDownTimer(30000, 100) {
            ProgressWheel wheel = (ProgressWheel) findViewById(R.id.progress_wheel);
            TextView timerText = (TextView) findViewById(R.id.timerText);
            public void onTick(long millisUntilFinished) {
                timerText.setText(String.valueOf(millisUntilFinished / 1000));
                wheel.setInstantProgress((float)(30000 - millisUntilFinished)/(30000));
            }

            public void onFinish() {
                timerText.setText(R.string.elapsed_time);
                wheel.setProgress(1.0f);
            }
        }.start();
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        if (item.getItemId() == android.R.id.home) {
            onBackPressed();
            return true;
        }
        return false;
    }

    @Override
    public void onBackPressed(){
        new AlertDialog.Builder(this)
                .setTitle("Stop Timer?")
                .setMessage("This will stop the running timer and remove any scheduled notifications.")
                .setPositiveButton(R.string.stop_text, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        // continue with delete
                        finish();
                    }
                })
                .setNegativeButton(android.R.string.cancel, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        // do nothing
                    }
                })
                //.setIcon(android.R.drawable.ic_dialog_alert)
                .show();
    }
}
