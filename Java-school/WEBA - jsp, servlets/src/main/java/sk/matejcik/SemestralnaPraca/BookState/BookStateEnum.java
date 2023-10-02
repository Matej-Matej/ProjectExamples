package sk.matejcik.SemestralnaPraca.BookState;

public enum BookStateEnum {
    READING {
        @Override
        public String toString() {
            return "reading";
        }
    },
    PLAN_TO_READ {
        @Override
        public String toString() {
            return "planToRead";
        }
    },
    COMPLETED {
        @Override
        public String toString() {
            return "completed";
        }
    }
}