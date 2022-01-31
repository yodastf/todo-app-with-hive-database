import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/domain/data_provider/box_manager.dart';
import 'package:todo_app/domain/entity/group.dart';
import 'package:todo_app/domain/entity/task.dart';
import 'package:todo_app/widgets/navigation/main_navigation.dart';
import 'package:todo_app/widgets/tasks/tasks_widget.dart';



class TasksWidgetModel extends ChangeNotifier {
  TasksWidgetConfiguration configuration;
    ValueListenable<Object>? _listenableBox; 
  
   late final Future<Box<Task>> _box;
  late final Future<Box<Group>> _groupBox;


    var _tasks = <Task>[];

  List<Task> get tasks => _tasks.toList();
  
  TasksWidgetModel({required this.configuration}){
    _setup();
  }

  void showForm(BuildContext context){

    Navigator.of(context).pushNamed(MainNavigationRouteNames.tasksForm,arguments: configuration.groupKey);

  }

  

  Future<void> _readTasksFromHive() async{
    _tasks = (await _box).values.toList();
    notifyListeners();
  }

  Future<void> _setup() async {
    
  
    _box = BoxManager.instance.openTaskBox(configuration.groupKey);

  
  
   await _readTasksFromHive();
   _listenableBox = (await _box).listenable();
    _listenableBox?.addListener(_readTasksFromHive);

  }

    @override
  Future<void> dispose() async{
    _listenableBox?.removeListener( _readTasksFromHive );
    await BoxManager.instance.closeBox(await _box);
    super.dispose();
  }

  Future<void> doneToggle(int taskIndex) async{
    final task = (await _box).getAt(taskIndex);
    task?.isDone = !task.isDone;
    await task?.save();
  
  }

   Future<void> deleteTask(int taskIndex) async{

    await (await _box).deleteAt(taskIndex);
    

  
    
  }

}

class TasksWidgetModelProvider extends InheritedNotifier{
  final TasksWidgetModel model;
  const TasksWidgetModelProvider(
    {
    Key? key, 
    required Widget child,
    required this.model
    }) : super(
      key: key,
      child: child,
      notifier: model);

  static TasksWidgetModelProvider? watch(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<TasksWidgetModelProvider>();
  }

  static TasksWidgetModelProvider? read(BuildContext context){
    final widget = context.getElementForInheritedWidgetOfExactType<TasksWidgetModelProvider>()?.widget;
    return widget is TasksWidgetModelProvider ? widget : null;
  }

  
  
}