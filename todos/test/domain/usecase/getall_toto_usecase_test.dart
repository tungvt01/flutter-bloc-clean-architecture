import 'package:dartz_test/dartz_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todos/core/error/exceptions.dart';
import 'package:todos/core/error/failures.dart';
import 'package:todos/domain/model/todo_model.dart';
import 'package:todos/domain/usecase/index.dart';

import 'usecase_mock.mocks.dart';

void main() async {
  late MockTodoRepository todoRepository;
  late GetAllTodoUseCase updateTodoUseCase;

  setUp(() {
    todoRepository = MockTodoRepository();
    updateTodoUseCase = GetAllTodoUseCaseImpl(todoRepository);
  });

  tearDown(() {
    reset(todoRepository);
  });

  test('Should delete todo successfully', () async {
    List<TodoModel> response = List.generate(
        5, (int index) => TodoModel(id: index, title: 'title', description: 'description', createdDate: DateTime.now(), isFinished: true));
    when(todoRepository.getAll()).thenAnswer((_) => Future<List<TodoModel>>.value(response));

    final result = await updateTodoUseCase.getAll();

    verify(todoRepository.getAll()).called(1);
    expect(result, isRight);
    expect(result.getRightOrFailTest(), response);

    verifyNoMoreInteractions(todoRepository);
  });

  test('Should delete todo unsuccessful', () async {
    final exception = RemoteException(errorMessage: 'error message');
    when(todoRepository.getAll()).thenThrow(exception);

    final result = await updateTodoUseCase.getAll();

    verify(todoRepository.getAll());
    expect(result, isLeft);
    expect(result.getLeftOrFailTest(), isInstanceOf<RemoteFailure>());
    expect(result.getLeftOrFailTest().message, exception.errorMessage);

    verifyNoMoreInteractions(todoRepository);
  });
}
