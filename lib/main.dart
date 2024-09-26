import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sesame/home_screen/srour.dart';
import 'package:sesame/shop_cart/cubit/cart_cubit.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SROUR());
}

class SROUR extends StatelessWidget {
  const SROUR({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CartCubit(),
        ),
      ],
      child: const MaterialApp(
        title: "SROUR",
        debugShowCheckedModeBanner: false,
        home: ConnectionCheckScreen(),
      ),
    );
  }
}

class ConnectionCheckScreen extends StatefulWidget {
  const ConnectionCheckScreen({super.key});

  @override
  _ConnectionCheckScreenState createState() => _ConnectionCheckScreenState();
}

class _ConnectionCheckScreenState extends State<ConnectionCheckScreen> {
  bool isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkConnection();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        isConnected = result != ConnectivityResult.none;
      });
    });
  }

  Future<void> _checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      isConnected = connectivityResult != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isConnected ? Srour() : const OfflineScreen();
  }
}

class OfflineScreen extends StatelessWidget {
  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off, size: 100, color: Colors.green),
            SizedBox(height: 20),
            Text(
              'لا يوجد اتصال بالشبكة ',
              style: TextStyle(fontSize: 24, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
