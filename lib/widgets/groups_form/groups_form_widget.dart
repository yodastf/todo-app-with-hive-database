import 'package:flutter/material.dart';
import 'package:todo_app/widgets/groups_form/groups_form_widget_model.dart';

class GruopFormWidget extends StatefulWidget {
  const GruopFormWidget({ Key? key }) : super(key: key);

  @override
  State<GruopFormWidget> createState() => _GruopFormWidgetState();
}

class _GruopFormWidgetState extends State<GruopFormWidget> {
  final _model = GroupFormWidgetModel();
  @override
  Widget build(BuildContext context) {
    return  GroupFormWidgetModelProvider(
      model: _model,
    child: _GroupsWidgetBody());
  }
}


class _GroupsWidgetBody extends StatelessWidget {
  const _GroupsWidgetBody({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("New group"),
      ),
      body: Center(
        child: Container(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _GroupNameWidget(),
        ),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GroupFormWidgetModelProvider.read(context)?.model.saveGroup(context),
        child: Icon(Icons.done),
      ),
    );
  }
}

class _GroupNameWidget extends StatelessWidget {
  const _GroupNameWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = GroupFormWidgetModelProvider.watch(context)?.model;
    return TextField(
      autofocus: true,
      decoration: InputDecoration(border: OutlineInputBorder(),
      hintText: 'Group Name',
      errorText: model?.errorText,
      
      ),
      onChanged: (value) =>model?.groupName = value,
      onEditingComplete: () => model?.saveGroup(context),
    );
  }
}