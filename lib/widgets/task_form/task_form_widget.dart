import 'package:flutter/material.dart';
import 'package:todo_app/widgets/task_form/task_form_widget_model.dart';

class TaskFormWidget extends StatefulWidget {
  final int groupKey;
  const TaskFormWidget({ Key? key,required this.groupKey  }) : super(key: key);

  @override
  _TaskFormWidgetState createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  late final TaskFormWidgetModel _model;

  @override
  void initState() {
    
    super.initState();
    _model=TaskFormWidgetModel(groupKey: widget.groupKey);
  }




  @override
  Widget build(BuildContext context) {
    return TaskFormWidgetModelProvider(model: _model,child:_TextsWidgetBody(),);
  }
}

class _TextsWidgetBody extends StatelessWidget {
  const _TextsWidgetBody({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model =TaskFormWidgetModelProvider.watch(context)?.model;
    final actionButton = FloatingActionButton(
        onPressed: () => model?.saveTask(context),
        child: Icon(Icons.done),
      );
    return  Scaffold(
      appBar: AppBar(
        title: Text("New task"),
      ),
      body: Center(
        child: Container(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _TaskTextWidget(),
        ),),
      ),
      floatingActionButton: model?.isValid == true ? actionButton:null,
    );
  }
}

class _TaskTextWidget extends StatelessWidget {
  const _TaskTextWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TaskFormWidgetModelProvider.read(context)?.model;
    return TextField(
      autofocus: true,
      minLines: null,
      maxLines: null,
      expands: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Task text',
      
      ),
      onChanged: (value) =>model?.taskText = value,
      onEditingComplete: () => model?.saveTask(context),
    );
  }
}

