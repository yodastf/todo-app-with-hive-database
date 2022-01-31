
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/domain/entity/task.dart';
part 'group.g.dart';

@HiveType(typeId: 1)
class Group extends HiveObject{
  // last used HiveField key 1
  @HiveField(0)
  String name;



  Group({required this.name});

 

}