import 'package:flutter/material.dart';
import 'package:sesame/home_screen/products_list.dart';
import 'package:sesame/models/infinix_model.dart';
import 'package:sesame/shop_cart/shop_cart.dart';

// تعديل صفحة HomeView لإضافة زر للانتقال إلى صفحة الإعدادات
class mahtackat extends StatelessWidget {
  const mahtackat({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(98, 206, 60, 1),
            title: const Text(
              'معلبات سرور',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Stack(
            children: [
              TabBarView(
                children: [
                  ProductsList(
                    modelList: infinixModelList,
                  ),
                ],
              ),
              Positioned(
                top: MediaQuery.sizeOf(context).height / 3,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      )),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ShopCart(),
                        ),
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "عربه التسوق",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
