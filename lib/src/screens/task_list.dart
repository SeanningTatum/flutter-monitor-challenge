import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';

import './create_task.dart';
import '../models/todo.dart';
import '../widgets/route_animations.dart';
import '../widgets/task.dart';

class TaskListScreen extends StatefulWidget {
  // TODO (Sean Urgel): Rename color to a better variable
  // and remove accentColor. Create a mapping to better
  // handle the situation in order to remove prop drilling
  final String title;
  final Color color;
  final Color accentColor;
  final String tag;
  final List<Todo> todos;

  TaskListScreen({
    Key key,
    @required this.title,
    @required this.color,
    @required this.tag,
    @required this.accentColor,
    @required this.todos,
  }) : super(key: key);

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  Function onPressTask(int ndx) => (bool value) {
        setState(() {
          widget.todos[ndx].isFinished = value;
        });
      };

  void onPressAdd(BuildContext context) async {
    final answer = await Navigator.of(context).push(
      NoAnimationSlideDown(
        builder: (BuildContext context) => CreateTaskScreen(
              backgroundColor: widget.color,
            ),
      ),
    );

    print(answer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        actions: [
          CircleAvatar(
            child: Text('S'),
          ),
          Padding(padding: EdgeInsets.only(right: 16))
        ],
      ),
      body: Hero(
        tag: widget.tag,
        child: SwipeDetector(
          onSwipeDown: Navigator.of(context).pop,
          child: Task(
            title: widget.title,
            color: widget.color,
            accentColor: widget.accentColor,
            todos: widget.todos,
            onPressTask: this.onPressTask,
            isSelected: true,
            onPressAdd: this.onPressAdd,
          ),
        ),
      ),
    );
  }
}
