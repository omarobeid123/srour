import 'package:flutter/material.dart';
import 'package:sesame/home_screen/hat.dart';
import 'package:sesame/home_screen/home_screen.dart';
import 'package:sesame/home_screen/mahtackat.dart';
import 'package:sesame/home_screen/maraba.dart';
import 'package:sesame/home_screen/shoclt.dart';
import 'package:sesame/home_screen/tahina.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              'اختر الصنف',
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
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 15,
                  shrinkWrap: true,
                  children: [
                    ProductWidget(
                      imageUrl: 'assets/Halawa/1.jpg',
                      label: 'حلاوة سرور',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeView()),
                        );
                      },
                    ),
                    ProductWidget(
                      imageUrl: 'assets/Halawa/2.jpg',
                      label: 'طحينة سرور',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => tahina()),
                        );
                      },
                    ),
                    ProductWidget(
                      imageUrl: 'assets/Halawa/3.jpg',
                      label: 'مربى سرور',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => maraba()),
                        );
                      },
                    ),
                    ProductWidget(
                      imageUrl: 'assets/Halawa/4.jpg',
                      label: 'شوكولا سرور',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => shoclt()),
                        );
                      },
                    ),
                    ProductWidget(
                      imageUrl: 'assets/Halawa/5.jpg',
                      label: 'معلبات سرور',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => mahtackat()),
                        );
                      },
                    ),
                    ProductWidget(
                      imageUrl: 'assets/Halawa/6.jpg',
                      label: 'مشروبات',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Hat()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductWidget extends StatelessWidget {
  final String imageUrl;
  final String label;
  final VoidCallback onTap;

  ProductWidget(
      {required this.imageUrl, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipOval(
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
