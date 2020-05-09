class User {
  int userId;
  String email;
  String username;
  String password;
  String role;
  int branchId;
  String dated;

  User(this.userId, this.email, this.username, this.password, this.role,
      this.branchId, this.dated);

  User.fromMap(dynamic obj) {
    this.userId = obj["user_id"];
    this.email = obj["email"];
    this.username = obj["username"];
    this.password = obj["password"];
    this.role = obj["role"];
    this.branchId = obj["branch_id"];
    this.dated = obj["dated"];
  }

  Map<String, dynamic> toMap() {
    return {
      "user_id": userId,
      "email": email,
      "username": username,
      "password": password,
      "role": role,
      "branch_id": branchId,
      "dated": dated,
    };
  }
}
