class Product {
  String description;
  dynamic discount;
  int id;
  String image;
  List<String> images;
  bool in_cart;
  bool in_favorites;
  String name;
  dynamic old_price;
  dynamic price;

  Product(
      {this.description,
      this.discount,
      this.id,
      this.image,
      this.images,
      this.in_cart,
      this.in_favorites,
      this.name,
      this.old_price,
      this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      description: json['description'],
      discount: json['discount'],
      id: json['id'],
      image: json['image'],
      images:
          json['images'] != null ? new List<String>.from(json['images']) : null,
      in_cart: json['in_cart'],
      in_favorites: json['in_favorites'],
      name: json['name'],
      old_price: json['old_price'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['discount'] = this.discount;
    data['id'] = this.id;
    data['image'] = this.image;
    data['in_cart'] = this.in_cart;
    data['in_favorites'] = this.in_favorites;
    data['name'] = this.name;
    data['old_price'] = this.old_price;
    data['price'] = this.price;
    if (this.images != null) {
      data['images'] = this.images;
    }
    return data;
  }
}
