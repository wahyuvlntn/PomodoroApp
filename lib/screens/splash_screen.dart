import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF4A095),
              Color(0xFFB3C7BE),
              Color(0xFFD0E0E9),
              Color(0xFF82D2CB),
              Color(0xFF66D7BD),  
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to TIVY!',
              style: TextStyle(
                fontFamily: 'Monsterrat',
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.w600,
              )
            ),
            const SizedBox(height: 100),
            const Center(
              child: SizedBox(
                width: 235,
                height: 181,
                child: Image(
                  image: AssetImage('lib/assets/logo-tivy.png') 
                  ),
              ),
            ),
            const SizedBox(height: 100),
            const Text(
              'Get ready to streamline your work and \nstay on top of your to-do list like a pro.',
              textAlign: TextAlign.center ,
              maxLines: 2,
              style: TextStyle(
                fontFamily: 'Monsterrat',
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              )
            ),
            const SizedBox(height: 100),
            SizedBox(
              height: 58,
              width: 108,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pushReplacementNamed(context, '/homescreen');
                },
                child: Icon(Icons.arrow_forward, color: Colors.black,size: 28,),
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                 ),
              )
            ),
          ],
        )
      )
    );
  }
}