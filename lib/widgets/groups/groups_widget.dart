import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/widgets/groups/groups_widget_model.dart';
import 'package:todo_app/widgets/groups_form/groups_form_widget_model.dart';

class GroupsWidget extends StatefulWidget {
  const GroupsWidget({ Key? key }) : super(key: key);

  @override
  State<GroupsWidget> createState() => _GroupsWidgetState();
}

class _GroupsWidgetState extends State<GroupsWidget> {
  final _model = GroupsWidgetModel();
  @override
  Widget build(BuildContext context) {
    return GroupsWidgetModelProvider(
      model: _model,
    child: _GroupsWidgetBody());
  }

  @override
  void dispose() async{
    await _model.dispose();
    super.dispose();
  }
}

class _GroupsWidgetBody extends StatelessWidget {
  const _GroupsWidgetBody({ Key? key }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Groups')),
      body: _GroupListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GroupsWidgetModelProvider.read(context)?.model.showForm(context),
        child: Icon(Icons.add),
        ),
    );
  }
}

class _GroupListWidget extends StatelessWidget {
  const _GroupListWidget({ Key? key }) : super(key: key);
  

  @override
   Widget build(BuildContext context) {
     final groupsCount = GroupsWidgetModelProvider.watch(context)?.model.groups.length ?? 0;
    return ListView.separated(
      itemCount: groupsCount,
      itemBuilder: (BuildContext context, int index){
        return _GroupListRowWidget( indexInList: index,);
      },
      separatorBuilder: (BuildContext context, int index){
        
        return const Divider(height: 1);
      },
      
      
    );
  }
}



class _GroupListRowWidget extends StatelessWidget {
  final int indexInList;
  const _GroupListRowWidget({ Key? key, required this.indexInList}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final model = GroupsWidgetModelProvider.read(context)!.model;
    final group = model.groups[indexInList];
    return Slidable(
      key: const ValueKey(0),

              

              
              endActionPane:  ActionPane(
                motion: const ScrollMotion(),
                children:  [
                  SlidableAction(
                    
                    flex: 2,
                    
                    onPressed: (dynamic) => model.deleteGroups(indexInList),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                  SlidableAction(
                    onPressed: null,
                    backgroundColor: Color(0xFF0392CF),
                    foregroundColor: Colors.white,
                    icon: Icons.save,
                    label: 'Save',
                  ),
                ],
              ),
      child: ListTile(
        title: Text(group.name),
        trailing: Icon(Icons.chevron_right),
        onTap: () => model.showTasks(context,indexInList),
        
      ),
    );
  }
}
