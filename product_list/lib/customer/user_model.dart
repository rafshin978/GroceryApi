import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class User {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String? email;

  @HiveField(3)
  final String? mobileNumber;

  @HiveField(4)
  final String? city;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.city,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@HiveType(typeId: 3)
@JsonSerializable()
class UserDetails {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String? email;

  @HiveField(3)
  final String? mobileNumber;

  @HiveField(4)
  final String? city;

  UserDetails({
    this.id,
    this.name,
    this.email,
    this.mobileNumber,
    this.city,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
        id: json['id'],
        name: json['name'],
        mobileNumber: json['mobile_number'],
        email: json['email'],
        city: json['city']);
  }
}
