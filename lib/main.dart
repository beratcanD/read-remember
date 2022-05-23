import 'package:flutter/material.dart';
import 'package:login_page_firebase_flutter/constants.dart';
import 'package:login_page_firebase_flutter/pages/auth/main_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Login',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        colorScheme: const ColorScheme.light().copyWith(primary: kPrimaryColor),
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: kTextColor,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainPage(),
    );
  }
}