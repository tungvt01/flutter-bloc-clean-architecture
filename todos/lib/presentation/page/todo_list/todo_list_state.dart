import 'package:todos/core/error/failures.dart';
import 'package:todos/presentation/base/index.dart';
import '../../../domain/model/todo_model.dart';

class TodoListState extends BaseState {
  List<TodoModel>? todos;
  TodoListState({
    this.todos,
    LoadingStatus? loadingStatus,
    Failure? failure,
  }) : super(
            loadingStatus: loadingStatus ?? LoadingStatus.none,
            failure: failure);

  TodoListState copyWith(
      {List<TodoModel>? todos,
      LoadingStatus? loadingStatus,
      Failure? failure}) {
    return TodoListState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        failure: failure ?? this.failure,
        todos: todos ?? this.todos);
  }
}

class OnUpdateTotoSuccessState extends TodoListState {
  TodoModel todo;
  OnUpdateTotoSuccessState({
    required this.todo,
    List<TodoModel>? todos,
  }) : super(loadingStatus: LoadingStatus.finish, todos: todos);
}
