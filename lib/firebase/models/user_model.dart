import 'dart:convert';

Usermodel usermodelFromJson(String str) => Usermodel.fromJson(json.decode(str));

String usermodelToJson(Usermodel data) => json.encode(data.toJson());

class Usermodel {
  Usermodel({
    required this.id,
    required this.email,
    required this.phone,
    required this.username,
  });

  String id;
  String email;
  String phone;
  String username;

  factory Usermodel.fromJson(Map<dynamic, dynamic> json) => Usermodel(
    id: json["id"],
    email: json["email"],
    phone: json["phone"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "id" : id,
    "email": email,
    "phone": phone,
    "username": username,
  };
}
