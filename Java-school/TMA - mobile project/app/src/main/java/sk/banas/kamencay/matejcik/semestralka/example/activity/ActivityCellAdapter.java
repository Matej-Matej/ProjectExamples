package sk.banas.kamencay.matejcik.semestralka.example.activity;

import android.annotation.SuppressLint;
import android.content.Context;
import android.graphics.drawable.shapes.Shape;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.List;

import sk.banas.kamencay.matejcik.semestralka.R;

public class ActivityCellAdapter extends ArrayAdapter<ActivityCell> {

    public ActivityCellAdapter(Context context,int resource, List<ActivityCell> activityCellList) {
        super(context,resource,activityCellList);
    }

    @SuppressLint("SetTextI18n")
    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {

        ActivityCell activityCell = getItem(position);

        if (convertView == null) {
            convertView = LayoutInflater.from(getContext()).inflate(R.layout.activity_cell,parent,false);
        }

        TextView tv_name = convertView.findViewById(R.id.tv_activity_cell_name);
        TextView tv_points = convertView.findViewById(R.id.tv_activity_cell_points);
        TextView tv_distance = convertView.findViewById(R.id.tv_activity_cell_distance);

        ImageView star1 = convertView.findViewById(R.id.iv_activity_cell_star_1);
        ImageView star2 = convertView.findViewById(R.id.iv_activity_cell_star_2);
        ImageView star3 = convertView.findViewById(R.id.iv_activity_cell_star_3);
        ImageView star4 = convertView.findViewById(R.id.iv_activity_cell_star_4);
        ImageView star5 = convertView.findViewById(R.id.iv_activity_cell_star_5);


        tv_name.setText(activityCell.getName());

        int difficulty = Integer.parseInt(activityCell.getDifficulty());

        star1.setImageResource(R.drawable.ic_activity_cell_star_empty);
        star2.setImageResource(R.drawable.ic_activity_cell_star_empty);
        star3.setImageResource(R.drawable.ic_activity_cell_star_empty);
        star4.setImageResource(R.drawable.ic_activity_cell_star_empty);
        star5.setImageResource(R.drawable.ic_activity_cell_star_empty);

        switch (difficulty) {
            case 1:
                star1.setImageResource(R.drawable.ic_activity_cell_star_full);
                break;
            case 2:
                star1.setImageResource(R.drawable.ic_activity_cell_star_full);
                star2.setImageResource(R.drawable.ic_activity_cell_star_full);
                break;
            case 3:
                star1.setImageResource(R.drawable.ic_activity_cell_star_full);
                star2.setImageResource(R.drawable.ic_activity_cell_star_full);
                star3.setImageResource(R.drawable.ic_activity_cell_star_full);
                break;
            case 4:
                star1.setImageResource(R.drawable.ic_activity_cell_star_full);
                star2.setImageResource(R.drawable.ic_activity_cell_star_full);
                star3.setImageResource(R.drawable.ic_activity_cell_star_full);
                star4.setImageResource(R.drawable.ic_activity_cell_star_full);
                break;
            default:
                star1.setImageResource(R.drawable.ic_activity_cell_star_full);
                star2.setImageResource(R.drawable.ic_activity_cell_star_full);
                star3.setImageResource(R.drawable.ic_activity_cell_star_full);
                star4.setImageResource(R.drawable.ic_activity_cell_star_full);
                star5.setImageResource(R.drawable.ic_activity_cell_star_full);
                break;
        }

        tv_points.setText(activityCell.getPoints() + " points");
        tv_distance.setText(activityCell.getDistance() + " km");


        return convertView;
    }
}
