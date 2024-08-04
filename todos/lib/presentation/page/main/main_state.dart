import 'package:equatable/equatable.dart';
import 'package:todos/core/error/failures.dart';
import 'package:todos/domain/model/todo_model.dart';
import 'package:todos/presentation/base/index.dart';

class MainState extends BaseState with EquatableMixin {
  MainState({
    LoadingStatus? loadingStatus,
    super.failure,
  }) : super(loadingStatus: loadingStatus ?? LoadingStatus.none);

  MainState copyWith({LoadingStatus? loadingStatus, Failure? failure}) {
    return MainState(loadingStatus: loadingStatus, failure: failure);
  }

  @override
  List<Object?> get props => [loadingStatus, failure];
}

class AddNewTodoSuccessState extends MainState {
  TodoModel todo;

  AddNewTodoSuccessState({required this.todo})
      : super(
          loadingStatus: LoadingStatus.finish,
        );

  @override
  List<Object?> get props => [loadingStatus, failure, todo];
}
