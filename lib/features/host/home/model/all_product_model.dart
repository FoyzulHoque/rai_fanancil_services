class ProductListResponse {
  final Meta? meta;
  final List<ProductModel>? data;

  ProductListResponse({this.meta, this.data});

  factory ProductListResponse.fromJson(Map<String, dynamic> json) {
    return ProductListResponse(
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      data: json['data'] != null
          ? List<ProductModel>.from(
          json['data'].map((x) => ProductModel.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "meta": meta?.toJson(),
    "data": data?.map((x) => x.toJson()).toList(),
  };
}

class Meta {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  Meta({this.page, this.limit, this.total, this.totalPage});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      totalPage: json['totalPage'],
    );
  }

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
    "totalPage": totalPage,
  };
}

class ProductModel {
  final String? id;
  final String? title;
  final String? image;
  final String? price;
  final String? quantity;
  final String? serialNumber;
  final String? createdAt;
  final String? updatedAt;

  ProductModel({
    this.id,
    this.title,
    this.image,
    this.price,
    this.quantity,
    this.serialNumber,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      price: json['price'],
      quantity: json['quantity'],
      serialNumber: json['serialNumber'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "price": price,
    "quantity": quantity,
    "serialNumber": serialNumber,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}
