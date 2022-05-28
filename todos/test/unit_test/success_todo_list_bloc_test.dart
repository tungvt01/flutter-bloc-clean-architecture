import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todos/presentation/page/todo_list/index.dart';
import 'package:todos/presentation/utils/index.dart';
import '../mock_injector.dart';

void main() async {
  await initMockInjector(runMode: RunMode.success);
  blocTest('Get all todo success',
      build: () => mockInjector.get<TodoListBloc>(),
      act: (bloc) => (bloc as TodoListBloc)
          .dispatchEvent(OnOnFetchingTodoListEvent(PageTag.allTodo)),
      expect: () => [
            isA<TodoListState>(),
            isA<TodoListState>(),
          ],
      verify: (b) {
        final bloc = b as TodoListBloc;
        expect(bloc.state.todos!.length, 2);
      });

  blocTest('Get Doing todos',
      build: () => mockInjector.get<TodoListBloc>(),
      act: (bloc) => (bloc as TodoListBloc)
          .dispatchEvent(OnOnFetchingTodoListEvent(PageTag.doingTodo)),
      expect: () => [
            isA<TodoListState>(),
            isA<TodoListState>(),
          ],
      verify: (b) {
        final bloc = b as TodoListBloc;
        expect(bloc.state.todos!.length, 1);
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
        final bloc = b as TodoListBloc;
        expect(bloc.state.todos!.length, 1);
      });
}
