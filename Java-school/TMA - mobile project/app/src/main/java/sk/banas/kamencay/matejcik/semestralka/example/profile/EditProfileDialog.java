package sk.banas.kamencay.matejcik.semestralka.example.profile;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.EditText;
import android.widget.Switch;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatDialogFragment;

import sk.banas.kamencay.matejcik.semestralka.R;

public class EditProfileDialog extends AppCompatDialogFragment {

    private EditText editValueString, editValueFloat;
    private Switch editValueBoolean;
    private ExampleDialogListener listener;
    private String dialogTitle;
    private String dialogValueString;
    private String dialogValueFloat;
    private boolean dialogValueBoolean;

    public enum EditingParameterEnum{STRING, FLOAT, BOOLEAN};
    private EditingParameterEnum editingParameterEnum;

    public EditProfileDialog(EditingParameterEnum editingParameterEnum, String dialogTitle, String dialogValueString) {
        this.editingParameterEnum = editingParameterEnum;
        this.dialogTitle = dialogTitle;
        this.dialogValueString = dialogValueString;
        this.dialogValueFloat = "";
        this.dialogValueBoolean = false;
    }

    public EditProfileDialog(EditingParameterEnum editingParameterEnum, String dialogTitle, Float dialogValueFloat) {
        this.editingParameterEnum = editingParameterEnum;
        this.dialogTitle = dialogTitle;
        this.dialogValueString = "";
        this.dialogValueFloat = Float.toString(dialogValueFloat);
        this.dialogValueBoolean = false;
    }

    public EditProfileDialog(EditingParameterEnum editingParameterEnum, String dialogTitle, boolean dialogValueBoolean) {
        this.editingParameterEnum = editingParameterEnum;
        this.dialogTitle = dialogTitle;
        this.dialogValueString = "";
        this.dialogValueFloat = "";
        this.dialogValueBoolean = dialogValueBoolean;
    }

    @NonNull
    @Override
    public Dialog onCreateDialog(@Nullable Bundle savedInstanceState) {
        AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
        LayoutInflater inflater = getActivity().getLayoutInflater();
        View view = inflater.inflate(R.layout.edit_profile_dialog,null);
        builder.setView(view)
                .setTitle(this.dialogTitle)
                .setNegativeButton("cancel", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {

                    }
                })
                .setPositiveButton("ok", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        switch (editingParameterEnum) {
                            case STRING:
                                listener.applyTextString(editValueString.getText().toString());
                                break;
                            case FLOAT:
                                listener.applyTextFloat(editValueFloat.getText().toString());
                                break;
                            case BOOLEAN:
                                listener.applyTextBoolean(editValueBoolean.isChecked());
                                break;
                        }
                    }
                });

        this.editValueString = view.findViewById(R.id.et_edit_profile_value_string);
        this.editValueFloat = view.findViewById(R.id.et_edit_profile_value_float);
        this.editValueBoolean = view.findViewById(R.id.s_edit_profile_gender);

        this.editValueString.setVisibility(View.INVISIBLE);
        this.editValueFloat.setVisibility(View.INVISIBLE);
        this.editValueBoolean.setVisibility(View.INVISIBLE);

        switch (editingParameterEnum) {
            case STRING:
                this.editValueString.setVisibility(View.VISIBLE);
                this.editValueString.setText(this.dialogValueString);
                break;
            case FLOAT:
                this.editValueFloat.setVisibility(View.VISIBLE);
                this.editValueFloat.setText(this.dialogValueFloat);
                break;
            case BOOLEAN:
                this.editValueBoolean.setVisibility(View.VISIBLE);
                this.editValueBoolean.setChecked(this.dialogValueBoolean);
                break;
        }
        return builder.create();
    }

    @Override
    public void onAttach(@NonNull Context context) {
        super.onAttach(context);
        try {
            listener = (ExampleDialogListener) context;
        } catch (ClassCastException e) {
            throw new ClassCastException(context.toString() + "must implement ExampleDialogListener");
        }

    }

    public interface  ExampleDialogListener {
        void applyTextString(String value);
        void applyTextFloat(String value);
        void applyTextBoolean(boolean value);
    }
}
