import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todos/core/error/exceptions.dart';
import 'package:todos/presentation/page/todo_list/index.dart';
import 'package:todos/presentation/utils/index.dart';
import '../mock_injector.dart';

void main() async {
  await initMockInjector(runMode: RunMode.failure);

  blocTest('Get all todo failure',
      build: () => mockInjector.get<TodoListBloc>(),
      act: (bloc) => (bloc as TodoListBloc)
          .dispatchEvent(OnOnFetchingTodoListEvent(PageTag.allTodo)),
      expect: () => [
            isA<TodoListState>(),
            isA<TodoListState>(),
          ],
      verify: (b) {
        final _bloc = (b as TodoListBloc);
        expect(_bloc.state.failure!.errorCode!, ioException);
        expect(_bloc.state.failure!.message!, 'error in getting all data');
      });

  blocTest('Get Doing todos',
      build: () => mockInjector.get<TodoListBloc>(),
      act: (bloc) => (bloc as TodoListBloc)
        ..dispatchEvent(OnOnFetchingTodoListEvent(PageTag.doingTodo)),
      expect: () => [
            isA<TodoListState>(),
            isA<TodoListState>(),
          ],
      verify: (b) {
        final _bloc = (b as TodoListBloc);
        expect(_bloc.state.failure!.errorCode!, ioException);
        expect(_bloc.state.failure!.message!,
            'error in getting todo list by condition');
      });

  blocTest('Get Done todos',
      build: () => mockInjector.get<TodoListBloc>(),
      act: (bloc) => (bloc as TodoListBloc)
          .dispatchEvent(OnOnFetchingTodoListEvent(PageTag.doneTodo)),
      expect: () => [
            isA<TodoListState>(),
            isA<TodoListState>(),
          ],
      verify: (b) {
        final _bloc = (b as TodoListBloc);
        expect(_bloc.state.failure!.errorCode!, ioException);
        expect(_bloc.state.failure!.message!,
            'error in getting todo list by condition');
      });
}
