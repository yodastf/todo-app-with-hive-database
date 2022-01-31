import 'package:flutter/material.dart';
import 'package:todo_app/widgets/groups/groups_widget.dart';
import 'package:todo_app/widgets/groups_form/groups_form_widget.dart';
import 'package:todo_app/widgets/groups_form/groups_form_widget_model.dart';
import 'package:todo_app/widgets/navigation/main_navigation.dart';
import 'package:todo_app/widgets/task_form/task_form_widget.dart';
import 'package:todo_app/widgets/tasks/tasks_widget.dart';

class MyApp extends StatelessWidget {

  static final mainNavigation = MainNavigation();
  const MyApp({Key? key}): super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes:mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute,
      onGenerateRoute: mainNavigation.onGenerateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      
    );
  }
}
