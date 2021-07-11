class UserBodyRegister {
  String name;
  String phone;
  String email;
  String password;

  UserBodyRegister({this.email, this.password, this.name, this.phone});

  factory UserBodyRegister.fromJson(Map<String, dynamic> json) {
    return UserBodyRegister(
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['name'] = this.name;
    return data;
  }
}

class UserBodyUpdate {
  String name;
  String phone;
  String email;

  UserBodyUpdate({this.email, this.name, this.phone});

  factory UserBodyUpdate.fromJson(Map<String, dynamic> json) {
    return UserBodyUpdate(
      email: json['email'],
      phone: json['phone'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['name'] = this.name;
    return data;
  }
}
