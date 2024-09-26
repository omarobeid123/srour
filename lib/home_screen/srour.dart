import 'package:flutter/material.dart';
import 'package:sesame/home_screen/hat.dart';
import 'package:sesame/home_screen/home_screen.dart';
import 'package:sesame/home_screen/mahtackat.dart';
import 'package:sesame/home_screen/maraba.dart';
import 'package:sesame/home_screen/shoclt.dart';
import 'package:sesame/home_screen/tahina.dart';
import 'package:sesame/shop_cart/shop_cart.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'home_scren.dart';

void main() {
  runApp(Srour());
}

class Srour extends StatefulWidget {
  @override
  _SrourState createState() => _SrourState();
}

class _SrourState extends State<Srour> {
  int _currentCircleIndex = 0;
  Timer? _timer;
  PageController _pageController = PageController(initialPage: 0);

  final List<String> _imageUrls = [
    'assets/srour/foreimage/1.jpg',
    'assets/srour/foreimage/2.jpg',
    'assets/srour/foreimage/3.jpg',
    'assets/srour/foreimage/4.jpg',
    'assets/srour/foreimage/5.png',
  ];

  @override
  void initState() {
    super.initState();
    _startCircleChangeTimer();
  }

  void _startCircleChangeTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      int nextPage = (_currentCircleIndex + 1) % _imageUrls.length;
      _pageController.animateToPage(
        nextPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentCircleIndex = nextPage;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToNewPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(98, 206, 60, 1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/srour/logo.png',
              width: 70,
              height: 70,
            ),
            SizedBox(width: 10),
            Flexible(
              fit: FlexFit.loose,
              child: Center(
                child: Text(
                  'SROUR',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShopCart()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                SizedBox(height: 20),
                Container(
                  width: constraints.maxWidth * 0.8,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PageView.builder(
                      controller: _pageController,
                      reverse: true,
                      onPageChanged: (index) {
                        setState(() {
                          _currentCircleIndex = index;
                        });
                      },
                      itemCount: _imageUrls.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          _imageUrls[index],
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.5),
                      child: CircleAvatar(
                        radius: 5,
                        backgroundColor: _currentCircleIndex == (4 - index)
                            ? Colors.green
                            : Colors.grey,
                      ),
                    );
                  }),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      '<< اختر الصنف',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
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
                        physics: NeverScrollableScrollPhysics(), // يمنع التمرير
                        children: [
                          ProductWidget(
                            imageUrl: 'assets/Halawa/2.jpg',
                            label: 'طحينة سرور',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => tahina()),
                              );
                            },
                          ),
                          ProductWidget(
                            imageUrl: 'assets/Halawa/1.jpg',
                            label: 'حلاوة سرور',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeView()),
                              );
                            },
                          ),
                          ProductWidget(
                            imageUrl: 'assets/Halawa/4.jpg',
                            label: 'شوكولا سرور',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => shoclt()),
                              );
                            },
                          ),
                          ProductWidget(
                            imageUrl: 'assets/Halawa/3.jpg',
                            label: 'مربى سرور',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => maraba()),
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
                          ProductWidget(
                            imageUrl: 'assets/Halawa/5.jpg',
                            label: 'معلبات سرور',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => mahtackat()),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 50), // إضافة مساحة فارغة هنا
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment(-0.9, 0.8), // تعديل الموقع هنا
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () => _navigateToNewPage(context),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.green,
              child: Icon(
                Icons.perm_phone_msg,
                size: 30,
                color: Colors.white,
              ),
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

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(98, 206, 60, 1),
        title: const Text(
          'رجوع',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme:
            IconThemeData(color: Colors.white), // تغيير لون أيقونة السهم هنا
      ),
      body: Container(
        color: Colors.green,
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Align(
                alignment: Alignment.topRight,
                child: Text(
                  'الحسابات',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  launch('https://web.facebook.com/Sroursrour2');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 83, vertical: 10),
                ),
                child: Text(
                  'فيسبوك شركة سرور',
                  style: TextStyle(color: Colors.green),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  launch(
                      'https://www.instagram.com/srour__company?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw==');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                ),
                child: Text(
                  'انستغرام شركة سرور',
                  style: TextStyle(color: Colors.green),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  launch(
                      'https://api.whatsapp.com/send/?phone=962780272000&text&type=phone_number&app_absent=0');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 83, vertical: 10),
                ),
                child: Text(
                  'واتساب شركة سرور',
                  style: TextStyle(color: Colors.green),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(
                color: Colors.white,
                thickness: 2,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  launch(
                      'https://api.whatsapp.com/send/?phone=962788526880&text&type=phone_number&app_absent=0');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 73, vertical: 10),
                ),
                child: Text(
                  'واتساب مطور التطبيق',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
