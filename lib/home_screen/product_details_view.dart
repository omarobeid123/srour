import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sesame/home_screen/home_screen.dart';
import 'package:sesame/models/product_model.dart';
import 'package:sesame/service/product_helper.dart';
import 'package:sesame/shop_cart/cubit/cart_cubit.dart';
import 'package:sesame/shop_cart/shop_cart.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.model});
  final ProductModel model;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  bool _isAddedToCart = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('رجوع'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Center(
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(widget.model.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              " ${widget.model.name}",
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              " ${widget.model.color}",
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8.0),
            const SizedBox(height: 8.0),
            const SizedBox(height: 170),
            Row(
              children: [
                if (!_isAddedToCart)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        ProductModel newProduct = ProductModel(
                            name: widget.model.name,
                            description: widget.model.description,
                            price: widget.model.price,
                            color: widget.model.color,
                            image: widget.model.image,
                            count: widget.model.count);
                        context.read<CartCubit>().addProduct(newProduct);
                        setState(() {
                          _isAddedToCart = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 24.0),
                      ),
                      child: const Text(
                        'إضافة لعربة التسوق',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                if (_isAddedToCart)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ShopCart(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 24.0),
                      ),
                      child: const Text(
                        'عرض عربة التسوق',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(width: 16.0),
                Text(
                  widget.model.price,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
