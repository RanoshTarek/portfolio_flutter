class UserBody {
  String email;
  String password;

  UserBody({this.email, this.password});

  factory UserBody.fromJson(Map<String, dynamic> json) {
    return UserBody(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
