import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_overview/action_bar.dart';
import 'package:mobx_overview/add_todo.dart';
import 'package:mobx_overview/description.dart';
import 'package:mobx_overview/todo_list.dart';
import 'package:mobx_overview/todo_list_view.dart';
import 'package:provider/provider.dart';

class TodosPage extends StatefulWidget {
  @override
  _TodosPageState createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  TodoList todoList;
  ReactionDisposer disposer;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    todoList = TodoList();
    disposer = autorun((_) {
      if (todoList.todos.isEmpty && todoList.wasFulfiled)
        scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('Все дела выполнены'),
          ),
        );
    });
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<TodoList>(
      create: (_) => todoList,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Todo list example'),
        ),
        body: Column(
          children: [
            AddTodo(),
            ActionBar(),
            Description(),
            TodoListView(),
          ],
        ),
      ),
    );
  }
}
