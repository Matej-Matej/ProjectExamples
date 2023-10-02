package sk.matejcik.SemestralnaPraca.User;

public enum UserRoleEnum {
    ADMIN {
        @Override
        public String toString() {
            return "admin";
        }
    },
    USER {
        @Override
        public String toString() {
            return "user";
        }
    }
}
