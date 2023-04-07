import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:slide_popup_dialog_null_safety/slide_popup_dialog.dart' ;

import '../utils/todo_tile.dart';

class Pomodoro extends StatefulWidget {
  Pomodoro({Key? key}) : super(key: key);

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  
  int check = 2;
  double defaultValue = 300;
  double value = 300.0;
  bool isStarted = false;
  bool isPaused = false;
  bool isOver = false;
  int focusedMins = 0;
  late Timer _timer;
  //List <String> toDoList = ["Kalkulus","PBO",'Laprak Sisop'];
  late String taskName;
  bool isClick = false;
  List toDoList = [
    [
      false,
      "Kalkulus",
      "10:00 ~ 11 April 2023",
      "Mengerjakan Latihan 1 di Google Classroom"
    ],
    [false, "PBO", "02:30 ~ 11 April 2023", "Mengerjakan study case di Eling"],
  ];
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    
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
            check%2==0 ? isOver = true : isOver = false;
          });
          print(check);
          
          check++;
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

  void stopTimer() {
    _timer.cancel();
    setState(() {
      value = defaultValue;
      isPaused = false;
      isStarted = false;
    });
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
      backgroundColor: isStarted ? Color(0xFFA9CBE3) : isPaused?
      Color(0xFFFFB4AB):Color(0xFF5CDBBD),
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
                          isStarted? 'Dont wait for opportunities, create them. \n- Roy T. Bennett -' :
                          isPaused? "Procrastination is the thief of time. \n- Edward Young -" :
                          "If you can dream it, you can do it. \n- Walt Disney -",
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
                    const SizedBox(
                      height: 30,
                    ),
                     Center(
                       child: GestureDetector(
                        onTap: (){
                          showSlideDialog(
                          context: context,
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: toDoList.length,
                            itemBuilder: ( context,  index){
                              return 
                              GestureDetector(
                                
                                child: ToDoTile(
                                
                                taskName: toDoList[index][1],
                                timeName: toDoList[index][2],
                                descName: toDoList[index][3],
                                taskCompleted: toDoList[index][0],
                                ),
                                onTap: (){
                                  setState((){
                                    isClick = true;
                                    taskName = '${toDoList[index][1]}';
                                  });
                                },
                              );
                              // GestureDetector(
                              //   onTap: () {
                              //     setState(() {
                              //       isClick = true;
                              //     taskName = '${toDoList[index]}';
                              //     });
                                  
                              //   },
                              //   child: Container(
                              //     height: 36,
                              //     color: Color(0xFF5CDBBD),
                              //     child: Center(
                              //       child: Text('${toDoList[index]}'),
                              //     )
                              //   ),
                              // );
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            ),
                          barrierColor: Colors.white.withOpacity(0.7),
                          pillColor: Colors.red,
                          backgroundColor: Colors.white,
                        );
                        },
                        child: Container(
                        
                        height: 45,
                        width: 264,
                        decoration: BoxDecoration(
                          
                          color: isStarted ? Color(0xFF5A7B91) : isPaused?
                          Color(0xFFDE3730): Color(0xFF008770),
                          borderRadius: const BorderRadius.all(Radius.circular(30))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isClick? taskName:'Laprak Sisop',
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
                                  trackColor: isStarted ? Color(0xFF5A7B91) : isPaused?
                                  Color(0xFFDE3730) : Color(0xFF008770),
                                  progressBarColor: isStarted ? Color(0xFF294A5E) : isPaused?
                                  Color(0xFF690005) : Color(0xFF008770),
                                  hideShadow: true,
                                  dotColor: Colors.white,
                                  // dotColor: isStarted? Colors.white : isPaused ? Colors.white:Colors.transparent ,
                                  
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
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Center(
                                      child: Container(
                                        width: 100,
                                        height: 35,
                                        decoration: BoxDecoration(
                        
                                        color: isStarted ? Color(0xFF5A7B91) : isPaused?
                                        Color(0xFFDE3730): Color(0xFF008770),
                                        borderRadius: const BorderRadius.all(Radius.circular(20))
                                      ),
                                      child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          isOver? 'Break':
                                          isStarted?'Focus':isPaused?'Focus':'Idle',
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
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Center(
                                      child: Text(
                                        "${(value ~/ 60).toInt().toString().padLeft(2, '0')}:${(value % 60).toInt().toString().padLeft(2, '0')}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 46,
                                        ),
                                      ),
                                      
                                    ),
                                  ],
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
                              ),
                              
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if(!isStarted&&!isPaused)
                          SizedBox(
                            height: 50,
                            width: 150,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF008770),
                              textStyle: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Montserrat',
                                
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                              ),
                              ),
                            onPressed: () {
                              startTimer();
                              isStarted = true;
                            },
                            child: const Text('Start'),
                            ),
                          ),
                          if(isStarted&&!isPaused)
                          SizedBox(
                            height: 50,
                            width: 150,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF5A7B91),
                              textStyle: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Montserrat',
                                
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                              ),
                              ),
                            onPressed: () {
                              pauseTimer();
                              isStarted = false;
                              isPaused = true;
                            },
                            child: const Text('Pause'),
                            ),
                          ),
                          if(!isStarted&&isPaused)
                          Center(
                            child: Row(
                              children: [
                                SizedBox(
                                height: 50,
                                width: 150,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFFDAD6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                  ),
                                  ),
                                onPressed: () {
                                  startTimer();
                                  isStarted = true;
                                  isPaused = false;
                                },
                                child: const Text(
                                  'Continue',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Montserrat',
                                    color: Colors.black,
                                  ),
                                
                                ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                width: 150,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFBA1A1A),
                                  textStyle: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Montserrat',
                                    
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                  ),
                                  ),
                                onPressed: () {
                                  stopTimer();
                                  isStarted = false;
                                  isPaused = false;
                                },
                                child: const Text('Stop'),
                                ),
                              ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      
      
    );
    
  }
}
