import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todos/data/local/todo_dao.dart';
import 'package:todos/domain/model/todo_model.dart';
import 'package:todos/domain/usecase/index.dart';
import 'package:todos/presentation/page/todo_list/index.dart';
import 'package:todos/presentation/utils/index.dart';
import '../mock_injector.dart';

void main() async {
  await initMockInjector();
  late TodoListBloc _bloc;
  late TodoDAO _todoDaoImpl;
  late GetAllTodoUseCase _getAllTodoUseCase;
  late GetTodoListByConditionUseCase _getTodoListByConditionUseCase;
  late UpdateTodoUseCase _updateTodoUseCase;

  setUpAll(() {
    _bloc = mockInjector.get<TodoListBloc>();
    _todoDaoImpl = mockInjector.get<TodoDAO>();
    _getAllTodoUseCase = mockInjector.get<GetAllTodoUseCase>();
    _getTodoListByConditionUseCase =
        mockInjector.get<GetTodoListByConditionUseCase>();
    _updateTodoUseCase = mockInjector.get<UpdateTodoUseCase>();
  });
  blocTest(
    'Get All Todo',
    build: () => _bloc,
    act: (bloc) =>
        _bloc..dispatchEvent(OnOnFetchingTodoListEvent(PageTag.allTodo)),
    expect: () => [
      isA<TodoListState>(),
      isA<TodoListState>(),
    ],
  );
  test('Test: get all todo usecase', () async {
    final either = await _getAllTodoUseCase.getAll();
    expect(either.isRight(), true);
    expect(either.getOrElse(() => []).length, 2);
  });

  test('Test: only get finished todo usecase', () async {
    final either = await _getTodoListByConditionUseCase.getTodoListByCondition(
        isFinished: true);
    expect(either.isRight(), true);
    expect(either.getOrElse(() => []).length, 1);
  });

  test('Test: only get Doing todo usecase', () async {
    final either = await _getTodoListByConditionUseCase.getTodoListByCondition(
        isFinished: false);
    expect(either.isRight(), true);
    expect(either.getOrElse(() => []).length, 1);
  });

  test('Test: mark todo as Doing', () async {
    List<TodoModel> todos = await _todoDaoImpl.getAll();
    final updateModel = todos[1];
    expect(updateModel.isFinished, true);
    updateModel.isFinished = false;

    final updateResult =
        await _updateTodoUseCase.updateTodo(todoModel: updateModel);
    expect(updateResult.isRight(), true);

    // refresh list
    todos = await _todoDaoImpl.getAll();

    expect(todos[1].isFinished, false);
  });

  test('Test: mark todo as Done', () async {
    List<TodoModel> todos = await _todoDaoImpl.getAll();
    final updateModel = todos[0];
    expect(updateModel.isFinished, false);
    updateModel.isFinished = true;
    final updateResult =
        await _updateTodoUseCase.updateTodo(todoModel: updateModel);
    expect(updateResult.isRight(), true);

    // refresh list
    todos = await _todoDaoImpl.getAll();

    expect(todos[0].isFinished, true);
  });

  test('Test: Create new todo', () async {
    final newNewdo = TodoModel(
        title: 'Learn Japanese',
        description: "With my teacher at 9:00 AM",
        createdDate: DateTime.now(),
        isFinished: false);
    newNewdo.id = 3;
    final either = await _updateTodoUseCase.updateTodo(todoModel: newNewdo);
    expect(either.isRight(), true);
    // refresh list
    final todos = await _todoDaoImpl.getAll();
    expect(todos.length, 3);
    expect(todos[2].isFinished, false);
  });
}
