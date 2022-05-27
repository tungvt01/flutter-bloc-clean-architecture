import 'package:todos/core/error/failures.dart';
import 'package:todos/domain/model/todo_model.dart';
import 'package:todos/presentation/base/index.dart';

class MainState extends BaseState {
  MainState({
    LoadingStatus? loadingStatus,
    Failure? failure,
  }) : super(
            loadingStatus: loadingStatus ?? LoadingStatus.none,
            failure: failure);

  MainState copyWith({LoadingStatus? loadingStatus, Failure? failure}) {
    return MainState(loadingStatus: loadingStatus, failure: failure);
  }
}

class AddNewTodoSuccessState extends MainState {
  TodoModel todo;
  AddNewTodoSuccessState({required this.todo})
      : super(
          loadingStatus: LoadingStatus.finish,
        );
}
