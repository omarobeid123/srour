import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sesame/home_screen/home_scren.dart';
import 'package:sesame/models/product_model.dart';
import 'package:sesame/service/product_helper.dart';
import 'package:sesame/shop_cart/cubit/cart_cubit.dart';
import 'package:sesame/shop_cart/cubit/cart_states.dart';

import '../info_form/info_form.dart';

class ShopCart extends StatefulWidget {
  const ShopCart({Key? key}) : super(key: key);

  @override
  State<ShopCart> createState() => _ShopCartState();
}

class _ShopCartState extends State<ShopCart> {
  @override
  void initState() {
    context.read<CartCubit>().getProducts();
    super.initState();
  }

  // Function to show the product image in a dialog
  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: 300,
                      height: 300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to add or update products in the cart based on similarity of name, description, and color
  void _addToCart(ProductModel newProduct, CartCubit cubit) {
    bool foundSimilar = false;

    for (int i = 0; i < cubit.products.length; i++) {
      ProductModel existingProduct = cubit.products[i];

      if (newProduct.name == existingProduct.name &&
          newProduct.description == existingProduct.description &&
          newProduct.color == existingProduct.color) {
        // Update quantity if all details match
        cubit.quantities[i]++;
        foundSimilar = true;
        break;
      }
    }

    if (!foundSimilar) {
      // Add new product if no similar product found
      cubit.products.add(newProduct);
      cubit.quantities.add(1); // Initial quantity
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartStates>(
      builder: (context, state) {
        var cubit = context.read<CartCubit>();
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromRGBO(98, 206, 60, 1),
            title: Center(
              child: Text(
                'عربة التسوق',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
          body: cubit.products.isEmpty
              ? const Center(child: Text('عربة التسوق فارغة'))
              : Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                              );
                            },
                            icon: Icon(Icons.add, color: Colors.green),
                            label: Text(
                              'إضافة منتجات',
                              style: TextStyle(color: Colors.green),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(color: Colors.green),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: cubit.products.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (cubit.products[index].image !=
                                            null) {
                                          _showImageDialog(context,
                                              cubit.products[index].image!);
                                        }
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          color: Colors.grey[300],
                                          child: cubit.products[index].image !=
                                                  null
                                              ? Image.network(
                                                  cubit.products[index].image!,
                                                  fit: BoxFit.cover,
                                                )
                                              : Center(
                                                  child: Text(
                                                    cubit.products[index].name,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cubit.products[index].name,
                                            style: TextStyle(fontSize: 16),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  IconButton(
                                                    icon: Icon(
                                                      cubit.quantities[index] >
                                                              1
                                                          ? Icons
                                                              .remove_circle_outline
                                                          : Icons
                                                              .delete_outline_rounded,
                                                      color: cubit.quantities[
                                                                  index] >
                                                              1
                                                          ? Colors.red
                                                          : Colors.red,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        if (cubit.quantities[
                                                                index] >
                                                            1) {
                                                          cubit.quantities[
                                                              index]--;
                                                        } else {
                                                          cubit.removeProduct(
                                                              index);
                                                        }
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                      '${cubit.quantities[index]}',
                                                      style: TextStyle(
                                                          fontSize: 18)),
                                                  IconButton(
                                                    icon: Icon(
                                                        Icons
                                                            .add_circle_outline,
                                                        color: Colors.green),
                                                    onPressed: () {
                                                      setState(() {
                                                        cubit.quantities[
                                                            index]++;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                  '\$${cubit.products[index].price.toString()}',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.grey)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'JD ${cubit.calculateTotal(cubit.products).toStringAsFixed(2)}',
                                      style: TextStyle(fontSize: 18)),
                                  Text('المجموع',
                                      style: TextStyle(fontSize: 18)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('JD 2', style: TextStyle(fontSize: 18)),
                                  Text('التوصيل',
                                      style: TextStyle(fontSize: 18)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'JD ${(cubit.calculateTotal(cubit.products) + 2).toStringAsFixed(2)}',
                                      style: TextStyle(fontSize: 18)),
                                  Text('الإجمالي',
                                      style: TextStyle(fontSize: 18)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PersonalInformationPage(
                                products: cubit.products,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'تأكيد الطلب',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 80),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
