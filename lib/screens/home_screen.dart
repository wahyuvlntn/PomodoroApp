import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final List<Icon> timesCompleted = [];
  Home(){
    
  }

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5CDBBD),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Pomodoro number: 2',
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Set: 3',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: DotNavigationBar(
          margin: EdgeInsets.only(left: 10, right: 10),
          currentIndex: _currentIndex,
          backgroundColor: Colors.black,
          unselectedItemColor: Color(0xffA9ACA9),
          // enableFloatingNavBar: false,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            /// Home
            DotNavigationBarItem(
              icon: Icon(Icons.dashboard_customize_rounded),
              selectedColor: Colors.white,
            ),

            /// Likes
            DotNavigationBarItem(
              icon: Icon(Icons.home),
              selectedColor: Color(0xffA9ACA9),
            ),

            /// Search
            DotNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded),
              selectedColor: Color(0xffA9ACA9),
            ),
          ],
        ),
      ),
    );
  }
}
