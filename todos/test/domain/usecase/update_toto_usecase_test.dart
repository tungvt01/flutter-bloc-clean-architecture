import 'package:dartz_test/dartz_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todos/core/error/exceptions.dart';
import 'package:todos/core/error/failures.dart';
import 'package:todos/domain/model/todo_model.dart';
import 'package:todos/domain/usecase/update_todo_usecase.dart';

import 'usecase_mock.mocks.dart';

void main() async {
  late MockTodoRepository todoRepository;
  late UpdateTodoUseCase updateTodoUseCase;

  setUp(() {
    todoRepository = MockTodoRepository();
    updateTodoUseCase = UpdateTodoUseCaseImpl(todoRepository);
  });

  tearDown(() {
    reset(todoRepository);
  });

  var updatingToto = TodoModel(
    id: 0,
    title: 'title',
    description: 'description',
    createdDate: DateTime.now(),
    isFinished: true,
  );

  test('Should update todo successfully', () async {
    const success = true;
    when(todoRepository.updateTodo(todo: updatingToto)).thenAnswer((_) => Future<bool>.value(success));

    final result = await updateTodoUseCase.updateTodo(todoModel: updatingToto);

    verify(todoRepository.updateTodo(todo: updatingToto));
    expect(result, isRight);
    expect(result.getRightOrFailTest(), success);

    verifyNoMoreInteractions(todoRepository);
  });

  test('Should failed when update todo', () async {
    final exception = RemoteException(errorMessage: 'error message');
    when(todoRepository.updateTodo(todo: updatingToto)).thenThrow(exception);

    final result = await updateTodoUseCase.updateTodo(todoModel: updatingToto);

    verify(todoRepository.updateTodo(todo: updatingToto));
    expect(result, isLeft);
    expect(result.getLeftOrFailTest(), isInstanceOf<RemoteFailure>());
    expect(result.getLeftOrFailTest().message, exception.errorMessage);

    verifyNoMoreInteractions(todoRepository);
  });
}
