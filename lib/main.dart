import 'package:flutter/material.dart';
import "package:shop_ecommerce_app/providers/cart_provider.dart";
import "package:shop_ecommerce_app/pages/home_page.dart";
import "package:provider/provider.dart";

void main() {
  runApp(const MyApp());
}

// provider types
// 1) Provider => readonly
// 2) ChangeNotifierProvider
// 3) FutureProvider
// 4) StreamProvider

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        )
      ],
      child: MaterialApp(
        title: "Shopping App",
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(fontSize: 25, color: Colors.black),
          ),
          fontFamily: "Montserrat",
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(fontSize: 12),
            prefixStyle: TextStyle(fontSize: 12),
            prefixIconColor: Color.fromRGBO(119, 119, 119, 1),
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(233, 211, 98, 1),
            primary: const Color.fromRGBO(233, 211, 98, 1),
            // background: const Color.fromRGBO(20, 18, 7, 1),
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
            titleMedium: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            bodySmall: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
