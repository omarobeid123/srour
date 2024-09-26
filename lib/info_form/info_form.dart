import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sesame/home_screen/srour.dart';
import 'package:sesame/shop_cart/cubit/cart_cubit.dart';
import '../models/product_model.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({super.key, required this.products});
  final List<ProductModel> products;

  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();

  bool _isNameEmpty = false;
  bool _isPhoneInvalid = false;
  bool _isCityEmpty = false;
  bool _isRegionEmpty = false;
  bool _isStreetEmpty = false;

  Future<void> _handleRefresh() async {
    // Implement refresh logic here if needed
  }

  void _handleConfirmButton() async {
    setState(() {
      _isNameEmpty = _nameController.text.isEmpty;
      _isPhoneInvalid = _phoneController.text.length != 9;
      _isCityEmpty = _cityController.text.isEmpty;
      _isRegionEmpty = _regionController.text.isEmpty;
      _isStreetEmpty = _streetController.text.isEmpty;
    });

    if (!_isNameEmpty &&
        !_isPhoneInvalid &&
        !_isCityEmpty &&
        !_isRegionEmpty &&
        !_isStreetEmpty) {
      final CollectionReference productsCollection =
          FirebaseFirestore.instance.collection('orders');
      await productsCollection.add({
        "name": _nameController.text,
        "phone": _phoneController.text,
        "city": _cityController.text,
        "area": _regionController.text,
        "street": _streetController.text,
        "price": context.read<CartCubit>().calculateTotal(widget.products) + 2,
        "date": DateFormat('dd-MM-yyyy').format(DateTime.now()),
        "orders": widget.products.map((e) => e.toJson()).toList(),
        "count": context.read<CartCubit>().quantities,
        "states": 0
      });
      context.read<CartCubit>().clearCart();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: const Text('! تم استلام طلبك '),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('سيتم توصيل منتجك في أقرب وقت'),
                  const SizedBox(height: 16),
                  Image.network(
                    'https://i.postimg.cc/mkRV9NjY/ic-launcher.png',
                    height: 100,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Srour(),
                        ),
                      );
                    },
                    child: const Text(
                      'إضافة المزيد من المنتجات',
                      style: TextStyle(
                        color: Colors.green,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(98, 206, 60, 1),
        title: const Text(
          'رجوع',
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
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            physics:
                AlwaysScrollableScrollPhysics(), // Allow scrolling even if not overscrolling
            child: Column(
              children: [
                CustomTextField(
                  label: 'الاسم',
                  hint: 'ادخل اسمك',
                  controller: _nameController,
                  isEmpty: _isNameEmpty,
                ),
                const SizedBox(height: 16),
                PhoneNumberField(
                  controller: _phoneController,
                  isInvalid: _isPhoneInvalid,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'المدينة',
                  hint: 'ادخل اسم المدينة',
                  controller: _cityController,
                  isEmpty: _isCityEmpty,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'المنطقة',
                  hint: 'ادخل اسم المنطقة',
                  controller: _regionController,
                  isEmpty: _isRegionEmpty,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'اسم الشارع',
                  hint: 'ادخل اسم الشارع',
                  controller: _streetController,
                  isEmpty: _isStreetEmpty,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 80),
                  ),
                  onPressed:
                      _handleConfirmButton, // تعيين الدالة المناسبة للضغط
                  child: Text(
                    'ارسال الطلب',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  bool isEmpty;

  CustomTextField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.isEmpty,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(widget.label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            hintText: widget.hint,
            filled: true,
            fillColor: widget.isEmpty ? Colors.red[100] : Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: widget.isEmpty
                  ? const BorderSide(color: Colors.red)
                  : BorderSide.none,
            ),
          ),
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}

class PhoneNumberField extends StatefulWidget {
  final TextEditingController controller;
  bool isInvalid;

  PhoneNumberField({required this.controller, required this.isInvalid});

  @override
  _PhoneNumberFieldState createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text('رقم الهاتف', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c0/Flag_of_Jordan.svg/1200px-Flag_of_Jordan.svg.png',
                    width: 30,
                  ),
                  const SizedBox(width: 8),
                  const Text('+962 '),
                ],
              ),
            ),
            hintText: '7 X X X X X X X X',
            filled: true,
            fillColor: widget.isInvalid ? Colors.red[100] : Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: widget.isInvalid
                  ? const BorderSide(color: Colors.red)
                  : BorderSide.none,
            ),
          ),
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(9),
          ],
        ),
      ],
    );
  }
}
