import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos/domain/model/todo_model.dart';
import 'package:todos/infrastructure/injection.dart';
import 'package:todos/presentation/base/index.dart';
import 'package:todos/presentation/page/main/index.dart';
import 'package:todos/presentation/page/todo_list/index.dart';
import 'package:todos/presentation/page/todo_list/widget/todo_item_widget.dart';
import 'package:todos/presentation/utils/index.dart';
import 'package:todos/presentation/widgets/index.dart';

import '../../utils.dart';

class MockMainBloc extends Mock implements MainBloc {}

class MockTodoListBloc extends Mock implements TodoListBloc {}

main() {
  late MockTodoListBloc todoListBloc;
  late MockMainBloc mainBloc;

  final todoMock = TodoModel(
    id: 0,
    title: 'Learning English',
    description: 'Need spend 3 hours for English',
    createdDate: DateTime.now(),
    isFinished: false,
  );

  setUpAll(() {
    mainBloc = MockMainBloc();
    todoListBloc = MockTodoListBloc();
  });

  setUp(() async {
    await injector.reset();
    injector.registerFactory<MainBloc>(() => mainBloc);
    injector.registerFactory<TodoListBloc>(() => todoListBloc);
    reset(mainBloc);
    when(() => mainBloc.stream)
        .thenAnswer((_) => BehaviorSubject<MainState>().stream);
    when(() => mainBloc.state)
        .thenAnswer((_) => MainState(loadingStatus: LoadingStatus.finish));
    when(() => mainBloc.close()).thenAnswer((_) => Future<void>.value());
    when(() => todoListBloc.stream).thenAnswer(
      (_) => BehaviorSubject<TodoListState>.seeded(
        TodoListState(todos: [todoMock]),
      ).stream,
    );
    when(() => todoListBloc.state)
        .thenAnswer((_) => TodoListState(todos: [todoMock]));
    when(() => todoListBloc.close()).thenAnswer((_) => Future<void>.value());
  });

  testWidgets('TodoListPage', (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        generateTestPage(
          page: const MainPage(
            pageTag: PageTag.main,
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(TodoItemWidget), findsExactly(1));

      final checkbox = find.descendant(
        of: find.byType(TodoItemWidget),
        matching: find.byKey(const ValueKey('updateTodoItem')),
      );
      await tester.ensureVisible(checkbox);
      await tester.dragUntilVisible(
        checkbox,
        find.byType(SingleChildScrollView),
        const Offset(0, 50),
      );
      await tester.pumpAndSettle();
      expect(checkbox, findsAtLeast(1));
      await tester.tap(checkbox);
      await tester.pumpAndSettle();

      expect(find.text('Mark this item is "Done" ?'), findsExactly(1));
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      expect(find.byType(TodoItemWidget), findsExactly(1));

      await tester.drag(find.byType(TodoItemWidget), const Offset(-500, 0));
      await tester.pump();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      expect(find.text('Are you sure to delete this note?'), findsExactly(1));
      final deleteMenuItem = find.descendant(
        of: find.byType(RoundContainer),
        matching: find.text('Delete'),
      );
      final cancelMenuItem = find.descendant(
        of: find.byType(RoundContainer),
        matching: find.text('Cancel'),
      );
      expect(deleteMenuItem, findsExactly(1));
      expect(cancelMenuItem, findsExactly(1));
      await tester.ensureVisible(deleteMenuItem);
      await tester.tap(deleteMenuItem);
      await tester.pumpAndSettle();
    });
  });
}
