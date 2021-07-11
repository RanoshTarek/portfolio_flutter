class SearchModule {
  Data data;
  String message;
  bool status;

  SearchModule({this.data, this.message, this.status});

  factory SearchModule.fromJson(Map<String, dynamic> json) {
    return SearchModule(
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
  List<SearchProduct> data;
  int current_page;
  String first_page_url;
  int from;
  int last_page;
  String last_page_url;
  int next_page_url;
  String path;
  int per_page;
  int prev_page_url;
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
          ? (json['data'] as List)
              .map((i) => SearchProduct.fromJson(i))
              .toList()
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

class SearchProduct {
  String description;
  int id;
  String image;
  List<String> images;
  bool in_cart;
  bool in_favorites;
  String name;
  dynamic price;

  SearchProduct(
      {this.description,
      this.id,
      this.image,
      this.images,
      this.in_cart,
      this.in_favorites,
      this.name,
      this.price});

  factory SearchProduct.fromJson(Map<String, dynamic> json) {
    return SearchProduct(
      description: json['description'],
      id: json['id'],
      image: json['image'],
      images:
          json['images'] != null ? new List<String>.from(json['images']) : null,
      in_cart: json['in_cart'],
      in_favorites: json['in_favorites'],
      name: json['name'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['id'] = this.id;
    data['image'] = this.image;
    data['in_cart'] = this.in_cart;
    data['in_favorites'] = this.in_favorites;
    data['name'] = this.name;
    data['price'] = this.price;
    if (this.images != null) {
      data['images'] = this.images;
    }
    return data;
  }
}
