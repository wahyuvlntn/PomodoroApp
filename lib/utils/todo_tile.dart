import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final String timeName;
  final String descName;

  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;
  final Function(BuildContext)? editFunction;

  const ToDoTile({
    super.key,
    required this.taskName,
    required this.timeName,
    required this.descName,
    required this.taskCompleted,
    this.onChanged,
    this.deleteFunction,
    this.editFunction,
  });
   
   

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Padding(
      //ini satu
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          // SlidableAction(
          //   onPressed: editFunction,
          //   icon: Icons.edit,
          //   backgroundColor: Colors.green,
          //   borderRadius: BorderRadius.circular(12),
          // ),
          SlidableAction(
            onPressed: deleteFunction,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(12),
          )
        ]),
        child: Container(
          padding: const EdgeInsets.all(20), //jarak dalem
          decoration: BoxDecoration(
              // color: Theme.of(context).colorScheme.primary,
              color: Colors.white, //warna kotak
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              //chekbox
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title
                  Text(
                    taskName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        // maxLines: 4,
                        decoration: taskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    timeName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        // maxLines: 4,
                        decoration: taskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),

                  const SizedBox(height: 6),

                  SizedBox(
                    width: 250,
                    child: RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: descName,
                        style: TextStyle(
                          color: Colors.black,
                          decoration: taskCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          // fontSize: 16.0,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}