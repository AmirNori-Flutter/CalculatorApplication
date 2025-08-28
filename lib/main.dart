import 'package:calculator/Pages/splash_scrren.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,

      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: isDark ? Colors.white : Color(0xFF151515),
            fontFamily: 'inter',
            fontSize: 48,
          ),
          displayMedium: TextStyle(
            color: Color(0xFF747474),
            fontFamily: 'inter',
            fontSize: 48,
          ),
        ),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF151515),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: isDark ? Colors.white : Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
        ),
      ),


      home: SplashScrren(),
    );
  }
}