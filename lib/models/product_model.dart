import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String productName;
  String productImage;
  int productPrice;
  String productId;
  int productQuantity;
  String productDescription;
  List<dynamic>productUnit;
  ProductModel(
      {
      this.productQuantity,
      this.productId,
      this.productUnit,
      this.productImage,
      this.productName,
      this.productPrice, this.productDescription});

    factory ProductModel.fromDocument(DocumentSnapshot doc) {
    return ProductModel(
      productName: doc['productName'],
      productImage: doc['productImage'],
      productPrice: doc['productPrice'],
      productId: doc['productId'],
      productUnit: doc['productUnit'],
      productDescription: doc['description'],
    );
  }
}
