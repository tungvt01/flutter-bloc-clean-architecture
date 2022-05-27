import 'package:todos/domain/model/todo_model.dart';
import 'package:todos/presentation/base/index.dart';
import 'package:todos/presentation/utils/index.dart';

class OnOnFetchingTodoListEvent extends BaseEvent {
  PageTag tag;
  OnOnFetchingTodoListEvent(this.tag);
}

class OnRequestUpdateTodoEvent extends BaseEvent {
  TodoModel todo;
  OnRequestUpdateTodoEvent({required this.todo});
}

class UpdateTotoSuccessEvent extends BaseEvent {
  TodoModel todo;
  UpdateTotoSuccessEvent({required this.todo});
}
