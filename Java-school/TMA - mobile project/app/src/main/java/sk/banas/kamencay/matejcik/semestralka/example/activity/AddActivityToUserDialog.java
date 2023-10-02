package sk.banas.kamencay.matejcik.semestralka.example.activity;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.ScrollView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatDialogFragment;
import androidx.fragment.app.FragmentActivity;

import java.util.ArrayList;
import java.util.List;

import sk.banas.kamencay.matejcik.semestralka.R;
import sk.banas.kamencay.matejcik.semestralka.database.Activity;
import sk.banas.kamencay.matejcik.semestralka.database.ActivityStatesEnum;
import sk.banas.kamencay.matejcik.semestralka.database.DataBaseHelper;
import sk.banas.kamencay.matejcik.semestralka.database.SharedData;
import sk.banas.kamencay.matejcik.semestralka.database.User;
import sk.banas.kamencay.matejcik.semestralka.database.UserActivity;
import sk.banas.kamencay.matejcik.semestralka.example.logreg.LoginActivity;

public class AddActivityToUserDialog extends AppCompatDialogFragment {

    @NonNull
    @Override
    public Dialog onCreateDialog(@Nullable Bundle savedInstanceState) {
        AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());

        LayoutInflater inflater = getActivity().getLayoutInflater();
        View view = inflater.inflate(R.layout.add_activity_to_user_dialog,null);

        ListView listView = view.findViewById(R.id.lv_add_activity_to_user_all_activities);

        DataBaseHelper dataBaseHelper = new DataBaseHelper(getActivity().getApplicationContext());
        List<Activity> activityList = dataBaseHelper.getAllActivities();

        User loggedUser = dataBaseHelper.getUserByID(SharedData.loadLoggedUser(getActivity().getApplicationContext()));
        if (loggedUser == null) {
            startActivity(new Intent(getActivity().getApplicationContext(), LoginActivity.class));
        }

        ArrayList<ActivityCell> activityCellArrayList = new ArrayList<>();
        int index = 0;

        for (Activity a : activityList) {
            if (!dataBaseHelper.isActivityChoosed(a.getId(),loggedUser.getId())) {
                activityCellArrayList.add(new ActivityCell(""+index,String.valueOf(a.getId()),a.getName(),String.valueOf(a.getPoints()),String.valueOf(a.getDistance()),String.valueOf(a.getDifficulty())));
                index++;
            }
        }

        ActivityCellAdapter adapter = new ActivityCellAdapter(getActivity().getApplicationContext(),0,activityCellArrayList);
        listView.setAdapter(adapter);

        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                ActivityCell activityCell = (ActivityCell) listView.getItemAtPosition(i);
                dataBaseHelper.insertUserActivity(new UserActivity(-1,loggedUser.getId(),Integer.parseInt(activityCell.getActivityId()), ActivityStatesEnum.CHOOSED.toString(),""));
                dismiss();
            }
        });

        builder.setView(view)
                .setTitle("Add activity to your profile")
                .setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                    }
        });

        return builder.create();
    }

    @Override
    public void onDismiss(@NonNull DialogInterface dialog) {
        super.onDismiss(dialog);
        final FragmentActivity activity = getActivity();
        if (activity instanceof DialogInterface.OnDismissListener) {
            ((DialogInterface.OnDismissListener) activity).onDismiss(dialog);
        }
    }
}
