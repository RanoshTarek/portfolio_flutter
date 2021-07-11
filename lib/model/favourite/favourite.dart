import 'package:first_app/model/home/home_module.dart';

class FavouriteModule {
  Data data;
  String message;
  bool status;

  FavouriteModule({this.data, this.message, this.status});

  factory FavouriteModule.fromJson(Map<String, dynamic> json) {
    return FavouriteModule(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  Product product;

  Data({this.id, this.product});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
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
//   int discount;
//   int id;
//   String image;
//   int old_price;
//   int price;
//
//   Product({this.discount, this.id, this.image, this.old_price, this.price});
//
//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       discount: json['discount'],
//       id: json['id'],
//       image: json['image'],
//       old_price: json['old_price'],
//       price: json['price'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['discount'] = this.discount;
//     data['id'] = this.id;
//     data['image'] = this.image;
//     data['old_price'] = this.old_price;
//     data['price'] = this.price;
//     return data;
//   }
// }
