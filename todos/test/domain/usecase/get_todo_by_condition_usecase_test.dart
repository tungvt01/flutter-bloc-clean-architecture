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
  late GetTodoListByConditionUseCase updateTodoUseCase;
  const condition = false;

  setUp(() {
    todoRepository = MockTodoRepository();
    updateTodoUseCase = GetTodoListByConditionUseCaseImpl(todoRepository);
  });

  tearDown(() {
    reset(todoRepository);
  });

  test('Should get todos by condition successfully', () async {
    List<TodoModel> response = List.generate(
        5, (int index) => TodoModel(id: index, title: 'title', description: 'description', createdDate: DateTime.now(), isFinished: true));
    when(todoRepository.getTodoListByCondition(isFinished: condition)).thenAnswer((_) => Future<List<TodoModel>>.value(response));

    final result = await updateTodoUseCase.getTodoListByCondition(isFinished: condition);

    verify(todoRepository.getTodoListByCondition(isFinished: condition)).called(1);
    expect(result, isRight);
    expect(result.getRightOrFailTest(), response);

    verifyNoMoreInteractions(todoRepository);
  });

  test(
      'Should get todos by condition'
      ' unsuccessful', () async {
    final exception = RemoteException(errorMessage: 'error message');
    when(todoRepository.getTodoListByCondition(isFinished: condition)).thenThrow(exception);

    final result = await updateTodoUseCase.getTodoListByCondition(isFinished: condition);

    verify(todoRepository.getTodoListByCondition(isFinished: condition)).called(1);
    expect(result, isLeft);
    expect(result.getLeftOrFailTest(), isInstanceOf<RemoteFailure>());
    expect(result.getLeftOrFailTest().message, exception.errorMessage);

    verifyNoMoreInteractions(todoRepository);
  });
}
