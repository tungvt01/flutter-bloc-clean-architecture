import 'package:dartz/dartz.dart';
import 'package:todos/domain/model/todo_model.dart';
import 'package:todos/domain/usecase/index.dart';
import 'package:todos/presentation/base/index.dart';
import 'package:todos/presentation/page/todo_list/todo_list_state.dart';
import 'package:todos/presentation/utils/index.dart';

import '../../../core/error/failures.dart';
import 'index.dart';

class TodoListBloc extends BaseBloc<BaseEvent, TodoListState> {
  final GetAllTodoUseCase _getAllTodoUseCase;
  final UpdateTodoUseCase _updateTotoUseCase;
  final GetTodoListByConditionUseCase _getTodoListByConditionUseCase;
  TodoListBloc(this._getAllTodoUseCase, this._updateTotoUseCase,
      this._getTodoListByConditionUseCase)
      : super(initState: TodoListState()) {
    on<OnOnFetchingTodoListEvent>((e, m) => _onFetchingTotoHandler(e, m));
    on<OnRequestUpdateTodoEvent>((e, m) => _onUpdateTodoEventHandler(e, m));
  }

  _onFetchingTotoHandler(
      OnOnFetchingTodoListEvent event, Emitter<TodoListState> emitter) async {
    emitter(state.copyWith(loadingStatus: LoadingStatus.loading));
    Either<Failure, List<TodoModel>> result;

    if (event.tag == PageTag.allTodo) {
      result = await _getAllTodoUseCase.getAll();
    } else {
      result = await _getTodoListByConditionUseCase.getTodoListByCondition(
          isFinished: event.tag == PageTag.doneTodo);
    }

    final newState = result.fold<TodoListState>(
        (l) => state.copyWith(failure: l, loadingStatus: LoadingStatus.finish),
        (r) => state.copyWith(loadingStatus: LoadingStatus.finish, todos: r));
    emitter(newState);
  }

  _onUpdateTodoEventHandler(
      OnRequestUpdateTodoEvent event, Emitter<TodoListState> emitter) async {
    emitter(state.copyWith(loadingStatus: LoadingStatus.loading));
    final result = await _updateTotoUseCase.updateTodo(todoModel: event.todo);
    final newState = result.fold<TodoListState>(
        (l) => state.copyWith(failure: l, loadingStatus: LoadingStatus.finish),
        (r) {
      List<TodoModel> todos = state.todos ?? [];
      final index = todos.indexWhere((element) => element.id == event.todo.id);
      if (index >= 0) {
        todos[index] = event.todo;
      }
      return OnUpdateTotoSuccessState(todo: event.todo, todos: todos);
    });
    emitter(newState);
  }

  @override
  void dispose() {}
}
