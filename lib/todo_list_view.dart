import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_overview/todo_list.dart';
import 'package:provider/provider.dart';

class TodoListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoList = Provider.of<TodoList>(context);

    return Observer(
        builder: (_) => Flexible(
                child: ListView.builder(
              itemCount: todoList.visibleTodos.length,
              itemBuilder: (_, index) {
                final todo = todoList.visibleTodos[index];
                return Observer(
                    builder: (_) => CheckboxListTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                todo.description,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => todoList.removeTodo(todo))
                          ],
                        ),
                        value: todo.done,
                        onChanged: (flag) => todo.done = flag));
              },
            )));
  }
}
