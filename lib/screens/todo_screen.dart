import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro_app/extension/time_format.dart';
import 'package:pomodoro_app/utils/dialog_box.dart';
import 'package:pomodoro_app/utils/todo_tile.dart';

import '../utils/toDoList.dart';

class ToDo extends StatefulWidget {
  const ToDo({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  //text controllers
  TextEditingController taskController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void dispose() {
    taskController.dispose();
    descController.dispose();
    super.dispose();
  }

  // TimeOfDay time = TimeOfDay(hour: 10, minute: 30);
  TimeOfDay timeOfDay = TimeOfDay.now();
  void showTime() {
    showTimePicker(context: context, initialTime: timeOfDay).then((value) {
      setState(() {
        timeOfDay = value!;
      });
    });
  }

  DateTime dateTime = DateTime.now();

  Future<DateTime> showDate() async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now(),
    );

    return dateTime = picker ?? DateTime.now();
  }

  // makelist to do tasks
  // List toDoList = [
  //   [
  //     false,
  //     "Kalkulus",
  //     "10:00 ~ 11 April 2023",
  //     "Mengerjakan Latihan 1 di Google Classroom"
  //   ],
  //   [false, "PBO", "02:30 ~ 11 April 2023", "Mengerjakan study case di Eling"],
  // ];

  // chekbox ws tapped
  void checkBoxChange(bool? value, int index) {
    //buat state untuk update
    setState(() {
      toDoList[index][0] = !toDoList[index][0];
    });
  }

  //save new task
  void saveNewTask() {
    String time = '${timeOfDay.to24hours()} ~'
        ' ${DateFormat('dd MMMM yyyy').format(dateTime)}';
    setState(() {
      toDoList.add([
        false,
        taskController.text,
        time,
        descController.text,
      ]);
      taskController.clear();
      descController.clear();
    });
    Navigator.of(context).pop();
  }

  // create new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          taskController: taskController,
          descController: descController,
          onSave: saveNewTask,
          onTimePicker: showTime,
          timeOfDay: timeOfDay,
          date: DateFormat('dd MMMM yyyy').format(dateTime),
          onDatePicker: showDate,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  TimeOfDay timeOfDayEdit = TimeOfDay.now();

  void showTimeEdit() {
    showTimePicker(context: context, initialTime: timeOfDayEdit).then((value) {
      setState(() {
        timeOfDayEdit = value ?? TimeOfDay.now();
      });
    });
  }

  DateTime date = DateTime.now();

  Future<DateTime> showDateEdit() async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now(),
    );

    return date = picker ?? DateTime.now();
  }

  // edit task
  void editTask(int i) {
    TextEditingController taskControllerEdit = TextEditingController();
    TextEditingController descControllerEdit = TextEditingController();

    String initTask = toDoList[i][1];
    String initDesc = toDoList[i][3];

    print(initTask);
    print(initDesc);

    String item = toDoList[i][2];
    var list = item.split(' ~ ');

    timeOfDayEdit = TimeOfDay(
      hour: int.parse(list.first.split(":")[0]),
      minute: int.parse(list.first.split(":")[1]),
    );

    date = DateFormat('dd MMMM yyyy').parse(list.last);

    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          isEdit: true,
          initTask: initTask,
          initDesc: initDesc,
          taskController: taskControllerEdit,
          descController: descControllerEdit,
          onSave: () {
            String time = '${timeOfDayEdit.to24hours()} ~'
                ' ${DateFormat('dd MMMM yyyy').format(date)}';

            toDoList[i][1] = taskControllerEdit.text;
            toDoList[i][2] = time;
            toDoList[i][3] = descControllerEdit.text;

            Navigator.of(context).pop();
            taskControllerEdit.clear();
            descControllerEdit.clear();
          },
          onTimePicker: showTimeEdit,
          timeOfDay: timeOfDayEdit,
          date: DateFormat('dd MMMM yyyy').format(date),
          onDatePicker: showDateEdit,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5CDBBD),
      // backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('MY TO DO'),
        backgroundColor: Color(0xFF5CDBBD),
      ),

      floatingActionButton: Center(
        child: FloatingActionButton(
              onPressed: createNewTask,
              backgroundColor: Colors.white,
              child: const Icon(Icons.add, color: Colors.black,),
            ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      
      body: 
          ListView.builder(
            
            itemCount: toDoList.length,
            itemBuilder: (context, i) {
              return ToDoTile(
                taskName: toDoList[i][1],
                timeName: toDoList[i][2],
                descName: toDoList[i][3],
                taskCompleted: toDoList[i][0],
                onChanged: (value) => checkBoxChange(value, i),
                deleteFunction: (context) => deleteTask(i),
                editFunction: (context) => editTask(i),
              );
            },
          ),
          
        
      );
    
  }
}