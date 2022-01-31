import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/widgets/tasks/tasks_widget_model.dart';

class TasksWidgetConfiguration {
  final int groupKey;
  final String title;

  TasksWidgetConfiguration(this.groupKey, this.title);
}

class TasksWidget extends StatefulWidget {
  final TasksWidgetConfiguration configuration;
  
  const TasksWidget({ Key? key, required this.configuration }) : super(key: key);

  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {

  late final TasksWidgetModel _model;

  @override
  void initState() {
    super.initState();

    _model=TasksWidgetModel(configuration: widget.configuration);
  }



  
    
  

  @override
  Widget build(BuildContext context) {
    final model = _model;
    if(model != null){
      return TasksWidgetModelProvider(
        model: model,
         child: const TasksWidgetBody() ,);
    }else{return Center(child: CircularProgressIndicator());}
    
  }

  @override
  void dispose() async{
    await _model.dispose();
    super.dispose();
  }
}

class TasksWidgetBody extends StatelessWidget {
  const TasksWidgetBody({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.watch(context)?.model;
    final title = model?.configuration.title ?? "Tasks";
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        
        ),
        body: _TaskListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model?.showForm(context),
        child: Icon(Icons.add),
        ),
      
    );
  }
}

class _TaskListWidget extends StatelessWidget {
  const _TaskListWidget({ Key? key }) : super(key: key);
  

  @override
   Widget build(BuildContext context) {
     final groupsCount = TasksWidgetModelProvider.watch(context)?.model.tasks.length ?? 0;
    return ListView.separated(
      itemCount: groupsCount,
      itemBuilder: (BuildContext context, int index){
        return _TaskListRowWidget( indexInList: index,);
      },
      separatorBuilder: (BuildContext context, int index){
        
        return const Divider(height: 1);
      },
      
      
    );
  }
}



class _TaskListRowWidget extends StatelessWidget {
  final int indexInList;
  const _TaskListRowWidget({ Key? key, required this.indexInList}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.read(context)!.model;
    final task = model.tasks[indexInList];

    final icon = task.isDone ? Icons.done : Icons.circle_outlined;
    final style = task.isDone ? TextStyle(decoration: TextDecoration.lineThrough) : null;
    return Slidable(
      key: const ValueKey(0),

              

  
              endActionPane:  ActionPane(
                motion: const ScrollMotion(),
                children:  [
                  SlidableAction(
  
                    flex: 2,
                    
                    onPressed: (dynamic) => model.deleteTask(indexInList),
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
        title: Text(
          task.text,
          style: style,
          
          ),
        trailing: Icon(icon),
        onTap: () => model.doneToggle(indexInList),
        
      ),
    );
  }
}