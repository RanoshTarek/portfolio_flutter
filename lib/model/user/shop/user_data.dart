class UserResponse {
  UserData data;
  String message;
  bool status;

  UserResponse({this.data, this.message, this.status});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['`data`'] = this.data.toJson();
    }
    return data;
  }
}

class UserData {
  int credit;
  String email;
  int id;
  String image;
  String name;
  String phone;
  int points;
  String token;

  UserData(
      {this.credit,
      this.email,
      this.id,
      this.image,
      this.name,
      this.phone,
      this.points,
      this.token});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      credit: json['credit'],
      email: json['email'],
      id: json['id'],
      image: json['image'],
      name: json['name'],
      phone: json['phone'],
      points: json['points'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['credit'] = this.credit;
    data['email'] = this.email;
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['points'] = this.points;
    data['token'] = this.token;
    return data;
  }
}
