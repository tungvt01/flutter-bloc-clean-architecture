import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos/core/error/failures.dart';
import 'package:todos/domain/model/todo_model.dart';
import 'package:todos/domain/usecase/index.dart';
import 'package:todos/presentation/base/base_state.dart';
import 'package:todos/presentation/page/todo_list/index.dart';
import 'package:todos/presentation/utils/index.dart';

class MockGetAllTodoUseCase extends Mock implements GetAllTodoUseCase {}

class MockUpdateTodoUseCase extends Mock implements UpdateTodoUseCase {}

class MockGetTodoListByConditionUseCase extends Mock
    implements GetTodoListByConditionUseCase {}

class MockRemoveTodoUseCase extends Mock implements RemoveTodoUseCase {}

main() {
  late TodoListBloc todoListBloc;
  late MockGetAllTodoUseCase getAllTodoUseCase;
  late MockUpdateTodoUseCase updateTodoUseCase;
  late MockGetTodoListByConditionUseCase getTodoListByConditionUseCase;
  late MockRemoveTodoUseCase removeTodoUseCase;
  final initialState =
      TodoListState(loadingStatus: LoadingStatus.finish, todos: []);
  final todoMock = TodoModel(
    id: 0,
    title: 'Learning English',
    description: 'Need spend 3 hours for English',
    createdDate: DateTime.now(),
    isFinished: false,
  );

  setUp(() {
    getAllTodoUseCase = MockGetAllTodoUseCase();
    updateTodoUseCase = MockUpdateTodoUseCase();
    getTodoListByConditionUseCase = MockGetTodoListByConditionUseCase();
    removeTodoUseCase = MockRemoveTodoUseCase();
    todoListBloc = TodoListBloc(
      getAllTodoUseCase,
      updateTodoUseCase,
      getTodoListByConditionUseCase,
      removeTodoUseCase,
    );
  });

  group('_onFetchingTotoHandler', () {
    blocTest(
      'should fetch all todo item',
      build: () {
        return todoListBloc;
      },
      seed: () => initialState,
      setUp: () {
        when(() => getAllTodoUseCase.getAll()).thenAnswer((_) async {
          return Future.value(Right([todoMock]));
        });
      },
      act: (_) {
        todoListBloc.dispatchEvent(OnOnFetchingTodoListEvent(PageTag.allTodo));
      },
      expect: () => [
        initialState.copyWith(loadingStatus: LoadingStatus.loading),
        initialState
            .copyWith(loadingStatus: LoadingStatus.finish, todos: [todoMock]),
      ],
      verify: (_) {
        verify(() => getAllTodoUseCase.getAll()).called(1);
        verifyNever(
          () => getTodoListByConditionUseCase.getTodoListByCondition(
            isFinished: false,
          ),
        );
        verifyNever(
          () => getTodoListByConditionUseCase.getTodoListByCondition(
            isFinished: true,
          ),
        );
      },
    );

    blocTest(
      'should fetch todo items by condition',
      build: () {
        return todoListBloc;
      },
      seed: () => initialState,
      setUp: () {
        when(
          () => getTodoListByConditionUseCase.getTodoListByCondition(
            isFinished: false,
          ),
        ).thenAnswer((_) async {
          return Future.value(Right([todoMock]));
        });
      },
      act: (_) {
        todoListBloc
            .dispatchEvent(OnOnFetchingTodoListEvent(PageTag.doingTodo));
      },
      expect: () => [
        initialState.copyWith(loadingStatus: LoadingStatus.loading),
        initialState
            .copyWith(loadingStatus: LoadingStatus.finish, todos: [todoMock]),
      ],
      verify: (_) {
        verify(
          () => getTodoListByConditionUseCase.getTodoListByCondition(
            isFinished: false,
          ),
        ).called(1);
        verifyNever(
          () => getTodoListByConditionUseCase.getTodoListByCondition(
            isFinished: true,
          ),
        );
        verifyNever(() => getAllTodoUseCase.getAll());
      },
    );

    final remoteFailure = RemoteFailure(msg: 'remote failure');
    blocTest(
      'should emit error',
      build: () {
        return todoListBloc;
      },
      seed: () => initialState,
      setUp: () {
        when(
          () => getTodoListByConditionUseCase.getTodoListByCondition(
            isFinished: false,
          ),
        ).thenAnswer((_) async {
          return Future.value(Left(remoteFailure));
        });
      },
      act: (_) {
        todoListBloc
            .dispatchEvent(OnOnFetchingTodoListEvent(PageTag.doingTodo));
      },
      expect: () => [
        initialState.copyWith(loadingStatus: LoadingStatus.loading),
        initialState.copyWith(
          loadingStatus: LoadingStatus.finish,
          failure: remoteFailure,
        ),
      ],
      verify: (_) {
        verify(
          () => getTodoListByConditionUseCase.getTodoListByCondition(
            isFinished: false,
          ),
        ).called(1);
      },
    );
  });

  final updatedTodoMock = TodoModel(
    id: 0,
    title: 'Learning English',
    description: 'Need spend 3 hours for English',
    createdDate: DateTime.now(),
    isFinished: false,
  );
  group('_onUpdateTodoEventHandler', () {
    blocTest(
      'should update todo item',
      build: () {
        return todoListBloc;
      },
      seed: () => initialState.copyWith(todos: [updatedTodoMock]),
      setUp: () {
        when(() => updateTodoUseCase.updateTodo(todoModel: updatedTodoMock))
            .thenAnswer((_) async {
          return Future.value(const Right(true));
        });
      },
      act: (_) {
        todoListBloc
            .dispatchEvent(OnRequestUpdateTodoEvent(todo: updatedTodoMock));
      },
      expect: () => [
        initialState.copyWith(
          todos: [updatedTodoMock],
          loadingStatus: LoadingStatus.loading,
        ),
        OnUpdateTotoSuccessState(
          todo: updatedTodoMock,
          todos: [updatedTodoMock],
        ),
      ],
      verify: (_) {
        verify(() => updateTodoUseCase.updateTodo(todoModel: updatedTodoMock))
            .called(1);
      },
    );
  });

  final deletingTodo = TodoModel(
    id: 0,
    title: 'Learning English',
    description: 'Need spend 3 hours for English',
    createdDate: DateTime.now(),
    isFinished: false,
  );
  group('_onDeleteTotoEventHandler', () {
    blocTest(
      'should delete todo item',
      build: () {
        return todoListBloc;
      },
      seed: () => initialState.copyWith(todos: [deletingTodo]),
      setUp: () {
        when(() => removeTodoUseCase.removeTodo(todoModel: deletingTodo))
            .thenAnswer((_) async {
          return Future.value(const Right(true));
        });
      },
      act: (_) {
        todoListBloc
            .dispatchEvent(OnRequestDeleteTodoEvent(todo: deletingTodo));
      },
      expect: () => [
        initialState.copyWith(
          todos: [deletingTodo],
          loadingStatus: LoadingStatus.loading,
        ),
        initialState.copyWith(todos: [], loadingStatus: LoadingStatus.finish),
      ],
      verify: (_) {
        verify(() => removeTodoUseCase.removeTodo(todoModel: deletingTodo))
            .called(1);
      },
    );
  });
}
