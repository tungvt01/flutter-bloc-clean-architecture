import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos/core/error/failures.dart';
import 'package:todos/domain/model/todo_model.dart';
import 'package:todos/domain/usecase/add_new_todo_usecase.dart';
import 'package:todos/presentation/base/index.dart';
import 'package:todos/presentation/page/main/index.dart';

class MockAddNewTotoUseCase extends Mock implements AddNewTotoUseCase {}

main() {
  late MainBloc mainBloc;
  late MockAddNewTotoUseCase usecase;
  final initialState =
      MainState(loadingStatus: LoadingStatus.none, failure: null);
  final addNewTodo = TodoModel(
    id: 0,
    title: 'title',
    description: 'description',
    createdDate: DateTime.now(),
    isFinished: true,
  );

  setUp(() {
    usecase = MockAddNewTotoUseCase();
    mainBloc = MainBloc(usecase);
  });

  blocTest(
    'should emit AddNewTodoSuccessState when new item was added successfully',
    seed: () => initialState,
    setUp: () {
      when(() => usecase.addNewTodo(todoModel: addNewTodo))
          .thenAnswer((_) async {
        return Future.value(const Right(true));
      });
    },
    build: () {
      return mainBloc;
    },
    act: (_) {
      mainBloc.dispatchEvent(OnAddNewTodoEvent(todo: addNewTodo));
    },
    expect: () => [
      initialState.copyWith(loadingStatus: LoadingStatus.loading),
      AddNewTodoSuccessState(todo: addNewTodo),
    ],
    verify: (_) {
      verify(() => usecase.addNewTodo(todoModel: addNewTodo)).called(1);
    },
  );

  final remoteFailure = RemoteFailure(msg: 'remote failure');
  blocTest(
    'should emit failure error',
    seed: () => initialState,
    setUp: () {
      when(() => usecase.addNewTodo(todoModel: addNewTodo))
          .thenAnswer((_) async {
        return Future.value(Left(remoteFailure));
      });
    },
    build: () {
      return mainBloc;
    },
    act: (_) {
      mainBloc.dispatchEvent(OnAddNewTodoEvent(todo: addNewTodo));
    },
    expect: () => [
      initialState.copyWith(loadingStatus: LoadingStatus.loading),
      MainState(failure: remoteFailure, loadingStatus: LoadingStatus.finish),
    ],
    verify: (_) {
      verify(() => usecase.addNewTodo(todoModel: addNewTodo)).called(1);
    },
  );
}
