// // product_helper.dart
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../models/product_model.dart';
//
// class ProductHelper {
//   static const String _keyProducts = 'products';
//
//   Future<void> saveProducts(List<ProductModel> products) async {
//     final prefs = await SharedPreferences.getInstance();
//     List<String> jsonProducts = products.map((product) => jsonEncode(product.toJson())).toList();
//     prefs.setStringList(_keyProducts, jsonProducts);
//   }
//
//   Future<List<ProductModel>> getProducts() async {
//     final prefs = await SharedPreferences.getInstance();
//     List<String>? jsonProducts = prefs.getStringList(_keyProducts);
//     if (jsonProducts != null) {
//       return jsonProducts.map((jsonProduct) => ProductModel.fromJson(jsonDecode(jsonProduct))).toList();
//
//     }
//     return [];
//   }
//
//   Future<void> updateProductName(int index, int count) async {
//     List<ProductModel> products = await getProducts();
//     if (index >= 0 && index < products.length) {
//       products[index].count = count;
//       await saveProducts(products);
//     }
//   }
//
//   Future<void> deleteProduct(int index) async {
//     List<ProductModel> products = await getProducts();
//     if (index >= 0 && index < products.length) {
//       products.removeAt(index);
//       await saveProducts(products);
//     }
//   }
//
//   Future<void> clearData() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_keyProducts);
//   }
// }
