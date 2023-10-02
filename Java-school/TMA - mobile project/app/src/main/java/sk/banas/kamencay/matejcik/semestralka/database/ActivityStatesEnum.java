package sk.banas.kamencay.matejcik.semestralka.database;

import androidx.annotation.NonNull;

public enum ActivityStatesEnum {

    CHOOSED {
        @NonNull
        @Override
        public String toString() {
            return "choosed";
        }
    },
    STARTED {
        @NonNull
        @Override
        public String toString() {
            return "started";
        }
    },
    ENDED {
        @NonNull
        @Override
        public String toString() {
            return "ended";
        }
    }

}
