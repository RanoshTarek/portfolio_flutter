import 'package:first_app/model/home/home_module.dart';

class FavouriteListResponse {
  Data data;
  String message;
  bool status;

  FavouriteListResponse({this.data, this.message, this.status});

  factory FavouriteListResponse.fromJson(Map<String, dynamic> json) {
    return FavouriteListResponse(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      message: json['message'] != null ? json['message'] : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    if (this.message != null) {
      data['message'] = this.message;
    }
    return data;
  }
}

class Data {
  List<DataX> data;
  int current_page;
  String first_page_url;
  int from;
  int last_page;
  String last_page_url;
  Object next_page_url;
  String path;
  int per_page;
  Object prev_page_url;
  int to;
  int total;

  Data(
      {this.data,
      this.current_page,
      this.first_page_url,
      this.from,
      this.last_page,
      this.last_page_url,
      this.next_page_url,
      this.path,
      this.per_page,
      this.prev_page_url,
      this.to,
      this.total});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => DataX.fromJson(i)).toList()
          : null,
      current_page: json['current_page'],
      first_page_url: json['first_page_url'],
      from: json['from'],
      last_page: json['last_page'],
      last_page_url: json['last_page_url'],
      next_page_url:
          json['next_page_url'] != null ? json['next_page_url'] : null,
      path: json['path'],
      per_page: json['per_page'],
      prev_page_url:
          json['prev_page_url'] != null ? json['prev_page_url'] : null,
      to: json['to'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.current_page;
    data['first_page_url'] = this.first_page_url;
    data['from'] = this.from;
    data['last_page'] = this.last_page;
    data['last_page_url'] = this.last_page_url;
    data['path'] = this.path;
    data['per_page'] = this.per_page;
    data['to'] = this.to;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.next_page_url != null) {
      data['next_page_url'] = this.next_page_url;
    }
    if (this.prev_page_url != null) {
      data['prev_page_url'] = this.prev_page_url;
    }
    return data;
  }
}

class DataX {
  int id;
  Product product;

  DataX({this.id, this.product});

  factory DataX.fromJson(Map<String, dynamic> json) {
    return DataX(
      id: json['id'],
      product:
          json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}

// class Product {
//   String description;
//   int discount;
//   int id;
//   String image;
//   String name;
//   int old_price;
//   int price;
//
//   Product(
//       {this.description,
//       this.discount,
//       this.id,
//       this.image,
//       this.name,
//       this.old_price,
//       this.price});
//
//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       description: json['description'],
//       discount: json['discount'],
//       id: json['id'],
//       image: json['image'],
//       name: json['name'],
//       old_price: json['old_price'],
//       price: json['price'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['description'] = this.description;
//     data['discount'] = this.discount;
//     data['id'] = this.id;
//     data['image'] = this.image;
//     data['name'] = this.name;
//     data['old_price'] = this.old_price;
//     data['price'] = this.price;
//     return data;
//   }
// }
