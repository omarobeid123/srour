import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sesame/models/product_model.dart';
import 'package:sesame/service/product_helper.dart';
import 'package:sesame/shop_cart/cubit/cart_states.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialState());

  List<ProductModel> products = [];
  List<int> quantities = [];
  Map<String, bool> productInCart = {};

  void addProduct(ProductModel product) {
    if (productInCart.containsKey(product.name) &&
        productInCart[product.name]!) {

      int productIndex = products.indexWhere((p) => p.name == product.name);

      // Increment the quantity of the product
      if (productIndex != -1) {
        quantities[productIndex] += 1;
      }
    }else{
      products.add(product);
      quantities.add(1);
      productInCart[product.name] = true;
    }
    emit(AddCartState());
  }

  void removeProduct(int index) {
    if (index >= 0 && index < products.length) {
      productInCart[products[index].name] = false;
      products.removeAt(index);
      quantities.removeAt(index);
    }
    emit(DeleteCartState());
  }

  void clearCart() {
    products.clear();
    quantities.clear();
    productInCart.clear();
  }

  double calculateTotal(List<ProductModel> productsData) {
    double total = 0;
    for (int i = 0; i < productsData.length; i++) {
      total += double.parse(productsData[i].price) *
          quantities[i];
    }
    return total;
  }

  void updateQuantities() {
    quantities = List<int>.filled(products.length, 1);
    emit(UpdateCartState());
  }

  List<ProductModel> getProducts() {
    return products;
  }

  void incrementQuantity(ProductModel result) {}
}
