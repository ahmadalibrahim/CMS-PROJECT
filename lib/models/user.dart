class User {
  String firstName;
  String lastName;
  String email;
  String phone;
  String password;
  String token;
  int UserID;

  User(String firstName, String lastName, String email, String phone,
      int UserID, String password, String token) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.phone = phone;
    this.token = token;
    this.UserID = UserID;
    this.password = password;
  }
  String getEmail() {
    return this.email;
  }

  settToken(String token) {
    this.token = token;
  }

  String getfirstName() {
    return this.firstName;
  }

  String getlastName() {
    return this.lastName;
  }

  int getUserID() {
    return this.UserID;
  }

  String getToken() {
    return this.token;
  }
}
