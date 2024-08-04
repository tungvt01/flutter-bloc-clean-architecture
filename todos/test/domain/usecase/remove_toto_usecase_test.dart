import 'package:dartz_test/dartz_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todos/core/error/exceptions.dart';
import 'package:todos/core/error/failures.dart';
import 'package:todos/domain/model/todo_model.dart';
import 'package:todos/domain/usecase/remove_todo_usecase.dart';

import 'usecase_mock.mocks.dart';

void main() async {
  late MockTodoRepository todoRepository;
  late RemoveTodoUseCase updateTodoUseCase;

  setUp(() {
    todoRepository = MockTodoRepository();
    updateTodoUseCase = RemoveTodoUseCaseImpl(todoRepository);
  });

  tearDown(() {
    reset(todoRepository);
  });

  var deletingTodo = TodoModel(
    id: 0,
    title: 'deleting Todo title',
    description: 'description',
    createdDate: DateTime.now(),
    isFinished: true,
  );

  test('Should delete todo successfully', () async {
    const success = true;
    when(todoRepository.remove(id: deletingTodo.id)).thenAnswer((_) => Future<bool>.value(success));

    final result = await updateTodoUseCase.removeTodo(todoModel: deletingTodo);

    verify(todoRepository.remove(id: deletingTodo.id)).called(1);
    expect(result, isRight);
    expect(result.getRightOrFailTest(), success);

    verifyNoMoreInteractions(todoRepository);
  });

  test('Should delete todo unsuccessful', () async {
    final exception = RemoteException(errorMessage: 'error message');
    when(todoRepository.remove(id: deletingTodo.id)).thenThrow(exception);

    final result = await updateTodoUseCase.removeTodo(todoModel: deletingTodo);

    verify(todoRepository.remove(id: deletingTodo.id));
    expect(result, isLeft);
    expect(result.getLeftOrFailTest(), isInstanceOf<RemoteFailure>());
    expect(result.getLeftOrFailTest().message, exception.errorMessage);

    verifyNoMoreInteractions(todoRepository);
  });
}
