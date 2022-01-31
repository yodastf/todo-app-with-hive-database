
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/domain/data_provider/box_manager.dart';
import 'package:todo_app/domain/entity/group.dart';

class GroupFormWidgetModel extends ChangeNotifier{
  var _groupName ='';
  String? errorText;
  set groupName(String value){
    if(errorText !=null && value.trim().isNotEmpty){
      errorText = null;
      notifyListeners();
      }
      _groupName = value;

  }


  void saveGroup(BuildContext context) async{
   
    final groupName =_groupName.trim();
    if(groupName.isEmpty){ 
      errorText ='Input Group Name';
      notifyListeners();
      return;
      }

    final box = await BoxManager.instance.openGroupBox();
    final group = Group(name: groupName);
    await box.add(group);
    await BoxManager.instance.closeBox(box);
    Navigator.of(context).pop();
    

  }


}

class GroupFormWidgetModelProvider extends InheritedNotifier{
  final GroupFormWidgetModel model;
  const GroupFormWidgetModelProvider({Key? key, required Widget child,required this.model}) : super(key: key,notifier: model, child: child);

  static GroupFormWidgetModelProvider? watch(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<GroupFormWidgetModelProvider>();
  }

  static GroupFormWidgetModelProvider? read(BuildContext context){
    final widget = context.getElementForInheritedWidgetOfExactType<GroupFormWidgetModelProvider>()?.widget;
    return widget is GroupFormWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(GroupFormWidgetModelProvider oldWidget){
    return false;
  }




}