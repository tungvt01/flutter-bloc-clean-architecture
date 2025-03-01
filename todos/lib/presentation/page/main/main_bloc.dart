import 'package:injectable/injectable.dart';
import 'package:todos/domain/usecase/add_new_todo_usecase.dart';
import 'package:todos/presentation/base/index.dart';
import 'package:todos/presentation/page/main/index.dart';

@Injectable(env: [Environment.prod, Environment.dev])
class MainBloc extends BaseBloc<BaseEvent, MainState> {
  final AddNewTotoUseCase _addNewTotoUseCase;
  MainBloc(this._addNewTotoUseCase) : super(initState: MainState()) {
    on<OnAddNewTodoEvent>((e, m) => _onAddNewTodoHandler(e, m));
  }

  _onAddNewTodoHandler(
      OnAddNewTodoEvent event, Emitter<MainState> emitter) async {
    emitter(state.copyWith(loadingStatus: LoadingStatus.loading));
    final result = await _addNewTotoUseCase.addNewTodo(todoModel: event.todo);

    final newState = result.fold<MainState>(
        (l) => state.copyWith(failure: l, loadingStatus: LoadingStatus.finish),
        (r) => AddNewTodoSuccessState(todo: event.todo));
    emitter(newState);
  }

  @override
  void dispose() {}
}
