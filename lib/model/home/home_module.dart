class HomeModule {
  Data data;
  String message;
  bool status;

  HomeModule({this.data, this.message, this.status});

  factory HomeModule.fromJson(Map<String, dynamic> json) {
    return HomeModule(
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
  String ad;
  List<Banner> banners;
  List<Product> products;

  Data({this.ad, this.banners, this.products});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      ad: json['ad'],
      banners: json['banners'] != null
          ? (json['banners'] as List).map((i) => Banner.fromJson(i)).toList()
          : null,
      products: json['products'] != null
          ? (json['products'] as List).map((i) => Product.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ad'] = this.ad;
    if (this.banners != null) {
      data['banners'] = this.banners.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

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

class Banner {
  Category category;
  int id;
  String image;
  Product product;

  Banner({this.category, this.id, this.image, this.product});

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
      id: json['id'],
      image: json['image'],
      product:
          json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}

class Category {
  int id;
  String image;
  String name;

  Category({this.id, this.image, this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      image: json['image'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    return data;
  }
}
