class User {
  String? id;
  String? email;
  String? password;

  User({
    this.id,
    this.email,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
    };
  }

  User.fromMap(Map<String, dynamic> user) {
    id = user['id'];
    email = user['email'];
    password = user['password'];
  }
}
