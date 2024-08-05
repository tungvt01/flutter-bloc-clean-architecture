import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todos/app_injector.dart';
import 'package:todos/main.dart';
import 'package:todos/presentation/app/index.dart';
import 'package:todos/presentation/base/index.dart';
import 'package:todos/presentation/page/main/widget/input_toto_widget.dart';
import 'package:todos/presentation/page/todo_list/index.dart';
import 'package:todos/presentation/page/todo_list/widget/todo_item_widget.dart';
import 'package:todos/presentation/resources/index.dart';
import 'package:todos/presentation/widgets/index.dart';

main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    appBloc = ApplicationBloc();
    await initInjector();
    await AppLocalizations.shared.reloadLanguageBundle(languageCode: 'en');
  });

  group('Should create/update/delete todo item successfully', () {
    testWidgets('should add toto item', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(BlocProvider<ApplicationBloc>(
          create: (BuildContext context) => appBloc,
          child: const MyApp(),
        ));
        await tester.pump();

        final addTodoButton = find.byType(FloatingActionButton);
        await tester.tap(addTodoButton);
        await tester.pump();
        expect(find.byType(InputTodoWidget), findsOneWidget);

        await tester.enterText(find.byType(TextFormField).first, 'Input new title');
        await tester.enterText(find.byType(TextFormField).last, 'Input new description');
        await tester.tap(find.text('Save'));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(find.descendant(of: find.byType(TodoListPage), matching: find.byType(TodoItemWidget)), findsExactly(1));
        expect(find.text('Input new title'), findsOneWidget);
        expect(find.text('Input new description'), findsOneWidget);

        final markAsDoneButton = find.descendant(of: find.byType(TodoItemWidget), matching:find.byKey(const ValueKey('updateTodoItem')));
        await tester.tap(markAsDoneButton);
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text('Mark this item is "Done" ?'), findsExactly(1));
        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();

        await tester.drag(find.byType(TodoItemWidget), const Offset(-500, 0));
        await tester.pump();
        await tester.tap(find.text('Delete'));
        await tester.pumpAndSettle();
        expect(find.text('Are you sure to delete this note?'), findsExactly(1));
        final deleteMenuItem = find.descendant(of: find.byType(RoundContainer), matching: find.text('Delete'));
        final cancelMenuItem = find.descendant(of: find.byType(RoundContainer), matching: find.text('Cancel'));
        expect(deleteMenuItem, findsExactly(1));
        expect(cancelMenuItem, findsExactly(1));
        await tester.ensureVisible(deleteMenuItem);
        await tester.tap(deleteMenuItem);
        await tester.pumpAndSettle();
        expect(find.descendant(of: find.byType(TodoListPage), matching: find.byType(TodoItemWidget)), findsExactly(0));
      });
    });
  });
}
