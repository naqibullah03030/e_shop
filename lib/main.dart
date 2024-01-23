import 'package:e_shop/cart_provider.dart';
import 'package:e_shop/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>CartProvider(),
      child: MaterialApp(
        title: 'E Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.yellow, primary: Colors.yellow),
          fontFamily: "Lato",
          useMaterial3: true,
          inputDecorationTheme: const InputDecorationTheme(
            iconColor: Color.fromRGBO(119, 119, 119, 1),
            hintStyle: TextStyle(
              color: Color.fromRGBO(
                0,
                0,
                0,
                0.7,
              ),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            titleMedium: TextStyle(fontSize: 18),
            titleSmall: TextStyle(fontSize: 14),
            bodySmall: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
