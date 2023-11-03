// import 'dart:convert';

// List<ProductModel> productFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

// String productToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class ProductModel {
//   int? id;
//   String? title;
//   double? price;
//   String? description;
//   String? category;
//   String? image;
//   Rating? rating;

//   ProductModel({this.id, this.title, this.price, this.description, this.category, this.image, this.rating});

//   ProductModel.fromJson(Map<String, dynamic> json) {
//     if(json["id"] is int) {
//       id = json["id"];
//     }
//     if(json["title"] is String) {
//       title = json["title"];
//     }
//     if(json["price"] is double) {
//       price = json["price"];
//     }
//     if(json["description"] is String) {
//       description = json["description"];
//     }
//     if(json["category"] is String) {
//       category = json["category"];
//     }
//     if(json["image"] is String) {
//       image = json["image"];
//     }
//     if(json["rating"] is Map) {
//       rating = json["rating"] == null ? null : Rating.fromJson(json["rating"]);
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> _data = <String, dynamic>{};
//     _data["id"] = id;
//     _data["title"] = title;
//     _data["price"] = price;
//     _data["description"] = description;
//     _data["category"] = category;
//     _data["image"] = image;
//     if(rating != null) {
//       _data["rating"] = rating?.toJson();
//     }
//     return _data;
//   }
// }

// class Rating {
//   double? rate;
//   int? count;

//   Rating({this.rate, this.count});

//   Rating.fromJson(Map<String, dynamic> json) {
//     if(json["rate"] is double) {
//       rate = json["rate"];
//     }
//     if(json["count"] is int) {
//       count = json["count"];
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> _data = <String, dynamic>{};
//     _data["rate"] = rate;
//     _data["count"] = count;
//     return _data;
//   }
// }

// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> producFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
    int? id;
    String? title;
    double? price;
    String? description;
    Category? category;
    String? image;
    Rating? rating;

    ProductModel({
        this.id,
        this.title,
        this.price,
        this.description,
        this.category,
        this.image,
        this.rating,
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        price: json["price"].toDouble(),
        description: json["description"],
        category: categoryValues.map[json["category"]],
        image: json["image"],
        rating: Rating.fromJson(json["rating"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": categoryValues.reverse[category],
        "image": image,
        "rating": rating!.toJson(),
    };
}

enum Category {
    ELECTRONICS,
    JEWELERY,
    MEN_S_CLOTHING,
    WOMEN_S_CLOTHING
}

final categoryValues = EnumValues({
    "electronics": Category.ELECTRONICS,
    "jewelery": Category.JEWELERY,
    "men's clothing": Category.MEN_S_CLOTHING,
    "women's clothing": Category.WOMEN_S_CLOTHING
});

class Rating {
    double? rate;
    int? count;

    Rating({
        this.rate,
        this.count,
    });

    factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"].toDouble(),
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
