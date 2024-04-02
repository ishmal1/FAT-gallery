import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String name;
  final String address;
  final String? description;
  final String? imageURL;

  Product({
    required this.name,
    required this.address,

     this.description,
     this.imageURL,
  });

  factory Product.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return Product(
      name: data['restaurantName'],
      address: data['address'],
      description: data['description'],
      imageURL: data['imageURL'],
    );
  }
}
