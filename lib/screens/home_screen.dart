import 'dart:async';

import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Home extends StatefulWidget {
  final List<Icon> timesCompleted = [];
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;
  double defaultValue = 300;
  double value = 300.0;
  bool isStarted = false;
  int focusedMins = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color(0xFFA9CBE3)));
    
  }

  void startTimer() {
    focusedMins = value.toInt();
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (value <= 1) {
          setState(() {
            timer.cancel();
            value = defaultValue;
            isStarted = false;
          });
        } else {
          setState(() {
            value--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void pauseTimer() {
  if (_timer.isActive) {
    _timer.cancel();
    setState(() {
      isStarted = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA9CBE3),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
          child: Column(
            children: <Widget>[
              Center(
                      child: Container(
                        child: Text(
                          'Dont wait for opportunities, create them.    - Roy T. Bennett -',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Monsterrat',
                            
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      )
                    ),
                     Center(
                      child: Container(
                      
                      height: 45,
                      width: 264,
                      decoration: BoxDecoration(
                        
                        color: Color(0xFF5A7B91),
                        borderRadius: const BorderRadius.all(Radius.circular(30))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Laprak Sisop',
                            style: TextStyle(
                              fontFamily: 'Monsterrat',
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          )
                        ]
                      ) 
                      ),
                      
                    ),
                    
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                   
                    Center(
                      child: SizedBox(
                        width: 250,
                        height: 250,
                        child: Stack(
                          children: [
                            SleekCircularSlider(
                              initialValue: value,
                              min: 0,
                              max: 5401,
                              appearance: CircularSliderAppearance(
                                customWidths: CustomSliderWidths(
                                  trackWidth: 15,
                                  handlerSize: 10,
                                  progressBarWidth: 15,
                                  shadowWidth: 0,
                                ),
                                customColors: CustomSliderColors(
                                  trackColor: Color(0xFF5A7B91),
                                  progressBarColor: Color(0xFF294A5E),
                                  hideShadow: true,
                                  dotColor: Colors.white,
                                  
                                ),
                                size: 250,
                                angleRange: 360,
                                startAngle: 270,
                              ),
                              onChange: (newValue) {
                                setState(() {
                                  value = newValue;
                                });
                              },
                              innerWidget: (double newValue) {
                                return Center(
                                  child: Text(
                                    "${(value ~/ 60).toInt().toString().padLeft(2, '0')}:${(value % 60).toInt().toString().padLeft(2, '0')}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 46,
                                    ),
                                  ),
                                );
                              },
                            ),
                            if (isStarted)
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 250,
                                  height: 250,
                                  color: Colors.transparent,
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (!isStarted) {
                            isStarted = true;
                            startTimer();
                          } else {
                            _timer.cancel();
                            value = defaultValue;
                            isStarted = false;
                          }
                        });
                      },
                      child: Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFF5A7B91),
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 3,
                              blurRadius: 3,
                              offset: const Offset(0, 3),
                              color: Colors.black.withOpacity(0.1),
                            )
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          isStarted ? "STOP" : "START",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Monsterrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
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
