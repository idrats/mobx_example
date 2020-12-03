import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_overview/todo_list.dart';
import 'package:provider/provider.dart';

class ActionBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoList = Provider.of<TodoList>(context);

    return Column(
      children: [
        Observer(
          builder: (_) => Column(
            children: [
              RadioListTile(
                  title: const Text('Все'),
                  value: VisibilityFilter.all,
                  groupValue: todoList.filter,
                  onChanged: (filter) => todoList.filter = filter),
              RadioListTile(
                  title: const Text('Ожидают выполнения'),
                  value: VisibilityFilter.pending,
                  groupValue: todoList.filter,
                  onChanged: (filter) => todoList.filter = filter),
              RadioListTile(
                  title: const Text('Завершены'),
                  value: VisibilityFilter.completed,
                  groupValue: todoList.filter,
                  onChanged: (filter) => todoList.filter = filter),
            ],
          ),
        ),
        Observer(
            builder: (_) => ButtonBar(
                  children: [
                    RaisedButton(
                        child: const Text('Удалить завершенные'),
                        onPressed: todoList.canRemoveAllCompleted
                            ? todoList.removeCompleted
                            : null),
                    RaisedButton(
                        child: const Text('Пометить все как выполненные'),
                        onPressed: todoList.canMarkAllAsCompleted
                            ? todoList.markAllAsCompleted
                            : null),
                  ],
                ))
      ],
    );
  }
}
