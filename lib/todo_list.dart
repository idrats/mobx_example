import 'package:mobx/mobx.dart';
import 'package:mobx_overview/todo.dart';
part 'todo_list.g.dart';

enum VisibilityFilter { all, pending, completed }

class TodoList = _TodoList with _$TodoList;

abstract class _TodoList with Store {
  @observable
  ObservableList<Todo> todos = ObservableList<Todo>();

  @observable
  VisibilityFilter filter = VisibilityFilter.all;

  @observable
  bool wasFulfiled = false;

  @computed
  ObservableList<Todo> get pendingTodos =>
      ObservableList.of(todos.where((todo) => todo.done == false));

  @computed
  ObservableList<Todo> get completedTodos =>
      ObservableList.of(todos.where((todo) => todo.done == true));

  @computed
  bool get hasCompletedTodos => completedTodos.isNotEmpty;

  @computed
  bool get hasPendingTodos => pendingTodos.isNotEmpty;

  @computed
  String get itemsDescription {
    if (todos.isEmpty) {
      return 'Добавьте дела, их сейчас нет в списке';
    }
    return '${pendingTodos.length} ожидают выполнения, ${completedTodos.length} выполнены';
  }

  @computed
  ObservableList<Todo> get visibleTodos {
    switch (filter) {
      case VisibilityFilter.completed:
        return completedTodos;
      case VisibilityFilter.pending:
        return pendingTodos;
      default:
        return todos;
    }
  }

  @computed
  bool get canRemoveAllCompleted =>
      hasCompletedTodos && filter != VisibilityFilter.pending;

  @computed
  bool get canMarkAllAsCompleted =>
      hasPendingTodos && filter != VisibilityFilter.completed;

  @action
  void addTodo(String description) {
    final todo = Todo(description);
    todos.add(todo);
    if (!wasFulfiled) wasFulfiled = true;
  }

  @action
  void removeTodo(Todo todo) {
    todos.removeWhere((element) => element == todo);
  }

  @action
  void changeFilter(VisibilityFilter filter) => this.filter = filter;

  @action
  void removeCompleted() {
    todos.removeWhere((element) => element.done);
  }

  @action
  void markAllAsCompleted() {
    for (final todo in todos) {
      todo.done = true;
    }
  }
}
