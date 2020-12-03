import 'package:flutter/material.dart';
import 'package:mobx_overview/todo_list.dart';
import 'package:provider/provider.dart';

class AddTodo extends StatelessWidget {
  final _textController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final todoList = Provider.of<TodoList>(context);

    return TextField(
      autofocus: true,
      decoration: InputDecoration(
          labelText: 'Добавьте Todo', contentPadding: EdgeInsets.all(8)),
      controller: _textController,
      textInputAction: TextInputAction.done,
      onSubmitted: (String value) {
        todoList.addTodo(value);
        _textController.clear();
      },
    );
  }
}
