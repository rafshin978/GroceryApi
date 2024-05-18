import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'model_home.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()

class Product extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String image;

  @HiveField(3)
  int price;

  @HiveField(4)
  DateTime createdDateTime;

  @HiveField(5)
  DateTime modifiedDateTime;

  @HiveField(6)
  bool flag;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.createdDateTime,
    required this.modifiedDateTime,
    required this.flag,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    try {
      print('Parsing product with id: ${json['id']}');
      return Product(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        price: json['price'],
        createdDateTime: DateTime.parse('${json['created_date']} ${json['created_time']}'),
        modifiedDateTime: DateTime.parse('${json['modified_date']} ${json['modified_time']}'),
        flag: json['flag'],
      );
    } catch (e) {
      print('Error parsing product: $e');
      rethrow;
    }
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'createdDateTime': createdDateTime.toIso8601String(),
      'modifiedDateTime': modifiedDateTime.toIso8601String(),
      'flag': flag,
    };
  }
}


@HiveType(typeId: 1)
@JsonSerializable()
class ProductDetails extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String image;

  @HiveField(3)
  int price;

  ProductDetails({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    try {
      print('Parsing product details with id: ${json['id']}');
      return ProductDetails(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        price: json['price'],
      );
    } catch (e) {
      print('Error parsing product details: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
    };
  }
}
