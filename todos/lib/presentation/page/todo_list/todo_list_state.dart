import 'package:equatable/equatable.dart';
import 'package:todos/core/error/failures.dart';
import 'package:todos/presentation/base/index.dart';
import '../../../domain/model/todo_model.dart';

//ignore: must_be_immutable
class TodoListState extends BaseState with EquatableMixin {
  List<TodoModel>? todos;
  TodoListState({
    this.todos,
    LoadingStatus? loadingStatus,
    super.failure,
  }) : super(
          loadingStatus: loadingStatus ?? LoadingStatus.none,
        );

  TodoListState copyWith({
    List<TodoModel>? todos,
    LoadingStatus? loadingStatus,
    Failure? failure,
  }) {
    return TodoListState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      failure: failure ?? this.failure,
      todos: todos ?? this.todos,
    );
  }

  @override
  List<Object?> get props => [todos, loadingStatus, failure];
}

//ignore: must_be_immutable
class OnUpdateTotoSuccessState extends TodoListState {
  TodoModel todo;
  OnUpdateTotoSuccessState({
    required this.todo,
    super.todos,
  }) : super(loadingStatus: LoadingStatus.finish);
}
