import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos/domain/model/todo_model.dart';
import 'package:todos/infrastructure/injection.dart';
import 'package:todos/presentation/base/base_state.dart';
import 'package:todos/presentation/page/main/index.dart';
import 'package:todos/presentation/page/main/widget/input_toto_widget.dart';
import 'package:todos/presentation/page/todo_list/index.dart';
import 'package:todos/presentation/page/todo_list/widget/todo_item_widget.dart';
import 'package:todos/presentation/utils/index.dart';

import '../../utils.dart';

class MockMainBloc extends Mock implements MainBloc {}

class MockTodoListBloc extends Mock implements TodoListBloc {}

main() {
  late MockMainBloc mainBloc;
  late MockTodoListBloc todoListBloc;
  final todoMock = TodoModel(
      id: 0, title: "Learning English", description: "Need spend 3 hours for English", createdDate: DateTime.now(), isFinished: false);

  setUpAll(() {
    mainBloc = MockMainBloc();
    todoListBloc = MockTodoListBloc();
  });

  setUp(() async {
    await injector.reset();
    injector.registerFactory<MainBloc>(() => mainBloc);
    injector.registerFactory<TodoListBloc>(() => todoListBloc);
    reset(mainBloc);
    when(() => mainBloc.stream).thenAnswer((_) => BehaviorSubject<MainState>().stream);
    when(() => mainBloc.state).thenAnswer((_) => MainState(loadingStatus: LoadingStatus.finish));
    when(() => mainBloc.close()).thenAnswer((_) => Future<void>.value());
    when(() => todoListBloc.stream).thenAnswer((_) => BehaviorSubject<TodoListState>.seeded(TodoListState(todos: [todoMock])).stream);
    when(() => todoListBloc.state).thenAnswer((_) => TodoListState(todos: [todoMock]));
    when(() => todoListBloc.close()).thenAnswer((_) => Future<void>.value());
  });

  testWidgets('MainPage', (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(generateTestPage(
          page: const MainPage(
        pageTag: PageTag.main,
      )));

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      expect(find.byType(InputTodoWidget), findsOneWidget);
      expect(find.byType(TextFormField), findsExactly(2));
      expect(find.byKey(const Key('save-button-key')), findsExactly(1));

      await tester.enterText(find.byType(TextFormField).first, 'Input new title');
      await tester.enterText(find.byType(TextFormField).last, 'Input new description');

      expect(find.text('Input new title'), findsOneWidget);
      expect(find.text('Input new description'), findsOneWidget);

      final saveButton = find.byKey(const Key('save-button-key'));
      await tester.ensureVisible(saveButton);
      await tester.tap(saveButton, warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.descendant(of: find.byType(TodoListPage), matching: find.byType(TodoItemWidget)), findsExactly(1));
    });
  });
}
