import 'package:flutter/material.dart';
import 'package:pomodoro_app/screens/home_screen.dart';
import 'package:pomodoro_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro',
     
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/splashscreen': (context) => SplashScreen(),
        '/homescreen': (context) => Home(),
      },
      home: SplashScreen(),
      initialRoute: '/splashscreen',
    );
  }
}
