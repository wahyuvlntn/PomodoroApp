import 'package:flutter/material.dart';
import 'package:pomodoro_app/extension/time_format.dart';
import 'package:pomodoro_app/utils/my_button.dart';

class DialogBox extends StatefulWidget {
  final TextEditingController taskController;
  final TextEditingController descController;
  final Function() onSave;
  final Function() onCancel;
  final Function() onTimePicker;
  final Function() onDatePicker;
  final TimeOfDay timeOfDay;
  final String date;
  final bool isEdit;
  final String? initTask;
  final String? initDesc;

  const DialogBox({
    Key? key,
    required this.onSave,
    required this.onCancel,
    required this.taskController,
    required this.onDatePicker,
    required this.descController,
    required this.onTimePicker,
    required this.timeOfDay,
    required this.date,
    this.isEdit = false,
    this.initTask,
    this.initDesc,
  }) : super(key: key);

  @override
  _DialogBoxState createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Task'),
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 300, //size
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              initialValue: widget.isEdit ? widget.initTask! : null,
              controller: widget.taskController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task",
              ),
            ),
            TextFormField(
              initialValue: widget.isEdit ? widget.initDesc! : null,
              controller: widget.descController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a desc",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //display choose time
                Text(
                  widget.timeOfDay.to24hours(),
                  // widget.timeOfDay.format(context).toString(),
                  style: const TextStyle(fontSize: 15),
                ),

                // button
                TextButton.icon(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(color: Colors.blue),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                  onPressed: widget.onTimePicker,
                  icon: const Icon(
                    Icons.access_alarm,
                  ),
                  label: const Text(
                    'Pick Time',
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //display choose time
                Text(
                  widget.date,
                  style: const TextStyle(fontSize: 15),
                ),

                // button
                TextButton.icon(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(color: Colors.blue),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                  onPressed: widget.onDatePicker,
                  icon: const Icon(
                    Icons.calendar_month,
                  ),
                  label: const Text('Pick Date'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(text: "Save", onPressed: widget.onSave),
                const SizedBox(width: 8),
                MyButton(text: "Cancel", onPressed: widget.onCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}