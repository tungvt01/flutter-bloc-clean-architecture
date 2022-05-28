import 'package:flutter_test/flutter_test.dart';
import 'package:todos/core/error/exceptions.dart';
import 'package:todos/core/error/failures.dart';
import 'package:todos/domain/model/todo_model.dart';
import 'package:todos/domain/usecase/index.dart';
import '../mock_injector.dart';

void main() async {
  await initMockInjector(runMode: RunMode.failure);
  late GetAllTodoUseCase _getAllTodoUseCase;
  late GetTodoListByConditionUseCase _getTodoListByConditionUseCase;
  late UpdateTodoUseCase _updateTodoUseCase;

  setUpAll(() {
    _getAllTodoUseCase = mockInjector.get<GetAllTodoUseCase>();
    _getTodoListByConditionUseCase =
        mockInjector.get<GetTodoListByConditionUseCase>();
    _updateTodoUseCase = mockInjector.get<UpdateTodoUseCase>();
  });

  test('Test: get all todo usecase', () async {
    final either = await _getAllTodoUseCase.getAll();
    expect(either.isLeft(), true);
    final failure = either.swap().getOrElse(() => throw IOException());
    expect(failure, isA<LocalFailure>());
    expect(failure.errorCode, ioException);
    expect(failure.message, 'error in getting all data');
  });

  test('Test: only get finished todo usecase', () async {
    final either = await _getTodoListByConditionUseCase.getTodoListByCondition(
        isFinished: true);
    expect(either.isLeft(), true);
    final failure = either.swap().getOrElse(() => throw IOException());
    expect(failure, isA<LocalFailure>());
    expect(failure.errorCode, ioException);
    expect(failure.message, 'error in getting todo list by condition');
  });

  test('Test: only get Doing todo usecase', () async {
    final either = await _getTodoListByConditionUseCase.getTodoListByCondition(
        isFinished: false);
    expect(either.isLeft(), true);
    final failure = either.swap().getOrElse(() => throw IOException());
    expect(failure, isA<LocalFailure>());
    expect(failure.errorCode, ioException);
    expect(failure.message, 'error in getting todo list by condition');
  });

  test('Test: mark todo as Doing', () async {
    final either = await _updateTodoUseCase.updateTodo(
        todoModel: TodoModel(
            title: 'mark as doing',
            description: 'update todo ',
            createdDate: DateTime.now(),
            isFinished: false));
    expect(either.isLeft(), true);
    final failure = either.swap().getOrElse(() => throw IOException());
    expect(failure, isA<LocalFailure>());
    expect(failure.errorCode, ioException);
    expect(failure.message, 'error in inserting or updating todo');
  });

  test('Test: mark todo as Done', () async {
    final either = await _updateTodoUseCase.updateTodo(
        todoModel: TodoModel(
            title: 'mark as Done',
            description: 'update toto',
            createdDate: DateTime.now(),
            isFinished: false));
    expect(either.isLeft(), true);
    final failure = either.swap().getOrElse(() => throw IOException());
    expect(failure, isA<LocalFailure>());
    expect(failure.errorCode, ioException);
    expect(failure.message, 'error in inserting or updating todo');
  });

  test('Test: Create new todo', () async {
    final newNewdo = TodoModel(
        title: 'Learn Japanese',
        description: "With my teacher at 9:00 AM",
        createdDate: DateTime.now(),
        isFinished: false);
    newNewdo.id = 3;
    final either = await _updateTodoUseCase.updateTodo(todoModel: newNewdo);
    expect(either.isLeft(), true);
    final failure = either.swap().getOrElse(() => throw IOException());
    expect(failure is LocalFailure, true);
    expect(failure.errorCode, ioException);
    expect(failure.message, 'error in inserting or updating todo');
  });
}
