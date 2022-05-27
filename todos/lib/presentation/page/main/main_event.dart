import 'package:todos/domain/model/todo_model.dart';
import 'package:todos/presentation/base/index.dart';

class OnAddNewTodoEvent extends BaseEvent {
  TodoModel todo;
  OnAddNewTodoEvent({required this.todo});
}

class OnAddNewTodoSuccessEvent extends BaseEvent {
  TodoModel todo;
  OnAddNewTodoSuccessEvent({required this.todo});
}
