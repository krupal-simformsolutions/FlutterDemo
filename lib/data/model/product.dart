import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class Product {
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "image")
  String image;

  Product({required this.id, required this.name, required this.image});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "image": image,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      name: json["name"],
      image: json["image"],
    );
  }
//
}
