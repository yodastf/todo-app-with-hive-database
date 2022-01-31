import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/domain/data_provider/box_manager.dart';
import 'package:todo_app/domain/entity/group.dart';
import 'package:todo_app/domain/entity/task.dart';
import 'package:todo_app/widgets/navigation/main_navigation.dart';
import 'package:todo_app/widgets/tasks/tasks_widget.dart';

class GroupsWidgetModel extends ChangeNotifier {

  late final Future<Box<Group>> _box;
  ValueListenable<Object>? _listenableBox; 
  var _groups = <Group>[];

  List<Group> get groups => _groups.toList();

  GroupsWidgetModel(){
    _setup();
  }

   Future<void> deleteGroups(int groupIndex) async{
    
    final box = await _box;
    final groupKey =(await _box).keyAt(groupIndex) as int;
    final taskBoxName = BoxManager.instance.makeTaskBoxName(groupKey);
    await Hive.deleteBoxFromDisk(taskBoxName);
 
    await box.deleteAt(groupIndex);
  }

  void showForm(BuildContext context){

    Navigator.of(context).pushNamed(MainNavigationRouteNames.groupsForm);

  }

   Future<void> showTasks(BuildContext context, int groupIndex) async{
    
    
    final group =(await _box).getAt(groupIndex);
    if(group != null){
       final configuration = TasksWidgetConfiguration(group.key as int,group.name);


      unawaited(Navigator.of(context).pushNamed(MainNavigationRouteNames.tasks,arguments: configuration),);
    }
   
    

  }


  

  Future<void> _readGroupsFromHive() async{
    _groups = (await _box).values.toList();
    notifyListeners();
  }

  void _setup() async {
    
   
    _box = BoxManager.instance.openGroupBox();

   
   await _readGroupsFromHive();
   _listenableBox = (await _box).listenable();
    _listenableBox?.addListener(_readGroupsFromHive);

  }

  @override
  Future<void> dispose() async{
    _listenableBox?.removeListener( _readGroupsFromHive );
    await BoxManager.instance.closeBox(await _box);
    super.dispose();
  }

}

class GroupsWidgetModelProvider extends InheritedNotifier{
  final GroupsWidgetModel model;
  const GroupsWidgetModelProvider({Key? key, required Widget child,required this.model}) : super(key: key,notifier:model,child: child);

  static GroupsWidgetModelProvider? watch(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<GroupsWidgetModelProvider>();
  }

  static GroupsWidgetModelProvider? read(BuildContext context){
    final widget = context.getElementForInheritedWidgetOfExactType<GroupsWidgetModelProvider>()?.widget;
    return widget is GroupsWidgetModelProvider ? widget : null;
  }

  




}