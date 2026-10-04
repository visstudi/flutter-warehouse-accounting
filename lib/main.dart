import 'package:flutter/material.dart';
import 'package:sandbox_app1/pages/login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        filledButtonTheme: FilledButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(15)),
            ),
            padding: EdgeInsets.all(15),
          ),
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: TextStyle(fontWeight: FontWeight.w600),
            foregroundColor: Colors.blue[500],
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
          ),
        ),

        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.grey[900],
          foregroundColor: Colors.white,
        ),
      ),

      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
